Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F81E66880
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdTO-0003XR-36; Fri, 19 Dec 2025 11:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTM-0003XA-UD
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:36:56 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdTL-0000Nn-9I
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:36:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so14703985e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162213; x=1766767013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Idoopkne2XoD7/e2z+6W5PLbLmqN2coild025VrEoYo=;
 b=KM/0FkQZZYCyZnJOo6Zty+MlqRF8+kD7q8Z2somCSHCF6GmEP5Ge/aYZ8h4/A2G9rs
 26tSkuEUDihy996GXC5XBv1WDBJwhIIJ8du/b9hUU7SAPC0Cx3r/W/Z9wIItq7ytOUmL
 pjZz+O24mflLGOGYevVj1jn5g5yqloLe4BSRfID2aodJiYTDzAsbh5MKebOenXtRhr3h
 Yewg45ZjTTuEvPjxjyMdeY7PWLC3XGwdBMM6fCmBNTnJ6gejv9r+nja7mqrJMesfwt8i
 c26f3vOIIVuHqNCHLOElPhu6TVooRysSt+SdJospWq+YmYrxvDCEb7n0lnFhhKex7PJv
 67+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162213; x=1766767013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Idoopkne2XoD7/e2z+6W5PLbLmqN2coild025VrEoYo=;
 b=KX2VNRJnLCvDwSrKLkOV5EesZPeDVwk53zoW3cIFRpnAfvEG4ZnWefYvnn+awD4Vgb
 I5NEv4bhsmv2XabQCOUjoCm5THtx8fWbTwydrBBn4qTXwm/Lp/FEN+ITX4FFqDUG3SmA
 gnlme6A8fr56JNX/Us6q0sE7gnK44mQh7b5PXaMgflM6ILn5Z8aVZva2LXWXo3WpawTu
 wsbaOOz9YzSJgjFxQEvpIqKJoEaJwNxYnnlWWZxbofCUrqZ/HpkxOdrOFoxiONPhgoQu
 v9ChcFDsH4aPFVZH5VlRjVVsbAZ84ION/gq6iRnoDF1QRLJTVrC+vG4cM5jrVEJELJSa
 2qgA==
X-Gm-Message-State: AOJu0Yz4XV//1ThwZ2nC4J0U5wacKdN0a94ny4FraToRgIfMTSZ1JKcG
 REkcjCEKVWWf6vXP35LEbvD7a4GhoCZloPobeoMfjZO+NZ+DXUdyTFV/Kdk3Fh43712l4nWHmBP
 m4hUvWRU=
X-Gm-Gg: AY/fxX7eaij/80cr2VVj44A9kKuNA7QxZ0++TA6wlTHeubidhK9WpDObLS4LUTsQpk1
 tlzQzPBXXb8wC9CzZl/gXprls60eJzcJgM+FACrG8mQY8q8svv86BQWra5FpHLYTvz/WJ5gDp+4
 4Rl8Yvweq+/NVi24XMTfxkpWrG5LF9vaqABWSd4bZ/1TwCM0+WcKEU28RGlhT8HAoJf7Mls8EHi
 HsVst+EqZ+8mxOUl5kkC2F+YcCJrnB6iEl7MdTjc/xXGhtaeAdRCspnamEAqCAdTidEVYSx9plx
 q/vTmR2qWosBZfgxw8M0vaGLpxLnDCx21S8akGC2axm/rajhWgIMRLhiPDyrzp7wPDpG9rOXbzZ
 +eJZ0/0mlsf42bL6uHVIWW8hOXpLjUW3FJZ+halcKDtYaGrtxSpwZekRs++i5pURxT5Zu+CdBts
 BJykEAK2+EHg0+zqV/EL/C+/mSd2gnX/9LRq2Cw/Bj8RXevOw/TU35Rb4EpM7m
X-Google-Smtp-Source: AGHT+IEkxnTJcJ9oAUxuC6v68WLP5ktyzJwu7Ct9ZyyhuJMNnqjisS7YudX611Di/S7IBEnVqKhAxw==
X-Received: by 2002:a05:600d:108:20b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-47d1c038664mr20285055e9.28.1766162212543; 
 Fri, 19 Dec 2025 08:36:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbe58sm50901345e9.9.2025.12.19.08.36.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:36:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/9] target/sparc: Stop using the legacy native-endian APIs
Date: Fri, 19 Dec 2025 17:36:40 +0100
Message-ID: <20251219163650.74303-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

SPARC is always big-endian, so use the '_be' suffix to
select the big-endian variant of the load/store helper.

Simplify gdbstub using ldn(TARGET_LONG_BITS...).

Based-on: <20251219161953.72724-1-philmd@linaro.org> and more.

Philippe Mathieu-Daudé (9):
  hw/sparc: Use explicit big-endian LD/ST API
  target/sparc: Replace MO_TE -> MO_BE
  target/sparc: Use address_space_ld/st[n]_be() in ld/st_asi helpers
  target/sparc: Use explicit big-endian LD/ST API
  target/sparc: Use big-endian variant of cpu_ld/st_data*()
  target/sparc: Inline translator_ldl()
  target/sparc: Inline cpu_ldl_code() call in cpu_do_interrupt()
  target/sparc: Simplify gdbstub sparc_cpu_gdb_write_register()
  configs/targets: Forbid SPARC to use legacy native endianness APIs

 configs/targets/sparc-linux-user.mak       |  1 -
 configs/targets/sparc-softmmu.mak          |  1 -
 configs/targets/sparc32plus-linux-user.mak |  1 -
 configs/targets/sparc64-linux-user.mak     |  1 -
 configs/targets/sparc64-softmmu.mak        |  1 -
 hw/sparc/leon3.c                           | 42 +++++++-------
 hw/sparc/sun4m.c                           |  6 +-
 hw/sparc64/sun4u.c                         |  6 +-
 target/sparc/gdbstub.c                     | 12 +---
 target/sparc/int32_helper.c                |  4 +-
 target/sparc/ldst_helper.c                 | 66 ++++++----------------
 target/sparc/mmu_helper.c                  | 32 ++++++-----
 target/sparc/translate.c                   | 60 ++++++++++----------
 13 files changed, 95 insertions(+), 138 deletions(-)

-- 
2.52.0


