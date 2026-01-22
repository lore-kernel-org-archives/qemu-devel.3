Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF18DC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vir9K-0000xP-IP; Thu, 22 Jan 2026 04:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vir9I-0000rn-6u
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vir9E-0005Jd-P8
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769074715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zs6Z8rSNgSgnG+3hlWFT61YkymMBUCGMxxUkBeZ07Tw=;
 b=KyXi2LPmwMrO5hSXv9NuJuwhaqxu3V1hm0K1xpcvfKEPD5MqrpDcK3Qb+YZDZ4P61x0+X7
 DidXEh8ohdccnfisFDVmnVNsL4HSJlsdNRez+ojgErmVsAyswFzrw7aGoN0YBZ1BAITi9c
 0nRf8dpCq6Nlek1efnEctCbNE98465g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-32rA7KV3NGeSfh_sHGFwvA-1; Thu,
 22 Jan 2026 04:38:32 -0500
X-MC-Unique: 32rA7KV3NGeSfh_sHGFwvA-1
X-Mimecast-MFC-AGG-ID: 32rA7KV3NGeSfh_sHGFwvA_1769074711
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F7E41944DF2; Thu, 22 Jan 2026 09:38:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C50E1956095; Thu, 22 Jan 2026 09:38:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 160E121E692D; Thu, 22 Jan 2026 10:38:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  kvm <kvm@vger.kernel.org>,  Helge Deller
 <deller@gmx.de>,  Oliver Steffen <osteffen@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Matias Ezequiel Vara Larsen
 <mvaralar@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  German Maglione
 <gmaglione@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  danpb@redhat.com,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Modern HMP (was: Call for GSoC internship project ideas)
In-Reply-To: <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 14 Jan 2026
 22:00:57 +0400")
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
Date: Thu, 22 Jan 2026 10:38:28 +0100
Message-ID: <871pjigf6z.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Tue, Jan 6, 2026 at 1:47=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
>> Dear QEMU and KVM communities,
>> QEMU will apply for the Google Summer of Code internship
>> program again this year. Regular contributors can submit project
>> ideas that they'd like to mentor by replying to this email by
>> January 30th.

[...]

>> How to propose your idea
>> ------------------------------
>> Reply to this email with the following project idea template filled in:
>>
>
> Rather than replying to this mail, I sketched some ideas of things I have
> in mind on the wiki directly:

[...]

> https://wiki.qemu.org/Internships/ProjectIdeas/ModernHMP

[...]

Let's start the discussion with your nicely written Wiki page:

    =3D=3D=3D External HMP Implementation via QMP =3D=3D=3D

    '''Summary:''' Implement a standalone HMP-compatible monitor as an
    external binary (Python or Rust) that communicates with QEMU
    exclusively through QMP, enabling future decoupling of the built-in
    HMP from QEMU core.

    QEMU provides two monitor interfaces:
    * '''QMP''' (QEMU Machine Protocol): A JSON-based machine-readable
      protocol for programmatic control
    * '''HMP''' (Human Monitor Protocol): A text-based interactive
      interface for human operators

    Currently, HMP is tightly integrated into QEMU, with commands
    defined in `hmp-commands.hx` and `hmp-commands-info.hx`. Most HMP
    commands already delegate to QMP internally (e.g., `hmp_quit()`
    calls `qmp_quit()`), but HMP parsing, formatting, and command
    dispatch are compiled into the QEMU binary.

Also line editing and completion.

Most HMP commands cleanly wrap around QMP command handlers such as
qmp_quit().  Wrapping them around QMP commands instead is a
straightforward problem.  I'm more concerned about HMP stuff that uses
other internal interfaces.  Replacing them may require new QMP
interfaces, or maybe a careful culling of inessential HMP features.
Known such stuff: completion does not wrap around QMP command handlers.
It is provided by the HMP core.

Risk: this can easily become the 10% that take the other 90% of the
time, or even the 5% that sink the project.

Risk: serious code duplication until we can get rid of built-in HMP.
Fine if the goal is to explore and learn by building a prototype, and we
simply throw away the prototype afterwards.

    This project aims to externalize HMP functionality, providing a
    standalone tool that offers the same user experience while
    communicating with QEMU purely through QMP.

Potential for a better editing experience, because our readline
reimplementation is lacking compared to the real thing.

    '''Add `CONFIG_HMP` build option''':
    * Create a new Meson configuration option to disable built-in HMP
    * Allow QEMU to be built without HMP
    * Facilitate testing of external HMP as a replacement

    '''Create an external HMP implementation''' in Python or Rust that:
    * Connects to QEMU via QMP socket
    * Parses HMP command syntax and translates to QMP calls
    * Formats QMP responses as human-readable HMP output
    * Supports command completion and help text

    '''Use `hmp-commands.hx` for code generation''':
    * Parse the existing `.hx` files to extract command definitions
    * Generate boilerplate code (command tables, argument parsing, help
      text)
    * Produce a report of implemented vs. unimplemented commands
    * Enable tracking of HMP/QMP parity

.hx is C source code with ReST snippets.  scripts/hxtool strips out the
ReST.  docs/sphinx/hxtool.py ignores the C source code, and processes
the ReST.  It works.  Not a fan.

If we succeed in replacing built-in HMP by an external one, and the
external one isn't written in C, then having C source code in .hx no
longer makes sense.  Parsing it will be wasted effort.  It may still
make sense initially.

    '''Identify and address QMP gaps''':
    * Audit all HMP commands for QMP equivalents

Also audit the HMP core.  Known problem: completion.

    * For critical missing commands, propose QAPI schema additions
    * Document commands that cannot be externalized
    * Provide patches or RFCs for missing QMP functionality

    '''Future Work''' (out of scope):

    * Seamless replacement of built-in HMP

    '''Links:'''
    * https://wiki.qemu.org/Documentation/QMP - QMP documentation
    * https://wiki.qemu.org/Features/QAPI - QAPI schema system
    * https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html - QMP
      reference
    * https://www.qemu.org/docs/master/system/monitor.html - HMP
      documentation

    '''Details:'''
    * Skill level: intermediate
    * Language: Python or Rust (student choice), with C for QMP gap
      patches
=20=20=20=20
    * Mentor: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> (elmarco
      on IRC)
    * Markus?

Makes sense.

    * Suggested by: Marc-Andr=C3=A9 Lureau


