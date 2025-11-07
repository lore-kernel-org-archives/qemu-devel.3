Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0713FCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJN0-0005LI-Lr; Fri, 07 Nov 2025 05:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHJMz-0005L2-D8
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 05:07:01 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHJMx-0006Bj-Ru
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 05:07:01 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63fd2b18c40so450101d50.0
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 02:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762510018; x=1763114818; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kzn5dgDShaETWr++9NNSL6YhtukhSIhCmdYfBHNhS00=;
 b=XN2EM3Jwmk+rq42nf4dgbdFQmEekuvFkq/AdI+vm4Oo2LFcUUROd6HbS4AvEIYhOCE
 cgOTQcJGIZHrulYMNqlgzLJ28r4JkrPbZlU3JFsFyMQZaQdKnRCeRvDC3Mhw/C3rZOpg
 vQWl+5bhxBm1a2objY5LUPOb1fWo7y/Sim6PI6EVuwxLqZGpqW81v9cuDQL5AK5EXj/Y
 aODxwIJIDAsOT9nTJhLICsh3nNJBwTncI5NE5twdqw90E5Y9W8u7CAU/eQ7Jyai8aOFW
 am7FrFVlUFvmm1tuLCoXV2ola6QmSUOG33PaqI6uPrYc64eDazGHgjmwl+HcYTSaEql1
 +tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762510018; x=1763114818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kzn5dgDShaETWr++9NNSL6YhtukhSIhCmdYfBHNhS00=;
 b=Mi1Hqnmo7AcAB3ij4cXQmMD7PQPdi/HpBAVrNuaAIIl88ekppfLkwviMyEqG0FpCBS
 L5P3XvnB0ugkG+jaGWDjRelyd31z+XLcFmVSW6L+nKUbgtIanbDJE9l/gpxM4KvXq7Gc
 WaCQnO3InpubBbLGw1FVquUs9ecfFwRevzT5fPVq4jdjcEzrt/cBtswRQkQFbcjt9voN
 VhPfwNU4h5TU7Ba19kFDhzTqpaw8aeeo7pcjaUPr/+u3+BQp5jg5VbbaicYMLpxCvmW3
 ffUkNPdMpv0IEiUBiHIZB/UncA3fiUzW28s8e7YQmb4Zk3WfvR8HWzkIf1YowoOrRK/u
 UGrA==
X-Gm-Message-State: AOJu0YwaXLXxI0XBOCS4MIBVbcg9TycEoJ2/OPTmhkKWeajd900Rnmo/
 EnG2cr03xDuMz3hdIlTAXQCA2cDrko8JtCtkzmNbxPbnyux2fBXqWFf4xXnnQqaFoTRfudnZs5L
 xAeRkfSWAweXLmpXwMqFHAqcPTYcbFjwjVCbv2eJxiQ==
X-Gm-Gg: ASbGncuYKQi0o9KyeAZM7GEcL/0gF1Ut0yLWMEfMrE++F9oG69KK7mUWR8DJwZcHKLE
 Hy/RRSY7d+gLbHzpK7z/JFd9Sf8rQONt4nG4MPwwMi1UrWzXluYkZtensj6ns2qvPegYf5OJRU5
 /lHnH7SgegPumNvCt4nnDN8ee+dM27jbx0h/Rp69lMd/PGVTNSsIZFQ1cmIvXRaPgs9ud2Fj0N8
 XIzHRMno6zzFB9K2k7nIPazEz0Gff6rXnjgTk7xrsrU6OWwoHdql5gn1mhcRA==
X-Google-Smtp-Source: AGHT+IFzdVFg8UyP1BX34wkn4nnoaq4RDZClaEwEkVfj7MPhptwMYLmC5HIv32Z7ZSux8tWWAXgfjAAn5t4ZN02g5LY=
X-Received: by 2002:a05:690e:2513:10b0:63e:b41:cebc with SMTP id
 956f58d0204a3-640c41ccb6emr1874974d50.17.1762510018348; Fri, 07 Nov 2025
 02:06:58 -0800 (PST)
MIME-Version: 1.0
References: <20251103175851.428816-1-peter.maydell@linaro.org>
 <20251103175851.428816-3-peter.maydell@linaro.org>
 <CACGkMEsU=kz+SXo=L3JUzuNTqVK_pyGh8xhU6aiAKjnwSR8YfQ@mail.gmail.com>
In-Reply-To: <CACGkMEsU=kz+SXo=L3JUzuNTqVK_pyGh8xhU6aiAKjnwSR8YfQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Nov 2025 10:06:46 +0000
X-Gm-Features: AWmQ_bk3aoysczcheWyBv7FgcBaSpGYjGGwLZUQskT9ykG0omEXQaUhg2XMeDKI
Message-ID: <CAFEAcA8EyX4rPvJSUH-ZfxCLvXd68Xg5wPVedk6UzTHgSK5p6w@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/net/e1000e_core: Correct rx oversize packet checks
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 7 Nov 2025 at 03:50, Jason Wang <jasowang@redhat.com> wrote:
>
> On Tue, Nov 4, 2025 at 1:59=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> >      do {
> > +        /*
> > +         * Loop processing descriptors while we have packet data to
> > +         * DMA to the guest.  desc_offset tracks how much data we have
> > +         * sent to the guest in total over all descriptors, and goes
> > +         * from 0 up to total_size (the size of everything to send to
> > +         * the guest including possible trailing 4 bytes of CRC data).
> > +         */
> >          hwaddr ba[MAX_PS_BUFFERS];
> >          E1000EBAState bastate =3D { { 0 } };
> >          bool is_last =3D false;
> > @@ -1512,23 +1519,27 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
> >          e1000e_read_rx_descr(core, &desc, ba);
> >
> >          if (ba[0]) {
> > -            size_t desc_size =3D total_size - desc_offset;
> > -
> > -            if (desc_size > core->rx_desc_buf_size) {
> > -                desc_size =3D core->rx_desc_buf_size;
> > -            }
> > +            /* Total amount of data DMA'd to the guest in this iterati=
on */
> > +            size_t desc_size =3D 0;
> > +            /*
> > +             * Total space available in this descriptor (we will updat=
e
> > +             * this as we use it up)
> > +             */
> > +            size_t rx_desc_buf_size =3D core->rx_desc_buf_size;
> >
> >              if (desc_offset < size) {
> > -                static const uint32_t fcs_pad;
> >                  size_t iov_copy;
> > +                /* Amount of data to copy from the incoming packet */
> >                  size_t copy_size =3D size - desc_offset;
> > -                if (copy_size > core->rx_desc_buf_size) {
> > -                    copy_size =3D core->rx_desc_buf_size;
> > -                }
> >
> >                  /* For PS mode copy the packet header first */
> >                  if (do_ps) {
> >                      if (is_first) {
> > +                        /*
> > +                         * e1000e_do_ps() guarantees that buffer 0 has=
 enough
> > +                         * space for the header; otherwise we will not=
 split
> > +                         * the packet (i.e. do_ps is false).
> > +                         */
> >                          size_t ps_hdr_copied =3D 0;
> >                          do {
> >                              iov_copy =3D MIN(ps_hdr_len - ps_hdr_copie=
d,
> > @@ -1550,14 +1561,26 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
> >                          } while (ps_hdr_copied < ps_hdr_len);
> >
> >                          is_first =3D false;
> > +                        desc_size +=3D ps_hdr_len;
> >                      } else {
> >                          /* Leave buffer 0 of each descriptor except fi=
rst */
> >                          /* empty as per spec 7.1.5.1                  =
    */
> >                          e1000e_write_hdr_frag_to_rx_buffers(core, ba, =
&bastate,
> >                                                              NULL, 0);
> >                      }
> > +                    rx_desc_buf_size -=3D core->rxbuf_sizes[0];
> >                  }
> >
> > +                /*
> > +                 * Clamp the amount of packet data we copy into what w=
ill fit
> > +                 * into the remaining buffers in the descriptor.
> > +                 */
> > +                if (copy_size > rx_desc_buf_size) {
> > +                    copy_size =3D rx_desc_buf_size;
> > +                }
> > +                desc_size +=3D copy_size;
> > +                rx_desc_buf_size -=3D copy_size;
> > +
> >                  /* Copy packet payload */
> >                  while (copy_size) {
> >                      iov_copy =3D MIN(copy_size, iov->iov_len - iov_ofs=
);
> > @@ -1574,12 +1597,22 @@ e1000e_write_packet_to_guest(E1000ECore *core, =
struct NetRxPkt *pkt,
> >                          iov_ofs =3D 0;
> >                      }
> >                  }
> > +            }
> >
> > -                if (desc_offset + desc_size >=3D total_size) {
> > -                    /* Simulate FCS checksum presence in the last desc=
riptor */
> > -                    e1000e_write_payload_frag_to_rx_buffers(core, ba, =
&bastate,
> > -                          (const char *) &fcs_pad, e1000x_fcs_len(core=
->mac));
> > -                }
> > +            if (rx_desc_buf_size &&
> > +                desc_offset >=3D size && desc_offset < total_size) {
> > +                /*
> > +                 * We are in the last 4 bytes corresponding to the FCS=
 checksum.
> > +                 * We only ever write zeroes here (unlike the hardware=
).
> > +                 */
> > +                static const uint32_t fcs_pad;
> > +                /* Amount of space for the trailing checksum */
> > +                size_t fcs_len =3D MIN(rx_desc_buf_size,
> > +                                     total_size - desc_offset);
> > +                e1000e_write_payload_frag_to_rx_buffers(core, ba, &bas=
tate,
> > +                                                        (const char *)=
&fcs_pad,
> > +                                                        fcs_len);
> > +                desc_size +=3D fcs_len;
> >              }
> >              desc_offset +=3D desc_size;
>
> This should be done before the if (rx_desc_bufs_size && ... ?

No. That if() block deals with adding (possibly part of) the 4
checksum bytes. Those are part of the total data we DMA to
the guest, and so the if() block adds fcs_len to desc_size,
and those extra bytes need to be added to desc_offset.

> >              if (desc_offset >=3D total_size) {

Otherwise conditions like this and the loop termination condition
would not fire, because desc_offset would not get up to total_size.

thanks
-- PMM

