Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBAFC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kri-0005o8-CL; Wed, 23 Apr 2025 20:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015Z-TZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqE-0004jd-Pi
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:28 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so304564b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456004; x=1746060804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJajZrSf8/i/8ZotN5EXGfyCyGYwpY5Ucs7xI6zZ2dk=;
 b=rkumZSy7tMX3PUlp6NZy9RYDVsAwvfbJhcoJ6AzeyD+LqyGL3Sg4Re6GDcjaMJB5cA
 l6QXLAfBtmgeHOZ0PqEDwdzpjMg+xKi3GLwQ3HiQNFlNigqy9iOnkaz4KtLq6jsEUww+
 jOiDtPB9eFX+U8OJxbLy0tHp3IxaKZ82kdFid2dscoYZO72tOXQQ3oZWNPF587cx1Ohc
 MxCvIY5CUeKZCkh35i7lyCoucRoksOHKCdoxpgyuOGdLelQ80oCHTCZQ4OQ+ddQcOx64
 apXsP6kjbWk4LWoLIoTjrhDHLqU8xiZTZaHjeF+okORO2ajsgDrjj/5ZOOSVW809XWOD
 A2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456004; x=1746060804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJajZrSf8/i/8ZotN5EXGfyCyGYwpY5Ucs7xI6zZ2dk=;
 b=DZh3Hp7aWGakOaPkS4YUMx9EcpcEUPNBhQXxYaK1lScEGeh/Bdq7OauUw1iTwHfKRH
 BqQ0LS3s68v60VroD5gS6LQJRkXJgJBdr/EHqD1ir3l3AkQ0lP4IoQyqstQjgPVwPH/m
 nAnu/j8I7glNwvLC6mcZimwjnSaNEgU70KYKAWBgLPINg8cqq5fkoCAbVEcnaHWIarBT
 2fuMvbQ1X/H2pdBL5s79NCdQHbZ1b1ti7qAiVOTmhIkNewKGJfHByAAa6HQ0ov2Dbc+j
 8Bak4g7e9UtICj1/xdLoFCQIhkuWaBqOTKHMkQnFOAdrGBXq58tehmGjoL5fXImVuHZI
 ofTA==
X-Gm-Message-State: AOJu0Yzbfzud/H01skRvF+Q3K/RtP3oNPIo56ATJELjpeTBsYYgeHiPR
 O5q10LFzx7RH7YBYOvOtLOLW6Gsc4BEht3G8iycBH4XTpStwaWqVawbHdvzCfnh5mZ+YBrWuP4f
 n
X-Gm-Gg: ASbGncuBAaDfWRhggaH6FPwDQiGoVyPJ+dHQGOqNnpbMjzuxcJU7X59ySuzNCqGZe7Z
 sfC2Mz4LhCoFqfgtvKiGvw9It27qYGPPET0/8sm0JqMO6fudJKdFCALctKTCqB9f3irc+IE9aMc
 cKkn+ZtG1WsnmZfKlg75E/AFS/0VW7C3L7nDGlMFB/grdibawUrR1gQOESZjoouJocZvtQYoMso
 0v1EwMGbtEtO/kJcwh8HoPcmrnbXKarXcRc1CxI8utkxCFf1pArB2NEhiQiQmu8wXBpMFP/QWYg
 GbS6weJqpMgwDKjTHzwSMGU2EQRorSVPcWzIdcw9sPcTmp+U0tXw3odL9kh/Bivi5JoZBM435X4
 =
X-Google-Smtp-Source: AGHT+IHJOnbO4msPmWcyIumD8YtMBX29Dmb39+6o/DrL3c0RAnOgdPsLCE0o6k4FEjWmFe6fB3Aa8Q==
X-Received: by 2002:a05:6a00:3cc4:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-73e2461c8a7mr1224827b3a.8.1745456004476; 
 Wed, 23 Apr 2025 17:53:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 065/148] accel/tcg: Rebuild full flags in
 tlb_reset_dirty_range_locked
Date: Wed, 23 Apr 2025 17:48:10 -0700
Message-ID: <20250424004934.598783-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Undo the split between inline and slow flags before masking.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5df98d93d0..28c47d4872 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -886,9 +886,10 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntryFull *full, CPUTLBEntry *ent
                                          uintptr_t start, uintptr_t length)
 {
     const uintptr_t addr = ent->addr_write;
+    int flags = addr | full->slow_flags[MMU_DATA_STORE];
 
-    if ((addr & (TLB_INVALID_MASK | TLB_MMIO |
-                 TLB_DISCARD_WRITE | TLB_NOTDIRTY)) == 0) {
+    flags &= TLB_INVALID_MASK | TLB_MMIO | TLB_DISCARD_WRITE | TLB_NOTDIRTY;
+    if (flags == 0) {
         uintptr_t host = (addr & TARGET_PAGE_MASK) + ent->addend;
         if ((host - start) < length) {
             qatomic_set(&ent->addr_write, addr | TLB_NOTDIRTY);
-- 
2.43.0


