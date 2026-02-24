Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D518E9B258
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 13:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vusIY-0007kP-73; Tue, 24 Feb 2026 08:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vusIM-0007hh-Hh
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vusIK-0002ro-4O
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 08:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771939062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GyJcKDcII0qVCnJspTjHWtNo0vVH8oIKZsCLyXanQoo=;
 b=B9Zh8NxmftY8F0u60HeTjpDKOyuFbvX0ZtW9GLLALIdWj/DJiEzJZKovCEcAC0O6gg7QkX
 xLWyev/dYoBn9UmP4HWMp3Sirr2u83z13Tij3TFb+fVG/hbe4VfUHepV+SlRfDVVrb69lP
 6dd6uHJVLVUNz47ZEu/FnA2i3uqn99M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-l4UoscF1Ni-splLM0cWjWw-1; Tue,
 24 Feb 2026 08:17:40 -0500
X-MC-Unique: l4UoscF1Ni-splLM0cWjWw-1
X-Mimecast-MFC-AGG-ID: l4UoscF1Ni-splLM0cWjWw_1771939060
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B8C81956067; Tue, 24 Feb 2026 13:17:39 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.66])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78E071954102; Tue, 24 Feb 2026 13:17:37 +0000 (UTC)
Date: Tue, 24 Feb 2026 14:17:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 0/2] block: Wire up 'flat' mode also for 'query-block'
Message-ID: <aZ2k7lWcTRgzRnB7@redhat.com>
References: <cover.1770210044.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770210044.git.pkrempa@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 04.02.2026 um 14:15 hat Peter Krempa geschrieben:
> v4:
>  - No need to check 'has_flat', as qemu doesn't have warnings about
>    unused variables active (Markus)
>  - Doc wording tweak (Markus)
> 
> v3:
>  - Doc wording tweak (Eric)
> 
> v2:
>  - More descriptive docs text for the new QAPI option (Markus; new
>    wording not approved)
>  - use new options in hmp_nbd_server_start to avoid fetching unused
>    backing image info, impossible in 'info block' worker (Markus)
> 
> Peter Krempa (2):
>   block: Wire up 'flat' mode also for 'query-block'
>   hmp_nbd_server_start: Don't ask for backing image data

Thanks, applied to the block branch.

If you'd like the feature to keep working in future versions, I'd
recommend a follow-up patch that makes qemu-iotests print the result
with flat=true in some test case.

Kevin


