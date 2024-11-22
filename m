Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B713E6ADCA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVf-0005pk-9i; Fri, 22 Nov 2024 17:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVb-0005lr-Ca
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:15 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVZ-0003kW-5G
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:15 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-212776d6449so29174905ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315932; x=1732920732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnekImMLpmnqj2ki5QRB6e1OkoxsbRA1JDfNzoJ9KgA=;
 b=fePdAl9/GX6lVSp1DzEbuxM6ujcK0/fDgaOLTpuBmujfrNI4HLHED61icQ/bPB63NE
 eLZjai2DxQSZOaHYnbONHht0NOxQEeTLQysfQ1MJDYCsi0oxM1EfVSId6WpGmUgYOrP+
 2o8j3eXx+Cc3Jbhl8kzXf4yzDu67Uv07PGXzfoWBIIcu/epTFVK01F6bjfv35ApcaLWZ
 ggFdSu7uIcsNuq1qLWrZ8BLl8n27OBsTuczCVjXaTOAVUc8fa+ixfDGnUNMcO7mKUKG7
 rXaK6J2TaBPCXaM6SWZog8+rG2E0JDIpFXDBg5rAGLGyFOxele3xC6fLNyELDJhDgt3w
 RQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315932; x=1732920732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnekImMLpmnqj2ki5QRB6e1OkoxsbRA1JDfNzoJ9KgA=;
 b=sV+8ANhn4p05a15LGrgigOda4dkerWUnulfywF7pxcOPyNTW62C72jOCajiGymsaZ4
 eJW/bQU8t0/ktkymFLX5KKOn8v2Hb/I7RhVxNLMRaCW+JOQ4PeQOUFa0YEzCEtldlBov
 BkEcNoQ5Y+BSrOfl/wv1OKaIUGx6LrvJYYdfyVA6nl1H9UgY8iKhAX7S/M+yYrToMKn4
 wObeR0SGFavn1PaXJJQNRJVk0p3SLzuecnyIfZh3xEBpz5qXRqz9WnDApFE5l6kxJoq3
 q665r/7uKwvZt023OyyTMl8TBTb69tp1toR/+qqqSs3ubQFilKnlGuPClOITDeFPkJwz
 GyTQ==
X-Gm-Message-State: AOJu0YzYvwJhIs0HKvTbH/VYlro6QoT5Y6eyDPK+Hlp4Z+ulwwM08bEO
 dRzb8XjZ8sz+VhwGMUwPNcd/AtFL7slWXQ06P/Eq03LpzI2LZd+kadZagn8JXteyQ6NDLPKskG/
 h
X-Gm-Gg: ASbGncu6YYnCAAfiib/kPkisfBi/xA46j2hqrxyF1uvzTCe+GwGGmTJlqBgz87T0+NI
 6LSTybg3OUVu+9qgMdHMkoR46zf/EWCn1AA4D/gXYas3hnXIUONDgOccugs6qTQhnXn/qrq4WtN
 8hyDgy7HPwduR/SHO+93L2Dk/1D3+atUZ4QUNSQDGjTsrz/NZ8+tseu546E+o4amlRLCZgZ4O92
 EMmgYqB5ER6TdEPQI8DOKCsAsBpwRkbCEiQZ+Y0XTdE3cHdnc5by5eiJGLgclLTtwKMO1I5wp0w
 +iCcpakYCDkYAw==
X-Google-Smtp-Source: AGHT+IE3corzaIp2Z8UzNSQyE2uX12n/ene/FKjh2tER+aNBiHAxc0gWDTTlK1TJ9t/l7sI+I1MsRg==
X-Received: by 2002:a17:902:d4cb:b0:20c:8331:cb6e with SMTP id
 d9443c01a7336-2129f53714cmr60798735ad.19.1732315931867; 
 Fri, 22 Nov 2024 14:52:11 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 08/12] docs/system/arm/orangepi: update links
Date: Fri, 22 Nov 2024 14:50:45 -0800
Message-Id: <20241122225049.1617774-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/orangepi.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
index 9afa54213b0..db87e81fec4 100644
--- a/docs/system/arm/orangepi.rst
+++ b/docs/system/arm/orangepi.rst
@@ -119,7 +119,7 @@ Orange Pi PC images
 Note that the mainline kernel does not have a root filesystem. You may provide it
 with an official Orange Pi PC image from the official website:
 
-  http://www.orangepi.org/downloadresources/
+  http://www.orangepi.org/html/serviceAndSupport/index.html
 
 Another possibility is to run an Armbian image for Orange Pi PC which
 can be downloaded from:
@@ -213,7 +213,7 @@ including the Orange Pi PC. NetBSD 9.0 is known to work best for the Orange Pi P
 board and provides a fully working system with serial console, networking and storage.
 For the Orange Pi PC machine, get the 'evbarm-earmv7hf' based image from:
 
-  https://cdn.netbsd.org/pub/NetBSD/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
+  https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz
 
 The image requires manually installing U-Boot in the image. Build U-Boot with
 the orangepi_pc_defconfig configuration as described in the previous section.
-- 
2.39.5


