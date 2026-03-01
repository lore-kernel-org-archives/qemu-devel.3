Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5536BFD006E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 18:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwlWT-0000qK-NA; Sun, 01 Mar 2026 13:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwlWP-0000pS-UA
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 13:28:06 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vwlWN-00054r-0t
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 13:28:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772389654; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZoB+BSqzmBQJz6K+iHbMLi+VBCcgkIZ3n0jLXRclJ+KnzTN71LEYQDxvj3RvtvNSL7Clo+SCOBlXBQrlVeuaSmiBs2EyjNY1mWTrgl2aRYUOr7JMUuPqUxbMpSqAm38ghWxTG23N0iH82tiBluzkzBBdMaZEPc3ZdIvoTWqf4dY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772389654;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=PIK0y3EgVOv1wu9kvCbKYsMypZnY7E3WBStIWYeaBwo=; 
 b=AM9V0XswvBXrvBHVhIAr5PYJGgA7gulfPl0Ih8jAhWlRTKW8DLy45T5VYsrGJ1I/Hn39C9Spt5Nnum92bTBbGNQJsJGvhw71Vl84md0t/MY7vNyuRa7QROeql5f4/AOheOjQm07hilZKKlLY0Z1du9R7QIblmPXj+cRcuEv11VQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772389654; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=PIK0y3EgVOv1wu9kvCbKYsMypZnY7E3WBStIWYeaBwo=;
 b=WlsaKpn09div68cjsH9SPZm7byBAAkzrgTcyMRsOJYPzQ7Y1S+4NsGTEPrfLT1TB
 ttZapPKwhjTA41bfbpTZPddFG7PrzDVwSPn3+Umvq8OMWCWkNEE8qku4pFKS0RTW5zT
 VEyjD7KKCywYEuKM3buQ0FuRe+YogiOinHgg2VkU=
Received: by mx.zohomail.com with SMTPS id 1772389652830321.96883764588983;
 Sun, 1 Mar 2026 10:27:32 -0800 (PST)
Message-ID: <ac3a6c73-4dc2-47df-acfc-73a327fffd9f@collabora.com>
Date: Sun, 1 Mar 2026 21:27:17 +0300
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
 <aacd5ef6-a16d-47d1-93cf-c3ca9ac0706b@collabora.com>
Content-Language: en-US
In-Reply-To: <aacd5ef6-a16d-47d1-93cf-c3ca9ac0706b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

On 2/24/26 00:18, Dmitry Osipenko wrote:
> On 2/20/26 18:17, Dmitry Osipenko wrote:
>> On 2/20/26 11:35, Akihiko Odaki wrote:
>>> On 2026/02/20 9:16, Dmitry Osipenko wrote:
>>>> Hello,
>>>>
>>>> This is follow up to DRM native context v16 [1] and MAP_FIXED API v10 [2]
>>>> virtio-gpu patches that has been reviewed previously and were waiting for
>>>> a new release of libvirglrenderer 1.3.0.
>>>>
>>>> [1] https://lore.kernel.org/qemu-devel/20251116125641.2255794-1-
>>>> dmitry.osipenko@collabora.com/
>>>> [2] https://lore.kernel.org/qemu-devel/20260118162856.223796-1-
>>>> dmitry.osipenko@collabora.com/
>>>>
>>>> Based-on: 20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp
>>>>
>>>> Changelog:
>>>>
>>>> v19:- Further improved improved naming of functions and terminology RE
>>>>        GL context binding. Suggested by Akihiko Odaki.
>>>>
>>>>      - Added new patch "ui/gdk: Restore original context after new
>>>> context
>>>>        creation" in addition to improved "ui/sdl2: Restore original
>>>> context"
>>>>        that now getd actual bound GL context and restores to it instead
>>>>        of restoring to the console's ctx, for consistency with the rest
>>>>        of GL context management fixes that ensure context is bound only
>>>>        when necessary.
>>>>
>>>>      - Improved virtio_gpu_virgl_update_render_state() with force_ctx_0()
>>>>        and unbind_ctx() to make deferred GPU resetting maintain bound GL
>>>>        context properly.
>>>
>>> Both the new context management improvement and the MAP_FIXED API
>>> changes look good to me. For the whole series,
>>>
>>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>
>>> Thank you for completing this change.
>>
>> Thanks a lot for your help with the reviews!
> 
> There is report about dbus display not working with this series on [1].
> The problem sorted out by adding missing GL ctx re-bindings. Spice
> display should need similar fix. Will make v20.
> 
> [1]
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/38731#note_3341965

After digging further, I realized that touching GTK APIs outside of
main-loop thread is troubling as UI toolkits are single threaded, and
virtio-gpu interacts with those APIs while processing cmds. I'll abandon
this approach with GL context unbinding and instead make virtio-gpu to
process commands only from main-loop thread in v20.

-- 
Best regards,
Dmitry

