Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3140AC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5Ne-0002ZR-1u; Tue, 21 Jul 2026 03:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wm5Nc-0002XP-Jk
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wm5Na-0006xB-OH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784620744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lX2v55AGr51x0YaynLTMtlaht0Z2HEPzcmY3IeqlbTk=;
 b=fYu6XDG/d2NNqYlzxVK/DZGfB6qc/C/utZ6hg3o0F5p5uv/XXa8VLOtxa9EZnYgvaFABBE
 69Rc99u8tkxL0mJg81OYr6B5S2mrIvw2vhICJj+3tDAwi4IQPBch0vfGOmUO9Gv8LUoOxB
 SdYoqvFiKpwJqg999baNmPON5NnuylI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-rM9ydSmiP2GrpNu7_f10gg-1; Tue, 21 Jul 2026 03:59:03 -0400
X-MC-Unique: rM9ydSmiP2GrpNu7_f10gg-1
X-Mimecast-MFC-AGG-ID: rM9ydSmiP2GrpNu7_f10gg_1784620742
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cec4226c70so176042115ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 00:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784620742; cv=none;
 d=google.com; s=arc-20260327;
 b=r094n7g1LGlEzGT71u9AJQ9B1VAzhkqMTYUZdwn/QoVCJGvVazbLQsxJcWbekFdk7U
 lILzkGcblxv18vJdjeEXYVwjy5vCwIFfz+MhRQyErhI9E0DROF/+YPsfW3n07s8hCmU9
 6cYz5CPEsS/p3I/YnCIgrtGUS1zSqxdWIFLBUN5FYj2315NLtZb7n1hHnV3GEBGCHGkt
 y03yDDd8ZimEt57/lqyDvYBRg/+UlI5r38TtsCfoWeQ2sYfgXBYDZaFKPCYUzPwSKXRO
 lnXq5W1E0blopX/EItOp6QJH4THsSxt3XxV80jP1VQW5TW9M3DOEk5Ld4mreXw1dI/Aw
 R6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lX2v55AGr51x0YaynLTMtlaht0Z2HEPzcmY3IeqlbTk=;
 fh=+bVwEW/7mQJjEj7MNZVnCO4j6Z6LDWLpoZP2xH3QkJs=;
 b=r2orrM/swyQfD3tnzT7ZHWMn5xYm+ggG9Fo1JEyHKos+FvUe2gtHJ+C/01YwXO6MJO
 Q7XPglKVNYzxGpZRcZGspS2rWDrC142drfzw/eS4g6/BYcbNMKST6XbH3KQ+qOLsjZJx
 /NCmqvpb8Q9goauol5JYqxpB0FUutBBsDCvy80yf5vmjGW3fM+1LiGuKbs1ZKr4qGF0u
 YiQAnRdIv2Nl1lb6Kw6lXs91SBPUpymu6xpWLWq9Dz6Tts2np3hiL6XQD1NKd6E81Lqe
 YfCRpqOBj+CycT0Swvy+IGp5ZomB+73v32njM6okxE+/oo6bvna1Zbz3i0S9O1l7sB8v
 ylxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784620742; x=1785225542; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lX2v55AGr51x0YaynLTMtlaht0Z2HEPzcmY3IeqlbTk=;
 b=gUwTu4HGydn95Dbfrx9C/qodVoEvqdvlU+29ak/ROGmeipae20OaKcigMXTtqKKIXY
 cgOzCUU6PxnqRudZhAsZqlpZCNJjudxzkOysoGvE1e8QHqJBtdruQ20LSMzueMvJX1+s
 wgoxiy8kclwAOZuJTxo3aOKkdW6SODtGDJbGsteFPDT34oz/nao0OOf8/dsWF+V/oMvG
 MezaLQfDPdzwkKu1KlOcAedu6rwrz1FLrBdfht9pjNWk5kTo1aHOl+7h6DUUuK4j88oO
 EDIk2aE6e/Xi0ozPgyWDV3ppS3NOXAg9bxDlP5tlMr/SB8zly8D1LkR7aV+GTMUUwScz
 FfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784620742; x=1785225542;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lX2v55AGr51x0YaynLTMtlaht0Z2HEPzcmY3IeqlbTk=;
 b=CapL6u6adDn2VMVZ3Y0xeQy2oGtbNRuDQ07LyS4EtI8Bx3VA1VsAzjwrSe6nJ+XfE4
 n5ZyaIFPJSpUhJxL6rprGf1SyadlZZVpaEFaEq9eIAcyQMPwpm5wWdc/dWjsq0gDnOUw
 j49IO39ie2jNhwlWhh9wj4r5Z6sxri0kLceC34qyZ0+T68grsBjbld1qdDWuLOaT9hLS
 ymHOCiv4ZTJNLd6T8ZsI52/d5517WFONx73zCqgBYt5viK92QMRQ26gSghOKyi2W59FL
 F1IV+nUsZyw9PIMVOhyQ2zs0Rqqsdzx3osLRll2ZuGbx/oLNpu9vt1aBzFHPPrf+liEG
 P4Vg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrx4/TfaU8S1DowrGGqcnsFamFVE9xAZuK/CLboYTSYqUfwP5WNcgDMjY72tGGp1mJKFIjDIsXiDd5V@nongnu.org
X-Gm-Message-State: AOJu0YxBJPfJwfLui2eud5lDC6cpM2+4oLK7dbrE9FQc8WnEWheyQr15
 W+Qvzp+Qx/IAMiwwFAPRUbCo1VqH3N//0yFNyr69ky1/7O5gH3K1p/5C/YLrTtA3+XCJIAYr1Y/
 Ny/UcMxtrcgllwsBsCXQ08jFNkxhOwjCl4EchOWQVOczLCBHPsPserjPVA3PbeSGD+IDzoaGurP
 D+8uGu5df+XD4ycfCE8ACsawbPDOiv5Cc=
X-Gm-Gg: AR+sD11gVz7W48zxcheRpA9bW4vDI4Cs4e3ZIPqdeEGBfStPhGqQocYjHgXCC97/Ezh
 0KZzYodRNiRkjsW5j9etYpVtqOHzJwbouVPHxAopD86s4U6wOomoYiVCp5U9eBYgICMVz4TcTCp
 RJMik0ztKp+JUTCX2TJ+L159nygIGZaSn+U/njhfF9GPClmIpjvJn/4n9bIdX0kJq/A+5sZvKcg
 +jyT0q9kyNmAx8TrgasJ/N67eoRLnZyROUVjxyXra9ixcGzi9V5MG0TNpcVNAFSalsba6p9Z7qP
 Cg==
X-Received: by 2002:a17:903:26c6:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2cf34819447mr189668175ad.6.1784620741834; 
 Tue, 21 Jul 2026 00:59:01 -0700 (PDT)
X-Received: by 2002:a17:903:26c6:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2cf34819447mr189667725ad.6.1784620741041; Tue, 21 Jul 2026
 00:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-7-fabb4db3c204@redhat.com>
 <7970030.EvYhyI6sBW@weasel>
 <7790107e-1256-4ed8-ba49-cab980197938@oss.qualcomm.com>
 <5af0aaf1-d372-4800-9f6f-8f5dacd8c69e@oss.qualcomm.com>
In-Reply-To: <5af0aaf1-d372-4800-9f6f-8f5dacd8c69e@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Jul 2026 11:58:49 +0400
X-Gm-Features: AUfX_mwkaLQEM0pLlT2VIiuWIGldOYBZqIvCk6ao2O3sK_TvcA9Cj7tuBTxYDnE
Message-ID: <CAMxuvaxREAH4K45UYeC6PK5fnYXTZW9nitRApMdtaxOC6rPDow@mail.gmail.com>
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
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=mlureau@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 21, 2026 at 12:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 20/7/26 22:42, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > On 20/7/26 16:02, Christian Schoenebeck wrote:
> >> On Monday, 20 July 2026 09:55:36 CEST Marc-Andr=C3=A9 Lureau wrote:
> >>> All V9fsTransport callbacks are invoked exclusively from coroutine
> >>> context (the v9fs_* PDU handlers). Annotate the function pointer
> >>> types in V9fsTransport and all implementations (virtio and xen
> >>> backends), as well as intermediate callers in 9p.c (pdu_marshal,
> >>> pdu_unmarshal, v9fs_init_qiov_from_pdu, etc.).
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>>   hw/9pfs/9p.h               | 26 +++++++++++++++-----------
> >>>   hw/9pfs/9p.c               | 31 +++++++++++++++++++------------
> >>>   hw/9pfs/virtio-9p-device.c | 24 +++++++++++++-----------
> >>>   hw/9pfs/xen-9p-backend.c   | 34 +++++++++++++++++-----------------
> >>>   4 files changed, 64 insertions(+), 51 deletions(-)
> >>>
> >>> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> >>> index 1a309664f6e..0e52ffbdf38 100644
> >>> --- a/hw/9pfs/9p.h
> >>> +++ b/hw/9pfs/9p.h
> >>> @@ -472,17 +472,21 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)=
;
> >>>   void v9fs_reset(V9fsState *s);
> >>>
> >>>
> >>>   struct V9fsTransport {
> >>> -    ssize_t     (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset, const
> >>> char *fmt,
> >>> -                                va_list ap);
> >>> -    ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const
> >>> char *fmt,
> >>> -                                  va_list ap);
> >>> -    void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec
> >>> **piov,
> >>> -                                        unsigned int *pniov, size_t
> >>> size);
> >>> -    void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec
> >>> **piov,
> >>> -                                         unsigned int *pniov, size_t
> >>> size);
> >>> -    void        (*push_and_notify)(V9fsPDU *pdu);
> >>> -    size_t      (*msize_limit)(V9fsState *s);
> >>> -    size_t      (*response_buffer_size)(V9fsPDU *pdu);
> >>> +    ssize_t     coroutine_fn (*pdu_vmarshal)(V9fsPDU *pdu, size_t
> >>> offset,
> >>> +                                             const char *fmt,
> >>> va_list ap);
> >>> +    ssize_t     coroutine_fn (*pdu_vunmarshal)(V9fsPDU *pdu, size_t
> >>> offset,
> >>> +                                               const char *fmt,
> >>> va_list ap);
> >>> +    void        coroutine_fn (*init_in_iov_from_pdu)(V9fsPDU *pdu,
> >>> +                                                     struct iovec
> >>> **piov,
> >>> +                                                     unsigned int
> >>> *pniov,
> >>> +                                                     size_t size);
> >>> +    void        coroutine_fn (*init_out_iov_from_pdu)(V9fsPDU *pdu,
> >>> +                                                      struct iovec
> >>> **piov,
> >>> +                                                      unsigned int
> >>> *pniov,
> >>> +                                                      size_t size);
> >>> +    void        coroutine_fn (*push_and_notify)(V9fsPDU *pdu);
> >>> +    size_t      coroutine_fn (*msize_limit)(V9fsState *s);
> >>> +    size_t      coroutine_fn (*response_buffer_size)(V9fsPDU *pdu);
> >>>   };
> >>
> >> I wonder whether that could be made more diff/blame-friendly.
> >> Especially as
> >> this currently only serves documentation purposes.
> >>
> >> They way you are positioning coroutine_fn it usually resolves to an
> >> attribute
> >> attached to the function's return type, not to the function itself, ev=
en
> >> though clang/gcc handling it flexible. For attaching an attribute to t=
he
> >> function itself the attribute should either be attached before the
> >> function
> >> declaration or after the function declaration.
> >
> > I tend to aggree it would be clearer to have these attributes /before/
> > the function prototype declaration.
>
> $ git grep -E '^(static )?coroutine_(mixed_)?fn' | wc -l
>        90

More like
$  git grep -rnE '\b(coroutine_fn|co_wrapper[a-z_]*)\b' | wc -l
1343

most of them are "return-type co_annotation fn(..)"
we even have scripts/block-coroutine-wrapper.py that relies and
produce this order..
a bit late to change the style imho...

At least, let's not make this a requirement for this series, please

>> block/block-copy.c:47:static coroutine_fn int
> block_copy_task_entry(AioTask *task);
> block/copy-before-write.c:106:static coroutine_fn int
> cbw_do_copy_before_write(BlockDriverState *bs,
> block/nvme.c:1351:static coroutine_fn int nvme_co_flush(BlockDriverState
> *bs)
> block/ssh.c:1223:static coroutine_fn int ssh_flush(BDRVSSHState *s,
> BlockDriverState *bs)
> nbd/server.c:3077:static coroutine_fn void nbd_trip(void *opaque)
> block/block-copy.c:581:static coroutine_fn int
> block_copy_task_entry(AioTask *task)
> ...
>
> >
> >> In both cases you could then
> >> add it to its own, separate line, avoiding a lot of noise.
> >>
> >> /Christian
> >>
> >>
> >>
> >>
> >
> >
>


