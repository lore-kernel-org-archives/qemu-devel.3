Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A12AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfDN3-0007Fe-Nm; Thu, 02 Jul 2026 05:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfDN2-0007Bt-Gi
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:06:08 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfDN0-0007Oc-W4
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:06:08 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664c1cf7445so2029946d50.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 02:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782983165; cv=none;
 d=google.com; s=arc-20260327;
 b=TGoovLylAL60nNxGbkx5D3k8Au8dDYy4/8V6l92c8Lf50XOkhHsvjuotMfB90QLe9+
 PLuj9J5sS+9urRm03JjW5zB6PKI3524NHanR9YiIlVCAEQK5GyqbMR55G9KHrzYrsJRW
 X7ob7mbc/egana7qIbGpLvncuveh3JiEPHPBZ3N5tRKKObZcqzDz87bJxSqMFLaOVAy6
 zm4wpIBKxlyCf9KJGhAo1Y6lz17fFI4wVUUTrhD+6LT36DWnbCylZNl4mimFNxyZ7yN0
 Zj//wWJSrg8RphKpjgwQjyLkeFpIBGqiBKZ/cVPNKoK9yUvNujop9rg+i4+UTaGI2Q+A
 JL9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9cEOkumq398N7Qdu+51eDUcOf7lxn3XziNGH2X2hLww=;
 fh=Yr7MACYtLQOa4nGMGHVQ85rgvXP8tAqFWOWLWYeuYUo=;
 b=W/zdEEn2pE5SrDE8AweSx+ms9lpbMNw7GqTrmYbprB9du8RcDIDQsEJsfSl8qeQuXA
 esQ1gi/suXzA7Lz2zxmCpG2p5QbQgI4Vw/EJOA5AgJtX4HuCpBUvmGgFQyC8Z4PyJiEV
 znRrtfXDu8Glgwm9WyaTFTqlkPwwBnvI8skGfLxKfR/UJheqFizJR2ydqXjW6H9/6Kk/
 zFYZGxOXtg57KFn30fPkz3oOAC1HOBMFE025ELTgDQO5F3tBvkCNMXKw5e7p/lm6+2X1
 g5WTBcxwqEPIGEBN5uN8tZTgGtDe0csWfow3UdUiuzCL4Jpt759IlkSSVrEZUqPmM6+v
 iVAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782983165; x=1783587965; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9cEOkumq398N7Qdu+51eDUcOf7lxn3XziNGH2X2hLww=;
 b=tAe6NTgNpe9fHHYEM9ynMzBYvzBzN+Vjf4Wo/UgHOx93c6hLKK2Af7+9q/FwW679G5
 4wi65h1IAV5PFldojNAOsNhc/nwWa9Xs5n80uc9FNqTi7/nI7Xk1mgAnMVMMU02AJoju
 fQ1KBc+XTDPH4q1Fpo07lBdAYf2572ajyuD1x+seakfvfibjZDq5qSn/ayd4HIaeDuFh
 VcO5c84ebWV7CNlJ3vRGnjXh2/fTxb8kBpVjNGaOzM0JO/7Y4uxRBPY4zLzqfgbTUyeV
 9rTQ9awFxfXsRnfdDTEKVtXByyKyuRi6j6LQeSluGFrSofEqLdtCDDGjvUjGdJsuq5rV
 I/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782983165; x=1783587965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cEOkumq398N7Qdu+51eDUcOf7lxn3XziNGH2X2hLww=;
 b=Prpm58R7ToM9is94x8zlHRwVSQwDOzb50uVL+KUe2bwyz276oHu3gAdYEPrDSyUHPb
 mwSj+8KOzYXHK6XDqdq6BF2aA6/48OAoDcxzi1Uw6V4mOjgceSqJaIt2YfVMcNLY1KkQ
 UrBOWlJFpUqzr8JCcnoqL7+glDLTZObGKuDTBxayOp5xyRNmaLWT3HI2evQSBRCVamcG
 uwHLKNcJGfzS2dt/clgb41NFqfVcLdZ0mZCEA8C8uzwLLtTCL2oFp/xuJ3HXL3AhRIJ8
 cYJYxOWKzkQdw5s5D2CPQqTE9aZ42kCuNNc+Ukwx4KI7kgM+DxFWwfUOMZWRdakNipIc
 HYHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpM3m6zxQprm5FjkKdpGSF/IiFK1vl1YKVE7Rdx1BRDdpVxbzvLHOzibX/zLPFvGqlC7kXLM0Vn/YAm@nongnu.org
X-Gm-Message-State: AOJu0Yzltuu/5RNkgXyc3NuuV9jPu73Jq4SHi/++hDxYAWCAFG3x3vQH
 SusdsmYWFxZto2HqrLLXpDD1d6IONt12gnEn6woQMIpNd88dkiAXkV52YqVCV1AVNCZb7sgJS32
 45+/h8T+RnYtQwe7Zh8VV9JGadexsBGALfnsJsf94GA==
X-Gm-Gg: AfdE7clisWlymqyGIjhr4NV8SwWo9PjthV4iOYhBPmOm0SNZ8K9ZOUyM84fQpfaaakW
 HfsTDo5/ALM9A4kEVjKgPCkMVsQSKfmbYQfjQQFta+9MlhKwSUwTBs5cuZA80ZValxQF8dZwsv7
 TkmOvaj3y7UP0jHBv2W/Cj3kNXIC0i5Y8WJt1tf+ViXeNbZgC75TkQPcpdsw3kqKULUZPdiGG4n
 tOe5V1zRZDepFcBGLY5LLmj9366+SkTJonsvWs+WhbuUc2nYMTikpXIPR9IIKotsokuX7C095zn
 X1ZLF75Uqq523V27dVUrBEu/E8H07k+fhXYdrreIH9XRBSCQpXWY3pUN
X-Received: by 2002:a53:ac96:0:b0:664:ca89:3f3 with SMTP id
 956f58d0204a3-66521b3c867mr6305916d50.40.1782983165543; Thu, 02 Jul 2026
 02:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260701231224.106850-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260701231224.106850-1-heinrich.schuchardt@canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Jul 2026 10:05:53 +0100
X-Gm-Features: AVVi8CcFQ3Et8fmL6ZbMi6P-Fxy-dqB9fkmbkd-hkXDogb5P3YbAFgAT6RHyHz8
Message-ID: <CAFEAcA9Y1Mfsdn=tQXA=QJqa14JbjhnexPhnem1oi9vyeDPVpQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/virt: define initial aarch64 TCG CPU
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 2 Jul 2026 at 00:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Function virt_get_default_cpu_type() is meant to return the default CPU
> type. But for aarch64 TCG it returns cortex-a15 which is a 32-bit CPU.
> This results in failures to boot if no specific CPU is required by
> the command line.
>
> Return neoverse-v1 as default aarch64 TCG CPU. This is the aarch64 CPU
> with richest feature set.

The default CPU type for the "virt" board is the way it is
for command line backwards compatibility: people may have
existing command lines that this change would break.

I agree that for most people "cortex-a15" is not what they want;
the underlying principle we were trying to follow at the time was
"any command line that works with qemu-system-arm should work and
do the same thing under qemu-system-aarch64". So the virt board
has the same default CPU for both qemu-system-arm and qemu-system-aarch64.

If we were going to change the default, I would probably suggest
using "max". Picking any particular fixed CPU model name is a bad
idea, because (a) it won't work with KVM and (b) in five years
time that particular CPU model will be an old and out of date one,
and we'll find we still need to tell people "you should specify
a CPU type because the default doesn't have XYZ features".

thanks
-- PMM

