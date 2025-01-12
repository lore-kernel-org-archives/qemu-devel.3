Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFE5E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 15:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX0D4-0008Kg-3B; Sun, 12 Jan 2025 10:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tX0D0-0008KU-DR
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:49:02 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tX0Cy-00058m-Nk
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 10:49:02 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1736696925; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XhkFQwSH1vflGcOHyDkw+Wv3rN5F8OFBxpHMitCXyP8jPzNx4sLo+wXFZc8pFaoAKR7AY/auIf9zzi+rphx8VSUNpkEwzOMS67/G3UiEmJOubytlH5bNv6VAKcDahqz3mpErHovdXrHlV7H9gYWP8C9mhqyo+rNgPNk2PUqWJro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736696925;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KKNwhc56JfrDXz/56C882MhpAk/RuIUiBVEG67eCGa8=; 
 b=BmS3hsIxxyicWJ06JS2bTnEH1n/VFQ+qCWHKEcFxtIB9H8GzRj5n25VKtyOa4mWx86IE7wLKKo71YDmuGsp76Q8WqD6HNPk/fIBQ34Vd+uemFpOt5uRUlpoG/oXsgCCYFoqSqPi+w9nrpYinr8vgOUJpZmAytG+R/phYX2apHIg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736696924; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=KKNwhc56JfrDXz/56C882MhpAk/RuIUiBVEG67eCGa8=;
 b=Kn5RB76lRZekx7wwjdhZ76Rg7hkov0NMOiVIvP+adV1Rg9jh0FaME+3fwNcxfgaz
 hkr229nyPkItrKd4VSyiAvx/pcbyD1myoYTToXD62Zu9o+BYSwprKE522ptyIpTOguu
 h2hwj/P6iOcnVh8rm4mCSb2rB+hcQPXEHfh2Rt54=
Received: by mx.zohomail.com with SMTPS id 1736696921161572.5779411819628;
 Sun, 12 Jan 2025 07:48:41 -0800 (PST)
Message-ID: <bcc3b08e-751f-4167-9af9-e98da4ee9dc8@collabora.com>
Date: Sun, 12 Jan 2025 18:48:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Support virtio-gpu DRM native context
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
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
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
 <20250108081322-mutt-send-email-mst@kernel.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250108081322-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
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

On 1/8/25 16:14, Michael S. Tsirkin wrote:
> On Mon, Nov 11, 2024 at 01:18:32AM +0300, Dmitry Osipenko wrote:
>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>
>> Contarary to Virgl and Venus contexts which mediate high level GFX APIs,
>> DRM native context [1] mediates lower level kernel driver UAPI, which
>> reflects in a less CPU overhead and less/simpler code needed to support it.
>> DRM context consists of a host and guest parts that have to be implemented
>> for each GPU driver. On a guest side, DRM context presents a virtual GPU as
>> a real/native host GPU device for GL/VK applications.
>>
>> [1] https://www.youtube.com/watch?v=9sFP_yddLLQ
>>
>> Today there are four known DRM native context drivers existing in a wild:
>>
>>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>>   - AMDGPU, mostly merged into upstreams
>>   - Intel (i915), merge requests are opened
>>   - Asahi (Apple SoC GPUs), WIP status
> 
> Took a quick look, looks ok
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Gerd, you gonnu pick this up?
> 
> Dmitry, if you will post a rebase, I can apply too.

Thanks! The plan was that Alex will test this patchset on his setup and
then either he or you will apply it. Will post the rebased version too,
there is a minor merge conflict with the latest Qemu tree now.

-- 
Best regards,
Dmitry

