Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B530C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 09:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujDf1-0001x3-73; Tue, 05 Aug 2025 05:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ujDew-0001nM-ET
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 05:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ujDes-0005eg-NW
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 05:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754384911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYKkzLn/uhOHXyojAyewUpwtwZR+5vChqK7EZOJ9F/Y=;
 b=IRFuYZovqnuWep99RGqAbqwgWzhM76nXLTYyLoI2e0Rw1vqIdpLDI+u3kE88BuLjYd2qh+
 yljmJPc+1tC9o9qA9BPktocN/MrYLQQvQMlzS/Fbpt5nWIAoZKtzzT0fhZ0lZM0auIM4sE
 nhAVBzdcvdTVAq2/bh5v2ZQcF31DE6A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-CBoctBaGMjutM1rqrxDxRw-1; Tue, 05 Aug 2025 05:08:30 -0400
X-MC-Unique: CBoctBaGMjutM1rqrxDxRw-1
X-Mimecast-MFC-AGG-ID: CBoctBaGMjutM1rqrxDxRw_1754384909
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24011ceafc8so46841705ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 02:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754384908; x=1754989708;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYKkzLn/uhOHXyojAyewUpwtwZR+5vChqK7EZOJ9F/Y=;
 b=pTYRENImRcjphxCPloVtnrRwv4/x8YtwgUeMXz4dwtxoViIVTOuhhdO+SCYQSqQE8A
 2DCs89JiJ8RYcCvW7buDoMDoG5Dl12EDrW/+g3ObHdjRlNyCnqFHnpMl7029TR1atEnF
 hZ4+MfTxTC7QPWi7xOwQu1aoizvoim5FdCKQthrsFPZ5RGDKh0ky1YifYhonOuTZM94n
 hS8HfmN3ySPkl4fH4fBWhlyg+Hx+fWecxEmIMKxy3gA+9H4ryOcgdW78Dqyjdy4H8XqN
 S6IVMHnky8kLfmQrTtX7nYfaLHEbSzkgh5iqVM8VZGX8FZ45TBS7L2OYJT97+uTgh+mA
 Fe8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHAvSpVnDHd7FOu5g7mFytounFDw7z0AJOxjnnc841FG7aIfpVDnnkOhSKrgKvRz1Efgk4uMLmSI+S@nongnu.org
X-Gm-Message-State: AOJu0Yyenem+rYh2/Qmwroc/T44IffivbJgpJmGHRH4KNzgoqv0R1iCu
 3Thvk2v8UuUUpPpsQKUSuQsCV89dtYzRT5QI7lv5YkXNOjAKxcdW+U6Y05s2fHKXbFR+G39KPHC
 by6d2GrbLfG4WZrZlaL3oh9I2W7dk46S/YWCq7rIdf0jP3cVs96cm07QXP8VuDZoQMgq8NuMOrQ
 DSzrH/yWZIN/wp5oWcxcA0J+SXbdicLDk=
X-Gm-Gg: ASbGncvkURTai5Lio/3qNCmbnnp1TTFqlQzLGpDIRsiCwuHIsUjzFbPiroyGaZXKSj+
 9i18UrEOzvx9WaW1C7g2YQvvxCkdoCB5m4TL/40W7DH2qI/j/+JIas3Co+YbHUGmMk4RUMxRpGX
 PM2Ko4/t6cM0arbPDB8WbO
X-Received: by 2002:a17:902:ef47:b0:234:9375:e07c with SMTP id
 d9443c01a7336-2424705defamr184698465ad.46.1754384907660; 
 Tue, 05 Aug 2025 02:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB14t0jEyQKwgLp0xICLWkhb5nYipIlSRR+/1kTCYvNa3+EvQhAcJGpOF4COdiANGQ9QJy18VW1DzlfGUOBdk=
X-Received: by 2002:a17:902:ef47:b0:234:9375:e07c with SMTP id
 d9443c01a7336-2424705defamr184698005ad.46.1754384907150; Tue, 05 Aug 2025
 02:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
 <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
 <CAJaqyWd=ssa5fkmV7Z=tzJvFeciC1P2U2pYheaSrZ2PZCaejHg@mail.gmail.com>
 <9a7c409f-cd7e-4906-812b-c8a4d77cfc4d@gmail.com>
 <CAJaqyWdme4GSTQr-mbGiWvV5Wu0Mnjc467ptWFoX2i3zHygf3g@mail.gmail.com>
 <97eafb50-492a-4571-92de-503fbc0d06fd@gmail.com>
 <CAJaqyWeG2n=BhjNhQzMagjh5t-dgno6q-esVjzqrw8z3_sUrHA@mail.gmail.com>
 <68e7a854-f7d3-4d21-87b0-3a23f4341493@gmail.com>
 <CAJaqyWcWoyGWeOG1B8FBZgGb6n99fVkTAvaTFco0A2cvr8Lf8w@mail.gmail.com>
 <15d4f488-5431-460c-8e06-0741e11fe7f2@gmail.com>
In-Reply-To: <15d4f488-5431-460c-8e06-0741e11fe7f2@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 5 Aug 2025 11:07:50 +0200
X-Gm-Features: Ac12FXxMWadACgqDPtQoh6VBIlFQ-7GxmfWijO-TXY4nWzu6S8-x_HfLTsbpvGM
Message-ID: <CAJaqyWfwcUyzpJMuTxE=znmrJeWoiGfUSmO9Oh1G3mH4YJ5pLA@mail.gmail.com>
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Aug 4, 2025 at 8:04=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> Hi,
>
> On 7/31/25 7:22 PM, Eugenio Perez Martin wrote:
> > On Wed, Jul 30, 2025 at 4:33=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >> I think I have finally found the reason behind this issue.
> >>
> >> The order in which "add_packed" and "get_buf_packed" are performed in =
the
> >> nested guest kernel (L2 kernel) and QEMU are a little different. Due t=
o
> >> this, the values in free_head and svq->desc_next[] differ and the gues=
t
> >> crashes at some point. More below.
> >>
> >> On 6/26/25 1:07 PM, Eugenio Perez Martin wrote:
> >>> On Thu, Jun 26, 2025 at 7:16=E2=80=AFAM Sahil Siddiq <icegambit91@gma=
il.com> wrote:
> >>>> I think there's something off in the way "free_head", "last_used_idx=
" and
> >>>> "desc_next" values are calculated in vhost_svq_get_buf_packed() [1].
> >>>>
> >>>> In the latest test run, QEMU sent ids 0 through 28 to L2. L2 started=
 receiving
> >>>> them in order till id 8. At this point it received id 7 again for so=
me reason
> >>>> and then crashed.
> >>>>
> >>>> L2:
> >>>>
> >>>> [ 1641.129218] (prepare_packed) output.0 -> needs_kick: 1
> >>>> [ 1641.130621] (notify) output.0 -> function will return true
> >>>> [ 1641.132022] output.0 -> id: 0
> >>>> [ 1739.502358] input.0 -> id: 0
> >>>> [ 1739.503003] input.0 -> id: 1
> >>>> [ 1739.562024] input.0 -> id: 2
> >>>> [ 1739.578682] input.0 -> id: 3
> >>>> [ 1739.661913] input.0 -> id: 4
> >>>> [ 1739.828796] input.0 -> id: 5
> >>>> [ 1739.829789] input.0 -> id: 6
> >>>> [ 1740.078757] input.0 -> id: 7
> >>>> [ 1740.079749] input.0 -> id: 8
> >>>> [ 1740.080382] input.0 -> id: 7    <----Received 7 again
> >>>> [ 1740.081614] virtio_net virtio1: input.0:id 7 is not a head!
> >>>>
> >>>> QEMU logs (vhost_svq_get_buf_packed):
> >>>> ------
> >>>> size              : svq->vring.num
> >>>> len               : svq->vring_packed.vring.desc[last_used].len
> >>>> id                : svq->vring_packed.vring.desc[last_used].id
> >>>> num               : svq->desc_state[id].ndescs
> >>>> last_used_chain   : Result of vhost_svq_last_desc_of_chain(svq, num,=
 id) [2]
> >>>> free_head         : svq->free_head
> >>>> last_used         : (last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRA=
P_CTR)) + num
> >>>> used_wrap_counter : !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WR=
AP_CTR))
> >>>> ------
> >>>> size: 256, len: 82, id: 7, vq idx: 0
> >>>> id: 7, last_used_chain: 7, free_head: 6, vq idx: 0
> >>>> num: 1, free_head: 7, id: 7, last_used: 8, used_wrap_counter: 1, vq =
idx: 0
> >>>> ------
> >>>> size: 256, len: 104, id: 8, vq idx: 0
> >>>> id: 8, last_used_chain: 8, free_head: 7, vq idx: 0
> >>>> num: 1, free_head: 8, id: 8, last_used: 9, used_wrap_counter: 1, vq =
idx: 0
> >>>> ------
> >>>> size: 256, len: 98, id: 9, vq idx: 0
> >>>> id: 9, last_used_chain: 9, free_head: 8, vq idx: 0
> >>>> num: 1, free_head: 9, id: 9, last_used: 10, used_wrap_counter: 1, vq=
 idx: 0
> >>>> ------
> >>>> size: 256, len: 104, id: 10, vq idx: 0
> >>>> id: 10, last_used_chain: 10, free_head: 9, vq idx: 0
> >>>> num: 1, free_head: 10, id: 10, last_used: 11, used_wrap_counter: 1, =
vq idx: 0
> >>>>
> >>>> I have a few more ideas of what to do. I'll let you know if I find s=
omething
> >>>> else.
> >>>>
> >>> I cannot find anything just by inspection. What about printing all th=
e
> >>> desc_state and all desc_next to check for incoherencies in each
> >>> svq_add and get_buf?
> >> In this test, all 256 descriptors were filled in the RX vq.
> >>
> >> In the TX queue, L2 kernel would add one descriptor at a time and noti=
fy
> >> QEMU. QEMU would then register it in its SVQ and mark it as "available=
".
> >> After processing the descriptor, QEMU would mark it as "used" and flus=
h it
> >> back to L2. L2, in turn, would mark this descriptor as "used". After t=
his
> >> process, L2 would add the next descriptor in the TX vq while reusing t=
his
> >> ID. This was observed from idx 0 till idx 7.
> >>
> >> L2's debug logs:
> >>
> >> [   18.379112] (use_indirect?) output.0 -> verdict: 0                <=
----- Begin adding descriptor in idx 6
> >> [   18.387134] (add_packed) output.0 -> idx: 6
> >> [   18.389897] (add_packed) output.0 -> id: 0
> >> [   18.392290] (add_packed) output.0 -> len: 74
> >> [   18.394606] (add_packed) output.0 -> addr: 5012315726
> >> [   18.397043] (add_packed) output.0 -> next id: 1
> >> [   18.399861] Entering prepare_packed: output.0
> >> [   18.402478] (prepare_packed) output.0 -> needs_kick: 1
> >> [   18.404998] (notify) output.0 -> function will return true        <=
----- Notify QEMU
> >> [   18.406349] output.0 -> id: 0, idx: 6                             <=
----- Mark ID 0 in idx 6 as used
> >> [   18.409482] output.0 -> old free_head: 1, new free_head: 0        <=
----- ID 0 can be reused
> >> [   18.410919] (after get_buf processed) output.0 -> id: 0, idx: 7   <=
----- Next slot is idx 7
> >> [   18.921895] (use_indirect?) output.0 -> verdict: 0                <=
----- Begin adding descriptor with ID =3D 0 in idx 7
> >> [   18.930093] (add_packed) output.0 -> idx: 7
> >> [   18.935715] (add_packed) output.0 -> id: 0
> >> [   18.937609] (add_packed) output.0 -> len: 122
> >> [   18.939614] (add_packed) output.0 -> addr: 4925868038
> >> [   18.941710] (add_packed) output.0 -> next id: 1
> >> [   18.944032] Entering prepare_packed: output.0
> >> [   18.946148] (prepare_packed) output.0 -> needs_kick: 1
> >> [   18.948234] (notify) output.0 -> function will return true        <=
----- Notify QEMU
> >> [   18.949606] output.0 -> id: 0, idx: 7                             <=
----- Mark ID 0 in idx 7 as used
> >> [   18.952756] output.0 -> old free_head: 1, new free_head: 0        <=
----- ID 0 can be reused
> >> [   18.955154] (after get_buf processed) output.0 -> id: 0, idx: 8   <=
----- Next slot is idx 8
> >>
> >> There was no issue in QEMU till this point.
> >>
> >> [   19.177536] (use_indirect?) output.0 -> verdict: 0                <=
----- Begin adding descriptor with ID =3D 0 in idx 8
> >> [   19.182415] (add_packed) output.0 -> idx: 8
> >> [   19.187257] (add_packed) output.0 -> id: 0
> >> [   19.191355] (add_packed) output.0 -> len: 102
> >> [   19.195131] (add_packed) output.0 -> addr: 4370702342
> >> [   19.199224] (add_packed) output.0 -> next id: 1
> >> [   19.204929] Entering prepare_packed: output.0
> >> [   19.209505] (prepare_packed) output.0 -> needs_kick: 1
> >> [   19.213820] (notify) output.0 -> function will return true       <-=
---- Notify QEMU
> >> [   19.218792] (use_indirect?) output.0 -> verdict: 0               <-=
---- Next slot is idx 9
> >> [   19.224730] (add_packed) output.0 -> idx: 9
> >> [   19.227067] (add_packed) output.0 -> id: 1                       <-=
---- ID 0 can't be reused yet, so use ID =3D 1
> >> [   19.229090] (add_packed) output.0 -> len: 330
> >> [   19.231182] (add_packed) output.0 -> addr: 4311020614
> >> [   19.233302] (add_packed) output.0 -> next id: 2
> >> [   19.235620] Entering prepare_packed: output.0
> >> [   19.237781] (prepare_packed) output.0 -> needs_kick: 1
> >> [   19.239958] (notify) output.0 -> function will return true       <-=
---- Notify QEMU
> >> [   19.237780] output.0 -> id: 0, idx: 8                            <-=
---- Mark ID 0 in idx 8 as used
> >> [   19.243676] output.0 -> old free_head: 2, new free_head: 0       <-=
---- ID 0 can now be reused
> >> [   19.245214] (after get_buf processed) output.0 -> id: 0, idx: 9  <-=
---- Next slot is idx 9
> >> [   19.247097] output.0 -> id: 1, idx: 9                            <-=
---- Mark ID 1 in idx 9 as used
> >> [   19.249612] output.0 -> old free_head: 0, new free_head: 1       <-=
---- ID 1 can now be reused
> >> [   19.252266] (after get_buf processed) output.0 -> id: 1, idx: 10 <-=
---- Next slot is idx 10
> >>
> >> ID 0 and ID 1 in idx 8 and idx 9 respectively are pushed to QEMU
> >> before either of them are marked as used.
> >>
> >> But in QEMU, the order is slightly different.
> >>
> >> num: 1, init_flags: 128                                               =
         <----- vhost_svq_add_packed()
> >> idx: 8, id: 0, len: 0, flags: 0, vq idx: 1                            =
         <----- Before adding descriptor
> >> idx: 8, id: 0, len: 102, flags: 128, vq idx: 1                        =
         <----- After adding descriptor
> >> Finally: new_idx: 9, head_idx: 8, id: 0, len: 102, flags: 128, vq idx:=
 1
> >> svq->vring.num: 256                                                   =
         <----- Begin vhost_svq_get_buf_packed()
> >> descriptor_len: 0
> >> descriptor_id: 0                                                      =
         <----- Mark ID =3D 0 as used
> >> last_used: 8                                                          =
         <----- Processing idx 8
> >> used_wrap_counter: 1
> >> svq->desc_state[id].ndescs: 1
> >> free_head: 0                                                          =
         <----- Update free_head to 0.
> >> last_used: 9                                                          =
         <----- Update last_used to 9.
> >> vq idx: 1                                                             =
         <----- End vhost_svq_get_buf_packed()
> >> i: 0                                                                  =
         <----- vhost_svq_flush()
> >> descriptor_len: 0
> >> elem->len: 22086
> >> i: 1
> >> elem_is_null: 1
> >> vq idx: 1                                                             =
         <----- End vhost_svq_flush()
> >> num: 1, init_flags: 128                                               =
         <----- vhost_svq_add_packed()
> >> idx: 9, id: 0, len: 0, flags: 0, curr: 0, vq idx: 1                   =
         <----- Before adding descriptor
> >> idx: 9, id: 0, len: 330, flags: 128, curr: 1, vq idx: 1               =
         <----- After adding descriptor
> >> Finally: new_idx: 10, head_idx: 9, id: 0, len: 330, flags: 128, vq idx=
: 1      <----- ID 0 has been reused (versus ID 1 in L2)
> >> svq->vring.num: 256                                                   =
         <----- Begin vhost_svq_get_buf_packed()
> >> descriptor_len: 0
> >> descriptor_id: 0                                                      =
         <----- Mark ID =3D 0 as used
> >> last_used: 9                                                          =
         <----- Processing idx 9
> >> used_wrap_counter: 1
> >> svq->desc_state[id].ndescs: 1
> >> free_head: 0                                                          =
         <----- Update free_head to 0.
> >> last_used: 10                                                         =
         <----- Update last_used to 10.
> >> vq idx: 1                                                             =
         <----- End vhost_svq_get_buf_packed()
> >> i: 0                                                                  =
         <----- vhost_svq_flush()
> >> descriptor_len: 0
> >> elem->len: 22086
> >> i: 1
> >> elem_is_null: 1
> >> vq idx: 1                                                             =
         <----- End vhost_svq_flush()
> >>
> >> In QEMU, id 0 is added in idx 8. But it's marked as used before a
> >> descriptor can be added in idx 9. Because of this there's a discrepanc=
y
> >> in the value of free_head and in svq->desc_next.
> >>
> >> In the current implementation, the values of ID are generated, maintai=
ned
> >> and processed by QEMU instead of reading from the guest's memory. I th=
ink
> >> reading the value of ID from the guest memory (similar to reading the
> >> descriptor length from guest memory) should resolve this issue.
> >>
> >
> > Ok you made a good catch here :).
> >
> > The 1:1 sync is hard to achieve as a single buffer in the guest may
> > need to be splitted in many buffers in the host.
> >
> >> The alternative would be to ensure that "add_packed" and "get_buf_pack=
ed"
> >> are synchronized between the guest and QEMU.
> >
> > Yes, they're synchronized. When the guest makes an available
> > descriptor, its head is saved in the VirtQueueElement of the SVQ's
> > head idx on svq->desc_state.
> >
> > Reviewing patch 3/7 I see you're actually returning the id of the
> > first descriptor of the chain in *head, while it should be the id of
> > the *last* descriptor. It should not be the cause of the failure, as I
> > don't see any descriptor chain in the log.
>
> Does this mean if the current free_head is 3 and the length of the chain
> is 4, then ID 7 should be saved in the descriptor ring? In the current
> implementation, *all* descriptors in the chain are being assigned the sam=
e
> ID (=3D free_head instead of free_head + length of chain).
>

Ouch, you're right! I recall I had the same comment while reading the
kernel's version and I forgot it.

> > To keep the free linked list happy we may need to store the head of the
> > descriptor chain in the vq too.
> >
> > Now, why is SVQ id 0 being reused? Sounds like free_list is not
> > initialized to 0, 1, 2... but to something else like 0, 0, 0, etc. Can
> > you print the whole list in each iteration?
> >
>
> The free_list initially has the following values:
> index 0 -> 1
> index 1 -> 2
> ...
> index 254 -> 255
> index 255 -> 0
>
> free_head is set to 0 at the beginning. When add_packed() executes for
> the first time ID 0 is used and free_head is set to 1. If get_buf_packed(=
)
> is run immediately after the "add" operation, free_list[ID] is set to
> the current free_head (ID 1 in this case). After this free_head is set to
> the used ID (0 in this case).
>
> So, free_list still looks like this:
> index 0 -> 1
> index 1 -> 2
> ...
> index 254 -> 255
> index 255 -> 0
>
> But the free_head is 0. So, ID =3D 0 is reused again.
>
> When 2 IDs (such as with idx 8 and idx 9 in the guest) are added to the
> SVQ without either being used, then free_head is updated as shown:
>
> free_head =3D 0 -> 1 -> 2
>
> And then marking both IDs as "used" results in:
>
> free_list[0] =3D current free_head (=3D 2)
> free_head =3D 0
> free_list[1] =3D current free_head (=3D 0)
> free_head =3D 1
>
> So free_list looks like this:
>
> index 0 -> 2
> index 1 -> 0
> index 2 -> 3
> index 3 -> 4
> ...
> index 254 -> 255
> index 255 -> 0
>
> None of the indices in free_list hold the value 1.
>

So the free_list should always transverse all the indices. If SVQ
makes available 0, 1 and then the device uses 0, 1 in that order, the
free list should be 1 -> 0 -> 2 -> 3... Otherwise the loop will make
available the same descriptor twice. You should always have this case
in the rx queue in the Linux kernel virtio driver once it uses two
descriptors, maybe you can trace it and compare it with your SVQ code?

I just spotted that you're using le32_to_cpu(used descriptor id) in
patch 5/7, but it should be le16_to_cpu(). It shouldn't matter in x86
but it would cause problems in BE archs.

> Since at this point free_head is 1, ID 1 is now used very frequently
> if add_packed() and get_buf_used() run one at a time in an interleaved
> fashion.
>

This part is expected.


