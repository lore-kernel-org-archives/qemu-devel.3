Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71278CD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4W-0002xV-MD; Mon, 15 Jun 2026 16:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4S-0002th-I2
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE4R-0002Dv-0t
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFVw19IYcg8Vi68AQsWHVfWaq1NgmtwviDz8DJlU8Ec=;
 b=Z3/D6aMtkYBEPMQTvB6VfK/MhQduHMzhM2vPhPR/+5qDS4g1HT+cwANDuFfd40I//tX+NV
 OHMUnE/2yRBtLlXbFWPmTDAB/xPO4mTHSp4V8KLGa5w3I51BkrDCr7TrRVCQtqi7vEwF4c
 RvNIQbqP6NpLkzCB+P3Han/XsfJY8ZA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-gv-xwEjHP3aIAIMK4j4zTw-1; Mon,
 15 Jun 2026 16:38:06 -0400
X-MC-Unique: gv-xwEjHP3aIAIMK4j4zTw-1
X-Mimecast-MFC-AGG-ID: gv-xwEjHP3aIAIMK4j4zTw_1781555885
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CE011800350; Mon, 15 Jun 2026 20:38:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7ED15414; Mon, 15 Jun 2026 20:38:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:30 +0400
Subject: [PATCH v2 04/53] qapi/backend: wire up type-infos generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-4-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uvjz2W2mHnyexv8i2EcHpZHrtNOIG6lMcGZHXJTUUWQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKNFn83iRGjfo38dm5SFIum1NFCosaZRr+Mo
 m7223BzD+mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijQAKCRDa6OEJdZac
 5Z6ED/907h9wvPND8kuDseWhCRUHyd8x5vtHtWFAbUl/xs6yj94vg8exq6GbxB/x+tzX8ldEY8Q
 e31YsuddgPfh7IhAV77e3crtsoyzayku0Bxaqc1SpswGwXrDKhKr+YHMQtHv0Q6h2ZhM6mXW53c
 oTD+/jRcv8/C+Ul72laFwccZUUxzYGYCv7m9krZH9Qnjbr6s64W0ENbBIv88eXVGgDULxQWv7a2
 buBGm79L+R33HLaPkRSWBv6b4HrSe+nY14LNCqYg5fkkog0fSp4cth4C8F8mlc80ohKHeJhY/OX
 G0JbLblbY9BZiGHbd5TC8nUAWW6nlv7MWhlrOOzQB0TmI8kXF9IyxrCGPDfFEZ3dS7+M6uvyBLM
 fIFZjRUDBmuHDu9D3ddqemzpOzUvok7sw00Qbu2TUKXUGYBhbxdrw0oLCXe5DGLXExN/bLQ+5WY
 qVyFI0o8kLU8iL7Rkwr4BQkaLABCYGrr/RmyEKNAUMZFnQOG3Cwvs/PUMvX80h3QUznCI7eO/Em
 cuUmDg6Gx3Wj5VjV9y/dBJU8BcPYESeb8TisgF+CqOGRE9evDLT9aj0Dw8ABWuUL2XDbsy2SB89
 d/2csuUw5+gx7cC+l8LjDH7Ktim6b1ULPm/h8zQibZmzClpBns/sw4tuKiHeNx+7l1whPMABwHz
 TUftp12SoML2syw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Call gen_type_infos() after gen_introspect(), passing the name map so
type-info constants get the correct masked names.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/backend.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 49ae6ecdd33..353f7801149 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -8,6 +8,7 @@
 from .features import gen_features
 from .introspect import gen_introspect
 from .schema import QAPISchema
+from .type_infos import gen_type_infos
 from .types import gen_types
 from .visit import gen_visit
 
@@ -62,4 +63,5 @@ def generate(self,
         gen_visit(schema, output_dir, prefix, builtins)
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
-        gen_introspect(schema, output_dir, prefix, unmask)
+        name_map = gen_introspect(schema, output_dir, prefix, unmask)
+        gen_type_infos(schema, output_dir, prefix, builtins, name_map)

-- 
2.54.0


