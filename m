Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45975C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuD61-0003Ua-NF; Mon, 17 Mar 2025 12:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuD5s-0003TC-Bk
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:13:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuD5q-0003g3-15
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:13:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso23033285e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228011; x=1742832811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rb3LS0vNPhnknUl9Yi62tIxsFcdNc1tr/8ma9EHvQ3I=;
 b=huKSqmZKlXs6B74KC9QMzmNbsgHvQSgk/odIDpeZ41qp1gaXO+O2OaIoMEBeU8nY4X
 f6g2AY8O6YSSbMYEAtgbIO8eToLaF6dxUqQhysaW8Ocq15rVfwkRgn//QbdduntdGbFn
 NnxoBEWU4qVkvotB+uuQ3eSmE284VNvPac//jYBEbkanHn99HvuB/R2DLxSjwazCGT3U
 UycvjJ9lWWBFjtSApOg2avwzQ4fZGBnbvy/J79Jad9UUUzLN7EaLQAbTPtTJI0A+g9Pb
 3eBWszZND3NWHTcmD3rTXTDY7U1cdCpD5wpYrDClMXT5kbFQVxM1mwH1tHa1tYMxaOCx
 RTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228011; x=1742832811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rb3LS0vNPhnknUl9Yi62tIxsFcdNc1tr/8ma9EHvQ3I=;
 b=PiXdmH80VVb6+phq2Dr9utac2cxoHa5IzQiONoF8y47389Z1q/nhsG4M9I5lNRqLuX
 AKCkqIqj4BWNQutv+s9GMcvh7ftpH6cu5naWvIPPoaYm0GN0z6ZWYHcX1xlFgY4oydSG
 rmVW8iZCOkpsKiT/WhqcT/tLQGXV7Vg3wwu5hNIwx9Gn3YWpez/t5C4hmC0etmtiIuLR
 /NB7qFqRRGG96ytOfxJC613eU51Bj2RgQEx43o4fvVqImbXoX9UNOS6iiVyllXTTuVNe
 kAgdh7c6lBnuI/ZLn8c95FpTOPZmcuL+QZZepiuZohKgWLcrxa7npmdEElCh9nv0zunN
 pWMQ==
X-Gm-Message-State: AOJu0YyATFN+Uiz/5Rs1I41N9+JbxDdckU++v1g8VytGpHrACXqXC5WB
 kMinzENgojXqBMR+S/NH14UZDD+sPzXe6sIKdSgHSiGOHf82k6tcvMVXGMJDVFczUnchomLMGX9
 R
X-Gm-Gg: ASbGncvyWI/DFoPu8WDzFoiS+6FOomyZT7EgwEK/s5FPHEgwbmNrcc+eNui6Rl/oRWD
 Vou/bdkifGj+ObHYGn5O0jQpimLRRnzLkKlP7LMZp9tqAKJ6GzWBT9YylhxOuN32K48eJLchj7D
 jKD7wXl4A7LJfoh6/AWTrn9RcucBk/VUELFSr0o2H20kbGYGIGkwwQw+g217Ete9gJzbbyonupY
 7XcUuma8niozwTNkI5V1Rt3UJLBh1zMgty91zZo9wFWb8wrcSV5tJXpsxW8/8rd2Lqk/FLq0MnD
 8HLYCNV0Rf9Fj5HQUpeyL46hTkqw6OIZgV5XbEBrakGQAmy+lW6y3IO0i8x/NppH047mVTjhk1w
 i74a7S3g1MxKtWiwXv/c=
X-Google-Smtp-Source: AGHT+IEp94Iit9UOvxjGsdLbkpAxIV3w2OsjsSQBDGC1Te7+SAoNykoO+bbm885p9kpf9o6KO7iKXw==
X-Received: by 2002:a5d:6da7:0:b0:391:2e31:c7e5 with SMTP id
 ffacd0b85a97d-3971dce07d6mr11729466f8f.6.1742228010978; 
 Mon, 17 Mar 2025 09:13:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm15273358f8f.82.2025.03.17.09.13.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Mar 2025 09:13:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] exec: Restrict memory-internal.h to system/
Date: Mon, 17 Mar 2025 17:13:27 +0100
Message-ID: <20250317161329.40300-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Only file units within the system/ directory need access to
"memory-internal.h". Move it to system/ to restrict its scope.

Based-on: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>

Philippe Mathieu-Daudé (2):
  accel/tcg: Remove unnecesary inclusion of memory-internal.h in
    cputlb.c
  exec: Restrict memory-internal.h to system/

 MAINTAINERS                                | 2 +-
 {include/exec => system}/memory-internal.h | 6 ------
 accel/tcg/cputlb.c                         | 1 -
 system/memory.c                            | 3 ++-
 system/physmem.c                           | 3 ++-
 5 files changed, 5 insertions(+), 10 deletions(-)
 rename {include/exec => system}/memory-internal.h (88%)

-- 
2.47.1


