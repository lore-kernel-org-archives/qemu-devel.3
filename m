Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50E9C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5Ug-00050g-0Y; Tue, 21 Jul 2026 04:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wm5Ue-0004zj-6Z
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wm5UZ-0007zC-4l
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784621177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFJkTceATNhlEeBNPmDXU/6gPzuVSzu7MUPB+fQ2clM=;
 b=CLVlF3cYDyBn1DITIeDBx/F1UPFlbTadcE9OsSAEHdsVQ6CQ4zfnW8Y/YQyp4ZwfX+IEB5
 6YIhp/aCKyYppL00KU/alKjnUwVBR9+4iz0dYbfi5vKy4HhH78Us7mxpx4IQMnvK1Y9ivu
 D4X6gyjQ8lrwt/+l0jwcwB6htaioCHs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-pEbVGZ1ZOwOZubzhPaunlA-1; Tue, 21 Jul 2026 04:06:16 -0400
X-MC-Unique: pEbVGZ1ZOwOZubzhPaunlA-1
X-Mimecast-MFC-AGG-ID: pEbVGZ1ZOwOZubzhPaunlA_1784621175
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccafc5e82cso102376715ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784621175; cv=none;
 d=google.com; s=arc-20260327;
 b=DTw6qYbaVxbS2OhxSJk190Uzvk5YYlFUTAnu8RSqpp7o2+pDYtC7SwdCqDPqj5bh1I
 VvLWtQ1EtokFjaxgAnFFuG5Fyw5Zt0n/sBG1J7Ucj0Or+/YHC8UMjzC1pw5HFa9LMXz5
 LxKD+drgLgx4TlJJJwflgL1NTq2D8CnfdPR71GZyTugsnAdwpuNauy0pnss0VyG6TK2J
 zC8Zo38pyTgEvEtUFoYnEKYnwUC2tNzs+K3WhCn/Tbeqp86LiH8e3mhJ6kLiurtnU4Ev
 E53GMX/rspV89EEk81sEBZuvnYDnY4mYK7hCMRW1WPDpyxr7WkrprP+LR18z+HFj2hyN
 Qzfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MFJkTceATNhlEeBNPmDXU/6gPzuVSzu7MUPB+fQ2clM=;
 fh=tcUtymARzvXyjKJgvSO/fGskJYExRaJMWugb7/O7Ikc=;
 b=Fh1tUQtkVobnN4pzvFQJWbXXnNITUR/QM1eLzQTjreW3MnKI0UmOrFKGwPBeJByeIp
 Itppvz7zFDrWF7xKe3UoQfsTCTRZmhY+d64CPRpi0Ug5M7/gynZC0aXxXy9W+wHWe/lD
 oVbpNgwndu5jiQWkOdXKF/KI27h2Ook3l+X3MPkeuzVJmqLHPjxY+HqGOrbEdtlbzfFE
 w8EKFObhS/Q5h8VvUIdvb5tJ7tXkMtUyIBdHsg8qI+MJChaGpdAZPBC2TIO+k6n8yGhI
 TW/zhoERKRHkHtqpuLh8R8H5sRkFpoo+BZ7VU1oGPYCqcQ0H0PzXR0pycctwJLZK95/Q
 HTCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784621175; x=1785225975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MFJkTceATNhlEeBNPmDXU/6gPzuVSzu7MUPB+fQ2clM=;
 b=bxz1tvsAZUNPtiRAfN2rSiRky2eYStZ49ARu9nO6QI87oInN9+NKM+CUOC4Um9bPAq
 8zumxLqXCWwLemtmsxolrMR+bXrrNvKdYNGhf2vmO1X74XzrJCBgPOQytYTOijmzKIfT
 9cp1T+OcoeGfcyUq/oirDZUddwGVsWRP8kMjUK/30mvlr9j+Bh9aJ+sfqCtf/mHU8dkY
 2Ps2mjmnI+k6w3yIq7maF1Kd6u5u764Zfq9fLVpYt9aTD+d6H7oNlgiCuQ2p6sTTUzC+
 SvxCfFqH6NJ6qnA0Q3tUerM741q+z6WBheYjdivG669QZw2GdVWAGehKGfBEKu3CtSPU
 2wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784621175; x=1785225975;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MFJkTceATNhlEeBNPmDXU/6gPzuVSzu7MUPB+fQ2clM=;
 b=eHFnfmcspx9zkSnBzMEguWPn5gRFKY447S06iv5+TSSYSgdbbjkrCRf+gMxwRHu/nD
 NIHN9IqDD/E39Y62KIDuaOaN8PbzXtP3mT6ZTG5CKD0xgjBHSRKWosqR1PdFNaUzzPdR
 4gdZYa42X9wSCCdoqxpuAgiklHSr9uPs+gwhXcGQv/I7Lmhqrxp4QaCX5OFB1N/1MoUl
 oWVvcJoc1iAagKrIR7RlUsq7sjdRzKylikdpbPuGgF9ln6HmflDgRoebcgQ3OsL6+pmT
 0I2fgYOXa/AdinfiUF885LXi59USbWTGDr6kHOu5BIW7jxDW6jOFVjguC7y7L848Tu4F
 Pa2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEl2Uj2Mo098QzXE3ggeVuuF2nBLi7gF5PKfqERcj3yhOuN5IZCIST0Ow6VgZ8f/RTC2R610Un8TBG@nongnu.org
X-Gm-Message-State: AOJu0YyyVRDGt3wXrCB0XolGOS+uNH0Kz5wq/w5DHb8Wn/o536EcXw98
 P/k9/WleUL5cZVbrc7k2+Lwf3RChnqrh3OXWBHbBXEELBEFuqlgd/G9Dpmvcq3URO9ZioNwTfZ7
 ZB/D+SAB6cs/AjGL1TXK4NtPns8bHH7mYWxnRZtGZ7MKO1sMsfXqQ+usehK2A6Y7auchD9VE/+B
 X2/uZOwB5MqBnHwy/VDwvX7LX+XleQ678=
X-Gm-Gg: AR+sD13wAjB/U7rXfFLwQpqrBAng+GQL67SuIgkoNnzS1rNjAugQ4Fc5e0h37rkR0iQ
 SXPcosBzpaZfaaAhJz4fkpDovcvtWUPgxYMNZQfKDIF1KT6kY2cbMuOmY+pUWV3jdsqTvPFKyvZ
 EbD5nCcHAcgtRz8o9+xjeGOHx3D6oz9DoXJ687Nli/ZSpds6zicnewQldUTPgTuoVFux2JMNae+
 2yr01BaRZBjc5OjIabvuE4qVvwfuXIMkKdLS7G0fJfKZ8jjMneBC7st3N51+kkvfXfsV2E0V0T9
 CA==
X-Received: by 2002:a17:903:240e:b0:2c9:97a7:f540 with SMTP id
 d9443c01a7336-2cf349fe337mr199883405ad.38.1784621175008; 
 Tue, 21 Jul 2026 01:06:15 -0700 (PDT)
X-Received: by 2002:a17:903:240e:b0:2c9:97a7:f540 with SMTP id
 d9443c01a7336-2cf349fe337mr199882915ad.38.1784621174504; Tue, 21 Jul 2026
 01:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-7-fabb4db3c204@redhat.com>
 <7970030.EvYhyI6sBW@weasel>
 <7790107e-1256-4ed8-ba49-cab980197938@oss.qualcomm.com>
 <5af0aaf1-d372-4800-9f6f-8f5dacd8c69e@oss.qualcomm.com>
 <CAMxuvaxREAH4K45UYeC6PK5fnYXTZW9nitRApMdtaxOC6rPDow@mail.gmail.com>
In-Reply-To: <CAMxuvaxREAH4K45UYeC6PK5fnYXTZW9nitRApMdtaxOC6rPDow@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Jul 2026 12:06:03 +0400
X-Gm-Features: AUfX_myozeXoOdlqc3QvGx1Q5TVqdta-D4KlWqih7qFuon5PGsySMNcqHkMbr2o
Message-ID: <CAMxuvaySONs4r=1Bmsao1f1cZdviGGwPVM8+1Q+1vdY0X-pYVw@mail.gmail.com>
Subject: Re: [PATCH 7/8] hw/9pfs: annotate V9fsTransport callbacks as
 coroutine_fn
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Denis V. Lunev" <den@openvz.org>, 
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, xen-devel@lists.xenproject.org,
 Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=mlureau@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 21, 2026 at 11:58=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Tue, Jul 21, 2026 at 12:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> <philmd@oss.qualcomm.com> wrote:
> >
> > On 20/7/26 22:42, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > > On 20/7/26 16:02, Christian Schoenebeck wrote:
> > >> On Monday, 20 July 2026 09:55:36 CEST Marc-Andr=C3=A9 Lureau wrote:
> > >>> All V9fsTransport callbacks are invoked exclusively from coroutine
> > >>> context (the v9fs_* PDU handlers). Annotate the function pointer
> > >>> types in V9fsTransport and all implementations (virtio and xen
> > >>> backends), as well as intermediate callers in 9p.c (pdu_marshal,
> > >>> pdu_unmarshal, v9fs_init_qiov_from_pdu, etc.).
> > >>>
> > >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >>> ---
> > >>>   hw/9pfs/9p.h               | 26 +++++++++++++++-----------
> > >>>   hw/9pfs/9p.c               | 31 +++++++++++++++++++------------
> > >>>   hw/9pfs/virtio-9p-device.c | 24 +++++++++++++-----------
> > >>>   hw/9pfs/xen-9p-backend.c   | 34 +++++++++++++++++----------------=
-
> > >>>   4 files changed, 64 insertions(+), 51 deletions(-)
> > >>>
> > >>> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > >>> index 1a309664f6e..0e52ffbdf38 100644
> > >>> --- a/hw/9pfs/9p.h
> > >>> +++ b/hw/9pfs/9p.h
> > >>> @@ -472,17 +472,21 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hd=
r);
> > >>>   void v9fs_reset(V9fsState *s);
> > >>>
> > >>>
> > >>>   struct V9fsTransport {
> > >>> -    ssize_t     (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset, const
> > >>> char *fmt,
> > >>> -                                va_list ap);
> > >>> -    ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, con=
st
> > >>> char *fmt,
> > >>> -                                  va_list ap);
> > >>> -    void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec
> > >>> **piov,
> > >>> -                                        unsigned int *pniov, size_=
t
> > >>> size);
> > >>> -    void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iove=
c
> > >>> **piov,
> > >>> -                                         unsigned int *pniov, size=
_t
> > >>> size);
> > >>> -    void        (*push_and_notify)(V9fsPDU *pdu);
> > >>> -    size_t      (*msize_limit)(V9fsState *s);
> > >>> -    size_t      (*response_buffer_size)(V9fsPDU *pdu);
> > >>> +    ssize_t     coroutine_fn (*pdu_vmarshal)(V9fsPDU *pdu, size_t
> > >>> offset,
> > >>> +                                             const char *fmt,
> > >>> va_list ap);
> > >>> +    ssize_t     coroutine_fn (*pdu_vunmarshal)(V9fsPDU *pdu, size_=
t
> > >>> offset,
> > >>> +                                               const char *fmt,
> > >>> va_list ap);
> > >>> +    void        coroutine_fn (*init_in_iov_from_pdu)(V9fsPDU *pdu,
> > >>> +                                                     struct iovec
> > >>> **piov,
> > >>> +                                                     unsigned int
> > >>> *pniov,
> > >>> +                                                     size_t size);
> > >>> +    void        coroutine_fn (*init_out_iov_from_pdu)(V9fsPDU *pdu=
,
> > >>> +                                                      struct iovec
> > >>> **piov,
> > >>> +                                                      unsigned int
> > >>> *pniov,
> > >>> +                                                      size_t size)=
;
> > >>> +    void        coroutine_fn (*push_and_notify)(V9fsPDU *pdu);
> > >>> +    size_t      coroutine_fn (*msize_limit)(V9fsState *s);
> > >>> +    size_t      coroutine_fn (*response_buffer_size)(V9fsPDU *pdu)=
;
> > >>>   };
> > >>
> > >> I wonder whether that could be made more diff/blame-friendly.
> > >> Especially as
> > >> this currently only serves documentation purposes.
> > >>
> > >> They way you are positioning coroutine_fn it usually resolves to an
> > >> attribute
> > >> attached to the function's return type, not to the function itself, =
even
> > >> though clang/gcc handling it flexible. For attaching an attribute to=
 the
> > >> function itself the attribute should either be attached before the
> > >> function
> > >> declaration or after the function declaration.
> > >
> > > I tend to aggree it would be clearer to have these attributes /before=
/
> > > the function prototype declaration.
> >
> > $ git grep -E '^(static )?coroutine_(mixed_)?fn' | wc -l
> >        90
>
> More like
> $  git grep -rnE '\b(coroutine_fn|co_wrapper[a-z_]*)\b' | wc -l
> 1343
>

That matching is not accurate, it's actually hard enough to match all
annotations instances.. but this should be a rough estimation.

> most of them are "return-type co_annotation fn(..)"
> we even have scripts/block-coroutine-wrapper.py that relies and
> produce this order..
> a bit late to change the style imho...
>
> At least, let's not make this a requirement for this series, please
>
> >> block/block-copy.c:47:static coroutine_fn int
> > block_copy_task_entry(AioTask *task);
> > block/copy-before-write.c:106:static coroutine_fn int
> > cbw_do_copy_before_write(BlockDriverState *bs,
> > block/nvme.c:1351:static coroutine_fn int nvme_co_flush(BlockDriverStat=
e
> > *bs)
> > block/ssh.c:1223:static coroutine_fn int ssh_flush(BDRVSSHState *s,
> > BlockDriverState *bs)
> > nbd/server.c:3077:static coroutine_fn void nbd_trip(void *opaque)
> > block/block-copy.c:581:static coroutine_fn int
> > block_copy_task_entry(AioTask *task)
> > ...
> >
> > >
> > >> In both cases you could then
> > >> add it to its own, separate line, avoiding a lot of noise.
> > >>
> > >> /Christian
> > >>
> > >>
> > >>
> > >>
> > >
> > >
> >


