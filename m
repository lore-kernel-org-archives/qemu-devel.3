Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC67DFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABRy-0003BI-9s; Tue, 07 Apr 2026 14:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wABR3-0002em-0w
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:46:04 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wAAAA-0007tk-Vy
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 13:24:32 -0400
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so855765666b.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775582669; x=1776187469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNnqyiKu4QqqTcyzSZuetFLzuspnDmf4RqP+xBfCwDM=;
 b=O+x6ddl3/ztqGaenL4F08qjNv94tRTD+cCUzLsx5dZrQHqLXiggxi0zR6XKLCGNEmw
 OKQMpAgxrILzGS7woerTmUBLjZRtLVJHj/2aGuPsSpdePfTJfFK0kpgIXCiw/Jbw8h+W
 M1rvE+EcfOf1+sFVhsJaMHYrLB+o7ZmnFCEgCZpapVguH9mQUl/alpJoTzZzKOFxThbR
 tlObsurRMoaFUAe2CIbO1j+eIcErUjAuRchz/EER8M+hjYu996BdJtwoCRL7k3WOE34l
 +teoOop1HG9PYB12/Xw4nRtTVP3iaLq05mxxCNjTemdiOvKdFD4RDXVXGESOaEZendiU
 5wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775582669; x=1776187469;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SNnqyiKu4QqqTcyzSZuetFLzuspnDmf4RqP+xBfCwDM=;
 b=nwyDg8P/4TXWMVLveKzEQxSqJG4n92Yu3Pcp1jBcCv9l6Vpq5wQ7d7oDoqnDQ40PJL
 wCjCqHLPAt2NAljt4LpaOJ8DoRn2MgVM+Qxx9JM/KhRXiQd29R159eKbV06XRQLbclOb
 14ER7NQsgQz/VLndQmFA6uinGe3bYxzhoFnqmQV7xX1GwPY+fBUSTuxp/jODMSCS5UgV
 Hpm6AsfaojGyp60Igs62zvia64XfAayeU7l6it1XHNjF74QYL3Fk+fMOVFrEOQw4bm/j
 QZ9fmJ2TolTRppL3zOOWnkkJIuEofZ98dHRf77AlQqS/w35kjhCaixlHs+Vfx4dJH2IE
 Eg8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWvkiN+qAzPHgMOpCC+eLEQM8N+Q1yVAi1PAMod62PPZN0a5kPVdrCWx16h175sZabmpsUxSkJTJjb@nongnu.org
X-Gm-Message-State: AOJu0YwwRMsVehhDRUqhfuci40ybO8yRIpJA+bh6gUYEgF++UVh7/7yi
 mmvZEDLhIoRCw32Y0YTBTDoSEwoldkCINyLEfDCpWT2QTPPRpAm+JOt0wEeCB4EKVLc=
X-Gm-Gg: AeBDies1DshU8AK/7UuRCVbyAgGZlFcu0E3OKqE57YpXSlYpcUom/UAn0vJ3MGPuwHt
 DsUJ7ua1+D0NZXIZ3TMxE69jAULhXxt+UUEpw3/mSdpDOwN4/spPsdgTAhQ/YD+VVBQdG7o9KC6
 HA7P/RODJ2nMQe9++BerVGbcFkbzDTuZSOQvq6g/kf47nesvd2ttDn5DOFHPcHqdUtQ6G7/TfNg
 sdlY01aUFk6VryZCGzZJu4eRTocpj0iODFE9P39AxnKIIvXwNGkxG+w459ZDwa/jhBcVtzlF4AI
 MLYcn5FkFVYkgd7HmPqBRD9kl1bdhv0vsdrNlftOB6uIFjcDgk/PEggTvA2G+R4fCmXQzXWjT/2
 w4sxPwZmR8F4IGpinyjnFvZBukJax2kBpY1trrUUQwtUup+EejcXFJIarx/CtSQFfRncLaiNx08
 cAiWDLkMZDUOOH8uaRpaOI59NGhmf21BAZTQ==
X-Received: by 2002:a17:907:d40f:b0:b98:2b83:909d with SMTP id
 a640c23a62f3a-b9c679f592dmr947670466b.37.1775582668761; 
 Tue, 07 Apr 2026 10:24:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3cfeedc2sm572469066b.42.2026.04.07.10.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 10:24:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C19925F9CD;
 Tue, 07 Apr 2026 18:24:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Weil <sw@weilnetz.de>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Huang Rui <ray.huang@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Pierre-Eric
 Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yiwei
 Zhang <zzyiwei@gmail.com>,  Sergio Lopez Pascual <slp@redhat.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger
 Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Robert Beckett
 <bob.beckett@collabora.com>, Anthony Roberts <anthony.roberts@linaro.org>
Subject: Re: [PATCH v22 02/18] ui/sdl2: Don't disable scanout when display
 is refreshed
In-Reply-To: <c9943b84-e997-4ce8-8449-5c0115ca9250@weilnetz.de> (Stefan Weil's
 message of "Tue, 7 Apr 2026 18:44:43 +0200")
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
 <20260303151422.977399-3-dmitry.osipenko@collabora.com>
 <c9943b84-e997-4ce8-8449-5c0115ca9250@weilnetz.de>
User-Agent: mu4e 1.14.1-pre1; emacs 30.1
Date: Tue, 07 Apr 2026 18:24:26 +0100
Message-ID: <87qzoqbs51.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Weil <sw@weilnetz.de> writes:

> Am 03.03.26 um 16:14 schrieb Dmitry Osipenko:
>> Display refreshment is invoked by a timer and it erroneously disables
>> the active scanout if it happens to be invoked after scanout has been
>> enabled. This offending scanout-disable race condition with a timer
>> can be easily hit when Qemu runs with a disabled vsync by using SDL or
>> GTK displays (with vblank_mode=3D0 for GTK). Refreshment of display's
>> content shouldn't disable the active display. Fix it by keeping the
>> scanout's state unchanged when display is redrawn.
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>   ui/sdl2-gl.c | 1 -
>>   1 file changed, 1 deletion(-)
>> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>> index 3be17d1079af..5eca0248233e 100644
>> --- a/ui/sdl2-gl.c
>> +++ b/ui/sdl2-gl.c
>> @@ -51,7 +51,6 @@ static void sdl2_gl_render_surface(struct sdl2_console=
 *scon)
>>       int ww, wh;
>>         SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>> -    sdl2_set_scanout_mode(scon, false);
>>         SDL_GetWindowSize(scon->real_window, &ww, &wh);
>>       surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
>
> I got a user report that my latest QEMU for Windows no longer supports
> SDL. According to my own test, SDL still worked with git master
> (2026-03-07), but was broken with 11.0.0-rc0 (2026-03-18).

This is:

  https://gitlab.com/qemu-project/qemu/-/work_items/3347

Anthony should be posting a patch to the list soon.

>
> Therefore this patch series might have caused the regression which
> still exists in 11.0.0-rc2. All test installers are available here:
> https://qemu.weilnetz.de/w64/2026/.
>
> Regards
> Stefan Weil

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

