Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF586CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 10:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu77s-00005q-7H; Thu, 04 Sep 2025 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu77l-0008W1-Qb
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:23:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uu77f-0005Pc-1K
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 06:23:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45cb6428c46so6544915e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756981394; x=1757586194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8WQ7LUh1A1KBG9tydBdEOxJ8dvprRw5xXuBpuRm8H6I=;
 b=qs3fC/GytVjqKJC5mpCN+3izQyKW2KXg5lv1xpsyaitfKRl/Ng7Q5KdGiPm53gGWel
 yBG2/BTuyZanHZoyD/dLCemMTZR+t1/o6cjPj5nQbZkpGNL7dK66jGU/TTqePQ/NIFl4
 AFrI3hGTF40IEiNuJUfO5nwND0EAsCmjVLT9T2G20ZCGaaM7Squ1rxZq4rVHYRSX0jRx
 MwxNt5JxRfLjBR1YB44I5lPKnFqVIT6RvFUoLPjHgt1e/6J8MJ4/yRcPqn97AHL0rrB8
 xFBI2/4Zv/0AQ7rqdOwyvWwV3tl1GU1+7rI3nmyrxgzoYpMlOombnE1xpfJ8B3bNwx6Z
 7tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756981394; x=1757586194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8WQ7LUh1A1KBG9tydBdEOxJ8dvprRw5xXuBpuRm8H6I=;
 b=chO0IOLCToD4jMyv57rCaeUfBtIQ68U4ytPmWpbtCOqVc2qQuowVg1pm4huaV8cGHH
 6wiXNplgm/7tcUrWo8zjinkX0L3IbdqwV+7K0hO2IdNPTHM7oq/SCGMLUtd2ibffUzX1
 7LF/enAaIEFsBL+06gn/vF0rKD9TIpIxEf9STCQav+zkO1WbejJt8OqtZLmF9y2CubMR
 /p0JjyCHLHfGe5gnoSIgugUG/x0vgbqJ+ZEw6Rjpeyq2TheR+rLZwFg5fXyHJrutfXB+
 Tv6QxXu+lIckf0nNBuS7cxQHRaVNixT33Qir+jDjusjh78oxceq4rzaybmf2Nms5hhwr
 +PhA==
X-Gm-Message-State: AOJu0YwJpZH2CHOBgukJ2BvFRbYhV8tBlVyQcDENv81NeqL/Axt07f5J
 TtaL7s2b2Z1jL12ebh7/SeOkFAfBCqlhd1b4Pl/vaX+7XivpIfP0gR7b7NpUOlJWiKBpVP6L1W0
 5OW0dJAk=
X-Gm-Gg: ASbGncurCl1irsZ7+723lOgeF4kmE9wbojXjLJva/SM+7JHlugZszGN6e1JLAiWd80k
 qjQdGopn7tOE1Idc5n7XyflPohoL2ZKCXKU0nuw9RljXVO/RMyyfqmTH1HE8pkREx0/gzmYlWxj
 oylZnwCCdTMCIsmScEKsZ8dBp7+bIBjzaKENkk0Q5+ndUhDxgU04mrHZDxBLPZkfp/C1nf2H2Bt
 o4hn4lrIUD4koNbFtUTflOTHqUyZ+Z8zOwlHHpB+EEDzwTVgi/6QsKS1hb03QEIVjNfAbI1YsO/
 0rQmNbiImbHrqAfXHGPm17w0KNFbmXJoSVrCoA5oF2x9rvhpPySl67kZ3Z7ScSHr6UOCeK/1sfn
 Uk/WJhWA3jyLCM1lI6BUY+/642yV+WvmMDSLa8peJai0MhmLtJGOfm6JQh8tSXzDOADU=
X-Google-Smtp-Source: AGHT+IFoXLkryOlq0QpiLfLcj5zpbQEEeO1Xso9OxwoDePLG+OK4Yagln/wU/oWnIx42eH1N8FZWbA==
X-Received: by 2002:a05:600c:548b:b0:459:d8c2:80b2 with SMTP id
 5b1f17b1804b1-45b85526618mr152606545e9.7.1756981394165; 
 Thu, 04 Sep 2025 03:23:14 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm147699195e9.19.2025.09.04.03.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 03:23:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: floss@arusekk.pl
Subject: [PATCH v4 0/4] linux-user: Add syscall dispatch support
Date: Thu,  4 Sep 2025 12:23:06 +0200
Message-ID: <20250904102311.57383-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hiya,

I have adjusted the signal return trampoline detection from

  https://lore.kernel.org/qemu-devel/20250711225226.14652-1-floss@arusekk.pl/

and tidied up a few other bits.  Would you please re-test this
versus your plan9 emulator?  Thanks,


r~


Arusekk (1):
  linux-user: Add syscall dispatch support

Richard Henderson (3):
  linux-user: Create vdso_sigreturn_region_{start,end}
  linux-user: Populate sigreturn_region_{start,end} in all vdso.S
  linux-user: Populate vdso_sigreturn_region_{start,end} from sigtramp
    page

 linux-user/loader.h            |   2 +
 linux-user/qemu.h              |   5 +++
 linux-user/signal-common.h     |   7 +++
 linux-user/syscall_defs.h      |   6 +++
 linux-user/elfload.c           |   7 +++
 linux-user/gen-vdso.c          |   6 +++
 linux-user/main.c              |   2 +
 linux-user/signal.c            |   2 +
 linux-user/syscall.c           |  76 ++++++++++++++++++++++++++++++++-
 linux-user/aarch64/vdso-be.so  | Bin 3224 -> 3320 bytes
 linux-user/aarch64/vdso-le.so  | Bin 3224 -> 3320 bytes
 linux-user/aarch64/vdso.S      |   2 +
 linux-user/arm/vdso-be32.so    | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso-be8.so     | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso-le.so      | Bin 2648 -> 2724 bytes
 linux-user/arm/vdso.S          |   2 +
 linux-user/gen-vdso-elfn.c.inc |   7 ++-
 linux-user/hppa/vdso.S         |   2 +
 linux-user/hppa/vdso.so        | Bin 2104 -> 2224 bytes
 linux-user/i386/vdso.S         |   2 +
 linux-user/i386/vdso.so        | Bin 2672 -> 2792 bytes
 linux-user/loongarch64/vdso.S  |   2 +
 linux-user/loongarch64/vdso.so | Bin 3560 -> 3712 bytes
 linux-user/ppc/vdso-32.so      | Bin 3020 -> 3140 bytes
 linux-user/ppc/vdso-64.so      | Bin 3896 -> 4048 bytes
 linux-user/ppc/vdso-64le.so    | Bin 3896 -> 4048 bytes
 linux-user/ppc/vdso.S          |   2 +
 linux-user/riscv/vdso-32.so    | Bin 2980 -> 3124 bytes
 linux-user/riscv/vdso-64.so    | Bin 3944 -> 4104 bytes
 linux-user/riscv/vdso.S        |   2 +
 linux-user/s390x/vdso.S        |   2 +
 linux-user/s390x/vdso.so       | Bin 3464 -> 3616 bytes
 32 files changed, 133 insertions(+), 3 deletions(-)

-- 
2.43.0


