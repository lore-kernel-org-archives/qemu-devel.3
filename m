Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B06CCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVVh-0004vu-VU; Fri, 19 Jun 2026 05:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waVVe-0004ve-SI
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waVVd-0002Ma-CK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781861252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuXbN23PIU58b7deksHZ+0DIOrEQuFLr5bpHZ3gM45E=;
 b=Og3C2x/YkN1BNW4J5ZbcLoN5Av6yk97G83RsdBaUX7oV3DrjcNhSBSsULPN6UraiNpraFk
 CeA4iKXqAc/jJA73PW64jicFAs/1N68vTQ27YFcKZa/xN3gVX8ooM6RILyi93CxXdopSHD
 XibH2cjIRFPmte8++DOs9RalH2AlUxU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-Djg2uRS1PWaS9sXuSSsrcA-1; Fri, 19 Jun 2026 05:27:31 -0400
X-MC-Unique: Djg2uRS1PWaS9sXuSSsrcA-1
X-Mimecast-MFC-AGG-ID: Djg2uRS1PWaS9sXuSSsrcA_1781861250
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6eeff3b75so2304714a34.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 02:27:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781861250; cv=none;
 d=google.com; s=arc-20240605;
 b=WmZH2f3k9ORBKtUZabBvdm3Ber6pZ/dHS9LkKPzjPeD2CYPZh7M/wBF139nfwDBMA8
 CQkdKAWCqWtnRnBGsxzuikXYdXnbSVP/CCVOz7Qq1CzisM9fugqtIvGq6GB6ckkQM9kB
 RIdhwNi9maYoTVDm1PTHZ43qHFYiF98atKvRAzesQrWWLgk4j6JLBRUpwk4EMcHQaPgh
 4mv0oHhjqLaJuWQgfbzyDoEbdf9gbskHBrR1G68dsw+2FjOxHcge8tpj6XiCPbhT6cC+
 +Db5xvf4t4WXV2YTaEYtyT4vq9oa7ZTZ7AKriwmHJ3TjIujOySEB0egbg9lezgT4YIRP
 Q1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RuXbN23PIU58b7deksHZ+0DIOrEQuFLr5bpHZ3gM45E=;
 fh=04v5ZYUW8ANt5RCk6sNpTQ0TYFD6RCbkcuU9tSkC1zE=;
 b=G87tnWaW4l1pjq3eKdLZlsqGWsDV/McmsKRM13Krpp4nJ8nA+yWVbbnaNBefbe8xEu
 Eq2TmLrSY78x+X7Vu0XqfoZK5k7OTNQmddOFVEK4ma+szCfQ57S7YX/8GStOEmXFGkF9
 hsThCQ3Zna7xFnhRDQOBi5vu6HgpILAH3YMInjL3hi0f46d0gBMLjSc07qrBx/LeoNMp
 UwAzNqFTqOCPh9MSWnQ4x+ZaxJ/vAGOy8wTjj4Wwz2HFXTyKJvgyRAvvnBQXe6kTOoVP
 pfCLvkqzjKTonz0Y7FO0B6xk/FF9Xo4RleI6KwAHryIGJL3cXIMgBgkSv7ykPcqIDKIF
 DxCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781861250; x=1782466050; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RuXbN23PIU58b7deksHZ+0DIOrEQuFLr5bpHZ3gM45E=;
 b=PHZrpccfYx9Koe+OwTX3hkMF2+A0c3p3hUe27cysoSXgbsNmQak14MTx3weCxd/JWP
 MQJrTBk0zlUtLp8PwNwzr3r9r752qNJ0NsfCoDTnNqrt7PWAHQ56FmLvQjRLfQCCeqTP
 5ku2DtCgtzv/lxrHayl4fByvLMkrRjWFbPb2ATcvcFrXQOneKOq76O+IFhUkfYb0Qr3e
 DOAE38cx40TV335oU0Fe1apaOm2+63A27rlBm5m14MP71fpx9YSJqrNIBHkEmJdYsofS
 JSODef1V6rw7RODltzZZch41PtoGHo0J2ZEXNYkQKHNvMa6FpdnX4YQ/sEbhYX+13dgu
 998A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781861250; x=1782466050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RuXbN23PIU58b7deksHZ+0DIOrEQuFLr5bpHZ3gM45E=;
 b=kQlA7R5771GsHr4lzQLBbGmn3W7q2y6YoEXjFy/aHCBz6oF6vySImxsao4e9AKFI8y
 iMCHHCOlv4+WAf/5FsFQVKM65t3sduBaXOAmVYadQIOau1GYSoken4nTdq41onwXJ3nB
 dmMVy35TNiYduSOUd/1m6GHbDVKCEoX2GN4E3fJejrCl7Ea4d5UEXIc88py0gNE9Y2YK
 A0Ti08uNfC7i5VQ+1htnripRH34kIa5LFW7I+K746hblJql1bf67PJK+jdlVfWBHnjBs
 uXjIiqOT+9JpTb7YOhLJRGYYcdErZ3sin4p9W8VkFZ1b8mga7b4rWyyY6GIs5Xf2prCj
 /QsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ//WTAwVj02INiXODtSUcyMLEOfqjw/mhkhOQGlPLsfdpvPX/p3tJTIYlYKltmZd3wzp0UIYbhURaHn@nongnu.org
X-Gm-Message-State: AOJu0YxnQD6Z0+cPt6Rq0ENbVPek7QWh2O5yDANPlB3kdUecSKhN5uQw
 dJZLW/KrWhThWgPQzMPEELjpI90CwJ3361hbOydwE9gKWz76Yw6YP8ntxQPzDmyjgA2kgBiBqN4
 WKsE8zKGNeaE9/U+ktsFoqwQi+ru06EJxBDCaPceeTPlgmKF5tokkLcLKBl6D/3okKaGiu0OioD
 3BAnDJ0AGE0oRcuIdBrN6ljALJACfi/cI=
X-Gm-Gg: AfdE7ckCBO1YGbiVe795Q7kFxfdUNw9jSLKnUcNnmp7KzDtTvWvv/hDPZrlQdm7DXMV
 xfXZr6glEYzPjjleNsZDUb0O1RZ3YGaN3fayu6hJof4CqK+mkmi60oTQy90NOokQvHLGlmNooAP
 3ZFolUjBnVnSoSleKhVRv6MKfAbMNcayXjfQ1zeKCD8A4YvffstvOeOOpEfH/JvpelIsHZHFz+f
 Lof70kTPZZKplSifOQhN71ZXno=
X-Received: by 2002:a05:6808:f94:b0:486:4212:d728 with SMTP id
 5614622812f47-489b1bd42a8mr1299789b6e.43.1781861250564; 
 Fri, 19 Jun 2026 02:27:30 -0700 (PDT)
X-Received: by 2002:a05:6808:f94:b0:486:4212:d728 with SMTP id
 5614622812f47-489b1bd42a8mr1299765b6e.43.1781861250130; Fri, 19 Jun 2026
 02:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260619053623.756021-1-mbawa@redhat.com>
 <20260619053623.756021-4-mbawa@redhat.com>
 <CAFEAcA_5d+_miPKpUf7Zo=B=XwCF=vcNZMsv9jQa258pF26nRA@mail.gmail.com>
In-Reply-To: <CAFEAcA_5d+_miPKpUf7Zo=B=XwCF=vcNZMsv9jQa258pF26nRA@mail.gmail.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Fri, 19 Jun 2026 14:57:14 +0530
X-Gm-Features: AVVi8CcGV1OC4Aj6La72zRgLI-pjxGw-Yz9FFXcZbMgC12HGK_Z4dvaXbqoQVEI
Message-ID: <CAJg9KkzGPNqmAqzV6zm+UAoepVDwEgyj79FMOxaw4P-z4Bwrog@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/core/platform-bus: guard
 platform_bus_get_mmio_addr() against NULL
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 19, 2026 at 2:47=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 19 Jun 2026 at 06:36, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> >
> > sysbus_mmio_get_region() returns NULL when a device has fewer MMIO
> > regions than the requested slot index.  platform_bus_get_mmio_addr()
> > passes the result directly to memory_region_is_mapped() without a
> > NULL check, causing a SIGSEGV.
> >
> > Return -1 early when the region pointer is NULL, consistent with the
> > existing "not mapped" path.
> >
> > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> > ---
> >  hw/core/platform-bus.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
> > index a2217a2dee..16d0ecc0f3 100644
> > --- a/hw/core/platform-bus.c
> > +++ b/hw/core/platform-bus.c
> > @@ -59,8 +59,7 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *=
pbus, SysBusDevice *sbdev,
> >      Object *pbus_mr_obj =3D OBJECT(pbus_mr);
> >      Object *parent_mr;
> >
> > -    if (!memory_region_is_mapped(sbdev_mr)) {
> > -        /* Region is not mapped? */
> > +    if (!sbdev_mr || !memory_region_is_mapped(sbdev_mr)) {
> >          return -1;
> >      }
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> but doesn't this need to come earlier in the series, so
> that the code can handle the NULL pointer before we
> change the device/machine to not expose the 2nd MR?
>
>
> thanks
> -- PMM
>

Right, I didn't think about bisectability,
I put the patches in the order I made the changes. v3 then

Thanks,
Faiz


