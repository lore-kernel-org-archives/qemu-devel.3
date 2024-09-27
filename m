Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E894CEBF7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 07:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su5PQ-0004ni-4Y; Fri, 27 Sep 2024 03:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1su5PO-0004me-9r
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1su5PM-0003hw-6Q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 03:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727422133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZlhgHa5oCyR8W4JGBxbbHBPORbeVYoXF5r7knvJEH4=;
 b=EaMH6FWm3YgEX0BsUwgb/SFGwcyHuvq0lGcRUynbBI6utbK9ldLA9peYMfDgPLhZkEkSYp
 QAkiC4pWu37n9pNIAnQ0f7zaxjmw7eG+IsdB/hbr2t93dlntFRMcCkCbOeAGw8rwTqh40d
 bn0BRQ8sZmp+1h4EHXVLCLYisIwAYPA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-yKZolCNkM3Cm3ao-9UD-tQ-1; Fri,
 27 Sep 2024 03:28:49 -0400
X-MC-Unique: yKZolCNkM3Cm3ao-9UD-tQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60353193610E; Fri, 27 Sep 2024 07:28:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E1951956086; Fri, 27 Sep 2024 07:28:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BBE721E6A28; Fri, 27 Sep 2024 09:28:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  qemu-devel
 <qemu-devel@nongnu.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Hanna Reitz <hreitz@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org,  Michael Tokarev
 <mjt@tls.msk.ru>,  ncopa@alpinelinux.org,  bofh@freebsd.org,
 emulation@freebsd.org,  virtualization@gentoo.org,  dilfridge@gentoo.org,
 hi@alyssa.is,  edolstra+nixpkgs@gmail.com,  brad@comstyle.com,  Paolo
 Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  dvzrv@archlinux.org,
 anatol.pomozov@gmail.com,  Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
In-Reply-To: <ZvWPH1f6ZnvH1iYZ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 26 Sep 2024 17:43:11 +0100")
References: <871q16fq9c.fsf@draig.linaro.org> <ZvWPH1f6ZnvH1iYZ@redhat.com>
Date: Fri, 27 Sep 2024 09:28:43 +0200
Message-ID: <875xqh4kt0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Sep 26, 2024 at 03:23:11PM +0100, Alex Benn=C3=A9e wrote:

[...]

>> One issue that came up is how we handle adequately reviewing code when
>> most of the maintainers are experienced C coders but might not know much
>> about Rust. While we want to avoid the situation of developers vetoing
>> conversion there should be communication ahead of any serious work to
>> avoid rust contributions coming out of the blue. If a maintainer feels
>> they cannot maintain a bunch of unfamiliar rust code the submitter
>> should be prepared to find people willing to become a maintainers as
>> unmaintained drive-by submissions are not useful for the long term
>> health of the project.
>
> Yep, communication is critical, if proposing to rewrite existing
> functionality. Drowning maintainers in conversion patches without
> warning is a guaranteed way to create friction between people.
>
>> With relative inexperience there was a concern we could inadvertently
>> introduce technical debt in the code base (C-like Rust vs Rusty rust).
>> What can we do to mitigate that issue?
>
> On a long enough time frame, all exiting code can be considered
> technical debt. Given the relatively sparse Rust experiance
> across our community, we're guaranteed to make more design
> mistakes in the first few years. Mitigating this is important,
> but at the same time, we should also accept we're not going
> to get everything perfect.
>
> One thing our community is very good at is obsessing about
> perfection of patch series. I can forsee us doing that to an
> even greater extent with any Rust conversions of code. If we
> are not careful we could really harm  our overall productivity
> by spending too much time striving for a perfect Rust abstraction
> first time out, even though many of us would still be relative
> newcomers to Rust, such that we don't know what we don't know.
>
> IOW, we need to be pragmatic about accepting some level of
> technical debt at times. Especially if there are cases where
> our Rust design is held back by existing C code, we might be
> better off temporarily accepting sub-optimal Rust, to avoid
> immediately refactoring piles of C code, and tackle the problems
> later.

A deliberate approach to explore some before we go all in could mitigate
the risk of taking on too much technical debt.

We obviously need to write instances of each interesting class of things
to ferret out the problems, and design good interfaces.  I'd recommend
to write few instances, ideally one, then let them mature some before we
create many more of them.  Prioritize gaining experience over quantity.

[...]


