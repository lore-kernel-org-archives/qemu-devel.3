Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25AF606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YoSqLCR8;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jIOxv1OB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPLJB-0003Pl-1W; Fri, 06 Nov 2026 09:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xPLJ9-0003OL-Kj
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:52:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xPLJ7-0002GG-Td
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793976765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hAG1lMR6EpyUF8Mo/bczfeHpe//nmcoFZfecTgTJ8Q=;
 b=YoSqLCR87VRyOpF22H/oirtcVTqBpgkcG0RUceamFUQrBS6pufIf/fhO/qB/nGm56XGHpw
 rBFVzwNidfBblJiNCUhyYg/pTZjDT+wZmgjln5GQ2mnPlGA2Suwo1StKTfMs5ntV68X+Qm
 g//9ztiPrXfaxTRaRWu85N19d3gOb00=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-gbIxBAphM_WPE9CzdgVN8Q-1; Fri, 06 Nov 2026 09:52:40 -0500
X-MC-Unique: gbIxBAphM_WPE9CzdgVN8Q-1
X-Mimecast-MFC-AGG-ID: gbIxBAphM_WPE9CzdgVN8Q_1793976760
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ade5b3ae97so681753a91.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 06:52:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793976760; cv=none;
 d=google.com; s=arc-20260327;
 b=JgrPeQBPYAml6b+CmEPfbeZ2hxw2XEm2+r0NXCMADWt67Ld4pgltLmyXJeMXt85zp8
 zJvCG1NU6YJzm+FASk4iuO8GNgZ8ChGbV39Vd+vYOie/ZCc6jFwquaaGxnCdMvoWZamF
 EV09ViaIuqul2evQ4GQoAezFb0pw+iLg+Sn5OVSHVsIIxShuYuylb8jK06EDYlQafZG0
 iGnqwwlJdXm5YaPYPaz9bencRF9r1l17L+damI3ZWCspZmQ30vUCFINlGp32x34wcn83
 X37pMcKel+lLxUqI4UXsZok/7qmFZNLm4MreDhVb9FMWEa8xYz1inlStde4PHLiVWp3w
 TbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+hAG1lMR6EpyUF8Mo/bczfeHpe//nmcoFZfecTgTJ8Q=;
 fh=1AbWADtWmakKEyv9HcG4MidgvJ6nC/INvIYgcdzfmcQ=;
 b=itGub0PE+gjPuqQMxsl6j8HM1V5Xb4GIE6+S6ViwS+Y9K29RIqVsPVdVw1Ax5LZIGM
 RqHNA4ihHe2TiJO4VpC7c9g+Jp8hcxho50GdciTK8SNyb1S1A0PTm3ZFm5Z56V0BbsxZ
 Qe93Qz9QEYfjlI2eTfjZHkiImzgIr9CF8DA83B3W6UVkItR/etY01Kk2ojW5koa9rwvp
 W2bmhJcY3ha3isWsSjmB38ncEu6lAzu13psD4GZQu8l43u/LeWgb1mN8j2mjOeyGRIzH
 w0LNG4ak9CZIJZkJH6ajf/bGtaYQ1qnIGqr8C6Ui1nKtm/6pMoV60fZdusZwFDI/8P3q
 ZG3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793976760; x=1794581560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+hAG1lMR6EpyUF8Mo/bczfeHpe//nmcoFZfecTgTJ8Q=;
 b=jIOxv1OB0/KK8vaGsjlAOXlv+jsx6V+WdO28Wemfs/qWAg3wiExG7DSEU2X8Xfyebr
 edmwXcAZduzTtHkmQ6Kqd51w43N6jbcG1w8J/N8Pk2klCo2UD04hYLzbJwpM6gcVUxYh
 ov+XTUj0k4QsNVLgfpXKMkqCT/dGBh826/1U8TGFw8FN8g3wOqV0LYebg1QSVP2a/nAh
 mHkMGhmR1WiLJsRKrKoibU4Wlz5Qc3q295kovM5e9ddz6/VdhSIM7qEn3rnfw8/kY8wg
 66btQARTvmy5mX9sC5dECDv7hHb0CIsO8sZwVmJx5rNEZqjagpPvE2LqXNV9ZIXwDolI
 CyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793976760; x=1794581560;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+hAG1lMR6EpyUF8Mo/bczfeHpe//nmcoFZfecTgTJ8Q=;
 b=InH6kuOqtHb6potAH26GbYbSg+AxQIkdwWbvMLVS6JPzE3JVwby+36se6gD7VsFMO1
 Lj50UY7XUlWoaxUZCawN8ke4epUbkWGM/+pvY2xDZyxgwH/TtHOwYUI2E7S17BQjjCzS
 QTj6YHCoLpC0GDLO78s5pbc8CwhJhDYrbsZJt2uavOGmLxlW7AXFC+GTWh7FCIBVWDRa
 2FWcX7eB647w5EBRVmWe450EfYz+bogrpKzTB1SFKYH1DQg9Mg8BIRGaN0t0DE+FMQm6
 y23AhQJOqLkR2dWHWI+66F9LRR0nrWOWF3V+3ooc2cZsCrAk27mlaJ5LAwd2J5a/WZ7d
 dbWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErErAjtEyRsIZnd3H09cEFhduFsyKdAaHuNHy9qtd92HvezITnYeU+qvytzOHQf05WhJas5qnx0o3uyX@nongnu.org
X-Gm-Message-State: APuU4Z/yAM8Xnoh4Tw7wNfLHy/Dc77795Hyg8nUjSZi/sHyioJAolDxk
 dzSeu1lRL8UqZQCXkiillCbghTNnp0gz5QfI89UtcTiMCSfz6j1iCu4gTcKoVCp1cJsE2oRqmT2
 8ikl7C13CBk5JaU/NyXEynQS2Z4/1/ifsqYBMefISEieOx9h0Q/IDXfgvHb+OdQKufpcbf2NNu1
 Rac1vtnifNqxF0SIG/qNgDpy9oga5WZC4=
X-Gm-Gg: AYBFou1eVfCpSoHJ/QbzMBhYdWblSDV/evJKVI9mjoKvBG42w4ZeSPC0DqD39RAmH4q
 pt6mkPDbLsS2QT9Hj0Ynv1LFZ4HnvTHKSov0kzQRfb0/XSYsNVMDjaQreWI44f09YmI92FV8Ze0
 3I1Xh9loinity2JRX00GbNEm/8RzPnBZaW0si/fl3zcwEU5g3AmgR9aHNAx0z9nllfdN09+rRqx
 izsnxqulLqsj0GNUOalkZujM/9S/8FQ4sb8K8UX0G+vZ4punhhHsICRYX/ZEpOOQikXHgR1u8Qw
 Ng==
X-Received: by 2002:a17:90b:35c5:b0:3ad:677f:567f with SMTP id
 98e67ed59e1d1-3b0db70daffmr1759559a91.40.1793976759691; 
 Fri, 06 Nov 2026 06:52:39 -0800 (PST)
X-Received: by 2002:a17:90b:35c5:b0:3ad:677f:567f with SMTP id
 98e67ed59e1d1-3b0db70daffmr1759539a91.40.1793976759161; Fri, 06 Nov 2026
 06:52:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-5-berrange@redhat.com>
 <fe7f7d29-8ca3-4ced-afcc-c768b84c4888@redhat.com>
 <CAMxuvazfhfGSZCiSi+viwJ7f7XDWAZfjmW39n3a7a-qQyw-YSA@mail.gmail.com>
 <au3mwO32b0-PSXKu@redhat.com>
In-Reply-To: <au3mwO32b0-PSXKu@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 6 Nov 2026 18:52:27 +0400
X-Gm-Features: AclHuK8PkA73Zsh95_t7Twce7oOByDLrT6UMHFSQfVJqhUHCjhh81u-PlI46tLQ
Message-ID: <CAMxuvayhYcOvH2QPptrKUQGFHoRxQcM1USF5OwuZYR_g2c4zgw@mail.gmail.com>
Subject: Re: [PATCH v2 04/28] hw: mark all remaining virtio object types as
 secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Fri, Nov 6, 2026 at 6:40=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Fri, Nov 06, 2026 at 06:35:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Nov 6, 2026 at 3:53=E2=80=AFPM Thomas Huth <thuth@redhat.com> w=
rote:
> > >
> > > On 29/10/2026 14.12, Daniel P. Berrang=C3=A9 wrote:
> > > > These are all intended for use in a virtualization scenario and mus=
t
> > > > provide a security boundary.
> > > >
> > > > Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > > ---
> > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > >
> >
> > I have a second thought about this, I'd like to exclude all
> > gpu-accelerated paths for now. virgl/mesa/rutabaga expose a very large
> > attack surface, so I'd like to drop them from the secure boundary
>
> Rather than repost, please see my response for patch 2:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg01530.html
>
> TL;DR: we have already promised anything virtio related is in scope
> for security handling for a long time, as they are all unambiguously
> "virtualization use case".
>

the value of a secure policy enforcement is low if we know those
devices are unsecure and don't have the resources to make them secure.

> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


