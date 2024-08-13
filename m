Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133A9C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdnHK-00069l-C7; Tue, 13 Aug 2024 04:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sdnHI-000687-KJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sdnHF-0001E4-35
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723539190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9g4p0aELZmJLiExTi61Q/td1mekB+vBOpipm8JdlEQ=;
 b=VKTN9Xt7RsoA1PcW7170E2KCXa5ejW2BXV795otcq4Gm7yCCWwKlTad8ZXracI9s14Kzlz
 hFoB9d+Kg8cYOXBF3+cDSaPTXmYHJoMCn1+KLVS2hyHXnSsiTELT3TVGpcJssSpeJ2L4nU
 yLova35U+zDFSlluopWTHZsxPdJEzyo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-Sxn1Nsi1PUmTXD4hbMFmQg-1; Tue,
 13 Aug 2024 04:53:06 -0400
X-MC-Unique: Sxn1Nsi1PUmTXD4hbMFmQg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1392219560B1; Tue, 13 Aug 2024 08:53:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.152])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B88AA1956048; Tue, 13 Aug 2024 08:53:00 +0000 (UTC)
Date: Tue, 13 Aug 2024 10:52:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Amjad Alsharafi <amjadsharafi10@gmail.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, "open list:vvfat" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v5 0/5] vvfat: Fix write bugs for large files and add
 iotests
Message-ID: <Zrse6iszB_pmi3VF@redhat.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
 <44aaeed5-95d3-46dc-b04c-ae4cfab5b029@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44aaeed5-95d3-46dc-b04c-ae4cfab5b029@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 11.08.2024 um 09:51 hat Michael Tokarev geschrieben:
> 12.06.2024 15:43, Amjad Alsharafi wrote:
> > These patches fix some bugs found when modifying files in vvfat.
> > First, there was a bug when writing to the cluster 2 or above of a file, it
> > will copy the cluster before it instead, so, when writing to cluster=2, the
> > content of cluster=1 will be copied into disk instead in its place.
> > 
> > Another issue was modifying the clusters of a file and adding new
> > clusters, this showed 2 issues:
> > - If the new cluster is not immediately after the last cluster, it will
> > cause issues when reading from this file in the future.
> > - Generally, the usage of info.file.offset was incorrect, and the
> > system would crash on abort() when the file is modified and a new
> > cluster was added.
> > 
> > Also, added some iotests for vvfat, covering the this fix and also
> > general behavior such as reading, writing, and creating files on the filesystem.
> > Including tests for reading/writing the first cluster which
> > would pass even before this patch.
> ...
> > Amjad Alsharafi (5):
> >    vvfat: Fix bug in writing to middle of file
> >    vvfat: Fix usage of `info.file.offset`
> >    vvfat: Fix wrong checks for cluster mappings invariant
> >    vvfat: Fix reading files with non-continuous clusters
> >    iotests: Add `vvfat` tests
> 
> Actually, maybe the whole series is a good candidate for -stable, not
> just the first fix.  What do you think?

Yes, if you consider vvfat relevant for stable at all, then I think you
want to take all of the fixes, each one fixes some corruption in
read-write mode. (Though as far as I can tell, read-write support is
still broken even after this series.)

Kevin


