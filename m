Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F24DC0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 11:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tavJt-0002vT-6e; Thu, 23 Jan 2025 06:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tavJs-0002vA-8K
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 06:24:20 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tavJo-0002Ak-J4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 06:24:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1737631441; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SdXWJcpDj07pRFlPzXWy1WDiXIjW+HMPcfKoigYlE/5YLOCzoZdTVp2pKzlYBTrzjULgYVwLWWfurSFcCjIbSktm54QU1I1X6yP5RWgs0L9fMPeAGEuS7Ga/P7blaRzwI8JOOc/GO85lfG7qVZjs8++lmPtIQp+k0LHSGxUkBcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1737631441;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=z4kGZnJ9mOaDzGLdYHfjgS5EwIsicC6M7Qi0ox7Xafg=; 
 b=U9F5AfCrmnOVVO0YQW3Dzlvgx38iBhwibwqOILziFSzv6SFTLAOa/3xWbAHM84VRlqzz70CkEfGLOGdY17JTqnoULSrdos2MIcybb7wwwNj0RxRsdg1aFuDTj+5D7PrOqb0t7oaSpNXpoLmN9BrUzri9JLNAnOGvwQ52clP23pY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737631441; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=z4kGZnJ9mOaDzGLdYHfjgS5EwIsicC6M7Qi0ox7Xafg=;
 b=Qn7zNyj+NBn1+/ppoFvun+U9DPjkVucxxPu7a0hjWTH0B0VLApWpMoU6Y/j26B1R
 oxletUMWkVS4j3hs57rm72VgTLHrUCO4IvJYJXXiUEGCHltjp2ic80TXahcTN/m0Gp6
 QgHrpHQR2gOGrZTEmvc5SRkpdDms6WG/1KDfPdwI=
Received: by mx.zohomail.com with SMTPS id 1737631435080590.2073650241499;
 Thu, 23 Jan 2025 03:23:55 -0800 (PST)
Message-ID: <f5c8e901-5d36-47b0-91d3-40699c51c259@collabora.com>
Date: Thu, 23 Jan 2025 14:23:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Support virtio-gpu DRM native context
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
References: <20250119220050.15167-1-dmitry.osipenko@collabora.com>
 <87jzamn5ri.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87jzamn5ri.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On 1/22/25 20:00, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>
>> Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
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
> 
> I tried my AMD system today with:
> 
> Host:
>   Aarch64 AVA system
>   Trixie
>   virglrenderer @ v1.1.0/99557f5aa130930d11f04ffeb07f3a9aa5963182
>   -display sdl,gl=on (gtk,gl=on also came up but handled window resizing
>   poorly)
>   
> KVM Guest
> 
>   Aarch64
>   Trixie
>   mesa @ main/d27748a76f7dd9236bfcf9ef172dc13b8c0e170f
>   -Dvulkan-drivers=virtio,amd -Dgallium-drivers=virgl,radeonsi -Damdgpu-virtio=true
> 
> However when I ran vulkan-info --summary KVM faulted with:
> 
>   debian-trixie login: error: kvm run failed Bad address
>    PC=0000ffffb9aa1eb0 X00=0000ffffba0450a4 X01=0000aaaaf7f32400
>   X02=000000000000013c X03=0000ffffba045098 X04=0000aaaaf7f3253c
>   X05=0000ffffba0451d4 X06=00000000c0016900 X07=000000000000000e
>   X08=0000000000000014 X09=00000000000000ff X10=0000aaaaf7f32500
>   X11=0000aaaaf7e4d028 X12=0000aaaaf7edbcb0 X13=0000000000000001
>   X14=000000000000000c X15=0000000000007718 X16=0000ffffb93601f0
>   X17=0000ffffb9aa1dc0 X18=00000000000076f0 X19=0000aaaaf7f31330
>   X20=0000aaaaf7f323f0 X21=0000aaaaf7f235e0 X22=000000000000004c
>   X23=0000aaaaf7f2b5e0 X24=0000aaaaf7ee0cb0 X25=00000000000000ff
>   X26=0000000000000076 X27=0000ffffcd2b18a8 X28=0000aaaaf7ee0cb0
>   X29=0000ffffcd2b0bd0 X30=0000ffffb86c8b98  SP=0000ffffcd2b0bd0
>   PSTATE=20001000 --C- EL0t
>   QEMU 9.2.50 monitor - type 'help' for more information
>   (qemu) quit
> 
> Which looks very much like the PFN locking failure. However booting up
> with venus=on instead works. Could there be any differences in the way
> device memory is mapped in the two cases?

Memory mapping works exactly the same for nctx and venus. Are you on
6.13 host kernel?

-- 
Best regards,
Dmitry

