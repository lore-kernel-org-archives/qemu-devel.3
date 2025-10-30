Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B262CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 18:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEX7e-0008Js-D2; Thu, 30 Oct 2025 14:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEX7Y-0008Je-SS
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEX7T-0008Bq-A9
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761847880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3JGthDOFoF8DfMsCDYqUvoEJQfQIjZZsJppcTY5b+/c=;
 b=bYe9oy1O8orBHuyt5IiGYuCF21yUxhU6zaozXjhZyJ79jBoy/j8taoiVbX9JGzc3bS7fSi
 Jurqao5pMleohWT75SAdtT6mE0B4TYm4PTE9O6/lPX87bqYJPnKD/CevkjLX2dAkfnJ5XT
 S0Ceob7u0AS7ceYL2P5IALXgqfFezCk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-NjySzWMYNN2lPryfZGYXJg-1; Thu,
 30 Oct 2025 14:11:16 -0400
X-MC-Unique: NjySzWMYNN2lPryfZGYXJg-1
X-Mimecast-MFC-AGG-ID: NjySzWMYNN2lPryfZGYXJg_1761847875
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B06C71955F21; Thu, 30 Oct 2025 18:11:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18DEC30001A8; Thu, 30 Oct 2025 18:11:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 60D6821E6A27; Thu, 30 Oct 2025 19:11:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: michael.roth@amd.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3] qapi: Add documentation format validation
In-Reply-To: <87ms58fpyn.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 30 Oct 2025 15:01:52 +0100")
References: <20251029173059.378607-1-vsementsov@yandex-team.ru>
 <87ms58fpyn.fsf@pond.sub.org>
Date: Thu, 30 Oct 2025 19:11:10 +0100
Message-ID: <87v7jwdzup.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Markus Armbruster <armbru@redhat.com> writes:

> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>
>> Add explicit validation for QAPI documentation formatting rules:
>>
>> 1. Lines must not exceed 70 columns in width (including '# ' prefix)
>> 2. Sentences must be separated by two spaces
>>
>> Example sections are excluded, we don't require them to be <= 70,
>> that would be too restrictive.
>>
>> Example sections share common 80-columns recommendations (not
>> requirements).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Hi all!
>>
>> This substitutes my previous attempt
>>   "[PATCH v2 00/33] qapi: docs: width=70 and two spaces between sentences"
>> Supersedes: <20251011140441.297246-1-vsementsov@yandex-team.ru>
>>
>> v3:
>> 01: ignore example sections
>> other commits: dropped :)
>>
>> Of course, this _does not_ build on top of current master. v3 is
>> to be based on top of coming soon doc-cleanup series by Markus.
>
> I'll post this today.

Make that tomorrow: docs/interop/firmware.json needs cleanup, or else
"make check" fails.  Going to throw in docs/interop/vhost-user.json for
good measure.

[...]


