Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BEEE9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 07:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsyU3-00008c-3f; Thu, 19 Feb 2026 02:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsyU1-00008K-0E
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsyTx-0007mU-Cw
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771486191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqM4ppACFIOsS4lWIzT28TJ7L469u29AgRMeZ584hGM=;
 b=aGpwgFZ9Ss6a1jl7uL6JS5icoSZEv5MQSlKOGjYUS4oJ0Zn9qUs8jkx4GtOW4r9q7xIV1k
 1o7YP0hm9YVZYnylH+VDjeXosGSCspMjY/B/QFDQKEHNQsRcpVJOHWPfoRySnC7a7IdKov
 QkV+US90gleLU/Zu0zwg6RiOBkudLFM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-P4F4nM-QOKG60ueSNkUzEw-1; Thu,
 19 Feb 2026 02:29:49 -0500
X-MC-Unique: P4F4nM-QOKG60ueSNkUzEw-1
X-Mimecast-MFC-AGG-ID: P4F4nM-QOKG60ueSNkUzEw_1771486189
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 283A7195608F
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 07:29:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB293180066B
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 07:29:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E79A21E692D; Thu, 19 Feb 2026 08:29:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Daniel =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: CentOS 9, Python, and other Fairytales
In-Reply-To: <CAFn=p-ZdzRuisd6g65A+VXyDKXnTuBc0gnt0ApbhVBZG5GhJZQ@mail.gmail.com>
 (John Snow's message of "Wed, 18 Feb 2026 15:41:03 -0500")
References: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
 <87wm0afsnh.fsf@pond.sub.org>
 <56a8affc-e786-4dc8-81bd-c1f78a224afd@redhat.com>
 <CAFn=p-YqRu3eaR+RvpCi3uaq8Y7s0pGtXwOLztqMDCqYG6McPA@mail.gmail.com>
 <CABgObfaRzjaGTdXGHG=BeHFgGJaC4tt0eKOJu=L=SYWpQmm+6w@mail.gmail.com>
 <CAFn=p-ZdzRuisd6g65A+VXyDKXnTuBc0gnt0ApbhVBZG5GhJZQ@mail.gmail.com>
Date: Thu, 19 Feb 2026 08:29:46 +0100
Message-ID: <874ind6vit.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On Wed, Feb 18, 2026 at 3:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
>> Il mer 18 feb 2026, 18:10 John Snow <jsnow@redhat.com> ha scritto:
>>> On Wed, Feb 18, 2026, 6:48=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
>>>> Markus Armbruster <armbru@redhat.com> writes:
>>>>
>>>> > John Snow <jsnow@redhat.com> writes:

[...]

>>>> >> My plan:
>>>> >> - Wait and see what happens after the current QEMU release
>>>> >> - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)
>>>> >> - Gleefully drop Debian 12 in June
>>>> >> - Hold my breath and see if FreeBSD happens to modernize by this po=
int
>>>> >> (They have until October 2027 to do so, so it's a dice roll if they
>>>> >> will or not)
>>>> >> - Do a big round of Python modernization all at once; either to 3.11
>>>> >> or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray =
for
>>>> >> forgiveness that I am removing CentOS stream 9's ability to build d=
ocs
>>>> >> offline so I don't have to wait another six months and then do anot=
her
>>>> >> big cleanup round
>>>>
>>>> The main nice features of 3.12 are improved f-strings, which are nice
>>>> but not really a necessity.
>>>>
>>>> If I read it correctly, https://www.freshports.org/lang/python says it
>>>> has 3.9 on PPC and 3.11 elsewhere, but
>>>> https://www.freshports.org/lang/python311 says 3.11 exists on PPC as w=
ell.
>>>>
>>>> I'd go for 3.11 and Sphinx 7.  For FreeBSD we can require Python from =
Ports.
>>>
>>>
>>> freebsd ports is currently at 3.11, which is the main reason I am sayin=
g "see what freebsd does by June"
>>>
>>> if they update, we can have Python 3.12 and Sphinx 7.x. If they don't, =
we get 3.11 and 5.x
>>
>>
>> Why can't we do 3.11 and 7.x, and let freebsd also get sphinx from pypi =
until they update?
>
> Hm, I guess no reason, beyond my recalcitrance on breaking docs on a
> supported build platform unless absolutely necessary. It'd still be my
> preference to align with the native distro repo/ports versions if at
> all possible, but I suppose if FreeBSD doesn't fix itself by June or
> so that we can consider dropping docs support with ports packages at
> that time.
>
> (I think I just have Stockholm Syndrome from arguing for "unnecessary
> version bumps to get shiny new toys" and prefer to let those arguments
> come from my seniors ... so I stick with very safe changes when at all
> possible.)

You do.  Please consider going to 7.x really, really seriously.

>>
>> Paolo
>>
>>> . Both are good jumps, but on the chance I can make the bigger jump, I'=
d rather do it in one round instead of two.
>>>
>>>>
>>>> Paolo
>>>>


