Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AED3C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3L-0005VS-LU; Fri, 04 Sep 2026 15:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3K-0005VI-HF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3J-0007pU-27
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRnXKZYrzbjyn4A8hYpuDdRC4OzW1AM3O5ymYNZ3gBk=;
 b=iYmyrdFWCyjCP7luEU79VK+iNrF1rB5fBYeLr+FoF6KafV4wadTRhQFFmGxURvrz0FSVMO
 QgwQIlIhkEnGjJs0mAyPpB9KhI/qd8gsHi7oI+0kOs9ifh46Q0q7Xg+JDlWDdKV/RWhkqn
 oNs5CzhiNKSDIZxA5ZPN93d+B4DRqDg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-7EEBlolUPNioKHHealAeGQ-1; Fri,
 04 Sep 2026 15:58:17 -0400
X-MC-Unique: 7EEBlolUPNioKHHealAeGQ-1
X-Mimecast-MFC-AGG-ID: 7EEBlolUPNioKHHealAeGQ_1788551896
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A0311888F01; Fri,  4 Sep 2026 19:58:16 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC1441800642; Fri,  4 Sep 2026 19:58:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:45 +0400
Subject: [PATCH v4 02/75] qapi/gen: fix _module_basename for multi-dash
 'what' parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-2-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8qQ5+NhKhFTbUvRZ8NDUWUg42L5+gNHRkxrEPEB9zC8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLIf+XjanGQ7KLk3Tr1HQrk1sfy48u6jtUKR
 eZX6Huc/6WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyAAKCRDa6OEJdZac
 5SPEEACCIFtd2bfjXgFWJM/8ArvL1dElVcXTWhBt6xVBheyOmEwLJmQJMcr6RcosQcrWU2Elq6J
 8pNpBtG/BMPFQyKWpXgver+F8ksJlGl7FRK0lbX4mtQcAr/cXvOEqXMOG2oG9p20/fVK5ry549E
 ZeFnETWvrARhKDL5Pp6RZKjR2V9ahPXZokPhx7xKigRcJO4RWGxSNQRSP7ZGiSBRPc2GinUvVtb
 5f34H4o6/4783hvG+w3lukSdBiBKjyULi6sezj0ly8H6X+ZLL1yS3/yVUG7WOfKyUbG7j/lxgQ1
 CTYV30DI0kHW6zzWT9w/7zXSsX02BYglAXzQ0tXIjlhob91vrOtMEZhhQ1aFxsJoAYvKOWyZZVa
 QsKQvRB0E2E6X8TUTSBURvBK+KOugCKVKY6digd8WmSFeuSTh1QkCCPmuVozctLlIPHAN7oI9qf
 rkEjOadfEIHtQrrVl2TvixF3zToy7LNfnLjk9YSO4isP4aCrtWqb4GBzlBP1bTa58YMWo7l0C09
 6HtHfMNQm+tWcLA7XH5nCy96CroOqeLcJkbDArt689sYLw7cpLJezG0GJ1MboXf1RTS1259yM1o
 QZobpNmTNbwf+LW++dzfdg8kzIIW+4XayJIs32tH9VMXcLIO2CY7OOHI5niHpJS8yicCjR1hKJw
 gqDwuNHtksWNx3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The re.sub() call replaces every hyphen in 'what' with the system module
infix. This produces broken filenames for multi-hyphen names (e.g.
'qapi-type-infos' becomes 'qapi-builtin-type-builtin-infos').

Add count=1 so only the first hyphen is replaced.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/gen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 0c9b8db3b024..690187d4280d 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -300,7 +300,7 @@ def _module_basename(self, what: str, name: str) -> str:
                 ret += '-' + os.path.splitext(basename)[0]
         else:
             assert QAPISchemaModule.is_system_module(name)
-            ret += re.sub(r'-', '-' + name[2:] + '-', what)
+            ret += re.sub(r'-', '-' + name[2:] + '-', what, count=1)
         return ret
 
     def _module_filename(self, what: str, name: str) -> str:

-- 
2.55.0.543.g5ebe2ebe4ea8


