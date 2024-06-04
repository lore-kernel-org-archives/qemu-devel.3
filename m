Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8A7C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 05:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEMGE-00052j-E5; Tue, 04 Jun 2024 00:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEMGA-000528-Ql
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 00:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEMG8-0006Mz-1Q
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 00:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717477135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bq+7Q0aVVfcomC4fBqffFBZ1gvdnJxDCNC5r+0OIDjs=;
 b=fxWZhomkf/aw+9YxCtTHiwobxcQMJs0nRgb//QjCG2+b8f2Wux7V+Hu0Ew/opRnTUJ8syQ
 c2fvoh1E4vbNgQwUXXmB6YP1W07yN5bxzaQXl0k6ybS0D0m6w3OsOXBGDd8QMLvrJPJN98
 XcJgRTN6NAfacPyhbG8TaGyIpWGwXlE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-I6DWwb-cPxWL5Fo4JisOSw-1; Tue, 04 Jun 2024 00:58:42 -0400
X-MC-Unique: I6DWwb-cPxWL5Fo4JisOSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28F8D85A58C;
 Tue,  4 Jun 2024 04:58:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BE3F28A2;
 Tue,  4 Jun 2024 04:58:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B15821E6757; Tue,  4 Jun 2024 06:58:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-devel@nongnu.org,  Cornelia Huck <cohuck@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org,  devel@lists.libvirt.org,  Eric Farman
 <farman@linux.ibm.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  Anton Johansson <anjo@rev.ng>,
 qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
In-Reply-To: <Zl4tgFuAdjU2bst6@gallifrey> (David Alan Gilbert's message of
 "Mon, 3 Jun 2024 20:54:24 +0000")
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com> <Zl4tgFuAdjU2bst6@gallifrey>
Date: Tue, 04 Jun 2024 06:58:40 +0200
Message-ID: <87y17lcni7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>> On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
>> > On 30/05/2024 09.45, Philippe Mathieu-Daud=C3=A9 wrote:
>> > > We are trying to unify all qemu-system-FOO to a single binary.
>> > > In order to do that we need to remove QAPI target specific code.
>> > >=20
>> > > @dump-skeys is only available on qemu-system-s390x. This series
>> > > rename it as @dump-s390-skey, making it available on other
>> > > binaries. We take care of backward compatibility via deprecation.
>> > >=20
>> > > Philippe Mathieu-Daud=C3=A9 (4):
>> > >    hw/s390x: Introduce the @dump-s390-skeys QMP command
>> > >    hw/s390x: Introduce the 'dump_s390_skeys' HMP command
>> > >    hw/s390x: Deprecate the HMP 'dump_skeys' command
>> > >    hw/s390x: Deprecate the QMP @dump-skeys command
>> >=20
>> > Why do we have to rename the command? Just for the sake of it? I think
>> > renaming HMP commands is maybe ok, but breaking the API in QMP is some=
thing
>> > you should consider twice.

PRO rename: the command's tie to S390 is them immediately obvious, which
may be useful when the command becomes available in qemu-systems capable
of running other targets.

CON rename: users need to adapt.

What are the users?  Not libvirt, as far as I can tell.

>> That was going to be my question too. Seems like its possible to simply
>> stub out the existing command for other targets.

That's going to happen whether we rename the commands or not.

> Are these commands really supposed to be stable, or are they just debug
> commands?  If they are debug, then add the x- and don't worry too much.

docs/devel/qapi-code-gen.rst:

    Names beginning with ``x-`` used to signify "experimental".  This
    convention has been replaced by special feature "unstable".

Feature "unstable" is what makes something unstable, and is what
machines should check.

An "x-" prefix may still be useful for humans.  Machines should *not*
key on the prefix.  It's unreliable anyway: InputBarrierProperties
member @x-origin is stable despite it's name.  Renames to gain or lose
the prefix may or may not be worth the bother.

Making an existing part of the interface unstable should be treated
similar to deprecating it: we keep it stable for at least the
deprecation period.  Not written policy, because we didn't consider such
changes when we documented our deprecation policy in
docs/about/deprecated.rst.

Alternative path to a renamed command (*if* we want that):

1. Make it unstable.

2. But keep it stable for two releases.

3. Rename.

[...]


