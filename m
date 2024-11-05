Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F19CD2C122
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L9W-00059C-HO; Tue, 05 Nov 2024 10:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8L9U-00058G-2D
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8L9Q-0001S8-5W
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730819241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDOCs9AzKFq/5DyCUiVzD2R0kPMRzr6ywh8PyNjLNGA=;
 b=YHep06ILSVY9M3AwwJQpm5NBn60c/8k+atFUMtL0ctWs+rM+rYA/UQiG/rhowNC7tPRUAt
 wYDo/FAsx8nUkD1bBkXnc2JOSRyuQZI5sTzPbGaK9l5vRBMUt7eULUHaP2ibSXD9DqmfI6
 f6aJ5snR1ANx1lIH2y5RjoJodcXT2/Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-Z4q-zZTjMiqHQ4ncP5Hghg-1; Tue,
 05 Nov 2024 10:07:20 -0500
X-MC-Unique: Z4q-zZTjMiqHQ4ncP5Hghg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19EAA1955F29
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2024 15:07:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64BA919560AD; Tue,  5 Nov 2024 15:07:15 +0000 (UTC)
Date: Tue, 5 Nov 2024 15:07:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] crypto: purge 'loaded' property that was documented as
 already removed
Message-ID: <Zyo0n0pJY1BI4-TT@redhat.com>
References: <20241030084718.2980247-1-berrange@redhat.com>
 <874j4nzagr.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874j4nzagr.fsf@pond.sub.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 04, 2024 at 09:09:40AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > The 'loaded' property on TLS creds and secret objects was marked as
> > deprected in 6.0.0 and then marked as removed in 7.1.0.
> 
> deprecated
> 
> Regarding "marked as removed": not quite.  Its entry was moved from
> docs/about/deprecated.rst to docs/about/removed-features.rst, but the
> text there is "should simply be removed."
> 
> >
> > Except it wasn't actually removed, it was just made read-only, while
> > claiming it was removed. Finish the long overdue removal job.
> >
> > Fixes: 0310641c06dd5f7ea031b2b6170cb2edc63e4cea
> 
> I'm not sure it fixes something that was broken.  Commit 0310641c06d
> (crypto: make loaded property read-only) did what it said on the tin.
> What it did was unusual, and maybe a bad idea.

I'm re-wording the commit message to:

  The 'loaded' property on TLS creds and secret objects was marked as
  deprecated in 6.0.0. In 7.1.0 the deprecation info was moved into
  the 'removed-features.rst' file, but the property was not actually
  removed, just made read-only. This was a highly unusual practice,
  so finish the long overdue removal job.

and removing the "Fixes" tag

> 
> Anyway, not important now.
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


