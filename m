Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E72D2C13D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Lbc-0007Zq-Ij; Tue, 05 Nov 2024 10:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8Lba-0007MJ-91
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:36:30 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8LbX-0004k5-4P
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:36:29 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e5a00d676so307140b3a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1730820985; x=1731425785; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d4go3bp9vwKXUsHdZahivwZLkjek4unj4vZiye1qF4s=;
 b=VoxqSw0hK+FpsXapxAnZn2xm2U4Atloko+9/On00TegdXhWnFBBRvoQzESaagA3Hhk
 JVw+LYpQsnhrlTPw3KXJ6iabcjfR63BZeYUMa3nsK0tf0/Yb0rXcDoTxiVACf5TVWdAH
 BdSk/sEOe1jAbrhFqi5NDACSgPPMxSR9rOvVYn15ovT6TIZeU0CgNVg+QG1dE46zDaYy
 c9Dmvx8zRH2CzpitqQMKNJrf4nGRXrF0XJD5cOFVZQiC13kinhc9nE0Y3m0cKlPgsLB/
 nV6gqkPt4CHyFy43shNdW6ogJjmmr3atqbx0AZDF0bp1i8EfbbOQURhDDHuOmJya8aDd
 2L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730820985; x=1731425785;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d4go3bp9vwKXUsHdZahivwZLkjek4unj4vZiye1qF4s=;
 b=ULqTjLhxcBCtdxz/zjGdfMcvXA4bpNqYwtLXw/582T09UFtuAs36VsrYu1+vk/YRV+
 XrcLB/cq8PDoSa9gAnsqJi1YPhg7N8CfO4Kn/r8xKJ7HW8z5SnIV2pg1rbXZR/OCgFhC
 7n56dOf4DKT4kUdjtoDKOmO8S3Od3KwPN5NmhLXl2GRgYfroyjcdEejoAFbprXNThOP9
 fKNjiPylfHK8RS0wbXREOYey+K4tIs9JScz2JSiyjCttC8nBDhdfYYFpm0w3ZzyQjDmq
 Jq52SL2dQx5UhybOh9tBvZGEV7HNDAxK0E31RSSKCX8eJ7TO5u/MLW7dl3eSsmf068hU
 k8zA==
X-Gm-Message-State: AOJu0YwKEFBwAqXfxgS9GVcHMX40WjK9Jis2NkWPVN03KiAhKFeep0if
 Qi7CiyJXDSgCXNVh4vDG86b8yhbyzJd7gfdXd98tc6gxvdV3RT64H33VZCpYDAE=
X-Google-Smtp-Source: AGHT+IFPNzTOicsWI/ZHk09BGEXt421GfY3gJHvkV8Fgbzh0BmEw6exeiPkJ0LknXcctLin2s5BuoA==
X-Received: by 2002:a05:6a20:9143:b0:1d9:14b4:9bf2 with SMTP id
 adf61e73a8af0-1d9a81ce828mr25250168637.0.1730820985081; 
 Tue, 05 Nov 2024 07:36:25 -0800 (PST)
Received: from localhost ([184.22.32.237]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee459f9222sm9184701a12.64.2024.11.05.07.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:36:24 -0800 (PST)
Date: Tue, 5 Nov 2024 22:36:10 +0700
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v4 05/15] MAINTAINERS: Add myself as maintainer for
 apple-gfx, reviewer for HVF
Message-ID: <Zyo7LCTKSsCNz6wX@roolebo.dev>
References: <20241024102813.9855-1-phil@philjordan.eu>
 <20241024102813.9855-6-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024102813.9855-6-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=roman@roolebo.dev; helo=mail-pf1-x436.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Thu, Oct 24, 2024 at 12:28:03PM +0200, Phil Dennis-Jordan wrote:
> I'm happy to take responsibility for the macOS PV graphics code. As
> HVF patches don't seem to get much attention at the moment, I'm also
> adding myself as designated reviewer for HVF and x86 HVF to try and
> improve that.
> 
> I anticipate that the resulting workload should be covered by the
> funding I'm receiving for improving Qemu in combination with macOS. As
> of right now this runs out at the end of 2024; I expect the workload on
> apple-gfx should be relatively minor and manageable in my spare time
> beyond that. I may have to remove myself from more general HVF duties
> once the contract runs out if it's more than I can manage.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3bfa132fd6..16ea47a5e6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -505,6 +505,7 @@ F: target/arm/hvf/
>  X86 HVF CPUs
>  M: Cameron Esfahani <dirty@apple.com>
>  M: Roman Bolshakov <rbolshakov@ddn.com>
> +R: Phil Dennis-Jordan <phil@philjordan.eu>
>  W: https://wiki.qemu.org/Features/HVF
>  S: Maintained
>  F: target/i386/hvf/
> @@ -512,6 +513,7 @@ F: target/i386/hvf/
>  HVF
>  M: Cameron Esfahani <dirty@apple.com>
>  M: Roman Bolshakov <rbolshakov@ddn.com>
> +R: Phil Dennis-Jordan <phil@philjordan.eu>
>  W: https://wiki.qemu.org/Features/HVF
>  S: Maintained
>  F: accel/hvf/
> @@ -2580,6 +2582,11 @@ F: hw/display/edid*
>  F: include/hw/display/edid.h
>  F: qemu-edid.c
>  
> +macOS PV Graphics (apple-gfx)
> +M: Phil Dennis-Jordan <phil@philjordan.eu>
> +S: Maintained
> +F: hw/display/apple-gfx*
> +
>  PIIX4 South Bridge (i82371AB)
>  M: Hervé Poussineau <hpoussin@reactos.org>
>  M: Philippe Mathieu-Daudé <philmd@linaro.org>
> -- 
> 2.39.3 (Apple Git-145)
> 
> 

Thanks for helping out,
Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>

I have recently got some cycles to do HVF work too at DDN.

i386 HVF future is not clear as it took two days to update my 2015 MBA
just to get QEMU compiled. It's no longer supported by brew.sh so I had
to go through some hoops to get dependencies compiled.

Regards,
Roman

