Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8876AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjX0-0000rL-7f; Fri, 17 Jan 2025 05:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tYjWw-0000qR-RI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:24:46 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tYjWs-0003ZM-Vb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:24:45 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so2591929a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1737109481; x=1737714281;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Jeowottcg/qSRTTvxY4wfz1zy87S6E3SUFNnq8pNG4=;
 b=N6GfhzUUfd9FFxloaHfEzzuVxfIGGhl64OqY/A6YBIVKLILx2Z3svqS89vVghmM2gd
 aSkhDpjpJjoSNvtN+5/uKO7rnFcqoXPontN3ufuVS/GQ82hAecCx/2cK0bd0nXxozho7
 aM795Y3aLq+sIgVG71OeGj84zWAhDCKI2CkO8WtPCuQQBW4FjSmWnWjIsBF1+91siXi0
 CdCv3cT2A46IkjELqSL+xefwmt8PVHpWchD5Tb4yXJiA990V+5S0BgB+B5fi4CC94XQi
 q5Som1laUEF2JIFDYpFRuesXRWei0u547x54VhJyZpD6+6USWwh63L3q69n0ie7lSYim
 4nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737109481; x=1737714281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Jeowottcg/qSRTTvxY4wfz1zy87S6E3SUFNnq8pNG4=;
 b=loNkX3+LMGtwQcuPx1mT9YsdcNC+PhCKevvDNqjwat+gd41xk0FS6q6RMJXqDtrL90
 z6Szzd9EEmWuSiowZhakUOs6UHo6zYAjTj7EyzY6X9Nk83tHTFTg8wlSqI5rUdMSC4Er
 KUefUd3FztyaqCdFIx8G3bYZMRj1WGqYZDNfa8+QRKVvTWX3qDrqLWmUkBiBtoWwFQk0
 R18OQxt1NvcT1b+OxvZ2dOtWxpBYG4Z38adaq2JGtOyd/v1dOtsZETHhYS5k10mbAm5x
 NwMkJu7SNT6EbSRAF734N6Uc72oYvY5NzvckhPJXq0TzyXnr+q+xqH8qKzfPQJJLKxwt
 g68g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwdZgFMsPVzoD0hJkcYDw0dJ36pN5iSPdRM7DCWHmue7vyi9F7TwuOEPpiI6L+QNzZWxbwWoTfy2Cx@nongnu.org
X-Gm-Message-State: AOJu0Ywrs3Fu9mgOlaXZaSdC992wYI2hws9zy7RHmGZw9zPQFYo3Lzk9
 +giubYm/4Jknyj6suN2IhT8QRugA6O3crFaV+1NbWfAR1R5gfgnkPys0RiS9z6DvwqybgC6Wo9p
 gBlHlzXhjEnYh6QOcICw0TqfhBmRG6Ia//xwq
X-Gm-Gg: ASbGncsF27TooAg8i8+Ekk3Z9+lMqn56ZYvgPawyrcZadrK9IiclBQYQGD09WcfGmjd
 6BcqZ5uPp7H1vXSKCTbZTjQ/aHka4VVF0sqIC+Q==
X-Google-Smtp-Source: AGHT+IEqesODGdEUGoR+bOzV4XdO24Di7dYv4CcX1uL2Ut08AOXJihqX4bij6kfRR+bzJKlJKHtfNOocdWI7QxvS9gs=
X-Received: by 2002:a17:90a:e18f:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-2f782c7a769mr3502679a91.12.1737109480731; Fri, 17 Jan 2025
 02:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
 <20250117-coreaudio-v4-3-f8d4fa4cb5f4@daynix.com>
In-Reply-To: <20250117-coreaudio-v4-3-f8d4fa4cb5f4@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 17 Jan 2025 11:24:29 +0100
X-Gm-Features: AbW1kvZByV2wnRoHTKVkgYptaDITD4JBEKaPAJEvAGLfZNU6ac8OdSigR7A604Y
Message-ID: <CAGCz3vvxQ0ktO3oPy_mNaUR3HUTCtjYLC27BXG3Pe186X2qvNw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] coreaudio: Initialize the buffer for device change
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 devel@daynix.com
Content-Type: multipart/alternative; boundary="0000000000008907b1062be45105"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::102c;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000008907b1062be45105
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 07:48, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> Reallocate buffers when the active device change as the required buffer
> size may differ.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>

---
>  audio/coreaudio.m | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index b9e1a952ed37..72a6df0f75ee 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -466,6 +466,7 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core)
>      core->outputDeviceID = deviceID;
>      core->audioDevicePropertyBufferFrameSize =
> audioDevicePropertyBufferFrameSize;
>      core->hw.samples = core->bufferCount *
> core->audioDevicePropertyBufferFrameSize;
> +    audio_generic_initialize_buffer_out(&core->hw);
>      core->ioprocid = ioprocid;
>
>      return 0;
>
> --
> 2.47.1
>
>
>

--0000000000008907b1062be45105
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Jan 2025 at 0=
7:48, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=
=3D"_blank">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Reallocate buffers when the active devi=
ce change as the required buffer<br>
size may differ.</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
</blockquote><div>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phi=
l@philjordan.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;</div><div><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0audio/coreaudio.m | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/audio/coreaudio.m b/audio/coreaudio.m<br>
index b9e1a952ed37..72a6df0f75ee 100644<br>
--- a/audio/coreaudio.m<br>
+++ b/audio/coreaudio.m<br>
@@ -466,6 +466,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core=
)<br>
=C2=A0 =C2=A0 =C2=A0core-&gt;outputDeviceID =3D deviceID;<br>
=C2=A0 =C2=A0 =C2=A0core-&gt;audioDevicePropertyBufferFrameSize =3D audioDe=
vicePropertyBufferFrameSize;<br>
=C2=A0 =C2=A0 =C2=A0core-&gt;hw.samples =3D core-&gt;bufferCount * core-&gt=
;audioDevicePropertyBufferFrameSize;<br>
+=C2=A0 =C2=A0 audio_generic_initialize_buffer_out(&amp;core-&gt;hw);<br>
=C2=A0 =C2=A0 =C2=A0core-&gt;ioprocid =3D ioprocid;<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
<br>
-- <br>
2.47.1<br>
<br>
<br>
</blockquote></div></div>
</div>

--0000000000008907b1062be45105--

