Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EDFCCD185
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 07:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6P28-0002U0-2B; Wed, 08 Oct 2025 03:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P26-0002Tp-DP
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6P24-0004pA-NQ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 03:56:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso60895855e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759910179; x=1760514979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6xYsvCSK4rbEWmr9hp03tz8RUCvGH9H+ecrsoWlrsU=;
 b=jre/f0QigrGiUSKfJVAyvs1Ru7L2XdDvhUfuZ/Ufq5VKAVFnupesDCn0Uq66zHnp0M
 P2+gn6JSZ3BHxerb2sCEWQmMjfKu3XUaAdT0KxS4BCTDDiqWNbbTS3hiReQ3TwXksvk5
 xhLZaTkteYyAZnGxEwGgfexnYmrNIT0DEX5QhlRZXx/SZ7koIIsLUoJ5WA2aqkRryM3Q
 0L8rvBaCfWHjM3JkcsAIEuf3YRPGjhvSPLREAmaJU9+U9fiK04jAG4sJ0/eeah6SkykF
 nkszaYqaB5hOU+skguKfmew1u6JCF0aVWzp6UU9006yhCnNMmq9QuMuVe529ESpIbdSI
 h3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759910179; x=1760514979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6xYsvCSK4rbEWmr9hp03tz8RUCvGH9H+ecrsoWlrsU=;
 b=YaE0RkJVDpa+Gg0P/L19AA0WqdF6o96mPJFd6HYJwb9gAXpKhUT0oZGGgug5w8Bv1X
 nPxH9SQ5MluVdh8SK95UDq3UqTX03l4CQR5X+gma2VgNWba9blQNNN1lINSjV0O9F4n6
 8k/330eHTjzGH2wHRz5Du1RQVrjkjF6PEiuVoEYmsQznlFyS0Ggp+P2wuaR4xjqcYmwe
 88IUHdehmL+koQeepfH/pMT+e+DNnMc6z+KDV2UL9CwimSPsQ2UGff44T0mpWTs1Nlg8
 FHIv0uAIAVjeVqtNQKhvN3PUBLhCHaQZIVy6WHNX/b42QYocLb7SWL5p5OiL0VVnBrYg
 mJ+w==
X-Gm-Message-State: AOJu0YyKkQ1u792/6JhrQ3SZaMvtmXVBBEr1kbDmE85mR575U3uBJ2dk
 TsQJq/0cIzvaNl4PSV98RiRnxQD6o6byWbfF+Ke0oVjOpHoG20XiiT7Nt6dInpnTOgW9eoCDB7s
 TyAC+Wp1jFQ==
X-Gm-Gg: ASbGncvE/4JlHe0LrksQFVezhCbur6T3gC+VYpZGzW4HQ/FjNlJJdykfdTVBbqfJ25g
 RPiHDlXZheVHslu+UWN7U1B5fImd9aflFK4n6WNzZOdN8VZISKD4ugfUyIVBnfnwQWGw+BrteO9
 pdaoMNxUe6W4U0+XKC0j3AcnWzVci0PVip+kHQPZOPHVe1Nx70mfqmkzbcE5H9gRIXQNsOkF/6V
 Dkp9Eh7p0uOWBo95IAeb29tWifuWCnA9mdhtZJwNOY2cJvaHkojnNPe3WCruCP4BiUFr5Qo6a6B
 GA+6VdP5/ufdfcB/jxz7GcsfHX79BnawryTkPtmL2muru0Pp/7JDLuEHg8oDkp3rMFo5uUz7Owy
 Sp1a662aCsjFj40c68sTp661oWVn817TJhE8AYFqAd4Pwhl4k0SWQcU2H9K3hvyGU9KLVYbMO9R
 l+OFMaD1yWNINZSz+M+VmIS1L6
X-Google-Smtp-Source: AGHT+IHFmv8O2mODM6hQbh49ArPearUKPG+HxOsPB3GYoKwKpoHmcMtrBkoklfvx3+7ttc6hFJmobg==
X-Received: by 2002:a05:600c:6487:b0:46e:4783:1a7a with SMTP id
 5b1f17b1804b1-46fa9a8f37emr16035395e9.3.1759910178677; 
 Wed, 08 Oct 2025 00:56:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9d6fd3esm25102915e9.18.2025.10.08.00.56.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 00:56:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] target/openrisc: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT32()
Date: Wed,  8 Oct 2025 09:56:05 +0200
Message-ID: <20251008075612.94193-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008075612.94193-1-philmd@linaro.org>
References: <20251008075612.94193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Both OpenRISCTLBEntry fields are of uint32_t type. Use the
appropriate VMSTATE_UINT32() macro.

There is no functional change (the migration stream is not
modified), because the OpenRISC targets are only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/or1k-*
  configs/targets/or1k-linux-user.mak:5:TARGET_LONG_BITS=32
  configs/targets/or1k-softmmu.mak:5:TARGET_LONG_BITS=32

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/openrisc/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 081c706d02c..fa054e528bd 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -26,8 +26,8 @@ static const VMStateDescription vmstate_tlb_entry = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
-        VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(mr, OpenRISCTLBEntry),
+        VMSTATE_UINT32(tr, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.51.0


