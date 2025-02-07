Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2E1C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 12:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgNoG-00005v-5B; Fri, 07 Feb 2025 07:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgNny-0008Ot-7I
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tgNnv-0006Cu-2q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 07:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738932594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ACbs5y7bwLfuM7WcKRPlYYsOm/ka0y+AxXv51HcvjXA=;
 b=DbudYmaIXoll72FsBh5UccbQ6yLM54iZqlMWwc0stAZMcFg/0a9zVSw8yQ5fzhqTZBm8Ca
 XrdoZZDHcovgOZYpyKG1deW6vKbDbdE7ZDHLnV6ejfykAUg3WElvhV7REG8IoPhGwK/SVV
 aDB8Nq6YkFB5DPxp3NzIWh75sCNHhcs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-LW7Ymt0-MbyNNieWC-LsFQ-1; Fri,
 07 Feb 2025 07:49:50 -0500
X-MC-Unique: LW7Ymt0-MbyNNieWC-LsFQ-1
X-Mimecast-MFC-AGG-ID: LW7Ymt0-MbyNNieWC-LsFQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CC191956094; Fri,  7 Feb 2025 12:49:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40BCB1800360; Fri,  7 Feb 2025 12:49:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF9AB21E6A28; Fri, 07 Feb 2025 13:49:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-ppc@nongnu.org,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 4/8] hw/boards: Remove all invalid uses of
 auto_create_sdcard=true
In-Reply-To: <34235ce5-9f6c-4968-a8c1-ab868389e9cf@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 6 Feb 2025 11:12:46
 +0100")
References: <20250204180746.58357-1-philmd@linaro.org>
 <20250204180746.58357-5-philmd@linaro.org>
 <87a5b07u1d.fsf@pond.sub.org>
 <34235ce5-9f6c-4968-a8c1-ab868389e9cf@linaro.org>
Date: Fri, 07 Feb 2025 13:49:44 +0100
Message-ID: <8734gpj4wn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> On 5/2/25 08:03, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> MachineClass::auto_create_sdcard is only useful to automatically
>>> create a SD card, attach a IF_SD block drive to it and plug the
>>> card onto a SD bus. Only the ARM and RISCV targets use such
>>> feature:
>>>
>>>   $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
>>>   hw/arm
>>>   hw/riscv
>>>   $
>>>
>>> Remove all other uses.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>=20
>> Impact?
>>=20
>> As far as I can tell, this stops creation of the if=3Dsd default drive
>> these machines don't actually use.  Correct?
>
> Yes, since these machines don't expose a SD-bus, the drive can
> not be attached and always triggers the same error:
>
> $ qemu-system-hppa -sd /bin/sh
> qemu-system-hppa: -sd /bin/sh: machine type does not support=20
> if=3Dsd,bus=3D0,unit=3D0

To be precise...

Before the series, a bunch of machines create an if=3Dsd,index=3D0 drive by
default even though they cannot use it.  HMP "info block" shows it:

    sd0: [not inserted]
        Removable device: not locked, tray closed

"By default" means -nodefaults suppresses it.

After the series, this default drive is gone.

That is all.

Correct?

The commit message could be clearer about this.  Perhaps:

    hw/boards: Do not create unusable default if=3Dsd drives

    A number of machines create an if=3Dsd drive by default even though
    they lack an SD bus, and therefore cannot use the drive.

    This drive is created when the machine sets flag
    @auto_create_sdcard.

    Delete that from machines that lack an SD bus.

Listing the affected machines might be useful.

Worth a mention in the release notes?  I don't know.


