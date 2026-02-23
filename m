Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4209EEC285
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 21:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vudKo-0005kQ-An; Mon, 23 Feb 2026 16:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vudKn-0005kB-0Q
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:19:17 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vudKk-0003Ob-2y
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 16:19:16 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771881533; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A4syuX5dSubQ+4mZqf4HT7tskgbGHK8iJN+55uW11bnK5cL+syTGnAHgE4lTvcrEgN9FqM6P7WZ50LCZbR3OmdVGg4TjE8d5H6aGaE093PgKGls6VBhiL2emFmMN+9t/xiQUhSJpxeCA1pzObZi62zjZ9Nr6iC/LhDh4NOtOht0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771881533;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YFQdz7w4VGkTmtRG/ZwwTtKF3s80DL/NFFoR29MHFtM=; 
 b=EsAhzP2JYqp2b9aD+vj92JkT6O1TaRhvzyMAlp+yLnihWCYOoDp/9lT8+DVncPI4QfKgV5A/d8IEe0tm8vrWH5+QjBKnfLmiUhIH5jEPrJktLmkT01WEMk2lSTDQzop/i2hmiC3azTwSDR9iayx8LQbc6uzaFadZIhRCZbZktIc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771881533; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=YFQdz7w4VGkTmtRG/ZwwTtKF3s80DL/NFFoR29MHFtM=;
 b=CrOgkMkmKevwZ9FNibUPLHyzCBjrhAQuSZs9IiIswTTab/DkXxRcf5sri7tfxahK
 1zvXHZgu4ko2FCFwybUY85gvU/wBFMf8xBzVIdWybKnQOOeHK6wZrsZ4vo94Qsq5ttL
 51SmniUlAqvjinYhihGDnRYawhV4NoztuKiKSnFw=
Received: by mx.zohomail.com with SMTPS id 1771881531320702.5887229418487;
 Mon, 23 Feb 2026 13:18:51 -0800 (PST)
Message-ID: <aacd5ef6-a16d-47d1-93cf-c3ca9ac0706b@collabora.com>
Date: Tue, 24 Feb 2026 00:18:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/20] Support virtio-gpu DRM native context and
 MAP_FIXED API
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
 <d012a6ae-0754-42a8-ad07-9445ee4a9346@collabora.com>
Content-Language: en-US
In-Reply-To: <d012a6ae-0754-42a8-ad07-9445ee4a9346@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

On 2/20/26 18:17, Dmitry Osipenko wrote:
> On 2/20/26 11:35, Akihiko Odaki wrote:
>> On 2026/02/20 9:16, Dmitry Osipenko wrote:
>>> Hello,
>>>
>>> This is follow up to DRM native context v16 [1] and MAP_FIXED API v10 [2]
>>> virtio-gpu patches that has been reviewed previously and were waiting for
>>> a new release of libvirglrenderer 1.3.0.
>>>
>>> [1] https://lore.kernel.org/qemu-devel/20251116125641.2255794-1-
>>> dmitry.osipenko@collabora.com/
>>> [2] https://lore.kernel.org/qemu-devel/20260118162856.223796-1-
>>> dmitry.osipenko@collabora.com/
>>>
>>> Based-on: 20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp
>>>
>>> Changelog:
>>>
>>> v19:- Further improved improved naming of functions and terminology RE
>>>        GL context binding. Suggested by Akihiko Odaki.
>>>
>>>      - Added new patch "ui/gdk: Restore original context after new
>>> context
>>>        creation" in addition to improved "ui/sdl2: Restore original
>>> context"
>>>        that now getd actual bound GL context and restores to it instead
>>>        of restoring to the console's ctx, for consistency with the rest
>>>        of GL context management fixes that ensure context is bound only
>>>        when necessary.
>>>
>>>      - Improved virtio_gpu_virgl_update_render_state() with force_ctx_0()
>>>        and unbind_ctx() to make deferred GPU resetting maintain bound GL
>>>        context properly.
>>
>> Both the new context management improvement and the MAP_FIXED API
>> changes look good to me. For the whole series,
>>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>> Thank you for completing this change.
> 
> Thanks a lot for your help with the reviews!

There is report about dbus display not working with this series on [1].
The problem sorted out by adding missing GL ctx re-bindings. Spice
display should need similar fix. Will make v20.

[1]
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/38731#note_3341965

-- 
Best regards,
Dmitry

