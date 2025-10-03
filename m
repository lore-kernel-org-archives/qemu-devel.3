Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BADCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTd-0007KW-Pv; Thu, 02 Oct 2025 23:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTY-0007Gr-AC
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTI-0001Go-6X
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-78a9793aa09so2134243b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462111; x=1760066911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28Bk3riTrRllVyR4WtGi5USfALnDCz+z5kNXdk28Trc=;
 b=f4linJ1u2mZE5PXh/P820u1ng0X0dfWISEA/iTUV8tVxk3ImE/6a9Bn57Ug403dK3c
 B3cYiBw94wSkbkaEz4WzBf/gcl1rzxr214NE5+UityC2+dyCK17bSqqoWBo1iZ0E/XCG
 3Eyk65ZA0n0fDZgZ5y6ki4xpnB+nYHDp/KMYqCILXB7/VmYpD0Ntgs0Nya/aC1PutEks
 UE6OFRYr94a/apR4wcWha5AMaHYYJ9ZTk2FeMVDeKezNauRNb11IIThSkZzJBGsayClp
 MRbYsoPkbPsthmX3hg6e7spoMEEOjBdBMK4yItruG3JwZwi+TCNKR4xWvc0pHXCQ+Wq7
 ufEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462111; x=1760066911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=28Bk3riTrRllVyR4WtGi5USfALnDCz+z5kNXdk28Trc=;
 b=LayjYl+A0mTgyFNgmEwHVMYMhykdZ3k6KxFNCOqoGVfrXKyG3CNUqkWNxvN9yeapAg
 1YXqM9V6b1FGcZSqhLgl/hdeQ3nAVF0kFCi2WyNrDmJHZUXPEb2nz0cZNTyGyxkO8GiS
 L1f42JqYmK4uYAr0re/DHgKMttUuOdYIsgXsgpa2i13zwJAnHuKXGtpLBNlh8BZ4FUg/
 QN5efTcFykCGy6mnKMOdBevpLAu5EqYAS2j+x0MiQbfjj3Z+yRttKxh7nXdNFCzs1DEl
 pc0N69RySpSfwZshxPnNqGGMT0bKFv3RfpT4O4OO3Wq1V/eX+YMFSNJ+b1KRd26UWjBV
 2zZg==
X-Gm-Message-State: AOJu0YzoaogRxtfMGVb07R7FNAqpIF6SeGcYRB9dajUGyoneYf9jJ7ET
 qnTzUGGEOid2nu2g2Vb4iHwwquDGyrJV9dUiZ6ZRCmgSYX1x7CuAspS+ohI9GQ==
X-Gm-Gg: ASbGnctmz+yOxOLVIA0TykSoM3QFbyxwz5vPFvc7tgZg/DfEQL6kx8fEVV/8f6H86Bz
 dqPFJ/KIGP45q5B+doBAGK45Jo6Wt4V3jOozHRpdtD1G97znNwvIII0LYmGjMMuA18nG+0B67nK
 QvtKn582B7cUY7vv82ZPqduOrf6BFWFRns5yz5OASy4fD6apOcWmbFyOHqakOs57/IOyDYSMjUG
 HYRKcf9m8FYSrGvFSlngRaSnOcgAYMwuehu8Og9j1xfAoZGsdUqE94FIKQbpaelfOvkjaI6yzmh
 qCsH6S8NIJtUOHbLPnOJIJqeJ8mLRZQ+g0EZI4GH9iwOhc+C+WsgxlD0z5FxkLUeoFfwIfhKvCl
 CmqLukg06W3rIRwgccQxi1MHfaZc6bE1yJriKVvBh2iem7ufl9LNkuIQ6jkIgjDRT0fq4hu9FmM
 9ssdBhov7wLTqkPWXqpZ6hW2BXw7Us5COg9Qid1yrKDFTsSYDuIyBx
X-Google-Smtp-Source: AGHT+IFl2tO8kR55uu93lq74MhCmUVP4XpWAiPiLkndwg4CutGNsBQnh2HT9+bAHbIDy1jTLoWt/UA==
X-Received: by 2002:a05:6a20:4324:b0:307:a015:37ef with SMTP id
 adf61e73a8af0-32b61e549b6mr2350213637.20.1759462111184; 
 Thu, 02 Oct 2025 20:28:31 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Xuemei Liu <liu.xuemei1@zte.com.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/26] qemu/osdep: align memory allocations to 2M on RISC-V
Date: Fri,  3 Oct 2025 13:27:08 +1000
Message-ID: <20251003032718.1324734-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Similar to other architectures (e.g., x86_64, aarch64), utilizing THP on RISC-V
KVM requires 2MiB-aligned memory blocks.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20250924131803656Yqt9ZJKfevWkInaGppFdE@zte.com.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/qemu/osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1b38cb7e45..6de6c0c4e5 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -561,7 +561,7 @@ int madvise(char *, size_t, int);
 
 #if defined(__linux__) && \
     (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__) \
-     || defined(__powerpc64__))
+     || defined(__powerpc64__) || defined(__riscv))
    /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
       Valgrind does not support alignments larger than 1 MiB,
       therefore we need special code which handles running on Valgrind. */
-- 
2.51.0


