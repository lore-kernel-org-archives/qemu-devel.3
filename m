Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8B5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0fh-0006ii-22; Mon, 18 May 2026 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0ff-0006i6-6E
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wP0fd-0005Cg-Du
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779121100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZy0OU1N8ft6zOxGnJCl27Tw09WA7Y41+QRsOSq/xQw=;
 b=eCtj2NiVnIM1i+Z28zVV+zfOuc8nsatIS5eRXTVI6ZAp5FwhxeKJlDYK7+68tl2n8ZAGcI
 jHg75N2pPF9Cg4FNy5boE1PURNG1/ZVUH0fppeVZAE0wRQFpILaXsyIIJsmMLSgrWnIPeS
 NoaTRObcY8S25SnEiuYh1M/VYupxPCQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-NlPZboUhMGGSGxH2Dm7Wtw-1; Mon,
 18 May 2026 12:18:18 -0400
X-MC-Unique: NlPZboUhMGGSGxH2Dm7Wtw-1
X-Mimecast-MFC-AGG-ID: NlPZboUhMGGSGxH2Dm7Wtw_1779121098
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED95D195608F; Mon, 18 May 2026 16:18:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A3CE30002DD; Mon, 18 May 2026 16:18:16 +0000 (UTC)
Date: Mon, 18 May 2026 17:18:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] system/rtc: Fix a possible year-2038 integer overflow
 problem
Message-ID: <ags7xIsUG2DqX5vu@redhat.com>
References: <20260518160255.1844308-1-thuth@redhat.com>
 <ags5_IDkvxClCdHm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ags5_IDkvxClCdHm@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 18, 2026 at 05:10:36PM +0100, Daniel P. Berrangé wrote:
> On Mon, May 18, 2026 at 06:02:55PM +0200, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> > 
> > rtc_realtime_clock_offset is initialized with:
> > 
> >   rtc_realtime_clock_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
> > 
> > And QEMU_CLOCK_REALTIME might be based on gettimeofday() in certain
> > cases (see get_clock_realtime() in include/qemu/timer.h). So this
> > counter will exceed 32 bits in the year 2038, thus we should not
> > store this value in a normal integer variable. Change it to an int64_t
> > to fix the problem.
> > And while we're at it, also adjust the nearby rtc_host_datetime_offset
> > variable to be on the safe side in the related code.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  system/rtc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Actually on second reading I think this patch is not quite right.
The code which uses the value is:

    time_t value = qemu_clock_get_ms(clock) / 1000;
    switch (clock) {
    case QEMU_CLOCK_REALTIME:
        value -= rtc_realtime_clock_offset;


On 64-bit platforms 'int' was 64-bit already and so was time_t so we
have no bug to fix.

On 32-bit platforms the patch fixes 'int' to 'int64' which is fine
but that int64 value is then subtracted from time_t which is usually
going to be 32-bit again, unless the OS was built with 64-bit time_t
on 32-bit which almost no one does.

IOW we only platform this fixes is 32-bit OS with 64-bit time_t.

We can't do any better than that as the caller code paths need a
time_t to pass into gmtime/localtime.

So IMHO we should just declare it as time_t. 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


