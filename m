Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3299EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmVO-0002v9-Pt; Thu, 09 Jul 2026 07:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmVM-0002uI-SP
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:01:20 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmVK-0005CS-L8
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:01:20 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-664ce3000e6so1700970d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783594877; cv=none;
 d=google.com; s=arc-20260327;
 b=KcF7BupGG5CSvq1Jc0XbDqsDgYf2Pic9hG+rpIbmPG/ZszqP0f/NXimiNu3R3RpQy6
 iQvD4ng1PnJaS7Eitu+nDBLAMWzJos+cpCUVUOu7gZP1YQLIob1ZMqh5NLNoBf9YmEvb
 1Jhok/MYKtDQgEFdw9P7rfNhgrbDkClSMVhMsnDV61VxRzGXHf0SmxFbwlZw4DbNaQeL
 4ivwmfe6VRAynCckktXPDvfVk1VaEJmcQMsPcf9FYrh3hPicVyh55N6eoAJ7hpbKeu/C
 kNt9P6jlz0ToqkwgD5M8zNm0CKZsqUAaLHLP/zQhwkunYXMixkMOpfGPJNilPlE6NqHa
 iduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TAXL4xpT4eVuUR20/E9jML7+hCl0Aiu/a3Q6Cgbp40g=;
 fh=MexFYhAlPd9z0w41BmB7cvNOeTOn+40b4vVX5tS7sYU=;
 b=hv6o+rnaGBqSRt4ZQ0ehTBsAjoIFa/zJa3FK58MlfyR3IWsM1uXJflYL0TXwluw4ji
 0vJ9JRHEaLS32fJyxwBQT7J7XjTTBqMJhUyd7PvvCgWml0r+m5XODvUKIj4RAt07EqpH
 1aGJi8KBACw1Hub56foFZW8BWJszvrr74ass5ATImeFMXGN7cV2i9T9Jn5WkjmooGuUQ
 W3Rgw9He0fqJvxZpumwh8ZmAE56zri2pNHBRIprkyv1tCT1n38JAFbXTHi55RsQriOYS
 Ish6YKsFYdpryB1RMuF/8FKQKpaYPlwrUOqPj1QXUbifhsaUrjTNVICl3+Nc9E4Nzbmi
 q78g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783594877; x=1784199677; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TAXL4xpT4eVuUR20/E9jML7+hCl0Aiu/a3Q6Cgbp40g=;
 b=k7b7EbLPwF10yoVTM2NZhob81C10nuBiWDLe+7kPInGGSHwFx7+aALamdRJGoIqdVD
 k/wdqKrXbzoFK+7k4Tg7YVP1fn939JBo3GPvVxB7UuEobiz6Go2+DvbrNggVqEQoBxhf
 yLLujAMfXJw9Z296TifVWEkywb4u5CHg56qaKK1bZQHrYBZK7e6+0g9rIZtmXCm13Xod
 iGMEfXETdmuB69vzfur8HsbqcznDuN4z5Z4gD4VQtrXtYMz2oWI7wVUtgNsrOWbqmiRQ
 XYzEO0N8u9CR22IzpybbRcA7geY7dySds+zMaC2/WXLKp9qKz+7HFfsq9lBekziNXz9k
 rfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783594877; x=1784199677;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TAXL4xpT4eVuUR20/E9jML7+hCl0Aiu/a3Q6Cgbp40g=;
 b=NhtFm0n1wdRhtrrGUZwrmgIJXq9JjwB9pPJxfErdzMrfVz0LrHr6enp9Q/VoBjrjc9
 XlgOuD0PS2/YhBKj7MR2YNmJfctEfRBWIPl+XGDBvlx7PKpOMisOPo4RX/sUUdsP0b97
 lV5Zv/1EIWYok0Cb9+uMCHGFZEiWVwiyYexGXpb9fRvk2AqASPzVWd23b6BeM17xJVwR
 poPnJX9BAf6TZCUp1d90tCYTs4zk5kye1U7noDNyjmZ+lN58itEKTHLXeR8Rv0UAizN0
 VD6rDYdK5USLvMCFgYDpvsvSsf2D3Z1kU/Eh2a6fupc/ZP9ropBvsu5UwLrXGrMjPEoM
 CJjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIyUlDbIiRFru4E0Wall0hvD+FqPKOMTSRwP1g1TA3SggS1t5jTDtBdhDHpmkDdc1wO39vPR6NDnCP@nongnu.org
X-Gm-Message-State: AOJu0YxklFGJGFGDBqEIfv0fIiX1/FMGG+pAvvd0kSak8ZUj9vtERini
 ctFBpaFnQlXzqws3XfcOQrw2paX7tyaNRlSPaxVgW8TTGiDfrerOrmc2eto0kXOJgxb++cW+lwG
 8cDakIkYkY/JSMz+Bx2VE7FMP7FnDFS5MnV9OsDU6Jw==
X-Gm-Gg: AfdE7cnrA8VW7Yl+UV+EdZGxCkTC/uL3Xl5I9G58pMjH45JxIiFdPbbjCok4nq3HPyS
 ESflENskcbUAgg6noDbPw/yjbEj213nCmE9GAVVNOskPxyIXo3sFLM4SOpgDZwHmlqH/mcQl/Ue
 6ZSKvo4JHKJbGJi5n+SDVQK8y9Lj0EKd4gmXP3CyuNDBULAn+IuvSopRet4udHemMy47fLHf5/u
 B0PbfZ9+PRKDE5fPNCUxZWwrioJn7DIdIIpVCnVG3LSsptdybrD3EtViZ0KZ/IlYsYbxVArFFg6
 QXjevrHptw8rd4gRs6McsayLT6s+Jsh0I9bBDJVi3hbIL/z+WM2Lc/Am
X-Received: by 2002:a05:690e:12cb:b0:664:ae6a:ef4 with SMTP id
 956f58d0204a3-6679f1c516amr4780964d50.82.1783594876900; Thu, 09 Jul 2026
 04:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260707112450.111178-1-skolothumtho@nvidia.com>
In-Reply-To: <20260707112450.111178-1-skolothumtho@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 12:01:05 +0100
X-Gm-Features: AUfX_myqh7PJMmam3llIRbGUEeVmS1xzCz1H12eha40mxKFTrFT3yzj7OKW3xUQ
Message-ID: <CAFEAcA86zv2wYZKT=8ib0EvwzEjF7cByJXfZooBKC9x6M=rCTg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/tegra241-cmdqv: Do not sync GERRORN on VCMDQ
 allocation
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 7 Jul 2026 at 12:25, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> When a guest hits a command error, the hardware sets GERROR and the guest
> acknowledges it by writing GERRORN to match. These registers use toggle
> semantics, and since GERROR is read-only, both GERROR and GERRORN may
> remain set after an error has been handled. As long as they stay equal
> there is no pending error, so a subsequent VM is unaffected.
>
> When a new VM starts, QEMU allocates the hardware VCMDQ and flushes its
> cached GERRORN of zero, while the hardware may still have both GERROR and
> GERRORN set from an error the previous guest acknowledged. This makes them
> differ again, so the hardware sees a pending error and stall the VCMDQ,
> leading to CMD_SYNC timeouts.
>
> Do not sync GERRORN when allocating a hardware VCMDQ.
>
> Fixes: 1d0f77535417 ("hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0 accesses to the mmap'd host VINTF page0")
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>



Applied to target-arm.next, thanks.

-- PMM

