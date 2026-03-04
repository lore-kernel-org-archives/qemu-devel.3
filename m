Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35233EDEC1D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:11:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgO2-0002Hd-CS; Wed, 04 Mar 2026 02:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgNx-00028n-M8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vxgNv-0001Ni-Ty
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772608266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEnTXRD+uqUitIvcHcs41eGxcDpYOi/zYR4RoDlAkCE=;
 b=RSQWKV46IUWetCAnYFhEn2JqFVOTy457aJTN1+eu8SKF2c3lLuLGQYL4SMrsmYVx3sDWQ7
 eZcpAEVF/q6JpN+9q1vU6C7ltdLx8a4VnqNzUXphGz5Wi/dbyxhGCYRd2LclXtklfJ4eIH
 QsgKKQKXTeSzZGPLBPLGXv+XmZUyw9o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-DfNpJhQCNMehmFFm_h_IzQ-1; Wed, 04 Mar 2026 02:11:05 -0500
X-MC-Unique: DfNpJhQCNMehmFFm_h_IzQ-1
X-Mimecast-MFC-AGG-ID: DfNpJhQCNMehmFFm_h_IzQ_1772608264
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c5269fcecdeso3502273a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:11:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772608264; cv=none;
 d=google.com; s=arc-20240605;
 b=AItlUmRVWfcLHPJ9SmrdROI3qWd1bHanFvgUDsymGs5/KD3hpfPvpAc6ERL94lut81
 N5uYe5bMZcfZPbAqHPw5IoXQqa0ksZJ9WZsbUeIC4yNVlR6ytVAIrKy0yVEIRsCatvzv
 IqRgwy5PCewMyhmcdCYQ3cDaYNcGfia54z5IhFZRnR9nFot5GpndalJ6petX+ZTDF1IU
 tvfxa2o8AfsWJr9UmiMYVRhn8Ps58y48LnlteSQCoZxqgOz9zsulIW1TJnxHlQ+luSc6
 jQxXL7kZBMx2q6JkleQllSSRj5wkL9gyO0vXX7Jw7S3Vc1rYo9auM/OyeHlFawckT+mC
 hDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FEnTXRD+uqUitIvcHcs41eGxcDpYOi/zYR4RoDlAkCE=;
 fh=LyWEs+lL45hwsi57wRrCWsHyfzy7Svw7PUUmpiLqeKE=;
 b=D6dprc/NSr3bMjuKHp7KenmoNritObUPewk5QbnCfzLCP0b5iyvEDQAwybMjcvNChu
 eJqCpOOHYFISZDY28C8xICIXBc+jup5Y6A5m9ZKuPijOxKoMcMmUQxFOY4HeLvq0kcu7
 q5dkgFPjs3hmUyLAo7l7k6k2X5kqATq/oKZ3+H51kF1lfhdtkDA2EHYHSmVhcNuGfLvp
 PQGymzCpCzFa0hZUtmY/5kIObXjh70id7OK0XM7RE0AiDAtSVUIKxTVnaupoIUzc9CDr
 W2YVVOUAQXYWCuR1AtdnHNpuer5qEATXWGQyVTH0yqLT9UsQtPvEfElOy5QD7kjbCft8
 WkgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772608264; x=1773213064; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEnTXRD+uqUitIvcHcs41eGxcDpYOi/zYR4RoDlAkCE=;
 b=L47aQyYkRce7v5QS7VSq+W4TRZQSW2u+5ctB3ukK/JQp+rpMOqI5dt0ZoQVQiFiSPY
 fDiYE5PLF7nLj+6JtuyduUMbbOru/sJ4HOQf4ISBGhKZVhiFSOo/LprG6/PrIjRre7et
 +pmUBrFJj2IjqtzlE1p0g1EwlKNuHhdGx0A1rcNMjS9Y1iACz1PJ2ctq32+O3i6Xc1MW
 qafW+2Qfq2c/1WCgYMHMvWIjI22eg9oJJU9bWX2K6gHHOf7imjjQllQ6k6qCZhrMxpS1
 Y+otV6CskkCcMQJetT13YPPhp3Lp38e7+9KN9MQ5arY9sz78tr3/91GphJH4xRsOfeWv
 gqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772608264; x=1773213064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FEnTXRD+uqUitIvcHcs41eGxcDpYOi/zYR4RoDlAkCE=;
 b=SrFaseGuT4pm+G2eB1SlaU55WG7twMN/PeP+vgCBNvj+Hdr+eFMsrVP6e/aguO1LdA
 p2rnNuTI3Rm6iGdxIwtX9DmhPnDWRa3jZVoROvOHYLuOGtCdFuvYs7/L8D4b3BwdIVEg
 f7xVo1Dbv52qhhcFvcXuj3KHVxGObl22YyO35+HR66ueTbNres3W6H6fKWF61FsgaKOx
 fx58rp0K8bEffpQ7NwvnBgX5Y6JMDA531a1xBd3JtX2rQKJ0UdGxsZcxevJ6E4ykanFN
 iZiuKrPlkEfMM4o8jOASyk3Q4rEskJXpLfmjqwGzM/Ou2DSMLY7ZkIlDqfOcgv/eo1db
 kXEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKYToDUYbkaZIQAinrTAlW9wbOUWcFAFNZkPU+OOkEpx9jv7MkgOxVZj/POgmNWKudblpnYqp5IUS/@nongnu.org
X-Gm-Message-State: AOJu0YyKk7PcEt/GmK9mUVZLjmdNAC1vOvojrLGmpzeRwtGQWn8LIorY
 VVpRlFIi1VZT0fQzvpoTElnELoR9WmjNqOdUz1MKNGMRBtNc9dT7erFG31kbJe8ewC37HVv26R5
 nKK/BJA3fleTuyha5IyJ5Vht+CBrF6r+r4b3nrB3glt04WcVmmcGtZEf9p/ihaAkwMS6GBshNFH
 tl7NDzVomeg/xubPR2p/LiPFJsjPFiWzA=
X-Gm-Gg: ATEYQzzw1wuvGDfGs/37sew7AWRMo/KYkOi2LyvcSKm/wIIRNaM1qf3m4qwyq2WcQv2
 OvScHY+SyBr81mJL4EnedTJOR8iTQwx4QcB+OQR/CsWHOHTzGPlnEkp+Lr4/i84c4qDgP9Y7G9i
 8EU9vLnjSEJgrxuN5iFcRm/jMI7YcI8WU3ktbj0U+kDgPELjlf2sFDfF+/AqrS6rG0lnXBOZXUU
 ByHAlo=
X-Received: by 2002:a05:6a21:696:b0:387:dfb3:cd0a with SMTP id
 adf61e73a8af0-3982e260e1cmr1089062637.63.1772608264360; 
 Tue, 03 Mar 2026 23:11:04 -0800 (PST)
X-Received: by 2002:a05:6a21:696:b0:387:dfb3:cd0a with SMTP id
 adf61e73a8af0-3982e260e1cmr1089041637.63.1772608263967; Tue, 03 Mar 2026
 23:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20260127173849.588F25969F0@zero.eik.bme.hu>
 <597883bc-c6a3-cd7f-42dc-1ee7fb8e213c@eik.bme.hu>
 <35356f16-3a1f-4ba3-8d10-bece637d9c4e@linaro.org>
In-Reply-To: <35356f16-3a1f-4ba3-8d10-bece637d9c4e@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 15:10:52 +0800
X-Gm-Features: AaiRm52_rDLETpRVzQBMp-EuoZdN7XPwqJUP6PPtWawjzCFYQph2c_WzMyeGrU8
Message-ID: <CACGkMEsRwnRAEGoff5m5QU_KfxDMXw1jhMj5Re+KNrm-5sRmXw@mail.gmail.com>
Subject: Re: [PATCH] rtl8139: Remove ineffective parameter
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 23, 2026 at 5:57=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 12/2/26 19:45, BALATON Zoltan wrote:
> > On Tue, 27 Jan 2026, BALATON Zoltan wrote:
> >> The do_interrupt parameter for rtl8139_do_receive was originally added
> >> in commit 6cadb320c7 to avoid generating interrupt when receiving in
> >> loopback mode. Later commit 5311fb805a changed this so that this
> >> parameter became ineffective and now this parameter is unused and
> >> always 1. If this turns out to be a problem maybe there's a better way
> >> to fix this so remove the do_interrupt parameter for now to simplify
> >> code.
> >
> > Ping?
>
> Jason usually only does 1 pull request per dev cycle, close to soft
> freeze.
>
> Jason, since this patch is trivial enough, I'll take it via my
> hw-misc tree for convenience. Please object if you disagree :)

Feel free to do that.

Thanks

>
> Regards,
>
> Phil.
>
> >
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >> hw/net/rtl8139.c | 24 ++++++++----------------
> >> 1 file changed, 8 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> >> index 9fd00574d2..2ad6338ebe 100644
> >> --- a/hw/net/rtl8139.c
> >> +++ b/hw/net/rtl8139.c
> >> @@ -815,7 +815,8 @@ static bool rtl8139_can_receive(NetClientState *nc=
)
> >>     return avail =3D=3D 0 || avail >=3D 1514 || (s->IntrMask & RxOverf=
low);
> >> }
> >>
> >> -static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t
> >> *buf, size_t size_, int do_interrupt)
> >> +static ssize_t rtl8139_receive(NetClientState *nc,
> >> +                               const uint8_t *buf, size_t size_)
> >> {
> >>     RTL8139State *s =3D qemu_get_nic_opaque(nc);
> >>     PCIDevice *d =3D PCI_DEVICE(s);
> >> @@ -1173,20 +1174,11 @@ static ssize_t
> >> rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
> >>     }
> >>
> >>     s->IntrStatus |=3D RxOK;
> >> -
> >> -    if (do_interrupt)
> >> -    {
> >> -        rtl8139_update_irq(s);
> >> -    }
> >> +    rtl8139_update_irq(s);
> >>
> >>     return size_;
> >> }
> >>
> >> -static ssize_t rtl8139_receive(NetClientState *nc, const uint8_t
> >> *buf, size_t size)
> >> -{
> >> -    return rtl8139_do_receive(nc, buf, size, 1);
> >> -}
> >> -
> >> static void rtl8139_reset_rxring(RTL8139State *s, uint32_t bufferSize)
> >> {
> >>     s->RxBufferSize =3D bufferSize;
> >> @@ -1745,7 +1737,7 @@ static uint32_t
> >> rtl8139_RxConfig_read(RTL8139State *s)
> >> }
> >>
> >> static void rtl8139_transfer_frame(RTL8139State *s, uint8_t *buf, int
> >> size,
> >> -    int do_interrupt, const uint8_t *dot1q_buf)
> >> +                                   const uint8_t *dot1q_buf)
> >> {
> >>     struct iovec *iov =3D NULL;
> >>     struct iovec vlan_iov[3];
> >> @@ -1828,7 +1820,7 @@ static int rtl8139_transmit_one(RTL8139State *s,
> >> int descriptor)
> >>     s->TxStatus[descriptor] |=3D TxHostOwns;
> >>     s->TxStatus[descriptor] |=3D TxStatOK;
> >>
> >> -    rtl8139_transfer_frame(s, txbuffer, txsize, 0, NULL);
> >> +    rtl8139_transfer_frame(s, txbuffer, txsize, NULL);
> >>
> >>     DPRINTF("+++ transmitted %d bytes from descriptor %d\n", txsize,
> >>         descriptor);
> >> @@ -2246,7 +2238,7 @@ static int
> >> rtl8139_cplus_transmit_one(RTL8139State *s)
> >>                     DPRINTF("+++ C+ mode TSO transferring packet size =
"
> >>                         "%d\n", tso_send_size);
> >>                     rtl8139_transfer_frame(s, saved_buffer,
> >> tso_send_size,
> >> -                        0, (uint8_t *) dot1q_buffer);
> >> +                                           (uint8_t *)dot1q_buffer);
> >>
> >>                     /* add transferred count to TCP sequence number */
> >>                     stl_be_p(&p_tcp_hdr->th_seq,
> >> @@ -2323,8 +2315,8 @@ skip_offload:
> >>
> >>         DPRINTF("+++ C+ mode transmitting %d bytes packet\n",
> >> saved_size);
> >>
> >> -        rtl8139_transfer_frame(s, saved_buffer, saved_size, 1,
> >> -            (uint8_t *) dot1q_buffer);
> >> +        rtl8139_transfer_frame(s, saved_buffer, saved_size,
> >> +                               (uint8_t *)dot1q_buffer);
> >>
> >>         /* restore card space if there was no recursion and reset
> >> offset */
> >>         if (!s->cplus_txbuffer)
> >>
>


