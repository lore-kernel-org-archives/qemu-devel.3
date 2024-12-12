Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CD1E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjtf-0003cD-9v; Thu, 12 Dec 2024 09:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjtc-0003bW-V6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:10:29 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLjtb-0002eK-1F
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:10:28 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so463222f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734012624; x=1734617424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6lYC8dWochLcUJNegfdM4xCIAMjFl1Jo4JV99TZ6P8=;
 b=XEFi39V11HB8hq5J9LgodN2kizRIzW4x6gYslEyECXEjlsbks+fCYnhhXxkCwKNyDn
 nDZQIBvCa0O8GsKGpT9sQNeali0MrxwfHEuIg9mtm4EMN4ZVAbMlYxl6bniiTXdAmQiR
 TEzSAVMm5t4G/7LnctXCf7KOtJgfHNukVkfWKVat491wihtG5kmKaMB/e/al8c0x/2gw
 bSY/086FGw6SqyaAkLjUMjL2GpfA2NZf2hu3zXpHFaIQUjTtSiWqYISy1O65Ws+Ty/IP
 pphWHF0zAC2PMLwNYltS22sj5pROt1WBUvpNoSDq6QwiSmtw5HtyYdW9vaKn73/4aArz
 vV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012624; x=1734617424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z6lYC8dWochLcUJNegfdM4xCIAMjFl1Jo4JV99TZ6P8=;
 b=Ie+iPohZZySoBv6WB7a063SdufDDiKJAc+QF3rfFfhPaUYIM/7lPERy66wSJRoLoCI
 84HILqzPchvfkiM6/pDNyhIM/ZfMejyMtwfm31AO1V3KV/MJA+OmVVj4dWt29jOgIomf
 00B53MNHASg5dGYSGENFi2/TKeFyHuqqsb18CmA50iq2K9m5Nd8VeQQMwRvQIWoInjpu
 XyMpxCUPC3KkyahBSIspAXIVuAtFq0HkusxkOXsdXsJNb+sO1fJZi5kk205XcXtihpy5
 MI0BZ7xW3II3G963fKcZQsVVfz2xlce00im9HR+trcwXnXVtFn44oTnLdvwf/6ZBZxJj
 hfhw==
X-Gm-Message-State: AOJu0YywysLel6rePy9476YlXjMp8oYPiLBc7mFZ8otKiGB4X8KAjUwb
 1oovkSg9aViJqGh+0+qZ476hL6Rz8NCGR3zlKkZWTqlorDrtsmKXDkpNo7T2RT6DEHil2Xxd5iA
 1
X-Gm-Gg: ASbGncsdha92hq2Gi6dyfA4oSTmmObLPX3uDgjuCh7gan45Bh4xnnKHEW3b0cNLHxoG
 OCnB/96aioLkP6r5zV/KsilAA+0W9MGFXDmER5+FrFDMnk/BF2d3LzNqxE3KhjY/uH6ebnNfZ8C
 EjLkE7wDHfJirNYxymhx1YL+EFcCb+chPrNv/wvwQST2jnrWMf3U0DDQbrAYqdzzBe1dNy9C38d
 wpD4NXaLihthCuHWbUWyOK7Kx1hAuGwCc+5Imi24AFnQ/wWGipsL0bbN7xL6UF9HwAB2otR5VTu
 ET3lzik8oCI4LP9UXYiYhwhYmyAyyek=
X-Google-Smtp-Source: AGHT+IFsA0QLrNiuOIE4UpylrjvoWGygdJAiisbjeBD9qT5hEAzJICOh5vlPbJ8Qe49m74jDzAhZ6g==
X-Received: by 2002:a5d:64cf:0:b0:386:3918:16cd with SMTP id
 ffacd0b85a97d-387877dcaafmr2725943f8f.59.1734012620165; 
 Thu, 12 Dec 2024 06:10:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625579464sm17794725e9.10.2024.12.12.06.10.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 06:10:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] qemu/atomic: Header cleanups
Date: Thu, 12 Dec 2024 15:10:15 +0100
Message-ID: <20241212141018.59428-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

- Include "qemu/atomic.h" in "qemu/atomic128.h"
- Use .h.inc suffix

Philippe Mathieu-Daudé (3):
  qemu/atomic: Rename atomic128-cas.h headers using .h.inc suffix
  qemu/atomic: Rename atomic128-ldst.h headers using .h.inc suffix
  qemu/atomic128: Include missing 'qemu/atomic.h' header

 host/include/aarch64/host/atomic128-cas.h                    | 2 +-
 include/qemu/atomic128.h                                     | 5 +++--
 .../aarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc}  | 0
 .../generic/host/{atomic128-cas.h => atomic128-cas.h.inc}    | 0
 .../generic/host/{atomic128-ldst.h => atomic128-ldst.h.inc}  | 0
 .../host/{atomic128-ldst.h => atomic128-ldst.h.inc}          | 0
 .../x86_64/host/{atomic128-ldst.h => atomic128-ldst.h.inc}   | 2 +-
 host/include/x86_64/host/load-extract-al16-al8.h.inc         | 2 +-
 8 files changed, 6 insertions(+), 5 deletions(-)
 rename host/include/aarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/generic/host/{atomic128-cas.h => atomic128-cas.h.inc} (100%)
 rename host/include/generic/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/loongarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/x86_64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (96%)

-- 
2.45.2


