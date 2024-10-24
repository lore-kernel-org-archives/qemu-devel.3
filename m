Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBB5CE8E96
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t41OF-0003YO-8K; Thu, 24 Oct 2024 13:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t41O5-0003Xn-BO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:12:41 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t41Nz-0005IO-4Q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:12:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729789941; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BtCM/3Qt5IzJPPU2+eaMQft2Ogw/wSVZhS3NsTlc5+Q7cFk0zzMC1uY9VacApae9SF0eBj+EH3FjwyM3JeP/4ysQPAsms0lh7jGpTnDNwPBV2ZhTFP8Ln0FR3ZWAUtKVicNBdIM5R+ftxcyWpLwDytV7V/rxEgOoJbNkNqPPYEc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729789941;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=W8qWYjcx4dCY34WPhTY+t5DtggQ9NQcfFfCnMwKoW/E=; 
 b=QKtX7BUk/3LPf2JmeE64p1WmM8ZTQOrvG5VxPWMFCAUGepVtT51obYiiRRZsOiPDmuHZqG5LMRJnplgGx2+Hl2xLrhJuWB/Z+nzXraYSseop/Bx5jm9K+KDRDFCfAf3AWFr8idmuJE43Q1yKHDGd6tBh4hz/xCg9luvohMpEO9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729789941; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=W8qWYjcx4dCY34WPhTY+t5DtggQ9NQcfFfCnMwKoW/E=;
 b=ct2d8ThbMMiX1E6i1erspgHKrJqOtWun4oiPvjcrz93wTks0se1Gvr0xgGb1JwYp
 20KtTXv4BEAP3Pf90vRAJA8nm6hJ9JE8neE+ZVI6uT6OjJ+dqEyhAx3fAe5jhQGdgBI
 r8vQsbht/Ae2Z8fIgiQpEM4QGdV08qZJ6jpOLijI=
Received: by mx.zohomail.com with SMTPS id 1729789939664249.83591850225548;
 Thu, 24 Oct 2024 10:12:19 -0700 (PDT)
Message-ID: <ad3ef8bd-f78b-4ceb-9e2d-6653e9866159@collabora.com>
Date: Thu, 24 Oct 2024 20:12:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Support virtio-gpu DRM native context
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
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
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <87ikthke2i.fsf@draig.linaro.org>
 <999ae767-41ab-49aa-a3b6-bbe2d63164d8@collabora.com>
 <87v7xhis9k.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87v7xhis9k.fsf@draig.linaro.org>
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

On 10/24/24 15:45, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> On 10/24/24 13:09, Alex Bennée wrote:
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>
>>>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>>> It's based on the pending Venus v17 patches [1] that bring host blobs
>>>> support to virtio-gpu-gl device.
>>>>
>>>> Based-on: 20240822185110.1757429-1-dmitry.osipenko@collabora.com
>>>>
>>>> [1]
>>>> https://lore.kernel.org/qemu-devel/20240822185110.1757429-1-dmitry.osipenko@collabora.com/
>>>
>>> Now the tree is open are you going to re-base with the tags and get it
>>> merged? We don't have long before softfreeze for 9.2!
>>
>> The Venus patches apply cleanly to the latest base. I'll re-send them
>> today in a hope that it will speed up the merging process. Thanks for
>> the heads up.
>>
>> Patches should be waiting for Michael Tsirkin to press a button to get
>> them merged. On the other hand, I now see MAINTAINERS says that
>> virtio-gpu status is "Orphan", thought Michael/Gerd are in charge of it.
>> Does it means that any QEMU maintainer with a commit access could help
>> with applying virtio-gpu patches?
> 
> In theory although it would be better if we could find someone to
> step-up to maintainer duties. Could that be you?

Potentially, yes. I'd be happy to help. Though not earlier than next
year as I'll be on a quite long vacation soon'ish, will get in touch
with you.

-- 
Best regards,
Dmitry

