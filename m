Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C245CCA5FAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBsal-0000UR-T8; Wed, 30 Sep 2026 07:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBsak-0000Tq-1M
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:35:18 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBsai-00053Z-8Z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:35:17 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ac47074e38so2681627b3.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 04:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790768114; cv=none;
 d=google.com; s=arc-20260327;
 b=PjwqMpO77uAlHyekafw0QiCbY6xRdglkun1zLw3pet1BB9GQ5LPJsNuBQkzrTWppHA
 YQkXeCEN851Y1iInZc+GuRvtAYn5LehBKjQsSDtzGTPNkYSh2mJH0zpaVWpuLGhpZy4V
 N7jxHB9vfnb8DMxm81DbpivdOJKwUIu7d7Y9zDhfCPfBEsVa5MVVUwm3thONQUD/vW4S
 ck2k5CHgT7VB0bR58ERqaj8GPLbEMtx3MfsRSuWAHxi4Ny2ybG0Nij7F+BWgMbzB3JXo
 TnzG3bqwrPCJvimWKbBTj2TYvhpv0LvZNTqkGcDtj+LeII83sSpWjE0HcuJ9IYad2kmD
 hhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SeY6Z1jmk7ymRLBox8aezw1ZLI+jut6EQpLQBAspM3Y=;
 fh=+EjqEHtQwKNufVIRoBGKtWOd7N2ov51GBxxOgvUpuXc=;
 b=cSH4d8iKlqpuk7hwDzEn18+tQrQJaSFsMh3Z5GdVcXE0C2N7v3Z3RTt5qLp9D4TX+F
 RfG1Vam9JqKEeLMXdcu8wBv4FMVnVNzVd6lKcCEceVjqqy67Jrejb9VZ/103OFOTuLn2
 08j39ubhVpIwX3cPrvOofLIZS1V4vjs3cqYeyG6uHsGEhwu4Nw7mHttelX5iRKlueWP0
 jGXgwWvhf1I1mw6S04MSJO6cYWC1SoelSzMMsfgRaJdP7QJ/blTeO9CG8MW7qe+GtIO4
 YXHgdJLl3D+puTbg8CzN8BCun93xE0Bx02gulVKmqh7O+iaZmwUED3v+jYgCq7xqX4KQ
 gSdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790768114; x=1791372914; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SeY6Z1jmk7ymRLBox8aezw1ZLI+jut6EQpLQBAspM3Y=;
 b=HHl4/JM7PTMKVXcNEsOe42Ji126Unn8iSQ9MLxspYpta5TAb9AnJFv/JN4wC3Qua95
 rHNNR+UyHi4wVA4QHJgIRW87UqKRH3C+/v47/1JLgAHIYN+rvd0LXSuA6Hf345olvpcj
 +12C4geTqKJcpwVAZhW2nXt6BxG3+gF91DixlnfcYqcuPRyhRA1iui5Iw1hTjuu0LRH1
 dHivwqO4ieyM4AoDnLlVjgd1HB2dOwE9It7lFpfNfER7IJU3C8ZyqdgPIFwoqmEnx0RD
 bquIw1UVNJXc8lgGNOQiEt+wa2n3+Bimwchyq5uu6Gkirpq9atVvtRIdJjKFIwqq7OgZ
 7i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790768114; x=1791372914;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SeY6Z1jmk7ymRLBox8aezw1ZLI+jut6EQpLQBAspM3Y=;
 b=wv3LyJiOSivW6CVlqT0eJtci4pynJfKzYiWszkLz2dLJuMQ1LB4+/UiJYEv5CVe+08
 kWuzLVRGRkDLHu+Zq3l0EIjhQqcQcMjiKwx1w//b0Z0GQJKCp7AkIJRRSDtUzTQtTwws
 O+Gx6QxVepEYrE7rFxKxD/nr2Qx71lutVnSGefxENiZ3KxUzRDKwA6PDM/q7RGLbEW6G
 epvLOagBG+BtcVzXArvCThmtTTabWKfkVMAl+SKuYKEqFYtyzTDmuFjqpBYz6fo3mbmH
 eYeR/ma3R9CKaFUNN1wUMuQXaDOMwtWTmBp1Zrx8yAUOLwTV7E84QMKuC3hfIG1bxD5x
 xrkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBySDOpxHYSvCBR5loxa3WyanqIKlk2EacqAnY6zmk56ULBQrlLnV8sSL/SmJ2J4cqFVPaqqrz5G76gp@nongnu.org
X-Gm-Message-State: AFq9FYJg8z2m4K8gKAo4YsH9NUJHTqy/9zhZYsIoq5Ts7UlUXxMW5/8o
 WgeWkWGfmfgGy8sxpN0Xgwz4h21pRvZgiVPkfB/RVuiFaNjOpwNDaKUPaznJIhNRJOP/II5ifSR
 S4YyND4Y1g8mFqhSVxTFnTYlmieFgxCuLI9FjubiwZA==
X-Gm-Gg: AYBFou3pmFjs4/YyClK5AY5uhnA1vpJUANDlTlYCdujoDL7FcirPt5R8Usb/w2Wb2TZ
 R6/I7jCULnyXL/DIP+SbiDgKfddEnWAHlHKxQUgL845672ZKqtkR2KSJx6EeHbYhZ6rgc4PtceL
 +Q11yHLy+hwzzH6WtbPh3pQsvnjE6ZoAMsJEg/54Apgc/u7Zl+EdFp06AdiTU8zJNHPtAZYGm+b
 aP7k9VcXuUdTpD3NOEr59B6cTUAyn5J98XWEmBwWldrdWNBfd4RP0Ug0bVLbQ4Q1UI9m6gKRSgl
 M3hv1bJtZu0GCzvCAMqZRRjvLxhUunBXpK0ERMiGUuYedYXxcxVPqPDQu7+BD1nXTEACqxUFps7
 vBZw2QJMSFOLo29axQjhpnCrQ9bl8YKeFtOjD5ms=
X-Received: by 2002:a05:690c:ec3:b0:885:cf67:95dd with SMTP id
 00721157ae682-8ac97909b55mr3191337b3.31.1790768114223; Wed, 30 Sep 2026
 04:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260924172928.2110956-1-coltonlewis@google.com>
 <20260924173051.2117637-1-coltonlewis@google.com>
 <CAFEAcA9Rwrffx8bYiOxrtQGdg31QAz1oBm8okzpfqHZ6yK0Y7A@mail.gmail.com>
 <20260929212102.3659389-1-coltonlewis@google.com>
In-Reply-To: <20260929212102.3659389-1-coltonlewis@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Sep 2026 12:35:02 +0100
X-Gm-Features: AclHuK8bFLv0KvzZpr3GNRdEy1zBXYO_hECfn1oR1UjooEwhow1ZvPDksGAca58
Message-ID: <CAFEAcA9DYo3GW_59eZjsk1qL0--3amYd7ufPqt80O2qv=Qm_pw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Enable KVM PMU partitioning and counter limit
To: Colton Lewis <coltonlewis@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvmarm@lists.linux.dev, 
 Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mingwei Zhang <mizhang@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Tue, 29 Sept 2026 at 22:21, Colton Lewis <coltonlewis@google.com> wrote:
>
> Hi Peter,
>
> Thanks for reviewing!
>
> On Mon, Sep 28, 2026 at 03:01:32PM +0100, Peter Maydell wrote:
> > What should we do with these properties if we're not using KVM
> > (i.e. for TCG, hvf, etc) ?
>
> PMU partitioning is specific to KVM, so moving it into
> kvm_arm_add_vcpu_properties() (which is only called when kvm_enabled())
> and naming it "kvm-pmu-partition" per the KVM VCPU Features convention
> in docs/system/arm/cpu-features.rst seems to make the most sense.
>
> For the counter limit property, would you prefer that it also live in
> kvm_arm_add_vcpu_properties() as "kvm-pmu-num-counters" (KVM-only), or
> keep "pmu-num-counters" general so TCG can also use it to override
> PMCR_EL0.N in reset_pmcr_el0?

If it can reasonably easily be implemented (or potentially implemented)
for TCG, then I guess the general name makes most sense.

-- PMM

