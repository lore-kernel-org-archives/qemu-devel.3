Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9D6C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvze-0003Ni-4Q; Fri, 28 Aug 2026 08:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wzvzd-0003NZ-43
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:47:37 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wzvzb-0000xd-Lg
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:47:36 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3969e82ff8fso996832a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787921254; x=1788526054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RzPaqL4/mHAVqsKq27PDGFNe/OdVSsoGnuRREvrAOGo=;
 b=NwlbcIQoNjnUKIY8uQFjVW6M1naJ6X5VpveqIvUdvVEmEkGOMEtC2W+YdTZ/+keFgJ
 rVwdVwy4JFq2baKSyQilnUv6q3A2tDcriClATOSCULW8MAY7iht7L8tnv5Hde+xn6L8K
 W66AWm9oGH4d1b8b6or8n/pEihSz/AxJz8ZeEewIT9hV+nY6hqnxKI1O20ELBI7TBw5B
 PiyNR9+PmTYSchY+gOs42nRwd/js1z+Kg59UzaUzSt3yIU6lNPy3r3eAZVVyjKg275xg
 WAUJ3f1bmZzJTF9jK1BoJvGvNWd1MGuEysWdXR2LS+UaJNtO4TXcDeGQvXhdnwF7t99v
 VasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921254; x=1788526054;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RzPaqL4/mHAVqsKq27PDGFNe/OdVSsoGnuRREvrAOGo=;
 b=mSPCVIt7Uij5c64X98VdwjF5dN3atRcG4k5pTtPyvXKdEibeWUlssCQMJ5DZWvqhGk
 Z0VqJkobLunGBdcjAvM2wRmOk1DTad8u/iP9ijNXmz2tzXSiHD3jUXbegn3wqCsxWMV7
 jV3l9Wix67miFl/rfuqGSsTIfzLaL64mZsCTIiwAMrc497IXCuY/7qTY6u1RzZN6tyME
 5d3gq2RNvE9+/UFqE3VBc61/8IY8vO+Mp/qLx42xMDAXzArZq3v/jv4DeGduKXYzZyB9
 //P4vgXCzDOwE3BOU7pDybUFbweDguQO1kHciDGZOsM+d1vCRJETX36nWzcuCEvCGJt0
 z/Ng==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/DB/6evbhkVaaypB1PWWOmM3ZxTvxLoA4K17Mqn2M+ANL7+P6CVHngy2ux4SpLgfNSl2stkq697Ck@nongnu.org
X-Gm-Message-State: AFuF++mpus4BocQguiY04l1zECP0jq2hCJ4ldjQTN13oLg2pe+wGMnmB
 C1i0QjHU6e2EGRBYghm9ftQ8QRo82C7cqNDRjripI30PD4Xe7/4VLKdi
X-Gm-Gg: AR+sD13g63czOpzYJMi8ylPHWfIuBSWv5D+XLc+WGFMct+zQN0z8EAjkliF3i5DXelp
 LJXdtfSPB5vQa6SM4ZSLKso6ieIHqKtZH60SJINeSZDiCNkJgfqfWF+NfK612yBKa3J2wPTfnHH
 U/t0xXks9NFBwTlRKXC/C2+U/bYFplWiApOs4Bts5YYssOMQHyS4M2RC6kbYBUWWB4DxiWTeVRG
 VEenlZ527z62mQJiMeVOXCPnorUUz2R2OtukMaGSHJivaSsyUY7Qe/2XjUWppI+qaInh7VoEZ/y
 Nzz3nanSBc9g7bJLXEKnF5Wqw4zAZ2Qerv9/wuWrpKAdeKxGfVfxPU9HWQogPvSx3r/q1pjK7x+
 fephX08aLxj03icCK6Sgk5nlH9AGX2pOLfFXc6MnPCgx8a13bnVIVlmbu+fDWZ0rdymSbM2H3vM
 J0Qi7Hp93y7+VbBF2o9DNA4vq86JrDHL2Mj3rM4BQih0GghtWURSoaPmTpEhaTt2YgQYicZsXQg
 +6NidJmL83Z0ZeS251YkvryKg==
X-Received: by 2002:a17:90b:180e:b0:396:5c22:b1f1 with SMTP id
 98e67ed59e1d1-396d0e26ca8mr11478714a91.8.1787921253643; 
 Fri, 28 Aug 2026 05:47:33 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd0079sm7277481a91.5.2026.08.28.05.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 05:47:33 -0700 (PDT)
Message-ID: <2c5ddb68-b7c7-4f7b-9793-be0fc51f29c7@gmail.com>
Date: Fri, 28 Aug 2026 21:47:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu/virgl: free BHs and timers on renderer reset
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260827154355.3346449-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20260827154355.3346449-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pj1-x1030.google.com
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

On 2026/08/28 0:43, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> virtio_gpu_virgl_reset() does not free the bottom halves or timers
> allocated by the previous virtio_gpu_virgl_init() call. A subsequent
> virtio_gpu_virgl_init() overwrites the old pointers, leaking the
> previous allocations.
> 
> Fixes: bd9258917fbf ("virtio-gpu: Destroy virgl resources on virtio-gpu reset")

This Fixes: tag needs to be corrected. bd9258917fbf^ already reset the
renderer and re-entered virtio_gpu_virgl_init(), overwriting the 
allocations. That behavior began in 7e688d1bf515, so the current tag 
misses older affected releases. Please use:

Fixes: 7e688d1bf515 ("virtio-gpu: Handle virtio_gpu_virgl_init() failure")

With the Fixes tag corrected:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 0b79aef8d1f5..8bf6417c6514 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1425,6 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>   
>   static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
>   {
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>       struct virtio_gpu_simple_resource *res, *tmp;
>   
>       /*
> @@ -1443,6 +1444,11 @@ static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
>   
>       virtio_gpu_virgl_reset_async_fences(g);
>   
> +    g_clear_pointer(&gl->cmdq_resume_bh, qemu_bh_delete);
> +    g_clear_pointer(&gl->async_fence_bh, qemu_bh_delete);
> +    g_clear_pointer(&gl->print_stats, timer_free);
> +    g_clear_pointer(&gl->fence_poll, timer_free);
> +
>       return true;
>   }
>   


