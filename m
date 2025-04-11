Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4939C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 20:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Kmk-0002ae-Lv; Fri, 11 Apr 2025 16:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3KmZ-0002Yz-MN
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3KmX-0006Bl-8h
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744402518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TMFNZOUqphR5D1d5NJn+2p9ueCXtPk7JOFMR8lZ1vis=;
 b=Yx+q8hkpHdjB0KurfCtzirYxpR7Qyn+5n3hf9t8fftXT7O6Jop/tXQMoNuxAuy4DgSviSy
 5VYhW5QCQvU/RgdpDH217Ul26GpI9/ZE33mHxvwmLR/BXB3I1J9cYk+j4P2J6B4Or3MTZM
 53TvUc2hnNBgOTwnjpHg3tHOeXsdEPo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-imwWa1MyMfW0tpQ5JBadNg-1; Fri,
 11 Apr 2025 16:15:17 -0400
X-MC-Unique: imwWa1MyMfW0tpQ5JBadNg-1
X-Mimecast-MFC-AGG-ID: imwWa1MyMfW0tpQ5JBadNg_1744402516
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C514B1801A1A; Fri, 11 Apr 2025 20:15:15 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C58B180AF7C; Fri, 11 Apr 2025 20:15:12 +0000 (UTC)
Date: Fri, 11 Apr 2025 15:15:10 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: nsoffer@redhat.com, pkrempa@redhat.com
Subject: Re: [PATCH 0/6] Make blockdev-mirror dest sparse in more cases
Message-ID: <4iftygymz2kk24xea2arluttyv7qn2r3ase2g2y6qd2u3dijlm@6ekiuzefyotw>
References: <20250411010732.358817-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411010732.358817-8-eblake@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
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

On Thu, Apr 10, 2025 at 08:04:50PM -0500, Eric Blake wrote:
> When mirroring images, it makes sense for the destination to be sparse
> even if it was not connected with "discard":"unmap"; the only time the
> destination should be fully allocated is if the user pre-allocated it,
> or if the source was not sparse.
> 
> Eric Blake (6):
>   mirror: Skip pre-zeroing destination if it is already zero
>   file-posix: Allow lseek at offset 0 when !want_zero
>   mirror: Skip writing zeroes when target is already zero
>   block: Expand block status mode from bool to enum
>   file-posix: Recognize blockdev-create file as starting all zero
>   tests: Add iotest mirror-sparse for recent patches

Responding here to point out that in
https://issues.redhat.com/browse/RHEL-82906, Peter Krempa identified
that it was Nir's earlier patch:

> commit d05ae948cc887054495977855b0859d0d4ab2613
> Author: Nir Soffer <nsoffer@redhat.com>
> Date:   Fri Jun 28 23:20:58 2024 +0300
> 
>     Consider discard option when writing zeros
>     
>     When opening an image with discard=off, we punch hole in the image when
>     writing zeroes, making the image sparse. This breaks users that want to
>     ensure that writes cannot fail with ENOSPACE by using fully allocated
>     images[1].
>     
>     bdrv_co_pwrite_zeroes() correctly disables BDRV_REQ_MAY_UNMAP if we
>     opened the child without discard=unmap or discard=on. But we don't go
>     through this function when accessing the top node. Move the check down
>     to bdrv_co_do_pwrite_zeroes() which seems to be used in all code paths.
>     
>     This change implements the documented behavior, punching holes only when
>     opening the image with discard=on or discard=unmap. This may not be the
>     best default but can improve it later.
> ...

that changed qemu's behavior last year to be closer to its documentation.

It raises the question: should we change the default for "discard"
from "ignore" (what we currently have, where write zeroes defaults to
full allocation if you didn't request otherwise - but where this patch
series demonstrates that we can still be careful to avoid writing
zeroes to something that already reads as zeroes as a way to preserve
sparseness) to "unmap" (ie. we would favor sparse files by default,
but where you can still opt-in to full allocation)?

What are the policies on changing defaults?  Do we have to issue a
deprecation notice for any block device opened without specifying a
"discard" policy, and go through a couple of release cycles, so that
two releases down the road we can change the "discard" parameter from
optional to mandatory, and then even later switch it back to optional
but with a new default?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


