Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC10C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sayAH-00033f-5P; Mon, 05 Aug 2024 09:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sayAF-000332-Dw
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sayAD-0007w4-Gb
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 09:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722866056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sGvZY5Gd5kM1oGuWw6mCinxCO5gdBdIKPqROWVB8DsA=;
 b=L9gOWXW/DgfEy4NieJzuIASud4Ej8jNnxdnwdbkR7Wmb1EuvJiirN0eho7xH+oQf0yKFeU
 Lhh/iymTd7vFO0nAE+YUNsHy4YUg/ZRTqaRzw53wXtU24t1IiGAa5M+RMNRlvFw1Zl7umI
 Pbwy+LP7E+QmqWAQJb8Caqz3i72JOVQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-41Fwm-p-NxWbS5Dq2gvr6w-1; Mon,
 05 Aug 2024 09:54:14 -0400
X-MC-Unique: 41Fwm-p-NxWbS5Dq2gvr6w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 986F61955D42; Mon,  5 Aug 2024 13:54:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A53481955F40; Mon,  5 Aug 2024 13:54:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72E3521E66E5; Mon,  5 Aug 2024 15:54:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Michael
 Roth <michael.roth@amd.com>
Subject: Re: [PATCH 5/6] qapi: apply schema prefix to QAPI feature enum
 constants
In-Reply-To: <ZrDSqXtiT2U7zS-p@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 5 Aug 2024 14:24:57 +0100")
References: <20240801175913.669013-1-berrange@redhat.com>
 <20240801175913.669013-6-berrange@redhat.com>
 <87y15bnoq0.fsf@pond.sub.org> <ZrDGoSTUIcpaVGO8@redhat.com>
 <87a5hrm7wv.fsf@pond.sub.org> <ZrDSqXtiT2U7zS-p@redhat.com>
Date: Mon, 05 Aug 2024 15:54:10 +0200
Message-ID: <87frrjkrct.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

> On Mon, Aug 05, 2024 at 03:11:12PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Aug 05, 2024 at 02:22:47PM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > This allows us to include multiple QAPI schemas in the same file.
>> >> >
>> >> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> >>=20
>> >> I figure you had reason to simultaneously include headers generated f=
or
>> >> multiple schemas.  Do tell :)
>> >
>> > I didn't want to have this patch, but the unit tests do this :-(
>> >
>> > [2/37] Compiling C object tests/libtestqapi.a.p/meson-generated_.._tes=
t-qapi-commands-sub-sub-module.c.o
>> > FAILED: tests/libtestqapi.a.p/meson-generated_.._test-qapi-commands-su=
b-sub-module.c.o=20
>> > cc -m64 -Itests/libtestqapi.a.p -Itests -I../tests -I. -Iqapi -Itrace =
-Iui -Iui/shader -Itests/include -I/usr/include/glib-2.0 -I/usr/lib64/glib-=
2.0/include -I/usr/include/sysprof-6 -fdiagnostics-color=3Dauto -Wall -Winv=
alid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wempty-body =
-Wendif-labels -Wexpansion-to-defined -Wformat-security -Wformat-y2k -Wigno=
red-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-attr=
ibute -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-s=
tyle-definition -Wredundant-decls -Wshadow=3Dlocal -Wstrict-prototypes -Wty=
pe-limits -Wundef -Wvla -Wwrite-strings -Wno-missing-include-dirs -Wno-psab=
i -Wno-shift-negative-value -isystem /var/home/berrange/src/virt/qemu/linux=
-headers -isystem linux-headers -iquote . -iquote /var/home/berrange/src/vi=
rt/qemu -iquote /var/home/berrange/src/virt/qemu/include -iquote /var/home/=
berrange/src/virt/qemu/host/include/x86_64 -iquote /var/home/berrange/src/v=
irt/qemu/host/include/generic -iquote /var/home/berrange/src/virt/qemu/tcg/=
i386 -pthread -msse2 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGE=
FILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-ini=
t=3Dzero -fzero-call-used-regs=3Dused-gpr -fPIE -MD -MQ tests/libtestqapi.a=
.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o -MF tests/libte=
stqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.o.d -o te=
sts/libtestqapi.a.p/meson-generated_.._test-qapi-commands-sub-sub-module.c.=
o -c tests/test-qapi-commands-sub-sub-module.c
>> > In file included from tests/test-qapi-types-sub-sub-module.h:17,
>> >                  from tests/test-qapi-visit-sub-sub-module.h:17,
>> >                  from tests/test-qapi-commands-sub-sub-module.c:19:
>> > tests/test-qapi-features.h:16:5: error: redeclaration of enumerator =
=E2=80=98QAPI_FEATURE_DEPRECATED=E2=80=99
>> >    16 |     QAPI_FEATURE_DEPRECATED,
>> >       |     ^~~~~~~~~~~~~~~~~~~~~~~
>> > In file included from ./qapi/qapi-types-error.h:17,
>> >                  from /var/home/berrange/src/virt/qemu/include/qapi/er=
ror.h:275,
>> >                  from /var/home/berrange/src/virt/qemu/include/qapi/co=
mpat-policy.h:16,
>> >                  from tests/test-qapi-commands-sub-sub-module.c:14:
>> > ./qapi/qapi-features.h:16:5: note: previous definition of =E2=80=98QAP=
I_FEATURE_DEPRECATED=E2=80=99 with type =E2=80=98enum <anonymous>=E2=80=99
>> >    16 |     QAPI_FEATURE_DEPRECATED,
>> >       |     ^~~~~~~~~~~~~~~~~~~~~~~
>> > ninja: build stopped: subcommand failed.
>> > make[1]: *** [Makefile:167: run-ninja] Error 1
>> > make[1]: Leaving directory '/var/home/berrange/src/virt/qemu/build'
>> > make: *** [GNUmakefile:6: build] Error 2
>>=20
>> Compiles for me with PATCH 5/6 taken out.  What am I doing wrong?
>
> The bit in patch 6 which generates the enum still has the prefix:
>
> +        self._genh.add("typedef enum {\n")
> +        for name in features:
> +            self._genh.add(f"    {c_enum_const(self._prefix + 'QAPI_FEAT=
URE', name)},\n")
> +
> +        self._genh.add("} " + c_name(self._prefix + 'QapiFeature') + ";\=
n")

Alright, I got it to fail with the appended patch.  I'll have a closer
look.  Thanks!

[...]

diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
index 9b77be6310..1eb0c8a8ac 100644
--- a/scripts/qapi/features.py
+++ b/scripts/qapi/features.py
@@ -55,9 +55,9 @@ def visit_end(self) -> None:
=20
         self._genh.add("typedef enum {\n")
         for name in features:
-            self._genh.add(f"    {c_enum_const(self._prefix + 'QAPI_FEATUR=
E', name)},\n")
+            self._genh.add(f"    {c_enum_const('QAPI_FEATURE', name)},\n")
=20
-        self._genh.add("} " + c_name(self._prefix + 'QapiFeature') + ";\n")
+        self._genh.add("} " + c_name('QapiFeature') + ";\n")
=20
     def _record(self, features: List[QAPISchemaFeature]):
         for f in features:


