Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2802DCA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf7M-0005vC-Fn; Mon, 08 Sep 2025 12:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf7J-0005oa-QQ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf75-0001VP-6q
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350382;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDgUPuq7rPdtTPrif2U7Podh1uLZSUy5YpovD84eObM=;
 b=QN7lVIArs1fx+bwMA/nFiJFtn/IDni0ZuQE88YQXkeom1EGhKC5lKJNs2epWKCovbK4Eir
 haockJSsgT3/KvRKqUBHeoI6IklBKhSsoVkAP6kL5P8fseDrDKtN7Uzgy7gURtbKqIIUHI
 RWC8BtzZblGpfbhYOo4KvkilRl++4RY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-RUe0pwVAMt-s0IHcG13LSg-1; Mon,
 08 Sep 2025 12:53:00 -0400
X-MC-Unique: RUe0pwVAMt-s0IHcG13LSg-1
X-Mimecast-MFC-AGG-ID: RUe0pwVAMt-s0IHcG13LSg_1757350379
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DDD919560A1; Mon,  8 Sep 2025 16:52:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1094E300018D; Mon,  8 Sep 2025 16:52:56 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:52:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [PATCH v2 12/18] python: backport 'avoid creating additional
 event loops per thread'
Message-ID: <aL8J5X86g9ND21-u@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-13-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903051125.3020805-13-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 03, 2025 at 01:11:18AM -0400, John Snow wrote:
> This commit is two backports squashed into one to avoid regressions.
> 
> python: *really* remove get_event_loop
> 
> A prior commit, aa1ff990, switched away from using get_event_loop *by
> default*, but this is not good enough to avoid deprecation warnings as
> `asyncio.get_event_loop_policy().get_event_loop()` is *also*
> deprecated. Replace this mechanism with explicit calls to
> asyncio.get_new_loop() and revise the cleanup mechanisms in __del__ to
> match.
> 
> python: avoid creating additional event loops per thread
> 
> "Too hasty by far!", commit 21ce2ee4 attempted to avoid deprecated
> behavior altogether by calling new_event_loop() directly if there was no
> loop currently running, but this has the unfortunate side effect of
> potentially creating multiple event loops per thread if tests
> instantiate multiple QMP connections in a single thread. This behavior
> is apparently not well-defined and causes problems in some, but not all,
> combinations of Python interpreter version and platform environment.
> 
> Partially revert to Daniel Berrange's original patch, which calls
> get_event_loop and simply suppresses the deprecation warning in
> Python<=3.13. This time, however, additionally register new loops
> created with new_event_loop() so that future calls to get_event_loop()
> will return the loop already created.
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> cherry picked from commit 21ce2ee4f2df87efe84a27b9c5112487f4670622
> cherry picked from commit c08fb82b38212956ccffc03fc6d015c3979f42fe
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/qmp/legacy.py  | 46 +++++++++++++++++++++++---------------
>  python/qemu/qmp/qmp_tui.py | 10 ++-------
>  python/qemu/qmp/util.py    | 27 ++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 26 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


