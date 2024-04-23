Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A84BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 17:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzK5P-0000Cp-O1; Tue, 23 Apr 2024 13:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rzK5O-0000Cf-9e
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:37:42 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rzK5M-0004K5-F7
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 13:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713893857;
 bh=m8raZZ7KgNCqY7RsIKeE/4W/5Fvf6z4P+Aw5YFE5KT4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PBd830VI1eqn1Z/YoXTTGbtWGajOe9E2tSzKVl+FmISWNldMx3lHelvokecqeC3fA
 iXTKItr0Jog1yBJdDInJZyiLXmRRjSS2jt9AlDNrUOHC3VDBVa1JmYVN7r6PoHtIMC
 Hm24SJVDtcvfAigcLI5vLjCd7P+m2GbAo9afEC/xf2beLdw6afemZ7NFHmLzTrkTII
 nxMshP8KSWFHS+gYeO1v+4ot/H1ZV23wwASk5a/weezhVcrL/eWZD6ZQxlB0tvCkJK
 wUcDeNqfalzOmB1pKDEflf87RuvLdHLZRDauBBpehz7J5oNfVbKdivpm2ldkGeNM8d
 r3+N2tLsMG+Uw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4FA47378212F;
 Tue, 23 Apr 2024 17:37:35 +0000 (UTC)
Message-ID: <77e78ba1-3900-4193-9132-ed5fc6135987@collabora.com>
Date: Tue, 23 Apr 2024 20:37:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/11] Support blob memory and venus on qemu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <87jzkoqy59.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87jzkoqy59.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/23/24 11:30, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> Hello,
>>
>> This series enables Vulkan Venus context support on virtio-gpu.
>>
>> All virglrender and almost all Linux kernel prerequisite changes
>> needed by Venus are already in upstream. For kernel there is a pending
>> KVM patchset that fixes mapping of compound pages needed for DRM drivers
>> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
>> from Qemu.
>>
>> [1]
>> https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.com/
> 
> Following the link for the TTM/KVM patches on the kernel side points at
> changes for AMD cards getting NAK'ed so I'm a little confused as to what
> parts are needed.

I wouldn't say that patches are NAK'ed, they more having a problem with
getting a review. Without KMV patches host blobs don't work depending on
a host GPU driver and kernel configuration.

It's actually not only TTM drivers that are requiring the KVM changes,
but a non-TTM GPU drivers that use huge pages may also need them too.
You may need a patched KVM for i915 driver that doesn't use TTM,
depending on whether transparent huge pages are enabled in the kernel
config.

> Is this only relevant for ensuring the virtual mappings to the
> underlying hardware aren't moved around when KVM is exporting those
> pages to the guest?

Yes, host GPU driver needs to handle guest access page fault to keep
pages in place.

> Our interest is in Xen which obviously mediates everything through stage
> 2 mappings to from the real PA to the IPA the domains see. However AIUI
> all the blob allocation is managed by the GEM/TTM layer of whichever
> kernel is responsible for driving the GPU. Does this layer work with
> kernel vaddr or the underlying IPA of the resources? We shouldn't
> expect the IPA to change between allocations should we?

TTM works with memory pages and it moves pages around. It may swap out
pages and then relies on a working page faulting notification to swap-in
pages back.

Whether PA stays fixed, I don't know for sure. Robert Beckett or
somebody from AMD should know better how it works for Xen and may
comment on it.
-- 
Best regards,
Dmitry


