Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487F7C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvE6y-0003Zf-Bp; Thu, 20 Mar 2025 07:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tvE6g-0003Ym-AL
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tvE6c-0000bA-W3
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742470232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DIQHmzmLdPE+h+jSjUJtPaYaIPpGC0D+zcpElNjNaI8=;
 b=TEPL3ngMVrAyECDiq+kCl/KxpvdQnNpJ5Gde5HiABNkGJ7V3hxWNhe//bpyuB9+Va7G91A
 4iPaf8MuE84VGJXbtiYWG+BOPi1ICFWUITvK4D9vnf9uorJNTmOxEmi1Rv9N2Y3kfxAg83
 5j4IngW0CL99BC638DDLBT1jQPFcq1k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-cylvoJe1NNK06jNCjpdRHA-1; Thu,
 20 Mar 2025 07:30:27 -0400
X-MC-Unique: cylvoJe1NNK06jNCjpdRHA-1
X-Mimecast-MFC-AGG-ID: cylvoJe1NNK06jNCjpdRHA_1742470226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 849F1196D2D0; Thu, 20 Mar 2025 11:30:25 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.84])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90A54180094A; Thu, 20 Mar 2025 11:30:21 +0000 (UTC)
Date: Thu, 20 Mar 2025 12:30:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH] block: Fix bdrv_activate() not to fail without medium
Message-ID: <Z9v8SjOHxEm4ouXM@redhat.com>
References: <20250312143758.1660177-1-armbru@redhat.com>
 <Z9KwszV4pQ-Kw0es@redhat.com> <87tt7x87um.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt7x87um.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

Am 13.03.2025 um 12:53 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 12.03.2025 um 15:37 hat Markus Armbruster geschrieben:
> >> bdrv_activate() returns failure without setting an error when
> >> !bs->drv.  This is suspicious.  Turns out it used to succeed then,
> >> until commit 5416645fcf82 changed it to return -ENOMEDIUM.
> >> 
> >> Return zero instead.
> >> 
> >> Fixes: 5416645fcf82 (block: return error-code from bdrv_invalidate_cache)
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > The commit message sounds more theoretical. Did you find this only by
> > code inspection? Do we know what the effect on real-world cases is, so
> > we could add a sentence about it to the commit message? Maybe we could
> > even have a qemu-iotests case to show the effect?
> >
> > I absolutely agree that returning -ENOMEDIUM while not setting errp is
> > wrong. But without an example of what is affected, it's not obvious to
> > me which part of it needs to be fixed.
> 
> Code inspection.
> 
> Here's my somewhat extended rationale for my fix.
> [...]

> Not failing the function on !bs->drv is clearly intentional.
> 
> Behavior stayed this way for more than six years.  Then commit
> 5416645fcf8 (block: return error-code from bdrv_invalidate_cache)
> changed the function to return zero on success, a negative errno on
> failure.  According to the commit message, the patch is mere cleanup,
> and not supposed to change behavior.
> 
> Since the first return was a success before the patch (no error set),
> the correct value to return was zero.  The patch used -ENOMEDIUM
> instead.  This is a clear regression.
> 
> My patch restores previous behavior.

I understand your rationale and don't disagree with your patch.
But I would still like the commit message to explain the practical
consequences of the bug and if possible a test case.

If you tried to find the practical consequences and couldn't find any
way to trigger a bug as a user, that is worth documenting, too.

Kevin


