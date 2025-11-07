Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F2ACCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 03:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHDUo-0003HX-Ge; Thu, 06 Nov 2025 22:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHDUm-0003HK-0r
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 22:50:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHDUi-0003e7-JL
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 22:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762487434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnIDZ9hTPWCYpi2Y3YS28W9RflVVixwpFAXlsLFX2jY=;
 b=V/8WeMeV9yK3Vnq0ySVgvFgnRGQ6e3prHWKhkd7agHR8RCawi4SeynwiHgR0CthRcearOg
 0NiJLMsNb09+knGSolLc6ypUMvI0ykbUFceZi+aEtd3Ar5WwZpCpB6zSpzGR43hCHzo5pl
 M1319jfQy4oDmeNLQfLmy/9/wYPp6p8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-cxdGfkVKMie4het4VDfofA-1; Thu, 06 Nov 2025 22:50:33 -0500
X-MC-Unique: cxdGfkVKMie4het4VDfofA-1
X-Mimecast-MFC-AGG-ID: cxdGfkVKMie4het4VDfofA_1762487432
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34029b3dbfeso470718a91.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 19:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762487432; x=1763092232; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnIDZ9hTPWCYpi2Y3YS28W9RflVVixwpFAXlsLFX2jY=;
 b=RCeld87N10E510hGQxSurUprKDG4nGcI/veV9Qsw3oLNIiaAYh8OrHC2GLXg4qDa91
 9STbVQqloWDwpEQKwwYsZKbBsYZtB+W6T7iIzrIHWj2QkdEfiYO8//oASkszTBbzVTXb
 2uJqPvTjxx0/m3VkNQcL2IxPi3FeHhckVQSlJaXkynKqOmRRyJN1+hv3gF35nj8tW0de
 zUlfn7/nU/2YzjknHKU4+pfEjVMM9U60MmdIzwoAdQHTun2p1ywAcQ1G4MNTf64DGg8G
 1yEr0Apdk4eC5ogXPemHDT9azTg4a8WtkztDm/nZLSkvMdYIGcz+F9r3JEQU2isDmDUy
 FxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762487432; x=1763092232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VnIDZ9hTPWCYpi2Y3YS28W9RflVVixwpFAXlsLFX2jY=;
 b=QrWWzuvHHi5GgKI3O85Q1cZa1Z50J2vJ12Q74vireqvzUGs4QyNEA4buAoyB5NQjR6
 RT3rnpl2+QgYd4mLuupdV3+DuNdlIIsR2t6i/jn1uQrNm2uuIOKriidAmum8ICnBvh5Y
 LsNrKrV05xWRxEUXSDxuGglUqQqjujSpuLDVscbjJAjmnaOwLxbu1dJaoIgfLuIR8xaK
 9IebD6zTNv21KFstNaeWBDEGk9SeMjKPCc381M9XOklXFcwJ5DS08IyamhnQ5v4dNhew
 03j0VmVYlj+AvHv0JveljeFugk6q3NHEdZla4dU4l7Xrs2cuBSPADoxvBHcl7oMnWZ3N
 yxNA==
X-Gm-Message-State: AOJu0YyPu+HFe7+AObp3i5MtuH5YZ6D94JEk4jgF091BWm1iYYCIInG5
 M9BPYbfs5RBoxW9R3MmAFGE/xvUS4j1I5WI32y3xK7djgnisIde8Qf4Xa+bb8j4x1by4ZQ+uPKF
 srcojweURKsD9GstWkOKq26CwAT1u/02ol2hajZ9W3HdnQQFIoCdi70o+4rRDc7UKaBTTjp4nJl
 xma3A9kLf3Ap0xgTiHsRS7RYKYxtLX2uc=
X-Gm-Gg: ASbGncuFSaV5XwMI28z4h+IbBGvD4qukBKBOsmf4rXJBggOH61jiuvJkXg1YX+io0Fb
 2ipm4wYoVa9Dms3EsQJYS8ym/3mlVNt0iiiEO2MJNTqID9eeZvfCsOXliwF3xa3jacsz6c+O6ti
 ry8DRw9vy2VSB/tGtrVEjy6g0mSqFYGMpC1ri5o7/XdW5dGxs9CI3Jv6+U
X-Received: by 2002:a17:90b:4d83:b0:335:228c:6f1f with SMTP id
 98e67ed59e1d1-3434c4f971amr2006165a91.12.1762487432138; 
 Thu, 06 Nov 2025 19:50:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmcnthRcCodrxLDrEA4vkfodYMm/exNOmRFM9GbC3eyniuTnJU4m5l8h26DYZ4TH/ogMwBVhpZJQzA44hbibc=
X-Received: by 2002:a17:90b:4d83:b0:335:228c:6f1f with SMTP id
 98e67ed59e1d1-3434c4f971amr2006136a91.12.1762487431682; Thu, 06 Nov 2025
 19:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20251103175851.428816-1-peter.maydell@linaro.org>
 <20251103175851.428816-3-peter.maydell@linaro.org>
In-Reply-To: <20251103175851.428816-3-peter.maydell@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Nov 2025 11:50:20 +0800
X-Gm-Features: AWmQ_bl1fwhP3m4ZjhkDN9x07k0lEFhzPZRIDlGWhfEWW35jmqzVuTCBbp9WriE
Message-ID: <CACGkMEsU=kz+SXo=L3JUzuNTqVK_pyGh8xhU6aiAKjnwSR8YfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/net/e1000e_core: Correct rx oversize packet checks
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 4, 2025 at 1:59=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> In e1000e_write_packet_to_guest() we attempt to ensure that we don't
> write more of a packet to a descriptor than will fit in the guest
> configured receive buffers.  However, this code does not allow for
> the "packet split" feature.  When packet splitting is enabled, the
> first of up to 4 buffers in the descriptor is used for the packet
> header only, with the payload going into buffers 2, 3 and 4.  Our
> length check only checks against the total sizes of all 4 buffers,
> which meant that if an incoming packet was large enough to fit in (1
> + 2 + 3 + 4) but not into (2 + 3 + 4) and packet splitting was
> enabled, we would run into the assertion in
> e1000e_write_hdr_frag_to_rx_buffers() that we had enough buffers for
> the data:
>
> qemu-system-i386: ../../hw/net/e1000e_core.c:1418: void e1000e_write_payl=
oad_frag_to_rx_buffers(E1000ECore *, hwaddr *, E1000EBAState *, const char =
*, dma_addr_t): Assertion `bastate->cur_idx < MAX_PS_BUFFERS' failed.
>
> A malicious guest could provoke this assertion by configuring the
> device into loopback mode, and then sending itself a suitably sized
> packet into a suitably arrange rx descriptor.
>
> The code also fails to deal with the possibility that the descriptor
> buffers are sized such that the trailing checksum word does not fit
> into the last descriptor which has actual data, which might also
> trigger this assertion.
>
> Rework the length handling to use two variables:
>  * desc_size is the total amount of data DMA'd to the guest
>    for the descriptor being processed in this iteration of the loop
>  * rx_desc_buf_size is the total amount of space left in it
>
> As we copy data to the guest (packet header, payload, checksum),
> update these two variables.  (Previously we attempted to calculate
> desc_size once at the top of the loop, but this is too difficult to
> do correctly.) Then we can use the variables to ensure that we clamp
> the amount of copied payload data to the remaining space in the
> descriptor's buffers, even if we've used one of the buffers up in the
> packet-split code, and we can tell whether we have enough space for
> the full checksum word in this descriptor or whether we're going to
> need to split that to the following descriptor.
>
> I have included comments that hopefully help to make the loop
> logic a little clearer.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/537
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/e1000e_core.c | 61 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 14 deletions(-)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index ba77cb6011f..471c3ed20b8 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -1495,6 +1495,13 @@ e1000e_write_packet_to_guest(E1000ECore *core, str=
uct NetRxPkt *pkt,
>      rxi =3D rxr->i;
>
>      do {
> +        /*
> +         * Loop processing descriptors while we have packet data to
> +         * DMA to the guest.  desc_offset tracks how much data we have
> +         * sent to the guest in total over all descriptors, and goes
> +         * from 0 up to total_size (the size of everything to send to
> +         * the guest including possible trailing 4 bytes of CRC data).
> +         */
>          hwaddr ba[MAX_PS_BUFFERS];
>          E1000EBAState bastate =3D { { 0 } };
>          bool is_last =3D false;
> @@ -1512,23 +1519,27 @@ e1000e_write_packet_to_guest(E1000ECore *core, st=
ruct NetRxPkt *pkt,
>          e1000e_read_rx_descr(core, &desc, ba);
>
>          if (ba[0]) {
> -            size_t desc_size =3D total_size - desc_offset;
> -
> -            if (desc_size > core->rx_desc_buf_size) {
> -                desc_size =3D core->rx_desc_buf_size;
> -            }
> +            /* Total amount of data DMA'd to the guest in this iteration=
 */
> +            size_t desc_size =3D 0;
> +            /*
> +             * Total space available in this descriptor (we will update
> +             * this as we use it up)
> +             */
> +            size_t rx_desc_buf_size =3D core->rx_desc_buf_size;
>
>              if (desc_offset < size) {
> -                static const uint32_t fcs_pad;
>                  size_t iov_copy;
> +                /* Amount of data to copy from the incoming packet */
>                  size_t copy_size =3D size - desc_offset;
> -                if (copy_size > core->rx_desc_buf_size) {
> -                    copy_size =3D core->rx_desc_buf_size;
> -                }
>
>                  /* For PS mode copy the packet header first */
>                  if (do_ps) {
>                      if (is_first) {
> +                        /*
> +                         * e1000e_do_ps() guarantees that buffer 0 has e=
nough
> +                         * space for the header; otherwise we will not s=
plit
> +                         * the packet (i.e. do_ps is false).
> +                         */
>                          size_t ps_hdr_copied =3D 0;
>                          do {
>                              iov_copy =3D MIN(ps_hdr_len - ps_hdr_copied,
> @@ -1550,14 +1561,26 @@ e1000e_write_packet_to_guest(E1000ECore *core, st=
ruct NetRxPkt *pkt,
>                          } while (ps_hdr_copied < ps_hdr_len);
>
>                          is_first =3D false;
> +                        desc_size +=3D ps_hdr_len;
>                      } else {
>                          /* Leave buffer 0 of each descriptor except firs=
t */
>                          /* empty as per spec 7.1.5.1                    =
  */
>                          e1000e_write_hdr_frag_to_rx_buffers(core, ba, &b=
astate,
>                                                              NULL, 0);
>                      }
> +                    rx_desc_buf_size -=3D core->rxbuf_sizes[0];
>                  }
>
> +                /*
> +                 * Clamp the amount of packet data we copy into what wil=
l fit
> +                 * into the remaining buffers in the descriptor.
> +                 */
> +                if (copy_size > rx_desc_buf_size) {
> +                    copy_size =3D rx_desc_buf_size;
> +                }
> +                desc_size +=3D copy_size;
> +                rx_desc_buf_size -=3D copy_size;
> +
>                  /* Copy packet payload */
>                  while (copy_size) {
>                      iov_copy =3D MIN(copy_size, iov->iov_len - iov_ofs);
> @@ -1574,12 +1597,22 @@ e1000e_write_packet_to_guest(E1000ECore *core, st=
ruct NetRxPkt *pkt,
>                          iov_ofs =3D 0;
>                      }
>                  }
> +            }
>
> -                if (desc_offset + desc_size >=3D total_size) {
> -                    /* Simulate FCS checksum presence in the last descri=
ptor */
> -                    e1000e_write_payload_frag_to_rx_buffers(core, ba, &b=
astate,
> -                          (const char *) &fcs_pad, e1000x_fcs_len(core->=
mac));
> -                }
> +            if (rx_desc_buf_size &&
> +                desc_offset >=3D size && desc_offset < total_size) {
> +                /*
> +                 * We are in the last 4 bytes corresponding to the FCS c=
hecksum.
> +                 * We only ever write zeroes here (unlike the hardware).
> +                 */
> +                static const uint32_t fcs_pad;
> +                /* Amount of space for the trailing checksum */
> +                size_t fcs_len =3D MIN(rx_desc_buf_size,
> +                                     total_size - desc_offset);
> +                e1000e_write_payload_frag_to_rx_buffers(core, ba, &basta=
te,
> +                                                        (const char *)&f=
cs_pad,
> +                                                        fcs_len);
> +                desc_size +=3D fcs_len;
>              }
>              desc_offset +=3D desc_size;

This should be done before the if (rx_desc_bufs_size && ... ?

>              if (desc_offset >=3D total_size) {
> --
> 2.43.0
>

Thanks


