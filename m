Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054EBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn8F-0002LM-36; Tue, 16 Jul 2024 14:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8D-0002EB-QU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn82-0007Nk-Py
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so41126645e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155340; x=1721760140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I193XtkSF6UUQSItZ6ZLJnPcIP1h75KwwcHfeLlOgI0=;
 b=bGyc13k3rDf10GYqEG+cXerToZ7S/EVoId24Wz4Jz5djLgn2+r0lmzpxXSGUHwcU01
 YGKJbS66dxf3RWaLgAqthH7nzJTTFsWK3FzBx2g8Fc6mWXe82Iuyu4JCE3Zq5BG3Z7PJ
 r6FansOsTeGPWBbIUlgTx48tXT6AdxoLZ7/H8MNI1QSCXtUDfE6mmrnOT58H/VxjwXSw
 Q92u8LatL0mBiz2T1+LTDXLgB+/yMN2pJQ4hk80E5B7QPIse1gP09IQefRiBe/0tKiZM
 nla/yUVKzgY0v70c49Y6JAJemuLp1PU3+6S5JeUc0Y2fP0wr/OH7Ohb8K9acnPJEeFkg
 TPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155340; x=1721760140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I193XtkSF6UUQSItZ6ZLJnPcIP1h75KwwcHfeLlOgI0=;
 b=Jc7LfAEEBaGCootDhbFD37fCKKEsalR9aZoIaCi/A96wNXt55uHEGZ6XOeiJf+m6kR
 JrjByX1Ymy0IKubtVdXD3zKmhVqw2+BO0ZZGlrgYAilqAIOEO65PqcATQzVRrxwsSNcJ
 3JYOE/2BBR3rnwBodzT6Hbl7XPABDinqS3MDl0xYXUHzrTYAIKhbbx2ZrW0527CUroRh
 Sdc2S6ZlDgFDFQgIPWfN9bGpOnJpNJpA3demDDnToNYpL9E8FXJKITwtvKy0NwVEtCMR
 moZLdzEQPHXnsaldn3kGbnkym1Dlqq6WY1FhbiclT0zw9UK/iYzSM3RRMXzA5Jd8Jb3G
 Lg0Q==
X-Gm-Message-State: AOJu0Yz6DhoYnjhGTPZI+GXSDD77SaDoqoHveS3uwZrlg6eK3Fcf1ZNQ
 oR9D4xR+Od6HnuP38v30da9wjqbXzb/L8ynPF6P8uOb4JDIOq8ZbmWedXy7yz2C76r6fmfyopTN
 wCFcSnw==
X-Google-Smtp-Source: AGHT+IGRTMAOw/FLA5f3SPXAHwnsPqhnBUfOowBZjLaChaeHCWblS1ISZNI/LmuCJLEnqdkgLWL8aA==
X-Received: by 2002:a5d:458e:0:b0:367:8459:a56c with SMTP id
 ffacd0b85a97d-3682610c7d1mr1904438f8f.15.1721155339883; 
 Tue, 16 Jul 2024 11:42:19 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc306sm175963045e9.30.2024.07.16.11.42.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:42:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/11] hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on
 eMMC (CMD23)
Date: Tue, 16 Jul 2024 20:41:38 +0200
Message-ID: <20240716184144.42463-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716184144.42463-1-philmd@linaro.org>
References: <20240716184144.42463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Cédric Le Goater <clg@kaod.org>

The number of blocks is defined in the lower bits [15:0].

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240712162719.88165-6-philmd@linaro.org>
---
 hw/sd/sd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ab502d19b8..09077f0154 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1533,6 +1533,9 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
     }
 
     sd->multi_blk_cnt = req.arg;
+    if (sd_is_emmc(sd)) {
+        sd->multi_blk_cnt &= 0xffff;
+    }
     trace_sdcard_set_block_count(sd->multi_blk_cnt);
 
     return sd_r1;
-- 
2.41.0


