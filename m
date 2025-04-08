Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6E0C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E7B-0004ZI-2i; Tue, 08 Apr 2025 14:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E74-0004Yn-MS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:55:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E72-0004DE-7k
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:55:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3965c995151so3000197f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138554; x=1744743354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGo0+5f/HLAe67bUnyFSuZNNk2QAFIW9Hf13M3Fh2as=;
 b=CQ41GpPe57C4/TVDZA/mBMuzT8JxjzIEoTlG/fvFPVSeXVkT6pQO4KItMo3i5q9Ccj
 LjKo/+1VtFAHU5rlhlRStkiIl+0DZ6TgayPeOQD90C8sGbQaLVuWkB6AS2MPXQSvcIqO
 utmsvOL+wUwLkpVWVEZC8Qk+6+yiKKfXEI9n6GcNU2l0oH7vXH/LYYHar6HJdrdsiWKW
 bBlIaYVBBq+zlIeHZL65TaFL3UGjJ3Y+kwTtKb4IpiSuzdSJlvrppa07jNUN9mGNBotd
 hnmZDK0B1HkVKS5uJpdg7YVQHhPKjXsoKf8G24c00hICk7OxQ/OPJuUZVrkMe32M1fHq
 uU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138554; x=1744743354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGo0+5f/HLAe67bUnyFSuZNNk2QAFIW9Hf13M3Fh2as=;
 b=Y+pN3ciFTxDk1E4UUjE8MnJED8253csgr1Zk9w4qverwTZAf7yqej65rVOYrpRlo2w
 2HwfHqp0BeSksUelmpDTgiS4LwIpplPNklthhTK6MI71KBCqGQYPHyCNwUFg7+hrto1z
 Aq7r/+L/KN6BeFY77I5UMqhamouQCVfAHXUQzUj5R8Tjmeee8OAX6l8KsLEbxkAH1WaC
 1OWmumQPwXQ+h5jN1VrTKDqpFyNTww9d7KvTLhJEs006+emliFYjZdPe5PpNzNqmlnN2
 EM6RPj7VsKsuzEsNY003lj/fisAcqt0ZcKIQwbTNnp/7266R16JW/+7jbOHpXlrXsQh6
 iMGA==
X-Gm-Message-State: AOJu0Yzk++RhquF4It8gN8vFImUgbl8a1guakQ1rdANLKNZd9zUK2vsF
 B8o85TywD0df+O9nSmkSuI13EfoKcORWgwLlsrbNr09LrxgkTQLMBhsSLMEbAqXjQLp76B/OtGj
 JTdI=
X-Gm-Gg: ASbGnctyXAwNtL/Dnw9ciSX9gtOpb1/cDdaSf3pfT2OzKTEKni83axKQkZTr7m2QD2c
 y2sHFPQxVdQ7nCMUM3GCF9qIRbr4F4eK9cXXxWwedb5FETzrn/Oj++pdAgc/qhJ20WG41NLyAxr
 pgxyHrxoxdpFR2zn1p6GLpgD4ukZyt/SlevpNu09gOaWPVU/RkVv436hqH/HqmIxJIwRaqwW8CC
 w9/0q4GZb2AqxKZjPaWeSCOw0RUy8RsDPvG4DLdW4LLigxYQ7dtPf5+6nnWC05yRpDDlHIOsjck
 wWTcxYa3I0zRzFMMLjdQX1/Jen+ryDOA/HvdJ4redBbEDkzdR01CBU2erg/n+BDxLeceEPRn1d6
 ZnMbXpWPhYcoyMpR0spffel5YD5X1XQ==
X-Google-Smtp-Source: AGHT+IGCAtkpDt5w9hFPYZ1nAPjNJc0FSyDsi0b9c3LqV4P54gNKhipgPzy0E/9b/vZi/IDlPOonVA==
X-Received: by 2002:a05:6000:1863:b0:39c:12ce:67d with SMTP id
 ffacd0b85a97d-39d87aa1cc0mr292951f8f.9.1744138553973; 
 Tue, 08 Apr 2025 11:55:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1f27a55sm173079115e9.2.2025.04.08.11.55.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:55:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/8] docs/arm: Add apple HVF host for supported guest CPU type
Date: Tue,  8 Apr 2025 20:55:33 +0200
Message-ID: <20250408185538.85538-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408185538.85538-1-philmd@linaro.org>
References: <20250408185538.85538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Zhang Chen <zhangckid@gmail.com>

In my test, latest QEMU already support Apple HVF for -cpu host and max.

From guest VM lscpu:

Architecture:             aarch64
  CPU op-mode(s):         64-bit
  Byte Order:             Little Endian
CPU(s):                   11
  On-line CPU(s) list:    0-10
Vendor ID:                Apple
  Model name:             -
    Model:                0
    Thread(s) per core:   1
    Core(s) per socket:   11
    Socket(s):            1
    Stepping:             0x0
    BogoMIPS:             48.00
    Flags:                fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 asimddp sha512 asim
                          dfhm dit uscat ilrcpc flagm ssbs sb paca pacg dcpodp flagm2 frint

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250401083102.72845-1-zhangckid@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/arm/virt.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index adf446c0a29..6a719b95863 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -70,11 +70,11 @@ Supported guest CPU types:
 - ``cortex-a76`` (64-bit)
 - ``cortex-a710`` (64-bit)
 - ``a64fx`` (64-bit)
-- ``host`` (with KVM only)
+- ``host`` (with KVM and HVF only)
 - ``neoverse-n1`` (64-bit)
 - ``neoverse-v1`` (64-bit)
 - ``neoverse-n2`` (64-bit)
-- ``max`` (same as ``host`` for KVM; best possible emulation with TCG)
+- ``max`` (same as ``host`` for KVM and HVF; best possible emulation with TCG)
 
 Note that the default is ``cortex-a15``, so for an AArch64 guest you must
 specify a CPU type.
-- 
2.47.1


