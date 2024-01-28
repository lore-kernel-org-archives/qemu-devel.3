Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3929C47DDF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 07:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTzOL-00038e-Gs; Sun, 28 Jan 2024 02:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rTzOG-00036I-9D
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 02:15:41 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rTzOE-0004AP-05
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 02:15:39 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso1307463a12.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 23:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706426135; x=1707030935;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V1KoYGLz/4ZfG7upt/fBifSuqVAkdhjRoiQkFAgHFg4=;
 b=qcCtPhMEeEACfeV9D1TBUNDMZ5wNnZm3aadHt5UTZyhQdNYHaj4VoNEQY6jmsbE6wI
 5287o8pO+UwE8Fj0X8TqhUEGW4kgNIrbyydvZF9p06Udd+N1Bus7GMdP7E7zft88f2eD
 UpLPdHeANsXt8Yn1bTONxtCmXh421V176EcckZzbNw08ROx/9SgdEGik3iaGzNdyShEn
 RMIrfmyLT7CD1uWM3/dvvmg06J9rQoDY/kqosp2P1BjpcIZ1UgKU9kfospv/OD7QE5bD
 KZt+XFl8vqZQrGdkbzKQ5edSP2/YZLbQol8NYsBNXS7MP/w3IFrd8UnH8tUZBVgJYjL9
 vbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706426135; x=1707030935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1KoYGLz/4ZfG7upt/fBifSuqVAkdhjRoiQkFAgHFg4=;
 b=s+imsbRuNRiMApGz5GwM0Icfhp46VQNfvj9avfuIkrPZpuf2UT+ioXC0GTPYtHE5w0
 AdE98p59957s74SibgaB5ey8mKk+b5R5fQ9aZFa2Tx6BVLp4dm7LUJ+efLywZIb/dDQl
 rgqOooazTOKndbcfQI0++NNdQXWo/yuR3mgXo8eMcJ6rDBSIx3rMLcyFaRMSNKcmZu+r
 vZ+R6Z+lh38fxRmCw8mYgdTIsavTlI3OuZyDP+jUh5LOGYhu3yPeA0IsR7dWyQ3YOvlK
 v5/zwfD5LIZz1MIUCRwJFTSnpDLKf72MsItVPdLtgzRUpVSll8ydbdthDakKMZ/4TLp/
 QJPA==
X-Gm-Message-State: AOJu0Yw810131YAI7fQzeKU1koTCEPMbzElLqimsswszmMsrBWaiKOr5
 yBejHqiobXwXKRarnP4ESYmUQz8eemkrUDZcFwTbF02PAFC/M9oNyPYlc5y46HQ=
X-Google-Smtp-Source: AGHT+IH1Gj4h83KVztRR3824U4dHXQZufuERRVW0vyKYzfcesgXCJDY2f61wsZHyphCICBbprzIHsQ==
X-Received: by 2002:a05:6a20:2045:b0:19a:ef21:60a0 with SMTP id
 x5-20020a056a20204500b0019aef2160a0mr2532304pzx.25.1706426135505; 
 Sat, 27 Jan 2024 23:15:35 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 j2-20020a635942000000b005d5445349edsm3768544pgm.19.2024.01.27.23.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 23:15:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Jan 2024 16:15:28 +0900
Subject: [PATCH 1/2] hw/smbios: Fix OEM strings table option validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-smbios-v1-1-c3a50499baea@daynix.com>
References: <20240128-smbios-v1-0-c3a50499baea@daynix.com>
In-Reply-To: <20240128-smbios-v1-0-c3a50499baea@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

qemu_smbios_type11_opts did not the list terminator and that resulted in
out-of-bound memory access. qemu_smbios_type11_opts also needs to have
an element for the type option.

Fixes: 2d6dcbf93fb0 ("smbios: support setting OEM strings table")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/smbios/smbios.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 2a90601ac5d9..522ed1ed9fe3 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -369,6 +369,11 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
 };
 
 static const QemuOptDesc qemu_smbios_type11_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },
     {
         .name = "value",
         .type = QEMU_OPT_STRING,
@@ -379,6 +384,7 @@ static const QemuOptDesc qemu_smbios_type11_opts[] = {
         .type = QEMU_OPT_STRING,
         .help = "OEM string data from file",
     },
+    { /* end of list */ }
 };
 
 static const QemuOptDesc qemu_smbios_type17_opts[] = {

-- 
2.43.0


