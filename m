Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745DCE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 11:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJWNv-0000A7-EP; Fri, 06 Dec 2024 06:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJWNu-00009s-EM
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 06:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJWNl-0001dm-K4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 06:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733484022;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gfwD5NHS8rAs7xGrI5HVgGQc13g5v8lGHvToPj+6S2E=;
 b=SrVbdKBywWXzo41oEORb2YR2gkM0PjzAS2SDthohRE95afjhfxpyiv7iZ7PcE4tgRK5k/o
 xfD7aMBmilUGq1EqDFcC1uCe30PcjSmUpI2AEoU9FCIe14HQUoUJIu2KWjck4xlMmt9qbd
 Uskll0Pm59JaOQuZfCFZ5cbHi3BbMVQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-b0ARZomhP2uq9yEILIfkSw-1; Fri,
 06 Dec 2024 06:20:19 -0500
X-MC-Unique: b0ARZomhP2uq9yEILIfkSw-1
X-Mimecast-MFC-AGG-ID: b0ARZomhP2uq9yEILIfkSw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACA07195608A
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2024 11:20:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.160])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E2F51956095; Fri,  6 Dec 2024 11:20:17 +0000 (UTC)
Date: Fri, 6 Dec 2024 11:20:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/2] include: move include/qapi/qmp/ to include/qobject/
Message-ID: <Z1Ld7SCFGeyM9A54@redhat.com>
References: <20241118151235.2665921-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118151235.2665921-1-armbru@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 18, 2024 at 04:12:33PM +0100, Markus Armbruster wrote:
> To repeat the 1st patch commit message...
> 
> The general expectation is that header files should follow the same
> file/path naming scheme as the corresponding source file. There are
> various historical exceptions to this practice in QEMU, with one of
> the most notable being the include/qapi/qmp/ directory. Most of the
> headers there correspond to source files in qobject/.
> 
> This patch corrects that inconsistency by creating include/qobject/.
> The only outlier is include/qapi/qmp/dispatch.h which gets renamed
> to include/qapi/qmp-registry.h.
> 
> Changed in v3:
> 
>  - Rebased, trivial semantic conflict with commit 34fdd734c5d resolved
> 
>  - Drop extra blank line [Zhao Liu]
> 
>  - Instead of doing both the move to qobject/ and the rename of
>    qmp/dispatch.h to qmp-registry.h together in one patch per
>    top-level directory, do them separately, but tree-wide.

You kept my S-o-B on the v3 re-arrangement which is fine, so not sure if
you're looking for additional R-b before merging in 10.0 dev cycle. If so,
you can add:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


