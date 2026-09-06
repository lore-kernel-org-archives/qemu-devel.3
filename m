Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78EEC79F9E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38dc-0002Eo-Sy; Sun, 06 Sep 2026 04:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38db-0002DU-Do
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dZ-0000kh-SK
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGP6x3h6YYJwclrpDRPnifXfRsYBwd4ztRbxKciLjog=;
 b=c3vKIhHCNjJLJYiF0eKIKU1tWcvFrpI8CAB9rSJ1m8SyHnWJYA+luyZKfrMtvzGFOXjs3g
 pi7MUcMHehSef5LrQirvYrWBtOZNWlbZmlpiwuQ8806jPB2oFaWgNKNfQ2VZdlTgCqODhD
 W/mczoQPlDsSxtQOaf/EQAc+vkwYr0k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-757ye2BWNxKPaMNEbZrdhg-1; Sun,
 06 Sep 2026 04:54:00 -0400
X-MC-Unique: 757ye2BWNxKPaMNEbZrdhg-1
X-Mimecast-MFC-AGG-ID: 757ye2BWNxKPaMNEbZrdhg_1788684838
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CB1F18052FC; Sun,  6 Sep 2026 08:53:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EF341956042; Sun,  6 Sep 2026 08:53:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:53:34 +0400
Subject: [PATCH 2/9] tests/test_vhost_user_bridge: skip when running ASAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=d3v8wDpl6ZpnpLjDUpJFM+2TuIyDJb7L4WPUBwqWyqM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoY9/k9w5PImLk+LNUNu1WVYh96sp1l3/KU6
 UkrsdNS3xiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGAAKCRDa6OEJdZac
 5cjSD/9NiuPcABUIDCCnz8FfEvP7DWl5GvKODFUcbf58XQyPSXcDzyorEcg5bBSuZtMEQgfk+0E
 jQfihJfjG2z34XFLotlvXZw2jY+35pZWlNsk423YkdEaZA5xCaZ84X1UcsaUKY4pFwGEWfWXj4i
 dLe5SGg2b/LsmpXHk6KsG9ACX1ZTiILC+byTaKWn/MGux5+P+ZNe0x5ozKf82lKnwHVWO1HeBcw
 +6GvU2peDFqv7YdEa04eBaYVELxycZOjUVHD+iHjaa3i9L2H6KxqzgygfNARfyq5zIzFDQqcHwp
 51RpbnOig+2Cp/dtC5KohddckgCzwIhHIjka6BkSAfZ5E5wZVKAYI3OEOwe8NsVEVvWGh6aD1vZ
 xziNm/6US+LE/APpUBOtNT0sIKvdcnBnbaDYaBgFyDsIz4vjU6O3qkAWT88BvSon0UWnlaIj3Ls
 NGi4L9vsLbnjnzj+zy7TV4U+0uYICmVsnLIKMjEsLMsAIR217GCGW7mkJWEsEA1U4UT9L/e/wgc
 +PMiErYHQOm/OTIAB4AmoPfN2YzO5cuYHm8a7yBfS02NpSrB7EmiWFS7eu/0+TCXzhCSP/ZenPT
 EYJIwx2ZYNUlfusg/Rw4CM8wNrKSrFe2kUJavmgjZOPhabm1Zj+6Zt5do7fySH2kV0S4WtMKS95
 kYqH0G9J9qElkDQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Running vhost-user-bridge built with ASAN with stdbuf dies:
==2431898==ASan runtime does not come first in initial library list; you
should either link runtime to your application or manually preload it
with LD_PRELOAD.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/x86_64/test_vhost_user_bridge.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
index c36c62542053..5fedf61c5e72 100755
--- a/tests/functional/x86_64/test_vhost_user_bridge.py
+++ b/tests/functional/x86_64/test_vhost_user_bridge.py
@@ -73,12 +73,25 @@ def configure_vm(self, ud_socket_path, lport, rport, hostfwd_port, tftpdir):
             "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
         )
 
+    @staticmethod
+    def _is_asan_linked(binary_path):
+        try:
+            output = subprocess.check_output(
+                ["ldd", binary_path], stderr=subprocess.DEVNULL, text=True)
+            return "libasan" in output
+        except (subprocess.CalledProcessError, FileNotFoundError):
+            return False
+
     def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
         vubr_args = []
 
         if (stdbuf_path := which("stdbuf")) is None:
             self.log.info("Could not find stdbuf: vhost-user-bridge "
                           "log lines may appear out of order")
+        elif self._is_asan_linked(vubr_path):
+            self.log.info("vhost-user-bridge is ASan-linked: skipping "
+                          "stdbuf to avoid LD_PRELOAD conflict, "
+                          "log lines may appear out of order")
         else:
             vubr_args += [stdbuf_path, "-o0", "-e0"]
 

-- 
2.55.0.543.g5ebe2ebe4ea8


