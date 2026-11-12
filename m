Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB77606A88F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSa7wrsR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUIX-0004Ob-De; Thu, 12 Nov 2026 07:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xRUIU-0004O7-TI
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xRUIT-0000uM-Bt
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794487976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U63rO2VyuXrLmUGjVFO3QADGaD6C20+QctHvzcSRH30=;
 b=XSa7wrsRiyoVFSy2dW6tbc/sfciKUmxJHZzFEClP1fCVxhlcE74rvi9CEzTW2EN+2oj4vv
 /K8KebFjVMQMGgqxUU7fq2Ib5t/oBg9w5BT5S1DgCT5gST2PhgjLx4TWzC7/kGU8eEwNLU
 AUv8uFpj20wwe7vDBtwrTNHWA8x6Sx8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-H4ym9genNBiJ9EpS_a0DHA-1; Thu,
 12 Nov 2026 07:52:55 -0500
X-MC-Unique: H4ym9genNBiJ9EpS_a0DHA-1
X-Mimecast-MFC-AGG-ID: H4ym9genNBiJ9EpS_a0DHA_1794487974
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D09171891FA0; Thu, 12 Nov 2026 12:52:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.60])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2487618004FF; Thu, 12 Nov 2026 12:52:45 +0000 (UTC)
Date: Thu, 12 Nov 2026 13:52:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block/vhdx-log: Improve sanity checks to avoid OOB
 accesses with bad images
Message-ID: <avW2m_OERQZOdVXp@redhat.com>
References: <20261111150659.253918-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111150659.253918-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 11.11.2026 um 16:06 hat Thomas Huth geschrieben:
> The multiplication "hdr->descriptor_count * sizeof(VHDXLogDescriptor)" in
> vhdx_log_hdr_is_valid() can overflow on 32-bit systems, so this function
> could mark bad images as valid when the truncated result is smaller than
> hdr->entry_length. Switch to a division on the right hand side instead to
> avoid the overflow problems.
> 
> The second problem is in vhdx_log_read_desc(): desc_sectors is a 32-bit
> value, thus the multiplication "desc_sectors * VHDX_LOG_SECTOR_SIZE" is
> also done with 32 bit arithmetics, and the result is used as "size_t"
> parameter for qemu_try_blockalign(), i.e. the parameter here is also
> only 32 bits on 32-bit systems. Let's add a sanity check here to avoid
> the overflow problem that could lead to trouble later.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3860
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to the block branch.

Kevin


