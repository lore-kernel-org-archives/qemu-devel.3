Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06389CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVjg-0004PM-QS; Thu, 28 May 2026 04:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVjf-0004P2-C6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVjd-0007bO-Eq
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779955496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUFwEYHuDyXvHK70ETSgGp5dx/91U5W1rIutxfvFfLI=;
 b=SxUVzicrrhRlpIyCyes8JXWtNgk1pmeYmaEH8oCjdCpsJ96F737bR+xbtsYx6QQcuk+e9X
 mybxRy86cPhgwDO4XhRvXqXYFEbiRG/kyv/s+FfIesbHT8kj9f0Lj2BvTGMozvMIgwACzB
 qUrIMO+gSyGgFB7GgPHeZpePpjxPDWw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-ua_35jbkMnKTDKU_esGwYw-1; Thu, 28 May 2026 04:04:55 -0400
X-MC-Unique: ua_35jbkMnKTDKU_esGwYw-1
X-Mimecast-MFC-AGG-ID: ua_35jbkMnKTDKU_esGwYw_1779955494
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fe44ce385so95037265e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779955494; cv=none;
 d=google.com; s=arc-20240605;
 b=FIKBgVBh7W5L7vQUm0Av7ZaM/qDTOL2u0RkO96f1g1xzEDSJVHsiGyQZJTvTcFyOim
 SAtGJ1QkwbWZdjAdxnHHy2LaLryvl1BkF94IUl4G+E2nNtb60p4DRe1xQfxKLqTo6AwK
 ZGLPPXHuUMK1cYUjTqLm9dMLBapC+8OgwNEq/IrpBGKfmsYjVNp3HtYxAfGVaJrc0eHk
 n4jIWC0t6ZlrwBh3DgSyvWUIZFt0wO1BiovnmikB6m4NIl2psRfe+VcVxlQtTpZywAqs
 lE3EhxIcQvcc0BIZvMmHw6JDgLLGdzELPMCHIuub+CC3F5Jj3/yJAVghxUws+6Kf0ctT
 W4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HUFwEYHuDyXvHK70ETSgGp5dx/91U5W1rIutxfvFfLI=;
 fh=ZDSuhQo3pjEYSHSezNcziOY21RHpP42dPRjscILSidw=;
 b=jw/+4cL5tn1P1HErVIjx1DqU7b+XNo1hugKj+d57bhvDGzt32j39vYT/tg/428xkhO
 qxsihbOtmPspJQQItRHxUablBIsUUg2LB4W2ivc3jhVzeiV4jPuG/M2SfxWYr/o/NjfI
 g9OFiT+9sQoaJ0L2LS/xaszyOBPFe1VaBMSI12ypQmQufwx5V3t9V1b7zvO1TA6ovzzB
 VyUORQ+WkvI2/Ma2U814L+W+QA9Dn9THOOaGAyVp1g/T4iXTkZiTKcEs73J3la0H9Etp
 8LPsO/Om0plMzumxI04AyYWiKPImzX1C+ZnCTrkRHYPH8SeiJJcvDRbo3TyvsnK9YGPz
 ZVQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779955494; x=1780560294; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUFwEYHuDyXvHK70ETSgGp5dx/91U5W1rIutxfvFfLI=;
 b=No9PMf/CmMxu7+GkOJ+ZnPA3I78+alEDhP7Fq4gQHmMeTZ3x06XGiNootp4pdAokOE
 TuUhgqPpBlWODbx/dR2nHxi5fzid/kQ5qAnSjqLVn4RjtJWoBJzhsbazgZKzSZ6org0i
 ATznoUEsmxSqngFAB4jz++pvlL/nW9KlyyYFoZug9ni3DLvuODhjt/D5qwekZgwSD4+M
 uLrjyTamSXrsYmmZTR+W/MYGD3crHLj/XTEgY9UPdn7jaWUe1wLi0pN/o3eKc69N2puC
 u55m2qAB3Mvd8RaBHAjekYvrOo8Ftd27axtQ7pn/lAAI2moopt1A8ygPuWl0nw3+S97A
 gMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779955494; x=1780560294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HUFwEYHuDyXvHK70ETSgGp5dx/91U5W1rIutxfvFfLI=;
 b=sdlIrx8Smi3KpT0nfNRFaXnJ2W0IudrIlsgtbVIKH3QtsAuOgSI2oynZMScH7ZVvXh
 WgxZ2bPEG7XWZM8kQA7rMw6z4oYJkvptYNR2Pgvk5124d6WKVD/oTPTfr9RkpBusjyk8
 3i5V0rwb520fydp9Z8nuUGMpSPXeFVIcd1ADG0uhUBcjr0K6GbI0799QbvUpa2/vy5xq
 K88NSwhHoTgsWTL4O2HX99eNl/EAVQVAvFiwR/V6UMxkW5Ghi5EAYmlWTKLMRZZYQy8z
 K2wyeDVcSvtfI91jzix1Uy2Tjghp7+UCAX3giiWAEa2b8BHeFQZoWHN4qs1dpDYM/gK5
 itOA==
X-Gm-Message-State: AOJu0Yx3p6EtbG5xM2xTbGsHIGN6DQ7o+81hVJ+dudvr/Sg5WmstRG0Q
 dx/callgQyF9YTTu7UUlKxyYck/MZ0bX7I6xBzdtSq+J9qsmW2rDINaXwWcE3iG7T3fTeSxjLO6
 BnYwQ2eFgcrFBHtHP4NHznpadXKrlWk1SxdNkQbeVQ5Sx0V1h1/5qY/R1cLnGrvFV3gk5cAGNvo
 VpxRU26zTYjUs37etpoiZwNOu7Uvgrhfo=
X-Gm-Gg: Acq92OG3UoDGoHSCS3iQL2EnbUT/dlgV7WqZ32vXbzP+xNIqOrjoovfuzvc1VxAkx/G
 LV/9mhxvTUF2z4F15YGBsrWLD6EQ2GmoAxDmT92eQSlFEeXfhUzzm9shyYKuy5XjPTmCe2xVjdY
 dD7K/wZrBW/tXlKwN+qBaMQWws6JSzbqGVDO9cKHa1jK8TjubexWApRdtJVcdcwd50XclFD4iTd
 xdRHpT7b/rux5xnqyGQglJ783hTHiCzJnDBySznwZopjnRHD9otjCjl7kz4tf2S115s1TOFbn1s
 tmXsezHdKstUOz9heg==
X-Received: by 2002:a05:600c:444b:b0:490:388f:1c0d with SMTP id
 5b1f17b1804b1-490424a9c9bmr431074845e9.5.1779955494026; 
 Thu, 28 May 2026 01:04:54 -0700 (PDT)
X-Received: by 2002:a05:600c:444b:b0:490:388f:1c0d with SMTP id
 5b1f17b1804b1-490424a9c9bmr431074365e9.5.1779955493666; Thu, 28 May 2026
 01:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260528073412.551117-1-pbonzini@redhat.com>
 <20260528034301-mutt-send-email-mst@kernel.org>
 <CABgObfZwaiu4A2b2EFuFRA4dbWfHrDYEfiq5_-mf+zQpsYfTLQ@mail.gmail.com>
 <20260528035815-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260528035815-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 May 2026 10:04:40 +0200
X-Gm-Features: AVHnY4L1n2pUiaM8gIhggYag5OvjjAPriLO9-NZDAxVAzRodTrCtf4f7viUhUcI
Message-ID: <CABgObfbq9rFNHLYnhbr=5Gn9iJW1-BDsxTMLOjAoeM3h5Ct6wA@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 28, 2026 at 9:59=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > > +     AI-used-for: tests, docs
> > > > +     AI-used-for: code
> > > > +     AI-used-for: code (refactoring)
> > > > +     AI-used-for: code (prototype)
> > > > +     AI-used-for: research
>
> BTW: commit log ?

I don't think I want to encourage it to the point that it requires
highlighting, quite the opposite in fact. Using AI for minor edits is
irrelevant, while writing the bulk of the commit message should be a
conscious act of the submitter.

This was also mentioned in the other thread.

> > I suppose it can still be useful for traceability. I copied it from
> > Kevin's proposal but I can remove it.
> >
> > "Research" may also include using a script written by the LLM, which
> > is encouraged in the first section.
>
> but again, if the script is not merged, then the boundaries do not
> apply?

See the first sentence above re. traceability and copying from Kevin's
proposal. :)

Paolo


