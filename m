Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FB9E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 15:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX0KJ-0002oG-OY; Sun, 12 Jan 2025 10:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tX0KH-0002nk-RJ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:56:33 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tX0KG-0005xG-2H
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:56:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1736697379; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CgI1otSHVQhR/RObzC/9Fi/KwfnwbKLX7wmhsm/l2EHg2xOldYURhwlYLDzdPQkXKRDwVoqYZiawa9qErT7IYZQCIMCdw8S9/i3uzNvUu2XMloWClRzDjM4MZv/6ra6jvFJabGQWHyfmn7Yrm84iLNtXkMsp9vFjeMpkeywotmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736697379;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9CNMpKCKwqNzcbRrWx26tkTza5f6/UWf3JYTbXIbimg=; 
 b=fzjU6iSEO3Srxyiiu4UK3zN9WCGNHacEpRlszXPoYgGBLtnywE66LZCqHuWgfnbCfUvCf/E5nF40OKgn0O045K9dkKYkt7yePmHu3OjzsAQFFc25KtqATEB7UH2YDU6Ri6mOuCt8lVho66qRwu1kaEnsQPT7JdClYr44537u/A4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736697379; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=9CNMpKCKwqNzcbRrWx26tkTza5f6/UWf3JYTbXIbimg=;
 b=HdQuxAxrXEZjlVVzCGTNfh9seiKDuPxumKpyNLRvFEYr+ZSJHnkef4FI0zEIpxY7
 gU+mwPkiAAwmpQ2CorY/Ygji/1ccR/uVaT99PY2Pc5tQLqMl1dap9Npn1PNLoXIJwU/
 r/pIzXPN/i7Et4BCHCC+WjkTFhIOShCY4FJ+vp6s=
Received: by mx.zohomail.com with SMTPS id 1736697376368266.18873892709337;
 Sun, 12 Jan 2025 07:56:16 -0800 (PST)
Message-ID: <7337c00b-8835-45da-98c6-ba4d6639cb35@collabora.com>
Date: Sun, 12 Jan 2025 18:56:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Support virtio-gpu DRM native context
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny
 <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
 <87ikqm4wmp.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87ikqm4wmp.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/10/25 16:38, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>
>> Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
>> DRM native context [1] mediates lower level kernel driver UAPI, which
>> reflects in a less CPU overhead and less/simpler code needed to support it.
>> DRM context consists of a host and guest parts that have to be implemented
>> for each GPU driver. On a guest side, DRM context presents a virtual GPU as
>> a real/native host GPU device for GL/VK applications.
>>
>> [1] https://www.youtube.com/watch?v=9sFP_yddLLQ
>>
>> Today there are four known DRM native context drivers existing in a wild:
>>
>>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>>   - AMDGPU, mostly merged into upstreams
>>   - Intel (i915), merge requests are opened
>>   - Asahi (Apple SoC GPUs), WIP status
>>
>>
>> # How to try out DRM context:
>>
>> 1. DRM context uses host blobs and requires latest developer version 
>> of Linux kernel [2] that has necessary KVM fixes.
>>
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
>>
>> 2. Use latest libvirglrenderer from upstream git/main for Freedreno
>> and AMDGPU native contexts. For Intel use patches [3].
>>
>> [3] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1384
>>
>> 3. On guest, use latest Mesa version for Freedreno. For AMDGPU use
>> Mesa patches [4], for Intel [5].
>>
>> [4] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658
>> [5] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29870
>>
>> 4. On guest, use latest Linux kernel v6.6+. Apply patch [6] if you're
>>    running Xorg in guest.
> 
> Have you seen this failure before:
> 
>   ➜  ./qemu-system-x86_64 \
>                     -machine type=q35,accel=kvm,kernel-irqchip=split \
>                     -cpu host \
>                     -smp 4 \
>                     -device virtio-net-pci,netdev=unet \
>                     -netdev user,id=unet,hostfwd=tcp::2222-:22 \
>                     -drive driver=qcow2,file=trixie-x86_64.qcow2 \
>                     -serial mon:stdio \
>                     -m 24G \
>                     -object memory-backend-memfd,id=mem,size=24G,share=on \
>                     -device virtio-vga-gl,hostmem=4G,blob=on,drm_native_context=on \
>                     -display gtk,gl=on,show-cursor=on \
>                     -device virtio-tablet-pci -device virtio-keyboard-pci \
>                     -d guest_errors,unimp,trace:virtio_gpu_cmd_get_display_info
>   vmport: unknown command 56
>   virtio_gpu_cmd_get_display_info 
>   context 4 failed to dispatch CREATE_VIDEO_BUFFER: 22
>   vrend_decode_ctx_submit_cmd: context error reported 4 "gst-plugin-scan" Illegal command buffer 327735
>   context 4 failed to dispatch CREATE_VIDEO_BUFFER: 22
>   vrend_decode_ctx_submit_cmd: context error reported 4 "gst-plugin-scan" Illegal command buffer 327735
>   context 4 failed to dispatch CREATE_VIDEO_BUFFER: 22
>   vrend_decode_ctx_submit_cmd: context error reported 4 "gst-plugin-scan" Illegal command buffer 327735
>   error: kvm run failed Bad address
>   RAX=00007fb1e8fbefa0 RBX=00005649f1f4fb34 RCX=00000000fffffffc RDX=0000000000000004
>   RSI=0000000000000000 RDI=0000000000100000 RBP=00005649f2063710 RSP=00007ffe221807d0
>   R8 =0000000000000003 R9 =00007ffe22180808 R10=0000000000000302 R11=0000000000000000
>   R12=0000000000000001 R13=00007ffe22180800 R14=0000000000000002 R15=0000000000000001
>   RIP=00007fb20bfc3f7f RFL=00010202 [-------] CPL=3 II=0 A20=1 SMM=0 HLT=0
>   ES =0000 0000000000000000 ffffffff 00c00000
>   CS =0033 0000000000000000 ffffffff 00a0fb00 DPL=3 CS64 [-RA]
>   SS =002b 0000000000000000 ffffffff 00c0f300 DPL=3 DS   [-WA]
>   DS =0000 0000000000000000 ffffffff 00c00000
>   FS =0000 00007fb203aace80 ffffffff 00c00000
>   GS =0000 0000000000000000 ffffffff 00c00000
>   LDT=0000 0000000000000000 ffffffff 00c00000
>   TR =0040 fffffe67eec85000 00004087 00008b00 DPL=0 TSS64-busy
>   GDT=     fffffe67eec83000 0000007f
>   IDT=     fffffe0000000000 00000fff
>   CR0=80050033 CR2=00005646b7f7d018 CR3=000000012852a000 CR4=00750ef0
>   DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000 
>   DR6=00000000ffff0ff0 DR7=0000000000000400
>   EFER=0000000000000d01
>   Code=f3 0f 11 40 58 f3 0f 10 43 08 f3 0f 11 40 5c f3 0f 10 43 0c <f3> 0f 11 78 64 f3 0f 11 50 68 f3 44 0f 11 40 6c f3 0f 11 48 70 f3 0f 11 60 74 f3 0f 11 40
> 

The Qemu args look sane.

Don't remember ever seeing "vmport: unknown command 56" messages.

The CREATE_VIDEO_BUFFER errors are fine, VAAPI is disabled by default in
virglrenderer.

The "kvm run failed Bad address" will happen if you're running older
pre-6.13 host kernel that don't have KVM patches. Any chance that you
booted with a stock distro kernel by accident?

-- 
Best regards,
Dmitry

