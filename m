Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354860A2600
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=qvbIQS2/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3Gd-0002cm-Tq; Thu, 19 Nov 2026 09:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xU3Gb-0002cc-PE
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:37:37 -0500
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xU3GZ-00013S-L1
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795099045; bh=hyjPD4fcg+eWXsrRVktP5VBhV3wRc2hoeY6rYPnDJxc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qvbIQS2/SLymjTj/32ZieizSpzJS7KehMZeBvZqdp2fnVxF+mNWl6MZMrej6PTRTl
 T3hP6D1Th7/HOOwf+SjDSg+cb4dXQG0bUZsoxwh+/Zsrob2/qn1i7AOT5fopwTCL01
 vjy4K14xfZCnOKQhTlZ2Y483WJ+jDeTVcIEWEfeo=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 0DBF420188;
 Thu, 19 Nov 2026 15:37:23 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B11721E6A04; Thu, 19 Nov 2026 15:37:30 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  dave@treblig.org,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@mailo.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,  "Denis V. Lunev" <den@openvz.org>,  "Jason J.
 Herne" <jjherne@linux.ibm.com>,  Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/50] Make HMP optional (and later standalone)
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 28 Aug 2026 16:03:57 +0400")
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
Date: Thu, 19 Nov 2026 15:37:30 +0100
Message-ID: <878q2oc2fp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It's been a while :)

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi,
>
> This series makes HMP compile-time optional via --disable-hmp. The
> resulting binary speaks only QMP - reducing the attack surface, binary
> size and enforcing a separation between machine-readable interface and
> interactive debugging console.
>
> QMP offers almost all the functionality HMP could provide, so a separate
> standalone "HMP-like" console could be implemented on top of it. The
> rough list of missing commands (+complexity estimation) after this
> series:

Conversely, some QMP functionality only exists for HMP and CLI.

For instance, ObjectPropertyInfo has members @description and
@default-value.  @description is help text written for HMP / CLI syntax.

Management applications have no use for either.  So why do they exist?

They exist, because the code to print HMP device_add / CLI -device help
wraps around qmp_device_list_properties().  Commit 07d09c58dbb added
@description to *QMP* just to use it there, i.e. *within* QEMU.  Commit
1bb3d7d92c9 later added @default-value[*].  This is what I call an
accidental external interface.

Elsewhere, help does *not* wrap around QMP.  For instance, the code to
print HMP object_add / CLI -object help uses the internal QOM interface,
and the code to print -blockdev help uses the internal block driver
interface.

How could a separate-process HMP do help?

Ideally, the HMP help moves into that separate process, too.

If that's not practical, we can talk about adding QMP commands just for
HMP.

What I do not want is more HMP crap in QMP commands management
applications use.

In fact, I'm itching to deprecate ObjectPropertyInfo's @description and
@default-value.


[...]


[*] Help shows @default-value in HMP / CLI syntax as long as it is
string or bool.  Anything else it shows as JSON.  Fine for numbers,
which have the same syntax.  For anything else, translating from JSON to
HMP / CLI syntax is left to users.  Doing any better would be really
hard, because there is no single HMP / CLI syntax for these things.

