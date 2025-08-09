Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D71EC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uktCk-0005hP-UE; Sat, 09 Aug 2025 19:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uktCh-0005gh-Rp
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:42:23 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uktCg-0005ga-81
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:42:23 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-707365f4d47so33657046d6.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754782940; x=1755387740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=sfVuGac2CDyxX83RG/Zy/sSiKRv5/J7fUNEQNl9HtMM=;
 b=hAd7Vfj/pKSAT0Jtfa2S1xpzdkcmZjDwZrrgw0QDS4c+ca2L90yCkQyVj3MkGqfU7U
 OYlhY+w2qGamggdWYWp6kTjsSqKMNsKBb7zZcS5hq0RbQf0A6kzZPJaHIVGiXE3IR7d/
 qyBC4Zo+uTmHQRilJYwM+6Pe475tolkIaCGy6pjVS/DFNFhg5gYrux1qrZ2A+wLOAJcs
 IO6cVF9JVPotfByHb3JuVa6FaOGvdA46+LKHbvn3LGjG70BiaZZxKkkL26SHBSaqpFfB
 ax2JlzVr5+ok2Tw7zL5nbEGg0lexpWjGcNJc1eJ09HkP48BtsLjBpZFiA/QUAzSo5lR1
 Bq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754782940; x=1755387740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfVuGac2CDyxX83RG/Zy/sSiKRv5/J7fUNEQNl9HtMM=;
 b=NyAxkpaQIRt7yrCwiYTmbtjfBm3fwUPSxr9quOqSStY6R2jRTAuNAXnfPYL/DDyjR2
 xtLAOp+s4HO/nxb66/GP7cbWnqu+mHfzsVIvTDD44h6eyq5R7jovOxDj6hoQx0VgbYP6
 p9SJgA9LR00TdmDrvuT89tgKvJ9gV9aJg4FgRTs/FZGmys85FPE3u/fFAuZGCeo/gbH4
 V7N1QEUJqI+7RYK1Fi4N7wqsBEfVJyeCqpLot81FER35UGu6XjGuL/Ty5IOkzlVFMmUS
 1qP7JgtRXTk3u+RnEGpntSWzlfaNsONZnR/DfYjKsXW5ELqgaOOX+E0zbpLhcL6WuEoP
 xL0g==
X-Gm-Message-State: AOJu0YzJSuyTUMNB9jETKNd4NwT19JQYzB+3xTLUtfGZzykxij5GSrAy
 3ba4ABGsprkrHnYwX2mjzjei19PImMGBSpt1g83BIKgRvZDcJbWVLSvqqGtt3rrzHFjz5UOruhB
 7sgTN
X-Gm-Gg: ASbGncu65vkkMyNmG81xyQwArR8xrtKU170zIRtsOlOfKW+KFjR/0iLC40WbU5YNXO2
 Cn+WaY7SzDyqVSCN3Kt6uFRbeED0ox7+cTz4yL0qPseuXZCO/72OYuCdAxRU3EjGEtYWHZT5hyC
 +YhrUy8qpY4wAeUWEWjyBWVngiECQUkb9l05hpsg4qgBW1sxIlhcvoa+5ZszW4OXeEIgdQYFX4X
 XgTcypriWpfxZkl8cBlaQpPRynbA9nfkv5tdkEdZDaoCO8X9Fv3LVfXQo+Xn33gIWfPmXVesjsN
 Qr1VSUIynL3fNiyunad4njcixCT3AmswD1WGNH2iw2SYAp2UAUGC4y4lyNumwrF5QVxojylzy+H
 EMg3Kxc7R/aeBK6Zz52weKAPW8ATRIqVCkyHh2CJHRMjdwj7upPtLumftTce5K83cqrJB9po27u
 8t8gCD
X-Google-Smtp-Source: AGHT+IEo/aVksE/m5+/fCDYCwg+UVdb5RO91JXVYR7hGYD2r4av09HtuAn5lNJLWDSqU2HGbm2Pe1Q==
X-Received: by 2002:a05:6214:4104:b0:704:7dfa:3fd with SMTP id
 6a1803df08f44-7099b909ce7mr99612556d6.4.1754782939837; 
 Sat, 09 Aug 2025 16:42:19 -0700 (PDT)
Received: from stoup.. ([172.58.166.125]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077cd56226sm132135636d6.44.2025.08.09.16.42.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Aug 2025 16:42:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] tcg/i386: Improve 8-bit shifts with VGF2P8AFFINEQB
Date: Sun, 10 Aug 2025 09:42:05 +1000
Message-ID: <20250809234208.12158-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
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

x86 doesn't directly support 8-bit vector shifts, so we have
some 2 to 5 insn expansions.  With VGF2P8AFFINEQB, we can do
it in 1 insn, plus a (possibly shared) constant load.


r~


Richard Henderson (3):
  cpuinfo/i386: Detect GFNI as an AVX extension
  tcg/i386: Add INDEX_op_x86_vgf2p8affineqb_vec
  tcg/i386: Use vgf2p8affineqb for MO_8 vector shifts

 host/include/i386/host/cpuinfo.h |  1 +
 include/qemu/cpuid.h             |  3 ++
 util/cpuinfo-i386.c              |  1 +
 tcg/i386/tcg-target-opc.h.inc    |  1 +
 tcg/i386/tcg-target.c.inc        | 81 ++++++++++++++++++++++++++++++--
 5 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.43.0


