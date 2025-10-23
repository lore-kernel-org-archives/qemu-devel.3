Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AB9CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvMv-0007yA-QJ; Thu, 23 Oct 2025 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBvMt-0007xE-1u
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBvMp-0001Gp-0x
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761226111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OF2nA1METujzPjHJV1HljOWiHhBhgZvjTGkE2DUFBmA=;
 b=g7o9CxhAsi+pCsefCUwAIXnFj9CgGRLKN86ZltAnAg0fmgiMaS6rCn/UJpom/1BrOR3Jjj
 pKK7z3ET6FKPd0LkzY36OOIvNthHIehwEFBAQuhNa69qy7BRdwAXvNj2l2GfdwU+8x+2om
 A3F/q4YSLwAIIRdr+Ow0sNikN8d1/04=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-hcROlVZUM1ueR6zyIm6Z5w-1; Thu,
 23 Oct 2025 09:28:29 -0400
X-MC-Unique: hcROlVZUM1ueR6zyIm6Z5w-1
X-Mimecast-MFC-AGG-ID: hcROlVZUM1ueR6zyIm6Z5w_1761226108
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C9AF18002C9; Thu, 23 Oct 2025 13:28:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.138])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D3CF19540E9; Thu, 23 Oct 2025 13:28:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 85BEA1800850; Thu, 23 Oct 2025 15:28:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/1] hw/uefi/ovmf-log: Fix memory leak in hmp_info_firmware_log
Date: Thu, 23 Oct 2025 15:28:25 +0200
Message-ID: <20251023132825.338615-2-kraxel@redhat.com>
In-Reply-To: <20251023132825.338615-1-kraxel@redhat.com>
References: <20251023132825.338615-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

The FirmwareLog object returned by qmp_query_firmware_log() was
not being freed, causing a memory leak.

Use g_autoptr to ensure the object is automatically freed when
it goes out of scope.

Fixes: c8aa8120313f ("hw/uefi: add 'info firmware-log' hmp monitor command.")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251023063106.9834-1-zhaoguohan_salmon@163.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/ovmf-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 98ebb0209491..850ef21f8859 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -261,7 +261,7 @@ void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
     g_autofree gchar *log_esc = NULL;
     g_autofree guchar *log_out = NULL;
     Error *err = NULL;
-    FirmwareLog *log;
+    g_autoptr(FirmwareLog) log = NULL;
     gsize log_len;
     int64_t maxsize;
 
-- 
2.51.0


