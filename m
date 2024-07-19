Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4ADC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUit1-0005Cz-SA; Fri, 19 Jul 2024 04:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUit0-0005BR-QL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sUisz-0005Oz-0p
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721377360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gaomhL4k3MtH8gL6Mwt12r5Mwqj78Yxa4XCOYF34fgY=;
 b=NdoNWr5fwo7BzqrBL1YLov9Y68T5PPfhy3EaH53suPA+K1msGz5IKfgjAREB6oyG1rXzFi
 fCImM5Q4zO14ta74pd71f1P/BGu/MoQSaP8DHB7NsO+qUtVYRtjkqsUzSRZ29FglmJMJIY
 ic8/8kNc8gDN1vC2DEc05YlC1BeuV8o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-XAx2Wu5AMKekSMzpgPWJ3A-1; Fri,
 19 Jul 2024 04:22:36 -0400
X-MC-Unique: XAx2Wu5AMKekSMzpgPWJ3A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B3601955F40; Fri, 19 Jul 2024 08:22:35 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.130])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03ABE3000188; Fri, 19 Jul 2024 08:22:32 +0000 (UTC)
Date: Fri, 19 Jul 2024 10:22:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 4/5] vvfat: Fix reading files with non-continuous
 clusters
Message-ID: <ZpoiRiCgACkh5REh@redhat.com>
References: <ZpmxMEj5qZDUhj_h@amjad-pc>
 <117AB0D4-B3AC-4A8B-84AA-C4085A78B9FE@getmailspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117AB0D4-B3AC-4A8B-84AA-C4085A78B9FE@getmailspring.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 19.07.2024 um 02:29 hat Amjad Alsharafi geschrieben:
> 
> 
> On Jul 19 2024, at 8:20 am, Amjad Alsharafi <amjadsharafi10@gmail.com> wrote:
> 
> > On Thu, Jul 18, 2024 at 05:20:36PM +0200, Kevin Wolf wrote:
> >> Am 12.06.2024 um 14:43 hat Amjad Alsharafi geschrieben:
> >> > When reading with `read_cluster` we get the `mapping` with
> >> > `find_mapping_for_cluster` and then we call `open_file` for this
> >> > mapping.
> >> > The issue appear when its the same file, but a second cluster that is
> >> > not immediately after it, imagine clusters `500 -> 503`, this will give
> >> > us 2 mappings one has the range `500..501` and another `503..504`, both
> >> > point to the same file, but different offsets.
> >> > 
> >> > When we don't open the file since the path is the same, we won't assign
> >> > `s->current_mapping` and thus accessing way out of bound of the file.
> >> > 
> >> > From our example above, after `open_file` (that didn't open
> >> anything) we
> >> > will get the offset into the file with
> >> > `s->cluster_size*(cluster_num-s->current_mapping->begin)`, which will
> >> > give us `0x2000 * (504-500)`, which is out of bound for this
> >> mapping and
> >> > will produce some issues.
> >> > 
> >> > Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
> >> > ---
> >> >  block/vvfat.c | 23 ++++++++++++++++-------
> >> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >> > 
> >> > diff --git a/block/vvfat.c b/block/vvfat.c
> >> > index b63ac5d045..fc570d0610 100644
> >> > --- a/block/vvfat.c
> >> > +++ b/block/vvfat.c
> >> > @@ -1360,15 +1360,24 @@ static int open_file(BDRVVVFATState*
> >> s,mapping_t* mapping)
> >> >  {
> >> >      if(!mapping)
> >> >          return -1;
> >> > +    int new_path = 1;
> >> >      if(!s->current_mapping ||
> >> > -            strcmp(s->current_mapping->path,mapping->path)) {
> >> > -        /* open file */
> >> > -        int fd = qemu_open_old(mapping->path,
> >> > +            s->current_mapping->info.file.offset
> >> > +                != mapping->info.file.offset ||
> >> 
> >> I'm wondering if this couldn't just be s->current_mapping != mapping?
> > 
> > Actually, you are totally right. Not sure what made me go for this.
> > 
> > I tried also to test with only checking if the path changed, but it
> > fails on some tests. So the offset is important.
> > For that reason, checking just the mapping ptr is better since we won't
> > have 2 mappings with same file and offset.
> > 
> > I'll then use this change. Thanks
> 
> Should I send a new patch? since most commits are reviewed now

Yes, please do. I think I reviewed the whole series.

Kevin

> > 
> >> 
> >> > +            (new_path = strcmp(s->current_mapping->path,
> >> mapping->path))) {
> >> 
> >> If both the path and the offset change, we still want to set
> >> new_path, I
> >> think. And if we didn't already have a mapping, we also need to open the
> >> file.
> >> 
> >> Actually, setting a variable inside the condition makes it kind of hard
> >> to read, so if s->current_mapping != mapping works, we can do the check
> >> only in the conditon below:
> >> 
> >> > +        if (new_path) {
> >> 
> >> if (!s->current_mapping ||
> >>     strcmp(s->current_mapping->path, mapping->path))
> >> 
> >> > +            /* open file */
> >> > +            int fd = qemu_open_old(mapping->path,
> >> >                                 O_RDONLY | O_BINARY | O_LARGEFILE);
> >> > -        if(fd<0)
> >> > -            return -1;
> >> > -        vvfat_close_current_file(s);
> >> > -        s->current_fd = fd;
> >> > +            if (fd < 0) {
> >> > +                return -1;
> >> > +            }
> >> > +            vvfat_close_current_file(s);
> >> > +
> >> > +            s->current_fd = fd;
> >> > +        }
> >> > +        assert(s->current_fd);
> >> >          s->current_mapping = mapping;
> >> >      }
> >> 
> >> Kevin
> >> 
> > 
> 


