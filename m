Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196D7C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWm0-0007Ix-HF; Tue, 30 Jun 2026 07:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1weWlw-0007IQ-9c
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:37:00 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <y.sanjeevreddy@gmail.com>)
 id 1weWlt-0002v1-Gz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:36:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c125ba77577so227262466b.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 04:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782819415; cv=none;
 d=google.com; s=arc-20260327;
 b=Nt03qXIUWIHIzVQIjwuaiLiFpjsWy8+nRlmWLGqnqRy8LClBbsNiRLaFUNzIoNQLGM
 ytK1bWTfjwG6xfIHKrpVcXkph/e1Y2BXWNVk6VDA6Hnx/Z2X7jWYHYMz/Zv11OgoiSUs
 vOj1BbU26OSsCBBrdIdxFmVtvA7YMwaNTD5hX0uECmkqEWpizJ+7zQBC8O10VokWkfiB
 n6xjrIYb99sJGpnIqDeDosift8KTpFlqq85u86lbvmIp/ok1UlQoAxdRPjRWfTrt9Y1R
 lEZ1HnHSHiDO+syyKhlN4Mp/RRaJoaBT3OuortfJWcikhZseyaPlBt8UKt+aR7MBq4wF
 vjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mtTyQd4rcpZyq+xYZLyPRt6+57bsvuYFwzUD6FR9ns0=;
 fh=voDG+cf20gigmag5yIPfD/jq3oJmtQn4/B9NIfkR9dI=;
 b=EFD1xlJWt/oRNMsd8fGdnWewSHwJxaNxaUNjAw3ab3t5pC43eLl19eWY2evlJHnBcB
 j5rkADjSDXscRl6y/AA1rx9Aq1f/jKQP9J+mjdAo3kiR+x1CGlopHSIUlOcYSok8po1y
 oOHLQKbNZ6ZeQuyqWpMgc5uHm9o0Iln2wNZk9TbPHMupTGbY7LpS/1wAcKQnVJCQcOlW
 nm3HSe9IaqLjkaOODAg3r9cMI/EnapfhZ63yMlcwu7KdyX37sGWQOZ2hx3xW4Ql0+RjA
 2a4a70X3xs+GVQ785el2vUXNbxTOrfDqb5+sIIHthsZtq+G+pyLbtKYUCo/IwCLh4tRg
 9YqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782819415; x=1783424215; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mtTyQd4rcpZyq+xYZLyPRt6+57bsvuYFwzUD6FR9ns0=;
 b=X8nQ1mMi+HvZCgZX8T4FyLbDf6e2ONawtSGJUY/V3LmviusDE96CrP8qCeRklwZxGX
 j9/OPHBCcCMIly23gHon2M6ffP0w399tRp9/uTiRtMJn4PmqaFiSI4x21BqvLV8CCFGC
 HDoWzaZXGUVdpr8INj90FarotiM0s1evApfI32LosJUpVlJouT+eUv1w97xqZQuBtZPO
 2kTxDHnPT391n2RZT2OVYnfgFlM0Baj/G9HYM/0w5JR5t0zyFLciNaDWpu6YKd/de/tH
 zuoKzp4gFAFcV9XFQB8RKjAI797/1C16Td4UoyrmNrCO5YBD/b4pncUFfw2mpSAmMNzP
 BxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782819415; x=1783424215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtTyQd4rcpZyq+xYZLyPRt6+57bsvuYFwzUD6FR9ns0=;
 b=On9xq2sTQS/9V+1/jl2/sDoTiAnx9/j6Em0uvJOdkKvwFJoMbko29hxqP2suKF0ZV9
 lerfCjMXBeBwgdHLdHhl+Wzl8XaX2Ls8/z4Fg72/dretn2pTUlej4O6qFEWAkFfRkc+r
 oXQoXUcFdYGxBCniP+YLVO+2wbpAOgTS+1U2bAY6LhFhHPDKGr02XR2+GwuXtomkCVUe
 tHwdr8DmL+gXCs9wS8rm/jbp0BTTzC54yIdKkTq1jCRdjyYT+Jxjb2+arUligFhpnMPE
 +AIQT0OdAsh+RN3O3hxzD6bkMuRLyd0qV03jBB7jnsNswdtzkqBGmBS1KKzeBBVoNvt2
 +SSw==
X-Gm-Message-State: AOJu0Yx1m4Zp+8NtCsQzxmltpjMaZQ+Etje3cRpSknTVbnJQaAyYwmgG
 We+NgoQXQzoJridq8n6+F1JgFeBB65Jv7viDapvJNQKbgTaQOLostn6Ka8IMu/n9qwN+lCaqzN1
 A6e15gYmWFHEymR2gzPAbJnA3M2iSU4U=
X-Gm-Gg: AfdE7ckXeO5Fb5eMPrY6YYKLSoYQTw3YLhK1rzDB6Cbp8qoJ+GRydDNVnSY3lEeGhT2
 Cb0y4s41hdpG/HvGA457bt2hX7eXsmVeW4fDefeWUR5xYOY3EjBLXatPjyYOmHgV9fLg07aLlwF
 aPeemjeEx57bFTXPsURSK+byf9veb43HAbZHiWngHbFH3yN7EyPYUBjoiWCzO5ep4zgZsnQNrwx
 Kc5nt8YqgyMawmBJR6AiTtssQBEXaVU91ZRsndGpChSBwOcd8QVPCduy9o56KfaILTJB2xdZJxA
 Amwdsg0=
X-Received: by 2002:a17:907:1c0d:b0:bee:f541:1dca with SMTP id
 a640c23a62f3a-c128730483emr146484166b.28.1782819414673; Tue, 30 Jun 2026
 04:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260629-net-tx-pkt-ip-length-padding-v5-1-16760e30252e@gmail.com>
 <3b65505c-818f-42d8-8e62-2e1195f155b0@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3b65505c-818f-42d8-8e62-2e1195f155b0@rsg.ci.i.u-tokyo.ac.jp>
From: Sanjeev Reddy <y.sanjeevreddy@gmail.com>
Date: Tue, 30 Jun 2026 05:36:43 -0600
X-Gm-Features: AVVi8CdoGJg5CQj_9dHEEq8cgkbPaQNlyAknCzEoS0MTz41Koj9V3hrHaZ9RzcQ
Message-ID: <CAFULJv6_iH3Cjhk+sfy=4ufdNwO_p4YFGA+=f_O-m7QFF_ynOQ@mail.gmail.com>
Subject: Re: [PATCH v5] hw/net: fix e1000e/igb ip_len inflation by Ethernet
 minimum-frame padding
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e91077065576fd0d"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=y.sanjeevreddy@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000e91077065576fd0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Akihiko!

On Tue, Jun 30, 2026 at 1:41=E2=80=AFAM Akihiko Odaki <odaki@rsg.ci.i.u-tok=
yo.ac.jp>
wrote:

> On 2026/06/30 0:21, Sanjeeva Yerrapureddy wrote:
> > When a guest transmits a short Ethernet frame, iov_size() returns the
> > padded wire length including any bytes added to reach the Ethernet
> > minimum frame size of 60 bytes.  net_tx_pkt_rebuild_payload() uses
> > this inflated size as payload_len.  net_tx_pkt_update_ip_hdr_checksum()
> > then overwrites the IPv4 Total Length field with payload_len +
> > l3_hdr_len, inflating it by the padding.  The receiver interprets
> > Ethernet padding as IP payload, producing a malformed packet.
> >
> > Fix by removing the ip_len write from net_tx_pkt_update_ip_hdr_checksum=
()
> > so it only recomputes the checksum, and moving the ip_len assignment
> > into net_tx_pkt_update_ip_checksums() where it is only performed for
> > TSO (where ip_len must be derived from payload_len since the guest sets
> > ip_len=3D0 per Intel 82574 datasheet =C2=A77.3.4 for super-packets the =
host
> > will segment).
> >
> > Both e1000e and igb already call net_tx_pkt_update_ip_hdr_checksum()
> > from their IXSM paths, so both are corrected by this single common-
> > layer change.
> >
> > Signed-off-by: Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
>
> Reivewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> Thank you for promptly responding to reviews and identifying the cause
> of the issue.
>
> Regards,
> Akihiko Odaki
>
> > ---
> > Thank you Akihiko for the review of v4. I agree that avoiding two
> > similar functions is cleaner. v5 moves the ip_len write into
> > net_tx_pkt_update_ip_checksums() (the TSO path that already owns it)
> > and strips it from net_tx_pkt_update_ip_hdr_checksum(), which becomes a
> > pure checksum recomputation. The net effect is that both e1000e and igb
> > IXSM paths are corrected automatically without any device-layer change.
> >
> > Changes in v5:
> > - Remove the ip_len write from net_tx_pkt_update_ip_hdr_checksum() so
> >    it only recomputes the checksum.
> > - Move the ip_len assignment into net_tx_pkt_update_ip_checksums() (the
> >    TSO path), which already called net_tx_pkt_update_ip_hdr_checksum()
> >    immediately after. The comment and the ip_len line are restored to
> >    their upstream positions.
> > - Remove net_tx_pkt_update_ip_hdr_checksum_only() entirely =E2=80=94 no=
 longer
> >    needed.
> > - Revert the e1000e IXSM path to its original call of
> >    net_tx_pkt_update_ip_hdr_checksum(). Because that function no longer
> >    inflates ip_len, igb (which already calls the same function) is also
> >    corrected with no additional change.
> > - Link to v4:
> https://lore.kernel.org/qemu-devel/20260628-net-tx-pkt-ip-length-padding-=
v4-1-829b36db5adb@gmail.com
> >
> > Changes in v4:
> > - Add net_tx_pkt_update_ip_hdr_checksum_only(); call it from the e1000e
> >    IXSM path to avoid inflating ip_len.
> > - Link to v3:
> https://lore.kernel.org/qemu-devel/20260627-net-tx-pkt-ip-length-padding-=
v3-1-e860dabadd3f@gmail.com
> >
> > Changes in v3:
> > - Architectural redesign: three-case fallback logic in
> >    net_tx_pkt_rebuild_payload() plus net_tx_pkt_set_payload_len() API;
> >    e1000e pre-sets payload_len from PAYLEN descriptor field.
> > - Link to v2:
> https://lore.kernel.org/qemu-devel/20260625-net-tx-pkt-ip-length-padding-=
v2-1-287d0ba59ec1@gmail.com
> >
> > Changes in v2:
> > - Fix iov_copy() to use raw_payload_len and net_tx_pkt_get_total_len()
> >    to use iov_size() to preserve correct wire frame size.
> > - Link to v1:
> https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-ip-length-padding-=
v1-1-7a22fe9b4e40@gmail.com
> >
> > On the relationship to the short-packet receive-path discussion
> > (Peter Maydell):
> >
> https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=3D4ZR1+PA0=3D4-29=
=3DfEe+d+iUmhLTzpuQ@mail.gmail.com/
> >
> > The linked thread concerns the receive path. This patch addresses only
> > the transmit path: the IXSM offload path was overwriting a correctly
> > set guest ip_len with an inflated value that included Ethernet padding.
> > No changes to padding behaviour or the receive path are made.
> >
> > To: qemu-devel@nongnu.org
> > Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Jason Wang <jasowang@redhat.com>
> > ---
> >   hw/net/net_tx_pkt.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
> > index 903238dca2..b134348fe8 100644
> > --- a/hw/net/net_tx_pkt.c
> > +++ b/hw/net/net_tx_pkt.c
> > @@ -93,9 +93,6 @@ void net_tx_pkt_update_ip_hdr_checksum(struct NetTxPk=
t
> *pkt)
> >       uint16_t csum;
> >       assert(pkt);
> >
> > -    pkt->l3_hdr.ip.ip_len =3D cpu_to_be16(pkt->payload_len +
> > -        pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
> > -
> >       pkt->l3_hdr.ip.ip_sum =3D 0;
> >       csum =3D net_raw_checksum(pkt->l3_hdr.octets,
> >           pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
> > @@ -117,7 +114,9 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPkt
> *pkt)
> >
> >       if (gso_type =3D=3D VIRTIO_NET_HDR_GSO_TCPV4 ||
> >           gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP) {
> > -        /* Calculate IP header checksum */
> > +        /* Set ip_len and calculate IP header checksum */
> > +        pkt->l3_hdr.ip.ip_len =3D cpu_to_be16(pkt->payload_len +
> > +            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_len);
> >           net_tx_pkt_update_ip_hdr_checksum(pkt);
> >
> >           /* Calculate IP pseudo header checksum */
> >
> > ---
> > base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
> > change-id: 20260628-net-tx-pkt-ip-length-padding-951e75fa97b4
> >
> > Best regards,
> > --
> > Sanjeeva Yerrapureddy <y.sanjeevreddy@gmail.com>
> >
>
>

--=20
regards,
Sanjeeva Reddy.Y.

--000000000000e91077065576fd0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Akihiko!</div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 30, 20=
26 at 1:41=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-=
tokyo.ac.jp">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 2026/06/30 0:21, Sanjeeva Yerra=
pureddy wrote:<br>
&gt; When a guest transmits a short Ethernet frame, iov_size() returns the<=
br>
&gt; padded wire length including any bytes added to reach the Ethernet<br>
&gt; minimum frame size of 60 bytes.=C2=A0 net_tx_pkt_rebuild_payload() use=
s<br>
&gt; this inflated size as payload_len.=C2=A0 net_tx_pkt_update_ip_hdr_chec=
ksum()<br>
&gt; then overwrites the IPv4 Total Length field with payload_len +<br>
&gt; l3_hdr_len, inflating it by the padding.=C2=A0 The receiver interprets=
<br>
&gt; Ethernet padding as IP payload, producing a malformed packet.<br>
&gt; <br>
&gt; Fix by removing the ip_len write from net_tx_pkt_update_ip_hdr_checksu=
m()<br>
&gt; so it only recomputes the checksum, and moving the ip_len assignment<b=
r>
&gt; into net_tx_pkt_update_ip_checksums() where it is only performed for<b=
r>
&gt; TSO (where ip_len must be derived from payload_len since the guest set=
s<br>
&gt; ip_len=3D0 per Intel 82574 datasheet =C2=A77.3.4 for super-packets the=
 host<br>
&gt; will segment).<br>
&gt; <br>
&gt; Both e1000e and igb already call net_tx_pkt_update_ip_hdr_checksum()<b=
r>
&gt; from their IXSM paths, so both are corrected by this single common-<br=
>
&gt; layer change.<br>
&gt; <br>
&gt; Signed-off-by: Sanjeeva Yerrapureddy &lt;<a href=3D"mailto:y.sanjeevre=
ddy@gmail.com" target=3D"_blank">y.sanjeevreddy@gmail.com</a>&gt;<br>
<br>
Reivewed-by: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.=
jp" target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
<br>
Thank you for promptly responding to reviews and identifying the cause <br>
of the issue.<br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
&gt; ---<br>
&gt; Thank you Akihiko for the review of v4. I agree that avoiding two<br>
&gt; similar functions is cleaner. v5 moves the ip_len write into<br>
&gt; net_tx_pkt_update_ip_checksums() (the TSO path that already owns it)<b=
r>
&gt; and strips it from net_tx_pkt_update_ip_hdr_checksum(), which becomes =
a<br>
&gt; pure checksum recomputation. The net effect is that both e1000e and ig=
b<br>
&gt; IXSM paths are corrected automatically without any device-layer change=
.<br>
&gt; <br>
&gt; Changes in v5:<br>
&gt; - Remove the ip_len write from net_tx_pkt_update_ip_hdr_checksum() so<=
br>
&gt;=C2=A0 =C2=A0 it only recomputes the checksum.<br>
&gt; - Move the ip_len assignment into net_tx_pkt_update_ip_checksums() (th=
e<br>
&gt;=C2=A0 =C2=A0 TSO path), which already called net_tx_pkt_update_ip_hdr_=
checksum()<br>
&gt;=C2=A0 =C2=A0 immediately after. The comment and the ip_len line are re=
stored to<br>
&gt;=C2=A0 =C2=A0 their upstream positions.<br>
&gt; - Remove net_tx_pkt_update_ip_hdr_checksum_only() entirely =E2=80=94 n=
o longer<br>
&gt;=C2=A0 =C2=A0 needed.<br>
&gt; - Revert the e1000e IXSM path to its original call of<br>
&gt;=C2=A0 =C2=A0 net_tx_pkt_update_ip_hdr_checksum(). Because that functio=
n no longer<br>
&gt;=C2=A0 =C2=A0 inflates ip_len, igb (which already calls the same functi=
on) is also<br>
&gt;=C2=A0 =C2=A0 corrected with no additional change.<br>
&gt; - Link to v4: <a href=3D"https://lore.kernel.org/qemu-devel/20260628-n=
et-tx-pkt-ip-length-padding-v4-1-829b36db5adb@gmail.com" rel=3D"noreferrer"=
 target=3D"_blank">https://lore.kernel.org/qemu-devel/20260628-net-tx-pkt-i=
p-length-padding-v4-1-829b36db5adb@gmail.com</a><br>
&gt; <br>
&gt; Changes in v4:<br>
&gt; - Add net_tx_pkt_update_ip_hdr_checksum_only(); call it from the e1000=
e<br>
&gt;=C2=A0 =C2=A0 IXSM path to avoid inflating ip_len.<br>
&gt; - Link to v3: <a href=3D"https://lore.kernel.org/qemu-devel/20260627-n=
et-tx-pkt-ip-length-padding-v3-1-e860dabadd3f@gmail.com" rel=3D"noreferrer"=
 target=3D"_blank">https://lore.kernel.org/qemu-devel/20260627-net-tx-pkt-i=
p-length-padding-v3-1-e860dabadd3f@gmail.com</a><br>
&gt; <br>
&gt; Changes in v3:<br>
&gt; - Architectural redesign: three-case fallback logic in<br>
&gt;=C2=A0 =C2=A0 net_tx_pkt_rebuild_payload() plus net_tx_pkt_set_payload_=
len() API;<br>
&gt;=C2=A0 =C2=A0 e1000e pre-sets payload_len from PAYLEN descriptor field.=
<br>
&gt; - Link to v2: <a href=3D"https://lore.kernel.org/qemu-devel/20260625-n=
et-tx-pkt-ip-length-padding-v2-1-287d0ba59ec1@gmail.com" rel=3D"noreferrer"=
 target=3D"_blank">https://lore.kernel.org/qemu-devel/20260625-net-tx-pkt-i=
p-length-padding-v2-1-287d0ba59ec1@gmail.com</a><br>
&gt; <br>
&gt; Changes in v2:<br>
&gt; - Fix iov_copy() to use raw_payload_len and net_tx_pkt_get_total_len()=
<br>
&gt;=C2=A0 =C2=A0 to use iov_size() to preserve correct wire frame size.<br=
>
&gt; - Link to v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260624-n=
et-tx-pkt-ip-length-padding-v1-1-7a22fe9b4e40@gmail.com" rel=3D"noreferrer"=
 target=3D"_blank">https://lore.kernel.org/qemu-devel/20260624-net-tx-pkt-i=
p-length-padding-v1-1-7a22fe9b4e40@gmail.com</a><br>
&gt; <br>
&gt; On the relationship to the short-packet receive-path discussion<br>
&gt; (Peter Maydell):<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=3D4=
ZR1+PA0=3D4-29=3DfEe+d+iUmhLTzpuQ@mail.gmail.com/" rel=3D"noreferrer" targe=
t=3D"_blank">https://lore.kernel.org/qemu-devel/CAFEAcA_UhmCxJc16CHE=3D4ZR1=
+PA0=3D4-29=3DfEe+d+iUmhLTzpuQ@mail.gmail.com/</a><br>
&gt; <br>
&gt; The linked thread concerns the receive path. This patch addresses only=
<br>
&gt; the transmit path: the IXSM offload path was overwriting a correctly<b=
r>
&gt; set guest ip_len with an inflated value that included Ethernet padding=
.<br>
&gt; No changes to padding behaviour or the receive path are made.<br>
&gt; <br>
&gt; To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-de=
vel@nongnu.org</a><br>
&gt; Cc: Dmitry Fleytman &lt;<a href=3D"mailto:dmitry.fleytman@gmail.com" t=
arget=3D"_blank">dmitry.fleytman@gmail.com</a>&gt;<br>
&gt; Cc: Akihiko Odaki &lt;<a href=3D"mailto:odaki@rsg.ci.i.u-tokyo.ac.jp" =
target=3D"_blank">odaki@rsg.ci.i.u-tokyo.ac.jp</a>&gt;<br>
&gt; Cc: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_b=
lank">jasowang@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/net_tx_pkt.c | 7 +++----<br>
&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c<br>
&gt; index 903238dca2..b134348fe8 100644<br>
&gt; --- a/hw/net/net_tx_pkt.c<br>
&gt; +++ b/hw/net/net_tx_pkt.c<br>
&gt; @@ -93,9 +93,6 @@ void net_tx_pkt_update_ip_hdr_checksum(struct NetTxP=
kt *pkt)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t csum;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(pkt);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 pkt-&gt;l3_hdr.ip.ip_len =3D cpu_to_be16(pkt-&gt;payloa=
d_len +<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt-&gt;vec[NET_TX_PKT_L3HDR_FRAG].iov_le=
n);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pkt-&gt;l3_hdr.ip.ip_sum =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0csum =3D net_raw_checksum(pkt-&gt;l3_hdr.oct=
ets,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt-&gt;vec[NET_TX_PKT_L3HDR_F=
RAG].iov_len);<br>
&gt; @@ -117,7 +114,9 @@ void net_tx_pkt_update_ip_checksums(struct NetTxPk=
t *pkt)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (gso_type =3D=3D VIRTIO_NET_HDR_GSO_TCPV4=
 ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gso_type =3D=3D VIRTIO_NET_HDR=
_GSO_UDP) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Calculate IP header checksum */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set ip_len and calculate IP header che=
cksum */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt-&gt;l3_hdr.ip.ip_len =3D cpu_to_be16(=
pkt-&gt;payload_len +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt-&gt;vec[NET_TX_PKT_L3HD=
R_FRAG].iov_len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0net_tx_pkt_update_ip_hdr_check=
sum(pkt);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Calculate IP pseudo header =
checksum */<br>
&gt; <br>
&gt; ---<br>
&gt; base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb<br>
&gt; change-id: 20260628-net-tx-pkt-ip-length-padding-951e75fa97b4<br>
&gt; <br>
&gt; Best regards,<br>
&gt; --<br>
&gt; Sanjeeva Yerrapureddy &lt;<a href=3D"mailto:y.sanjeevreddy@gmail.com" =
target=3D"_blank">y.sanjeevreddy@gmail.com</a>&gt;<br>
&gt; <br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">regards,<br>Sanjeeva Reddy.Y.<br></div>

--000000000000e91077065576fd0d--

