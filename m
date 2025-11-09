Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96872CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 16:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI8gY-00082C-2E; Sun, 09 Nov 2025 11:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vI8gQ-00080J-Cr
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:54:30 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vI8gO-0000jt-5W
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:54:29 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-787d5555274so11242447b3.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762707266; x=1763312066; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7wTOeQOlsftaWq3Z04E6gOlfmQz3sNdvsoiQrNxHbY=;
 b=L+cIkU4sGrPZNUuQpbb8h4E6GJZabvPnBgQX2SwRLr26n85mgLVf8EG9yAnMXIGG6+
 NNBuvyY/NkNcBzjEWbjzIaweWL/lPT3pbu7LXt1tYlzR0WBkwGnzMNQ9qfUihz06QMoj
 sMPmtPZobJ8weGinZAWbqVLYkD7BdCY4t8ncICHQalGU6kImXnW2S6RHleVK3YCEiHxC
 Mg1NNF8Jr7fhsCDfGh+9btdOLCOz4GQNHxgHH9DLmjSMkUoZNE0jBYADtiwEJcj4FCfZ
 fhQ4PBM0zu63aab77LvQ1W5hQTQObFP8jKnzmhLl+jBkHKKVc2yDhBjfbt04abv2KvHX
 O5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762707266; x=1763312066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U7wTOeQOlsftaWq3Z04E6gOlfmQz3sNdvsoiQrNxHbY=;
 b=FF7jOy6uyBG54vOD2eED5fjocQ19NJI/5KjrEplf9Jz9C0nlz7F1VV8Q+Cg1EHIHiU
 JKoCkX7MbmncfvEQvcpKH8X8/FIEsdp2WT6lhsToWL6T8Obpa5JvEY66zaVIRsQ0wF6h
 dJ3DrReAhCD/+wBRCXzvtzHfTnKd/Yc1IHSJt/aplxfdrzFEMn8VMpiCq5HJqeMAj+1d
 ktjd8pPyoqqk9fKQEVvQJ6BvG97DF3GGuhzQgIyEscUgyN6JPFOAfGvbvOPeZrpjpCgZ
 nuH3jNxd9KsFRprpkSa+0INWflFDwjJdvetccA9p0BdCwG89RzHBcK2n2hLgCftiey6B
 vfbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3vnn05283r/9tpSHhnTPxgpLhdEzLsjRaPAKTvtdJl53Eh8maPaKaBBEVJjStbiQ+n5i15HmT1W2b@nongnu.org
X-Gm-Message-State: AOJu0YzZNyA5FaxV7QOq30+FXobMIZBcWjyRffhoS+h4DLJOReerr2YB
 AhWGXmiu13blsxPq5wHfapIWPaDrMJ0lFIXCv30Wpe+FBpyph7mO5O36FrRC7G/0COIc+Y1Jl+q
 7JTvp6TwAlBVvGQmoGbtVXtiPkAgLKE9v9TCz1f/PtA==
X-Gm-Gg: ASbGncuUtZEJE1rsqMYje0gFo1FlaTw2SswfPbKe0v6zR3PUMpRaxRGIvJMlRaKf4m5
 IbV2Thvrqh2nmP4iYWJIm6nq0/X2Ub7eUq2BWiB+r3Ylya0B7ebLlFa69Q4ySY4FelnHmfh2GCE
 E0lpRzFKMev943crRn59CE6taqlnuYJGt2urxlXaTMnTMNRLKpA3mcmI1T2sheW2WsPLuE99vii
 D71jXqPQq0rompPGG8aYTNxTUsg7u+HYX38LZww4mBV2qs9cL12niKqBURjSw==
X-Google-Smtp-Source: AGHT+IHw/zL+Zv/2Eiz87PlKkKQ1fQlcUbil5a68zn6R/xjJICpKLgBiISMn5yDntxRNl0jJOTBWVUqQLN1TLHnWZcc=
X-Received: by 2002:a05:690c:c36b:b0:783:cfa0:3b69 with SMTP id
 00721157ae682-787d5354711mr49682287b3.4.1762707266026; Sun, 09 Nov 2025
 08:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20251106145209.1083998-1-peter.maydell@linaro.org>
 <20251106145209.1083998-3-peter.maydell@linaro.org>
 <b708afc7-f894-4035-b6e4-62c6be99895f@linaro.org>
In-Reply-To: <b708afc7-f894-4035-b6e4-62c6be99895f@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 9 Nov 2025 16:54:14 +0000
X-Gm-Features: AWmQ_bmbzBv-vKOFIUr9NHLONdu4YvK5C3YnZs6qYWHG7XT_LXhHK9lTe05mnfo
Message-ID: <CAFEAcA90p1YTOU1Wsg2LCg7QaR3hLpH6pxgsuHSqz6V0w+g9yQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/display/xlnx_dp: Don't abort for unsupported
 graphics formats
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sun, 9 Nov 2025 at 13:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi,
>
> On 6/11/25 15:52, Peter Maydell wrote:
> > If the guest writes an invalid or unsupported value to the
> > AV_BUF_FORMAT register, currently we abort().  Instead, log this as
> > either a guest error or an unimplemented error and continue.
> >
> > The existing code treats DP_NL_VID_CB_Y0_CR_Y1 as x8b8g8r8
> > via a "case 0" that does not use the enum constant name for some
> > reason; we leave that alone beyond adding a comment about the
> > weird code.
> >
> > Documentation of this register seems to be at:
> > https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/AV_BUF_FO=
RMAT-DISPLAY_PORT-Register
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1415
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/display/xlnx_dp.c | 53 +++++++++++++++++++++++++++++++++++++++----=
-
> >   1 file changed, 48 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> > index c2bf692e7b1..d8119a56292 100644
> > --- a/hw/display/xlnx_dp.c
> > +++ b/hw/display/xlnx_dp.c
> > @@ -665,14 +665,28 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPStat=
e *s)
> >       case DP_GRAPHIC_BGR888:
> >           s->g_plane.format =3D PIXMAN_b8g8r8;
> >           break;
> > +    case DP_GRAPHIC_RGBA5551:
> > +    case DP_GRAPHIC_RGBA4444:
> > +    case DP_GRAPHIC_8BPP:
> > +    case DP_GRAPHIC_4BPP:
> > +    case DP_GRAPHIC_2BPP:
> > +    case DP_GRAPHIC_1BPP:
> > +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented graphic format %u"=
,
> > +                      __func__,
> > +                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_=
MASK);
> > +        s->g_plane.format =3D PIXMAN_r8g8b8a8;
> > +        break;
> >       default:
> > -        error_report("%s: unsupported graphic format %u", __func__,
> > -                     s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_M=
ASK);
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid graphic format %u"=
,
> > +                      __func__,
> > +                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_=
MASK);
> > +        s->g_plane.format =3D PIXMAN_r8g8b8a8;
> >           abort();
>
> Don't we want to remove this abort() call?

Whoops, yes. (The test case in the bug goes through the LOG_UNIMP
arm rather than the LOG_GUEST_ERROR one, so I didn't spot this.)

-- PMM

