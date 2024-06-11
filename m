Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BF3C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2Wy-0004GF-Lt; Tue, 11 Jun 2024 10:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH2Wn-0003u3-Ci
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH2Wj-00071l-AL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718116263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kV3MxGpsGCoh0lXguRIZ7kx9cS0PXboFJlj+TUUaD78=;
 b=hCgT+QD7bhUsNUBvDSAIJg/selOAnuCrvLkaSj452eVR+JuiZqH/madYfR61pUNfM7Pltv
 60rt+lD2XcT/hgLc1Y+52+hV7H0rLE5sdScJ+RfQqVooFhK/CxszyKik12EFj0OFgRpUz7
 MbWhMcsOubOVS82fP38se4ttmcus6l4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-Zvs-czWnPhOcwXFHz76Z6g-1; Tue,
 11 Jun 2024 10:30:58 -0400
X-MC-Unique: Zvs-czWnPhOcwXFHz76Z6g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AAF0195608C; Tue, 11 Jun 2024 14:30:57 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.130])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8ED51955E84; Tue, 11 Jun 2024 14:30:55 +0000 (UTC)
Date: Tue, 11 Jun 2024 16:30:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 2/4] vvfat: Fix usage of `info.file.offset`
Message-ID: <ZmhfnSIe30da03uN@redhat.com>
References: <cover.1717549035.git.amjadsharafi10@gmail.com>
 <a4ae80b8307284a8b30f0267171cca850f12dc42.1717549035.git.amjadsharafi10@gmail.com>
 <Zmcup6IVpHW3sRP5@redhat.com> <ZmhDl7ob8G62FtZb@amjad-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmhDl7ob8G62FtZb@amjad-pc>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am 11.06.2024 um 14:31 hat Amjad Alsharafi geschrieben:
> On Mon, Jun 10, 2024 at 06:49:43PM +0200, Kevin Wolf wrote:
> > Am 05.06.2024 um 02:58 hat Amjad Alsharafi geschrieben:
> > > The field is marked as "the offset in the file (in clusters)", but it
> > > was being used like this
> > > `cluster_size*(nums)+mapping->info.file.offset`, which is incorrect.
> > > 
> > > Additionally, removed the `abort` when `first_mapping_index` does not
> > > match, as this matches the case when adding new clusters for files, and
> > > its inevitable that we reach this condition when doing that if the
> > > clusters are not after one another, so there is no reason to `abort`
> > > here, execution continues and the new clusters are written to disk
> > > correctly.
> > > 
> > > Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
> > 
> > Can you help me understand how first_mapping_index really works?
> > 
> > It seems to me that you get a chain of mappings for each file on the FAT
> > filesystem, which are just the contiguous areas in it, and
> > first_mapping_index refers to the mapping at the start of the file. But
> > for much of the time, it actually doesn't seem to be set at all, so you
> > have mapping->first_mapping_index == -1. Do you understand the rules
> > around when it's set and when it isn't?
> 
> Yeah. So `first_mapping_index` is the index of the first mapping, each
> mapping is a group of clusters that are contiguous in the file.
> Its mostly `-1` because the first mapping will have the value set as
> `-1` and not its own index, this value will only be set when the file
> contain more than one mapping, and this will only happen when you add
> clusters to a file that are not contiguous with the existing clusters.

Ah, that makes some sense. Not sure if it's optimal, but it's a rule I
can work with. So just to confirm, this is the invariant that we think
should always hold true, right?

    assert((mapping->mode & MODE_DIRECTORY) ||
           !mapping->info.file.offset ||
           mapping->first_mapping_index > 0);

> And actually, thanks to that I noticed another bug not fixed in PATCH 3, 
> We are doing this check 
> `s->current_mapping->first_mapping_index != mapping->first_mapping_index`
> to know if we should switch to the new mapping or not. 
> If we were reading from the first mapping (`first_mapping_index == -1`)
> and we jumped to the second mapping (`first_mapping_index == n`), we
> will catch this condition and switch to the new mapping.
> 
> But if the file has more than 2 mappings, and we jumped to the 3rd
> mapping, we will not catch this since (`first_mapping_index == n`) for
> both of them haha. I think a better check is to check the `mapping`
> pointer directly. (I'll add it also in the next series together with a
> test for it.)

This comparison is exactly what confused me. I didn't realise that the
first mapping in the chain has a different value here, so I thought this
must mean that we're looking at a different file now - but of course I
couldn't see a reason for that because we're iterating through a single
file in this function.

But even now that I know that the condition triggers when switching from
the first to the second mapping, it doesn't make sense to me. We don't
have to copy things around just because a file is non-contiguous.

What we want to catch is if the order of mappings has changed compared
to the old state. Do we need a linked list, maybe a prev_mapping_index,
instead of first_mapping_index so that we can compare if it is still the
same as before?

Or actually, I suppose that's the first block with an abort() in the
code, just that it doesn't compare mappings, but their offsets.

> > 
> > >  block/vvfat.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/block/vvfat.c b/block/vvfat.c
> > > index 19da009a5b..f0642ac3e4 100644
> > > --- a/block/vvfat.c
> > > +++ b/block/vvfat.c
> > > @@ -1408,7 +1408,9 @@ read_cluster_directory:
> > >  
> > >          assert(s->current_fd);
> > >  
> > > -        offset=s->cluster_size*(cluster_num-s->current_mapping->begin)+s->current_mapping->info.file.offset;
> > > +        offset = s->cluster_size *
> > > +            ((cluster_num - s->current_mapping->begin)
> > > +            + s->current_mapping->info.file.offset);
> > >          if(lseek(s->current_fd, offset, SEEK_SET)!=offset)
> > >              return -3;
> > >          s->cluster=s->cluster_buffer;
> > > @@ -1929,8 +1931,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
> > >                          (mapping->mode & MODE_DIRECTORY) == 0) {
> > >  
> > >                      /* was modified in qcow */
> > > -                    if (offset != mapping->info.file.offset + s->cluster_size
> > > -                            * (cluster_num - mapping->begin)) {
> > > +                    if (offset != s->cluster_size
> > > +                            * ((cluster_num - mapping->begin)
> > > +                            + mapping->info.file.offset)) {
> > >                          /* offset of this cluster in file chain has changed */
> > >                          abort();
> > >                          copy_it = 1;
> > > @@ -1944,7 +1947,6 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
> > >  
> > >                      if (mapping->first_mapping_index != first_mapping_index
> > >                              && mapping->info.file.offset > 0) {
> > > -                        abort();
> > >                          copy_it = 1;
> > >                      }
> > 
> > I'm unsure which case this represents. If first_mapping_index refers to
> > the mapping of the first cluster in the file, does this mean we got a
> > mapping for a different file here? Or is the comparison between -1 and a
> > real value?
> 
> Now that I think more about it, I think this `abort` is actually
> correct, the issue though is that the handling around this code is not.
> 
> What this `abort` actually does is that it checks.
> - if the `mapping->first_mapping_index` is not the same as
>   `first_mapping_index`, which **should** happen only in one case, when
>   we are handling the first mapping, in that case
>   `mapping->first_mapping_index == -1`, in all other cases, the other
>   mappings after the first should have the condition true.
> - From above, we know that this is the first mapping, so if the offset
>   is not `0`, then abort, since this is an invalid state.

Yes, make sense.

> This is all good, the issue is that `first_mapping_index` is not set if
> we are checking from the middle, the variable `first_mapping_index` is
> only set if we passed through the check `cluster_was_modified` with the
> first mapping, and in the same function call we checked the other
> mappings.

I think I noticed the same yesterday, but when I tried to write a quick
patch that I could show you and that would update first_mapping_index in
each iteration, I broke something. So I decided I'd first ask you what
all of this even means. :-)

> From what I have seen, that doesn't happen since even if you write the
> whole file in one go, you are still writing it cluster by cluster, and
> the checks happen at that time.

Well, we do trigger the condition, but I suppose updating
first_mapping_index in each loop iteration is really the way to go if
you think the same.

Kevin


