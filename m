Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B794109B462
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yaj-0008QY-07; Tue, 31 Mar 2026 08:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7Yah-0008Q8-Fl
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7Yag-0000Zp-1s
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774961585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jE97nvbndYI6MVuXQLVsoswFUnylu5eF3Cm1HpjslSc=;
 b=dBoRMHvR5HSXHNPVLz6U37ryEFL4OH4iWCYvwcDaGi4U4cjJYztK9+Lb/ljQ2HtrwsaBog
 6GHiZm0AoVGIBoIMbYssKWKfntWYAt13qwmF1TyqYv+2fDIIDgEfIKGe/baOjJTifLuufa
 Bd2HytiUdkKNDXaCgrPX2aStqMAv0y4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-9E2sOo-vPkSrWT1dnigahg-1; Tue,
 31 Mar 2026 08:53:03 -0400
X-MC-Unique: 9E2sOo-vPkSrWT1dnigahg-1
X-Mimecast-MFC-AGG-ID: 9E2sOo-vPkSrWT1dnigahg_1774961582
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44A5018002CF; Tue, 31 Mar 2026 12:53:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDD8319560AB; Tue, 31 Mar 2026 12:52:58 +0000 (UTC)
Date: Tue, 31 Mar 2026 14:52:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: long.yunjian@zte.com.cn
Cc: hreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mou.yi@zte.com.cn, liang.xianlong@zte.com.cn
Subject: Re: [PATCH v2] block: fix annotation
Message-ID: <acvDqMw_ZbQ6ycdE@redhat.com>
References: <20260325094204300GFCZYBzAE00cSWaldbDcT@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325094204300GFCZYBzAE00cSWaldbDcT@zte.com.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 25.03.2026 um 02:42 hat long.yunjian@zte.com.cn geschrieben:
> From: Yunjian Long <long.yunjian@zte.com.cn>
> 
> Some functions are defined in block_int-io.h, so the correct
> annotation is block_int-io.h rather than block_int.h
> 
> Signed-off-by: Yunjian Long <long.yunjian@zte.com.cn>

Thanks, applied to the block branch.

Kevin


