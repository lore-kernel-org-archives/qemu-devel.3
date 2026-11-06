Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B616606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7u/q4mY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJp9-0005pz-Uh; Fri, 06 Nov 2026 08:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xPJos-0005gb-6p
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xPJoq-0006tE-K2
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793971043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CuBkhEwKDwv2HF7qxGzXFNlsWDtWFBBFW9LEPbcJSmQ=;
 b=X7u/q4mYb3wEm09c/MpBsnBrfF3P7Xd5UdhYOr407enBiuun8CfjfwedFz0hJ2LXolkZIU
 o2QrO0alBu1uVkv1DbdIQ0Z2O+HGzwmrgon5Ud5yysbg5DyrmTI2xKiJLlVNlVR2RDd+VE
 j4vgIsVWxwsbBXvy6ZAFdrXjXIGBYwI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-2G4wC7XbNXywhaPN5IiE-A-1; Fri,
 06 Nov 2026 08:17:20 -0500
X-MC-Unique: 2G4wC7XbNXywhaPN5IiE-A-1
X-Mimecast-MFC-AGG-ID: 2G4wC7XbNXywhaPN5IiE-A_1793971039
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B99471801364; Fri,  6 Nov 2026 13:17:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.86])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00AE19AC078; Fri,  6 Nov 2026 13:17:13 +0000 (UTC)
Date: Fri, 6 Nov 2026 14:17:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jean-louis@dupond.be, den@openvz.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2 0/3] qcow2: fix discard-no-unref=on data corruption
Message-ID: <au3TVywzQfGSJR09@redhat.com>
References: <20261105161515.794213-1-andrey.drobyshev@virtuozzo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105161515.794213-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 05.11.2026 um 17:15 hat Andrey Drobyshev geschrieben:
> v1 -> v2:
> 
>   * Patch 1:
>     - Add _require_disk_usage;
>     - Clean $TEST_IMG.nounref;
>     - Fix -fuse test run;
>     - Drop R-b's;
> 
>   * Patch 2, 3: add R-b's.
> 
> v1: https://lore.kernel.org/qemu-devel/20261027104441.830212-1-andrey.drobyshev@virtuozzo.com
> 
> Andrey Drobyshev (3):
>   iotests/290: add test case to check 'discard-no-unref' option behavior
>   qcow2: fix snapshot data corruption with discard-no-unref=on
>   iotests/290: add 'discard' and 'write -z -u' case with a snapshot

[Cc: qemu-stable]

Thanks, applied to the block branch.

Kevin


