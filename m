Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA20E6F070
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 17:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6vDn-0003YF-Ou; Fri, 01 Nov 2024 13:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6vDm-0003Xq-0X
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:14:02 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t6vDj-0006Xv-Ai
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 13:14:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1730481226; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kLJAoLnByRQOLlNktQB9F47NuQ510POMOOKpx83tCwauYYlEua2bTIhlrsCcELiO7mtk1LBszRNw2CJVkPrhm9MA0WRKJGEY3DI+Xwe6BDRfY4KtrpaSxsYVzamDSyJMf7KzA44nMP0Zj6p50AhnRJhlusnTxdT3QtmH4NYqQRc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730481226;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=O5Ua2Uo1iS4LvAyvi8urlZn2brbLWcxSpeX71RYSPdI=; 
 b=D+KSi0OChDLWvyUOaVYHvTdFH0TdrxQnmDl9t+ktTe09G2OWpZ7a7UIj6yZdgueGY+o+4sY9+oprzhL+uwRPf74UMaeFcVLP9BP10Wlvi+tORVImThOk+TWQDbPaiRclpi7KjqTPEOmv1Z0JNFs1MjgFiDHab29ipdkZ3nyhx1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730481226; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=O5Ua2Uo1iS4LvAyvi8urlZn2brbLWcxSpeX71RYSPdI=;
 b=SIqiN7PiI4HRgWvHoe1+5+9QXr0n/64V2oIIsRLV9Z12wO9EmjK2SGe1GGn01rSN
 lOMQZbVA/JvcbPBfX6jBInH8Trft8RrX6XMq+FXbwfQtA+vzuoIDqHcTOnXKqrSDHNG
 v7yZrXCPTcfP7i0vQHMR36D7RyOobb87egJ9fRpo=
Received: by mx.zohomail.com with SMTPS id 1730481223651851.1432063058376;
 Fri, 1 Nov 2024 10:13:43 -0700 (PDT)
Message-ID: <89fb3733-d1d9-44b7-8fdf-1a6c39864c05@collabora.com>
Date: Fri, 1 Nov 2024 20:13:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] virtio-gpu: Support DRM native context
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
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-7-dmitry.osipenko@collabora.com>
 <87sescin4u.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87sescin4u.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/31/24 13:26, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
>> using a new virtio-gpu-gl device option "drm=on".
> 
> I feel like using "drm" is confusing in this context because drm exists
> for the host and guest. What about "native-context" or even
> "context=[opengl|vulkan|wayland|native]"?
> The GPU command line is already getting complex so now might be the time
> to rationalise it.

Will think on it for v4, thanks.

> As an aside can mesa build the intel drivers on non-x86 systems as now I
> could potentially pass my native intel context to my emulated aarch64
> guests?

In general it should work. Don't know for sure how well Intel Mesa
driver works on ARM, suppose it should work okay because Intel now has
dGPUs. Intel Mesa driver has x86-specific assumptions, though maybe they
are optional for dGPUs. You may try to plug a DG2 card into your AVA
machine and report back :)

-- 
Best regards,
Dmitry

