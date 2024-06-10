Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60E9C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGiDt-00009k-VN; Mon, 10 Jun 2024 12:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sGiDl-00005o-MK
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sGiDf-0003s2-H9
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718038200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIHEg2/CWkoZwKCSQokgSF5+uZpt5/PMMMxZjn20df8=;
 b=XMu/Fgy95v3xn3fnx47nMiYhsJlzbtj842mwQWwbcDa1ZiMm4HmFG4CoJ6elr5kpxwN3o7
 9+lKO6ItPn3WTmkekv85tqsZKiBBJutBKmjTtyI2IgdrCxrKTAT6gPJw5Nc7EZn+qPERah
 OECshH8f3v9KrTqKT8qyx0QsQqYldNc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-B6VN6_e0NL2otu5es-ZO0g-1; Mon,
 10 Jun 2024 12:49:55 -0400
X-MC-Unique: B6VN6_e0NL2otu5es-ZO0g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6F88195DE5B; Mon, 10 Jun 2024 16:49:48 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.31])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06FE419560B6; Mon, 10 Jun 2024 16:49:45 +0000 (UTC)
Date: Mon, 10 Jun 2024 18:49:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 2/4] vvfat: Fix usage of `info.file.offset`
Message-ID: <Zmcup6IVpHW3sRP5@redhat.com>
References: <cover.1717549035.git.amjadsharafi10@gmail.com>
 <a4ae80b8307284a8b30f0267171cca850f12dc42.1717549035.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ae80b8307284a8b30f0267171cca850f12dc42.1717549035.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Am 05.06.2024 um 02:58 hat Amjad Alsharafi geschrieben:
> The field is marked as "the offset in the file (in clusters)", but it
> was being used like this
> `cluster_size*(nums)+mapping->info.file.offset`, which is incorrect.
> 
> Additionally, removed the `abort` when `first_mapping_index` does not
> match, as this matches the case when adding new clusters for files, and
> its inevitable that we reach this condition when doing that if the
> clusters are not after one another, so there is no reason to `abort`
> here, execution continues and the new clusters are written to disk
> correctly.
> 
> Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>

Can you help me understand how first_mapping_index really works?

It seems to me that you get a chain of mappings for each file on the FAT
filesystem, which are just the contiguous areas in it, and
first_mapping_index refers to the mapping at the start of the file. But
for much of the time, it actually doesn't seem to be set at all, so you
have mapping->first_mapping_index == -1. Do you understand the rules
around when it's set and when it isn't?

>  block/vvfat.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 19da009a5b..f0642ac3e4 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -1408,7 +1408,9 @@ read_cluster_directory:
>  
>          assert(s->current_fd);
>  
> -        offset=s->cluster_size*(cluster_num-s->current_mapping->begin)+s->current_mapping->info.file.offset;
> +        offset = s->cluster_size *
> +            ((cluster_num - s->current_mapping->begin)
> +            + s->current_mapping->info.file.offset);
>          if(lseek(s->current_fd, offset, SEEK_SET)!=offset)
>              return -3;
>          s->cluster=s->cluster_buffer;
> @@ -1929,8 +1931,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
>                          (mapping->mode & MODE_DIRECTORY) == 0) {
>  
>                      /* was modified in qcow */
> -                    if (offset != mapping->info.file.offset + s->cluster_size
> -                            * (cluster_num - mapping->begin)) {
> +                    if (offset != s->cluster_size
> +                            * ((cluster_num - mapping->begin)
> +                            + mapping->info.file.offset)) {
>                          /* offset of this cluster in file chain has changed */
>                          abort();
>                          copy_it = 1;
> @@ -1944,7 +1947,6 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
>  
>                      if (mapping->first_mapping_index != first_mapping_index
>                              && mapping->info.file.offset > 0) {
> -                        abort();
>                          copy_it = 1;
>                      }

I'm unsure which case this represents. If first_mapping_index refers to
the mapping of the first cluster in the file, does this mean we got a
mapping for a different file here? Or is the comparison between -1 and a
real value?

In any case it doesn't seem to be the case that the comment at the
declaration of copy_it describes.

>  
> @@ -2404,7 +2406,7 @@ static int commit_mappings(BDRVVVFATState* s,
>                          (mapping->end - mapping->begin);
>              } else
>                  next_mapping->info.file.offset = mapping->info.file.offset +
> -                        mapping->end - mapping->begin;
> +                        (mapping->end - mapping->begin);
>  
>              mapping = next_mapping;
>          }

Kevin


