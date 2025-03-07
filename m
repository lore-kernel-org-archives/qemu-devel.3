Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D496C282D0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqaYV-0002Px-Tk; Fri, 07 Mar 2025 11:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tqaYU-0002PX-9V; Fri, 07 Mar 2025 11:28:10 -0500
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1tqaYQ-0000vY-9T; Fri, 07 Mar 2025 11:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date;
 bh=yaoCgDwqPyoie72Nhfe+CmsilcG3+4JgnZmBZXTTZiQ=; b=eiXtWsOxKcduOtyeeVJGRo+Ou/
 EYOmMaDXtOCNb00An1PE4X6sIol0l8eepolAbmxtI+u30yfE7p1/iuLxRAUq4Y6VpsSF31BeAOEE6
 EdZs8/zfOkC7QO0tGEpo62woi03QSEn1SCLsAMAwK9yFYGQIWcupRcD7SbQZbD3XgOwQ=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tqaYL-0073eI-0u;
 Fri, 07 Mar 2025 16:28:01 +0000
Received: from [2a01:e0a:1da:8420:b77:bd5:6e45:7633] (helo=l14)
 by xenbits.xenproject.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <anthony@xenproject.org>) id 1tqaYK-00Cnez-2N;
 Fri, 07 Mar 2025 16:28:00 +0000
Date: Fri, 7 Mar 2025 17:27:56 +0100
From: Anthony PERARD <anthony@xenproject.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, sstabellini@kernel.org,
 paul@xen.org, olaf@aepfle.de, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 1/1] xen: No need to flush the mapcache for grants
Message-ID: <Z8sejC7gUn5MPJSy@l14>
References: <20250206194915.3357743-1-edgar.iglesias@gmail.com>
 <20250206194915.3357743-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206194915.3357743-2-edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 06, 2025 at 08:49:15PM +0100, Edgar E. Iglesias wrote:
> From: Stefano Stabellini <stefano.stabellini@amd.com>
> 
> On IOREQ_TYPE_INVALIDATE we need to invalidate the mapcache for regular
> mappings. Since recently we started reusing the mapcache also to keep
> track of grants mappings. However, there is no need to remove grant
> mappings on IOREQ_TYPE_INVALIDATE requests, we shouldn't do that. So
> remove the function call.
> 
> Fixes: 9ecdd4bf08 (xen: mapcache: Add support for grant mappings)
> Cc: qemu-stable@nongnu.org
> Reported-by: Olaf Hering <olaf@aepfle.de>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 
Anthony PERARD

