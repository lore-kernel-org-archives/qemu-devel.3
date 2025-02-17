Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89736C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5Sz-00026L-Du; Mon, 17 Feb 2025 13:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tk5St-0001yy-1b
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:03:33 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tk5Sq-0004sV-5q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:03:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1739815388; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jtMRpG73FXiAS9Yhb3VFM8jQofpxc3zcwofuoO90lvhWHUCHnAomqHbHT/61wGUm3eisz4D1KCrcXg+QituXgRd3Jjawq045YWZgMG88+SdvZe8G3SbBx7BnCkxR7FBPgupyu6KPCnYWc4MjFBl67tvENQhU7QCkYsqRBjTV2Po=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1739815388;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=StZ+j9Bn6VQGEz9sNLSQ+A5EWQZynslB1DaE0phWMx4=; 
 b=bUOfI8aVOpEG5Nt6jdfFwx1PbojTWdR3HryttBoo7rufP1y5Pt9AVz0KQf07npdEfiOxWxaTXUtnI3m1UebAJYF4VeiryRqYAdb97mJS711ag8YgEr99HSAR7UfssGbGWBoa45NMQiQpPj/82lF4XE/vv9b2ECGJgh+EANeHiJU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739815388; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=StZ+j9Bn6VQGEz9sNLSQ+A5EWQZynslB1DaE0phWMx4=;
 b=bMo3MkrMi7qsQf5r0mNm3EHK1UPihUYE+M8BfISr8N9o6d+1KStRwsXbVS5bZCUi
 jEfDvicBzFrrHtRtJ266ts/UTGm4uKn/OiMPPyDvE56w7JiGsAElh7t+4b0bSBmYfah
 tUwH/3B8jQkKZ1UCkXNh898VBYZRnQ/RwsFvSrqo=
Received: by mx.zohomail.com with SMTPS id 1739815386177439.1455086184113;
 Mon, 17 Feb 2025 10:03:06 -0800 (PST)
Message-ID: <c6e5b341-12fb-4580-a9df-2a016f2571b3@collabora.com>
Date: Mon, 17 Feb 2025 21:02:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
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
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <8734ggpped.fsf@draig.linaro.org>
 <f58d250d-3831-4ff1-a018-f62f9aeb2527@collabora.com>
 <87bjv0lhok.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87bjv0lhok.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/17/25 18:22, Alex Bennée wrote:
...
>> This VK_KHR_display problem is only reproducible with your rootfs that
>> you shared with me. It could be a trouble with your build configs or a
>> buggy package version used by your rootfs build, more likely the
>> former.
> So you have built that latest vkmark? This is a recent addition to
> vkmark for the 2025.1 release.

Yes, latest 2025.1 from git/master.

> Does vulkaninfo --summary show the extension available for you? It is
> certainly available on the host side:
> 
> VK_KHR_display                         : extension revision 23
> 

Have it on guest with my rootfs, not with yours. I'd suspect problem is
with the your Mesa build flags, maybe you haven't enabled necessary
flags related to WSI.

..
>>> With drm_native I get a lot of stutter while running and barely 100FPS
>>> (compared to ~8000 on pure venus). IMHO we need to figure out why there
>>> is such a discrepancy before merging because currently it makes more
>>> sense to use 
>> If you'd run with Xorg/Wayland directly without a DE, then it should
>> work okay. This should be a problem with unmapping performance that I'm
>> thinking about.
>>
>> That unmapping problem is partially understood. Unmapping code works
>> correctly, but we'll need to optimize the flatview code to perform
>> unmapping immediately.
> Why immediately? Surely if we are unmapping we can defer it. Or is this
> a case of having stale mappings making the life of new allocations
> harder?

Unmapping currently works synchronously for virtio-gpu in QEMU, hence
deferring it blocks whole virtio-gpu up to 100+ ms. And if multiple
unmappings are done in a row, then it's 100ms multiplied by the number
of unmappings.

-- 
Best regards,
Dmitry

