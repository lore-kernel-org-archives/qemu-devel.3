Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4E4FF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWy-0008Ja-BT; Tue, 07 Apr 2026 14:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wABTo-0003zm-N5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wA3EC-00060R-8h
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775556010;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I3BaSTqLz495XJE4RLhSIGgdqJbvfXtFZeqjjMWCekA=;
 b=iyHsD4XyNueFaPsHog55SJDZWDAOrWvDVQRr5aUZofLmFKqS2gxRC1ramorWxJH2lA6/Xk
 jF3ExDFEy6NF59E5YLy+mT1/e2uCG66KTc2LzS7MzIEjQeIT3ygFUPmc8r8Dr9IpKu3V86
 Ldh4f30RIuAPzFu1a4bsleppBsbcwV8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-7WkIX1yKPuC3_LzzYmdz6Q-1; Tue,
 07 Apr 2026 06:00:08 -0400
X-MC-Unique: 7WkIX1yKPuC3_LzzYmdz6Q-1
X-Mimecast-MFC-AGG-ID: 7WkIX1yKPuC3_LzzYmdz6Q_1775556007
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD0001956076; Tue,  7 Apr 2026 10:00:06 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 699C73000223; Tue,  7 Apr 2026 10:00:04 +0000 (UTC)
Date: Tue, 7 Apr 2026 11:00:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v3] Allow building qemu tools on 32-bit hosts
Message-ID: <adTVobzrgl8f6chd@redhat.com>
References: <adGTUNUSckx1KrAk@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adGTUNUSckx1KrAk@p100>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Apr 05, 2026 at 12:40:16AM +0200, Helge Deller wrote:
> Qemu's tools like qemu-img are often needed on 32-bit platforms,
> although the actual qemu emulators have been discontinued on 32-bit.

IMHO, the thought behind disabling 32-bit builds was not making
a statement about whether the code was useful on 32-bit platforms.
Users of 32-bit platforms will naturally always want to have as
much as possible available on their platform.

Rather it was that 32-bit platforms were no longer considered
important as targets by QEMU maintainers. The goal is thus to
reduce the set of targets that maintainers have to think about.

Thus the commit message needs to be justifying why 32-bit platforms
should still be treated as a target.

In terms of the impact on QEMU maintainers / subsystems we see

 * QEMU guest agent

    => util/, qapi/, qobject/, qom/, qga/

   Total about 300  C files

 * Adding in tools on top we also get

    => block/, chardev/, crypto/, io/, authz/, storage-daemon/

   Total about 700 C files


I'll support the build of QEMU guest agent on 32-bit, as we were
clear that we wanted to continue supporting 32-bit guests in
general.

I'm not in favour of re-introducing 32-bit support  for anything
else.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


