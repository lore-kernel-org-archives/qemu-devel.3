Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B9FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbfQ-0003La-Iw; Tue, 28 Apr 2026 02:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHbeV-0002f0-9K
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:10:37 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHbeT-0008Fh-9m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:10:34 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2ed0a45e970so480737eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777356631; cv=none;
 d=google.com; s=arc-20240605;
 b=S7TS6M6BsZNm5SgUuWTflHqm7edWO0qHGmepHHNgi9mtTu3pXfMIqiP3jd6SssSy3G
 hEOe5us9FuwzTs5w3hCEwRyO9P2I6K3zXgR8ooe25CWmXcLiBN7lOHb9sCUDa/A+EYHj
 HLCsBNqw23URn19r7yz++AUUmiKZBxvi/aSQt8VXsOH2dXqrBHAgqukrpXDtGzYyBUdz
 WYagXQ2HeT+SbUHKJoKb2v2OWw9PRHJennm4Y/km7GSq/7TfIol3d4nqBvyLD5N0w6Kz
 9fMW8+vghimREjBno9oD5es8BaaXnD+xaeB4r2Nlu+wQzex2ns6+Ua7/paNciZNiIfVN
 mluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8KCctdcuvyCf9r9u2hgYkHdY7gN0NsREHb4IcWcPcuo=;
 fh=JqQGORTJgH2aWZpUHKn5bzbF0Tsf7s+opzR8R+EYOmI=;
 b=JU39riEHtgDZaoOJloZUnDPv9/nYuy27GTz8jw19Oj+kf6152DphsPzksrqrNHsBmc
 fV2zxLLnFU1dyPeMQhGVvvOwjSLTtawRZytESRDx4ZT0Bj3FrDZbgivasqf5InPqZeAM
 fI655YhRw8vyPq0wNDt7qxfQgnDSKoKbL9qx8By5dMHD2mblpXocovNZszeWsWaWv+b/
 uK4AfsZVDvfVtj4mnLiF2qekUXqdjPZUxNf3cHMAUdFz+9NK7UUBMqf/7NmQKBPX8Q+1
 R3g9fNLNSSflM34XD9BVEqF+QzPbmDp+5GrIBMyQMt36pBzE18/FKejPmroIdYYPg52y
 VEqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777356631; x=1777961431; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KCctdcuvyCf9r9u2hgYkHdY7gN0NsREHb4IcWcPcuo=;
 b=ESkcF4KJOfNt75bFiiAVNsTiooUZWwdEN4lWU9nDYtCltWqHOQ3DYYx2RGCRH9Kvep
 ZpuIElZaA7Krl8aJdHW02ex7kyeaqJkC1YNpA5k4Qt8dUL+pWN+8oR7cDjrHPi1PRcVo
 Kavy7pebw3+ZZZ4pK3PBnmcypXNuo5L/NggIN0mdfq6QnLxnd6460nTB+ztD0F/h98NV
 me/XaiJFkh39f/nMIBXOl3r3HqNKeJ6ZVK44oyfr8Hd6kT34glzvjRLMfQkbnTSRVtI6
 1ZDJ75gRqd5woV2j23gBNlA6SeXDaPvqHLGTWGeo2G0uRgNHgR/Vv8S6n4ofpOXzOaWF
 EpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356631; x=1777961431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8KCctdcuvyCf9r9u2hgYkHdY7gN0NsREHb4IcWcPcuo=;
 b=hgyoGq4QJRsaAJvOqyrmCEfATM/ie/Q4/oyLkXPKxy4IEW/LD/wUplWlYyGOaa1JVj
 tYQrSgzd9ZsOcdWDqcFGYseiJxtxacj8QBLsudCPo4Abul6cHdlt1J0d54G7x/x/g83s
 VYeKpw7VHtk2loFeM9TXmMFs3lv5znbZYCad7+XtDjoq22ER2H1kdr3ggYVMhX/ETBVj
 3ZtXCUn73GwMUV7cAN6+eftZH8AsbSZ/vBsuNCUV63QvjDeHeGrMwpAKjqh3QYiyhjRa
 QsZI+yczc+W16FGlBlBuSKv6f0kkWL8HHimYoOMnsnhlEv9SD0dF6zouAetDrbl62B7m
 LOwQ==
X-Gm-Message-State: AOJu0YyycmLDbKgjBTYNOU8OO8TX+Yfgq0fi2nXv7ZQJKRXK6Mj5IHB3
 Rw7L1G71UjKCW01/7hjFMVfKCODCEESSAT572KnjCT8g08gfvoD9VTSpS1lI1UQ8hDSX8x055vM
 Ta27ave4TNH7r8wn57TOulCPmPiOyTJw=
X-Gm-Gg: AeBDievv3u4agK+hhqRzlzodjao+3S60i2lONkwp3sdXgXw+Cb/reMyQ1TNAqICpZ0b
 VIFVtkEYsaDFOIDBLWZPPrl8g8Fd+TZBXI+eCrfpqSh0X/GTQMV3JF/xNGbTM51inEvnGZcEm5I
 X6aNUO5qYCrM+JdyAhlh3I2tMFLUBNVOuOVYpU/n7JvemnS7ANLw0NIWdBoDD8jligBAFaEXY2z
 Cpk72pnswnAphsQuhQo73APULWPO7ab2j1X7UokZgrF+mayMe2OYkE6GmsF9F1BZel5BTJA88oL
 7HagRJxkxCRhkIyA8CoBSQydzp7ByTUNVm8ISd2F9BjMHEc7BTaUGWxZO1wFoA==
X-Received: by 2002:a05:7300:bb8a:b0:2c1:6cfd:73ee with SMTP id
 5a478bee46e88-2ed0a0a99d1mr747519eec.24.1777356631313; Mon, 27 Apr 2026
 23:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-4-c413f3605311@redhat.com>
 <d48730e4-2034-4245-a671-9d2dbd72b1a3@linaro.org>
In-Reply-To: <d48730e4-2034-4245-a671-9d2dbd72b1a3@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Apr 2026 10:10:19 +0400
X-Gm-Features: AVHnY4JjyIt1RQJvuFHktf_L9pE7s51ZXxqXSjJco_W-OnjFoisQUM-7xKjgFzI
Message-ID: <CAJ+F1C+ginfPqr3K4yYpnhC++SDt6Z0YBH92aTexiMHZpsX6dg@mail.gmail.com>
Subject: Re: [PATCH 04/41] hw/pci-host/i440fx: handle NULL bus in pci-hole64
 getters
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1329.google.com
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

Hi

On Tue, Apr 28, 2026 at 1:01=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 27/4/26 21:42, Marc-Andr=C3=A9 Lureau wrote:
> > When called on an unrealized i440FX host bridge (e.g. from
> > qmp_qom_list_properties), h->bus is NULL since the root bus is only
> > created during realize. Guard against this in both
> > pci_hole64_start and pci_hole64_end getters, reporting an error.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/pci-host/i440fx.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> > index e7d638b296c..6952094510d 100644
> > --- a/hw/pci-host/i440fx.c
> > +++ b/hw/pci-host/i440fx.c
> > @@ -189,8 +189,14 @@ static void i440fx_pcihost_get_pci_hole64_start(Ob=
ject *obj, Visitor *v,
> >                                                   const char *name,
> >                                                   void *opaque, Error *=
*errp)
> >   {
> > -    uint64_t hole64_start =3D i440fx_pcihost_get_pci_hole64_start_valu=
e(obj);
> > +    PCIHostState *h =3D PCI_HOST_BRIDGE(obj);
> > +    uint64_t hole64_start;
> >
> > +    if (!h->bus) {
> > +        error_setg(errp, "bus not realized");
>
> "PCI host bridge not realized"?

Ok

>
> But calling a getter at this point is a programming error IMHO.
>

We don't have a way to prevent calling getters when objects are just
instantiated but not yet in some "clean" state. Since this can be
triggered at run-time by QMP, we better return an error than doing
assert() or crash.

