Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB64C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdKP-0002gp-4J; Mon, 10 Mar 2025 09:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trdKM-0002f7-O8
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trdKK-00083K-W6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741613870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y9NRuclYVD9IAmen/TEb43j9UR7fvNxCJFWwcY5iass=;
 b=VSUVhhe18htc/8uD7phFEHUXiMu1XpTSb+MCeiBKaC6kfrwejpIJpvdJcMhqh1t4CzL57Q
 LjZLaiJHipfNvJQsYp6l23oeGcP1CPtS5+mJiLy+5lvPRjXh1/GmRjkq6NvIMzIPAPlpiR
 GaLceIyAXvABPcQhcPYKPPgb3pZjKA8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-oT-yOQauM_aTRmatz76m5A-1; Mon,
 10 Mar 2025 09:37:47 -0400
X-MC-Unique: oT-yOQauM_aTRmatz76m5A-1
X-Mimecast-MFC-AGG-ID: oT-yOQauM_aTRmatz76m5A_1741613864
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44AE11955DCD; Mon, 10 Mar 2025 13:37:44 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.222])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18F623001D0E; Mon, 10 Mar 2025 13:37:39 +0000 (UTC)
Date: Mon, 10 Mar 2025 14:37:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 04/12] scsi: introduce requests_lock
Message-ID: <Z87rIcwaBfAaxzLs@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
 <20250213180043.713434-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213180043.713434-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 13.02.2025 um 19:00 hat Stefan Hajnoczi geschrieben:
> SCSIDevice keeps track of in-flight requests for device reset and Task
> Management Functions (TMFs). The request list requires protection so
> that multi-threaded SCSI emulation can be implemented in commits that
> follow.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Some of this feels quite heavy-handed, and I imagine that having to take
the lock in every request could cause considerable lock contention only
so that we can iterate all requests in a slow path.

This works for now, but maybe in the long run, we want to teach the
SCSI layer about (virt)queues, and have a separate request list per
queue (= AioContext)?

Kevin


