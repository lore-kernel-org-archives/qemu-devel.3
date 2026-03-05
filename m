Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A9EEF33C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy4gw-0006N0-F0; Thu, 05 Mar 2026 04:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy4g7-00068C-5w
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy4g4-0007Qh-Fo
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 04:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772701647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0Yi1NoQrPTXkGhKfabum6yIpQq/vEoBLwyXo1hU/FU=;
 b=GXxxUsKfdNY2WFxuSbREZStADE0tHe9m/umXB9j02JHPWj0wxCg/5wWIrhP1vnlvWVHkm8
 ncDMpXpf2PUhliqjKySlitsFqni3tmISq6R7EUGt//9GvxkH3GpYMMNVT7sGE8VBVZftcr
 3E1QTpgx81QYM1WAWsd37WyreaqCRtY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-CZXq2IlbPdy0lcuiky2aMw-1; Thu,
 05 Mar 2026 04:07:24 -0500
X-MC-Unique: CZXq2IlbPdy0lcuiky2aMw-1
X-Mimecast-MFC-AGG-ID: CZXq2IlbPdy0lcuiky2aMw_1772701642
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EDF3180035D; Thu,  5 Mar 2026 09:07:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F8DB3003E98; Thu,  5 Mar 2026 09:07:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9E8021E6A04; Thu, 05 Mar 2026 10:07:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Viktor Prutyanov
 <viktor.prutyanov@phystech.edu>,  Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Keith Busch
 <kbusch@kernel.org>,  Klaus Jensen <its@irrelevant.dk>,  Jesper Devantier
 <foss@defmacro.it>,  qemu-block@nongnu.org
Subject: Re: [PATCH v4 3/4] tests: Clean up double comparisons to avoid
 compiler warning
In-Reply-To: <20260305-nvme-v4-3-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp> (Akihiko
 Odaki's message of "Thu, 05 Mar 2026 15:16:46 +0900")
References: <20260305-nvme-v4-0-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
 <20260305-nvme-v4-3-b65b9de1839f@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 05 Mar 2026 10:07:16 +0100
Message-ID: <87y0k6oda3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> To enable -Wformat-overflow=3D2, we need to clean up a couple of false
> positives:
>
> [2/5] Compiling C object tests/unit/test-qobject-output-visitor.p/test-qo=
bject-output-visitor.c.o
> FAILED: tests/unit/test-qobject-output-visitor.p/test-qobject-output-visi=
tor.c.o
> cc -Itests/unit/test-qobject-output-visitor.p -Itests/unit -I../tests/uni=
t -I. -Iqapi -Itrace -Iui -Iui/shader -Itests -Itests/include -I/usr/includ=
e/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-6 -fdiagnos=
tics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -D_GNU_SO=
URCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno=
-common -fwrapv -ftrivial-auto-var-init=3Dzero -fzero-call-used-regs=3Dused=
-gpr -fsanitize=3Daddress -fstack-protector-strong -fsanitize=3Dundefined -=
Wempty-body -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=3D2 -Wf=
ormat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2=
 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wnested-exter=
ns -Wold-style-declaration -Wold-style-definition -Wredundant-decls -Wshado=
w=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings -=
Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isystem /hom=
e/me/q/var/qemu/linux-headers -isystem linux-headers -iquote . -iquote /hom=
e/me/q/var/qemu -iquote /home/me/q/var/qemu/include -iquote /home/me/q/var/=
qemu/host/include/aarch64 -iquote /home/me/q/var/qemu/host/include/generic =
-iquote /home/me/q/var/qemu/tcg/aarch64 -pthread -fPIE -MD -MQ tests/unit/t=
est-qobject-output-visitor.p/test-qobject-output-visitor.c.o -MF tests/unit=
/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o.d -o tests/u=
nit/test-qobject-output-visitor.p/test-qobject-output-visitor.c.o -c ../tes=
ts/unit/test-qobject-output-visitor.c

I'd omit the three lines above for brevity's sake.

> ../tests/unit/test-qobject-output-visitor.c: In function =E2=80=98test_vi=
sitor_out_list_struct=E2=80=99:
> ../tests/unit/test-qobject-output-visitor.c:577:28: error: =E2=80=98%.6f=
=E2=80=99 directive writing between 3 and 317 bytes into a region of size 3=
2 [-Werror=3Dformat-overflow=3D]

I'd also omit the remainder of the report.

>   577 |         sprintf(expected, "%.6f", (double)i / 3);
>       |                            ^~~~
> ../tests/unit/test-qobject-output-visitor.c:577:27: note: assuming direct=
ive output of 8 bytes
>   577 |         sprintf(expected, "%.6f", (double)i / 3);
>       |                           ^~~~~~
> In file included from /usr/include/stdio.h:970,
>                  from /home/me/q/var/qemu/include/qemu/osdep.h:114,
>                  from ../tests/unit/test-qobject-output-visitor.c:13:
> In function =E2=80=98sprintf=E2=80=99,
>     inlined from =E2=80=98test_visitor_out_list_struct=E2=80=99 at ../tes=
ts/unit/test-qobject-output-visitor.c:577:9:
> /usr/include/bits/stdio2.h:30:10: note: =E2=80=98__builtin___sprintf_chk=
=E2=80=99 output between 4 and 318 bytes into a destination of size 32
>    30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    31 |                                   __glibc_objsize (__s), __fmt,
>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    32 |                                   __va_arg_pack ());
>       |                                   ~~~~~~~~~~~~~~~~~
> ../tests/unit/test-qobject-output-visitor.c: In function =E2=80=98test_vi=
sitor_out_list_struct=E2=80=99:
> ../tests/unit/test-qobject-output-visitor.c:578:26: error: =E2=80=98%.6f=
=E2=80=99 directive writing between 3 and 317 bytes into a region of size 3=
2 [-Werror=3Dformat-overflow=3D]

I'd similarly abridge this second warning.

>   578 |         sprintf(actual, "%.6f", qnum_get_double(qvalue));
>       |                          ^~~~
> ../tests/unit/test-qobject-output-visitor.c:578:25: note: assuming direct=
ive output of 8 bytes
>   578 |         sprintf(actual, "%.6f", qnum_get_double(qvalue));
>       |                         ^~~~~~
> In function =E2=80=98sprintf=E2=80=99,
>     inlined from =E2=80=98test_visitor_out_list_struct=E2=80=99 at ../tes=
ts/unit/test-qobject-output-visitor.c:578:9:
> /usr/include/bits/stdio2.h:30:10: note: =E2=80=98__builtin___sprintf_chk=
=E2=80=99 output between 4 and 318 bytes into a destination of size 32
>    30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    31 |                                   __glibc_objsize (__s), __fmt,
>       |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    32 |                                   __va_arg_pack ());
>       |                                   ~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> These buffers cannot actually overflow because the doubles are
> between 0 and 31.0/3 inclusive.
>
> However, formatting doubles just to compare them is silly.  Compare
> them directly instead.  To avoid potential rounding trouble, change
> the numbers tested to be representable exactly in double.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!


