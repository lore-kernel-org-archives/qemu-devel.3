Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D2FC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 20:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKNPH-0000gE-C8; Wed, 28 May 2025 16:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKNPG-0000fp-7J
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKNP4-0001Sw-G2
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748464170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bkr6+iBmmHfk0QiCNLnCqL1qxBlypnRx3Gd6Xn+mMTU=;
 b=UY7Sga58Ubkobsc2gbDa1QndNnUAaL46Yf6aj452nv2OBwq2YW0Uw+zh1XrPlujNztanxt
 3D9qWT7wyWQU28ibNOiZP57NnMSQUAmUJRrSA0neE/q/+TVqF3WN4/2luKj/4WfpwoJ5rf
 Rmvjt7l5h0AOKoxE7JyB3y7dyIcBuCM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-klXmRwEUO_OsDyujvo_z4g-1; Wed,
 28 May 2025 16:29:27 -0400
X-MC-Unique: klXmRwEUO_OsDyujvo_z4g-1
X-Mimecast-MFC-AGG-ID: klXmRwEUO_OsDyujvo_z4g_1748464166
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17386195608A; Wed, 28 May 2025 20:29:26 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5BA130001B0; Wed, 28 May 2025 20:29:23 +0000 (UTC)
Date: Wed, 28 May 2025 15:29:20 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hibriansong@gmail.com, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [RFC 01/11] aio-posix: fix polling mode with fdmon-io_uring
Message-ID: <mequ24eyekrec6eha4wu3yi442r7k55dtkj7wrqd7ek67dugjo@z4nwhz4bus5p>
References: <20250528190916.35864-1-stefanha@redhat.com>
 <20250528190916.35864-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528190916.35864-2-stefanha@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.904, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 28, 2025 at 03:09:06PM -0400, Stefan Hajnoczi wrote:
> The io_uring(7) file descriptor monitor cannot enter polling mode
> because it needs to submit a POLL_ADD SQE every time a file descriptor
> becomes active. Submitting SQEs only happens in FDMonOps->wait() outside
> of polling mode.
> 
> Fix this using the multi-shot mechanism introduced in Linux 5.13 and
> liburing 2.1. Stable and enterprise Linux distros ship 5.14+ as of March
> 2025, so it is safe to require this. Note that fdmon-io_uring is
> currently not enabled at runtime and is not essential, so QEMU can still
> be built without it on older hosts.
> 
> In multi-shot mode, a POLL_ADD SQE remains active until canceled with
> POLL_REMOVE. This avoids the need to submit a new SQE every time a file
> descriptor becomes active.
> 
> When POLL_REMOVE is processed by the host kernel, the multi-shot
> POLL_ADD operation completes with -ECANCELED. Adjust the code slightly
> to take this into account.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


