Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E42CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjz6-0004Zg-N8; Wed, 17 Jun 2026 02:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZjz4-0004ZC-Ij
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZjz3-0007ze-3i
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 02:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781678564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQ6N724csDt5tr46+bdOxwOzzzzEDLMw7t14L2V9SA0=;
 b=cT0otiPP1WCtpjjYPZXT2r8+JWcGUmJU9Arw5n+pLAco3sh1S60hXOlYYPuk0EAq3x1q16
 3+97CuH/4LzRj6kI8pRCclpffDbBJRS8bcw0IAOEKdTtzhvnYGOyv7e975N5EIFfMrSSlx
 JygRpEwZ/ZGA7lYbzpN6+dZ2G7Uec10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-lDuy9KjtO8iXZ8uG50t0HQ-1; Wed,
 17 Jun 2026 02:42:40 -0400
X-MC-Unique: lDuy9KjtO8iXZ8uG50t0HQ-1
X-Mimecast-MFC-AGG-ID: lDuy9KjtO8iXZ8uG50t0HQ_1781678559
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A29221955F0D; Wed, 17 Jun 2026 06:42:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E2D9180058F; Wed, 17 Jun 2026 06:42:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 992A421E6A01; Wed, 17 Jun 2026 08:42:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
In-Reply-To: <36f118b4-8e24-4425-bc45-df2f13651c21@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 15 Jun 2026 19:51:22 -0700")
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
 <05604cb4-6f61-4b64-90ce-505ac87d8a04@oss.qualcomm.com>
 <36f118b4-8e24-4425-bc45-df2f13651c21@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 08:42:36 +0200
Message-ID: <87fr2lpt0j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 6/15/2026 5:35 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 15/6/26 22:17, Pierrick Bouvier wrote:
>>> We add a new script: scripts/check-maintainers-file.py, that will run at
>>> configuration time (and not at build time), to not hurt build time.
>>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>>
>>> We can expect things to be mostly in sync since adding or removing a
>>> source or test file will trigger a configure step.
>>=20
>> You mention adding/removing but this script only checks for removals,
>> no additions; did I miss something?
>>
> The initial scope was only to check the MAINTAINERS file itself is
> correct. But while we're at it, we could extend the script to check that
> all files in the tree belong to at least one maintainer entry. This
> could have the benefit to force coverage for all new files. First we can
> try to see what is not covered at the moment.
>
> What do you think Markus?

I periodically post a report on MAINTAINERS coverage.  The most recent
one is for v10.2.0-rc4:

    Subject: Report on MAINTAINERS coverage
    To: qemu-devel@nongnu.org
    Date: Thu, 18 Dec 2025 13:45:24 +0100
    Message-ID: <87h5toc61n.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87h5toc61n.fsf@pond.sub.org/

We had more than a thousand files not covered then.  Getting to 100%
coverage would take a big push, and require help from many people.

Even with imperfect coverage, we could still require coverage for all
new files.  I'm not sure this is practical without at least some
targeted MAINTAINERS improvements.  Test-drive with a month or three
worth of existing commits to see how bad it would have been, to give us
an idea on how bad it would be?  Or just take the plunge, and revert if
it turns out to be bad?

This series tries to solve a smaller problem.  Even if we decide we want
the bigger problem solved, getting the smaller problem solved sooner is
probably better than getting it solved together with the bigger one
later.


