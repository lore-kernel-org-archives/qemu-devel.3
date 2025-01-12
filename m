Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAECE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 15:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX0EI-0000Yd-Pr; Sun, 12 Jan 2025 10:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tX0EE-0000XU-OO
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:50:18 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tX0EC-0005Mj-G2
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:50:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1736697006; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GtiPogtF/lf+dHVFijDTuQFYSCiIw7vdR4uB4Vbg09md2jz+k8YwNcgley/39+5IomPD3SVwA3Ni8T5aqZJHcdMaewrapSmbb7KHX651fn3AUuDuFEJvoYoCKhkYiz/j/nOdRPZfQ7wzt1mpLP3+5Q8jnVzlmysRder4BJWAM3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736697006;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vNHnONesPikNH/QGxGO2DcbLqI/5rWRDd5t9FnkPjTQ=; 
 b=G0YvyxI2PUHVuxZhp9GUNCyOexI9V49y8lanQlOzv98Tij1kokJFkGqnNAWxyE4J/lVlOC0DvgYnlkS1/EywYZ2/N4kORdG5yX694cN38T9NMsxjXlPwWa2hvdi8LJpYmW7Lxy0MuzRyo1kdyVnjb4kv/q0zD399Z0bmAXormsU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736697006; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vNHnONesPikNH/QGxGO2DcbLqI/5rWRDd5t9FnkPjTQ=;
 b=b/CVDnjxcORJ1OMFdXHgQAuHF1taPkuuLFQnDGz9FnJ1j5J4gKopc3FPNbYxKmrP
 KHc5JTcUJ4DtnE/7B5Q9Onp4khBpEpTue3do8599BMzooP0n5rzW2CrJBkXzQ87Gu6g
 HUF3IbzEOlHPUULzM7A9UsyoxLVXOcSTWw296mFI=
Received: by mx.zohomail.com with SMTPS id 1736697002808231.28755573184264;
 Sun, 12 Jan 2025 07:50:02 -0800 (PST)
Message-ID: <59cf10d1-25a6-4f7d-b6a8-6d6e82fc52ff@collabora.com>
Date: Sun, 12 Jan 2025 18:49:57 +0300
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
 <87o70e50ff.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87o70e50ff.fsf@draig.linaro.org>
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

On 1/10/25 15:16, Alex Bennée wrote:
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
> 
> Can we detect if virglrenderer has support at build time?
> 
>   [drm] pci: virtio-gpu-pci detected at 0000:00:02.0
>   [drm] Host memory window: 0x8000000000 +0x100000000
>   [drm] features: +virgl +edid +resource_blob +host_visible
>   [drm] features: +context_init
>   [drm] number of scanouts: 1
>   [drm] number of cap sets: 2
>   DRM native context support was not enabled in virglrenderer
>   qemu: virgl could not be initialized: -1
>   [drm:virtio_gpu_init] *ERROR* timed out waiting for cap set 0
> 
> is a poor failure mode at runtime.

It's not possible to check at a build time whether virglrenderer is
built with DRM support, there are no flags for that. There is no
build-time dependency on DRM for Qemu, hence such flags were never
needed. You can rebuild virglrenderer with enabled DRM support,
rebuilding Qemu isn't needed in that case.

In general, it should be up to a package maintainer to enable required
virglrenderer features. It's more a Qemu's design problem that it can't
initialize virglrenderer earlier, before starting VM, IMO. Overall,
don't see a problem to address here.

-- 
Best regards,
Dmitry

