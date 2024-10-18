Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B81D3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nDd-00078a-N1; Fri, 18 Oct 2024 09:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1nDc-00077w-Od
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1nDa-0001jh-Az
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EspAzy36YyRuKRnAum8NxNnjzUB8tKz+NNbWx/dpw7o=;
 b=i4ozU8Kt2qKKWXm882xRF2yNl0Q72RZM0dnqw7J/BqLv2EyykNOZw5n2vRVnNPooLomegx
 u7WfI4KJBR9S3YzFYlwxMpdQ5vFL6esZBZlLewl+kWnNQ3MXP+nbYdYgO6hcWeGizEU0MZ
 U8shQLHcEV4pRobB6k+NtC/66djyIWw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-Oz7WqmGoPaWBRbJY3PXAKQ-1; Fri,
 18 Oct 2024 09:40:32 -0400
X-MC-Unique: Oz7WqmGoPaWBRbJY3PXAKQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F54E1955BFE; Fri, 18 Oct 2024 13:40:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.196])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E8E31956086; Fri, 18 Oct 2024 13:40:29 +0000 (UTC)
Date: Fri, 18 Oct 2024 15:40:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH v2 0/4] block: Miscellaneous minor Coverity fixes
Message-ID: <ZxJlQJ0j8wDYkWAV@redhat.com>
References: <20241008164708.2966400-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008164708.2966400-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 08.10.2024 um 18:47 hat Peter Maydell geschrieben:
> This patchset is the remaining stragglers from my
> first set of "minor Coverity fixes" patches posted a
> couple of months back:
> https://patchew.org/QEMU/20240731143617.3391947-1-peter.maydell@linaro.org/
> Of that series, patches 3, 4, 5 and 6 are upstream now.
> 
> In this v2 series:
>  * patch 1 (old patch 2) has had a long line wrapped;
>    already reviewed
>  * patch 2 (old patch 7) now has hex2decimal() return "UINT_MAX"
>    instead of "-1"; already reviewed
>  * patch 3 is new, and fixes an error in an iotests reference
>    output file that's been lurking around for a few years now
>  * patch 4 (replacement for old patch 1) takes Kevin Wolf's
>    suggestion to make vdi SECTOR_SIZE a 64-bit constant so we
>    don't have to carefully cast it every time we want to use
>    it in a multiplication
> 
> Patches 3 and 4 need review; patch 4 passes "./check -vdi"
> except that 297 (the python-linter) fails for unrelated reasons.

Thanks, applied to the block branch.

Kevin


