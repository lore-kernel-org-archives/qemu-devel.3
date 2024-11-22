Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2255D75E59
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 14:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEUub-00011n-Tu; Fri, 22 Nov 2024 09:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tEUuQ-0000z4-Mb
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tEUuN-000106-BF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 09:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732286718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtHs2i7268Z2/INjT/SS12ySMUZMBxV5tvkpGmKoVic=;
 b=NViMmVJdQHZMrq1iyze1VElf9xqGv1jpw74K7vSdhWAWzCFqmVVTh7P84Jydl2LTQYaT83
 GQYY7BGbB3by6vf7d9GSVCtyRNTxtPgNVNwXxPze9VvhhrK8p0nvqdw32AeG9DaB9KruUV
 tWoEidTZtEyIVjB0T/Em54Pf1b80uIw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-asPGR2XcPR6iWZPOBzPRHg-1; Fri,
 22 Nov 2024 09:45:13 -0500
X-MC-Unique: asPGR2XcPR6iWZPOBzPRHg-1
X-Mimecast-MFC-AGG-ID: asPGR2XcPR6iWZPOBzPRHg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C90C1955D62; Fri, 22 Nov 2024 14:45:12 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.157])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BBE41955E99; Fri, 22 Nov 2024 14:45:08 +0000 (UTC)
Date: Fri, 22 Nov 2024 15:45:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 jjelen@redhat.com, mpitt@redhat.com
Subject: Re: [PATCH ssh v2] ssh: Do not switch session to non-blocking mode
Message-ID: <Z0CY8qQ7vdQ0EsLx@redhat.com>
References: <20241113125526.2495731-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113125526.2495731-1-rjones@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Am 13.11.2024 um 13:55 hat Richard W.M. Jones geschrieben:
> From: Jakub Jelen <jjelen@redhat.com>
> 
> The libssh does not handle non-blocking mode in SFTP correctly. The
> driver code already changes the mode to blocking for the SFTP
> initialization, but for some reason changes to non-blocking mode.
> This used to work accidentally until libssh in 0.11 branch merged
> the patch to avoid infinite looping in case of network errors:
> 
> https://gitlab.com/libssh/libssh-mirror/-/merge_requests/498
> 
> Since then, the ssh driver in qemu fails to read files over SFTP
> as the first SFTP messages exchanged after switching the session
> to non-blocking mode return SSH_AGAIN, but that message is lost
> int the SFTP internals and interpretted as SSH_ERROR, which is
> returned to the caller:
> 
> https://gitlab.com/libssh/libssh-mirror/-/issues/280
> 
> This is indeed an issue in libssh that we should address in the
> long term, but it will require more work on the internals. For
> now, the SFTP is not supported in non-blocking mode.
> 
> Fixes: https://gitlab.com/libssh/libssh-mirror/-/issues/280
> Signed-off-by: Jakub Jelen <jjelen@redhat.com>
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>

Thanks, applied to the block branch.

Kevin


