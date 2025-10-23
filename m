Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68868CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 18:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBzhO-0004yp-9z; Thu, 23 Oct 2025 14:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBzhM-0004yJ-Tm
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBzhJ-0004uM-Qo
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 14:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761242757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7m+JLpaggGeOphACh7MooaxAUCGY1CT2Ued+La4gR94=;
 b=eSzAuv0nwUxhXBJiTRvvmnmNbZIdJf/aADB4dTpt/Cn0wHv0czKJKXEWMShCUwBgYv+zHx
 EJC2qoIJPUH9SpxdN4JUV5wSwlsfk5oMzyfw1n1YsrqpRHqtrv2QjYmw7nICuuZ8Q3gtLP
 K4Ka1HKdhx0UWabfU8IpbJfRcK1JLNk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-gOrp4HcOMFS05mnolntjcA-1; Thu,
 23 Oct 2025 14:05:53 -0400
X-MC-Unique: gOrp4HcOMFS05mnolntjcA-1
X-Mimecast-MFC-AGG-ID: gOrp4HcOMFS05mnolntjcA_1761242751
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0F9D1800675; Thu, 23 Oct 2025 18:05:51 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.90])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF84819560B5; Thu, 23 Oct 2025 18:05:49 +0000 (UTC)
Date: Thu, 23 Oct 2025 20:05:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Chandan Somani <csomani@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2] block: enable stats-intervals for storage devices
Message-ID: <aPpue5a-uCkdlc9z@redhat.com>
References: <20251003220039.1336663-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003220039.1336663-1-csomani@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 03.10.2025 um 23:59 hat Chandan Somani geschrieben:
> This patch allows stats-intervals to be used for storage
> devices with the -device option. It accepts a list of interval
> lengths in JSON format.
> 
> It configures and collects the stats in the BlockBackend layer
> through the storage device that consumes the BlockBackend.
> 
> Signed-off-by: Chandan Somani <csomani@redhat.com>

Thanks, applied to the block branch.

Maybe you can add a patch on top that extends tests/qemu-iotests/136 to
also test the -device based settings (probably in a new child class)
instead of only -drive?

Kevin


