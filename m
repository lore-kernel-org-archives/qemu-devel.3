Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD2EE208E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJpE-0004rX-E0; Fri, 06 Feb 2026 06:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1voJp9-0004r0-M4
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:16:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1voJp7-0006nY-4p
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:16:31 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48068127f00so18885635e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770376586; x=1770981386; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pzn5Tsk0JyZx8knQaGoq3pk04RWwGqrEIOwN+7HOX0U=;
 b=OERIQjNoZZ1fAdHtbnPw35ncW6yRowivDt7/rls4waxgcIDOmIKLqzIGFDJ/Me0XL/
 5jHRz45cNwY6rw5a24uzVYhmkG8t00cq0n7MKW/wE5dy4OUMiCto4xlJ1goC0gnb3uOS
 GK/RcwZxIuweb0Ju4B3QIiHzi/tEd1DdE7GSxRVwSFI8lcZjEnXu2Ga9PXbEUis8zfcK
 cFT1O8vFETFnq6vgZUa/d2f9yo0oRvYt6UlVONlVMqQaSgVP5jxzFcWckNJewG+8+qw0
 7fGa+eQ4vI/hLQToZx4mbV4S0MOvq+vLqf56te0SAIVz67+v1q3kVfLvoCBUnTHCAkfF
 dqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770376586; x=1770981386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pzn5Tsk0JyZx8knQaGoq3pk04RWwGqrEIOwN+7HOX0U=;
 b=jTyN8Y1Zr2UbunmZ9U0BzcP292ap9jJz4SLD7UJrDJC0W5phDqBeecPtKMXBZYGqqA
 Y3SxNPm2XCWDFtpXtwdiGhQBdVsnAC03a0M9ST41S13EGTa8zgMErkQvhwp9n1ae8QxU
 h7SxqW36Po0TakJdKRc4Bues6ewi3VwI7Sb5G4p2cPRq4Vb5hSz8KePA9E8dm0P3xHCN
 ovTVNJfdIqcILbgYN5g2PW+lUlb2iHrqLseyF2JSgV6FtypXIUijKYqeXnIDtOIUJwzD
 4DKFNtPPDxLmautxAiIlpyrBqe0hMrhLd5TEhbqaIqntk2z/QSjRQwF+jX2cq1B7Umwv
 OH3Q==
X-Gm-Message-State: AOJu0Yz3OOqDEmRv1+EsCFmcqrjMo3bv99isIk9ZVbJmpZiPrXN3Ja/x
 yPI6Jp5zjtTRIaDc3t1MQoGy1+n4VwtAc2/4QRlbNQcj+OSLVnx3nQeG
X-Gm-Gg: AZuq6aKQpy5J3ggf9DAaWS5YCD8gRIwd6pd2SjnNlBfcK9eY+bEYaJKwoD0a6xswGtV
 3G3JAfUXUb1VTu40/qzSfy+qgjpOhk39RY6K4XSaXYdwzSWYASe3fHTZ9y5clqillzr7bPjdQbA
 odfVEfq1kaJ9ZhF2LZwYToWOn4Pc04mm7LWW5RTFPe3f4iAhOzIOkocI8uUqFl9aXVzPK2kqymP
 Qh8dj3L0tJp8/tyA4jFkr3EUu0+sqbRnTTu56eXTgERfG0bsa727uudMigk3+kATE/NPS/w7zGS
 uBewTHoU77Etu1CIgSGZ27ce0PdTHrG2h5WErHq+GjTyVLLf3C2lBCJ8SRHheftnYwS8ndh8WqR
 qxkaZqhP7Di5f20eeSs141H7Urv2KZBzfAnol0xNZ0D96cTwlSmpf3jSdXHuYTeL6Hogv48zxfs
 j2GyjkRn45MrhUG6SK2nivnZvOL9sGah3MFvujWfmlPDlCtYbphWlYHgEZHOJZehmXoWV2cZ/Il
 l5tGOZG+kZraNQ=
X-Received: by 2002:a05:600c:1d24:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-48320236b1emr30523645e9.32.1770376584992; 
 Fri, 06 Feb 2026 03:16:24 -0800 (PST)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320719bf4sm45174355e9.10.2026.02.06.03.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 03:16:24 -0800 (PST)
Date: Fri, 6 Feb 2026 11:16:23 +0000
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org
Subject: Re: [PATCH 4/6] tests/tcg/or1k: Rename from openrisc
Message-ID: <aYXNh5vuojddKmaQ@antec>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
 <20260205030244.266447-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205030244.266447-5-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Feb 05, 2026 at 01:02:42PM +1000, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

OK.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  tests/tcg/{openrisc => or1k}/test_add.c    | 0
>  tests/tcg/{openrisc => or1k}/test_addc.c   | 0
>  tests/tcg/{openrisc => or1k}/test_addi.c   | 0
>  tests/tcg/{openrisc => or1k}/test_addic.c  | 0
>  tests/tcg/{openrisc => or1k}/test_and_or.c | 0
>  tests/tcg/{openrisc => or1k}/test_bf.c     | 0
>  tests/tcg/{openrisc => or1k}/test_bnf.c    | 0
>  tests/tcg/{openrisc => or1k}/test_div.c    | 0
>  tests/tcg/{openrisc => or1k}/test_divu.c   | 0
>  tests/tcg/{openrisc => or1k}/test_extx.c   | 0
>  tests/tcg/{openrisc => or1k}/test_fx.c     | 0
>  tests/tcg/{openrisc => or1k}/test_j.c      | 0
>  tests/tcg/{openrisc => or1k}/test_jal.c    | 0
>  tests/tcg/{openrisc => or1k}/test_lf_add.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_div.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_eqs.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_ges.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_gts.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_les.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_lts.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_mul.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_nes.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_rem.c | 0
>  tests/tcg/{openrisc => or1k}/test_lf_sub.c | 0
>  tests/tcg/{openrisc => or1k}/test_logic.c  | 0
>  tests/tcg/{openrisc => or1k}/test_lx.c     | 0
>  tests/tcg/{openrisc => or1k}/test_movhi.c  | 0
>  tests/tcg/{openrisc => or1k}/test_mul.c    | 0
>  tests/tcg/{openrisc => or1k}/test_muli.c   | 0
>  tests/tcg/{openrisc => or1k}/test_mulu.c   | 0
>  tests/tcg/{openrisc => or1k}/test_sfeq.c   | 0
>  tests/tcg/{openrisc => or1k}/test_sfeqi.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sfges.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sfgesi.c | 0
>  tests/tcg/{openrisc => or1k}/test_sfgeu.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sfgeui.c | 0
>  tests/tcg/{openrisc => or1k}/test_sfgts.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sfgtsi.c | 0
>  tests/tcg/{openrisc => or1k}/test_sfgtu.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sfgtui.c | 0
>  tests/tcg/{openrisc => or1k}/test_sfles.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sflesi.c | 0
>  tests/tcg/{openrisc => or1k}/test_sfleu.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sfleui.c | 0
>  tests/tcg/{openrisc => or1k}/test_sflts.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sfltsi.c | 0
>  tests/tcg/{openrisc => or1k}/test_sfltu.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sfltui.c | 0
>  tests/tcg/{openrisc => or1k}/test_sfne.c   | 0
>  tests/tcg/{openrisc => or1k}/test_sfnei.c  | 0
>  tests/tcg/{openrisc => or1k}/test_sub.c    | 0
>  MAINTAINERS                                | 2 +-
>  tests/tcg/{openrisc => or1k}/Makefile      | 0
>  53 files changed, 1 insertion(+), 1 deletion(-)
>  rename tests/tcg/{openrisc => or1k}/test_add.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_addc.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_addi.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_addic.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_and_or.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_bf.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_bnf.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_div.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_divu.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_extx.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_fx.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_j.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_jal.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_add.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_div.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_eqs.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_ges.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_gts.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_les.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_lts.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_mul.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_nes.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_rem.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lf_sub.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_logic.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_lx.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_movhi.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_mul.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_muli.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_mulu.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfeq.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfeqi.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfges.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfgesi.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfgeu.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfgeui.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfgts.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfgtsi.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfgtu.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfgtui.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfles.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sflesi.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfleu.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfleui.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sflts.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfltsi.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfltu.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfltui.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfne.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sfnei.c (100%)
>  rename tests/tcg/{openrisc => or1k}/test_sub.c (100%)
>  rename tests/tcg/{openrisc => or1k}/Makefile (100%)
> 
> diff --git a/tests/tcg/openrisc/test_add.c b/tests/tcg/or1k/test_add.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_add.c
> rename to tests/tcg/or1k/test_add.c
> diff --git a/tests/tcg/openrisc/test_addc.c b/tests/tcg/or1k/test_addc.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_addc.c
> rename to tests/tcg/or1k/test_addc.c
> diff --git a/tests/tcg/openrisc/test_addi.c b/tests/tcg/or1k/test_addi.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_addi.c
> rename to tests/tcg/or1k/test_addi.c
> diff --git a/tests/tcg/openrisc/test_addic.c b/tests/tcg/or1k/test_addic.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_addic.c
> rename to tests/tcg/or1k/test_addic.c
> diff --git a/tests/tcg/openrisc/test_and_or.c b/tests/tcg/or1k/test_and_or.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_and_or.c
> rename to tests/tcg/or1k/test_and_or.c
> diff --git a/tests/tcg/openrisc/test_bf.c b/tests/tcg/or1k/test_bf.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_bf.c
> rename to tests/tcg/or1k/test_bf.c
> diff --git a/tests/tcg/openrisc/test_bnf.c b/tests/tcg/or1k/test_bnf.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_bnf.c
> rename to tests/tcg/or1k/test_bnf.c
> diff --git a/tests/tcg/openrisc/test_div.c b/tests/tcg/or1k/test_div.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_div.c
> rename to tests/tcg/or1k/test_div.c
> diff --git a/tests/tcg/openrisc/test_divu.c b/tests/tcg/or1k/test_divu.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_divu.c
> rename to tests/tcg/or1k/test_divu.c
> diff --git a/tests/tcg/openrisc/test_extx.c b/tests/tcg/or1k/test_extx.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_extx.c
> rename to tests/tcg/or1k/test_extx.c
> diff --git a/tests/tcg/openrisc/test_fx.c b/tests/tcg/or1k/test_fx.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_fx.c
> rename to tests/tcg/or1k/test_fx.c
> diff --git a/tests/tcg/openrisc/test_j.c b/tests/tcg/or1k/test_j.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_j.c
> rename to tests/tcg/or1k/test_j.c
> diff --git a/tests/tcg/openrisc/test_jal.c b/tests/tcg/or1k/test_jal.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_jal.c
> rename to tests/tcg/or1k/test_jal.c
> diff --git a/tests/tcg/openrisc/test_lf_add.c b/tests/tcg/or1k/test_lf_add.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_add.c
> rename to tests/tcg/or1k/test_lf_add.c
> diff --git a/tests/tcg/openrisc/test_lf_div.c b/tests/tcg/or1k/test_lf_div.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_div.c
> rename to tests/tcg/or1k/test_lf_div.c
> diff --git a/tests/tcg/openrisc/test_lf_eqs.c b/tests/tcg/or1k/test_lf_eqs.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_eqs.c
> rename to tests/tcg/or1k/test_lf_eqs.c
> diff --git a/tests/tcg/openrisc/test_lf_ges.c b/tests/tcg/or1k/test_lf_ges.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_ges.c
> rename to tests/tcg/or1k/test_lf_ges.c
> diff --git a/tests/tcg/openrisc/test_lf_gts.c b/tests/tcg/or1k/test_lf_gts.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_gts.c
> rename to tests/tcg/or1k/test_lf_gts.c
> diff --git a/tests/tcg/openrisc/test_lf_les.c b/tests/tcg/or1k/test_lf_les.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_les.c
> rename to tests/tcg/or1k/test_lf_les.c
> diff --git a/tests/tcg/openrisc/test_lf_lts.c b/tests/tcg/or1k/test_lf_lts.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_lts.c
> rename to tests/tcg/or1k/test_lf_lts.c
> diff --git a/tests/tcg/openrisc/test_lf_mul.c b/tests/tcg/or1k/test_lf_mul.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_mul.c
> rename to tests/tcg/or1k/test_lf_mul.c
> diff --git a/tests/tcg/openrisc/test_lf_nes.c b/tests/tcg/or1k/test_lf_nes.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_nes.c
> rename to tests/tcg/or1k/test_lf_nes.c
> diff --git a/tests/tcg/openrisc/test_lf_rem.c b/tests/tcg/or1k/test_lf_rem.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_rem.c
> rename to tests/tcg/or1k/test_lf_rem.c
> diff --git a/tests/tcg/openrisc/test_lf_sub.c b/tests/tcg/or1k/test_lf_sub.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lf_sub.c
> rename to tests/tcg/or1k/test_lf_sub.c
> diff --git a/tests/tcg/openrisc/test_logic.c b/tests/tcg/or1k/test_logic.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_logic.c
> rename to tests/tcg/or1k/test_logic.c
> diff --git a/tests/tcg/openrisc/test_lx.c b/tests/tcg/or1k/test_lx.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_lx.c
> rename to tests/tcg/or1k/test_lx.c
> diff --git a/tests/tcg/openrisc/test_movhi.c b/tests/tcg/or1k/test_movhi.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_movhi.c
> rename to tests/tcg/or1k/test_movhi.c
> diff --git a/tests/tcg/openrisc/test_mul.c b/tests/tcg/or1k/test_mul.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_mul.c
> rename to tests/tcg/or1k/test_mul.c
> diff --git a/tests/tcg/openrisc/test_muli.c b/tests/tcg/or1k/test_muli.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_muli.c
> rename to tests/tcg/or1k/test_muli.c
> diff --git a/tests/tcg/openrisc/test_mulu.c b/tests/tcg/or1k/test_mulu.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_mulu.c
> rename to tests/tcg/or1k/test_mulu.c
> diff --git a/tests/tcg/openrisc/test_sfeq.c b/tests/tcg/or1k/test_sfeq.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfeq.c
> rename to tests/tcg/or1k/test_sfeq.c
> diff --git a/tests/tcg/openrisc/test_sfeqi.c b/tests/tcg/or1k/test_sfeqi.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfeqi.c
> rename to tests/tcg/or1k/test_sfeqi.c
> diff --git a/tests/tcg/openrisc/test_sfges.c b/tests/tcg/or1k/test_sfges.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfges.c
> rename to tests/tcg/or1k/test_sfges.c
> diff --git a/tests/tcg/openrisc/test_sfgesi.c b/tests/tcg/or1k/test_sfgesi.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfgesi.c
> rename to tests/tcg/or1k/test_sfgesi.c
> diff --git a/tests/tcg/openrisc/test_sfgeu.c b/tests/tcg/or1k/test_sfgeu.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfgeu.c
> rename to tests/tcg/or1k/test_sfgeu.c
> diff --git a/tests/tcg/openrisc/test_sfgeui.c b/tests/tcg/or1k/test_sfgeui.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfgeui.c
> rename to tests/tcg/or1k/test_sfgeui.c
> diff --git a/tests/tcg/openrisc/test_sfgts.c b/tests/tcg/or1k/test_sfgts.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfgts.c
> rename to tests/tcg/or1k/test_sfgts.c
> diff --git a/tests/tcg/openrisc/test_sfgtsi.c b/tests/tcg/or1k/test_sfgtsi.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfgtsi.c
> rename to tests/tcg/or1k/test_sfgtsi.c
> diff --git a/tests/tcg/openrisc/test_sfgtu.c b/tests/tcg/or1k/test_sfgtu.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfgtu.c
> rename to tests/tcg/or1k/test_sfgtu.c
> diff --git a/tests/tcg/openrisc/test_sfgtui.c b/tests/tcg/or1k/test_sfgtui.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfgtui.c
> rename to tests/tcg/or1k/test_sfgtui.c
> diff --git a/tests/tcg/openrisc/test_sfles.c b/tests/tcg/or1k/test_sfles.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfles.c
> rename to tests/tcg/or1k/test_sfles.c
> diff --git a/tests/tcg/openrisc/test_sflesi.c b/tests/tcg/or1k/test_sflesi.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sflesi.c
> rename to tests/tcg/or1k/test_sflesi.c
> diff --git a/tests/tcg/openrisc/test_sfleu.c b/tests/tcg/or1k/test_sfleu.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfleu.c
> rename to tests/tcg/or1k/test_sfleu.c
> diff --git a/tests/tcg/openrisc/test_sfleui.c b/tests/tcg/or1k/test_sfleui.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfleui.c
> rename to tests/tcg/or1k/test_sfleui.c
> diff --git a/tests/tcg/openrisc/test_sflts.c b/tests/tcg/or1k/test_sflts.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sflts.c
> rename to tests/tcg/or1k/test_sflts.c
> diff --git a/tests/tcg/openrisc/test_sfltsi.c b/tests/tcg/or1k/test_sfltsi.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfltsi.c
> rename to tests/tcg/or1k/test_sfltsi.c
> diff --git a/tests/tcg/openrisc/test_sfltu.c b/tests/tcg/or1k/test_sfltu.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfltu.c
> rename to tests/tcg/or1k/test_sfltu.c
> diff --git a/tests/tcg/openrisc/test_sfltui.c b/tests/tcg/or1k/test_sfltui.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfltui.c
> rename to tests/tcg/or1k/test_sfltui.c
> diff --git a/tests/tcg/openrisc/test_sfne.c b/tests/tcg/or1k/test_sfne.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfne.c
> rename to tests/tcg/or1k/test_sfne.c
> diff --git a/tests/tcg/openrisc/test_sfnei.c b/tests/tcg/or1k/test_sfnei.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sfnei.c
> rename to tests/tcg/or1k/test_sfnei.c
> diff --git a/tests/tcg/openrisc/test_sub.c b/tests/tcg/or1k/test_sub.c
> similarity index 100%
> rename from tests/tcg/openrisc/test_sub.c
> rename to tests/tcg/or1k/test_sub.c
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00aa4f2a41..208628cb8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -307,7 +307,7 @@ F: target/or1k/
>  F: hw/or1k/
>  F: include/hw/or1k/
>  F: tests/functional/or1k/meson.build
> -F: tests/tcg/openrisc/
> +F: tests/tcg/or1k/
>  
>  PowerPC TCG CPUs
>  M: Nicholas Piggin <npiggin@gmail.com>
> diff --git a/tests/tcg/openrisc/Makefile b/tests/tcg/or1k/Makefile
> similarity index 100%
> rename from tests/tcg/openrisc/Makefile
> rename to tests/tcg/or1k/Makefile
> -- 
> 2.43.0
> 

