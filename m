Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6F0D58CDC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ZrM-0001Af-KT; Mon, 23 Mar 2026 03:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4ZrK-00019d-Dk
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4ZrH-0002dy-Pw
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774251473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5phMkHqJK6umlLLJaXrmjh8nbO8YVrSIXoxr7z9JE4A=;
 b=RlvCma6TT/XjFHN6FDP1H0odHfSLJbS2p1RuWGCm6VZwGr6UHOoEFEq1EzMn0qYwDYFfDf
 /VWoCTZSGmcdyhb0l8Eti/K49bdHojoH3O6gFrRaVm6OWgWooiTTTbEbOgJ4s9k/l7RrD0
 pbrnBHbmRZ/PhfMc+lt8YTixUIl25qI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-SgQDmLeuPfu6bCYoPmsZGQ-1; Mon,
 23 Mar 2026 03:37:52 -0400
X-MC-Unique: SgQDmLeuPfu6bCYoPmsZGQ-1
X-Mimecast-MFC-AGG-ID: SgQDmLeuPfu6bCYoPmsZGQ_1774251471
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 065F2195608B; Mon, 23 Mar 2026 07:37:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DE981955D71; Mon, 23 Mar 2026 07:37:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D6A621E6937; Mon, 23 Mar 2026 08:37:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?5pmP6b6Z6b6Z?= <yanlonglong@kylinos.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  John Snow <jsnow@redhat.com>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= Re: [PATCH] hw/ide: resolve core crash
 caused by optical drive pop-up during virtual machine startup
In-Reply-To: <1a3bpqsg0je3-1a3jv8ue67n0@nsmail8.2--kylin--1>
 (=?utf-8?B?IuaZj+m+mem+mSIncw==?=
 message of "Mon, 23 Mar 2026 09:05:21 +0800")
References: <1a3bpqsg0je3-1a3jv8ue67n0@nsmail8.2--kylin--1>
Date: Mon, 23 Mar 2026 08:37:48 +0100
Message-ID: <877br30zeb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

=E6=99=8F=E9=BE=99=E9=BE=99 <yanlonglong@kylinos.cn> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>>
>> yanlonglong <yanlonglong@kylinos.cn> writes:
>>
>> Reproducer?
>>
>> Is this a regression?
>
> This occurred in a production environment

Maintainers needs to understand the fix, and that means understanding
the bug.  Please help them.

A reproducer can go a long way towards understanding the bug.  It's also
required to test the fix.

Another way to help is a sufficiently detailed analysis of the bug.
What needs to happen for the program to crash?

Fixes we don't understand and cannot test are really, really dangerous.

[...]


