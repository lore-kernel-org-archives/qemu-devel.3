Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1939C02190
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduau-00082b-Lt; Fri, 31 Jan 2025 12:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tduas-00082S-Qx
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:14:14 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tduaq-0007p2-TR
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:14:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738343631; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aUGzWu3zTa2qPQB4f6NZT5qP24CIBnyC8aveXWB62nQJPG7c1feRO4OWI2u1vRKFpiQ0HEq/v0ILPa5l0U8yKlpYoMQfutbxnaM9lSFvYFBX9zopVOGZLkUoRbAsIsNxUDNNlq4n3CMdTQqjw+GlAlE+fy7Kfwd6sd+9WI+8xOE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738343631;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=kcvx+TEky8VUdORqbg7FPq96LuyRwD3bmaLUo7JbDBw=; 
 b=FPy0MAmA5Lh+E+i+0/j8VtH5enxmva3vBOY1vLjo1X6ET5U4Q/70UejJH51xK9F+gCY8E1V3/7A8sPU+IxIRw4t6eiUj7UuivR+LN1eQ5hdvCVcA/ps0OZVqb2XuF+SZjBtuSZyxNRI7v+Tbzdhod+oCH/nKpAOUkNpZMuxP8dc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738343631; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=kcvx+TEky8VUdORqbg7FPq96LuyRwD3bmaLUo7JbDBw=;
 b=Ol2fj9bCXh5T5JQcXeJO06ZKMWtCTWkd4p5eXEBvf0BLCVr9F0jUYu0A1/Xl2EAM
 MOIraV7uoWcIqO4mo2UDAC5bg+1nEeZlXq9intzO8j3BT5u87v03qavOxM8LTcNakNr
 1zzHuwWkKbimrE/acdIvCdwmMWxnXcpjdD1xxmXY=
Received: by mx.zohomail.com with SMTPS id 173834362508967.24507544752475;
 Fri, 31 Jan 2025 09:13:45 -0800 (PST)
Message-ID: <18bb7aa3-93cc-4a38-9641-31e6e988c64e@collabora.com>
Date: Fri, 31 Jan 2025 20:13:35 +0300
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
 <87cyg844fr.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87cyg844fr.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/27/25 19:17, Alex Bennée wrote:
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
>> Today there are four DRM native context drivers existing in a wild:
>>
>>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>>   - AMDGPU, completely upstreamed
> 
> Well good news and bad news.
> 
> I can verify that AMD native context works when I run my Aarch64 guest
> on my Aarch64 host with -accel TCG (therefor avoiding KVM all together).
> I get potato frame rates though (~150FPS) although I suspect that is
> because the PCI errata workaround.
> 
> When it comes to graphics memory allocation is there anything I can do
> to force all allocations to be very aligned? Is this in the purview of
> the AMD drm drivers or TTM itself?

All GPU allocations should be aligned to a page size. Alignment is
specified by AMD driver. I don't expect that alignment is the problem.
What's the size of your host and guest pages?

-- 
Best regards,
Dmitry

