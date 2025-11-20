Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45952CF8863
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM64I-0002DH-8c; Thu, 20 Nov 2025 09:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vM64E-0002D9-68
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:55:26 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vM64C-00021x-6D
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:55:25 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763650504; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LmsNH/EUHWsFKsn11u562A7EZVkPynuaC7C7if/+1F7Qg6MkeI9HXcYd+ENQLCjbixnorEzu1rTmA/2aJgmtEiSc2k/eOrFpfAl2ARVFbWe/u3mDZo8RLfz8ZsPRmZLw096SaZ8/682sXFdfxVLP4LAn+vG0T8mUO/hHUrJOER0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763650504;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GFPcDL17IIunLGbyTsX8w+sKZjuLQsXZwn4GtlEDc28=; 
 b=G5lda19m3UknrineYMkorm/8bsuafSUcg0QNwFhZaQBDmtsaPM6pkopYMq2vtrHHSKbofsDRPjQksN8f5Ilnm5CAVnWRTnmWSz2iBmUKjQPUa1/VsZu9PxNq3p7BNst8yOSzq5b8fIiip3XVFa2UZCxYjT62C9k3rkmHpgdbcPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763650504; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=GFPcDL17IIunLGbyTsX8w+sKZjuLQsXZwn4GtlEDc28=;
 b=aLzqLy355PcIWrDQPwOS1/7XpXrM+aCN9gDTdXgT1E2D3UG7cgCZJhHDXYkFB5qe
 WYQA3W4okkeKsrSevPWO/ELzebNaVHUZBy7udpY9jbkcyCXfZV0C8YpYlrqLegquNT6
 phZ2dlFEE0Raw66LNz6tLHSTFFDbqQeWeEUdutow=
Received: by mx.zohomail.com with SMTPS id 1763650502211123.17228119804327;
 Thu, 20 Nov 2025 06:55:02 -0800 (PST)
Message-ID: <00064b47-ca94-4eb9-a443-bb2739ed885a@collabora.com>
Date: Thu, 20 Nov 2025 17:54:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/7] virtio-gpu: Destroy virgl resources on
 virtio-gpu reset
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
 <20251120040632.4036204-6-dmitry.osipenko@collabora.com>
 <94e92cb0-3e5a-48e3-bf3c-12d27c23c27f@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <94e92cb0-3e5a-48e3-bf3c-12d27c23c27f@rsg.ci.i.u-tokyo.ac.jp>
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

On 11/20/25 08:07, Akihiko Odaki wrote:
>> +int virtio_gpu_virgl_reset(VirtIOGPU *g)
>>   {
>> +    struct virtio_gpu_simple_resource *res, *tmp;
>> +
>> +    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
>> +        virtio_gpu_virgl_resource_destroy(g, res, NULL);
>> +    }
>> +
>> +    if (!QTAILQ_EMPTY(&g->reslist)) {
>> +        error_report("failed to reset virgl resources");
>> +        return -1;
> 
> It shouldn't report an error if suspended.

Could you please expand on what you're meaning by "suspended"?

Suppose you're talking about guest's kernel suspension. There was a
discussion on [1] RE a need to use `x-pcie-pm-no-soft-reset=true` option
to avoid virtio-gpu resetting across S3 suspend-resume. This option
works with virtio-vga, but not with virtio-vga-gl device where VM hangs
on startup. So currently S3 doesn't work for virgl and needs further fixing.

[1]
https://lore.kernel.org/dri-devel/20250924194755.1265531-1-dongwon.kim@intel.com/

-- 
Best regards,
Dmitry

