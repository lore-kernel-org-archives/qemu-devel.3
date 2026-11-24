Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CD606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pond.sub.org header.i=@pond.sub.org header.a=rsa-sha256 header.s=mail header.b=rg5nlr0B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVntM-0002d0-89; Tue, 24 Nov 2026 05:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVntK-0002ce-Bw
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:36:51 -0500
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1xVntI-0003Gv-7c
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pond.sub.org; s=mail;
 t=1795516596; bh=wpRm6/SvpfGcBOahBiTAc0ENTvxsatAHAxrgew4ODnk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rg5nlr0B2RIc7i4JJFwlm3iW0nUcB4vmdf1IypF2PDmciPl8EvjDw0/qZFRdDeOOA
 l4lntNLPtOPN0yo5vSQoKRBu42VLi0Vq6rBly3JVCfOmouIQ4aApyqSLTH+UWGTZX8
 DWQoGfTUTWQdUaxt8iWS6Nl8IBzH5X+mhqKg9TUY=
Received: from blackfin.pond.sub.org
 (p200300d36f05b900e5f885c0cd39d8e9.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f05:b900:e5f8:85c0:cd39:d8e9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 2A16820C58;
 Tue, 24 Nov 2026 11:36:34 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8054C21E6A04; Tue, 24 Nov 2026 11:36:41 +0100 (CET)
From: Markus Armbruster <armbru@pond.sub.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Jag Raman
 <jag.raman@oracle.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: x-remote-object breaks QOM introspection
In-Reply-To: <awAKcZ-HG5M7qjVQ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 20 Nov 2026 08:53:05 +0000")
References: <87jymbjyia.fsf@pond.sub.org>
 <E30ADD82-0779-4294-B235-D27FD379C9D6@oracle.com>
 <877bi9e4mi.fsf@pond.sub.org>
 <C03B480F-3701-4DEB-A9DD-6C0F80A62568@oracle.com>
 <av8i7zkyTMX91FZs@redhat.com> <87mrr484cq.fsf@pond.sub.org>
 <awAKcZ-HG5M7qjVQ@redhat.com>
Date: Tue, 24 Nov 2026 11:36:41 +0100
Message-ID: <87pkvufrd2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Nov 20, 2026 at 06:21:57AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Thu, Nov 19, 2026 at 04:13:31PM +0000, Jag Raman wrote:

[...]

>> >> When x-remote-object is instantiated, the PCI device identified by o-=
>devid may not
>> >> yet exist because it appears later in QEMU=E2=80=99s command-line opt=
ions. As a result,
>> >> qdev_find_recursive() may fail to find it. Deferring the lookup until=
 machine init done
>> >> ensures that all devices have been instantiated and can be found usin=
g qdev_find_recursive().
>> >
>> > We've already got hacks to process different -object classes at
>> > different phases of command line processing. It sounds like
>> > x-remote-object needs to be set to be processed after -device.
>> >
>> > ie we need a new object_create_very_late() to be run after
>> > qemu_create_cli_devices()
>>=20
>> Many devices interact with supporting objects.  We have a common
>> frontend / backend pattern:
>>=20
>> * The device (frontend) has a property identifying the object (backend).
>>   The property setter resolves the property value to an object of the
>>   required type, and fails if it can't.  This also fails device
>>   creation.
>>=20
>>   CLI works, because we execute -object before -device.
>>=20
>>   Monitor works as long as users object_add before device_add.
>>=20
>> * Ideally, the device can work with any object of the required kind.
>>   When it can't, which isn't rare, its .realize() checks the object is
>>   suitable, and fails if it isn't.  This also fails device creation.
>>=20
>> Why isn't this workable here?
>
> The relationship between the object and device is reversed from
> the normal direction in the case of x-remote-object.
>
> Normally an object provides some kind of backend service that
> is consumed by the device.
>
> In this case the device can be any PCI endpoint and x-remote-object
> is consuming the device, in order to export it over the network
> to another "client" QEMU process which uses the x-pci-proxy-dev.
>
>
> So in the monitor you would use object_add x-remote-object after
> device_add <whatever>, and likewise the CLI should create
> "x-remote-object" after processing all -device.

I see.

The CLI should execute options left to right, just like the monitor
executes commands in order.  It doesn't, and we've worked around the
resulting problems since forever.  Fixing it for good would be hard and
painful.

