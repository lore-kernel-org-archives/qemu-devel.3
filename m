Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19951D10C02
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4kzA-0008Mp-0s; Sat, 26 Oct 2024 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kz8-0008MW-Ew
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:53:58 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kz7-0003is-0B
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:53:58 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e30db524c2so2292702a91.1
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965234; x=1730570034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=20F5Gu/eBrEEfio2iNByM6idYfdt22xkEdJwFN0eM/0=;
 b=P4kRVCSSmeopdehH8w1FscnAKeVtByU5MzqET7WFuhMwddgCOIFLA/s2JTIp9kS3kt
 IVUkmVDRHeaUYnvM7YYckDzUyahTVT9YVI24+sKdVo667PwtewvHuBEsXbV8didJw4CC
 3Nx5kSecheFJ1KamLIrZQuycLPTv56fstLc69uwfAiuJJYmVrFz2WEscNzcUubeF2+az
 6/3JvfStrQJL8SliqyURt6glIF0PzHm/4hmlQORTZ2rPOIjufM/tKgIFwcxtK4+qxewI
 jnqH4oDmnGyyfenqqPuY74wTwDsMhdXWHeE3+IHnrx0alC0NaYo8CT/CpD0jIFVOb1Xe
 Qc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965234; x=1730570034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=20F5Gu/eBrEEfio2iNByM6idYfdt22xkEdJwFN0eM/0=;
 b=SxV7gVXA+BMPdle625vi6r8AmW08ot8IM9BE90U8EhfKbp2+LRvaCsZ2WtVheHa46I
 TQVb1YruhDi+ob/TMjP6XLaypWE0iVX6oiS9KBQEL/IxAzRW+YM/RFcv6z0nUZR2XzPq
 iH6aeqmLhlKKTRptODRL+pUSjcRPytOJ4FgU0xgSmxrVzaIxDPM8mHb1ezydopeTX68G
 UGTQ6zPpYxNmHdkTvEz0DoOmOvlvkT2E+z32Q8X5xR60+P32al3KHO+MCuvTI5/9YaSQ
 On+9Vc1BTYOXoGkVHsq9C9IwGE8QNQiEBNO/0xWRYxCS2vUHzeYjCcGgW0x3XaRzZE2Q
 jJEg==
X-Gm-Message-State: AOJu0YyP/eu3wfdXqezu6M0QxCgl3ayPk0lxSFu0n3NVaMc7fKkmOrmS
 Fs5pzPGS/ZvR3c35NtdUJHT4p53fJ3mNSvZxTU6GIm+1STOzpshKGAjFsHHlQ2GzOJaTtuTKCYI
 G
X-Google-Smtp-Source: AGHT+IFaVOTz7nlxdqTVvGy+5dJMDnc5ndeX7MHMagxBFu1FS0UWDOKnDDmGDR9RzeoAjOOovmQkbw==
X-Received: by 2002:a17:90a:c089:b0:2e2:b69c:2a9 with SMTP id
 98e67ed59e1d1-2e8f11ac969mr3847746a91.26.1729965234643; 
 Sat, 26 Oct 2024 10:53:54 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e77e48c18csm5899775a91.5.2024.10.26.10.53.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 10:53:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH v3 0/9] target/mips: Convert Loongson LEXT opcodes to
 decodetree
Date: Sat, 26 Oct 2024 14:53:40 -0300
Message-ID: <20241026175349.84523-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Missing review: 1 & 9

Since v2:
- Extract decode_64bit_enabled()
- Remove unreachable 32-bit code

Since v1:
- Fixed '!is_double' check (rth)
- Rebased (removing tcg_temp_free calls)
- Simplified MULT[U].G (rth)
- Added R-b

Philippe Mathieu-Daudé (9):
  target/mips: Extract decode_64bit_enabled() helper
  target/mips: Simplify Loongson MULTU.G opcode
  target/mips: Re-introduce OPC_ADDUH_QB_DSP and OPC_MUL_PH_DSP
  target/mips: Convert Loongson DDIV.G opcodes to decodetree
  target/mips: Convert Loongson DIV.G opcodes to decodetree
  target/mips: Convert Loongson [D]DIVU.G opcodes to decodetree
  target/mips: Convert Loongson [D]MOD[U].G opcodes to decodetree
  target/mips: Convert Loongson [D]MULT[U].G opcodes to decodetree
  target/mips: Remove unreachable 32-bit code on 64-bit Loongson Ext

 target/mips/tcg/translate.h       |   3 +
 target/mips/tcg/godson2.decode    |  27 +++
 target/mips/tcg/loong-ext.decode  |  28 +++
 target/mips/tcg/loong_translate.c | 271 ++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c       | 271 ++----------------------------
 target/mips/tcg/meson.build       |   3 +
 6 files changed, 348 insertions(+), 255 deletions(-)
 create mode 100644 target/mips/tcg/godson2.decode
 create mode 100644 target/mips/tcg/loong-ext.decode
 create mode 100644 target/mips/tcg/loong_translate.c

-- 
2.45.2


