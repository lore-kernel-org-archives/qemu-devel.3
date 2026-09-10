Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83159C88E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oay-0004tZ-9C; Thu, 10 Sep 2026 19:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWl-0006ax-G5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWR-0004mn-RS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYj6Zo8VlXl2zP5B4qr6Yw7Ml5uWH4dbodIZUAM6V0A=;
 b=Mg4ZDaYoRKfBeqdm21MpmmfPowQO2nXPK38qJryFDByCLxa8Gw97X4J2SOvKBM9KnYDJZ/
 dLQaqUl4zXUsSoXxsSq2CcQNbAc3NZw+IfYpzerG79MqW+whyTBH8slTSyv7Sls5ug/TQy
 5GSBkmUiU+49Oft0r08JVmE0A+c+mwY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-9PpT0C_fMbGwFBa_aix4fg-1; Thu, 10 Sep 2026 16:13:10 -0400
X-MC-Unique: 9PpT0C_fMbGwFBa_aix4fg-1
X-Mimecast-MFC-AGG-ID: 9PpT0C_fMbGwFBa_aix4fg_1789071189
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47d81cf0c4cso68667f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071189; x=1789675989; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YYj6Zo8VlXl2zP5B4qr6Yw7Ml5uWH4dbodIZUAM6V0A=;
 b=ZNkf8VBBzkMEiUQ9vW0pCmB8Ws3XcYx4LkcC8kBsDp+g0jFeXUWW995qZkYw5ggtT/
 OHJvHTu5aRIr5EYWHMW3hWPvzYBuHmPtB2iJyhaqWZB+29L3BuNAAQ0uYPvtTx9xFwLW
 lCn80i+xi80CFabvAQZlvHZs2h3rVzQsDJRvw00Q3laitFwGlZ6QqqLlTma0il9dNGgo
 3K/kX8lfS9P0lLVo97xANJFYbdHCY3IA4VXTNtkC15FDejBemuaSfNukBt7KijKfztMn
 gqAeNxIKVCqItm1MgrdhtgkkKi2P4jks3w9u9WV9sNXV61HQSc1toRZrF6L9wFxXNgeS
 f0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071189; x=1789675989;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YYj6Zo8VlXl2zP5B4qr6Yw7Ml5uWH4dbodIZUAM6V0A=;
 b=diqODQi5OvghKXtnEjG4Uz9/xmekJc1RtIxYQaa8E7w3MfDuVejR95R1yQ5SP6Xk9a
 /Efy0GfsGTKykzAY0Puyb4VMH3mwPu5KfW6bIoNLCSZ8oUQiSWNyamVIZ/TCw8eo8HmU
 klnOBCMZL7yrCZvpUcche9QA3N/CWulTF2vc/vR+IQtge2kMnSn0GLJFTe3uzoZvG0XY
 NMnfvSD1dEsQ5VeUHqAfa/8vMp+Okkgg4PWMoOQPGNlF9ocRvPCqC0wOxUjL7l2QBp2F
 w4PRZAyTbpNxqM1VcAez0BxsMYKe+IstwyFR0bzlF11RzvDzaDqFOn9fq8LV2HJ5PEaQ
 Bpiw==
X-Gm-Message-State: AFuF++mWS6WFZlQ4KYCsq+BRHqEj+ou0Qh61oXeN4AtEEwlM3iAsjLks
 qJog2xUe1WsKNDB4GqyqkjE+Di9hOIJ7n5YKQMdzTsddT5vi8cW+HsG9T2+urSQmGrfuIhsMQJA
 tgZMxRZLm+HWS2GgjDfCQmn4favJQfk5P+aYGFu1Mg934KulRH34GeS/swhajqDVi9OfbItR/q5
 9r5bHGbzjol3jOhh/dHaOk0VS3DlOhtaV2Nw==
X-Gm-Gg: AYBFou003GYzCEcMi9lR3jTd6F8+8zMqML1Jb/Jlm67yA+DSHbb/4eoy81xbvb7tRoc
 Dt7iguQE5kZx+Ts+aEneI7gRfKAc9qP4X71HK+nAjTDJV/pu4Eib10XQQtQxoWV0ESLsy7R4qBO
 ZT6Gw/PouS/gsg8KYGgfG2jaBBeTmRJuQonC5ZqTi0A6aA00EpH9PYtn3RRsJpDd0pRMQBfp8uw
 T3uEVXaXPVjDqkMtoff8ShSAoKzsfzZFn05NPEWb3yL2kLUZK5T7XO+unhQnIT+iwzQM2doYmU9
 hkxR88ppATQqzWrwtv6iE0ZHaQ022+Ql0ke2fgOJy0aeHbToYS7FDSA82wIXe07D5PgVl0Ygm8W
 PbWQHSu5153zIkTw2Z0S2leg=
X-Received: by 2002:a5d:4483:0:b0:482:dac8:cd0d with SMTP id
 ffacd0b85a97d-486eb33ec05mr1074724f8f.21.1789071189221; 
 Thu, 10 Sep 2026 13:13:09 -0700 (PDT)
X-Received: by 2002:a5d:4483:0:b0:482:dac8:cd0d with SMTP id
 ffacd0b85a97d-486eb33ec05mr1074669f8f.21.1789071188697; 
 Thu, 10 Sep 2026 13:13:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb350686sm758979f8f.27.2026.09.10.13.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:08 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 40/90] hw/cxl: Drop Back-Invalidate from default CFMW window
 restrictions
Message-ID: <a29c67749651a166be31f21b5b7cf8b26f4b7e87.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Davidlohr Bueso <dave@stgolabs.net>

The default CXL Fixed Memory Window restrictions advertised host-only
coherent together with Back-Invalidate.  A window advertising both
simultaneously is undefined behavior per CXL r4.0 9.18.1.3.

Drop Back-Invalidate from the default, leaving device-coherent +
host-only + volatile + persistent.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260720233242.901544-3-dave@stgolabs.net>
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index f92f7fa3d5..75edb2c0a6 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x2f, 2);
+    build_append_int_noprefix(table_data, 0x0f, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
MST


