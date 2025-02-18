Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCA6C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 17:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkRqU-0005kN-3S; Tue, 18 Feb 2025 12:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkRqN-0005in-Ts
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:57:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkRqL-0004MH-FC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739901430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ohJmjIYbWqme2VjU7sggvr/n9MoswYfmC4VSlh5edw=;
 b=h+SHHjxcy7gn/c+gJSkqIc8ugWdwJxNzDEuNMf4HbztX0wum+7dsMA/lDvesKNZp2q7ia5
 +pXNMXmzOj2Urb8O+KsOh5rxE2tTBS+zmnDKHFXh1F6B8s8XyYGAmEfyMpDcbI8jRGSIAg
 woaN9l1M8aIse4s7genHEdlbgi5zYuc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-mFfBn5L5OxS6UEgd8evCAg-1; Tue,
 18 Feb 2025 12:57:09 -0500
X-MC-Unique: mFfBn5L5OxS6UEgd8evCAg-1
X-Mimecast-MFC-AGG-ID: mFfBn5L5OxS6UEgd8evCAg_1739901428
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1059B1800878; Tue, 18 Feb 2025 17:57:08 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C6821955BCB; Tue, 18 Feb 2025 17:57:04 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:57:02 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] rust: add module to convert between -errno and
 io::Error
Message-ID: <Z7TJ7hM8PcIOVOg2@redhat.com>
References: <20250213143216.3910163-1-pbonzini@redhat.com>
 <20250213143216.3910163-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213143216.3910163-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

Am 13.02.2025 um 15:32 hat Paolo Bonzini geschrieben:
> It is a common convention in QEMU to return a positive value in case of
> success, and a negated errno value in case of error.  Unfortunately,
> using errno portably in Rust is a bit complicated; on Unix the errno
> values are supported natively by io::Error, but on Windows they are not;
> so, use the libc crate.
> 
> This is a set of utility functions that are used by both chardev and
> block layer bindings.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

'make rustdoc' fails for me with this patch applied:

error: unresolved link to `io::Result`
   --> qemu-api/src/errno.rs:105:55
    |
105 |     /// A signed type that can be converted into an [`io::Result`]
    |                                                       ^^^^^^^^^^ no item named `io` in scope
    |
    = note: requested on the command line with `-D rustdoc::broken-intra-doc-links`

error: unresolved link to `io::Result`
   --> qemu-api/src/errno.rs:114:46
    |
114 |     /// A type that can be taken out of an [`io::Result`] and converted
    |                                              ^^^^^^^^^^ no item named `io` in scope

error: unresolved link to `into_neg_errno`
   --> qemu-api/src/errno.rs:118:15
    |
118 |         /// [`into_neg_errno`].
    |               ^^^^^^^^^^^^^^ no item named `into_neg_errno` in scope
    |
    = help: to escape `[` and `]` characters, add '\' before them like `\[` or `\]`

error: could not document `qemu_api`

Kevin


