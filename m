Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A26C0219E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 09:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti9FK-0008Mg-Kj; Wed, 12 Feb 2025 04:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ti9FG-0008ML-S9
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:41:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ti9FE-0003m6-QE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 04:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739353283;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOTLUYLGHCWUbAJxXyAYY0YlbfOnJyO/xXd+eL/scpk=;
 b=EuPTldL4fb8kEQET4UJ07QehWPP60M1hNKDob7T1pGKKgYCNevG0WEgIzR8MUmEgoPqGbv
 f64tO500vJ9DSHFVDccogFAbOaNrBcA5P8dUC7bic7BE4WP266TDlictvZp51DxSYk9GtE
 PeNTpbXw0/KBEu8qKHr+qArMXypCXxg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-wD4pvKNWOZ2s1Q_WKJ07_Q-1; Wed,
 12 Feb 2025 04:41:21 -0500
X-MC-Unique: wD4pvKNWOZ2s1Q_WKJ07_Q-1
X-Mimecast-MFC-AGG-ID: wD4pvKNWOZ2s1Q_WKJ07_Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B3E3195608E; Wed, 12 Feb 2025 09:41:20 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A00AC1800359; Wed, 12 Feb 2025 09:41:16 +0000 (UTC)
Date: Wed, 12 Feb 2025 09:41:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, hreitz@redhat.com,
 pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/11] bochs-rs: Add bochs block driver reimplementation
 in Rust
Message-ID: <Z6xsuCCRQWpFntxx@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-11-kwolf@redhat.com>
 <Z6xmkfyb37YDBz1o@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6xmkfyb37YDBz1o@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Wed, Feb 12, 2025 at 09:14:57AM +0000, Daniel P. Berrangé wrote:
> On Tue, Feb 11, 2025 at 10:43:27PM +0100, Kevin Wolf wrote:
> > This adds a separate block driver for the bochs image format called
> > 'bochs-rs' so that for the moment both the C implementation and the Rust
> > implementation can be present in the same build. The intention is to
> > remove the C implementation eventually and rename this one into 'bochs'.
> > This can only happen once Rust can be a hard build dependency for QEMU.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  rust/block/Cargo.toml    |   2 +-
> >  rust/block/src/bochs.rs  | 296 +++++++++++++++++++++++++++++++++++++++
> >  rust/block/src/driver.rs |   5 -
> >  rust/block/src/lib.rs    |   1 +
> >  4 files changed, 298 insertions(+), 6 deletions(-)
> >  create mode 100644 rust/block/src/bochs.rs
> > 
> > diff --git a/rust/block/Cargo.toml b/rust/block/Cargo.toml
> > index 70ee02f429..1c06f3a00c 100644
> > --- a/rust/block/Cargo.toml
> > +++ b/rust/block/Cargo.toml
> > @@ -3,7 +3,7 @@ name = "block"
> >  version = "0.1.0"
> >  edition = "2021"
> >  authors = ["Kevin Wolf <kwolf@redhat.com>"]
> > -license = "GPL-2.0-or-later"
> > +license = "GPL-2.0-or-later AND MIT"
> >  readme = "README.md"
> >  description = "Block backends for QEMU"
> >  repository = "https://gitlab.com/qemu-project/qemu/"
> > diff --git a/rust/block/src/bochs.rs b/rust/block/src/bochs.rs
> > new file mode 100644
> > index 0000000000..388ac5ef03
> > --- /dev/null
> > +++ b/rust/block/src/bochs.rs
> > @@ -0,0 +1,296 @@
> > +// SPDX-License-Identifier: MIT
> 
> Why MIT instead of our normal GPL-2.0-or-later.
> 
> Using Rust conversion to eliminate GPL usage for permissive licenses
> like MIT is not something I'd like to see us doing.

My bad. I should have noticed that the original bochs.c was also MIT,
so I presume you're considering this Rust impl to be a derived work.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


