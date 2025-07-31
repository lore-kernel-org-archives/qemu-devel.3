Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63B2C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 15:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhUzT-00015P-LP; Thu, 31 Jul 2025 11:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uhTik-0002Ea-E7
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uhTih-0006L7-3m
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753969994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BGRmus4BwphYDxyZlS6EzC47lv3OTWWwyHcmaNRV0Co=;
 b=cNBYTzwna+38mqP/aVl7UpjHhM4CKZTJteH5bo92V9iD6UmOuO0Deh/oHEQSfaBJPslW4q
 mLlf3fVl0X+rDPWZi20ggRAJDn2YsWmS7xznghtCW0wPP8PZEVY7d84Uu91p5K55sgtaZ7
 mnHgyZnmvvLxjzxzyQgEyH8e4MZqiPU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-8aggi_EENh6LbKoDAC0N-Q-1; Thu, 31 Jul 2025 09:53:12 -0400
X-MC-Unique: 8aggi_EENh6LbKoDAC0N-Q-1
X-Mimecast-MFC-AGG-ID: 8aggi_EENh6LbKoDAC0N-Q_1753969991
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31eac278794so1041037a91.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753969990; x=1754574790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGRmus4BwphYDxyZlS6EzC47lv3OTWWwyHcmaNRV0Co=;
 b=sRozH1a7y7cMpC+2h7EL6sw8DrXnMO6tVkeAFANP8un3wzskNXsOqyi2ai1pxfuHjQ
 uZG/SDy2+FXkn8b2Uvnh4jiXZXZqt7lXy568enW/+6Eu0N+gXaDj+uuPKDysRxRSstUE
 OnkqKkrNPGvmXnmnwJV38s9FcC61P7yawtNvglGKf5ZmbTQm4sy7hNNuDPduUGwx9Z6I
 vmsSC2T0062l6YmekCoq29HAd9Mu8H/qpfsWO1S23oWaG8Yl88tZP4JGBTAHLfcIVZTD
 ao3/cmeqCGX+OILz02FolZGqzp0YaT9qQQByg8f0MTTHyXHBh1rQ6p7Xack4IfNqmsHR
 lR4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlMr/a/nzU2wO/k3lGkQbG96hX/Rfi4sO9toEEc+3gi51u3jgLH3esoWEGIW/A8D6LsxlAdI1yzJHV@nongnu.org
X-Gm-Message-State: AOJu0YzAlCgqUvrqzWhutn+W8M1EhR1Wx/b+sLnp3Gk12NqndY8JVYjE
 H6rR80M8jBOpGb9uiSZncUkBz5TZbtnu6Age2g9pjir8hvH3Com1fuA0Aa+ReSnKrVgIXNVgsCM
 hUnA7SJUHlPRYccd4Wy4SleDrC2UhscygZCmvXavgbYE21U26oKwFjiaAn0a42Mv3iWXrFAoKvZ
 rsIkXqu85tEpUVJurRByFXV67kpzYhf0I=
X-Gm-Gg: ASbGncuLLOVCYhBZiq+NGccFvpKK1YDrVbTA3dAuDPcGWWXVm854W7bJmmGIlJP/wJH
 G448AFYXzrE2Gc/BmgZm2rLCxZ6+K8H0aOZJ6/+5cnTPWWqb6MxifAk0Sq1OW6+TraSvQu5yoyt
 iku7wvwaNcn4JwVqlf0pLzXfiFgGuvK/N7I4SnPvAbM2e4J63KJ5ApTN4=
X-Received: by 2002:a17:90b:17c2:b0:31f:22f:a23e with SMTP id
 98e67ed59e1d1-31f5de4ab59mr10180588a91.27.1753969990303; 
 Thu, 31 Jul 2025 06:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzWM+5wFEZt/dzoRUP2gQ1C75Ozq2Hu82DN34tBG5B+a5TJJ0xIYNUDmpak7SX5iuMZ4Z4mkGqJRTtKkOxOkY=
X-Received: by 2002:a17:90b:17c2:b0:31f:22f:a23e with SMTP id
 98e67ed59e1d1-31f5de4ab59mr10180500a91.27.1753969989323; Thu, 31 Jul 2025
 06:53:09 -0700 (PDT)
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
In-Reply-To: <68e7a854-f7d3-4d21-87b0-3a23f4341493@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 31 Jul 2025 15:52:12 +0200
X-Gm-Features: Ac12FXxqO_vLxBRwNrmIQxzibnOd-7X2ZUUELQFxABnxkLykhyiLVf9B6ZZlFFE
Message-ID: <CAJaqyWcWoyGWeOG1B8FBZgGb6n99fVkTAvaTFco0A2cvr8Lf8w@mail.gmail.com>
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

On Wed, Jul 30, 2025 at 4:33=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> I think I have finally found the reason behind this issue.
>
> The order in which "add_packed" and "get_buf_packed" are performed in the
> nested guest kernel (L2 kernel) and QEMU are a little different. Due to
> this, the values in free_head and svq->desc_next[] differ and the guest
> crashes at some point. More below.
>
> On 6/26/25 1:07 PM, Eugenio Perez Martin wrote:
> > On Thu, Jun 26, 2025 at 7:16=E2=80=AFAM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >> I think there's something off in the way "free_head", "last_used_idx" =
and
> >> "desc_next" values are calculated in vhost_svq_get_buf_packed() [1].
> >>
> >> In the latest test run, QEMU sent ids 0 through 28 to L2. L2 started r=
eceiving
> >> them in order till id 8. At this point it received id 7 again for some=
 reason
> >> and then crashed.
> >>
> >> L2:
> >>
> >> [ 1641.129218] (prepare_packed) output.0 -> needs_kick: 1
> >> [ 1641.130621] (notify) output.0 -> function will return true
> >> [ 1641.132022] output.0 -> id: 0
> >> [ 1739.502358] input.0 -> id: 0
> >> [ 1739.503003] input.0 -> id: 1
> >> [ 1739.562024] input.0 -> id: 2
> >> [ 1739.578682] input.0 -> id: 3
> >> [ 1739.661913] input.0 -> id: 4
> >> [ 1739.828796] input.0 -> id: 5
> >> [ 1739.829789] input.0 -> id: 6
> >> [ 1740.078757] input.0 -> id: 7
> >> [ 1740.079749] input.0 -> id: 8
> >> [ 1740.080382] input.0 -> id: 7    <----Received 7 again
> >> [ 1740.081614] virtio_net virtio1: input.0:id 7 is not a head!
> >>
> >> QEMU logs (vhost_svq_get_buf_packed):
> >> ------
> >> size              : svq->vring.num
> >> len               : svq->vring_packed.vring.desc[last_used].len
> >> id                : svq->vring_packed.vring.desc[last_used].id
> >> num               : svq->desc_state[id].ndescs
> >> last_used_chain   : Result of vhost_svq_last_desc_of_chain(svq, num, i=
d) [2]
> >> free_head         : svq->free_head
> >> last_used         : (last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_=
CTR)) + num
> >> used_wrap_counter : !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP=
_CTR))
> >> ------
> >> size: 256, len: 82, id: 7, vq idx: 0
> >> id: 7, last_used_chain: 7, free_head: 6, vq idx: 0
> >> num: 1, free_head: 7, id: 7, last_used: 8, used_wrap_counter: 1, vq id=
x: 0
> >> ------
> >> size: 256, len: 104, id: 8, vq idx: 0
> >> id: 8, last_used_chain: 8, free_head: 7, vq idx: 0
> >> num: 1, free_head: 8, id: 8, last_used: 9, used_wrap_counter: 1, vq id=
x: 0
> >> ------
> >> size: 256, len: 98, id: 9, vq idx: 0
> >> id: 9, last_used_chain: 9, free_head: 8, vq idx: 0
> >> num: 1, free_head: 9, id: 9, last_used: 10, used_wrap_counter: 1, vq i=
dx: 0
> >> ------
> >> size: 256, len: 104, id: 10, vq idx: 0
> >> id: 10, last_used_chain: 10, free_head: 9, vq idx: 0
> >> num: 1, free_head: 10, id: 10, last_used: 11, used_wrap_counter: 1, vq=
 idx: 0
> >>
> >> I have a few more ideas of what to do. I'll let you know if I find som=
ething
> >> else.
> >>
> > I cannot find anything just by inspection. What about printing all the
> > desc_state and all desc_next to check for incoherencies in each
> > svq_add and get_buf?
> In this test, all 256 descriptors were filled in the RX vq.
>
> In the TX queue, L2 kernel would add one descriptor at a time and notify
> QEMU. QEMU would then register it in its SVQ and mark it as "available".
> After processing the descriptor, QEMU would mark it as "used" and flush i=
t
> back to L2. L2, in turn, would mark this descriptor as "used". After this
> process, L2 would add the next descriptor in the TX vq while reusing this
> ID. This was observed from idx 0 till idx 7.
>
> L2's debug logs:
>
> [   18.379112] (use_indirect?) output.0 -> verdict: 0                <---=
-- Begin adding descriptor in idx 6
> [   18.387134] (add_packed) output.0 -> idx: 6
> [   18.389897] (add_packed) output.0 -> id: 0
> [   18.392290] (add_packed) output.0 -> len: 74
> [   18.394606] (add_packed) output.0 -> addr: 5012315726
> [   18.397043] (add_packed) output.0 -> next id: 1
> [   18.399861] Entering prepare_packed: output.0
> [   18.402478] (prepare_packed) output.0 -> needs_kick: 1
> [   18.404998] (notify) output.0 -> function will return true        <---=
-- Notify QEMU
> [   18.406349] output.0 -> id: 0, idx: 6                             <---=
-- Mark ID 0 in idx 6 as used
> [   18.409482] output.0 -> old free_head: 1, new free_head: 0        <---=
-- ID 0 can be reused
> [   18.410919] (after get_buf processed) output.0 -> id: 0, idx: 7   <---=
-- Next slot is idx 7
> [   18.921895] (use_indirect?) output.0 -> verdict: 0                <---=
-- Begin adding descriptor with ID =3D 0 in idx 7
> [   18.930093] (add_packed) output.0 -> idx: 7
> [   18.935715] (add_packed) output.0 -> id: 0
> [   18.937609] (add_packed) output.0 -> len: 122
> [   18.939614] (add_packed) output.0 -> addr: 4925868038
> [   18.941710] (add_packed) output.0 -> next id: 1
> [   18.944032] Entering prepare_packed: output.0
> [   18.946148] (prepare_packed) output.0 -> needs_kick: 1
> [   18.948234] (notify) output.0 -> function will return true        <---=
-- Notify QEMU
> [   18.949606] output.0 -> id: 0, idx: 7                             <---=
-- Mark ID 0 in idx 7 as used
> [   18.952756] output.0 -> old free_head: 1, new free_head: 0        <---=
-- ID 0 can be reused
> [   18.955154] (after get_buf processed) output.0 -> id: 0, idx: 8   <---=
-- Next slot is idx 8
>
> There was no issue in QEMU till this point.
>
> [   19.177536] (use_indirect?) output.0 -> verdict: 0                <---=
-- Begin adding descriptor with ID =3D 0 in idx 8
> [   19.182415] (add_packed) output.0 -> idx: 8
> [   19.187257] (add_packed) output.0 -> id: 0
> [   19.191355] (add_packed) output.0 -> len: 102
> [   19.195131] (add_packed) output.0 -> addr: 4370702342
> [   19.199224] (add_packed) output.0 -> next id: 1
> [   19.204929] Entering prepare_packed: output.0
> [   19.209505] (prepare_packed) output.0 -> needs_kick: 1
> [   19.213820] (notify) output.0 -> function will return true       <----=
- Notify QEMU
> [   19.218792] (use_indirect?) output.0 -> verdict: 0               <----=
- Next slot is idx 9
> [   19.224730] (add_packed) output.0 -> idx: 9
> [   19.227067] (add_packed) output.0 -> id: 1                       <----=
- ID 0 can't be reused yet, so use ID =3D 1
> [   19.229090] (add_packed) output.0 -> len: 330
> [   19.231182] (add_packed) output.0 -> addr: 4311020614
> [   19.233302] (add_packed) output.0 -> next id: 2
> [   19.235620] Entering prepare_packed: output.0
> [   19.237781] (prepare_packed) output.0 -> needs_kick: 1
> [   19.239958] (notify) output.0 -> function will return true       <----=
- Notify QEMU
> [   19.237780] output.0 -> id: 0, idx: 8                            <----=
- Mark ID 0 in idx 8 as used
> [   19.243676] output.0 -> old free_head: 2, new free_head: 0       <----=
- ID 0 can now be reused
> [   19.245214] (after get_buf processed) output.0 -> id: 0, idx: 9  <----=
- Next slot is idx 9
> [   19.247097] output.0 -> id: 1, idx: 9                            <----=
- Mark ID 1 in idx 9 as used
> [   19.249612] output.0 -> old free_head: 0, new free_head: 1       <----=
- ID 1 can now be reused
> [   19.252266] (after get_buf processed) output.0 -> id: 1, idx: 10 <----=
- Next slot is idx 10
>
> ID 0 and ID 1 in idx 8 and idx 9 respectively are pushed to QEMU
> before either of them are marked as used.
>
> But in QEMU, the order is slightly different.
>
> num: 1, init_flags: 128                                                  =
      <----- vhost_svq_add_packed()
> idx: 8, id: 0, len: 0, flags: 0, vq idx: 1                               =
      <----- Before adding descriptor
> idx: 8, id: 0, len: 102, flags: 128, vq idx: 1                           =
      <----- After adding descriptor
> Finally: new_idx: 9, head_idx: 8, id: 0, len: 102, flags: 128, vq idx: 1
> svq->vring.num: 256                                                      =
      <----- Begin vhost_svq_get_buf_packed()
> descriptor_len: 0
> descriptor_id: 0                                                         =
      <----- Mark ID =3D 0 as used
> last_used: 8                                                             =
      <----- Processing idx 8
> used_wrap_counter: 1
> svq->desc_state[id].ndescs: 1
> free_head: 0                                                             =
      <----- Update free_head to 0.
> last_used: 9                                                             =
      <----- Update last_used to 9.
> vq idx: 1                                                                =
      <----- End vhost_svq_get_buf_packed()
> i: 0                                                                     =
      <----- vhost_svq_flush()
> descriptor_len: 0
> elem->len: 22086
> i: 1
> elem_is_null: 1
> vq idx: 1                                                                =
      <----- End vhost_svq_flush()
> num: 1, init_flags: 128                                                  =
      <----- vhost_svq_add_packed()
> idx: 9, id: 0, len: 0, flags: 0, curr: 0, vq idx: 1                      =
      <----- Before adding descriptor
> idx: 9, id: 0, len: 330, flags: 128, curr: 1, vq idx: 1                  =
      <----- After adding descriptor
> Finally: new_idx: 10, head_idx: 9, id: 0, len: 330, flags: 128, vq idx: 1=
      <----- ID 0 has been reused (versus ID 1 in L2)
> svq->vring.num: 256                                                      =
      <----- Begin vhost_svq_get_buf_packed()
> descriptor_len: 0
> descriptor_id: 0                                                         =
      <----- Mark ID =3D 0 as used
> last_used: 9                                                             =
      <----- Processing idx 9
> used_wrap_counter: 1
> svq->desc_state[id].ndescs: 1
> free_head: 0                                                             =
      <----- Update free_head to 0.
> last_used: 10                                                            =
      <----- Update last_used to 10.
> vq idx: 1                                                                =
      <----- End vhost_svq_get_buf_packed()
> i: 0                                                                     =
      <----- vhost_svq_flush()
> descriptor_len: 0
> elem->len: 22086
> i: 1
> elem_is_null: 1
> vq idx: 1                                                                =
      <----- End vhost_svq_flush()
>
> In QEMU, id 0 is added in idx 8. But it's marked as used before a
> descriptor can be added in idx 9. Because of this there's a discrepancy
> in the value of free_head and in svq->desc_next.
>
> In the current implementation, the values of ID are generated, maintained
> and processed by QEMU instead of reading from the guest's memory. I think
> reading the value of ID from the guest memory (similar to reading the
> descriptor length from guest memory) should resolve this issue.
>

Ok you made a good catch here :).

The 1:1 sync is hard to achieve as a single buffer in the guest may
need to be splitted in many buffers in the host.

> The alternative would be to ensure that "add_packed" and "get_buf_packed"
> are synchronized between the guest and QEMU.
>

Yes, they're synchronized. When the guest makes an available
descriptor, its head is saved in the VirtQueueElement of the SVQ's
head idx on svq->desc_state.

Reviewing patch 3/7 I see you're actually returning the id of the
first descriptor of the chain in *head, while it should be the id of
the *last* descriptor. It should not be the cause of the failure, as I
don't see any descriptor chain in the log. To keep the free linked
list happy we may need to store the head of the descriptor chain in
the vq too.

Now, why is SVQ id 0 being reused? Sounds like free_list is not
initialized to 0, 1, 2... but to something else like 0, 0, 0, etc. Can
you print the whole list in each iteration?

> What are your thoughts on this?
>
> Thanks,
> Sahil
>
>
>


