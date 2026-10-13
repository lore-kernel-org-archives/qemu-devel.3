Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22279CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGdzH-000782-Fs; Tue, 13 Oct 2026 11:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGdzF-00076s-7Y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGdzB-0007X5-Vr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791903613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BRhH9I83JFwlSgyiWhq+Jj2IVq/3j5+7q64OpozDJzo=;
 b=Hvj3QoyPIpdqtJ32qfBJJ/0WCuwwc6kHxkKj62wvCU2xcQiREVcS0F557BdL6Pb5kFUdaP
 Ik6HwPA2J9gBBkFSgGCkUWJu54V3upLkPKELdsNWePQ5kpOKOsIAKafgIJaSs6kdDgdZSn
 pLyZ6VbhZwjWUKgMYpaudBij7BYv7Fg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-IN_O7ICbOg2x_37JkFTWZQ-1; Tue,
 13 Oct 2026 15:00:10 +0000
X-MC-Unique: IN_O7ICbOg2x_37JkFTWZQ-1
X-Mimecast-MFC-AGG-ID: IN_O7ICbOg2x_37JkFTWZQ_1791903609
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEA62182A138; Tue, 13 Oct 2026 15:00:08 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A07671955F73; Tue, 13 Oct 2026 15:00:06 +0000 (UTC)
Date: Tue, 13 Oct 2026 10:00:04 -0500
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: [PULL 02/15] qemu-nbd: Support -s and -l at the same time
Message-ID: <as0GYTta_kysg6vR@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
 <20261008131216.2437896-19-eblake@redhat.com>
 <45a86ce8-6db9-4636-b64f-577469a50901@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a86ce8-6db9-4636-b64f-577469a50901@linaro.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 09, 2026 at 12:40:59PM +0200, Richard Henderson wrote:
> On 10/8/26 15:11, Eric Blake wrote:
> > @@ -1155,13 +1165,17 @@ int main(int argc, char **argv)
> > 
> >       blk_set_enable_write_cache(blk, !writethrough);
> > 
> > +    orig_bs = bs;
> > +    if (flags & BDRV_O_SNAPSHOT) {
> > +        orig_bs = bs->backing->bs;
> > +    }
> 
> tsan complains:
> 
> ../qemu-nbd.c:1170:23: error: reading variable 'backing' requires holding
> mutex 'graph_lock' [-Werror,-Wthread-safety-analysis]
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/17055360066

Thanks for the heads up. I got a TSAN build working on my environment,
fixed up the problem, and posted a v2 pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


