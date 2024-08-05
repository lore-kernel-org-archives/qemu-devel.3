Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1203FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saxUt-0000N1-Pp; Mon, 05 Aug 2024 09:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1saxUl-0000MB-4M
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1saxUi-0001Kf-EZ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722863482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vyyV3EevUKbVyq49NzmCmQrNMokrc1uubxPeklNSxXE=;
 b=ZbUn2zOU5VBBdIMg6VOHC3vXg8h1HEt1hbfa+QW5JXq18QGpzf+OSVVYY7Q54vZSsbSeLX
 Xs+JeVA9FyrxQbSzIvBtx3AHFZYDSvvSrGNBtea6hhMHsr2v/7KznUiRDAuRA9wIdz7K3D
 NQKVhPNuQiPRgsfteiaXP3GBowccNAk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-RXTDuq5VN9C2AmlR8e-0aA-1; Mon,
 05 Aug 2024 09:11:18 -0400
X-MC-Unique: RXTDuq5VN9C2AmlR8e-0aA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 442FD1955D4C; Mon,  5 Aug 2024 13:11:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4881955D4A; Mon,  5 Aug 2024 13:11:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3874821E66E5; Mon,  5 Aug 2024 15:11:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH 5/6] qapi: apply schema prefix to QAPI feature enum
 constants
In-Reply-To: <ZrDGoSTUIcpaVGO8@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 5 Aug 2024 13:33:37 +0100")
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-6-berrange@redhat.com>
 <87y15bnoq0.fsf@pond.sub.org> <ZrDGoSTUIcpaVGO8@redhat.com>
Date: Mon, 05 Aug 2024 15:11:12 +0200
Message-ID: <87a5hrm7wv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Aug 05, 2024 at 02:22:47PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > This allows us to include multiple QAPI schemas in the same file.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>=20
>> I figure you had reason to simultaneously include headers generated for
>> multiple schemas.  Do tell :)
>
> I didn't want to have this patch, but the unit tests do this :-(
>
> [2/37] Compiling C object tests/libtestqapi.a.p/meson-generated_.._test-q=
api-commands-sub-sub-module.c.o
> FAILED: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands-sub-s=
ub-module.c.o=20
> cc -m64 -Itests/libtestqapi.a.p -Itests -I../tests -I. -Iqapi -Itrace -Iu=
i -Iui/shader -Itests/include -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0=
/include -I/usr/include/sysprof-6 -fdiagnostics-color=3Dauto -Wall -Winvali=
d-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-body -We=
ndif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -Wignored=
-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-attribu=
te -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-styl=
e-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototypes -Wtype-=
limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi -=
Wno-shift-negative-value -isystem /var/home/berrange/src/virt/qemu/linux-he=
aders -isystem linux-headers -iquote . -iquote /var/home/berrange/src/virt/=
qemu -iquote /var/home/berrange/src/virt/qemu/include -iquote /var/home/ber=
range/src/virt/qemu/host/include/x86_64 -iquote /var/home/berrange/src/virt=
/qemu/host/include/generic -iquote /var/home/berrange/src/virt/qemu/tcg/i38=
6 -pthread -msse2 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFIL=
E_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=
=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIE -MD -MQ tests/libtestqapi.a.=
p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o -MF tests/libtes=
tqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o.d -o tes=
ts/libtestqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o=
 -c tests/test-qapi-commands-sub-sub-module.c
> In file included from tests/test-qapi-types-sub-sub-module.h:17,
>                  from tests/test-qapi-visit-sub-sub-module.h:17,
>                  from tests/test-qapi-commands-sub-sub-module.c:19:
> tests/test-qapi-features.h:16:5: error: redeclaration of enumerator =E2=
=80=98QAPI_FEATURE_DEPRECATED=E2=80=99
>    16 |     QAPI_FEATURE_DEPRECATED,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./qapi/qapi-types-error.h:17,
>                  from /var/home/berrange/src/virt/qemu/include/qapi/error=
.h:275,
>                  from /var/home/berrange/src/virt/qemu/include/qapi/compa=
t-policy.h:16,
>                  from tests/test-qapi-commands-sub-sub-module.c:14:
> ./qapi/qapi-features.h:16:5: note: previous definition of =E2=80=98QAPI_F=
EATURE_DEPRECATED=E2=80=99 with type =E2=80=98enum <anonymous>=E2=80=99
>    16 |     QAPI_FEATURE_DEPRECATED,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~
> ninja: build stopped: subcommand failed.
> make[1]: *** [Makefile:167: run-ninja] Error 1
> make[1]: Leaving directory '/var/home/berrange/src/virt/qemu/build'
> make: *** [GNUmakefile:6: build] Error 2

Compiles for me with PATCH 5/6 taken out.  What am I doing wrong?

> I would be nice to eliminate that, but some parts of the test appear
> to pull in more of the system emulator code which forces in the main
> qapi schema
>
> n file included from ./qapi/qapi-types-block-core.h:17,
>                  from /var/home/berrange/src/virt/qemu/include/block/bloc=
k-common.h:27,
>                  from /var/home/berrange/src/virt/qemu/include/block/bloc=
k-global-state.h:27,
>                  from /var/home/berrange/src/virt/qemu/include/block/bloc=
k.h:27,
>                  from /var/home/berrange/src/virt/qemu/include/monitor/mo=
nitor.h:4,
>                  from /var/home/berrange/src/virt/qemu/include/qapi/qmp/d=
ispatch.h:17,
>                  from tests/test-qapi-init-commands.h:16,
>                  from tests/test-qapi-init-commands.c:15:
> ./qapi/qapi-features.h:16:5: error: redeclaration of enumerator =E2=80=98=
QAPI_FEATURE_DEPRECATED=E2=80=99
>    16 |     QAPI_FEATURE_DEPRECATED,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from tests/include/../test-qapi-types-sub-sub-module.h:1=
7,
>                  from tests/include/../test-qapi-commands-sub-sub-module.=
h:16,
>                  from tests/include/test-qapi-commands-sub-module.h:16,
>                  from tests/test-qapi-commands.h:16,
>                  from tests/test-qapi-init-commands.c:14:
> tests/include/../test-qapi-features.h:16:5: note: previous definition of =
=E2=80=98QAPI_FEATURE_DEPRECATED=E2=80=99 with type =E2=80=98enum <anonymou=
s>=E2=80=99
>    16 |     QAPI_FEATURE_DEPRECATED,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~
> tests/test-qapi-init-commands.c: In function =E2=80=98test_qmp_init_marsh=
al=E2=80=99:
> tests/test-qapi-init-commands.c:64:71: error: =E2=80=98TEST_QAPI_FEATURE_=
DEPRECATED=E2=80=99 undeclared (first use in this function); did you mean =
=E2=80=98QAPI_FEATURE_DEPRECATED=E2=80=99?
>    64 |                          qmp_marshal_test_command_features1, 0, 1=
u << TEST_QAPI_FEATURE_DEPRECATED);
>       |                                                                  =
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                                  =
     QAPI_FEATURE_DEPRECATED
> tests/test-qapi-init-commands.c:64:71: note: each undeclared identifier i=
s reported only once for each function it appears in
>
>
> Maybe the test needs to be split into two ?  One test exclusively testing
> with the tests/qapi-schema/qapi-schema-test.json, and one test exclusively
> with the main QMP QAPI schema ?

Which test is it?


