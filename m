Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA3BC52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saut3-0000QP-0e; Mon, 05 Aug 2024 06:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1saut1-0000LZ-No
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1saut0-0005AK-7S
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722853457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JyeccYMFBuvH114PmU6EH6oogbmfBM3fO5pDYR1gkXY=;
 b=FrL9ktC7xyPmGDy6Kmb4c9Wh9ErBaxXWgO/0+y0eMdJuvghlZhNdtkjGeS/xXvknECDpAP
 VcQVPpBptukdAT1Bd0pMfWDyd9GlEcBBbwFNwXBzngw9gbKBU/L9JXIj6as8r5iJ/4CjEO
 Rfl3g2kj8GY7jCaSBfuntqPlPoSXkxQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-RDVXEW06NLeOD_byUQBcRA-1; Mon,
 05 Aug 2024 06:24:15 -0400
X-MC-Unique: RDVXEW06NLeOD_byUQBcRA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4CF8195608B; Mon,  5 Aug 2024 10:24:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978D930001A5; Mon,  5 Aug 2024 10:24:11 +0000 (UTC)
Date: Mon, 5 Aug 2024 12:24:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v6 0/5] vvfat: Fix write bugs for large files and add
 iotests
Message-ID: <ZrCoSIBugqaEz4AH@redhat.com>
References: <cover.1721470238.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721470238.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Am 20.07.2024 um 12:13 hat Amjad Alsharafi geschrieben:
> These patches fix some bugs found when modifying files in vvfat.
> First, there was a bug when writing to the cluster 2 or above of a file, it
> will copy the cluster before it instead, so, when writing to cluster=2, the
> content of cluster=1 will be copied into disk instead in its place.
> 
> Another issue was modifying the clusters of a file and adding new
> clusters, this showed 2 issues:
> - If the new cluster is not immediately after the last cluster, it will
> cause issues when reading from this file in the future.
> - Generally, the usage of info.file.offset was incorrect, and the
> system would crash on abort() when the file is modified and a new
> cluster was added.
> 
> Also, added some iotests for vvfat, covering the this fix and also
> general behavior such as reading, writing, and creating files on the filesystem.
> Including tests for reading/writing the first cluster which
> would pass even before this patch.

Thanks, applied to the block branch (with patch 4 changed as indicated
in my comment there).

Kevin


