Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF391061B1A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hjs-0007n7-Fa; Mon, 30 Mar 2026 14:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjE-0007i4-Sh
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjD-00039j-5G
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b87970468so4387716f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774896764; x=1775501564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xv4fXudi8WmA4+DY+5K9JiStPbSVSJvSdVrxjTUqZ30=;
 b=jwaFwx6SGUF18VvmcJ6DxZs4fqSG7KLo/eaZF3JDFuqyaQU1mUCDsX2Eh7RwHtBTA8
 xZ3ENvZ1gA7CpoqVKG47+ciOCFxvLxwzw29nN/HljPvup7/r4bgQPZ0A2VDSaC0jHQtw
 ck1lCvj93TF/8/WHDHBKVJRzDuolQtQLYBrfsoEWselN1EPT7KpWvRYLwyy2CC4CzoEi
 Zz7GGxprdW3j6PVx5nTBBs3VGGdp3t+9Y6Alt/jXpbjvShWkLWDKcLJyKMIpqIbMert6
 SRiI2q4XFZn6vbvrBvXFzxS+TpZ6itC8fU9BUMUfpDQEXRO1Uc4bBOi0+WCNUzWC02Mh
 PYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896764; x=1775501564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xv4fXudi8WmA4+DY+5K9JiStPbSVSJvSdVrxjTUqZ30=;
 b=jderCelg1vmoCZ4fyD4zDQFNFNaFS3QyPWiYd9Mh7LMA1YBewC7A0ZoAid7iOz1JJz
 QzKppND8RsBpi1KhUZmog8c3P8PfkH9J6tHDFOpXyVtoTYlTcZy10M5XuLD7PEHEOQRZ
 dLGbNecSuL51YnqebleljAX7e2Z4+Rk5rYBdFgsdhnZ6PFRWDeoVbTjoPXVa5LONi3me
 KTe6WLgbUdJsPAbsD8ohdgFbYvBtn+asUQE1E1j1I6GAIhG+bBh3XkhgckC/VFSbfCx/
 j4+9ZPq+eIWWNqmgT81ZD4bylw+K3CDVXIk/npE3MJO1TSayIPZFx65klTftDlI45FSV
 kApw==
X-Gm-Message-State: AOJu0YzOV+aR9jT8/pXZBB0zaWQkQhg9WVT0uI0xn2ORwiFHrF43hTwH
 DlzSxAATQNd6SM3urWnn/72ILeEdEySPDiLVQwTZ4hpZiZFBiUu7ZKDioGvUIyMWMgQxp+9KHXH
 j99WuXqg=
X-Gm-Gg: ATEYQzw6YkYSEAd+0NjFi+A/plskVZpJJVqGlT0FgFih+u0noalba7NPlOJarueg20d
 tSC8OY3Az5w99P/Adj2KtrMkDw4afa1lEn11gGZ0e8qlMldX9avoni3l1ov4h8v6WHUIsY11MDZ
 dRG2bfBm9StOevoMXfNpXclAJMD/vQOMdcGTWkqdQmjYMrLwYKwAJv7F9JqlYpvh29oAkVR6CKP
 8KKFZchdFf0feUipOKJClMheflZosPexR+oGU8rgwT9C441z6vGjsNCTpi4E2KUEhXvf3nZlnLU
 pbHw6BXRk3YkkGYeptZ9trOBajzFuKH3ux+df0TDfyLGYPkWs9D8Ohgawctfp/4EO/aP0z90OJ/
 ta3HtD2SsDHBmTXJdfCBRsjSkKaK6+/f3gIv5JUbOK7inTrS+BUfM/lpw05A3hajXWeedCrS/yC
 xDCLBHpTC1KE8DstumW9HAp/BJ4ylWvp4PHGelqCLzNpZAwF2MFehFmrPjhBJxfEoTIjlXXS84n
 pBuEDsOCCrIyOkqkw/lfeiMnR7tz1k=
X-Received: by 2002:a05:6000:40db:b0:43c:fd0a:5c6c with SMTP id
 ffacd0b85a97d-43cfd0a5fc9mr9798822f8f.0.1774896764197; 
 Mon, 30 Mar 2026 11:52:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f1749sm21229400f8f.14.2026.03.30.11.52.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:52:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode
 option values
Date: Mon, 30 Mar 2026 19:52:36 +0100
Message-ID: <20260330185236.1905636-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330185236.1905636-1-peter.maydell@linaro.org>
References: <20260330185236.1905636-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In zynq_set_boot_mode() where we parse the string the user has set
the boot-mode option to, we use strncasecmp(str, "qspi", 4) and so
on.  This is wrong, because it means that we will ignore any trailing
junk on the end of the option string, and handle
 -machine boot-mode=sdXYZZY
the same as
 -machine boot-mode=sd

In the documentation we say:
 Supported values are ``jtag``, ``sd``, ``qspi`` and ``nor``.
and that's obviously what we meant to implement.

The correct tool for this job is a simple strcasecmp operation.
Switch to that.

We use the g_ascii_strcasecmp() rather than plain strcasecmp()
because we're comparing ASCII strings here and don't want the
potentially locale-specific behaviour that strcasecmp() implies (and
we're trying to standardize on the glib function for this kind of
string comparison).

Fixes: 7df3747c92d13 ("hw/arm/xilinx_zynq: Add boot-mode property")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20260327145012.907264-1-peter.maydell@linaro.org
---
 hw/arm/xilinx_zynq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index d43f36b718..9dcded9219 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -186,13 +186,13 @@ static void zynq_set_boot_mode(Object *obj, const char *str,
     ZynqMachineState *m = ZYNQ_MACHINE(obj);
     uint8_t mode = 0;
 
-    if (!strncasecmp(str, "qspi", 4)) {
+    if (!g_ascii_strcasecmp(str, "qspi")) {
         mode = 1;
-    } else if (!strncasecmp(str, "sd", 2)) {
+    } else if (!g_ascii_strcasecmp(str, "sd")) {
         mode = 5;
-    } else if (!strncasecmp(str, "nor", 3)) {
+    } else if (!g_ascii_strcasecmp(str, "nor")) {
         mode = 2;
-    } else if (!strncasecmp(str, "jtag", 4)) {
+    } else if (!g_ascii_strcasecmp(str, "jtag")) {
         mode = 0;
     } else {
         error_setg(errp, "%s boot mode not supported", str);
-- 
2.43.0


