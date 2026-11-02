Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF940607A8A9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E8O8Ne50
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtAV-0001e2-Hn; Mon, 02 Nov 2026 09:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNtAU-0001dW-3g
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:37:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNtAS-00085q-Oy
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6FMKDvBRIHpuxB3o52pyEo+Yqzq+dpVeQ/jDJEw5w4=;
 b=E8O8Ne50GBIqGv9TBnt8BmrbIcDlrg4dS59Dci36aLv/YdFP3hYkXAdEQEnhOFOzgs1ILB
 LRLMReJ1OHDEMCw/A23+A2Kkiu95KYklIJ3qZzwgbJCoS26YVQ9bBpjM8RS4/ItXzyOz6j
 JaE2X9EsiG3aoRVVT2rQkLhnPqKe00g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-_VkhzE6EMSml01h4kMUlVA-1; Mon,
 02 Nov 2026 09:37:44 -0500
X-MC-Unique: _VkhzE6EMSml01h4kMUlVA-1
X-Mimecast-MFC-AGG-ID: _VkhzE6EMSml01h4kMUlVA_1793630263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 273C118088B8; Mon,  2 Nov 2026 14:37:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.164])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90D491800444; Mon,  2 Nov 2026 14:37:39 +0000 (UTC)
Date: Mon, 2 Nov 2026 15:37:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fengli@smartx.com,
 jsnow@redhat.com, vsementsov@yandex-team.ru, hreitz@redhat.com
Subject: Re: [PATCH] iotests: cover discard passthrough during background
 mirror
Message-ID: <auigMGYytVTUHF63@redhat.com>
References: <auR5f-cvvNgsMqxF@redhat.com>
 <20261030162041.3191556-1-haoqian.he@smartx.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030162041.3191556-1-haoqian.he@smartx.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 30.10.2026 um 17:20 hat Haoqian He geschrieben:
> A mirror_top node without BDRV_O_UNMAP silently ignores discard
> requests.
> 
> Add a regression test to verify that discard requests are not
> ignored during background mirror.
> 
> Signed-off-by: Haoqian He <haoqian.he@smartx.com>

Thanks, applied to the block branch.

Kevin


