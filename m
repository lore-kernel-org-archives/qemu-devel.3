Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83ECC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 19:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdaV3-0007CD-2o; Thu, 30 Jan 2025 14:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdaV0-0007Bi-6O
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:46:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdaUx-0002Fc-W6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738266396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EoKNvU1o6ojN26J7NAHl3DNc3r0FGdAzLyhp4Vf9mzk=;
 b=GFVCozGT/tJ5/Z+Xd/e3tDE/UYMO9TQeg7GUwO8BblzhapscgOyYIfPAq3dOu2nNMbv6NR
 vMaPiLi4s1WpBUSugd7uxre6xJHBdHmn7mbl4vEPW/bsr1dDk4xxqdgcAD8hsHpd4hv8t4
 B8nIIvzfQwZypWQLZX/dqRGDOCKLPyA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-g59yboHQP6-nUVwTXex3wg-1; Thu,
 30 Jan 2025 14:46:32 -0500
X-MC-Unique: g59yboHQP6-nUVwTXex3wg-1
X-Mimecast-MFC-AGG-ID: g59yboHQP6-nUVwTXex3wg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B61B4180034F; Thu, 30 Jan 2025 19:46:31 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB3BB18008F8; Thu, 30 Jan 2025 19:46:27 +0000 (UTC)
Date: Thu, 30 Jan 2025 13:46:25 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/15] block: Inactivate external snapshot overlays
 when necessary
Message-ID: <xpfiexdwuoejqoms74a4v4qbg4qtgg364kf3pha6csbiipyakb@72aoxja36z32>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-3-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On Thu, Jan 30, 2025 at 06:12:33PM +0100, Kevin Wolf wrote:
> Putting an active block node on top of an inactive one is strictly
> speaking an invalid configuration and the next patch will turn it into a
> hard error.
> 
> However, taking a snapshot while disk images are inactive after
> completing migration has an important use case: After migrating to a
> file, taking an external snapshot is what is needed to take a full VM
> snapshot.
> 
> In order for this to keep working after the later patches, change
> creating a snapshot such that it automatically inactivates an overlay
> that is added on top of an already inactive node.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockdev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


