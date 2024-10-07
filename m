Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C9ECFB454
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtEb-0004q3-6k; Mon, 07 Oct 2024 15:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sxtEZ-0004mf-DA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:17:31 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sxtEW-000480-QP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:17:31 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9939f20ca0so367732866b.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728328647; x=1728933447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44Ilveo1rOi0WF58SKa3CGpa8bXpbaP11AShh6JMiTQ=;
 b=GFLL1QGHbE8MiN4fZP62DCmX406jzl0qxfnrBEuEwHe/f6hOCCC86P8w7dP8KVzNOu
 QUiyiFu8kFPyZkG9U/Mqr3wV8YDEB6GHioJuSxZ1+dd8pbEltWFH/UREKKoru8qZ5d19
 yGkUgzGnzXzHS2GCpuoX6KoTKuzLKshOtbHwVhoyIN3212wTbOqCAF0hoUSS+pGV3lpk
 QtIg2FZgn0pYg/uA6PfBmUSFbcGUBcHMIxpLeu9OVr5DfZ6dpGgjRiA9jCn57mW5x1yo
 P78guCEaDf98aOcLPaAvGM7BpI+BDZaXHP0y/eR5JT3J4icOlb2Osyh/uuoWjc3SpB83
 WPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728328647; x=1728933447;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44Ilveo1rOi0WF58SKa3CGpa8bXpbaP11AShh6JMiTQ=;
 b=Wv8kugtRFK+pciPdS5EFx5WAYLe+aHn7iL2iGwlIwFmxcRJrfVaLirMZ7Mc/jH0rMD
 HZ2Tlh/5VX0XCNBvETZRVHfKKHaNbHBF1hAPYWajKYV9bdOsDpvsYL4RBM68tBkAxIul
 wUqM6lu9rc9LP02WnVwBLSubL0Hrczzz09B+wT3mRXOY5RfZgFd4iK6GJI8qZiz05VZQ
 uD2M+mzDpBprhypKaVjfxXbUDMnA0jVQHM7A4L92NaHENrFagOQNXJRjQXwmRCBRvcE0
 2GBK/HBUfQ8Kx4LYUQHi7uW2/9G0WMYkzsC5I/zgXy1s255a4+F8NSuxqHzU0vpreSi2
 s+QA==
X-Gm-Message-State: AOJu0YzhPVaZybKQJipU9ad8HGECQClCqWri8OTKJLktTqwDyhLZxo0D
 knDFLtsU4w6tVovuzbQ8/Yr2gwy/JK/OEj1dw9WwlMm2k2vB8d//Paj1Uw==
X-Google-Smtp-Source: AGHT+IFB4fSlbFXzTjjaWw8hVEmQyFSoCaaZ9YtjhP7039ZT+/vLLrBQjRL4Kk1IDNIGQbP1h09PnA==
X-Received: by 2002:a17:907:9301:b0:a99:389a:63c2 with SMTP id
 a640c23a62f3a-a99389a66edmr805858866b.62.1728328646425; 
 Mon, 07 Oct 2024 12:17:26 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-054-083-243.78.54.pool.telefonica.de.
 [78.54.83.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a993c1b353dsm354618666b.35.2024.10.07.12.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 12:17:25 -0700 (PDT)
Date: Mon, 07 Oct 2024 19:17:22 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: Gert Wollny <gert.wollny@collabora.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/2=5D_ui/sdl2=3A_Don=27t_dis?=
 =?US-ASCII?Q?able_scanout_when_display_is_refreshed?=
In-Reply-To: <6ae662db-fba6-43a5-8be9-8de01dd4f476@daynix.com>
References: <20241006234353.3201037-1-dmitry.osipenko@collabora.com>
 <20241006234353.3201037-2-dmitry.osipenko@collabora.com>
 <6ae662db-fba6-43a5-8be9-8de01dd4f476@daynix.com>
Message-ID: <5BB676BD-9F53-421A-BBE1-35FC5AF3B47B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 7=2E Oktober 2024 18:15:11 UTC schrieb Akihiko Odaki <akihiko=2Eodaki@d=
aynix=2Ecom>:
>On 2024/10/07 8:43, Dmitry Osipenko wrote:
>> Display refreshment is invoked by a timer and it erroneously disables
>> the active scanout if it happens to be invoked after scanout has been
>> enabled=2E This offending scanout-disable race condition with a timer
>> can be easily hit when Qemu runs with a disabled vsync by using SDL or
>> GTK displays (with vblank_mode=3D0 for GTK)=2E Refreshment of display's
>> content shouldn't disable the active display=2E Fix it by keeping the
>> scanout's state unchanged when display is redrawn=2E
>>=20
>> Signed-off-by: Dmitry Osipenko <dmitry=2Eosipenko@collabora=2Ecom>
>
>Reviewed-by: Akihiko Odaki <akihiko=2Eodaki@daynix=2Ecom>

Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>> ---
>>   ui/sdl2-gl=2Ec | 1 -
>>   1 file changed, 1 deletion(-)
>>=20
>> diff --git a/ui/sdl2-gl=2Ec b/ui/sdl2-gl=2Ec
>> index e01d9ab0c7bf=2E=2E4975d923db38 100644
>> --- a/ui/sdl2-gl=2Ec
>> +++ b/ui/sdl2-gl=2Ec
>> @@ -51,7 +51,6 @@ static void sdl2_gl_render_surface(struct sdl2_consol=
e *scon)
>>       int ww, wh;
>>         SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>> -    sdl2_set_scanout_mode(scon, false);
>>         SDL_GetWindowSize(scon->real_window, &ww, &wh);
>>       surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
>
>

