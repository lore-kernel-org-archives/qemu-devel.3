Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4196D65C56
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsaX-00020e-Cy; Wed, 17 Dec 2025 09:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsaM-0001oz-AY
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsaI-0007EJ-CS
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:33:00 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso47007635e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765981974; x=1766586774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKaSMi3pt0gIgplZvrijN03Z46js5TRmGQTJjQZggCk=;
 b=iw3VW9EnFvgK0Ka7oF0kkKjsnkdNSCHiq87BQ8+HzYJzo/ZpYfyDK/ZIiVJFF5cCNk
 Ex9085VWscYUJioZA9GOHpQDUY5tYcm/kq3bo/qPgvdV3Nwxo9QxEHngvLp+qeRQnJ7Z
 wLBZZwmUEFhFXsNF7u2cMOOylRRSDQEtit4MWbcg0Dx5Y92+ee3kwxBudfSPeDpdBIYM
 zWU8f8My2nhdpjBRNMSpJF/qnQGPEh9WjkOROGvCItkB2a2JqyJ23NJxz69FA9kCt43d
 PJeBQ0RO3LsOkulXNGTs4RU9qxWpqETbQvZri/BQNRBEcKyo2tlMF4QoQOhvwlbKxi/r
 Ngww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981974; x=1766586774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SKaSMi3pt0gIgplZvrijN03Z46js5TRmGQTJjQZggCk=;
 b=KD3xmW+aBInsvUYXLmIIivqGR7PKG9vH7UB9QrQx02RkOuePfNKxnXIm1NoI+B18A7
 /hvQo3Rpu0VhC+zDRGZ7ta2Tg2GGFQaTUg70kcHg9nMA01p+InfUJq2up3mseSrk24wY
 /FF3r0Bjnlm9pMErIDsfySvAa+jgB3yC65W83h427pljbty/0VjOSEtPwAgEHLFcj5Wz
 TQd66wUmv5RVhU1fsbIK2w5PhuSx3Nxuuue5/PeVpdOsUaRXl3vObiu70MnBwhuTMWRX
 PRWuuMhDSxG51EFJNS71KGKIWPT/KRgthphRLub32n+yFzCVWxLdyEAw03xMpq/lyAL1
 QFSw==
X-Gm-Message-State: AOJu0Yymqs+XoBfMPtTgnd5VMB1eVHhkaAIB9IpY+M3jvX+ynfMTonNa
 HlqvWkyw80mjtlsmGoa3pHJABHmLkfGeL9aVzQ3MUDCCz7oSQhKVP56mi39WMugQSUw5WPKPmWm
 /0NP85nrQyQ==
X-Gm-Gg: AY/fxX53esosYbYP5Ey5Kdrnu/uNwWYqruVTtXXqOgujIbBL6wdNWIRyJQdA/euJG/E
 IRfsr95A6+SW2Z8OyZCBEFNWwkwxd5xArUWvJ0ivVjp0eKEAuRQJJQfvAskHKczyqXx7Wn+hIpb
 eW8gFxRpeOnAYtkBY1odnzZ2qxXBF0hMTAuRnYHEgUJIERvA+YaHKp2VqW+5LLCwYodWOySU0vD
 OH4heNF0fFP4YopYEPYwcREMUKaykRa+3xSbSIca8Tb4GWiMAakRm1YH58SMPX0SFClBkspdHen
 Oc8ub+mi0aml7VmqrZrm0chWA2SkgHI86HKAMpFsn1hEohmXEbmJlUzoH17N/MSVrCh8XR0pbic
 iEuZNdD/Z3yG1X3wn1Uea9vUHpNa7f1ufLNA+1Rq4Ny8xR09SncBsKuc5eCa45P/9l5P2BDlJpm
 ULpw8WO9pCChw8DD6ZFy3J7mXsefvtvGvy3uvbzlmk7lgSjaWv7xqcGO8Vhjj1QzkaM5tVlQg=
X-Google-Smtp-Source: AGHT+IHRVKUtS2MEM4IPi/MXXjtHq2fsKmWv8GwyE05H6zNhhaPwSybZ3Ilytm6Dcec8WiosK2BWMA==
X-Received: by 2002:a05:600c:a46:b0:477:63b5:6f76 with SMTP id
 5b1f17b1804b1-47a8f90cefamr184197965e9.25.1765981974512; 
 Wed, 17 Dec 2025 06:32:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc1d20absm43939065e9.4.2025.12.17.06.32.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:32:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 08/14] system/memory: Inline address_space_stq_internal()
Date: Wed, 17 Dec 2025 15:31:44 +0100
Message-ID: <20251217143150.94463-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143150.94463-1-philmd@linaro.org>
References: <20251217143150.94463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

As its name suggests, address_space_stq_internal() is an
internal method which can be inlined like all the other
ones in this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory_ldst.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index b45bfecd137..d5776678edf 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -422,7 +422,7 @@ void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
                                DEVICE_BIG_ENDIAN);
 }
 
-static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
+static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
     MemTxResult *result, enum device_endian endian)
 {
-- 
2.52.0


