Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACF5CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfa-0007w2-3T; Tue, 29 Sep 2026 06:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfR-0007jp-F1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:35 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfP-0008He-HO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:33 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48884b0219bso1914042f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676150; x=1791280950; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VOOyrT1J8y68rsCA5k0rcdeW7dkcYq+JFmPIt5Nc93w=;
 b=iWB51RBcwQ/x1TTniBg+wzm3924h9QgjdLp73J3HZG3db4UqviiWOpGqAZirGtVXHh
 VQkm2rWsXbujDVlsDAoXHiognxdbSGPKGfimKWmshlZpp1ou08YFTCDNFVUnWQvpPkcB
 b3R0RN2EtE9Fyb6IMM1fyLJyqGPcpzbuGaLXQUQ14nZIqhJulaIMUYPPJuMPq/saNzyz
 BqtEtcUHmbMw5vIjHAZI9/jQuhdgWDGZIS5Rzw6hKjzmjAuOsfcs8tX4FIC/7xWIreNR
 nTzSJFboL2Fl04suH2haTW5A2MJ8Sshd7G4Au7OckvCZFF97x1eWzqVr6iPNUNg7ysww
 YV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676150; x=1791280950;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VOOyrT1J8y68rsCA5k0rcdeW7dkcYq+JFmPIt5Nc93w=;
 b=idKlzFmtEJmq/RC62bpa1VnX2ENNNVBcK3ybs28983AjpB5eJl52bjth7Ab9FG8+lQ
 /hs9lpsfo+eSrapxZRYnDvbVaVvQe4cZurrwRqKzm2D1ghoXsvi64uvqw3lHk2CiZOif
 51O+l0/11FIReiZuwIJtSUYdzsO5IdYgkHub9EwFEoVdNz5BrGPQkRhqIcV6uSGx1UDy
 APUBjUemnuPEMH0T/M6j1/c22SwgIc6CtNVUgOzvJnJAIBnoMrKS7BPDTAfiS+tJTdFO
 P7oZSAq6vk/IicY8ZlvFear+Z2nkf/Xf8FKYXqyZ6ElD1/zWj4wO36yKqtYgbghOBQwq
 HvSQ==
X-Gm-Message-State: AFq9FYKIBElLbZMNhL1ZgodMc340zdqWInu/b4aezR81L0olIAqBQ8PC
 rih52FzfrFX54rFZmDuIjAAqXxBpFeVPGfKMRk/eVCMX0pqMhQFshukoviUIBl8MAFzgsaFnPw7
 aF810
X-Gm-Gg: AYBFou3OSXtmBAhZpZ6kJQFcenfDHlIpqLsDAuLRyCv4LweKxFrH4ASjcu5Wcym97Kd
 GfZiL4Owbxtabs0wPJPUq6ubqo8OupEyt5kqLG992F+njwJuoyzJ14AjLpTpz0j8S30LWScAtRz
 kBpeOI0RjVPdx3PNjGzeXw/7k48FhdjyuUBjyzAx8tgMLaQ/KXatogeYrszFoYe3HdjURBqSJBJ
 uWxl0K+vvziow4EjRKKLletyZAAglhbXLKDb81NVjaGRiH5PUkcXKuYkSDjG3MXjhhLrx1o5V8L
 LiLvGqdhDOSrLyPH/3EcyVOZm9UrD8fqGnYP5tgXQLuHpbBtitE084LGYW2Z9ZFn78OMA4ZUwae
 MqRvWI0WBxvgWD8bAC/OpDSjxSs598FQ9Lgq81WEtrrgxzlijTxNOYjhd496fdIbAEDr+R6Huqp
 8on2lRzR1XmzVEedXGvDj5pIZrooJ9AY5hGFCu0eCtwk2eGyjkxoG3FEIeeOMEDCmmweUXrsSRR
 SqRbgI4nMYOeuTz16RMQT5R15burfc5cJZTOddtwKQme5nwP68XsJGFuB7nmmaY6J7tdYT6Pu82
 4kI=
X-Received: by 2002:a5d:5889:0:b0:48a:f3dd:6979 with SMTP id
 ffacd0b85a97d-48af3dd6b6emr2368979f8f.19.1790676149954; 
 Tue, 29 Sep 2026 03:02:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/37] target/arm: Enable FEAT_UINJ for -cpu max-v9
Date: Tue, 29 Sep 2026 11:01:30 +0100
Message-ID: <20260929100133.2598676-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260925215004.456336-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 34b63f9867f..3bd5c42a664 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -223,6 +223,7 @@ the following architecture extensions:
 - FEAT_TTL (Translation Table Level)
 - FEAT_TTST (Small translation tables)
 - FEAT_UAO (Unprivileged Access Override control)
+- FEAT_UINJ (Injection of Undefined Instruction exceptions)
 - FEAT_VHE (Virtualization Host Extensions)
 - FEAT_VMID16 (16-bit VMID)
 - FEAT_WFxT (WFE and WFI instructions with timeout)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e156baf35d2..59692dddcfa 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1457,6 +1457,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, UINJ, 1);      /* v9.0: FEAT_UINJ */
     t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
-- 
2.43.0


