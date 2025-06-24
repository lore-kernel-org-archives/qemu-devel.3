Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D74C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 06:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTxPm-0005JG-Ls; Tue, 24 Jun 2025 02:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTxPj-0005Iw-8n
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 02:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uTxPh-0003M1-1U
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 02:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750747542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+gl2eVRWupQxN9pftpts+krIIpMZ52R49Wt5Ud8ucIs=;
 b=I5ra0Nz5GUoGmRT2/CArOGcSvEWlbOSztz2RoLlELnPHN/8TrfSgOC0Wbpl1h1+ZK1uMTO
 2+2Qh6uxA51pewywocQSrHOhtYKsjStyhy141ST//zbwV8sl6ZBa7ZqzWsS86DK8/t5eHp
 gzX56shyMv7W8F3EYykEQevd+OR867Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-CfMVev0oN0-fhEsBvXTeiw-1; Tue,
 24 Jun 2025 02:45:35 -0400
X-MC-Unique: CfMVev0oN0-fhEsBvXTeiw-1
X-Mimecast-MFC-AGG-ID: CfMVev0oN0-fhEsBvXTeiw_1750747534
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FBE118002E4; Tue, 24 Jun 2025 06:45:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2C791956096; Tue, 24 Jun 2025 06:45:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EE8421E6A27; Tue, 24 Jun 2025 08:45:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel <qemu-devel@nongnu.org>,
 Daniel =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
In-Reply-To: <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com> (Paolo
 Bonzini's message of "Wed, 18 Jun 2025 09:53:11 +0200")
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
Date: Tue, 24 Jun 2025 08:45:31 +0200
Message-ID: <87qzz9myd0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 6/5/25 21:35, John Snow wrote:
>> However, if we take as iron-clad our commitment to the build platform promise -- *and* guarantee offline/tarball builds as well -- then Debian 12 (as an example) only offers Sphinx 5.3.0 and not newer unless we allow internet access to fetch Sphinx 6.2.1. This is not a problem for developer workstations at all, but I am unclear on what problems this may cause for tarball releases and downstream offline/isolated/ reproducible builds, if any.
>> In this case, we can (probably) "fix" the issue by continuing to allow older Sphinx while preferring a newer Sphinx version when it is missing, but then we lose the ability to make code cleanups and drop a lot of back-compat crud. If memory serves, there were other issues recently where older versions of Sphinx behaved differently from newer versions, causing intermittent failures that were hard to track down.
>
> The *ideal* solution would be to:
>
> - accept: 4.3.2 or newer, which is what Ubuntu 22.04 has
>
> - install: 6.2.1, which is what supports Python 3.13

I guess this relates to pythondeps.toml line

    sphinx = { accepted = ">=3.4.3", installed = "5.3.0", canary = "sphinx-build" }

I further guess "accepted" means "reject anything older", and
"installed" means "preferred version".

> This lets all supported distros build documentation if they use the default Python runtime.  It would still require a couple hacks in compat.py: SOURCE_LOCATION_FIX and nested_parse_with_titles().
>
> I am not sure however whether to count the latter, for two reasons. First, it has this:
>
>     # necessary so that the child nodes get the right source/line set
>     content_node.document = directive.state.document
>
> so it is not a pure compatibility hack.  Second, and opposite, currently none of the uses of nested_parse_with_titles() go through compat.py's version, therefore it probably can be removed altogether.
>
> That leaves only SOURCE_LOCATION_FIX.
>
> As an aside, if the compat.py hacks survive, I would add comments to document which distros need the hacks.
>
>> What I'd like to know is: what precisely are our options in this scenario? Do we consider it acceptable for some platforms to be unable to build docs offline?
>
> Certainly for platforms not using the default Python runtime, which right now is only SLES.  For others...
>
>> How highly do we value the ability to locally build docs for any given release?

Purely offline, or not?

> ... I think I value this a bit higher than Markus, but not really because of offline builds.  Rather, keeping the "accepted" key lower (i.e. supporting the packaged sphinx on a wide range of distros) makes it easier to bump the "installed" key when needed, as in this failure to run 5.3.0 under Python 3.13.

Showing my ignorance again...  I don't understand how keeping "accepted"
lower helps.

> This time there was a version that works on both the oldest and newest Python that we support, but there may not always be one because sphinx is all too happy at dropping support for EOL'd versions of Python.

Pretty strong hint we shouldn't try to support EOL'd versions of Python
either.

> Paolo
>
>> Before I throw my weight behind any given option, I just want to know what we consider our non-negotiable obligations to be.
>> Thanks,
>> --js


