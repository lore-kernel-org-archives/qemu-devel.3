Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89EFC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 12:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taZnb-00011j-5i; Wed, 22 Jan 2025 07:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1taZnZ-00011R-6G
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:25:33 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1taZnX-00059U-8K
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 07:25:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1737548716; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gco2NJ+ppndj3eyrfTDU1X5X5wpIFeR/OES1JdNxbY7cNaHMPwKhNv6eAXDprOpkrJG/+Q/p8mJFg7/RlpC53AB1UD5R4HGBmqt+cQxPUthBkJjxibcdtkwH+yUgH60CrG9Y5gC1J4UuT778PGemp0vZnDvwUUQ9rYYC5aVWThw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1737548716;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aeL3pKVgxdVJAHyAkM4qtzvjecypl5g5T84vRGLboQI=; 
 b=dz5wbdclK1pHI6PpRT5CT8i0hYFGD2Z0W9cBIvP85HYrvITEqCtUFzoQ3MzEaCaznOwGknAFxi+DLylYoa5m9u/xcyAEmH0xDHrhmzKPjjHr4uJ6acOFLlqOP5EIpWAM244uZ3Cf60vqG2EOB817znOZqBTDH70VsnYSOFDxejA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737548716; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=aeL3pKVgxdVJAHyAkM4qtzvjecypl5g5T84vRGLboQI=;
 b=F1l8qvF3dJOcGr4FbRSwj75XXjRPWFjfyiVn23Em/1hRSU1j/2w2iocTyCrqlaUc
 r5eF/0YgFJmU5OlfuiG2nX9lHJVI1zre087Zyb+cg96b75vAr2UxLxunVSECKgU/8jS
 FzGqQ0D3oVkPOQ5H44UCg2yzT1FlUay5pxS3b2tQ=
Received: by mx.zohomail.com with SMTPS id 1737548714913397.03862598191154;
 Wed, 22 Jan 2025 04:25:14 -0800 (PST)
Message-ID: <f0f5efe3-6cc6-49fa-8d15-c16725380e89@collabora.com>
Date: Wed, 22 Jan 2025 15:25:08 +0300
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
 <871pwxqyr3.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <871pwxqyr3.fsf@draig.linaro.org>
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

On 1/20/25 18:41, Alex Bennée wrote:
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
>>   - Intel (i915), merge requests are opened
> 
> With the patch for the build failure:
> 
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Host:
> 
>   x86
>   Trixie
>   virglrenderer @ digitx/native-context-iris/a0b1872d252430a2b7f007db9fdbb0526385cfc0 
>   -display sdl,gl=on
> 
> KVM Guest
> 
>   x86
>   Trixie
>   mesa @ digitx/native-context-iris/78b1508c3f06
> 
> With gtk,gl=on I'm still seeing a lot of screen corruption which mirrors
> the terminal an leaves a destructive trail under the mouse cursor.
> show-cursor on or off makes no difference.

Thank you for the review and testing! I'm looking into that issue. Only
some people are hitting it and Pierre-Eric said he had that mirroring
issue without using nctx. Still interesting that the bug affects only
certain setups and is triggered by nctx.

-- 
Best regards,
Dmitry

