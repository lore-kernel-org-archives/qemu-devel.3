Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CA4EB7EBC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjZ0-0003ex-4f; Wed, 04 Mar 2026 05:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxjYw-0003eL-H7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:34:43 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxjYt-0004dM-7B
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:34:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772620463; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RejYSLAI2wKP4kZDRJBIaxyiWxRapU7Jzl3iQOEPrGvt8toMB1uxp8ZzxfePAFT1+6c7+/UzZLtXmWg0BvU6YT15wZnrf1mMUnHQEqqMijvsyKjw5KYByBVZ7GcRNv/eI8B673gX7YSZ3TNxrRqjEwremuycrEFUEGJIj1tWaGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772620463;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4tV5EHQ32aKSKCniJ6eSgOJYpBw1p3H1vQmvi4MK+a0=; 
 b=Y1mcSj9EzAmbuDAjErrEQSYdHXnPRSee7rUHYsWcXEbkm1zIlRA6eCQs2tjC443G/Mxv75G2Z1T83ZZ5qdczgj91lZbxhuce/Yqzih3x9wY93jTm8SDxxuiInNzKFvlfQs6GDmOJl1egBvsixCTm+OwoXBlebWqhVeS+5bqHiyA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772620463; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=4tV5EHQ32aKSKCniJ6eSgOJYpBw1p3H1vQmvi4MK+a0=;
 b=G5R9W28x1Nv2tYNYGOGeAIZh2L9p/K5t/OKiTFqOUzRQKeGzUg3P8XlVp4H5PrVY
 wXr3TZhsdgzZGdlZlvc09c/ldnPtewG2K+y0Zv5WxEN9D2eic4b/bf5ymHgCvjCYHY6
 hmfbL2A9+4WLloitD60g16nwcNHJyUwHKndh4N2U=
Received: by mx.zohomail.com with SMTPS id 1772620461057770.9760435478521;
 Wed, 4 Mar 2026 02:34:21 -0800 (PST)
Message-ID: <845a70b5-36a2-4a63-914c-162d6074b690@collabora.com>
Date: Wed, 4 Mar 2026 13:34:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 00/18] Support virtio-gpu DRM native context and
 MAP_FIXED API
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
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
 <6e087a75-4651-4953-83d6-864440b6db1d@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <6e087a75-4651-4953-83d6-864440b6db1d@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/4/26 09:10, Akihiko Odaki wrote:
> On 2026/03/04 0:14, Dmitry Osipenko wrote:
>> Hello,
>>
>> This is follow up to DRM native context v16 [1] and MAP_FIXED API v10 [2]
>> virtio-gpu patches that has been reviewed previously and were waiting for
>> a new release of libvirglrenderer 1.3.0.
>>
>> [1] https://lore.kernel.org/qemu-devel/20251116125641.2255794-1-
>> dmitry.osipenko@collabora.com/
>> [2] https://lore.kernel.org/qemu-devel/20260118162856.223796-1-
>> dmitry.osipenko@collabora.com/
>>
>> Changelog:
>>
>> v22:- Added r-b from Marc-André Lureau to ui/gdk patch.
>>
>>      - Corrected qemu_egl_create_context() to take explicit shared GL
>> context
>>        arg needed by gtk-egl display, as was suggested by Akihiko Odaki.
>>
>>      - Changed virtio-gpu BHs to use re-entrance guard as was
>> suggested by
>>        Akihiko Odaki.
> 
> Everything looks good to me. For the entire series:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Thanks

-- 
Best regards,
Dmitry

