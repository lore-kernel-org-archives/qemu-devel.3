Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E51CC4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 02:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra4p2-0002ey-Es; Tue, 13 Feb 2024 21:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1ra4p1-0002ep-2n
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 21:16:27 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1ra4ou-0004Qz-Vt
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 21:16:26 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d0e521de4eso46063441fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 18:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707876974; x=1708481774; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5V6FpyFPQ7E0ae5GNa4iGILabDfaZQIL9Hpwr2R0pDY=;
 b=kMfJJt3sCrTXLfNAQ751vIAYC4DZ5fFpFySuCX2fXh/C/7SqopGgY3sROA7VM1QcX3
 8W4Y2QVuyOw/VRTc2ZlwnkYkQ2OKuPRn94mC9H5CBnxpms1hIwFoHJgf7gqer9hEW3xN
 G3MCvHGTvJ8eP5Bz94/jROdzRWIvrBUHi4/31oeaz2uhn1d6cx6a3RgF6NDRmvocp8fS
 W+AIYIR4Bvi7EGBsFcM0GVwoUI/PciYXeG5OCt+XdIiXuTDoyTggAReAeawtbNR1d48f
 fcUtETBtpzEnZQ9yKp5ml1ghF+xNcuQGRqTHRIicjiO8TYuXiUvEfFdw+kCcj8/bcs/o
 i4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707876974; x=1708481774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5V6FpyFPQ7E0ae5GNa4iGILabDfaZQIL9Hpwr2R0pDY=;
 b=NYDPz05FwuT8+ZchnkqKYkN9QjnJLaJAmuUOKGu4WEwWFkicGH4gI7yBsO6ajnSjAn
 r7JkdBq98bvu+7d2oN2ZQl6vjQe3jL/2wc2t1rKF6WOduGpX3LUCx+LGS2958REslCGc
 swkHrH9lSwQunv2BKS682Nz+UFhtco0aiCw5amIYoVCeojFPYjj67kAvV5Xbcp410v1G
 LFSLIWTp7AFFINIBgu9Mf9Dq14bb11K+c1zd62iS2u103rn2cEqS4NH/oYpQsKPFUPcA
 rlZo+Q7tto9XOOYboBkksvWAfPHJsATiiawtgEbyTqtxUQsoL4Rfd1s5g7baiQQR69cw
 BZMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1NlwpNb0bEziGIrGNWIXZQiZYitwZ+aONUe8hMCDxVxa3dWGK2XmIVBVySgTv3sStVXs1NjxJW/JxmSpesH6ZGzlN9dI=
X-Gm-Message-State: AOJu0YxmszO1ZiwKqnL7jDGhZJotjrpNyFyUDhDTKEB3ciJlmXv/Wwon
 SXzG45JUN3203JChkNQzhsOvyR3fcLzZoNJ/h1yGIwClY/imC4/vg5wO6OBZQoz5d6dcKZS7XJ5
 iO2pt3q0k/OwGckpc5sW7DzVsRV9jt8zzaA5q7Q==
X-Google-Smtp-Source: AGHT+IEcJ2d20O7DyZyxCpsTCnxRtu2+gwJZug1hsrPYEyAWvgEH445hnKHrp3KkP8ElN/GPghsoOBBHg17Hk89abHs=
X-Received: by 2002:a05:651c:2106:b0:2d1:1911:e704 with SMTP id
 a6-20020a05651c210600b002d11911e704mr331529ljq.38.1707876974445; Tue, 13 Feb
 2024 18:16:14 -0800 (PST)
MIME-Version: 1.0
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-6-peterx@redhat.com>
 <CAAYibXiZ-c5zQutHHvL6-bO2yotPX=LQOmjj=HhhwmrAHc+2dA@mail.gmail.com>
 <871q9lde2o.fsf@suse.de>
In-Reply-To: <871q9lde2o.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Tue, 13 Feb 2024 18:16:03 -0800
Message-ID: <CAAYibXgbMvo98whxNUCU6gGOrff0ZSGn1bCS-vjSeuS=2YXidg@mail.gmail.com>
Subject: Re: [External] [PATCH v2 05/23] migration/multifd: Drop
 MultiFDSendParams.normal[] array
To: Fabiano Rosas <farosas@suse.de>
Cc: peterx@redhat.com, qemu-devel@nongnu.org, 
 Bryan Zhang <bryan.zhang@bytedance.com>, Avihai Horon <avihaih@nvidia.com>, 
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 9, 2024 at 4:20=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > On Fri, Feb 2, 2024 at 2:30=E2=80=AFAM <peterx@redhat.com> wrote:
> >>
> >> From: Peter Xu <peterx@redhat.com>
> >>
> >> This array is redundant when p->pages exists.  Now we extended the lif=
e of
> >> p->pages to the whole period where pending_job is set, it should be sa=
fe to
> >> always use p->pages->offset[] rather than p->normal[].  Drop the array=
.
> >>
> >> Alongside, the normal_num is also redundant, which is the same to
> >> p->pages->num.
> >
> > Can we not drop p->normal and p_normal_num? It is redundant now but I
> > think it will be needed for multifd zero page checking. In multifd
> > zero page, we find out all zero pages and we sort the normal pages and
> > zero pages in two seperate arrays. p->offset is the original array of
> > pages, p->normal will contain the array of normal pages and p->zero
> > will contain the array of zero pages.
>
> We're moving send_fill_packet into send_prepare(), so you should be able
> to do whatever data transformation at send_prepare() and add any fields
> you need into p->pages.
>
> If we keep p->normal we will not be able to switch into an opaque
> payload later on. There should be no mention of pages outside of
> hooks. This is long-term work, but let's avoid blocking it if possible.
>

Got it. I will make the proper changes.

Aside from that, I would like to get opinions from you guys regarding
zero page detection interface.
Here are the options I am thinking:
1) Do zero page detection in send_prepare().
This means no dedicated hook for zero_page_detection() otherwise we
will be calling a hook from inside a hook. But we will need a new
function multifd_zero_page_check_send() similar to how we use
multifd_send_fill_packet() now. multifd_zero_page_check_send() will
need to be called by all send_prepare() implementations.
2) Do zero page detection in a new hook zero_page_detection().
zero_page_detection will be called before send_prepare(). Seems like
extra complexity but I can go with that routine if you guys think it's
a cleaner way.

I am leaning towards 1) right now.

> >>
> >> This doesn't apply to recv side, because there's no extra buffering on=
 recv
> >> side, so p->normal[] array is still needed.
> >>
> >> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  migration/multifd.h      |  4 ----
> >>  migration/multifd-zlib.c |  7 ++++---
> >>  migration/multifd-zstd.c |  7 ++++---
> >>  migration/multifd.c      | 33 +++++++++++++--------------------
> >>  4 files changed, 21 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/migration/multifd.h b/migration/multifd.h
> >> index 7c040cb85a..3920bdbcf1 100644
> >> --- a/migration/multifd.h
> >> +++ b/migration/multifd.h
> >> @@ -122,10 +122,6 @@ typedef struct {
> >>      struct iovec *iov;
> >>      /* number of iovs used */
> >>      uint32_t iovs_num;
> >> -    /* Pages that are not zero */
> >> -    ram_addr_t *normal;
> >> -    /* num of non zero pages */
> >> -    uint32_t normal_num;
> >>      /* used for compression methods */
> >>      void *data;
> >>  }  MultiFDSendParams;
> >> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> >> index 37ce48621e..100809abc1 100644
> >> --- a/migration/multifd-zlib.c
> >> +++ b/migration/multifd-zlib.c
> >> @@ -116,17 +116,18 @@ static void zlib_send_cleanup(MultiFDSendParams =
*p, Error **errp)
> >>   */
> >>  static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
> >>  {
> >> +    MultiFDPages_t *pages =3D p->pages;
> >>      struct zlib_data *z =3D p->data;
> >>      z_stream *zs =3D &z->zs;
> >>      uint32_t out_size =3D 0;
> >>      int ret;
> >>      uint32_t i;
> >>
> >> -    for (i =3D 0; i < p->normal_num; i++) {
> >> +    for (i =3D 0; i < pages->num; i++) {
> >>          uint32_t available =3D z->zbuff_len - out_size;
> >>          int flush =3D Z_NO_FLUSH;
> >>
> >> -        if (i =3D=3D p->normal_num - 1) {
> >> +        if (i =3D=3D pages->num - 1) {
> >>              flush =3D Z_SYNC_FLUSH;
> >>          }
> >>
> >> @@ -135,7 +136,7 @@ static int zlib_send_prepare(MultiFDSendParams *p,=
 Error **errp)
> >>           * with compression. zlib does not guarantee that this is saf=
e,
> >>           * therefore copy the page before calling deflate().
> >>           */
> >> -        memcpy(z->buf, p->pages->block->host + p->normal[i], p->page_=
size);
> >> +        memcpy(z->buf, p->pages->block->host + pages->offset[i], p->p=
age_size);
> >>          zs->avail_in =3D p->page_size;
> >>          zs->next_in =3D z->buf;
> >>
> >> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> >> index b471daadcd..2023edd8cc 100644
> >> --- a/migration/multifd-zstd.c
> >> +++ b/migration/multifd-zstd.c
> >> @@ -113,6 +113,7 @@ static void zstd_send_cleanup(MultiFDSendParams *p=
, Error **errp)
> >>   */
> >>  static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
> >>  {
> >> +    MultiFDPages_t *pages =3D p->pages;
> >>      struct zstd_data *z =3D p->data;
> >>      int ret;
> >>      uint32_t i;
> >> @@ -121,13 +122,13 @@ static int zstd_send_prepare(MultiFDSendParams *=
p, Error **errp)
> >>      z->out.size =3D z->zbuff_len;
> >>      z->out.pos =3D 0;
> >>
> >> -    for (i =3D 0; i < p->normal_num; i++) {
> >> +    for (i =3D 0; i < pages->num; i++) {
> >>          ZSTD_EndDirective flush =3D ZSTD_e_continue;
> >>
> >> -        if (i =3D=3D p->normal_num - 1) {
> >> +        if (i =3D=3D pages->num - 1) {
> >>              flush =3D ZSTD_e_flush;
> >>          }
> >> -        z->in.src =3D p->pages->block->host + p->normal[i];
> >> +        z->in.src =3D p->pages->block->host + pages->offset[i];
> >>          z->in.size =3D p->page_size;
> >>          z->in.pos =3D 0;
> >>
> >> diff --git a/migration/multifd.c b/migration/multifd.c
> >> index 5633ac245a..8bb1fd95cf 100644
> >> --- a/migration/multifd.c
> >> +++ b/migration/multifd.c
> >> @@ -90,13 +90,13 @@ static int nocomp_send_prepare(MultiFDSendParams *=
p, Error **errp)
> >>  {
> >>      MultiFDPages_t *pages =3D p->pages;
> >>
> >> -    for (int i =3D 0; i < p->normal_num; i++) {
> >> -        p->iov[p->iovs_num].iov_base =3D pages->block->host + p->norm=
al[i];
> >> +    for (int i =3D 0; i < pages->num; i++) {
> >> +        p->iov[p->iovs_num].iov_base =3D pages->block->host + pages->=
offset[i];
> >>          p->iov[p->iovs_num].iov_len =3D p->page_size;
> >>          p->iovs_num++;
> >>      }
> >>
> >> -    p->next_packet_size =3D p->normal_num * p->page_size;
> >> +    p->next_packet_size =3D pages->num * p->page_size;
> >>      p->flags |=3D MULTIFD_FLAG_NOCOMP;
> >>      return 0;
> >>  }
> >> @@ -269,21 +269,22 @@ static void multifd_pages_clear(MultiFDPages_t *=
pages)
> >>  static void multifd_send_fill_packet(MultiFDSendParams *p)
> >>  {
> >>      MultiFDPacket_t *packet =3D p->packet;
> >> +    MultiFDPages_t *pages =3D p->pages;
> >>      int i;
> >>
> >>      packet->flags =3D cpu_to_be32(p->flags);
> >>      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
> >> -    packet->normal_pages =3D cpu_to_be32(p->normal_num);
> >> +    packet->normal_pages =3D cpu_to_be32(pages->num);
> >>      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
> >>      packet->packet_num =3D cpu_to_be64(p->packet_num);
> >>
> >> -    if (p->pages->block) {
> >> -        strncpy(packet->ramblock, p->pages->block->idstr, 256);
> >> +    if (pages->block) {
> >> +        strncpy(packet->ramblock, pages->block->idstr, 256);
> >>      }
> >>
> >> -    for (i =3D 0; i < p->normal_num; i++) {
> >> +    for (i =3D 0; i < pages->num; i++) {
> >>          /* there are architectures where ram_addr_t is 32 bit */
> >> -        uint64_t temp =3D p->normal[i];
> >> +        uint64_t temp =3D pages->offset[i];
> >>
> >>          packet->offset[i] =3D cpu_to_be64(temp);
> >>      }
> >> @@ -570,8 +571,6 @@ void multifd_save_cleanup(void)
> >>          p->packet =3D NULL;
> >>          g_free(p->iov);
> >>          p->iov =3D NULL;
> >> -        g_free(p->normal);
> >> -        p->normal =3D NULL;
> >>          multifd_send_state->ops->send_cleanup(p, &local_err);
> >>          if (local_err) {
> >>              migrate_set_error(migrate_get_current(), local_err);
> >> @@ -688,8 +687,8 @@ static void *multifd_send_thread(void *opaque)
> >>
> >>          if (p->pending_job) {
> >>              uint64_t packet_num =3D p->packet_num;
> >> +            MultiFDPages_t *pages =3D p->pages;
> >>              uint32_t flags;
> >> -            p->normal_num =3D 0;
> >>
> >>              if (use_zero_copy_send) {
> >>                  p->iovs_num =3D 0;
> >> @@ -697,12 +696,7 @@ static void *multifd_send_thread(void *opaque)
> >>                  p->iovs_num =3D 1;
> >>              }
> >>
> >> -            for (int i =3D 0; i < p->pages->num; i++) {
> >> -                p->normal[p->normal_num] =3D p->pages->offset[i];
> >> -                p->normal_num++;
> >> -            }
> >> -
> >> -            if (p->normal_num) {
> >> +            if (pages->num) {
> >>                  ret =3D multifd_send_state->ops->send_prepare(p, &loc=
al_err);
> >>                  if (ret !=3D 0) {
> >>                      qemu_mutex_unlock(&p->mutex);
> >> @@ -713,10 +707,10 @@ static void *multifd_send_thread(void *opaque)
> >>              flags =3D p->flags;
> >>              p->flags =3D 0;
> >>              p->num_packets++;
> >> -            p->total_normal_pages +=3D p->normal_num;
> >> +            p->total_normal_pages +=3D pages->num;
> >>              qemu_mutex_unlock(&p->mutex);
> >>
> >> -            trace_multifd_send(p->id, packet_num, p->normal_num, flag=
s,
> >> +            trace_multifd_send(p->id, packet_num, pages->num, flags,
> >>                                 p->next_packet_size);
> >>
> >>              if (use_zero_copy_send) {
> >> @@ -924,7 +918,6 @@ int multifd_save_setup(Error **errp)
> >>          p->name =3D g_strdup_printf("multifdsend_%d", i);
> >>          /* We need one extra place for the packet header */
> >>          p->iov =3D g_new0(struct iovec, page_count + 1);
> >> -        p->normal =3D g_new0(ram_addr_t, page_count);
> >>          p->page_size =3D qemu_target_page_size();
> >>          p->page_count =3D page_count;
> >>
> >> --
> >> 2.43.0
> >>

