Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0A8C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfkH-0000Mg-4J; Thu, 13 Mar 2025 06:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tsfk9-0000KQ-5G
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tsfk6-0002ol-CJ
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741861484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b+8CsjtAV+vHGkAnTEvkr+e9kVnyKxFp21QWnJGsh7g=;
 b=NmmxXqvKv5b3ol5jzX0KN+9VCpQHtLRheRBX9MZ03RM09iRXWIT0kE7TKPmPG6iwIqnTMQ
 XUUoNEzCnp2H21DWBEDFdEA2EmR9yxvmotcE6FexP2lmdBfADeSYkzYg3EG6yzjZlpNccO
 kuhrdMkQsrD08oSPsJa718SH6cocksE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150--Ve2R4N3O0qgvc9MVRREmw-1; Thu,
 13 Mar 2025 06:24:40 -0400
X-MC-Unique: -Ve2R4N3O0qgvc9MVRREmw-1
X-Mimecast-MFC-AGG-ID: -Ve2R4N3O0qgvc9MVRREmw_1741861479
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A4E41801A12; Thu, 13 Mar 2025 10:24:38 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B49FF1828A87; Thu, 13 Mar 2025 10:24:34 +0000 (UTC)
Date: Thu, 13 Mar 2025 11:24:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH v4] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
Message-ID: <Z9KyX1Ohb-tEyLkz@redhat.com>
References: <20240730141552.60404-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730141552.60404-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 30.07.2024 um 16:15 hat Alberto Garcia geschrieben:
> This tool converts a disk image to qcow2, writing the result directly
> to stdout. This can be used for example to send the generated file
> over the network.
> 
> This is equivalent to using qemu-img to convert a file to qcow2 and
> then writing the result to stdout, with the difference that this tool
> does not need to create this temporary qcow2 file and therefore does
> not need any additional disk space.
> 
> Implementing this directly in qemu-img is not really an option because
> it expects the output file to be seekable and it is also meant to be a
> generic tool that supports all combinations of file formats and image
> options. Instead, this tool can only produce qcow2 files with the
> basic options, without compression, encryption or other features.
> 
> The input file is read twice. The first pass is used to determine
> which clusters contain non-zero data and that information is used to
> create the qcow2 header, refcount table and blocks, and L1 and L2
> tables. After all that metadata is created then the second pass is
> used to write the guest data.
> 
> By default qcow2-to-stdout.py expects the input to be a raw file, but
> if qemu-storage-daemon is available then it can also be used to read
> images in other formats. Alternatively the user can also run qemu-nbd
> or qemu-storage-daemon manually instead.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Madeeha Javed <javed@igalia.com>

Thanks, applied to the block branch.

Kevin


