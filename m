Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEACE6ADCD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVf-0005q7-It; Fri, 22 Nov 2024 17:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVc-0005mz-Tr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:16 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVb-0003lR-I0
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:16 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7f8cc29aaf2so2040558a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315934; x=1732920734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4FdoiVujAHlSAX1GNeXZCXDPP5ciq+pm5Du23bE3KQ=;
 b=IkpQQydvpfblOy/pWVyDCRhND/bsuJ3m7yvCI0002I1mEDdQ1ZgOlVAPmUS3I8MQTA
 Z3f4DjSdQ+rZtwybTt8cqkqkdIPS8hEdLRRTc+BIHM72G32N3Bn2ta98K+9aVUde7TKX
 xD9bSk5h4UBin/Ob1vrWmTAFhghs6U7FvC1UNAI2TraNqQJOKWB9n9Ff9wGYcEwxRbgR
 kMnJdv86B5Os90/n3546Xfj3Il04BcklsASd4yFwu7MUs0d4R/3hJyJsfbKuvq7fnr6j
 ikO5tKEVC8d4X+0S4zZBMNTsHacz+x9lADyzK7P2us7cSofwE2aMKhv9QGkfbM7cn6yh
 fCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315934; x=1732920734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4FdoiVujAHlSAX1GNeXZCXDPP5ciq+pm5Du23bE3KQ=;
 b=YqTbQN7FaD0pNsQEG5FXFKKCTsvVSsOlDmSM2Q7ddI7W5iuN0gapevzeQth2WFfyyk
 asXkOIARQaL+dnpQMnFVKes3MTr2LyQfRVu/sumPJ4TA+R6r6LnX6KwlO1B34rhw6vq+
 e7uRR65gAAhae0ylgew0RiSakjalXmI6WL+iYJIqksGjD+9O/qBMKNldQ66TNm1ITqhv
 WiLfXvE7cgAVcM2MW0UBiGq5RREqTc/gefi3C/JPQLT2MsiJSMqW38F2ercO5jtmb78w
 NzsN53Tn//hRXkIhsEd8COjUpFcX8fAUk+Tqtg93W68K3PU/IUAFTR2jrNqGkmOvAHtn
 kDtw==
X-Gm-Message-State: AOJu0YyfVWtzM1lSmoOEwEh/Ce2wtoagIWXnmU7mpFOD97amELvHyaZO
 BluDXh6pCz3vpX7SAyLuSQz0HpHObTV+HbI+ybZfWrVFZaK3U5AV8nlqwVNq55OlmHXxt3fSzOh
 d
X-Gm-Gg: ASbGncuGUfdLMkqVJ+dnp3eAjatPyKfgDEMCWzVe5+sTLC/XVojCrnwX1jH0DQs5SmI
 VmuhukHkwKzg5Z1x9qXxgD18u4qFQ69zJQaJKe9ec71yXM3pA4IZrLF/ufL9w4qp4IRD8ty6fnb
 9f0qQItyRMbiHCkZYYx3p0/WsKEyNoabJaDA7X6a/5DtyXdYBtq2ts8iQuZOMwNDnU/UYRilI2L
 zJ8DGSVq5G5+XWsYF/CWByOF9sjAOhpgZrdtpWZy6/H9vI0rjfWHMbcT0nGp5i08Lgs8eCztLhz
 w/+e24Vp+cBMLg==
X-Google-Smtp-Source: AGHT+IEZ8vMtT4tlL3dFmKWQwg3pjx2Zl1LDPdzC/p8HBAJfYTdyVtOHfOls9IUa/lvOLkWEA+/cuw==
X-Received: by 2002:a17:902:f711:b0:20c:dbff:b9d8 with SMTP id
 d9443c01a7336-2129f28a632mr67148785ad.37.1732315933879; 
 Fri, 22 Nov 2024 14:52:13 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:13 -0800 (PST)
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
Subject: [PATCH 10/12] docs/system/arm/xlnx-versal-virt: document ospi-flash
 property
Date: Fri, 22 Nov 2024 14:50:47 -0800
Message-Id: <20241122225049.1617774-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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
 docs/system/arm/xlnx-versal-virt.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 0bafc76469d..c5f35f28e4f 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -178,6 +178,9 @@ Run the following at the U-Boot prompt:
   fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
   booti 30000000 - 20000000
 
+It's possible to change the OSPI flash model emulated by using the machine model
+option ``ospi-flash``.
+
 BBRAM File Backend
 """"""""""""""""""
 BBRAM can have an optional file backend, which must be a seekable
-- 
2.39.5


