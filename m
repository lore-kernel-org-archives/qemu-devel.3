Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E20FC5904
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVXo-00072W-70; Thu, 26 Feb 2026 02:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvVXe-0006zn-M7
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvVXb-0007Lq-Pp
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772089926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBdUl52cQDccib0nRxMgzOcVdooF8JsO4LTwPImhd04=;
 b=D+ZrGN2OUOeRRDq1a2Sw2PeDKgKAUONNF097rDoFdnAoloSTCJewS18bt8Qi1l8SfBKTh/
 5jeQAZVFfHcslcY3NTuJArp3y5tmZClpZ8OkV89/adNT0OcUJg77xZJpUyrS01Rn6UWaX/
 vGwutAYe7aTsIry31+AIQXwYFkqspQ8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-T9Rgry4ZPfaPSzmqrCYjrg-1; Thu,
 26 Feb 2026 02:12:04 -0500
X-MC-Unique: T9Rgry4ZPfaPSzmqrCYjrg-1
X-Mimecast-MFC-AGG-ID: T9Rgry4ZPfaPSzmqrCYjrg_1772089922
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D115F18005AD; Thu, 26 Feb 2026 07:12:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 665871956053; Thu, 26 Feb 2026 07:12:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E77F121E6932; Thu, 26 Feb 2026 08:11:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Stefan Weil
 <sw@weilnetz.de>,  "Dr. David Alan Gilbert" <dave@treblig.org>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  devel@lists.libvirt.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 25/27] util: add support for formatting a program
 name in messages
In-Reply-To: <aZ8iSclFzGgPEH1t@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 25 Feb 2026 16:24:41 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-26-berrange@redhat.com>
 <87ikbt3v0y.fsf@pond.sub.org> <aZ8iSclFzGgPEH1t@redhat.com>
Date: Thu, 26 Feb 2026 08:11:57 +0100
Message-ID: <871pi8htc2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Feb 19, 2026 at 11:08:45AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The error_report function can include the program name in any
>> > messages it prints. The qemu_log function has no equivalent
>> > behaviour.
>> >
>> > This introduces support for a "program name" in the new
>> > messages API, which will be included by default for all
>> > binaries.
>> >
>> > This change tweaks the output of the error_report function,
>> > adding a space between the program name and the location
>> > info.
>>=20
>> Why?
>
> Looking again, arguably that is fixing a pre-existing bug
>
> The current code is:
>
>     if (!monitor_cur() && g_get_prgname()) {
>         error_printf("%s:", g_get_prgname());
>         sep =3D " ";
>     }
>     switch (cur_loc->kind) {
>     case LOC_CMDLINE:
>         argp =3D cur_loc->ptr;
>         for (i =3D 0; i < cur_loc->num; i++) {
>             error_printf("%s%s", sep, argp[i]);
>             sep =3D " ";
>         }
>         error_printf(": ");
>         break;
>     case LOC_FILE:
>         error_printf("%s:", (const char *)cur_loc->ptr);
>         if (cur_loc->num) {
>             error_printf("%d:", cur_loc->num);
>         }
>         error_printf(" ");
>         break;
>     default:
>         error_printf("%s", sep);
>     }
>
>
> Notice how we honour "sep" for LOC_CMDLINE but ignore
> it for LOC_FILE.

This works exactly as intended.  To illustrate, add

    error_report("test, ignore");

to qdev_device_add(), then:

    $ cat t.cfg
    [device]
      driver =3D "usb-kbd"
    $ qemu-system-x86_64 -S -display none -machine usb=3Don -device usb-kbd=
 -readconfig t.cfg -monitor stdio
    QEMU 10.2.50 monitor - type 'help' for more information
    qemu-system-x86_64: -device usb-kbd: test, ignore
    qemu-system-x86_64:t.cfg:2: test, ignore
    (qemu) device_add usb-kbd
    test, ignore

The format

    program:sourcefile:lineno: message

conforms to the GNU Coding Standards at
<https://www.gnu.org/prep/standards/standards.html#Errors>, and matches
common practice.

> With the program name printing moved out into a separate
> function, the space is always printed. No change for
> LOC_CMDLINE, but new whitespace for LOC_FILE.
>
> Should have changed this in a separate patch.
>
>> >       The qemu_log function will gain the program name. This
>> > can be easily seen with the 'log' trace backend, and how it
>> > is now more closely matching error_report output.
>> >
>> > Before:
>> >
>> >   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 't=
race:qcrypto*'
>> >   qcrypto_tls_creds_x509_load TLS creds x509 load creds=3D0x5584e13937=
f0 dir=3Dfish
>> >   qcrypto_tls_creds_get_path TLS creds path creds=3D0x5584e13937f0 fil=
ename=3Dca-cert.pem path=3D<none>
>> >   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: N=
o such file or directory
>> >
>> > After:
>> >
>> >   # qemu-system-x86_64 -object tls-creds-x509,id=3Dt0,dir=3Dfish -d 't=
race:qcrypto*'
>> >   qemu-system-x86_64: qcrypto_tls_creds_x509_load TLS creds x509 load =
creds=3D0x5584e13937f0 dir=3Dfish
>> >   qemu-system-x86_64: qcrypto_tls_creds_get_path TLS creds path creds=
=3D0x5584e13937f0 filename=3Dca-cert.pem path=3D<none>
>> >   qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: N=
o such file or directory
>> >
>> > When adding this the '-msg program-name=3Don|off' option is
>> > introduced, so that the program name (which is enabled by
>> > default) can be supressed if desired. This could be useful
>> > if '-msg guest-name=3Don' is being used as a more informative
>> > identifier.
>>=20
>> Separate patch?
>
> It is a bit of a borderline decision, but I felt the knob to turn it
> off should be in the same patch that force enables it.

Peter objected to making the logs more verbose by default, and I think
he has a point.  Perhaps having errors and logs share a general format
is useful anyway, and perhaps making it even more configurable is as
well.  I figure we'd need separate configuration for logs and for error
messages.

Let's get to rough consensus before we debate the finer points like this
one.

>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> With regards,
> Daniel


