Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA63C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp4V5-0002Gs-Rd; Tue, 26 Mar 2024 06:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp4V3-0002Fn-Po
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp4V2-0002iD-AF
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711450667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsAuvtjcGMknxupq7dt0Tx5jDHTx3kFzc8XXDd0b8jY=;
 b=JEEucI2rSYEcarsAoKO64QnLTRP/HR6awRlGis1Nuz+zFMxejOJjizpaBoWZktpkx8Kbb2
 98syLERWQ8rT1EI0funJfCfoMYRB4eBECfgw9ezGv1zEAZaSiL1Dm7VZeNnSJxpITZUy/G
 VWsbGUdg174sFHOu96FPOxQfjtBUY0c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-YsFiHoJlPj6J1yCYNtY6uw-1; Tue,
 26 Mar 2024 06:57:41 -0400
X-MC-Unique: YsFiHoJlPj6J1yCYNtY6uw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA2B0383CD69;
 Tue, 26 Mar 2024 10:57:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E4E1492BC4;
 Tue, 26 Mar 2024 10:57:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8667721E668C; Tue, 26 Mar 2024 11:57:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  Anton Johansson
 <anjo@rev.ng>,  qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Claudio Fontana
 <cfontana@suse.de>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [PATCH-for-9.1 06/21] target/i386: Make X86_CPU common to new
 I386_CPU / X86_64_CPU types
In-Reply-To: <20240315130910.15750-7-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 15 Mar 2024 14:08:54
 +0100")
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-7-philmd@linaro.org>
Date: Tue, 26 Mar 2024 11:57:35 +0100
Message-ID: <87h6gtp8f4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> "target/foo/cpu-qom.h" can not use any target specific definitions.
>
> Currently "target/i386/cpu-qom.h" defines TYPE_X86_CPU depending
> on the i386/x86_64 build type. This doesn't scale in a heterogeneous
> context where we need to access both types concurrently.
>
> In order to do that, introduce the new I386_CPU / X86_64_CPU
> types, both inheriting a common TYPE_X86_CPU base type.
>
> Keep the current "base" and "max" CPU types as 32 or 64-bit,
> depending on the binary built.
>
> Adapt the cpu-plug-test, since the 'base' architecture is now
> common to both 32/64-bit x86 targets.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>

[...]

> diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
> index 7f5dd5f85a..97316d131f 100644
> --- a/tests/qtest/cpu-plug-test.c
> +++ b/tests/qtest/cpu-plug-test.c
> @@ -90,7 +90,7 @@ static void add_pc_test_case(const char *mname)
>      data->machine =3D g_strdup(mname);
>      data->cpu_model =3D "Haswell"; /* 1.3+ theoretically */
>      data->device_model =3D g_strdup_printf("%s-%s-cpu", data->cpu_model,
> -                                         qtest_get_arch());
> +                                         qtest_get_base_arch());
>      data->sockets =3D 1;
>      data->cores =3D 3;
>      data->threads =3D 2;

Doesn't build for me:

../tests/qtest/cpu-plug-test.c: In function =E2=80=98add_pc_test_case=E2=80=
=99:
../tests/qtest/cpu-plug-test.c:93:42: error: implicit declaration of functi=
on =E2=80=98qtest_get_base_arch=E2=80=99; did you mean =E2=80=98qtest_get_a=
rch=E2=80=99? [-Werror=3Dimplicit-function-declaration]
   93 |                                          qtest_get_base_arch());
      |                                          ^~~~~~~~~~~~~~~~~~~
      |                                          qtest_get_arch
../tests/qtest/cpu-plug-test.c:93:42: error: nested extern declaration of =
=E2=80=98qtest_get_base_arch=E2=80=99 [-Werror=3Dnested-externs]
../tests/qtest/cpu-plug-test.c:92:47: error: format =E2=80=98%s=E2=80=99 ex=
pects argument of type =E2=80=98char *=E2=80=99, but argument 3 has type =
=E2=80=98int=E2=80=99 [-Werror=3Dformat=3D]
   92 |     data->device_model =3D g_strdup_printf("%s-%s-cpu", data->cpu_m=
odel,
      |                                              ~^
      |                                               |
      |                                               char *
      |                                              %d
   93 |                                          qtest_get_base_arch());
      |                                          ~~~~~~~~~~~~~~~~~~~~~
      |                                          |
      |                                          int


