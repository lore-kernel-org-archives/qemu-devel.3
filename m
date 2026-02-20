Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0C9C56204
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtSGy-0003cU-AW; Fri, 20 Feb 2026 10:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtSGw-0003bm-6p
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:18:26 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtSGt-0000Xk-QT
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:18:25 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771600676; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VL6h4zz5x5Z65mjPwTHbDuRLKrj8Qm+X8iKfnAhhBIEd5aEip71Rxus/7fDk4zGQJwa1A7ZcLJksbwXRTy5Llwf1wiN1/U4wO/R0hOcK6kRax5IeFCkiO+UyUK7xAS24VDW+49QJK9BkGq90n9snnJR0xVJ/nuxLrbcGWk/lPmI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771600676;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EEg+fthIlWbJHkGc7KYCeA+M97ARcTRLMcXOzAg/Ovs=; 
 b=W/ZUwxcxlIXjBV3/GYYv4iRg7ecaf86KIM6nT+YTP0D1iVUY6usi7ObNwocDG+1hLH0Nna/qXPABbFLsnQz1iPFKdyZK7vGwpp8hBu2VJcgWnpRDNrI90jRdVUK5eQTzlJlSU7D+mWu4bHVkjAUFLZRruThWuzwiG9FRGw5yJmw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771600676; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=EEg+fthIlWbJHkGc7KYCeA+M97ARcTRLMcXOzAg/Ovs=;
 b=fdDcn+sLCWelOBsjt6AswjDMvmIk1Fch80yWICr/iJuen3vNm3ECQZGYOVCJ0wPs
 9LIZPTP0XHIpUvUmezDu+BDAUYgKPSpZkpv+36GiWTJ3BGDOtYA2ofolw6//RBpnYzw
 tBs7+ckg2pFm6pgXA+/st8SlVFp9SVkA+E8dVfGE=
Received: by mx.zohomail.com with SMTPS id 1771600674034429.27829558068754;
 Fri, 20 Feb 2026 07:17:54 -0800 (PST)
Message-ID: <d012a6ae-0754-42a8-ad07-9445ee4a9346@collabora.com>
Date: Fri, 20 Feb 2026 18:17:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/20] Support virtio-gpu DRM native context and
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
References: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
 <271c635c-8c2c-48bc-b44f-91b9d268bbe2@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <271c635c-8c2c-48bc-b44f-91b9d268bbe2@rsg.ci.i.u-tokyo.ac.jp>
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

On 2/20/26 11:35, Akihiko Odaki wrote:
> On 2026/02/20 9:16, Dmitry Osipenko wrote:
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
>> Based-on: 20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp
>>
>> Changelog:
>>
>> v19:- Further improved improved naming of functions and terminology RE
>>        GL context binding. Suggested by Akihiko Odaki.
>>
>>      - Added new patch "ui/gdk: Restore original context after new
>> context
>>        creation" in addition to improved "ui/sdl2: Restore original
>> context"
>>        that now getd actual bound GL context and restores to it instead
>>        of restoring to the console's ctx, for consistency with the rest
>>        of GL context management fixes that ensure context is bound only
>>        when necessary.
>>
>>      - Improved virtio_gpu_virgl_update_render_state() with force_ctx_0()
>>        and unbind_ctx() to make deferred GPU resetting maintain bound GL
>>        context properly.
> 
> Both the new context management improvement and the MAP_FIXED API
> changes look good to me. For the whole series,
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> Thank you for completing this change.

Thanks a lot for your help with the reviews!

-- 
Best regards,
Dmitry

