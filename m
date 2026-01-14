Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B15D37E2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0hq-0001SJ-Tj; Wed, 14 Jan 2026 08:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0hM-0001N4-AY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:14:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0hK-0002ch-HY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768396445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VF+4CofWT/uDPWbqrNbk5YpetW+t8sgEb1VGTugRRMs=;
 b=XDtTBR0zkyjBm9feq6kRg15Cpi6axhGdbpMws6RmhP92kx6cCx7BFa0cdfZo5UZrc6BL90
 olPXPUxqqk5xQJHbt+pwIGcMEnclSfpulTr3fCawkBsFhdzgdeOV6wNGy5oN1QuBzoswZS
 OFnP3VMB0wUtFHAYUSTc6/shhEkcq7Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-fWxIxb9LOr6tZvlaOw0JCw-1; Wed,
 14 Jan 2026 08:14:02 -0500
X-MC-Unique: fWxIxb9LOr6tZvlaOw0JCw-1
X-Mimecast-MFC-AGG-ID: fWxIxb9LOr6tZvlaOw0JCw_1768396441
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D195F19560A5; Wed, 14 Jan 2026 13:14:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 527DE19560A7; Wed, 14 Jan 2026 13:14:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D670521E692D; Wed, 14 Jan 2026 14:13:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  devel@lists.libvirt.org,
 qemu-block@nongnu.org,  qemu-rust@nongnu.org,  Stefan Weil
 <sw@weilnetz.de>,  Kevin Wolf <kwolf@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 14/24] monitor: move error_vprintf back to
 error-report.c
In-Reply-To: <aWeHlpz7m4hpPQCA@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 14 Jan 2026 12:09:58 +0000")
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-15-berrange@redhat.com>
 <87jyxl8wfo.fsf@pond.sub.org> <aWeHlpz7m4hpPQCA@redhat.com>
Date: Wed, 14 Jan 2026 14:13:57 +0100
Message-ID: <87sec81gmi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jan 13, 2026 at 02:38:19PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The current unit tests rely on monitor.o not being linked, such
>> > that the monitor stubs get linked instead. Since error_vprintf
>> > is in monitor.o this allows a stub error_vprintf impl to be used
>> > that calls g_test_message.
>> >
>> > This takes a different approach, with error_vprintf moving
>> > back to error-report.c such that it is always linked into the
>> > tests. The monitor_vprintf() stub is then changed to use
>> > g_test_message if QTEST_SILENT_ERRORS is set, otherwise it will
>> > return -1 and trigger error_vprintf to call vfprintf.
>> >
>> > The end result is functionally equivalent for the purposes of
>> > the unit tests.
>> >
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

[...]

>> Without stubs, no change in behavior.
>>=20
>> With both stubs, before the patch:
>>=20
>>     monitor_vprintf() is not supposed to run, and aborts
>>=20
>>     error_vprintf() calls g_test_message() for tests, else vfprintf()
>>=20
>> afterwards:
>>=20
>>     monitor_vprintf() calls g_test_message() and succeeds in tests, else
>>     fails
>>=20
>>     error_vprintf() calls monitor_printf(), and when it fails falls back
>>     to vfprintf().
>>=20
>> Alright, error_vprintf() behaves the same as before.
>>=20
>> monitor_vprintf() no longer aborts.  Hmm.  What if we somehow acquire
>> calls?  In tests, they'll go to g_test_message(), which is fine, I
>> guess.  Outside tests, they'll fail.  So does the non-stub version
>> unless the current monitor is HMP.  Also fine, I guess.
>>=20
>> Is it possible to link just one of the stubs?
>
> There is only 1 stub after this patch - for monitor_vprintf().
> error_vprintf() is never stubbed anymore.
>
> The interesting scenario outside there tests is the non-system emulator
> binaries.
>
> Those will not have the monitor code, so will get the monitor_vprintf
> stub. That will report g_test_initialized() =3D=3D false, and so the stub
> will return -1.  error_vprintf() will see this -1 return value and
> thus call to vfprintf().
>
> So the behaviour is again the same as before this patch AFAICT for all
> linkage scenarios.

Thank you!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


