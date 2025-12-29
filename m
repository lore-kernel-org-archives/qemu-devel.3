Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C895DE92FF7
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaM9H-0001mO-CZ; Mon, 29 Dec 2025 17:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM97-0001kM-0W
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:27 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaM94-0001BQ-1n
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:55:23 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so58533925e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767048919; x=1767653719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YoJDqo4LyDIhaY5T9JWwbUAyezya8j52K6GVubjeiVY=;
 b=DOUq486q3HHzXRf4lr8IUDYuYKa0EngEj6Y5eo+KRwKyz6VVkV2Opofrxn5SHlvAoR
 t6SJ8zJy13oNZ4shrZKVm2CyKxQUNrAhYnj1pPatZ/N4e8bbpaeb71Af8SRoRRrIEg7Y
 Ne2nNdIF06AGKePr9N5tqLjqZOraTMNaixkl+sucBXgj/odG9y8iE/ffTsPWpLLYo4bD
 6NPTu7+wchKaeyBZW06zClAT2jeGoXaxdxreVDSp+2q302LG74bS24FniNsVYrWie5E2
 8hxvlNjjT5MzF25sqiJJZItJf5YqUZ0RoBmCKcKTPpBWVc+exx+Fnja9SuL4Lmq2WkJJ
 oKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767048919; x=1767653719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoJDqo4LyDIhaY5T9JWwbUAyezya8j52K6GVubjeiVY=;
 b=l+xVny2BkDqBCn7MsHZncPpzf33/ylRp/wDdZ8NToF2i5wNgPIPjZaft5s3hD0knAH
 GmHe3dTjwFiynrfhm5xfec8YeIev4uifU8fqOlcugQkWCufBTMVwxr2ZKKzUmEWG8YQR
 cumVYKdYGM05iS0sWEYyvnLqGdBauZLSPVaq19d1tZYwlAwTrTq87DTaTpUnPQZtqn6A
 BYHgDdewTC/UAvcVgwIOSHOUhqWSY9+8N3xgPlrMdtxJEXCuL/Hk6I5cR11M6FUCqLL5
 pJoiZljZOnPe9d7+WGJdLyfP/nmFS/cp0hz2Suxix1p/E5WV+FFyGS/4jYEi5iB4/nk2
 fRuQ==
X-Gm-Message-State: AOJu0YxdaLjnCd4y6RfDVuEssx6B4wzzdNBA1I9z+r+R02shf/37YQ0J
 Wth0vxj6UdUnmdyj9UOpi1Fj9U59wA4eotcDi3JidzKTJFO3k4a8f7NZ7knud//3hY9jBDvMHMb
 XBsz6kqc=
X-Gm-Gg: AY/fxX7ja2Db6OTA9nb1jMBMr9/kpXSnSMMyhNSAMeMkwxy2FI6Aox3qu4QOcuUkRXX
 vyJQThtbQIQmnomu73QXumMPzsZ9gUvhv3/tbvSEgcbcePz2KffEQU26JFNBwT6S5cJ//hDX3aH
 TlIL1UhwJ+KGCnmoc+KWtw0D47UXZXOHW/KEpa0LjRwlZqQ4SIFuJKUDIax9SLaMUlCzIDNIHx6
 qojgHpcGIskaujPXbhyRj5POc+KZQpwXzByypCeBMA6QoWEg+S1NqwzlGCDV6teS7VQZb+2F0EU
 oNv05yEaHIur+6teIS3tsF89SyxwwTDl0IvEw5rXs3TutajB7SGg3tIstoIMgJip9zp4kB5fUkB
 ecmAtqZ48qvDdBXvKM8v/snbxSjLdJn+wyue9Yck77sknV3Y8OMDiLE/ixWbPdjBZk+rxemT1K2
 wCo0oA/aTw0DStcYuLGdE9kASPgY63cZrs8qYbBHlialr4/evBV8PUKbHSL+Yow0Ce8Jc4iks=
X-Google-Smtp-Source: AGHT+IGxO6bZhPL5pR7HKvfk3qPwzVDwKsggHhxQZODtIkYg/StY591adux1+WRIkhdCHApkBfIJGQ==
X-Received: by 2002:a05:600c:64c4:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-47d1959afedmr376075415e9.31.1767048919422; 
 Mon, 29 Dec 2025 14:55:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be274e407sm605067675e9.8.2025.12.29.14.55.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 14:55:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/5] target/hppa: Use explicit big-endian LD/ST API
Date: Mon, 29 Dec 2025 23:55:12 +0100
Message-ID: <20251229225517.45078-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Missing review: #2 and #3

Since v1:
- Rebased on commit 83202ca7227 (hppa-updates-qemu-v11-pull-request)

PA-RISC is big-endian. Use the explicit 'big'
endianness instead of the 'native' one.
Forbid further uses of legacy APIs.

tag: https://gitlab.com/philmd/qemu/-/tags/endian_hppa-v1
CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066

Philippe Mathieu-Daudé (5):
  target/hppa: Use big-endian variant of cpu_ld/st_data*()
  target/hppa: Remove unnecessary @cpu variable by using cpu_env()
  target/hppa: Use explicit big-endian LD/ST API
  target/hppa: Inline translator_ldl()
  configs/targets: Forbid HPPA to use legacy native endianness APIs

 configs/targets/hppa-linux-user.mak |  1 +
 configs/targets/hppa-softmmu.mak    |  1 +
 target/hppa/gdbstub.c               |  8 ++----
 target/hppa/int_helper.c            |  2 +-
 target/hppa/op_helper.c             | 44 ++++++++++++++---------------
 target/hppa/translate.c             |  3 +-
 6 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.52.0


