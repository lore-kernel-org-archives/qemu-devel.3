Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C6ECD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4x4-0006Gr-Bu; Fri, 26 Jun 2026 07:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd4x3-0006GZ-0W
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:42:29 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wd4x1-000641-At
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:42:28 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-37ce68a54f8so585845a91.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 04:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782474145; cv=none;
 d=google.com; s=arc-20260327;
 b=izcYUQ6L91e7bDhyfP6CIunzXXaJP4vddV5hqLuBoWh8dgPb0YoXznUre1DwILHugp
 29A1wAYIXa9KHbAq+VunlWBL0XRfxLCUHjiSqfyEZ2QJcuhB21bf+qquN998JqxXBt9X
 Zx3ddVFMy0xOaPYZjrhal99ou9eueA09Kfzs5EulcDe6tb+o02JJrdzyClu9/aqI5LUS
 E8b7MidlsCgo8viegqYs57G51KUvbe4TKwUNxPbD81Levi5RHInQdyo2BRMnSKLi7Y3w
 hu9G543G2wHgefx69lEgCPFJuDtdc2y0YLYOgu69faqPP4cv/+LIQsq2ceLIsWPY43Wu
 NhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LzYeR68ci351khv7d2iczfG5MqB3clRjz3xqPP6cXzg=;
 fh=uTkvGJng4tHFjwqkiJVLBmPe0shYaUVChu5ajQcJYpQ=;
 b=HcyaWau64+neY2xiBM9YQF4LVv4bw79qJSS3Du4D3p5gZ7guFeF3genhvcz53k6Sty
 mVvzm/ruXtAQ1Du2qy3Ja00DJwVEAg6XAbhrbDA7bEMBBdz8GbCRE97O0Xa0++QBQ1mw
 BIC5+TXvN80nnF8fCwhP8H+iacpSGgRWoe4eDQ2onLLaLm68M6pyhsXEbDuf6ON4cPY3
 J6+UEfYrAyFB1fRLTrf9V2KxUkyO2rs4Wu69wZiZFe+Mj49CuJ5JfhWkfUqTzXG/a2hW
 ZJJ0wIFp+p3dcPob/bG0G1BS33P1a+qUEIYVXT8iK99/SVd9CZVKxFibZXRqII6LWwdE
 Lt6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782474145; x=1783078945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzYeR68ci351khv7d2iczfG5MqB3clRjz3xqPP6cXzg=;
 b=kEBY57cNL/vG/zW6kpP5b3s8pbbrPvdGRZqNUuPzRU42vEJfKGRxAeQkt7yiNt1+NG
 rxoj5m4KWidLOb+zopaWREeJeshAcMo7U2PydNjpsgwN2FF7jJFoQuSCFnGSGlBWf/o9
 Wtt4ww60JsuoI46pFC/eGLT66l+TA/FIJWXoCxaoCdDKHaLDNYsVKK14qn2Y+WMIxjQD
 LJo2k78cMZz7AP0LD3RKMEZYs1aGn4jVzoMFtY9m/UfW5O+Eh6H+BPreHvU8hLfHQwOK
 aRcsAUb9NE8xgGJOEDBYoibPBuXep8ffeUferr7tzUU754JvQbyeJFtz0QLRCydmka3Q
 rcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782474145; x=1783078945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LzYeR68ci351khv7d2iczfG5MqB3clRjz3xqPP6cXzg=;
 b=rI9x77RNKh7u9+twzK7QkGbkiauE/AsnQOJ++QqPQbEkB4sY2MR5s+Mb/1+ny5xRdc
 YvaSlMpiuOA3WCpGeEDamXeQZ6V4ZUoIU71sv3sH0TjuzVzRIxDgOMUwbDIBeLBeNw9z
 QjClyqmFLVam/hYK1fJ95kq5O43GgYsFpAWgad4q3sE3btQ0RgeQneutlM43UnaZg2NP
 lDWSJDQai9k5YqTDHtFZVeubZfpFVoJYmpXqRTm0k7SM4sfPGV1KgF8Ylb8c5E4L6Vhh
 lKomeDnLX8AgX0H7cfmoanAt5JHMxd8sLU7yA3ffQtX3Q4JYbbxkha6z4yjTTd9o+wPK
 Clqg==
X-Gm-Message-State: AOJu0YxOU3zWwD0DHa4M0Y81X0DF5+CFFD4gBd687VbgeLsPDbNU6pwO
 0nX8vHeTM050fmcUZ/GaLr5AetnNf06tvKElK7ngLF00UZk+rD9iGVt8SIE0KPWTqTGSAmbrmLD
 ltC7XEyJ7+NO4QkSUau0859/mG+rJkBk=
X-Gm-Gg: AfdE7cn9ieFi00ySk2TsPthqWBq+JMu2v08awMe7o1Q+iiy4w9w/N/G7Ill8ev9OPwD
 W0Sb15yIgskytHZUmbbwCHuUnjQQAsTe7xsNspotzpvviQAZP+x3R7EME72thBBLn+boCJvKGQ6
 hB3FoxJYOA6rd7w7YSUxdWM9YmIgRuqMrm/x3yl0Dn2+oDl45TlMwH+fL9A0nDqbF7xXXi1SBf2
 3pQJjRI19fwSQvGYIygbJ61FiHH6kXIntGIxDKBk5KhIavfIyBtvjs/IvJV26/uyF3oUmxSa0rL
 d4RhfuuCcXhuYHhb4bHYa8evxhH1Nyb+UCU1RKZg1VPrIxTDJG4+N9jxZGKz+Pg=
X-Received: by 2002:a17:90b:510e:b0:367:b819:2214 with SMTP id
 98e67ed59e1d1-37dfa27a962mr6422525a91.13.1782474145387; Fri, 26 Jun 2026
 04:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260623184830.373232-1-faithilikerun@gmail.com>
 <aj5jfQ90ej74tAB-@ryzen>
In-Reply-To: <aj5jfQ90ej74tAB-@ryzen>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 26 Jun 2026 13:41:58 +0200
X-Gm-Features: AVVi8CelSLPfF3NQ_gWpnJ48s-g3cg11MOxTgouyYqQG3m8qzEP2-0Oa54euqyA
Message-ID: <CAAAx-8++OnGkdv8hq0ROyYkCHSUsuHK_2C-FRW1qjVLahuS2nw@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] Add full zoned storage emulation to the qcow2
 driver
To: Niklas Cassel <cassel@kernel.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 dlemoal@kernel.org, qemu-block@nongnu.org, dmitry.fomichev@wdc.com, 
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x102e.google.com
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

Hi Niklas,

On Fri, Jun 26, 2026 at 1:33=E2=80=AFPM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> Hello Sam,
>
> Again, thank you so much for spending your spare time on this!
>
> On Tue, Jun 23, 2026 at 08:48:25PM +0200, Sam Li wrote:
> > This patch series add a new extension - zoned format - to the
> > qcow2 driver, allowing full zoned storage emulation on a qcow2
> > image file. A user can attach such an image to a guest and have
> > it appear as a host-managed zoned block device.
> >
> > The zoned format is opt-in through a new qcow2 header extension
> > that pins the zone geometry. Behind the extension is a dedicated
> > zoned metadata region that stores one 8-byte write pointer (WP)
> > per zone. The extension is gated by an incompatible bit, so an
> > older qcow2 implementation cannot accidentally open the image.
> >
> > Each write pointer is routed through the write pointer cache,
> > a Qcow2Cache object. The write pointer cache is written to disk
> > after the qcow2 metadata is written, thus guaranteeing that
> > the write pointer is updated after the corresponding data is
> > written.
> >
> > Zone states are in memory. Read-only and offline states are
> > device-internal events, which are not modelled in qcow2
> > emulation for simplicity. The other zone states
> > (closed, empty, full) can be inferred from write poiner
> > values, presistent across QEMU reboots. The open states are
> > kept in memory using open zone lists.
> >
> > To create a qcow2 file with the zoned format:
> >
> >     qemu-img create -f qcow2 zbc.qcow2 \
> >         -o size=3D768M \
> >         -o zone.size=3D64M \
> >         -o zone.capacity=3D64M \
> >         -o zone.conventional_zones=3D0 \
> >         -o zone.max_append_bytes=3D4096 \
> >         -o zone.max_open_zones=3D6 \
> >         -o zone.max_active_zones=3D8 \
> >         -o zone.mode=3Dhost-managed
> >
> > Then attach it to a guest via the QEMU command line:
> >     -blockdev node-name=3Ddrive1,driver=3Dqcow2,\
> >               file.driver=3Dfile,file.filename=3Dzbc.qcow2 \
> >     -device virtio-blk-pci,drive=3Ddrive1 \
> >
> > v11->v12:
> > - validate the zoned header extension before allocating any zoned metad=
ata
> > - fix the zoned locking discipline: hold the qcow2 state lock (s->lock)
> >   across all zone-state list updates [Stefan]
> > - reject, instead of aborting on an assertion, a write that reaches the
> >   open-zone limit while every open zone is explicitly open
> > - fix reduced-capacity (zone_capacity < zone_size) handling:
> >     * transition a zone to FULL when the write pointer reaches the zone
> >       capacity
> >     * report the zone capacity, not the zone size, in zone_report
> > - return -EIO rather than -EINVAL for zone write-rule violations
> > - use int64_t for the zoned-metadata cluster offset and zone_size to
> >   avoid truncation on large images
> > - simplify qcow2_cache_set_dependency() [Stefan]
> > - virtio-blk: read the zone size through a new blk_get_zone_size() [Ste=
fan]
>
> > - docs/QAPI: clarify the max_open_zones / max_active_zones /
> >   max_append_bytes descriptions; use warn_report() for recoverable zone=
d
> >   configuration values in qcow2_check_zone_options() [Niklas, Stefan]
>
> I'm sorry, but to me, it looks like patch 1/5 in v12 is identical to v11.
>
> Did you perhaps forget to do git add or something?

Ah! I made a mistake of mixing changes of patch 1/5 to 2/5. I'll send
a new version. Thanks for checking.

Best regards,
Sam

