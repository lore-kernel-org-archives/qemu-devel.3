Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60372CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 12:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmSC-0000ct-2g; Mon, 07 Oct 2024 08:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxmS9-0000cZ-TM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:03:05 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxmS7-0006eG-VC
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 08:03:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728302569; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Li/VUEN3zPlNzRAH4tlnx5SnXffCz1ns9k2NMgy8VcsfoP65RRmUWxDCh2aVy1M7K+KvfQ3mbnlUfNSHC+qS/3lSduHbzmYI7aZXm3xT+jGXy7mjsVpRi1nwfvarFrznzHwmK5brJFMYzFTvBp/yHg+8oYabv1iRFw6WevUa51k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728302569;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B1Gy+g3lq2nTQhM4/W81FsUms6mxGfQU2IvMKOcd6PU=; 
 b=FJYAcDn2RGLSqq6TH5acYG1rKUcrVhOtlYN4au9+4rl3Ujba9hn9xX7Y8YW9QX0ry2T9y2gf5aCLp7/a3hqbd5t3YujckH3guzATlRMi/PRf+baxEQdrADoWaoxnA86OyHoFRxiB/nnsY0B4z7tY4LBaW4lWyCoR2kBcUZsCuRo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728302569; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=B1Gy+g3lq2nTQhM4/W81FsUms6mxGfQU2IvMKOcd6PU=;
 b=KTksa60kcX7XPVvg84DHIbnnONm0P72ijLNlVmXpNECEQUK6Sm8PsweNoXWfmKuG
 4pxKpGUvuT0ICFfA2qBcgUGdExxoe3TS33CSILdGeRPVGI5A0HDd+Zn84cgrIVr6GCd
 jTXkAJWc3dnomCTtGMf6qKSBPbUwGkN89h1PtDAc=
Received: by mx.zohomail.com with SMTPS id 1728302567327113.37981275804145;
 Mon, 7 Oct 2024 05:02:47 -0700 (PDT)
Message-ID: <e01ffbc1-31a2-42d9-9004-17b86462e2df@collabora.com>
Date: Mon, 7 Oct 2024 15:02:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Support virtio-gpu DRM native context
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>
References: <20241006232350.3198759-1-dmitry.osipenko@collabora.com>
 <1bd2bf2c-41a8-40f4-a086-17e7fbb21682@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1bd2bf2c-41a8-40f4-a086-17e7fbb21682@daynix.com>
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

On 10/7/24 12:48, Akihiko Odaki wrote:
> On 2024/10/07 8:23, Dmitry Osipenko wrote:
>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>> It's based on the pending Venus v17 patches [1] that bring host blobs
>> support to virtio-gpu-gl device.
> 
> Hi Dmitry,
> 
> Thank you for submitting this series.
> 
>>
>> [1]
>> https://lore.kernel.org/qemu-devel/20240822185110.1757429-1-dmitry.osipenko@collabora.com/
> 
> Please use Based-on: tag.
> For details, see: docs/devel/submitting-a-patch.rst

Thanks for a very quick review! All the comments are good to me, will
address them in v2.

-- 
Best regards,
Dmitry


