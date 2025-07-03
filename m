Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C429CC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFlP-00057i-BN; Thu, 03 Jul 2025 04:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXFlD-0004wq-M7
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXFlB-0008NL-8Q
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751533054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5K39wMKDaN5JpSUHPqHpKTkVRvsbM5vYy2SMcravSvU=;
 b=KxE05S+edBg6tGYos9KJYSjc69Jjiy2GeZAOSYlN4Iug05oJVEK178qIocAJ3qaQNsJ663
 XAr7sI9If7hHZw7I3SMSe4FRokXoTIgCjbhiWabeK6ler+Y6zBaGOI15KhgH5RY6FXRKim
 p88O4xmUVITaMHMBDIddlDWNCxskcfc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-sBr2j0pSNN-crngg_dvg-Q-1; Thu,
 03 Jul 2025 04:57:30 -0400
X-MC-Unique: sBr2j0pSNN-crngg_dvg-Q-1
X-Mimecast-MFC-AGG-ID: sBr2j0pSNN-crngg_dvg-Q_1751533050
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7CF819560AE; Thu,  3 Jul 2025 08:57:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 326E7180045B; Thu,  3 Jul 2025 08:57:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74C5521E6A27; Thu, 03 Jul 2025 10:57:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel <qemu-devel@nongnu.org>,
 Daniel =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
In-Reply-To: <CABgObfYEJ9Xu4b6zGp8E-vDsy7DqYHRrn10VBqjZaTgymmrWpQ@mail.gmail.com>
 (Paolo Bonzini's message of "Wed, 2 Jul 2025 15:24:49 -0400")
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
 <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
 <87qzz9myd0.fsf@pond.sub.org>
 <CABgObfaqauR5SDe67ueAg9-VvJBxM5+LqrYTF3CYjjzzmY8d+w@mail.gmail.com>
 <CABgObfYEJ9Xu4b6zGp8E-vDsy7DqYHRrn10VBqjZaTgymmrWpQ@mail.gmail.com>
Date: Thu, 03 Jul 2025 10:57:26 +0200
Message-ID: <87sejd4pop.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Il mer 2 lug 2025, 15:24 Paolo Bonzini <pbonzini@redhat.com> ha scritto:
>
>>
>>
>> Il mar 24 giu 2025, 02:45 Markus Armbruster <armbru@redhat.com> ha
>> scritto:
>>
>>> > ... I think I value this a bit higher than Markus, but not really
>>> > because of offline builds.  Rather, keeping the "accepted" key lower =
(i.e.
>>> > supporting the packaged sphinx on a wide range of distros) makes it e=
asier
>>> > to bump the "installed" key when needed, as in this failure to run 5.=
3.0
>>> > under Python 3.13.
>>>
>>> Showing my ignorance again...  I don't understand how keeping "accepted"
>>> lower helps.
>>>
>>
>> Because it makes it easier to use distro Python. If distro Python is
>> <accepted,
>>
>
> Sorry: if distro *sphinx* is <accepted.
>
> Paolo
>
>> configure's will try to use the "installed" version. If that version in
>> turn is too new for distro Python, you're screwed. So you want to be as
>> conservative as needed for accepted, but not more.

So, we get into trouble when accept the distro versions for some, but
not all depenencies, and end up with a mix of "accepted" and "installed"
versions that doesn't play together.

Ways to avoid this scenario:

* Ensure the "installed" version play with all the "accepted" versions
  of everything else.  I.e. as we move "installed" up, "accepted" needs
  to move up as well.

* We keep "accepted" for everything low enough so that we don't fall
  back to "installed" on any distro we care about.  Feels brittle.

Any others?

>> Regarding fool or pioneer: for sure we're extraordinarily kind towards
>> distros. To some extent we have to do that because of 1) the possible
>> competition of other VMMs that completely ignore distros (e.g. because t=
hey
>> just use cargo)=E2=80=94packaging is an area where C still has an edge a=
nd we want
>> to keep that edge 2) we're an infrastructure component that can't just t=
ell
>> users to grab a flatpak.
>>
>> The distro policy (mostly conceived by Dan) has served us well, with only
>> small adjustments needed to have newish version of Meson/Rust(*), and
>> non-prehistoric versions of Python. I don't see a need to change it, sin=
ce
>> at this point we have the tools needed to manage the complexity.

One of the "tools" being John Snow, I'm afraid.  Making the full Sphinx
version range work was impressive (and expensive!) work.  I take a
rather dim view on this kind of expensive heroics.  If John gets run
over by a bus, our hand may well be forced: I can't maintain the result
of his heroism, that's for sure.

>> Paolo
>>
>> (*) Most of the Rust issues would solve themselves by telling users of
>> Ubuntu 22.04 and Debian bookworm to install the upstream tool chain with
>> rustup instead of relying on distro rustc packages. Unlike Linux, which
>> uses unstable features, QEMU sticks to what's been stabilized and that
>> means newer releases sometimes.
>>
>> > This time there was a version that works on both the oldest and newest
>>> Python that we support, but there may not always be one because sphinx =
is
>>> all too happy at dropping support for EOL'd versions of Python.
>>>
>>> Pretty strong hint we shouldn't try to support EOL'd versions of Python
>>> either.
>>>
>>> > Paolo
>>> >
>>> >> Before I throw my weight behind any given option, I just want to know
>>> >> what we consider our non-negotiable obligations to be.
>>> >>
>>> >> Thanks,
>>> >> --js


