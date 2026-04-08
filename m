Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E950D10F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYN3-0007C1-7Q; Wed, 08 Apr 2026 15:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wAYJS-0008Qe-Fv
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:43 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wATGw-0004gE-96
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 09:48:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1775656086; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ndIndi6KNOtfYkL1M9otKI3X1lTF6Cn3RaSGrq9v3LZnwC9VHfmo5v2jFJkW4FUkKowyrjU4P/1Jow0Ugy4J/nGmk4E7V6LNgwoIyW9PQrW5H3+Cdv0XutKtK+gi3JktlCEf1xUAPike5RzGyamCLv0A2PlFXdQoTho5uzivkrg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775656086;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rgtKBvg/ZLN7Q6dglCEolC9fM9oukOa5QsjfV40lvjU=; 
 b=He2ZL1voZYevAoFu6QPT9qfQ1VsvSrJ+LQlkWOWYuXQtLyXN2rkyiAHQTJnDmG5oCSXd0GfemvjXXs0u15hlTVdrW4MKbVA5NIaBRSVDtiPVdtZSxu9zPpeKMxHIFav3kJGATJ2Z9J/CrN+9xxtG0IEo1FZuqS0R8qDRHJ3tBT0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775656086; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=rgtKBvg/ZLN7Q6dglCEolC9fM9oukOa5QsjfV40lvjU=;
 b=DSoyNrTSJqEHpjSB1I385wXwOIDWFeKuHfRT2ZQVOBo0xqCuhYcgq/s51MTJWYLL
 +lmzPZnjwRFcSvLXGbs5J+eLpKukCmrWrP9UiBIqvlutU6CeRBFaUidX+WL8YLUtKf4
 HkvkR9hiwn23R0rfm0JT5P6y36KaYW+bdqbY1Edg=
Received: by mx.zohomail.com with SMTPS id 1775656083527283.34652504728285;
 Wed, 8 Apr 2026 06:48:03 -0700 (PDT)
Message-ID: <a2f0da9e-8227-4f83-bf8d-e598d34c0e46@collabora.com>
Date: Wed, 8 Apr 2026 16:47:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 02/18] ui/sdl2: Don't disable scanout when display is
 refreshed
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Weil <sw@weilnetz.de>
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
 Robert Beckett <bob.beckett@collabora.com>,
 Anthony Roberts <anthony.roberts@linaro.org>
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
 <20260303151422.977399-3-dmitry.osipenko@collabora.com>
 <c9943b84-e997-4ce8-8449-5c0115ca9250@weilnetz.de>
 <87qzoqbs51.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87qzoqbs51.fsf@draig.linaro.org>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/7/26 20:24, Alex Bennée wrote:
> Stefan Weil <sw@weilnetz.de> writes:
> 
>> Am 03.03.26 um 16:14 schrieb Dmitry Osipenko:
>>> Display refreshment is invoked by a timer and it erroneously disables
>>> the active scanout if it happens to be invoked after scanout has been
>>> enabled. This offending scanout-disable race condition with a timer
>>> can be easily hit when Qemu runs with a disabled vsync by using SDL or
>>> GTK displays (with vblank_mode=0 for GTK). Refreshment of display's
>>> content shouldn't disable the active display. Fix it by keeping the
>>> scanout's state unchanged when display is redrawn.
>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>> Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>   ui/sdl2-gl.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>>> index 3be17d1079af..5eca0248233e 100644
>>> --- a/ui/sdl2-gl.c
>>> +++ b/ui/sdl2-gl.c
>>> @@ -51,7 +51,6 @@ static void sdl2_gl_render_surface(struct sdl2_console *scon)
>>>       int ww, wh;
>>>         SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>>> -    sdl2_set_scanout_mode(scon, false);
>>>         SDL_GetWindowSize(scon->real_window, &ww, &wh);
>>>       surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
>>
>> I got a user report that my latest QEMU for Windows no longer supports
>> SDL. According to my own test, SDL still worked with git master
>> (2026-03-07), but was broken with 11.0.0-rc0 (2026-03-18).
> 
> This is:
> 
>   https://gitlab.com/qemu-project/qemu/-/work_items/3347
> 
> Anthony should be posting a patch to the list soon.

Thanks a lot for handling the issue!

-- 
Best regards,
Dmitry

