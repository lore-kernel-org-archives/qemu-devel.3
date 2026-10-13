Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D5ECC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiVc-00024D-4I; Tue, 13 Oct 2026 15:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGiVa-00023v-La
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGiVZ-0001f3-B0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791920996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCkV3BXfbHYWAZmTAthYKK2Mf0Pgw6C5Bmn28YrCm9s=;
 b=YgdlFEvyQhKoqMSXQmKjUsOL49uUBxexDzoQCmE0iM6TA/QVGkh6G/yzCq2l631Q7JUwSb
 DeSNyruGM19Y0hRXCVRCPw/Y/VCghFwqjt78hFYpdpljpfdwOQCsPivO+7vVUNge990L2n
 NVMr/5ybwt5X4xJRe5JiBVmJbKAYOzw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-rFSfLW-0PWmc9jNl4BUrAQ-1; Tue,
 13 Oct 2026 19:49:54 +0000
X-MC-Unique: rFSfLW-0PWmc9jNl4BUrAQ-1
X-Mimecast-MFC-AGG-ID: rFSfLW-0PWmc9jNl4BUrAQ_1791920993
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 365B11955EB9; Tue, 13 Oct 2026 19:49:53 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 142BA1800351; Tue, 13 Oct 2026 19:49:49 +0000 (UTC)
Date: Tue, 13 Oct 2026 14:49:47 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v2 5/8] pr-manager-helper: add PR_HELPER_CLEANUP command
 support
Message-ID: <as6LFsFPo7V8jZEa@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
 <20261013181752.1299456-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013181752.1299456-6-stefanha@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Tue, Oct 13, 2026 at 02:17:49PM -0400, Stefan Hajnoczi wrote:
> qemu-pr-helper now supports the vendor-specific PR_HELPER_CLEANUP SCSI
> command. Add support to the client side.
> 
> pr_manager_helper_run() uses scsi_cdb_xfer() to determine the number of
> bytes to transfer. Extend scsi_cdb_xfer() to know that this
> vendor-specific command does not transfer any bytes.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
> - Move cdb[0] check after copy from io_hdr
> - Add missing endianness conversion for protocol flags
> ---
>  scsi/pr-manager-helper.c | 20 +++++++++++++++++---
>  scsi/utils.c             |  3 +++
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


