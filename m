Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A83C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRClG-00046S-HQ; Tue, 09 Jul 2024 11:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkw-0002WF-S3
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:52 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCkt-0006Wd-Kg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:27:50 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52eafa1717bso2595699e87.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538864; x=1721143664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egTnAJY4Ail08o7ydS3nshQ0gmoljQp4B2SNOCZM4Nk=;
 b=OCW5Xo4UcQ5u/BJ4MZXAT1fDkefnYsAR0UV53gtFdVQOc9bbFskBaqgRBcHaOv/TEz
 ImwmvYdnLBDs8Yno1SkzmQhetSDiu7uVw8KLBhvXr/XVPKrYKbqY1lSXNoiNe4JnnxWX
 NNXttNrlVfOlV3yuBdyleXnOzcn9ZzNiy2bECUyFOdMxIZ0O80FzJAOsGh2tubfC6Lcm
 c7IDGtACVso5Ae2nPDC0zwm1eFzhGzOQtTlAKoyLGEevfsKmwXBwQMKrGykOGFSVrwd9
 h8o82ToB3+Wpy4D1oqCcJC6xduNLJQFCY5TgAZwXMQp/Eed8qsnbXD1AIRNG4BEtbsZb
 8xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538864; x=1721143664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=egTnAJY4Ail08o7ydS3nshQ0gmoljQp4B2SNOCZM4Nk=;
 b=nRVy3cy519DBgvT4rkO4dIRyuHcCLW4DIH+/OvU20lVFcxykmHuWgsQvwAbOLcZyJ0
 cu+Rz+a4s7azdtb/ZKPkG/KL0JiUVzl2vA2CoZ1q62PIzK9BrjVSIMYU81wGmjpaM8MB
 POMR+HnDDAR2zSWn5nBNKV38/hxRzbReAhr35+QOKTRn82RHHvIkIGEfLRMaWaQQzcOt
 pAtrZp33u7y/qen1IYWjJKbjrgjQ2KbWfbLokpoM5bkwt/hum5M8JJS91hV+In2KrWN8
 u6SWvew/yUKHqiHcj0vXkRAYKT7O4VdCZqliYyR7yazxOknKxHS0UIjb7iYU7fwNI7xy
 CE1A==
X-Gm-Message-State: AOJu0Yy8wCbNKxIxZLmYC8h5BHbfihpWo0LNaiRKZEalN/BEy0/JJL/M
 u0vSxtXmcI3OAkiprlZW+t8+MkvVSNqbCUq+UB7d0TA2/P7+8v8tLElPXkg/AaFSnCssM3J2Eas
 l
X-Google-Smtp-Source: AGHT+IG0cotN2kE7WlMybEPu1eIZlrXG239DnKZesEeq5IqssmtGpUoLVragYJxBV7owKkvUFVm0MA==
X-Received: by 2002:a05:6512:2309:b0:52c:8024:1db with SMTP id
 2adb3069b0e04-52eb99d4ebamr1935061e87.63.1720538863738; 
 Tue, 09 Jul 2024 08:27:43 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab80asm2863625f8f.109.2024.07.09.08.27.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:27:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
Subject: [Aspeed PATCH v47 17/19] hw/sd/sdcard: Subtract bootarea size from blk
Date: Tue,  9 Jul 2024 17:25:54 +0200
Message-ID: <20240709152556.52896-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

The userdata size is derived from the file the user passes on the
command line, but we must take into account the boot areas.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Squash in previous?
---
 hw/sd/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5830725629..291497468f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -814,6 +814,10 @@ static void sd_reset(DeviceState *dev)
     }
     size = sect << HWBLOCK_SHIFT;
 
+    if (sc->bootpart_offset) {
+        size -= sd_bootpart_offset(sd);
+    }
+
     sect = sd_addr_to_wpnum(size) + 1;
 
     sd->reset_time_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-- 
2.41.0


