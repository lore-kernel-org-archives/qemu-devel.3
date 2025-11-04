Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF89CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKYG-0001lg-1x; Tue, 04 Nov 2025 12:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGKY6-0001kT-IR
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGKXy-0004FA-Ji
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762276216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zZ4sCR5gSe0VDkjQdrJRDy0RownehfBE41QW8iGHet8=;
 b=ZshIeCk/TZ3q3DMY4aREgB2UQ7Xlq9iWPjNft/GyUTEwC8LTQGoYbrKXU8jsMZG6qDXVtm
 yNU8h8ObDQKOqzN7tOoChhrx3BTxxL7iNRct6jtcWdtFAD4B1UccOTOFVXSaHbr0j/wPnx
 z4+gNEcvAOTbWypJ2MOeUdAuORN4yFQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-1MJ6UIYPOnamwCogBt1rhA-1; Tue,
 04 Nov 2025 12:10:14 -0500
X-MC-Unique: 1MJ6UIYPOnamwCogBt1rhA-1
X-Mimecast-MFC-AGG-ID: 1MJ6UIYPOnamwCogBt1rhA_1762276212
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88A9118002C1; Tue,  4 Nov 2025 17:10:12 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C806F18004D8; Tue,  4 Nov 2025 17:10:10 +0000 (UTC)
Date: Tue, 4 Nov 2025 18:10:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] tests/qemu-iotests: Improve test detection for
 meson
Message-ID: <aQozcLSLlFROIatQ@redhat.com>
References: <20251014104142.1281028-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014104142.1281028-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 14.10.2025 um 12:41 hat Thomas Huth geschrieben:
> When running the test in thorough mode, we currently try to run a lot of
> tests that are only skipped, which is somewhat annoying. This series
> fixes the problems (see second patch), and add some more image formats
> in the third patch (which should be fine now that the list of tests that
> we try to execute is not that big anymore).
> 
> v2:
> - Improve the detection mechanism in patch 2 by using regex statements
> - Extend the comment in patch 2 a little bit, saying that the detection
>   can fail in certain cases, e.g. when the "unsupported_fmt" and the
>   "supported_fmt" statement are on the same line (which does not seem to
>   be a problem with the current test cases right now, fortunately)

Thanks, applied to the block branch.

Kevin


