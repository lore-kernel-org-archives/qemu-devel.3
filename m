Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A77C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYQdH-00026m-GY; Thu, 16 Jan 2025 09:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYQdA-00025J-D4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYQd9-0003hQ-45
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737036832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yz3gEQ0+MJ5u/4HIRcA1TFjYo6ijCFllPInRf67W2k=;
 b=LRYJDzcRvGyFa0ge13BYobfq3fyZcjxSk35Z6ufw7t2TERRm2tT8Iirz7hBxMdxGTZvf1Z
 244zMi7ylr4dk0R1RzMDVyRiOGcfdvd3A4WPHh2PiV1pdEgtapwDl9FQZJz33EQiK4EySx
 dBBkgdgwExtSy9EP8Q7rpu7XQAFKXIU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-3tm8o5asPASjzUh015QrlQ-1; Thu,
 16 Jan 2025 09:13:48 -0500
X-MC-Unique: 3tm8o5asPASjzUh015QrlQ-1
X-Mimecast-MFC-AGG-ID: 3tm8o5asPASjzUh015QrlQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADC6D19133AB; Thu, 16 Jan 2025 14:13:47 +0000 (UTC)
Received: from redhat.com (unknown [10.39.196.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC84419560AE; Thu, 16 Jan 2025 14:13:22 +0000 (UTC)
Date: Thu, 16 Jan 2025 15:13:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/2] block: Fix leak in send_qmp_error_event
Message-ID: <Z4kUAPudOTNPdtRx@redhat.com>
References: <20241111170333.43833-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111170333.43833-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am 11.11.2024 um 18:03 hat Philippe Mathieu-Daudé geschrieben:
> Respin of Fabiano patch using g_autofree,
> and clarifying method docstrings.
> 
> Fabiano Rosas (1):
>   block: Fix leak in send_qmp_error_event
> 
> Philippe Mathieu-Daudé (1):
>   block: Improve blk_get_attached_dev_id() docstring
> 
>  include/sysemu/block-backend-io.h |  7 +++++++
>  block/block-backend.c             | 16 ++++++++++------
>  2 files changed, 17 insertions(+), 6 deletions(-)

Thanks, applied to the block branch.

Kevin


