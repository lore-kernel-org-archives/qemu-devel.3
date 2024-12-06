Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D73E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYn0-0008Jo-Tg; Fri, 06 Dec 2024 08:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tJYmy-0008JW-Q8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:54:36 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tJYmw-00018S-9h
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=fnerw1MWXwnpaJRlLgZr7PGkAEJimf/bowu0UUp5fD0=; b=S+V9MPxxnDDn/1FNW/yK1KxDWQ
 B/ocPYw0jnXXgof7pSm2ZyP0qzldr+yKcmaeZKjo1U6uZstOvUq4Buyvc6ZXp9tllCfiNJp2GPLpT
 KBieomReXxJsUkLxTeT6eoO4NeouvnqbCcsejimOEfljwzyqkmiU2pvVkfuLLllwfgaDM+mOiBAKx
 3zuVJvtGH1rB6E6am6yALazWdD+ZRFAEM+2gmKZOFOHHkKGhdEQPrCGmnAcPLTRae0gGnWuD3wXRN
 2ZF2rkjAXI2UC/g+igz+oRKIBJrFBHWPcMR+K1lZHcrlmCysYQaOqvRPUXgarnD8Kl8KViH2MeXTt
 t/zfruklB2SRW2UIR/Q8ijGW7zknR3+R+Iv/V1urFw9cqiUD+vbU2i4ns8rGWmKEWlm7IYkLxGMnD
 xByE8xlI8sjxD5cUv5lQX33wbqxX/RK5Tju9B5fQO7LlRfwRu5sHIeC2gukCFr/YE5MYaLJXN3lzd
 Q5bIIog43uSWxH3/7JwkbmOTnuV0AtPgJ57mQHgJRWKVE15bzoY/yGYB8FJtYro5CewELvNUpBBuc
 2OObLj8NtknWbhLv92A570kfk2AB/y9VxCL76XUbf8I/x+wXcP/VaRWNqLfZxxnwyb87VcoVbg2my
 /P5ITCA+/7wWdFL2GWJ/+0brb7oTCJLBdC7bv1cD4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Mads Ynddal <mads@ynddal.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] 9pfs: improve v9fs_walk() tracing
Date: Fri, 06 Dec 2024 14:54:29 +0100
Message-ID: <1966894.II7VRnYYsj@silver>
In-Reply-To: <20241204205959.GB48585@fedora>
References: <E1tIPPo-006ldP-Uk@kylie.crudebyte.com>
 <20241204205959.GB48585@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wednesday, December 4, 2024 9:59:59 PM CET Stefan Hajnoczi wrote:
> On Tue, Dec 03, 2024 at 10:14:28AM +0100, Christian Schoenebeck wrote:
> > 'Twalk' is the most important request type in the 9p protocol to look out
> > for when debugging 9p communication. That's because it is the only part
> > of the 9p protocol which actually deals with human-readable path names,
> > whereas all other 9p request types work on numeric file IDs (FIDs) only.
> > 
> > Improve tracing of 'Twalk' requests, e.g. let's say client wanted to walk
> > to "/home/bob/src", then improve trace output from:
> > 
> >   v9fs_walk tag 0 id 110 fid 0 newfid 1 nwnames=3
> > 
> > to:
> > 
> >   v9fs_walk tag=0 id=110 fid=0 newfid=1 nwnames=3 wnames={home, bob, src}
> > 
> > To achieve this, add a new helper function trace_v9fs_walk_wnames() which
> > converts the received V9fsString array of individual path elements into a
> > comma-separated string presentation for being passed to the tracing system.
> > As this conversion is somewhat expensive, this new helper function returns
> > immediately if tracing of event 'v9fs_walk' is currently not enabled.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  CCing tracing maintainers in case they have better ideas how to do this.
> 
> Thanks, Christian. Comments below but this looks fine if you prefer to
> keep it this way.

Hi Stefan,

> >  hw/9pfs/9p.c         | 42 +++++++++++++++++++++++++++++++++++++-----
> >  hw/9pfs/trace-events |  2 +-
> >  2 files changed, 38 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 578517739a..c08e7e492b 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1774,6 +1774,30 @@ static bool same_stat_id(const struct stat *a, const struct stat *b)
> >      return a->st_dev == b->st_dev && a->st_ino == b->st_ino;
> >  }
> >  
> > +/*
> > + * Returns a (newly allocated) comma-separated string presentation of the
> > + * passed array for logging (tracing) purpose for trace event "v9fs_walk" only.
> > + * If tracing for that event is disabled, it immediately returns NULL instead.
> > + *
> > + * It is caller's responsibility to free the returned string.
> > + */
> > +static char *trace_v9fs_walk_wnames(V9fsString *wnames, size_t nwnames)
> > +{
> > +    g_autofree char **arr = NULL;
> > +
> > +    if (trace_event_get_state(TRACE_V9FS_WALK) &&
> > +        qemu_loglevel_mask(LOG_TRACE))
> 
> There is no need to call qemu_loglevel_mask() explicitly if you use
> trace_event_get_state_backends() instead of trace_event_get_state(). The
> QEMU log backend will check qemu_loglevel_mask(LOG_TRACE) for you.

Makes sense, I'll change that.

> > +    {
> > +        arr = g_malloc0_n(nwnames + 1, sizeof(char *));
> > +        for (size_t i = 0; i < nwnames; ++i) {
> > +            arr[i] = wnames[i].data;
> > +        }
> > +        return g_strjoinv(", ", arr);
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> >  static void coroutine_fn v9fs_walk(void *opaque)
> >  {
> >      int name_idx, nwalked;
> > @@ -1787,6 +1811,7 @@ static void coroutine_fn v9fs_walk(void *opaque)
> >      size_t offset = 7;
> >      int32_t fid, newfid;
> >      P9ARRAY_REF(V9fsString) wnames = NULL;
> > +    g_autofree char *trace_wnames = NULL;
> >      V9fsFidState *fidp;
> >      V9fsFidState *newfidp = NULL;
> >      V9fsPDU *pdu = opaque;
> > @@ -1800,11 +1825,9 @@ static void coroutine_fn v9fs_walk(void *opaque)
> >      }
> >      offset += err;
> >  
> > -    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames);
> > -
> >      if (nwnames > P9_MAXWELEM) {
> >          err = -EINVAL;
> > -        goto out_nofid;
> > +        goto out_nofid_nownames;
> >      }
> >      if (nwnames) {
> >          P9ARRAY_NEW(V9fsString, wnames, nwnames);
> > @@ -1814,15 +1837,20 @@ static void coroutine_fn v9fs_walk(void *opaque)
> >          for (i = 0; i < nwnames; i++) {
> >              err = pdu_unmarshal(pdu, offset, "s", &wnames[i]);
> >              if (err < 0) {
> > -                goto out_nofid;
> > +                goto out_nofid_nownames;
> >              }
> >              if (name_is_illegal(wnames[i].data)) {
> >                  err = -ENOENT;
> > -                goto out_nofid;
> > +                goto out_nofid_nownames;
> >              }
> >              offset += err;
> >          }
> > +        trace_wnames = trace_v9fs_walk_wnames(wnames, nwnames);
> > +        trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, trace_wnames);
> 
> This could be adjusted slightly to avoid calling trace_v9fs_walk() when
> the trace event is disabled. It's up to you but this pattern is more
> common:
> 
>   if (trace_event_get_state_backends(TRACE_V9FS_WALK)) {
>       trace_wnames = trace_v9fs_walk_wnames(wnames, nwnames);
>       trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, trace_wnames);
>   }
> 
> Now trace_v9fs_walk_wnames() doesn't need to check the trace event state
> internally.

Mmm, it doesn't make much of a difference from execution PoV. Having the check
in very small trace_v9fs_walk_wnames() function would save 2 lines in rather
large v9fs_walk() function.

In the end, both are fine with me.

Thanks for your feedback!

/Christian

> > +    } else {
> > +        trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "");
> >      }
> > +
> >      fidp = get_fid(pdu, fid);
> >      if (fidp == NULL) {
> >          err = -ENOENT;
> > @@ -1957,7 +1985,11 @@ out:
> >      }
> >      v9fs_path_free(&dpath);
> >      v9fs_path_free(&path);
> > +    goto out_pdu_complete;
> > +out_nofid_nownames:
> > +    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "<?>");
> >  out_nofid:
> > +out_pdu_complete:
> >      pdu_complete(pdu, err);
> >  }
> >  
> > diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> > index a12e55c165..ed9f4e7209 100644
> > --- a/hw/9pfs/trace-events
> > +++ b/hw/9pfs/trace-events
> > @@ -11,7 +11,7 @@ v9fs_stat(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
> >  v9fs_stat_return(uint16_t tag, uint8_t id, int32_t mode, int32_t atime, int32_t mtime, int64_t length) "tag %d id %d stat={mode %d atime %d mtime %d length %"PRId64"}"
> >  v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t request_mask) "tag %d id %d fid %d request_mask %"PRIu64
> >  v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask, uint32_t mode, uint32_t uid, uint32_t gid) "tag %d id %d getattr={result_mask %"PRId64" mode %u uid %u gid %u}"
> > -v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames) "tag %d id %d fid %d newfid %d nwnames %d"
> > +v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames, const char* wnames) "tag=%d id=%d fid=%d newfid=%d nwnames=%d wnames={%s}"
> >  v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qids) "tag %d id %d nwnames %d qids %p"
> >  v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) "tag %d id %d fid %d mode %d"
> >  v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int iounit) "tag %u id %u qid={type %u version %u path %"PRIu64"} iounit %d"
> 



