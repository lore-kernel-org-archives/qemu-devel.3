Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB0AC35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuAj-0002Jz-TE; Wed, 19 Mar 2025 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuuAA-0001hT-1s
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:12:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tuuA2-0006kC-Vi
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742393536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sv7AbRgC/+1LXd3g9+YAfe5gSusJCdICJ4LNnmNXd2E=;
 b=fJk0RPkZgb7/3i3QKGrxZOTArscJ3xDMxIZ3oeq23idMXboagJXU7T7LVxNuUmf8KaXHbM
 0eWF3g1Hip0kpQjjuZBcI8s1gMbVCtwN5heEGIJWem9bLQZIueXQDqy/mJa+iXILHulQ6H
 rO2mK3kb2O/ukww5YDf4s8IEJleP+ns=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-6g5hZF5QNYa_Xli8xO3Dhw-1; Wed,
 19 Mar 2025 10:12:12 -0400
X-MC-Unique: 6g5hZF5QNYa_Xli8xO3Dhw-1
X-Mimecast-MFC-AGG-ID: 6g5hZF5QNYa_Xli8xO3Dhw_1742393529
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FD041955EA1; Wed, 19 Mar 2025 14:12:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6FFD1828A80; Wed, 19 Mar 2025 14:12:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4452418003AD; Wed, 19 Mar 2025 15:11:59 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 2/6] hw/uefi: fix error handling in uefi_vars_json_save
Date: Wed, 19 Mar 2025 15:11:54 +0100
Message-ID: <20250319141159.1461621-3-kraxel@redhat.com>
In-Reply-To: <20250319141159.1461621-1-kraxel@redhat.com>
References: <20250319141159.1461621-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Catch lseek errors.  Return on errors.
Use autoptr for the GString to simplify cleanup.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/uefi/var-service-json.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
index 761082c11fc1..f1c20a6b8c1e 100644
--- a/hw/uefi/var-service-json.c
+++ b/hw/uefi/var-service-json.c
@@ -178,7 +178,7 @@ void uefi_vars_json_init(uefi_vars_state *uv, Error **errp)
 
 void uefi_vars_json_save(uefi_vars_state *uv)
 {
-    GString *gstr;
+    g_autoptr(GString) gstr = NULL;
     int rc;
 
     if (uv->jsonfd == -1) {
@@ -187,18 +187,25 @@ void uefi_vars_json_save(uefi_vars_state *uv)
 
     gstr = uefi_vars_to_json(uv);
 
-    lseek(uv->jsonfd, 0, SEEK_SET);
+    rc = lseek(uv->jsonfd, 0, SEEK_SET);
+    if (rc < 0) {
+        warn_report("%s: lseek error", __func__);
+        return;
+    }
+
     rc = ftruncate(uv->jsonfd, 0);
     if (rc != 0) {
         warn_report("%s: ftruncate error", __func__);
+        return;
     }
+
     rc = write(uv->jsonfd, gstr->str, gstr->len);
     if (rc != gstr->len) {
         warn_report("%s: write error", __func__);
+        return;
     }
+
     fsync(uv->jsonfd);
-
-    g_string_free(gstr, true);
 }
 
 void uefi_vars_json_load(uefi_vars_state *uv, Error **errp)
-- 
2.48.1


