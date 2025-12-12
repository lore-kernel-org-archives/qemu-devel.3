Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1554D49230
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 14:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4IA-0000AX-4z; Fri, 12 Dec 2025 09:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vU4I8-00009h-Cu
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vU4I6-0004Ki-Oz
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765550320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hnl6f13Ja6GHFavUAdqdMHjv59XCSNTwf9oLUoTe43w=;
 b=ijuwQNA/zK/IMn7GC+QnLs3fe2D+//oXYq3l510vUS2zFoPJxdbZFDX3qTM5Eu4SI7shjB
 TgaYbKPSRClqlCX9E+ZzeOh/PCv8CUnCBkaC57KuZSmxFE+nomyPUsYC/i5XQGPoxtUWDi
 qVlGNp3tvCruyAuKI4HSmXCa2eSNQdI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-4w_sHJeENDGsBY937fMBnQ-1; Fri,
 12 Dec 2025 09:38:37 -0500
X-MC-Unique: 4w_sHJeENDGsBY937fMBnQ-1
X-Mimecast-MFC-AGG-ID: 4w_sHJeENDGsBY937fMBnQ_1765550316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E86D1801215; Fri, 12 Dec 2025 14:38:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8C1D180035F; Fri, 12 Dec 2025 14:38:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BF1121E6A27; Fri, 12 Dec 2025 15:38:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 0/9] for 11.0 conversion* of get_maintainers.pl to
 python
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Thu, 11 Dec 2025 18:01:23 +0000")
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
Date: Fri, 12 Dec 2025 15:38:33 +0100
Message-ID: <87bjk322ae.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> *incomplete
>
> I wanted to look at adding gitlab tags to MAINTAINERS and baulked
> slightly at figuring out what I would need to change in the perl
> script to cleanly handle it.
>
> While we imported the perl script from the kernel I'm fairly sure we
> don't use half the features it has and as us grey beards age out less
> people will be willing to tweak it. Consider this a proof-of-concept
> for discussion about if it is worth perusing this path.
>
> It only supports the two main forms:
>
>   ./scripts/get_maintainer.py -f path/to/file
>   ./scripts/get_maintainer.py path/to/patch1 path/to/patch2 ...
>
> But who needs more?

I've used options --git --nogit-fallback --git-since and --git-blame.

> Future improvements could include some more detailed analysis in
> conjugation with the repo to analysis:
>
>   - missing areas of coverage

I've used

    $ for i in `git-ls-files`; do [ "`scripts/get_maintainer.pl -f --no-git=
-fallback $i | grep -v '^qemu-devel@nongnu\.org'`" ] || echo $i; done >unma=
intained-files

Last post:

    From: Markus Armbruster <armbru@redhat.com>
    Subject: MAINTAINERS still leaves more files uncovered than I'd like
    To: qemu-devel@nongnu.org
    Date: Fri, 29 Sep 2023 13:43:30 +0200
    Message-ID: <87lecp6w7x.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87lecp6w7x.fsf@pond.sub.org/

I think I'll do it again soonish.

>   - maintainer stats
>
> Who knows maybe the kernel guys will want to import our script one day
> ;-)
>
> Alex.


