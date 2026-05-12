Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CB7CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMmh9-0001uD-OM; Tue, 12 May 2026 08:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMmh8-0001tu-46
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wMmh5-0002zN-MG
 for qemu-devel@nongnu.org; Tue, 12 May 2026 08:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778590718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HnJfjTvrEXToSDVaSXw+2Dz5QhD8brwwsUHn35Esi/g=;
 b=UQSZ3Fmnr5D92LMfb4p80wkdhIpfKiiOzMWZbcpJiIKTXf9F2Y+Gdtxt1FwN7EjKE50/aZ
 CPcorYxJpvBzgCyBgwFM5+disyTw6uDrSU2/Y8i4/oah8/t4mEuhzyciOkfC/mjQOhrYoz
 JVn1Itcw8yPzZMach/pmaldecuLyjpA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-K4Wxtyh0ME2lrKurHR8X_g-1; Tue,
 12 May 2026 08:58:36 -0400
X-MC-Unique: K4Wxtyh0ME2lrKurHR8X_g-1
X-Mimecast-MFC-AGG-ID: K4Wxtyh0ME2lrKurHR8X_g_1778590715
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62EDC19560B4; Tue, 12 May 2026 12:58:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.152])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 372B330001BB; Tue, 12 May 2026 12:58:32 +0000 (UTC)
Date: Tue, 12 May 2026 14:58:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org
Subject: Re: [PATCH 2/3] block/block-backend: delegate blk_co_preadv to
 blk_co_preadv_part
Message-ID: <agMj9nEEt8VpHCCx@redhat.com>
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
 <20260429062004.36582-3-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429062004.36582-3-guobin@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 29.04.2026 um 08:20 hat Bin Guo geschrieben:
> blk_co_preadv() and blk_co_preadv_part() share identical bodies except
> that blk_co_preadv() always passes qiov_offset=0.  blk_co_pwritev()
> already uses this pattern and simply calls blk_co_pwritev_part() with
> qiov_offset=0.  Apply the same simplification to the read side so that
> both pairs are consistent and the shared logic lives in a single place.
> 
> Before this change blk_co_preadv() duplicated the
> blk_inc_in_flight / blk_co_do_preadv_part / blk_dec_in_flight
> sequence.  After this change it is a one-liner wrapper, matching the
> write side.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


