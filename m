Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45287C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiCLX-0003Z6-Ot; Wed, 12 Feb 2025 08:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiCLN-0003WG-Pz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:59:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiCLM-0006ef-4X
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739365195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wc4/Q1W0a+4tLmco6sghMMYJbLkjgJQj5rqyt1VOpg0=;
 b=dGirav5ALoLLGx6v8pSjKmWqvLAL2igJlldtGH8p3COm8SBSXdaEzacfMpeDdsiXV+IkAK
 ih5naG6kn1bdGniu0dIYaBigrLYlMVPnIwk+AzGDv0IMPv/xW2V01BHk+XiMWw9LZvgKbv
 pWFz+0lKdm1KItIkmyA60tHMWQPllQk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-UObP2Dh-OB-OLaH3H3KRfQ-1; Wed,
 12 Feb 2025 07:59:52 -0500
X-MC-Unique: UObP2Dh-OB-OLaH3H3KRfQ-1
X-Mimecast-MFC-AGG-ID: UObP2Dh-OB-OLaH3H3KRfQ_1739365191
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF9711956050; Wed, 12 Feb 2025 12:59:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9492A1800365; Wed, 12 Feb 2025 12:59:48 +0000 (UTC)
Date: Wed, 12 Feb 2025 13:59:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/11] bochs-rs: Add bochs block driver reimplementation
 in Rust
Message-ID: <Z6ybQQRnmo8MljdY@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-11-kwolf@redhat.com>
 <0e3d0835-c216-4f8c-8b97-e849ecb5ca47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e3d0835-c216-4f8c-8b97-e849ecb5ca47@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Am 12.02.2025 um 08:45 hat Philippe Mathieu-Daudé geschrieben:
> On 11/2/25 22:43, Kevin Wolf wrote:
> > This adds a separate block driver for the bochs image format called
> > 'bochs-rs' so that for the moment both the C implementation and the Rust
> > implementation can be present in the same build. The intention is to
> > remove the C implementation eventually and rename this one into 'bochs'.
> > This can only happen once Rust can be a hard build dependency for QEMU.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   rust/block/Cargo.toml    |   2 +-
> >   rust/block/src/bochs.rs  | 296 +++++++++++++++++++++++++++++++++++++++
> >   rust/block/src/driver.rs |   5 -
> >   rust/block/src/lib.rs    |   1 +
> >   4 files changed, 298 insertions(+), 6 deletions(-)
> >   create mode 100644 rust/block/src/bochs.rs
> 
> 
> > diff --git a/rust/block/src/bochs.rs b/rust/block/src/bochs.rs
> > new file mode 100644
> > index 0000000000..388ac5ef03
> > --- /dev/null
> > +++ b/rust/block/src/bochs.rs
> > @@ -0,0 +1,296 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Block driver for the various disk image formats used by Bochs
> > + * Currently only for "growing" type in read-only mode
> > + *
> > + * Copyright (c) 2005 Alex Beregszaszi
> > + * Copyright (c) 2024 Red Hat
> > + *
> > + * Authors:
> > + *   Alex Beregszaszi
> > + *   Kevin Wolf <kwolf@redhat.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > + * of this software and associated documentation files (the "Software"), to deal
> > + * in the Software without restriction, including without limitation the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> 
> As an addition, we don't have to add the full license boilerplate IMO...

IANAL, but the license says "The above copyright notice and this
permission notice shall be included in all copies or substantial
portions of the Software.", so keeping it feels like the safe option.

Kevin


