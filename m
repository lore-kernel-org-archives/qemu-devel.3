Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7BBCE7AE6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 08:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smU6x-00009F-Gx; Fri, 06 Sep 2024 04:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smU6v-0008OZ-DJ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1smU6t-0004SM-MW
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 04:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725610466;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2btlhTt0PhPNtxsVpmL+Sk04QcIJcZteUWFzD5DOM7k=;
 b=dbiHd5ATnCg8kOr2Vas8AIg5MRE0n7vD3BGAkI61H2AJ/rL7F6o6Iq2Bx0Thy7M0jfv2d7
 3YP5QiLgaQOVJFvjjRZhVoR32gd2u7mf+KtT/BjWd8txjMis1yQWLNOJASoK76auEiyO8s
 RHKCYTT+wW3vcpg+VlkiRf8W/2WhV+Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-XL6EV9P_PWa_oL2ZIU95Rg-1; Fri,
 06 Sep 2024 04:14:24 -0400
X-MC-Unique: XL6EV9P_PWa_oL2ZIU95Rg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B86B197730D; Fri,  6 Sep 2024 08:14:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC0971955D4A; Fri,  6 Sep 2024 08:14:14 +0000 (UTC)
Date: Fri, 6 Sep 2024 09:14:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 0/2] qtest: Log verbosity changes
Message-ID: <Ztq5068xW640qeuD@redhat.com>
References: <20240905210328.25393-1-farosas@suse.de>
 <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95d9509b-d9a5-467a-860a-91bcd4baae1f@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Sep 06, 2024 at 08:16:31AM +0200, Thomas Huth wrote:
> On 05/09/2024 23.03, Fabiano Rosas wrote:
> > Hi,
> > 
> > This series silences QEMU stderr unless the QTEST_LOG variable is set
> > and silences -qtest-log unless both QTEST_LOG and gtest's --verbose
> > flag is passed.
> > 
> > This was motivated by Peter Maydell's ask to suppress deprecation
> > warn_report messages from the migration-tests and by my own
> > frustration over noisy output from qtest.
> 
> Not sure whether we want to ignore stderr by default... we might also miss
> important warnings or error messages that way...?

I would prefer if our tests were quiet by default, and just printed
clear pass/fail notices without extraneous fluff. Having an opt-in
to see full messages from stderr feels good enough for debugging cases
where you need more info from a particular test.

Probably we should set verbose mode in CI though, since it is tedious
to re-run CI on failure to gather more info

> If you just want to suppress one certain warning, I think it's maybe best to
> fence it with "if (!qtest_enabled()) { ... }" on the QEMU side - at least
> that's what we did in similar cases a couple of times, IIRC.

We're got a surprisingly large mumber of if(qtest_enabled()) conditions
in the code. I can't help feeling this is a bad idea in the long term,
as its making us take different codepaths when testing from production.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


