Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10167C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti8pz-0007oJ-3Z; Wed, 12 Feb 2025 04:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ti8pt-0007nJ-BD
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:15:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ti8pq-00058a-55
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739351709;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=m0BZMlZT23Te3S/Q9txjapM6b3rZEBIlCAVcc4tpnPo=;
 b=IcrA/0kCE7CM7r5UEEMCo85pe/UMADQ/rncwHF64A4iIuLr7D2qwn9pvycSjdQSU6gFq2Z
 +T8Oke0cZp/iXcAuFrnudN2YbfwTVKjIDTUMif5bfy/oF7dMlJ9gSbo+CBY5v5uEYvubH1
 dC7ePHhhfkzOYtnDbVMNGCCsrBop3vQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-aJVUjrkbP4eQRylX53aSXQ-1; Wed,
 12 Feb 2025 04:15:06 -0500
X-MC-Unique: aJVUjrkbP4eQRylX53aSXQ-1
X-Mimecast-MFC-AGG-ID: aJVUjrkbP4eQRylX53aSXQ_1739351705
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 201521800874; Wed, 12 Feb 2025 09:15:04 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4314C18004A7; Wed, 12 Feb 2025 09:15:00 +0000 (UTC)
Date: Wed, 12 Feb 2025 09:14:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/11] bochs-rs: Add bochs block driver reimplementation
 in Rust
Message-ID: <Z6xmkfyb37YDBz1o@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211214328.640374-11-kwolf@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 11, 2025 at 10:43:27PM +0100, Kevin Wolf wrote:
> This adds a separate block driver for the bochs image format called
> 'bochs-rs' so that for the moment both the C implementation and the Rust
> implementation can be present in the same build. The intention is to
> remove the C implementation eventually and rename this one into 'bochs'.
> This can only happen once Rust can be a hard build dependency for QEMU.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  rust/block/Cargo.toml    |   2 +-
>  rust/block/src/bochs.rs  | 296 +++++++++++++++++++++++++++++++++++++++
>  rust/block/src/driver.rs |   5 -
>  rust/block/src/lib.rs    |   1 +
>  4 files changed, 298 insertions(+), 6 deletions(-)
>  create mode 100644 rust/block/src/bochs.rs
> 
> diff --git a/rust/block/Cargo.toml b/rust/block/Cargo.toml
> index 70ee02f429..1c06f3a00c 100644
> --- a/rust/block/Cargo.toml
> +++ b/rust/block/Cargo.toml
> @@ -3,7 +3,7 @@ name = "block"
>  version = "0.1.0"
>  edition = "2021"
>  authors = ["Kevin Wolf <kwolf@redhat.com>"]
> -license = "GPL-2.0-or-later"
> +license = "GPL-2.0-or-later AND MIT"
>  readme = "README.md"
>  description = "Block backends for QEMU"
>  repository = "https://gitlab.com/qemu-project/qemu/"
> diff --git a/rust/block/src/bochs.rs b/rust/block/src/bochs.rs
> new file mode 100644
> index 0000000000..388ac5ef03
> --- /dev/null
> +++ b/rust/block/src/bochs.rs
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: MIT

Why MIT instead of our normal GPL-2.0-or-later.

Using Rust conversion to eliminate GPL usage for permissive licenses
like MIT is not something I'd like to see us doing.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


