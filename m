Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5263FC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjJk-0003FG-3X; Fri, 17 Jan 2025 05:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYjJi-0003Dm-HP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYjJd-0001bB-U7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737108660;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+Mp/x+/ogPHuu7PB5/FkjauJT57NxP0CE3V1Kpk01Jo=;
 b=PPDFAvu/q+vbbC4Z7uwTqJNFPi4G9ESgN037zUlvgku/ZAmGqo0Zxy8G4IIWP2EI0UZYH2
 iANToyTI4m6sucB/L4G1yOC4uY0awtnyka/waxwT7ln02Ci81VFK2qBSsomLc04fCA+W5e
 sR3kLoT2ZoNzT6dHFfgKrK3auMWTREE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-mNirULXQP4GP6LpAoENbgg-1; Fri,
 17 Jan 2025 05:10:58 -0500
X-MC-Unique: mNirULXQP4GP6LpAoENbgg-1
X-Mimecast-MFC-AGG-ID: mNirULXQP4GP6LpAoENbgg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C04B319560BA
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:10:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15B5C195608A; Fri, 17 Jan 2025 10:10:54 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:10:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v3 1/8] qapi: golang: Generate enum type
Message-ID: <Z4osq2u_UIQOGfze@redhat.com>
References: <20250110104946.74960-1-victortoso@redhat.com>
 <20250110104946.74960-2-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110104946.74960-2-victortoso@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 10, 2025 at 11:49:39AM +0100, Victor Toso wrote:
> This patch handles QAPI enum types and generates its equivalent in Go.
> We sort the output based on enum's type name.
> 
> Enums are being handled as strings in Golang.
> 
> 1. For each QAPI enum, we will define a string type in Go to be the
>    assigned type of this specific enum.
> 
> 2. Naming: CamelCase will be used in any identifier that we want to
>    export, which is everything.
> 
> Example:
> 
> qapi:
>   | ##
>   | # @DisplayProtocol:
>   | #
>   | # Display protocols which support changing password options.
>   | #
>   | # Since: 7.0
>   | ##
>   | { 'enum': 'DisplayProtocol',
>   |   'data': [ 'vnc', 'spice' ] }
> 
> go:
>   | // Display protocols which support changing password options.
>   | //
>   | // Since: 7.0
>   | type DisplayProtocol string
>   |
>   | const (
>   | 	DisplayProtocolVnc   DisplayProtocol = "vnc"
>   | 	DisplayProtocolSpice DisplayProtocol = "spice"
>   | )
> 
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/golang.py | 266 +++++++++++++++++++++++++++++++++++++++++
>  scripts/qapi/main.py   |   3 +
>  2 files changed, 269 insertions(+)
>  create mode 100644 scripts/qapi/golang.py
> 
> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> new file mode 100644
> index 0000000000..1e04c99f1c
> --- /dev/null
> +++ b/scripts/qapi/golang.py
> @@ -0,0 +1,266 @@
> +"""
> +Golang QAPI generator
> +"""
> +
> +# Copyright (c) 2025 Red Hat Inc.
> +#
> +# Authors:
> +#  Victor Toso <victortoso@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.
> +# See the COPYING file in the top-level directory.

Did you mean to say GPL-2.0-only ? Generally we'd expect
new code to be GPL-2.0-or-later.

Also we'd now desire "SPDX-License-Identifier: GPL-2.0-or-later"
for any newly added files, which reminds me to finish my patches
to checkpatch.pl to enforce SPDX usage.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


