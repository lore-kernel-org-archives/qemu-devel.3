Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A8AC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5Xy-0000Em-4s; Thu, 06 Mar 2025 02:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq5Xu-0000EN-67
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq5Xh-0002Bt-NC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741245675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0arMdp9zxPLrsw9kpXayTXF7RM0AkvRZ58th7pfGbD8=;
 b=R9B82il0k/5Bu/kh8xAHRPCkd6rBAofJACkrMAIxy2Gw2mLtEtqRjCfAc1zH9Eblmv0EDw
 dDDQB8VZJwMd+3xTEI2TQxCozvKVwrlflfGTNQOQgIb/ihb6ANwQ0hQbJe/yycOGkmE4lL
 jdTOil+uY8K9wpwkPNbccMsVmUZTN9w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-Vbb5yegDOGCNLPWyB6N92Q-1; Thu,
 06 Mar 2025 02:20:00 -0500
X-MC-Unique: Vbb5yegDOGCNLPWyB6N92Q-1
X-Mimecast-MFC-AGG-ID: Vbb5yegDOGCNLPWyB6N92Q_1741245599
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41CDB180035C; Thu,  6 Mar 2025 07:19:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D157018009BC; Thu,  6 Mar 2025 07:19:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6135121E66C1; Thu, 06 Mar 2025 08:19:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Michael Roth
 <michael.roth@amd.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 00/57] docs: Add new QAPI transmogrifier
In-Reply-To: <CAFn=p-bjRSAX=76uvowX=qUBgpRL8EoWEwLwLTjL+2MxcYWOOw@mail.gmail.com>
 (John Snow's message of "Wed, 5 Mar 2025 10:40:44 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <87jz93n281.fsf@pond.sub.org>
 <CAFn=p-bjRSAX=76uvowX=qUBgpRL8EoWEwLwLTjL+2MxcYWOOw@mail.gmail.com>
Date: Thu, 06 Mar 2025 08:19:55 +0100
Message-ID: <87jz92fwx0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> On Wed, Mar 5, 2025, 6:31=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Hi! This series is based on armbru/pull-qapi-2025-02-26.
>> >
>> > This series is a "minimum viable" version of the new QAPI documentation
>> > system. It does the bare minimum under the new framework, saving nice
>> > features for later.
>>
>> Not saved for later: a massive improvement of the generated
>> documentation's looks and usability.  Moreover, I hope the new generator
>> will be easier to maintain than the old one, because its inner workings
>> are closer to how Sphinx expects such things to work.  Fair?
>>
>
> I hope so too, though some of the sphinx version compatibility hacks are
> possibly fairly porcelain. The most egregious of them are for versions
> prior to Sphinx 4.1.
>
> Almost all of the compatibility hacks are factored into compat.py and they
> are all documented with what versions they're there for. Most of the
> ugliest is pre-4.1.

[...]

> It's the stuff in compat.py that was the absolute hardest. You need that
> stuff for this to work on the version ranges it works for, but typing it
> was an extra special torture.

Supporting such a wide range of versions is *expensive*.

Writing compat.py is sunk cost.

Maintaining it is not.  It's fragile hacks, hard to understand even with
deep Sphinx innards expertise, impossible to understand without.  I
figure if we somehow lost your expertise, we'd likely have to drop
support for old Sphinx the moment compat.py breaks.

Just because we can solve certain hard problems doesn't mean we should.
I question the wisdom of supporting such a wide range of Sphinx
versions.


