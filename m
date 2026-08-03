Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E018C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqzLF-0002k0-Su; Mon, 03 Aug 2026 16:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqzLF-0002jh-8B
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 16:32:57 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqzLC-0004qn-Aq
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 16:32:55 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-52cd38ddcdfso1839711cf.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 13:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785789173; cv=none;
 d=google.com; s=arc-20260327;
 b=eJm19c/P6g+he1264Cu3cFJv3eNatbsGCIm19zN6RLR9gE1VMbCnYx3NJtPZK+M9Cc
 OGkNu2s8ugk2lJ58C9eLzOjtYGKFfMzykjrO2TWIbp2o7M7JshilrMyOB9sPksx9w7ZZ
 E3wzBdVjtoeXU6wUezp6OpazQkIRe2w++anB0LxThGbomRuZVPZYOlHLWCro3wOFS+bB
 Jn0LIcdrsvh8GBndaFVCxvnRB4m1cORfrn9Qwzf1nPgsEn3J4ZhjjZ+ksSXGrglJhPLj
 Ox4sfhWO4PeQ2e6HcrV6WGn8Ox9jnyQgd6ebLKSWs0oEfuRaI8xGUtnezMO7ObVTkGjI
 SvNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hCwtTTt4p/er8EyO83nYLEPRBSYBVwZi0eOgwfYj6sM=;
 fh=xsRg86ZwBm0LGRQZIEC1R+b8QTOodxCX7/oSmDWEnOY=;
 b=LI4kAvfmHf3DrGT/v/DeF7voELQRQNdPzQMGpalX+X7Y/8pTl4XJL7bTErFiMZ5HaD
 EZv1nB+x17VG/79UlCudVf/QJTI/2Is9OfEQeh8/xG+0SQ1/Nhz45aHIr0NTHBYOvEwv
 CnNbCT6j30sNVqmJ2dlSmFpLPJnoQE177s1/uyxG6F4NiMB040pV3obIPpe92tKnR3nN
 /WvJmF/R0/17gSrj5kkTjDGR0Ll/ax/jdvYpVH+tRv/dbNrf3uJpW9sAbtbe+f5haKWc
 ORN0nH7+1yhFSFgG9MQGMx5EmHkAQLzAPhiJW06roFm/ecUZ65tGIJl/ONe1lzbBuO0o
 6dmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785789173; x=1786393973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hCwtTTt4p/er8EyO83nYLEPRBSYBVwZi0eOgwfYj6sM=;
 b=MuT3pKwGj8dXEK6pqiWvomMMd9r5qNV2ISFLdUXyuYP4wxdtTpGydAAJbiR7u3kIlp
 YN27MYGvhbVHIO63OyF0e7/RF5YH1qPwQTBOB/9PpQKA6ivQeg7TlwKpVXNirZxB1bJU
 d9NfKRkP0tJXOEy2tlBH60jlbb2HT8iKr3DAQ3O6wo8JFlVpO22tvBxMaELgbQzi2sIe
 Z/OyuUo14HwFVBthruPJX0HAo5dq+WQrcAZvm8bWs8Rd14IPKevFgt0LtCLC9QSmKEX4
 t39m+POBDxfFc1I8u8e3TOPFeuS7D/H/9EoD5mm8u9YuGYSovQqZnFlU0juNj7UCiDjX
 bM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785789173; x=1786393973;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hCwtTTt4p/er8EyO83nYLEPRBSYBVwZi0eOgwfYj6sM=;
 b=DWjZFpFygU4sHispyie1RRofV2EGSC+E6+MWJVHrsJzjnWpxQ6qu1SezrSFe9H/uN9
 C1n7leubcXt70yAljmH9AkW7634SCAVyTJvNQ0MZ3c680lsk1XSMyW4uasgpxhKSBPb5
 7gz7Y7R1tGi/P773d+zWDBHCNkYAw8pqULDvaenyDK3d9UhS/2cIGSD9jNGdNYF1ShO0
 DVBxTqTEjbtlCEKJ4n1wabOwqAiu1wxSniIGDFEJKldnDV48Fm5oVa6P+mUj87R1UfF+
 8j44qHxdR/lqHVx3co0AAp8aj9MQoo7V0fWrSb/f/8XrKDtSDjM4Ifbvwvxc6M3n6/ic
 WBpQ==
X-Gm-Message-State: AOJu0YxAM+/R3VvM/rt5M7JoHdrfzSx20TsN0ph1/ZmfZrQvcX3KJhSI
 WPQVQ8UpiDBYTgTB8rNGOdQil062hLTY+0MRZDkKjvEnAOdLVX5i1/Ial8JJDA6mYrzNFwxKNRM
 qNUrcZH0YnAqkmpIQkfjw8oH1tFhiUj8=
X-Gm-Gg: AR+sD12OxlKBztC2I+J+jDnQZHEa9gydvOj6IIM6HMWhoI9w6ggKZBXb4JMYuZH1Xms
 TKzcWBiJ52u1hnFngkUobd9VqczVwpyg0JrL4vPWs8Bv1ZSxsA52BWK1mMm6C6A0kpM3va9Ft01
 /x907TjpeyUxq1Lhpyi9bqkLRsYTxpsePVR1jiT6/Sl1n5LQht5a2VgDidJO3uf7XKRiKvVS9r5
 Uxe++vfWjnR4SwwNBDH/1YdfNldw2VmlTqHF99x2XBXvGDQcV4lx1swhSNulwhA2e0dcAnTVFnE
 FULd5YLNQp9DdCgUpo2Kj/vV6wnofRsAVHEywQrzVAuXiQKL5B8kHoCYeHuImM/g1P2lgYeKx1R
 b
X-Received: by 2002:a05:622a:410d:b0:528:162e:29d3 with SMTP id
 d75a77b69052e-52b5686829emr249348801cf.32.1785789173039; Mon, 03 Aug 2026
 13:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
 <eb1d8424-206a-47f5-9ad5-a833a56bb3f3@redhat.com>
In-Reply-To: <eb1d8424-206a-47f5-9ad5-a833a56bb3f3@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 3 Aug 2026 13:32:39 -0700
X-Gm-Features: AUfX_mxADHRsqJpTjVeUC1ttkitQKMfWB-ffhp4OzB1p5Jw_h04dsthg77bcW3Y
Message-ID: <CA+spn3pLkHn_Wk+-xa-k2PKXdDSa-S9c1Dd94t=Kj5tajPyzSA@mail.gmail.com>
Subject: Re: [PATCH RFC 02/15] vhost-user: Add memory-isolation qdev property
 to vhost-user devices
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 3, 2026 at 5:21=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> Should `vhost_user_vga_inst_initfn()` set up an alias for
> "memory-isolation", like it does for "chardev" now?
>

I am not 100% sure but I can test to see.  If an alias is needed, I suspect
that would also apply to vhost-user-gpu-pci, right?

>
> There are four lines in here that the checkpatch script notes to be over
> 80 characters in length, so they should be broken up.
>

Got it.  This will be fixed for the next rev.

> [...]
>
> > diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> > index 90bd2903db..d2a74a2860 100644
> > --- a/hw/virtio/vhost-user-base.c
> > +++ b/hw/virtio/vhost-user-base.c
> > @@ -409,7 +409,8 @@ static void vub_device_unrealize(DeviceState *dev)
> >
> >   /*Define common qdev properties.  Inherited by all children*/
> >   static const Property vub_properties[] =3D {
> > -    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
> > +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> > +    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memory_isolati=
on, false)
>
> Nitpick: I would add a comma here. (This hunk shows specifically why
> it=E2=80=99s a good idea: So that future additions don=E2=80=99t have to =
change the line
> to add the comma.)
>

Ah, I was wondering why I was seeing so many hanging commas .  That makes s=
ense.
I will add the comma in.

