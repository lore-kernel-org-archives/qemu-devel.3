Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC256C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo66C-0003J3-V2; Sun, 26 Jul 2026 17:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wo66A-0003Hf-S2
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:09:26 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wo669-0001DO-Fe
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:09:26 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38de840f2f0so1528584a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785100164; cv=none;
 d=google.com; s=arc-20260327;
 b=D7O/9Ccp9bEWrttZigdxDon21rpjouAxitUWfk3JWGKzH3X+ckO+lPzWC3yZiNkFUY
 cYLuiOjNx2yvkuu8BLlR7As5rki4YuYtW0fOgtbmh4MIyROfU5ewCUCLwepesbK/SHbZ
 ZiB+rJq8c8xQiW0SkH/dHr74Pln4l+VJdud4cKTKLWPm/hM2D4RaZ4W7Qqv1mPZYVJ6A
 o+7wG8b0q3Ou+eaLH2kVS+ebNEtIQxSCQxfYUEYhzbHIjaJTFYsgnE1bHggW2y2pdJJ3
 XTAx/W6iyoZmlabtX9sqCB6toskfmhxkqZjDfDH8GD6Lczdsf9Xi+SyUvKp/7umQL4uL
 oyOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bz/pGK+nVp1qpiG4hRbY18Z0nbHtZZMZr2fR6jF7H8k=;
 fh=uKI3ggVMJgYhH8K+/qh700OBsmBzXMzFdzBcQOaZbl0=;
 b=aj24GE/zgIIxDoJdrvEypmWPtwQecn2oTKCcH18qwKUhCY5EPrMCT/Ov3p0b5chz8p
 gP/tUN22eTK7A+ka9sqaATrOMaIXiaLs8VijSbP3ekKZfovAD5NgrAGGXFZCI5RFrgLE
 A8xvFas5RDN1wJLQCLv6bFEUhstGHjP5wN9mPoIhI4bXNE7RRjDKJraXBDa4PXMv3cm7
 A56VMZ0F0PWwEDYxaCnF7OAIYDcKaon+mPlsfCfwJ4jrCF8k4VD+2RtwIexqifBAq7LZ
 K/BzMkqhOWBA6zwbDGfBl+Xi9YFdW2oHR/OKS3jU8hxvf6oY/2JR1o2/XFhFhu/wkaLa
 bvdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785100164; x=1785704964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bz/pGK+nVp1qpiG4hRbY18Z0nbHtZZMZr2fR6jF7H8k=;
 b=q6jWedFQKEwNooNGshwNoIq1gVSUP5JO31FTCHgyf3jhyqrtN0tYb0Ra6Czrt4dRCQ
 FzEEAq2mZQDKbxkQn/7P+TW53ExKWTT84EFOCymmQjwkxXBPIgoihdwgk3LgAyoe5Mjm
 pDXuRuI9Z/K/O22iMTo7f1RsIXTZncrvlQRLO4j1bR+OjLlotz0Z4Mhnx4dqZ6BPEMwv
 CTzHP+iHsRyGAjCxOc0VI61z0Q4ggb3U0c+XSq4DnwlxWo7oj1lRmZstOoSWOIrY18ee
 idqp/4hKk38UPiovRp4mm5H3Xzg602pnBE5FTyoXCuVGCZTHLE/IO522Tu4PRBEJWKAU
 piwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785100164; x=1785704964;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bz/pGK+nVp1qpiG4hRbY18Z0nbHtZZMZr2fR6jF7H8k=;
 b=maygcB2+VwDsvCQ1jNzIQLlLA8ArM+Vh39dVroEJ7Me0Ncq4Bdwl+RgCaNdRRJpw2y
 USOIvTDrQcH5eRfkaLPm33EZKVmS54eVjldPH+bulohZCvKOl0AquASEqZc0zjaGiSCg
 ZfeEcdZiznLvr9zH72pV4MHQ/xrGasa371WYylncV4JOO6zm8YuU8S8M1l3+s2KDAcNd
 wkPIOYVgSet2SPfTqdC7586+UifRiSZoLiwc3YeEIgwRB7/+a4j2Cgz5RA/aKdl2B0m3
 GFGyKizAY703m8fEp1ONDgecCjSupylaWiOi0LjFTFogEDuc9mdrZZ4YgvNuWq+qoXjY
 fFDg==
X-Gm-Message-State: AOJu0YyPAxWrkM0IKf65qlTdMnHliN/AtCGmuS87SS+DI5jibRweYqKW
 3x3fYcZ5yEWBexo3SwDeeunxPYQ+8/u64GDTS2v37quzX4tWkqkEqeYMzHTs0ipHZBEbY2L+o17
 n4fQMrdMmXgekwNwSXpJ7dOMs9wzcJNc=
X-Gm-Gg: AR+sD1228KDSN0PlRhNcBZhnedEiTciqCJNu9l+b4UiSsy40m/BugBz9usrvQEHgIzz
 DZTT11mHQ3ElB+OntKLd8RJLJfNxpRmBbff468uhhYc1rDNZOXO5ER/fHfaa4B9u2VMOKmma01+
 68orAx70lQumtmsxOQCkb+6CNylx2STxiYIWt5MtLofpy/L2Z/WVHx4P+gvOEHxRAAyVmzMVEK+
 /pbctv40FMUIaxU9uhh+Y7UhJX905L0OzNuTtCE4mJAHg7p4/fjJSlWyuo40wbEHKaXe8j61+ZC
 M/3MxhORq/ko6xm0lw==
X-Received: by 2002:a17:90b:3810:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-38f293cd15emr5801529a91.1.1785100163960; Sun, 26 Jul 2026
 14:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
 <20260726164738-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260726164738-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 01:09:12 +0400
X-Gm-Features: AUfX_mylOzHtLX1B5pdeb_u2WgbX2EqX4Pr6UFlRNQstCQqi_x-D3pds_NHf1lg
Message-ID: <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 27, 2026 at 12:49=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for t=
he non interleaved cases")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Not commit log really?

SSIA, but I can make it longer if it helps.

>
> > ---
> >  hw/cxl/cxl-host.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index 7e744312f1d8..eba13c9e7cba 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDi=
rectPTState *state,
> >      MemoryRegion *mr =3D NULL;
> >      uint64_t vmr_size =3D 0, pmr_size =3D 0, offset =3D 0;
> >      MemoryRegion *direct_mr;
> > -    g_autofree char *direct_mr_name;
> > +    g_autofree char *direct_mr_name =3D NULL;
> >      unsigned int idx =3D state->hdm_decoder_idx;
> >
> >      if (ct3d->hostvmem) {
> >
> > --
> > 2.55.0
>
>

