Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D260CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxUu-0000AV-Ir; Mon, 17 Nov 2025 06:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKxUh-0008TA-6K
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:34:05 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKxUf-0000xj-Hj
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763379223; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nmI583AZTlKcvuIceseqEj3NYF+RtQOJIcQZF/2iwpeKrOlxL7BejxRRVat2kLkl0CZp4rLQOqYRPyIIJ9SSg8Eatm7rDDrP/9xZHBUWNAx/SBy08Z72LoSCYuSUQxd7XAUG29nrTEPHFXXPmXiezBcfDyYvV48fP3n4SDn4kME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763379223;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nYKvv6406nbEhE1Kb8OHCdOEeyYdNFpS/bMis8lu3fs=; 
 b=Y17g0I4FT/ayeQBT1vIII5g60yMyYCiyE3nWkL9E/jnfEEs5PIMRtXOGKKT/SeMynb4kINa9drjcJXEmUeR4ZK/w7f1jOvzql01WXTpVQvQCU76vUrOUNA8hN/MbVNptuoiiCkBO2BkoU+7i5mh1JRs5v53TR3g/+B85FZw6FQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763379223; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=nYKvv6406nbEhE1Kb8OHCdOEeyYdNFpS/bMis8lu3fs=;
 b=lR8WxAc4R+HKPYbXjC8jagTW1U1HQy8mUbAVZ8WqXGYBK0qriT2Sq1cXJ/YqwuU2
 xxzAknVVR1qeWcKRlauIwUYW4LcTUqAGmO4MtoNusXANdpZpWTiZknVQrt7z7hqcpb/
 4ijXYdPrL0Gozaiz241JyofHKTBCpVVAOXdVuWHk=
Received: by mx.zohomail.com with SMTPS id 1763379221810378.50321908854664;
 Mon, 17 Nov 2025 03:33:41 -0800 (PST)
Message-ID: <145b7a70-6b92-450d-9ea8-e618eefa85c7@collabora.com>
Date: Mon, 17 Nov 2025 14:33:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] Support mapping virtio-gpu virgl hostmem blobs
 using MAP_FIXED API
To: Yiwei Zhang <zzyiwei@gmail.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
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
References: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
 <CAJ+hS_ijKWTWW1k1YU-US-EaJD8UCM8+zk2Jqq9cSBhss-s+GA@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJ+hS_ijKWTWW1k1YU-US-EaJD8UCM8+zk2Jqq9cSBhss-s+GA@mail.gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/17/25 08:56, Yiwei Zhang wrote:
> On Sun, Nov 16, 2025 at 6:15 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Virglrender got a new unstable API that allows mapping host blobs at a given
>> memory address using MAP_FIXED mmap flag [1]. Usage of this new API brings
>> major performance and stability improvement for venus and drm native contexts,
>> see commit message of the RFC patch for details.
>>
>> Sending early to collect review feeback and have patch prepared by the
>> time new version of libvirglrenderer will be released with the stabilized
>> API.
>>
>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1374
>>
>> Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com
>>
>> Changelog:
>>
>> v2: - Addressed v1 review comments from Akihiko Odaki
>>
>>     - Added patch that removes unnecessary memory_region_set_enabled(),
>>       suggested by Akihiko Odaki
>>
>> Dmitry Osipenko (2):
>>   virtio-gpu: Remove superfluous memory_region_set_enabled()
>>   virtio-gpu: Support mapping hostmem blobs with map_fixed
>>
>>  hw/display/virtio-gpu-gl.c     | 45 +++++++++++++++++++-
>>  hw/display/virtio-gpu-virgl.c  | 76 ++++++++++++++++++++++++++++++++--
>>  include/hw/virtio/virtio-gpu.h |  3 ++
>>  3 files changed, 119 insertions(+), 5 deletions(-)
>>
>> --
>> 2.51.1
>>
> 
> Nice work! I'd say Venus loves it soooo much ; )
> 
> Tested-by: Yiwei Zhang <zzyiwei@gmail.com>

Thanks!

-- 
Best regards,
Dmitry

