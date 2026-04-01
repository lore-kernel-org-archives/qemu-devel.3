Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870BED3515A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7qzu-0002oP-R9; Wed, 01 Apr 2026 04:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7qzr-0002nd-IE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w7qzo-0007oy-3T
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775032335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gKcJFipCWIP6qnd0YK7qWtqu4roNo7pi9g4VRUyrrfw=;
 b=G//9NUK94OK0xkTXiqiXwimYhAhae7PLbE8hG+0hx0NEUqVMm44aW/twPvHl2UEtUGe8e8
 McjtOhP+G+YOlyh7M3iQBUn6i3V5xR9NRjvPHqQzUFmnSNTDC9i1a4CO8ExyXPHirbSjYn
 YV9kXkTn43nP5NuBwrSK0LYc3bmPJ8Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-vLihRtfhPUebQ16SwRFCCA-1; Wed,
 01 Apr 2026 04:32:10 -0400
X-MC-Unique: vLihRtfhPUebQ16SwRFCCA-1
X-Mimecast-MFC-AGG-ID: vLihRtfhPUebQ16SwRFCCA_1775032329
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22B331954B17; Wed,  1 Apr 2026 08:32:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BE551955F42; Wed,  1 Apr 2026 08:32:04 +0000 (UTC)
Date: Wed, 1 Apr 2026 10:32:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: hongmianquan <hongmianquan@bytedance.com>, qemu-devel@nongnu.org,
 armbru@redhat.com, michael.roth@amd.com, wubo.bob@bytedance.com,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2] monitor: Fix deadlock in monitor_cleanup
Message-ID: <aczYAumxAviEYqcR@redhat.com>
References: <20260327131024.51947-1-hongmianquan@bytedance.com>
 <78e18aaf-2231-42c8-9307-829fd4dd44a3@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e18aaf-2231-42c8-9307-829fd4dd44a3@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
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

Am 31.03.2026 um 23:38 hat Michael Tokarev geschrieben:
> On 27.03.2026 16:10, hongmianquan wrote:
> > During qemu_cleanup, if a non-coroutine QMP command (e.g., query-commands) is concurrently
> > received and processed by the mon_iothread, it can lead to a deadlock in monitor_cleanup.
> 
> Shouldn't this one too be picked up for the stable series?
> Sounds like a good candidate to me.

Yes, makes sense, please pick it up. I also agree with the SCSI and IDE
patch you picked up.

Kevin


