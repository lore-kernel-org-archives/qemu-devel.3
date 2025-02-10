Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D2CC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUzJ-0001Md-7L; Mon, 10 Feb 2025 09:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thUzB-0001Ht-5r
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thUz9-0001sr-0P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739198525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssA5j+bS7A7gy/93PxJkEwzIFJ0JIO3eg1MJ5VPaLvI=;
 b=dqLM42QWce0osjoRsI6JQkSUM5MAc3l3uM+anjfDj2earqBXqd5uyzp9EgTOe3PdqTND5f
 UmOSYVH0zllldLxcyNbFqVCfLKEDfYjHPl6SNmfr5IaAa1g5YjrmyRWJNUNE4qdwTPbniV
 dDDBgYSrBo4l10b7tWcS7GoLrK1mZE4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-5PJrxQaoMUWLDEepON4KdA-1; Mon,
 10 Feb 2025 09:42:04 -0500
X-MC-Unique: 5PJrxQaoMUWLDEepON4KdA-1
X-Mimecast-MFC-AGG-ID: 5PJrxQaoMUWLDEepON4KdA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D943D1956094; Mon, 10 Feb 2025 14:42:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5566219560A3; Mon, 10 Feb 2025 14:41:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB91621E6A28; Mon, 10 Feb 2025 15:41:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-ppc@nongnu.org,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 4/8] hw/boards: Remove all invalid uses of
 auto_create_sdcard=true
In-Reply-To: <96b39b3e-1a90-457c-bd8a-40a1b6216c1a@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 10 Feb 2025 15:03:34
 +0100")
References: <20250204180746.58357-1-philmd@linaro.org>
 <20250204180746.58357-5-philmd@linaro.org>
 <87a5b07u1d.fsf@pond.sub.org>
 <34235ce5-9f6c-4968-a8c1-ab868389e9cf@linaro.org>
 <8734gpj4wn.fsf@pond.sub.org>
 <96b39b3e-1a90-457c-bd8a-40a1b6216c1a@linaro.org>
Date: Mon, 10 Feb 2025 15:41:56 +0100
Message-ID: <87pljp3lqj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 7/2/25 13:49, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> On 5/2/25 08:03, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>>>
>>>>> MachineClass::auto_create_sdcard is only useful to automatically
>>>>> create a SD card, attach a IF_SD block drive to it and plug the
>>>>> card onto a SD bus. Only the ARM and RISCV targets use such
>>>>> feature:
>>>>>
>>>>>    $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
>>>>>    hw/arm
>>>>>    hw/riscv
>>>>>    $
>>>>>
>>>>> Remove all other uses.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>>
>>>> Impact?
>>>>
>>>> As far as I can tell, this stops creation of the if=3Dsd default drive
>>>> these machines don't actually use.  Correct?
>>>
>>> Yes, since these machines don't expose a SD-bus, the drive can
>>> not be attached and always triggers the same error:
>>>
>>> $ qemu-system-hppa -sd /bin/sh
>>> qemu-system-hppa: -sd /bin/sh: machine type does not support
>>> if=3Dsd,bus=3D0,unit=3D0
>>=20
>> To be precise...
>>=20
>> Before the series, a bunch of machines create an if=3Dsd,index=3D0 drive=
 by
>> default even though they cannot use it.  HMP "info block" shows it:
>>=20
>>      sd0: [not inserted]
>>          Removable device: not locked, tray closed
>>=20
>> "By default" means -nodefaults suppresses it.
>>=20
>> After the series, this default drive is gone.
>>=20
>> That is all.
>>=20
>> Correct?
>
> Correct.
>
>> The commit message could be clearer about this.  Perhaps:
>>=20
>>      hw/boards: Do not create unusable default if=3Dsd drives
>>=20
>>      A number of machines create an if=3Dsd drive by default even though
>>      they lack an SD bus, and therefore cannot use the drive.
>>=20
>>      This drive is created when the machine sets flag
>>      @auto_create_sdcard.
>>=20
>>      Delete that from machines that lack an SD bus.
>
> I reworded as:
>
>      hw/boards: Do not create unusable default if=3Dsd drives
>
>      A number of machines create an if=3Dsd drive by default even though
>      they lack an SD bus, and therefore cannot use the drive.
>
>      This drive is created when the machine sets flag
>      @auto_create_sdcard.
>
>      See for example running HMP "info block" on the HPPA C3700 machine:
>
>        $ qemu-system-hppa -M C3700 -monitor stdio -S
>        (qemu) info block
>
>        floppy0: [not inserted]
>            Removable device: not locked, tray closed
>
>        sd0: [not inserted]
>            Removable device: not locked, tray closed
>
>        $ qemu-system-hppa -M C3700 -sd /bin/sh
>        qemu-system-hppa: -sd /bin/sh: machine type does not support=20
> if=3Dsd,bus=3D0,unit=3D0
>
>      Delete that from machines that lack an SD bus.
>
>      Note, only the ARM and RISCV targets use such feature:
>
>       $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
>       hw/arm
>       hw/riscv
>       $

Lovely, thanks!

>> Listing the affected machines might be useful.
>
> I'll pass :)
>
>> Worth a mention in the release notes?  I don't know.
>
> I don't think so, since nothing working is lost.

Okay :)


