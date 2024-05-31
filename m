Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F7EC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD5xx-0003H1-Jf; Fri, 31 May 2024 13:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD5xw-0003Gg-8W
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD5xu-0003dc-JX
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717176173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eCrnAAxp60ov9N6znR2TztXPmdcE5hnEG5uvLbPn59E=;
 b=cPkiCQRBlDwlwuwQXd0uApsPikRFkipDiJ+drNgj0NTm8+U/EkxQ6Kd9xmaCbN/wnXF8UC
 i81G2Qf2Jzg5CIZ35eIawYVjR8h5VjbaJ64aSCJqhti/TPaX3Xi8H3/dsXADjOsChgFJ0J
 LzwDBb9AFxYX0MgdDMf1UcmMLkyMEVo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-hEbNdPJsPUiJYq_TbU9PPw-1; Fri, 31 May 2024 13:22:51 -0400
X-MC-Unique: hEbNdPJsPUiJYq_TbU9PPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B7BE185A780;
 Fri, 31 May 2024 17:22:51 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63E1E2026D68;
 Fri, 31 May 2024 17:22:50 +0000 (UTC)
Date: Fri, 31 May 2024 19:22:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 0/6] vvfat: Fix write bugs for large files and add
 iotests
Message-ID: <ZloHabJMkRY-paOL@redhat.com>
References: <cover.1716717181.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716717181.git.amjadsharafi10@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 26.05.2024 um 11:56 hat Amjad Alsharafi geschrieben:
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

I was wondering how to reproduce the bugs that patches 2 and 3 fix. So I
tried to run your iotests case, and while it does catch the bug that
patch 1 fixes, it passes even without the other two fixes.

Is this expected? If so, can we add more tests that trigger the problems
the other two patches address?

Kevin


