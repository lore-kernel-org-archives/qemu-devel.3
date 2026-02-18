Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C5DE9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 06:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsbSZ-0000uf-OD; Wed, 18 Feb 2026 01:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsbSY-0000uO-1J
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:54:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsbSV-0003eR-S9
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771397687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7A2D5AwoDypxd5YbWkOSqe5dgJDnYQW7gYO64C98axM=;
 b=iLbSEEL0KUpgxq0x5E39SDuilXj6Zom3SyOW9CIjtIPoT5dAiYU9W/7cugs7GgMNEXmWiV
 DRI1vSHkLqwpHaDGDyoMV36NCi00a9eXe6j3ocjOmt+PvCob2CkFLdH7tEkQ+P1aSL6fnq
 BEG4/xLSKW3KggGvnBhq7EgGdvo98mw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-stjBHcbEMjKuq8Q9fThHsQ-1; Wed,
 18 Feb 2026 01:54:46 -0500
X-MC-Unique: stjBHcbEMjKuq8Q9fThHsQ-1
X-Mimecast-MFC-AGG-ID: stjBHcbEMjKuq8Q9fThHsQ_1771397685
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 464CA1800464
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 06:54:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 066BA1800370
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 06:54:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 94A0021E692D; Wed, 18 Feb 2026 07:54:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Daniel =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: CentOS 9, Python, and other Fairytales
In-Reply-To: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
 (John Snow's message of "Tue, 17 Feb 2026 17:59:06 -0500")
References: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
Date: Wed, 18 Feb 2026 07:54:42 +0100
Message-ID: <87wm0afsnh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> FYI,
>
> bash-5.1# cat /etc/centos-release
> CentOS Stream release 9
> bash-5.1# python3 --version
> Python 3.9.25
> bash-5.1# dnf install python3.12-setuptools python3.12-wheel python3.12-pip
> Last metadata expiration check: 0:02:24 ago on Tue Feb 17 22:39:26 2026.
> Dependencies resolved.

[...]

> Transaction Summary
> ==================================================================================================================================================
> Install  9 Packages
>
> Total download size: 16 M
> Installed size: 66 M
> Is this ok [y/N]:
>
> ...
>
> So we actually probably have decent movement we can make as soon as
> Ubuntu 22.04 is dropped; enough to do:
>
> Python 3.9 -> 3.11
> pip 21.3.1 -> 23.0.1
> setuptools 53.0.0 -> 63.1.0
> wheel 0.36.2 -> 0.38.4

Accomodating a wide range of Python versions (language proper and
tooling) is costly.  Few projects go as far back as we do.  Narrowing
our range is good.

> With most of the new sticking points being debian 12 (EOL in June) or
> FreeBSD (timeline uncertain for when they'll re-modernize their python
> stack)
>
> One edge case here, however, is Sphinx, which does not actually have a
> modern package in centOS stream 9.
>
> CentOS currently ships 3.4.3, but it would not be usable if using the
> optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian 12
> have sphinx 5.3.0 to offer us, which is a reasonable version jump, but
> it means that CentOS would not be able to build docs unless you
> enabled `--online` for configuring QEMU or sideloaded Sphinx
> otherwise.

CentOS 9 reaches end of life on May 31 next year.  I do not think
keeping its ability to build bleeding edge docs offline out of the box
for its final year (give or take) is worth your time, or anybody's.

Same for FreeBSD, to be frank.

> That's enough to delete a large amount of the horrid crap in
> docs/sphinx/compat.py, though not all of it - version 6.2.0 is the
> version that would allow me to delete the *entire* thing.

That thing is an achievement in more than one way.  It makes something
work well that has no right to work at all.  It reaches vertiginous
heights of ugliness.  It was disgustingly expensive to write, and it
will be disgustingly expensive to fix if it ever breaks, more so if the
fixer isn't John Snow.  The sooner we get rid of it, the better.

> When Debian 12 is dropped (June), we're waiting on just FreeBSD to
> modernize their stack and we could make that final leap, too.
>
> My plan:
> - Wait and see what happens after the current QEMU release
> - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)
> - Gleefully drop Debian 12 in June
> - Hold my breath and see if FreeBSD happens to modernize by this point
> (They have until October 2027 to do so, so it's a dice roll if they
> will or not)
> - Do a big round of Python modernization all at once; either to 3.11
> or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray for
> forgiveness that I am removing CentOS stream 9's ability to build docs
> offline so I don't have to wait another six months and then do another
> big cleanup round

Makes sense to me.

> Updated version dashboard:
> https://gitlab.com/jsnow/repology-dashboard#results-overview-as-of-2026-02-16
>
> --js


