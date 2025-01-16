Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15FCC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRcC-0000FO-FG; Thu, 16 Jan 2025 10:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tYRcA-0000Em-Q0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:16:58 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tYRc7-0004px-Mk
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:16:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so10646645e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737040614; x=1737645414; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JT2gSkujXsePMz+0NLWXC5dK9R4EnVu/GkcnRqkTwNc=;
 b=Vbc6TiqmKEBE4kMBHicr9WgRgPdrKhTCDR87enSeha3KCz41ZKDL0W+YsMZ7fkTLIa
 Y5LXhA2IGYX8LN+b1nd/SaYxLfjMan+FVkDuip+lUnaakepZ4MBd49OkHablNx6u2w3a
 cxDSknQXvYS1FL5sQwYIkUA9rt2kmZSnijDppybfiPmMfnC2uEhSVXnGbgqHmkbPgA5M
 yAYkBYoyHq1CHdA4yHe6QltG0olb7avFW/+gHFYiMiEymEEnOORaQJFs97ArHTfxR0my
 UrhhoqxPkO9ClEoK4Whmki5xlJR/pYo7G8vGUVrPTibnbWbHVldzn/oOTHZ2jOWpmu9d
 7+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737040614; x=1737645414;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JT2gSkujXsePMz+0NLWXC5dK9R4EnVu/GkcnRqkTwNc=;
 b=LP8cq9+ul0XrxAnODGeReErcL62bm2Ybe7EhajFvgJScHUGMi0wdAVHsPzi6vdnOMo
 E9/dlM6HJHE86COXiBWhHCyNOaX4n2cIV9sPkmsizkRTroshxTF53wbEG8k1I0k8UU5f
 yU+h3zuO1jQvdySv67XavdGYy/3M0bpfaNmVFevXzbmo/azvHRt/6r7vJx46/Nquq21i
 NAv42duJZ04ux5K8nrGyGd8FDyCsZgIecQjH6QJp0gfqHnq9oZwQ0RV+FDWCT/aw09zu
 Clevmku1ofmX6EZqSmbuoGlxQ75RorJUowl6z63m6PNbLXcJ0MHaSStSmzbfAnBIsKse
 oX3g==
X-Gm-Message-State: AOJu0YzXVlIXAPHjvNJBHhhZ4CJeZZJ0mRFB/ew2Evmd0m+vGJQn0lS0
 1C/ywJ9GYOF0Zh7J1OQXGYx9EjpL6d/GP/6xIt6mCMm6wMLWb1a9KR+SVYiJpDg=
X-Gm-Gg: ASbGncvWkJKxGvpz0krjnQSF+kBZ77LS8kubRVVv+72wxGEl/ZXsNay2aSVTqQtVbYM
 rwL0raN6kfzrnhWWYrUTqUnYvjVMlsKqZ78ED7EzPS1PN2u/kGgNHja9ieEdG+Uy4GFvRvR9k2N
 OBbCp0q6G0KoCb/XlMey+/CgCbgjOCpeCciKlUNPO8hzXn2j8byK0b1Sl0DFbN/x9qmEOcxFBXA
 gc+wllAuB5gNfZs0EHmGQIig/YBGGRNOJoC8/ZgvKPM+FFYiADDJTaobab6tpJ6mrXcC2Sgv4PW
 i6YNVXFTH6Lezaz+d/5BE//BxYs9+W8sNsh/aa27BQ==
X-Google-Smtp-Source: AGHT+IGrCBWf0TtYSMUMozDkwqiGwy1RfCVUZd5ltJFxNp/AsZ0GZ9V43KfHSDPHEq/WYcPQKFrLSA==
X-Received: by 2002:a05:600c:1e02:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-436f04e048cmr240677835e9.8.1737040613949; 
 Thu, 16 Jan 2025 07:16:53 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389041f7e9sm2355325e9.23.2025.01.16.07.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 07:16:53 -0800 (PST)
Date: Thu, 16 Jan 2025 16:16:52 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-10.1 v2 03/13] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
Message-ID: <20250116-bf7d225d9fef8277a6315e63@orel>
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116145944.38028-4-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x330.google.com
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

On Thu, Jan 16, 2025 at 03:59:34PM +0100, Philippe Mathieu-Daudé wrote:
> The VirtMachineClass::disallow_affinity_adjustment
> field was only used by virt-2.6 machine, which got
> removed. Remove it and simplify virt_cpu_mp_affinity().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/arm/virt.h |  1 -
>  hw/arm/virt.c         | 30 +++++++++++++++---------------
>  2 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 27c5bb585cb..5d3b25509ff 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -117,7 +117,6 @@ typedef enum VirtGICType {
>  
>  struct VirtMachineClass {
>      MachineClass parent;
> -    bool disallow_affinity_adjustment;
>      bool no_its;
>      bool no_tcg_its;
>      bool claim_edge_triggered_timers;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0080577e1a9..53f4a96e517 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1759,24 +1759,24 @@ void virt_machine_done(Notifier *notifier, void *data)
>  
>  static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>  {
> -    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
> +    uint8_t clustersz;
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>  
> -    if (!vmc->disallow_affinity_adjustment) {
> -        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
> -         * GIC's target-list limitations. 32-bit KVM hosts currently
> -         * always create clusters of 4 CPUs, but that is expected to
> -         * change when they gain support for gicv3. When KVM is enabled
> -         * it will override the changes we make here, therefore our
> -         * purposes are to make TCG consistent (with 64-bit KVM hosts)
> -         * and to improve SGI efficiency.
> -         */
> -        if (vms->gic_version == VIRT_GIC_VERSION_2) {
> -            clustersz = GIC_TARGETLIST_BITS;
> -        } else {
> -            clustersz = GICV3_TARGETLIST_BITS;
> -        }
> +    /*
> +     * Adjust MPIDR like 64-bit KVM hosts, which incorporate the
> +     * GIC's target-list limitations. 32-bit KVM hosts currently
> +     * always create clusters of 4 CPUs, but that is expected to
> +     * change when they gain support for gicv3. When KVM is enabled
> +     * it will override the changes we make here, therefore our
> +     * purposes are to make TCG consistent (with 64-bit KVM hosts)
> +     * and to improve SGI efficiency.

32-bit KVM hosts are dead a long time, so we could definitely trim
this comment to at least remove those sentences. We'd also have
to double check arm64 KVM to see if the comment is still accurate,
since the comment is so old. Or, we could just delete the comment.

Thanks,
drew

> +     */
> +    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +        clustersz = GIC_TARGETLIST_BITS;
> +    } else {
> +        clustersz = GICV3_TARGETLIST_BITS;
>      }
> +
>      return arm_build_mp_affinity(idx, clustersz);
>  }
>  
> -- 
> 2.47.1
> 

