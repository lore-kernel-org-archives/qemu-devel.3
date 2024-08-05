Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABCBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauX4-0005SG-O4; Mon, 05 Aug 2024 06:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sauX3-0005D3-9V
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sauX1-00026l-8Y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 06:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722852092;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ztgT8ra/T2koBE+RWMqzRZZj3ngMYY96BS9nQ4dkgLw=;
 b=WDWuzT146Eh/l5YLJBOp2CCjsx6J1nVV5RH45H4E8/7kJTI9GyQ1LXN7bxgXjlEpA8j5zN
 UUztiPOzw2uaAwCqDT/vZajaSEr5bUOy9AvCWFHmF/+nfiJ6Z6iUwQEXomGULrI+RuTWoZ
 gEf0p819XnbSuwanT6sAXmsz7JL3wVw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-AHo1aTqeMzSbUXPWusr3lg-1; Mon,
 05 Aug 2024 06:01:29 -0400
X-MC-Unique: AHo1aTqeMzSbUXPWusr3lg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD6191955D4E; Mon,  5 Aug 2024 10:01:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9F6219560AE; Mon,  5 Aug 2024 10:01:23 +0000 (UTC)
Date: Mon, 5 Aug 2024 11:01:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <ZrCi8DWCKFiBHQAQ@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zpk7Mf2c7LiNV2xC@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Jul 18, 2024 at 11:56:33AM -0400, Peter Xu wrote:
> Steve,
> 
> On Sun, Jun 30, 2024 at 12:40:23PM -0700, Steve Sistare wrote:
> > What?
> 
> Thanks for trying out with the cpr-transfer series.  I saw that that series
> missed most of the cc list here, so I'm attaching the link here:
> 
> https://lore.kernel.org/r/1719776648-435073-1-git-send-email-steven.sistare@oracle.com
> 
> I think most of my previous questions for exec() solution still are there,
> I'll try to summarize them all in this reply as much as I can.
> 
> > 
> > This patch series adds the live migration cpr-exec mode, which allows
> > the user to update QEMU with minimal guest pause time, by preserving
> > guest RAM in place, albeit with new virtual addresses in new QEMU, and
> > by preserving device file descriptors.
> > 
> > The new user-visible interfaces are:
> >   * cpr-exec (MigMode migration parameter)
> >   * cpr-exec-command (migration parameter)
> 
> I really, really hope we can avoid this..
> 
> It's super cumbersome to pass in a qemu cmdline in a qemu migration
> parameter.. if we can do that with generic live migration ways, I hope we
> stick with the clean approach.

A further issue I have is that it presumes the QEMU configuration is
fully captured by the command line. We have a long term design goal
in QEMU to get away from specifying configuration on the command
line, and move entirely to configuring QEMU via a series of QMP
commands.

This proposed command is introducing the concept of command line argv
as a formal part of the QEMU API and IMHO that is undesirable. Even
today we have backend configuration steps only done via QMP, and I'm
wondering how it would fit in with how mgmt apps currently doing live
migration.

The flipside, however, is that localhost migration via 2 separate QEMU
processes has issues where both QEMUs want to be opening the very same
file, and only 1 of them can ever have them open.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


