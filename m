Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC6ECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEv2-0002sY-1d; Tue, 21 Oct 2025 12:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEv1-0002sH-3s
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:09:03 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBEuy-0000tA-QN
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:09:02 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-443aa90f025so2455194b6e.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062938; x=1761667738; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vn546EyIRXNGjpEvvj5PF7qU94YP8QFrRakMQKRLLOw=;
 b=iM2QJ5ASRvKWX+qppdoZMNPFPTSqhHdf7shvrD5qHW53xlal04bZooD/wNC8Q+o1q/
 JU7BnV1NAE0w5hA688rK2LM2kVJEA+N8F//FxU8sHzS7fwHZ4SiPZ0bOnUu7maNM28UP
 RbzFchKrMnkmm1H7o70TdPx+BRw0Q+d8YYLBXG8Bdy5CeShyrrlC9tFIYd8He+4HTApd
 RpDBd6SG82qdymj+XkDl5DdYB1xkZu+5w5iIK35CdAYaYFftfpyEsMnhp4awky3JqByk
 qi4rvf4/X9s7tBE5HLQP3s1z7rEUlB7YdqHAITuOza2W6evRv4DMvoif5fZG3vxC5UF5
 SpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062938; x=1761667738;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vn546EyIRXNGjpEvvj5PF7qU94YP8QFrRakMQKRLLOw=;
 b=g9vtP/95VuSBaiP+rxGyIIxQR0W1FPq/G/bA2L36PP0f3mCiEkx2WF29731gTzM/Kw
 6VCpfo6LyHXimivs/VlWDAefSVi9DFHzaDa7qMh9tM4Nr12/Ag4zZ2UoZiedKtoZww/w
 UMURorwV/OfcaPI1b9c94JAQJIfU3O8L5qSBrYWY2wDXWGUqnKsQov2/NeJVLUmiYYJl
 xjGOpLXxKvvAaYDGkneRJe2rQkeJxlcdw9dpbzCwtXrZ4dYyO140S5EOYyNYIICzgvFJ
 Yc0OdxnboI2QaXr7/LgKRucvSIt/8uahPNhjvOCVXWmNzWJVNm90FNN7hZnxVfiWtmsD
 aKlA==
X-Gm-Message-State: AOJu0YyYub1lUsbcf0lQ0qf5zJArlGYd3tlOUXJvZxxMFfyOkHuh3ZO7
 Jm67iWLX1hgq0vwno9ZNWCbY3YU//eFhxtvAhnFpczSj/XQGWZgQjBlMKY/bOv0GtSak3DqOXYM
 AiNme57V36Ik1GCk2LKXNfU+J9Q6kt25Qu4NRCf4A/W7hVU+h0koB
X-Gm-Gg: ASbGnct5yPCWqIy2HDiU60KiSxsZs6p7zfKSbEN7UHCNYh1LLvBJMetqRolao7ByfPY
 CBgOOCgGEAixqo5AWxXZzt4NM15KdPeinmg1YkQm9yGEF7ufiQ6yZKjzMmh/DIk00hT1026IJtE
 A6JvKM75iftrCmKrzrKGJ0h4DwsG2BDzLT2IQ8UCDaQXdPh56veR3FSH1Eapb02IApQKzLdw30s
 FDrveemH/W14aHzDqQuQotvPu2I8pYTLfLk28el92etzw6PMB3zgeVkmZmyQA==
X-Google-Smtp-Source: AGHT+IGz1NC027kKvhA+ZlwRCwCud0xf3oh1uudhq2cDZGCCiPxy0GNeZlCvJK95xTQIluAIi0gmDjGmU3XhJ9sJ2lo=
X-Received: by 2002:a05:690e:d51:b0:63d:a9c9:f4d6 with SMTP id
 956f58d0204a3-63e161c550fmr13450194d50.52.1761062548309; Tue, 21 Oct 2025
 09:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
 <20251010130527.3921602-28-peter.maydell@linaro.org>
In-Reply-To: <20251010130527.3921602-28-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 17:02:17 +0100
X-Gm-Features: AS18NWBccvKtqpEb27YKJvWvkzTKIRQCv_NIVIAOvEPu44l4EZG-6gyB4ZG5CH4
Message-ID: <CAFEAcA_OfoG=SAcfcasEVRas+XCzTN_5gtyYRsKw-_3zaL4Mow@mail.gmail.com>
Subject: Re: [PULL 27/76] target/arm: Introduce mmu indexes for GCS
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22a.google.com
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

On Fri, 10 Oct 2025 at 14:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20251008215613.300150-28-richard.henderson@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

>  /*
> - * Fix the number of mmu modes to 16.
> + * Fix the number of mmu modes across all targets.
> + * Current maximum is target/arm/.
>   */
> -#define NB_MMU_MODES 16
> +#define NB_MMU_MODES 22

> -#define ARM_MMU_IDX_COREIDX_MASK 0xf
> +#define ARM_MMU_IDX_COREIDX_MASK 0x1f

This change makes Coverity complain about a potential
array overrun when we use arm_to_core_mmu_idx(something)
as an MMU index that eventually gets used as an array
index into the CPUTLB struct arrays. It used to be the case
that (mmu_idx & ARM_MMU_IDX_COREIDX_MASK) could never be
larger than NB_MMU_MODES, but now it can be.

This is a false positive because we won't try to pass a
bogus mmu_idx and all our real ARMMMUIdx_* values have
in-range values for the COREIDX_MASK bits. But is it worth
adding an assert() to arm_to_core_mmu_idx() that its return
value is less than NB_MMU_MODES ? It might catch future bugs
where we forget to bump NB_MMU_MODES.

thanks
-- PMM

