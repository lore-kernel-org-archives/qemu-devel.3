Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4392AC9830D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 00:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9XQo-0004of-97; Wed, 23 Sep 2026 20:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9XQV-0004eW-S1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 20:35:09 -0400
Received: from mail-pj2-x20.google.com ([2607:f8b0:4864:39::20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9XQT-0002Lu-RK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 20:35:03 -0400
Received: by mail-pj2-x20.google.com with SMTP id
 d9443c01a7336-2d91c22d27dso5993045ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790210100; x=1790814900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=axqAhD5m+QBTZyPZivJFhfKKQyxrbfvrpPcZAjLmpQA=;
 b=N6e8FBvz/dq3bDFTcDlNYyis41xpOIyRQQkgTBaGmC662cUwFZ0wbaZ4u7r4I1tRnT
 dzm+V2HcWQIp5lsFfPXfQrFWtsXUmtgedZ7nW31CoXjm1gHnInfFy3xv0H+ja0InuFBd
 Mhh/v3+sfqjcijiivN6J7j1rW1f2rN+z5yOcCRism159iebjf/+mqB+BzIumxhW/w7bJ
 xGhWzrEmQkkdMXAVQXAqWMO8MGZeUH2X5RW9zrt5b9y9JQjmVQbbiDEjOE3dbiTpWChs
 MkLlXUM5X79Fb0Pf2K2rW3UMi48CHUC67AIJhDU5OfmdZAzxBYlFasGV+jZx5HpltpL7
 E05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790210100; x=1790814900;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=axqAhD5m+QBTZyPZivJFhfKKQyxrbfvrpPcZAjLmpQA=;
 b=YX2K/Zx/f3+sL4yz4O+sPSr7u/NOel1+QBNTumpXnQAvhQ/OdTfem0YNdFZdMlNzWJ
 aNc9skmiUIDQesgGGTfbx8KBWxdahrE1hrrhkK/RmWHyxLUbu+SrY2rJ4b3VHbKlb/q+
 oyjT9CKjR0XHCAwYKxHRdtG8Jb6C9Tzrn/HFcRJRsM+y3AKW67UWCABM3IXZQzEYLBmP
 D6pWyiT8Ro/pgrwgeAtnkhJ2CLZt5pucS9NK6gO9/WItKSiZ+9fx7suwgy052D1l5fbU
 xPh7PU3uQviR2sTHC6tHBOGedrlqwZ9am3nsnmCbU11zGwRwcYh9U3qZzvoJKUfCNLBw
 zOuw==
X-Gm-Message-State: AFuF++mtY4a64YDN5l3Kj0TnIDV1qQ5vIb5B5IIkKDfTvqS6TVV0h4Q6
 5iXRKmT0Z1HSmS2vJ/ci0h1YiZeCqHgLmm2BTZ9nrFc4oc5EnLmchRoopUCRM52HKSMtGwbfodp
 dmCgW
X-Gm-Gg: AYBFou0KMiE5uBHNBnwDCLFa277Td7j0mTrYDiKr+AsgQ5bxC1zclsdRrCUz7hhkVwi
 xpwVct3A/rM9ih7B5MGbZCrpSGqoTA7LS7G45cYjcPxer7oBKfOiPknLPqp8/Pnc0RgPakCNC3J
 UjwGo7HadZwScxCaHnpcPr5o1CUmittZJ75tEgKIWQfnRyqvNYLOSfcZWnB44ui+ZH+E/CxfOFm
 mdFxafmbgQxZ4WM5/vWXGU1gfzBiEkVvAhqO7JBSAC7FEOdZwWcJpqZNlv530zjMHmQhJjYkSw4
 6QeEupesdhDl+OLdzj1mk4BTnwR1MT0mj63EPvp4xuv1jr6l0C4Syd3o9SSqxbj3R1HJCOGGbvn
 /IZ9a9IeKfx4DqGOC2BxMlddNIQkR8xzt5OMTBtDe60uA/fJ4v+LjZgsmif+xPZxonNLCHkph9S
 g6Rk8adHokNMZANj0aLr7QL+DZ++OIZwvRzEsxmIDSATak4nSuD9mtNEmGHkvzA0ib+LJHmOTh4
 rUU2Qzb8lpcl/RSMjXlx3pCVQb0fHow8mQbv/sF3g==
X-Received: by 2002:a17:903:244b:b0:2dd:c100:4b80 with SMTP id
 d9443c01a7336-2df7dd77203mr6586655ad.55.1790210099416; 
 Wed, 23 Sep 2026 17:34:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5c03b9sm17818105ad.31.2026.09.23.17.34.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 17:34:58 -0700 (PDT)
Message-ID: <48e19b68-2dbf-4567-96ee-2a3e723212c9@linaro.org>
Date: Wed, 23 Sep 2026 17:34:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] tcg patch queue 20260923
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260923203441.31276-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::20;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x20.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 13:34, Richard Henderson wrote:
> The following changes since commit 014b1f730c0faa08067f8e9b5829e62ea3d4b177:
> 
>    Merge tag 'pull-9p-20260923' ofhttps://github.com/cschoenebeck/qemu into staging (2026-09-23 07:36:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260923-v2
> 
> for you to fetch changes up to 666879d5477ec41ab46fc10a27d18cbc13e8789e:
> 
>    accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags (2026-09-23 13:28:00 -0700)
> 
> ----------------------------------------------------------------
> accel: Change AccelOpsClass.update_guest_debug to void
> accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
> accel/tcg: Skip the can_do_io stores in user-only builds
> accel/tcg: Allow cross-page goto_tb chaining in user-only builds
> accel/tcg: fold the dynamic cflags into CPUState::tcg_cflags
> accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for system plugins
> accel/tcg: Allow some address space wraparound during translation
> tcg/optimize: Fix fold_multiply2 vs 1
> tcg/optimize: Fix expansion/simplification of deposit
> tcg/x86_64: Use the mulx insn from the bmi2 isa
> tcg/riscv64: Set vtype before whole-register vector loads

Applied, thanks.

r~

