Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5474ECCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 09:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqqvS-0003bY-Nq; Wed, 18 Sep 2024 05:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sqqvN-0003at-OP
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 05:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sqqvL-00043n-NK
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 05:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726651473;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Iz67smzzOXZyMTU9nhdny5TDC7LdQBbHvNtUHEwpvv8=;
 b=YqfeLrjppdY6Gvuq8hGfsEMhBcJocUuuIfdzwRxXFjvbO7Bqt+FQ7ePR/FGVIYrgpQxSnE
 50oYTr0Lv/x+bTtfCLmfZAmCBpg7jCWhGKizezoQAd5Z+oYx7BM5cGftPWh9K5z6bP7jQu
 HEEBfBw/wOPsm3ug5QJJrZBOh1EFP8g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-HpZYkV6TOHK-UOYg2yZW8Q-1; Wed,
 18 Sep 2024 05:24:29 -0400
X-MC-Unique: HpZYkV6TOHK-UOYg2yZW8Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 292F81944AA4; Wed, 18 Sep 2024 09:24:28 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.29])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBC9E30001A1; Wed, 18 Sep 2024 09:24:25 +0000 (UTC)
Date: Wed, 18 Sep 2024 11:24:22 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: flakiness on CI jobs run via k8s
Message-ID: <ZuqcRvjd9f3YGutx@redhat.com>
References: <CAFEAcA9ZsxwZb_=A15pUXDF+HH=sD-B8zm1j8MMJ-mPsZNP62Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ZsxwZb_=A15pUXDF+HH=sD-B8zm1j8MMJ-mPsZNP62Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 17, 2024 at 04:48:45PM +0100, Peter Maydell wrote:
> I notice that a lot of the CI job flakiness I'm seeing with main
> CI runs involves jobs that are run via the k8s runners. Notably
> cross-i686-tci and cross-i686-system and cross-i686-user are like this.
> These jobs run with no flakiness that I've noticed when they're run
> by an individual gitlab user (in which case they're not running on
> k8s, I believe). So something seems to be up with the environment
> we're using to run the jobs for the main CI. My impression is that
> the time things take to run can be very variable, especially if the
> CI job believes the reported number of CPUs and actually tries to run
> 8 or 9 test cases in parallel.
> 
> Any ideas what might be causing issues here, or config tweaks
> we might be able to make to ensure that the environment reports
> to the CI job a number of CPUs/etc that accurately reflects
> the amount of resource it really has?

Didn't we change the hosting for our k8s runners recently ? They were
running on Azure, but I vaguely recall hearing that it was being
switched again.

Anyway, perhaps the cloud provider is over-committing the env such
that we have excessive streal time and thus not getting the full
power of the CPUs we expect.  I know gitlab's own public runners
will suffer from this periodically, due to the very cheap VMs they
host on.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


