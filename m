Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F9C103A9AD
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Mef-0003MT-5q; Wed, 25 Mar 2026 07:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5Med-0003MJ-JT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5Mec-0007A2-3G
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 07:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774439043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IuzjRHctLZzfHYT065EpPRA9821a5ZEiQ0scrN3VRWw=;
 b=Nv/AMkgAG8Dw2aY9WvJ36Bpa1cjpSvcA1KnEWM4Y3XMQn0gCBobcM4eHb7zhHJZYLqz22a
 KSLw6GKAMl/6OtWD7u/QDVKlg+nSEu7N0Pok6WmnoHMELG0lR/ukXGSG7Krx34ssyE3w0q
 Vnjsz12vh9E7NdWDDDCg9dZGST2Vyw0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-9-GK3N0jMXOUpbkl1Vzkow-1; Wed,
 25 Mar 2026 07:43:59 -0400
X-MC-Unique: 9-GK3N0jMXOUpbkl1Vzkow-1
X-Mimecast-MFC-AGG-ID: 9-GK3N0jMXOUpbkl1Vzkow_1774439038
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66CF91800610; Wed, 25 Mar 2026 11:43:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFA541955F2E; Wed, 25 Mar 2026 11:43:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9245F21E6937; Wed, 25 Mar 2026 12:43:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,  "Daniel P. Berrange"
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Konstantin Kostiuk
 <kkostiuk@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: Cleaning up contrib/ and tools/
In-Reply-To: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 24 Mar 2026 17:09:33 +0000")
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
Date: Wed, 25 Mar 2026 12:43:55 +0100
Message-ID: <87tsu4m8w4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> We have a couple of directories in our source tree which have
> accumulated things in them that don't really belong there; this is a
> proposal to clean up by moving things to more appropriate locations
> (as 11.1 work, obviously).
>
> Firstly, contrib/ has a tendency to be a dumping ground for stuff that
> we didn't think hard enough about finding a good home for, and for
> things in a weird "not really maintained" state. We should either
> (a) care enough about something to give it a correct home and to
> maintain it, or (b) not care about it, and kick it out of our tree.
>
> Secondly, tools/ exists but is very under-used. I think it should be
> for the set of standalone tools that we build if you configure
> --enable-tools and which we document in docs/tools.  Currently it
> contains two things, one of which doesn't match that idea...
>
> So, starting with tools/:

[...]

> And for contrib/, easy ones first:
>  * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
>  * contrib/elf2dmp moves to tools/
>  * contrib/ivshmem-client and contrib/ivshmem-server move to tools/

Absolutely not.  This is example code, provided in the hope of helping
people understand the protocol, and experiment with it.  It is entirely
unfit for more serious use, and that's intentional.

If somebody contributes something fit for more serious use, and there's
interest in maintaining it in that role going forward, and that code is
still simple enough to serve the example code's purpose as described
above, we can drop the example code from contrib/.

We could also drop it without replacement just to have an empty
contrib/.  I think that would be a disservice to people trying to use
ivshmem.  But then I'm the guy who keeps telling people *not* to use it,
so why should I care?

Perhaps contrib/ is not a good home for example code.  It seems to
bother people whose judgement I respect.  Can we find a better home?

>  * contrib/plugins moves to plugins/plugins (or a different subdir
>    name of your choice)
>
> For contrib/, ones I'm less sure about:

[...]


