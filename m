Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963A1D0E6EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 15:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNv2J-0006x5-2t; Tue, 25 Nov 2025 10:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNv2G-0006v9-Pl
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:32:57 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNv2E-0006Yp-PC
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 10:32:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764084756; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VCWFwwG+gI18rK5GcsI0VLVWEAiz/hQz51u7Ch7sCONUgDeqHuPIx+zC1DFMQte6QNu7jwpGVKbn1VDyapss7EPt0G07VwN1Q5d51OfQ0vO3Tj1iH8ouY0UV8nPGBsXrtyxvwOJ73koysVtOcL4nyoHgSK7wITAXFMhiZj9trlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764084756;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/GVHo103ACKpfm9gv8V940QNFGCrYbMfEpz3UZM8u0Y=; 
 b=Zu/MIgJG7UWQOHsjgXvImiO1yxbZUT5rCGyc+EkBwODJSIMpAJYjvLqwUc/SX1hrGJy0WEtZ7Bo80/yYQN25m6tn/ajuclVO9OB8rkOT1p/udMtf1uilwXtO0v/NDHa9ONupQy5KnbUdSb+5M6H49/o14JqLDjj3nSQ0a1pzKgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764084756; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=/GVHo103ACKpfm9gv8V940QNFGCrYbMfEpz3UZM8u0Y=;
 b=IHVwLmBTcIt7gYlhMY1ZrALAd+k1620814rRSgaT/2tnpsdPobz/j+BebfF3PfT+
 ye/1Que987Y8CZaJdhHdWBQa9zAeb5qzGwdN/p96+IuqeKeEZ0H2YDRcz+RQdxR4e9G
 GmxXfgzR5l/D7uyNKOVkKQC6o/206xMp8GALq8kY=
Received: by mx.zohomail.com with SMTPS id 17640847517505.25654896649894;
 Tue, 25 Nov 2025 07:32:31 -0800 (PST)
Message-ID: <fe171938-9c05-4636-a138-ee62a4eabc3b@collabora.com>
Date: Tue, 25 Nov 2025 18:32:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/7] virtio-gpu: Validate hostmem mapping offset
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-3-dmitry.osipenko@collabora.com>
 <8734628gz0.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <8734628gz0.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/25/25 14:54, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> Check hostmem mapping boundaries originated from guest.
>>
>> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  hw/display/virtio-gpu-virgl.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>> index a6860f63b563..2224f59cf5d7 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -126,6 +126,14 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>          return -EOPNOTSUPP;
>>      }
>>  
>> +    if (offset + res->base.blob_size > b->conf.hostmem ||
>> +        offset + res->base.blob_size < offset) {
> 
> This second check seems weird. offset + blob_size could only every be
> smaller than offset if blob_size was negative. I feel we should have
> caught that earlier if it can happen.
> 
> Are we trying to catch an overflow here?

The second check catches integer overflow for huge mblob.offset that is
u64 coming from guest. This wasn't caught before, we missed validation
of the offset value.

-- 
Best regards,
Dmitry

