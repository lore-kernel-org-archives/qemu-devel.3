Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FE9C3ABCF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPje-0005x9-7H; Fri, 09 May 2025 11:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDPjc-0005sj-EY
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uDPja-0000gi-Mq
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746804837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oCxgSbc1h2u7EiObL3Q5np4QWtuChY6jgcEei1rL1BQ=;
 b=aDknVfk0zNPIB3HdhK+2PHfR0RZUvpjzXF+8sulZWtxJorZRUtvtQBgRqBAzA/LHWC3qed
 YNgVhG4s1fx36HqoOvR85omwN24hCqMPR4xz6nmVqZQU2ojOp/mqFD48SPjr0eVptqUrAT
 9SBP1ZYpet2LaPI/4eZhn3Q0IK9yNZA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-SkLPl6CEN8SAwbSBWX7veA-1; Fri,
 09 May 2025 11:33:56 -0400
X-MC-Unique: SkLPl6CEN8SAwbSBWX7veA-1
X-Mimecast-MFC-AGG-ID: SkLPl6CEN8SAwbSBWX7veA_1746804835
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 172F719560B0; Fri,  9 May 2025 15:33:55 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F94119560B0; Fri,  9 May 2025 15:33:52 +0000 (UTC)
Date: Fri, 9 May 2025 10:33:49 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, stefanha@redhat.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 10/11] tests: Add iotest mirror-sparse for recent
 patches
Message-ID: <bviylpfdsdwnf3sireigiaxh7x55nwcachvu5bnc6iwce3sg5e@pxistsof2hkn>
References: <20250425005439.2252467-13-eblake@redhat.com>
 <20250425005439.2252467-23-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425005439.2252467-23-eblake@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 24, 2025 at 07:52:10PM -0500, Eric Blake wrote:
> Prove that blockdev-mirror can now result in sparse raw destination
> files, regardless of whether the source is raw or qcow2.  By making
> this a separate test, it was possible to test effects of individual
> patches for the various pieces that all have to work together for a
> sparse mirror to be successful.
> 
> Note that ./check -file produces different job lengths than ./check
> -qcow2 (the test uses a filter to normalize); that's because when
> deciding how much of the image to be mirrored, the code looks at how
> much of the source image was allocated (for qcow2, this is only the
> written clusters; for raw, it is the entire file).  But the important
> part is that the destination file ends up smaller than 3M, rather than
> the 20M it used to be before this patch series.
> 

> +
> +filter_len() {
> +    sed -e 's/"len": [0-9]*/"len": LEN/g' \
> +        -e 's/"offset": [0-9]*/"offset": OFFSET/g'
> +}

This duplicates _filter_block_job_offset and _filter_block_job_len in
common.filter.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


