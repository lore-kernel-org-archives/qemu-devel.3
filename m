Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F52E6FE27
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smavf-0000li-Ck; Fri, 06 Sep 2024 11:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smavY-0000k2-KE
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:31:14 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smavU-0005sb-R7
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:31:12 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdbe4728so2337698a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725636667; x=1726241467; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FSMFPCKRM72gF/O6rl0xrBVl8EAYOMwC35frHo9+pq8=;
 b=F7Ng0//8CFWv+HaQSb8+6q7U6FAebDtB/OpSHH+eqN3wb7B5WwDnpsfwArYTbD+U7D
 1yqsmr6N1AtwN+GdGc1kiSOdMDqgOSEMLiwsQVYQRo+EdnC3P2gWw3URCWXnpR3AkUPY
 oDlzfJOLDpr7QKUg4xQ6dRJ1bzeqBRxbxhlWtyc5EliiZ5CCVYa8pSa4EHt1/Hvwzy58
 uDy/kNijPvkx2DP1XeoANwKoZ+KtsIt02nY4bUHUfuLJJ62PEU87/O3qs2JmuZRw+eXi
 YbUb3/PdBZLhKisvrSgFdXZInAwWz168MQcPjSvxTCqSFXwqRdcjSJi+DFI1qriM2bfx
 hLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725636667; x=1726241467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSMFPCKRM72gF/O6rl0xrBVl8EAYOMwC35frHo9+pq8=;
 b=XiyxpBXKsLroXSvLK9wajdODjz0ECg9a2XkR7QYPTWvKrrdr/i3Gog1r57H2mAomtl
 GZ6qi3SSwkveuCXz5aZ8NNoHApL5spvf64Wwl86I3KqS3phE2Yy7JHGOjSiDjhvvZDA+
 /jex/dxaZZK6OCOsxK8L4uIBiA9W52e+Wp52DN/dMqGePu1TIJEsgrBmffMMyTSUV3fl
 0Wm2YXrpUNBmQRhCD2UVqambJlLE+f6Aujj0AjFMwkuu6ggmR3tDY3a9T3S8pVef/4cl
 oGWv2gCehgPJirfaQFb6dzrFFipUonX0Spll2fmdHep1NEPAgzf2kJUQ48BzqdNOzs2Y
 qhRA==
X-Gm-Message-State: AOJu0YwXPXZhFTEItB1+wKxPLs+92itG02y0FCcAhKN4QfA80nDuVxg5
 qugMa0QwzMuMeGOhlUOd6E6ISXZArAP9/qx5Cbk02PcO15hdnZdmjiIXrhMLiY6NSB42tc41s+0
 WrjB2YdXUCCe6JeZXTb6Llja37Bl4u1VXNgg8sA==
X-Google-Smtp-Source: AGHT+IGzvcmGdHP8XRe3SG7oQwYiJouXPzPErWZehCySPGqr3CmZmFQTVpIpAyRSho7W+qLCrgCe0SnSQ0ffq6GmTH8=
X-Received: by 2002:a05:6402:5246:b0:5c3:5423:3d10 with SMTP id
 4fb4d7f45d1cf-5c354233f35mr6627677a12.5.1725636666944; Fri, 06 Sep 2024
 08:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240828111552.93482-1-danny_canter@apple.com>
 <20240828111552.93482-2-danny_canter@apple.com>
In-Reply-To: <20240828111552.93482-2-danny_canter@apple.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 16:30:56 +0100
Message-ID: <CAFEAcA9MWgPaJvPpvaQwRApa8NoKpUo-ozzBmKuPGREbkUhyUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/boards: Add hvf_get_physical_address_range to
 MachineClass
To: Danny Canter <danny_canter@apple.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, dirty@apple.com, 
 rbolshakov@ddn.com, agraf@csgraf.de, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Aug 2024 at 12:16, Danny Canter <danny_canter@apple.com> wrote:
>
> This addition will be necessary for some HVF related work to follow.
> For HVF on ARM there exists a set of APIs in macOS 13 to be able to
> adjust the IPA size for a given VM. This is useful as by default HVF
> uses 36 bits as the IPA size, so to support guests with > 64GB of RAM
> we'll need to reach for this.
>
> To have all the info necessary to carry this out however, we need some
> plumbing to be able to grab the memory map and compute the highest GPA
> prior to creating the VM. This is almost exactly like what kvm_type is
> used for on ARM today, and is also what this will be used for. We will
> compute the highest GPA and find what IPA size we'd need to satisfy this,
> and if it's valid (macOS today caps at 40b) we'll set this to be the IPA
> size in coming patches. This new method is only needed (today at least)
> on ARM, and obviously only for HVF/macOS, so admittedly it is much less
> generic than kvm_type today, but it seemed a somewhat sane way to get
> the information we need from the memmap at VM creation time.
>
> Signed-off-by: Danny Canter <danny_canter@apple.com>

> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 01fc5e6562..fa7a0f6b98 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -382,6 +382,8 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
>      mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
>      mc->kvm_type = x86_kvm_type;
> +    /* Not needed for x86 */
> +    mc->hvf_get_physical_address_range = NULL;
>      x86mc->save_tsc_khz = true;
>      x86mc->fwcfg_dma_enabled = true;
>      nc->nmi_monitor_handler = x86_nmi;

We guarantee that object and class structs are zero-initialized,
so we don't need to explicitly set this field to NULL.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

