Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09BEFC591C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 09:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvXpb-000524-7I; Thu, 26 Feb 2026 04:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvXpZ-00051w-FF
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:38:49 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvXpX-00054e-Ni
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:38:49 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso627885d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 01:38:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772098726; cv=none;
 d=google.com; s=arc-20240605;
 b=dcpl8cfL1fp/aKlWWCHeqS2nEhVRUWSXOdZV34WhM/ZBfrB049woANcKsqIu9CLXUA
 AQgyuN0TJgQkBBOnj0wWLWk/XdKZiK+c2hVUdr4Q1KnuRYpU6feFS99EWJ2bdQj+cr12
 Y2ePpEklSFqAgGUm6LjDyfhZkEr3w0QpHBViiFb6KObNbNp7RsNqZeJKGUtCQNK372/k
 HCN/TzQxQtqnuycXxSq2OpG4KA6JkmdUjmq2AWoZNSPc3t0lzjAyQm4wY26hfD7FUIOi
 NWK8PfxvDLtrvOBSkUc3VmH8SZYa0XdtX0ctD5ao0zTgdskQ0KI079OjM4u+KtUlIRaA
 hbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+yhLyVsXa/DpONOndO0ocUTiAr4mdTWzgmV+ew/rn2E=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=cW+LpioB27rTZZFjSsIH7fUjelXXAaGYJdcYtCHcJzoPsrCrqHof1v+aRHARX5T+51
 17tcopKEtHXyjUBhFm83QXIqSbpo6MHRX9uROr4R2Lv5dAJ7xkKpDIDAxdiNlq5AtIua
 /bl/5DzULOoTVTZ3StuFMnNJIyKnX4K5aSnmw2KvUOrlz/QWGw1cLvqk1u1RRWQipwVX
 soL7uPHQhWFYPtauI6MRwbAKv8PUVy3dBE0BUrUwp52b+Vg7G36vv4bGL0EoEfPbCf+n
 XM6IaViPOKeRVzDK3kL8l//kHPTRi2ICwLb4HoXW0QZwFVM1yqzed6sV/7UTqFVd75BB
 ykpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772098726; x=1772703526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+yhLyVsXa/DpONOndO0ocUTiAr4mdTWzgmV+ew/rn2E=;
 b=AqltxkdqrFzpG22CgbAAFvGKOsK4MrdKMCssMtgXTFwle4V0glENrqosYxsjVwYsuR
 YAT40uA+3kKIUlU0lLIiF8xIQo/Pa0y7Hqos/Bxg0b8v1/zaEQj4sk2wtkRHwVYDHbbh
 dA65xtNQCHeCj0MkY18ojEZv07xaAQNGYJFW4c3Wdu8bVGXyZidceCp51gYT+Ots7Ytg
 gPX/8xDl9KYHLBl51URDieNQ9zQSbaUBYL6HAWjRs29NpjrGW5B0hgwcnILEd6t7xYT6
 ildEHymZsy8LKf66qSH6ISlQ+017uqBCdrLM94iD5tniEyRprKiLPGi7EtWN7IMFbGFk
 VVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772098726; x=1772703526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yhLyVsXa/DpONOndO0ocUTiAr4mdTWzgmV+ew/rn2E=;
 b=q6J16NjC0O4AOTQq5VkNytjyObq9BU2hKZi/Z7SNYq8Wb+WTNRsmIyHN6hh6JIsnSG
 ZKvfwxGWJZHDUXWcfZGCyE5WCTM+0mXhhg7kQUvcfKSjulj0vQTev3MP9SZy5IQdkuqx
 8pAUNeMCGiCs6I4hClyoV/SjzDZF3iyAvAduX3Knt/J+GdkF6nqdGYlm+nHNLLnZ3Asq
 rJRPS0a/FLfKd3dDSwYyiVwFTbbZ42BxB9qXS6QXe/y0L0k8ikl6DSJYhBrFhshvPPyK
 0P4VpGBcFgnXjylZ87c7RRluSHWi4QJDx4DHqL8ZHV5eLnMpIj4D1CeIbIyCXOroxNtA
 +NqQ==
X-Gm-Message-State: AOJu0Yy6DJGyVO/Hy5wM5WrwqmqiHs/PoJ6oZgA+IPUWL18I/EaOQwi7
 g0koPHKVVJy0QyTMp3Uf0CfKEm/FbXKIlFo5ZrX/8gJruc0RALUOqB0/Q0LWifFrd9ZtHDmyS+w
 DY2c+KdPGXZguj1M1nZraHd8UEyXCUf5yE3r6lGXyxA==
X-Gm-Gg: ATEYQzwxROqdy/oPFotZwjvGvxSnHujx1/4HjUP9yS5B5qmVq+bAcXK271jN3G8DWxB
 5xQp4D4re1iq812Ai6gUkYN1yRCzAOh4N5/2P2Sqqyr0k/4nz8pMDa9rbQAvtmeDT6yDG8MKbjH
 goo1CYP/6H1vW/dFA1Ucttt1ssblcafyWgKL8MVfe8wMGPc6SRDC8mH03/6T3iY3rhyC53KQKFO
 LC5ZWMC6JvNepGUkGJWTcWtN3j7UMGxafpwa33eVoZEPQ0JfF264Yydd7n4eqP7X9ZFjrsHHM7P
 Hpy5O/JCO9EPOJxqEBbuE9nWfDiNJJImbIXt38w4UBvD8irwk8beDN7Fp1WJfaFHHmA=
X-Received: by 2002:a05:690e:6cc:b0:64a:d45b:a4c4 with SMTP id
 956f58d0204a3-64cb7c0c9f9mr859687d50.3.1772098726071; Thu, 26 Feb 2026
 01:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <CAFEAcA9ChSZchdz+17-ee3CzWK6g_BsbEz9_DQ--F+Ek037JLA@mail.gmail.com>
 <9cfa73f6-824a-4c35-8c1a-05d28d58c437@linaro.org>
 <c17e9534-3570-44ac-bcb3-159142b50052@linaro.org>
In-Reply-To: <c17e9534-3570-44ac-bcb3-159142b50052@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 09:38:33 +0000
X-Gm-Features: AaiRm51IHmbEZ3ccjtLPYd7Y4dHmhp_FPhYmgIk6T9JFe349rAJZ_xkN1YrhCl0
Message-ID: <CAFEAcA-PxcVjZnh+w_LYA-hrmVEcnWH14W=TFLQEWbh=ny+-Tw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] target/arm: Support SME for KVM
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Wed, 25 Feb 2026 at 04:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/25/26 15:24, Richard Henderson wrote:
> > On 2/25/26 04:08, Peter Maydell wrote:
> >> On Mon, 16 Feb 2026 at 03:45, Richard Henderson
> >> <richard.henderson@linaro.org> wrote:
> >>>
> >>> RFC mostly because the kernel support is not yet upsteam.
> >>> This is based on
> >>>
> >>> https://lore.kernel.org/linux-arm-kernel/20251223-kvm-arm64-sme-
> >>> v9-0-8be3867cb883@kernel.org/
> >>>
> >>> Properly testing this will take more time.  I'm not 100%
> >>> sure how to confirm that the SME registers have the correct
> >>> value across migration.
> >>
> >> Am I right that patches 2-8 in here:
> >>
> >>>    target/arm: Remove aarch64 test for kvm
> >>>    target/arm: Move kvm_arm_sve_get_vls within kvm.c
> >>>    target/arm: Init sve_vq in kvm_arm_set_cpu_features_from_host
> >>>    target/arm: Move kvm test out of cpu_arm_set_sve
> >>>    target/arm: Drop kvm_arm_sve_supported
> >>>    target/arm: Remove kvm test in arm_set_pmu
> >>>    target/arm: Drop kvm_arm_pmu_supported
> >>
> >> are preparatory cleanups that don't depend on the new
> >> linux-headers changes?
> >>
> >> (also maybe 10 and 11)
> >
> > Yes, 2-8,10,11 could all go in now.
>
> Indeed, we may want all of those prior to
>
> https://lore.kernel.org/qemu-devel/20260115-sme2-hvf-v2-2-2eca481bd7ee@linaro.org/
>
> and the change therein to arm_cpu_sme_finalize.

OK, I've applied 2-8 and 10-11 to target-arm.next.

thanks
-- PMM

