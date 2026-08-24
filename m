Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1A2C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyYqd-0005eS-V9; Mon, 24 Aug 2026 13:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyYqc-0005eK-KF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 13:52:38 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyYqa-0004hG-R0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 13:52:38 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-51c2cce930cso38818721cf.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787593955; x=1788198755; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IZOTfUX5NEhf+j4QCxZbLX4mIevuz2ORUg/xzpbPQAM=;
 b=FG+AHnGO+zJijhLosKhZ2HNiLg/ro1W001hzktBxYZN+/deOwK1V6GH7+EepfvKcrC
 7MeE8m2+4XSpmC3EdRQOLVtzI6oDY6KuYiLF3ulkLpLxNPT2l65sKYNnFyjfIIUNDAzo
 BpdTZvppdR/kKxvFugcnrLk9FmkkMMsXBMil/c71DD5TM7scl34Op3dsEjrS9YQnGNMW
 sATCPYHx7Img6iiaqh7YQ8Ozhh/ppEcGSVjJiNmMW+azGMdJh0qtz6FuicBWMo/HEUwf
 qEgDmESlBWggo+sEX7Vf74pfITYSaVRCPqdVL5lprRgdvvNrsuyZq8WwrwJKroVlAnqI
 OIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787593955; x=1788198755;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IZOTfUX5NEhf+j4QCxZbLX4mIevuz2ORUg/xzpbPQAM=;
 b=mcYyixj/Tbcf5aUO5RV+z+teyYeN16x8c9zHx3E1cg30/0ya/S9yB3dQ2Bdl7DR7mh
 fupzyPkRD4uNYfGyhCWjBC4jf/FIzjG2yoWpJvQ+uG4fo27AcHibkvwIFHJafpHBNEX2
 /Vev6SEN1gQHWYkQXa9Z1Qjfe7RjcMG5ybxiAwXtqiP5P/HyAqatJ59Dmombh3upQVZo
 pFVhPTmPLdXNG2Pg7E80r6H0gOjJlV5A3a6zysTALMLO58txLm3/nyYYL48evvbqWBzP
 zuDSLnXUGgU0Vj1lt3JJJNpVYctno+TUGm/y35Y2c+nTL73lDFMdco0UH0LUtbmtWPkw
 TfpA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbnM8UtImawy7GaAqGHvSLmimWc6AJTl92DsPtbR1jKeyU8ZtG/sCad6F0Zm7Cyik9Gmm5E1nZ97qK@nongnu.org
X-Gm-Message-State: AFuF++k+4/qOGFI5f9dCCWlLRQ7hylfTTzbRsCs0Gn0OPrrj5oI3i2jW
 9pjelKkHUMTwO8406Ad3kIk+TQziqwUALHOz4oo0QvyosIcsd2n++CJis/+Zga48Fvs=
X-Gm-Gg: AR+sD12+fo/1h0TUicHCoB33a2RZen6obM7E+e0Wf9sac4lzPahZLD7FA3F63J+r9tH
 Z+NFHdxGYnw3YotnVjng6H1cwfX2BOhtYiJ4W33GkesipwpdNzD4Y1HyIEKP6Wpq9mfdLOJTkgV
 szuJpXyJ1oS+alQBCQXXBsreJCbmchfgdHTLXNzkRyQoGPZ9GW5POQn3Ak+ZFT2rreWaIBBV4P2
 k17AMDpu2dyJcmU6fubTCvdKJVRd3hUaLrMuBpFsiSzdcn3C/+eE9HM5ptB25byXeh8a1b++abu
 BtqDqQKXAivOwwYwKTDCUJ9oxzXrf5qN/zGbMeINZwP942QsyVXKS+d1NBX4gVeDvBtQpy7gDNQ
 8iZ16yH22azUrEJH3jhVdvzqasVy1V+3Gi9l2ek/dcq1BQRE98Iz5doWcPwdSvyCcZ3HwuitM7o
 +ZgUC1sfGMwCP4ui/irEqwlvHO5QkM6zWSZWS9xrX/pYI/yZRQaRr1egVfKR68gLjw61w9eIpzX
 an98bsZjdqdG7sHZ9RvCe0ryep6LuxaejAdBzp3JWMwddg=
X-Received: by 2002:a05:622a:58d:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52e2f121faemr8306331cf.25.1787593954966; 
 Mon, 24 Aug 2026 10:52:34 -0700 (PDT)
Received: from ?IPV6:2607:fb90:3328:4602:233a:ffa3:848:6749?
 ([2607:fb90:3328:4602:233a:ffa3:848:6749])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e09b0c79bsm51350971cf.29.2026.08.24.10.52.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 10:52:34 -0700 (PDT)
Message-ID: <5fcabfcf-574c-45bc-8f92-79b638d22e2c@linaro.org>
Date: Mon, 24 Aug 2026 10:52:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/96] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x829.google.com
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

On 8/23/26 22:46, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
> 
> The following changes since commit eea8fe61b8be8f3016e522e6af24924a0266ca95:
> 
>    Merge tag 'igvm-20260821-pull-request' ofhttps://gitlab.com/kraxel/qemu into staging (2026-08-21 10:39:31 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260824-1
> 
> for you to fetch changes up to 85d38315fd19cda7fcfec5350f27cdfa15742600:
> 
>    target/riscv/tcg: sret in virtual user mode raises virtual instruction exception (2026-08-24 13:01:48 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 11.1
> 
> * Fix IMSIC CSR write and add tests
> * Parametrise debug trigger number
> * Add 'svbare' satp-mode
> * Fix RINTC PLIC context ID for KVM
> * Avoid abort when reading vtype before env->xl is set
> * Skip reset for KVM irqchip
> * Skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
> * More FDT cleanups (PLIC)
> * Make FCTL.BE in IOMMU read only 0
> * Check DC.TC reserved bits in IOMMU
> * Apply UXL WARL handling to vsstatus
> * Set cmd_ill IOFENCE.C if rsvp bits are set in IOMMU
> * Set RISCV_IOMMU_FQ_HDR_PV appropriately
> * Report QEMU CPU archid as 42
> * Check PMP before updating PTE
> * Add the Tenstorrent Atlantis machine

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

