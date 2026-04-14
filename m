Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E3F9D0F8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 21:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wClLy-0000Na-GX; Tue, 14 Apr 2026 17:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wClLo-0000Mk-8T
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 17:31:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wClLm-0003EX-Ao
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 17:31:16 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so42260635e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776202271; x=1776807071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LcDTu61/dPflOUCj5XRh3FAfwI549tA4VkhqrHnBI08=;
 b=EcQXj5qkyAL6bLrHKkUTtsy0WPTclfCCSa+VMMkyweRLjgIwUlU0Ipf8mpkHn0W4+w
 TvGIicDa2IJTd8IBUnxxFOn9C6wtdcxXmqO5eDm1Dc8Q38tXEcmhm5IUIlCWueZ8a8fU
 0wrmQD3KsuHN19+m3aKlkGmRPvLnDAteHlgtAo+Qb1t3MpuXAoYSvH5rlz1U5S2asDvD
 +/S1IGVvt7lxgTgGLD6qqhHVnE+TYeWgZHiuBJ8VGJCZO5ZkTYnC0BZQX7+e0uMYtXat
 lAgWpXpBTMU0hRq1m4k+LNtOYkvRm4pmEV6z/XqVAxMb3aSyuiVnHRUiwZFOrTKMj1X7
 zxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776202271; x=1776807071;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LcDTu61/dPflOUCj5XRh3FAfwI549tA4VkhqrHnBI08=;
 b=VaAh5tbr8xxrzdyB1c3yqvRK/O8J/FoMol+8rquROvlua8Dw/BR3jybYw4e9RZvd1G
 Wgok+WcrqQ30fthesD6AI2takEpwSOJevKcZ+z0/8+BsHVkgZk6n8mGyi4lmSxOx5Eeq
 61k3BjsBs7BiiM72V/2miE4oBkxwaMDXkJtfFPj14QKrh8HtCCTvuiXhNhS3v5jhzejc
 dWbSJhEJUuV2LDojeFllzHzzoTQqa3ekvMut401bo2Q1PWXYhCEvLeRf0OhXdcTAKU3+
 Fg4PkiP6LVE5XAL9cwgm/29h4FiWP1YC9GGVE9vWoRGRp/8Qk7Sjr9+UftUpkFmHbrPt
 Jpqw==
X-Gm-Message-State: AOJu0YzvNvJzkEf60tuFa4ntbKEc3f6SJXcHILnBp1LDkq/P2zaT21kr
 LryZ1yihndOalcXXe5GsNOMj+iVswRloKHVYgLrMPDTJv03paTpeKdx+S1NVK2l3bZN0yvhDG/4
 gYNEGIDU=
X-Gm-Gg: AeBDietqlFtt7Ld+rHUBrsfdOai/0LnviINHL1JU066ArduaH+7V0rJ4xqVUuHhbE75
 TvFsjbfYUMT+3d7PmQsfxGnbS8gWwzxzv1urI1KY+lwvlZ8YHKnpX5beKu7rCwQjh4mVu604H+y
 FMUUS6Z4LmYLb7GVVqCbOk7t0+Zxb2pkYl/qI8DKbD5aZC4llin0MYTV65KqelfBXtOdBbWEu8r
 CPEkrKShGhiJdbKuZBYYItZwKgYdMrFeAeiBilZP49Nex4th4Wde+V0gdCRJTgF2cgn30NeGd2R
 c6ArosREpE9saJ+flWJ4+oxDLdvmmslyYXtZCBHaidmcDMryJCvb78JMHFZ+q/nqFMaJ0LTqPId
 wjBUGclNzg8D2xY5MY09lCD0Z/9v8w0/HiZCdWM1EPAqdKk4HMUDybkmkOdrUU0LYWgZ5flVIfl
 0k+HZmZbbFRiPH/NTZVrot4yw3Jl1pZv2+hIIsgtOOdbnfTG75EF2PMks8b6HyMU0LQtjlJB1y
X-Received: by 2002:a05:600c:4ecf:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-488d68685aemr273070095e9.13.1776202271017; 
 Tue, 14 Apr 2026 14:31:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7400708dsm26083117f8f.25.2026.04.14.14.31.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Apr 2026 14:31:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v4 0/2] target/mips: Translate MSA vector load/store
 opcodes
Date: Tue, 14 Apr 2026 23:31:06 +0200
Message-ID: <20260414213108.66786-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Richard,

I tried to implement your suggestion from v3 [*]. Unfortunately
the box where I had the MSA test suite got erased, so it will
take me some time to restore the setup. I was surprised these
patches pass our CI tests so I added a pair of abort() which
didn't fire, so this code path isn't tested at all there.
Anyhow, do you mind having a quick look to see this is going
in the right direction?

Thanks!

Phil.

[*] https://lore.kernel.org/qemu-devel/2680c481-088b-4366-abc3-7d48d90db0b5@linaro.org/

Philippe Mathieu-Daudé (2):
  target/mips: Translate MSA vector load opcode (LD.df)
  target/mips: Translate MSA vector store opcode (ST.df)

 target/mips/tcg/msa_helper.h.inc |   9 --
 target/mips/tcg/msa_helper.c     | 173 -------------------------------
 target/mips/tcg/msa_translate.c  |  96 ++++++++++++++---
 3 files changed, 84 insertions(+), 194 deletions(-)

-- 
2.53.0


