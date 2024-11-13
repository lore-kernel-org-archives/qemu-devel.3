Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E43CD462AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 14:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBEO2-0008A8-Db; Wed, 13 Nov 2024 09:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tBEO1-00085E-2B
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:30:25 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tBENz-0001Ao-4n
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 09:30:24 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1731508206; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QLdn7/9zCnvUf/Cm3iKKo6pMFxiZfxAwdTiq4dOa8m/ChoybltkdVk503R0Rs0nPyDW7Ogci1VF1rJh7SkEX/8OrqU+eHXy4cMx1/BqMa2+IMUp3cl71hLYlILjeM7k2ZqpkjD9+6x0vHIExdS8XAU9mMjNbGZCTOZkkEYb35NA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731508206;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=umHYIoXT/ACnCV1Gc7hBYbUGOqNO/2GMk+4MAnyj3p8=; 
 b=QE7wuQJJ1PFF6ETMUxeqDByl95gOYIgVrc4aWpNcEX+/wqJlfoUuR/QVgzJz+mPyCubfLt/wOE10Wd9KPyoPRCAmajqt8jZH5MAw+0aAc6HQv3gmfJvFLngI1b2SJUuddLE7xRVyQ0nICMF4PKPYJM2DvxOaT9/pP86rwx1ZbU8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731508206; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=umHYIoXT/ACnCV1Gc7hBYbUGOqNO/2GMk+4MAnyj3p8=;
 b=HSCUDaBro+Ygn+fzZYbNk1Syb3PDLkMr5mIqKKp3OJq8rns5vwBTHbduoIhbWfw4
 JjGUsm0omFaASjVjrUk2500b8p/wqS6HXiKqSsLrQtJ4trKPmvH9i4pAQEd1dCJn6pA
 IjESuejkQsLob4QG+Lz8Kthp8aAyUl9ta/YAiNDE=
Received: by mx.zohomail.com with SMTPS id 1731508204395718.4938699731001;
 Wed, 13 Nov 2024 06:30:04 -0800 (PST)
Message-ID: <e4eb3609-354d-4a12-9f64-4957f08fe4d8@collabora.com>
Date: Wed, 13 Nov 2024 17:29:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] virtio-gpu: Support DRM native context
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
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
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-7-dmitry.osipenko@collabora.com>
 <87sescin4u.fsf@draig.linaro.org>
 <91c98764-c9ab-4299-8bbb-2d1a60e4d73c@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <91c98764-c9ab-4299-8bbb-2d1a60e4d73c@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/11/24 08:25, Akihiko Odaki wrote:
>>
>> I feel like using "drm" is confusing in this context because drm exists
>> for the host and guest. What about "native-context" or even
>> "context=[opengl|vulkan|wayland|native]"?
> 
> The terminology in the specification is "capset". Multiple capabilities
> can be enabled at a time (e.g., DRM and VENUS) and we don't have a means
> to express that with one property.
> 
> The best option I came up with is to strip the VIRTIO_GPU_ prefix from
> definitions in the specification. i.e.,:
> 
> VIRTIO_GPU_CAPSET_VIRGL -> capset-virgl
> VIRTIO_GPU_CAPSET_VIRGL2 -> capset-virgl2
> VIRTIO_GPU_CAPSET_GFXSTREAM -> capset-gfxstream
> VIRTIO_GPU_CAPSET_GFXSTREAM_VULKAN -> capset-gfxstream-vulkan
> VIRTIO_GPU_CAPSET_VENUS -> capset-venus
> VIRTIO_GPU_CAPSET_CROSS_DOMAIN -> capset-cross-domain
> VIRTIO_GPU_CAPSET_DRM -> capset-drm

Reasonable, thanks for the suggestion.

-- 
Best regards,
Dmitry

