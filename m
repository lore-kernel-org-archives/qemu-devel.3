Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E89FED2E8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0b3h-0004qS-It; Thu, 12 Mar 2026 04:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0b3R-0004pb-KZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0b3O-0004J0-6l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773302756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cDJCswpOQ5SwAVagmCWDtE7V6v8QDtekGazslYOahIA=;
 b=hGQgn+qzjz7vqeHmSe3JExi0/7yqXGdSd3Pw9Mb0sHnQbdDYTYCOButk3etf7ir+MoStrd
 rkAeFqhlrr8DoEzc8TqVOPlTewpTadFQtGQkLawT6AEWGZLa9p4mGzdEOAx5iskc4nCkle
 NJi/ZnMq3F2qVRrvMiQbdj1m8w4GNao=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-JOkfxnKwPPygBa-Ri-bqNQ-1; Thu,
 12 Mar 2026 04:05:52 -0400
X-MC-Unique: JOkfxnKwPPygBa-Ri-bqNQ-1
X-Mimecast-MFC-AGG-ID: JOkfxnKwPPygBa-Ri-bqNQ_1773302751
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9956519539A3; Thu, 12 Mar 2026 08:05:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 556D430002D6; Thu, 12 Mar 2026 08:05:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9E7921E6937; Thu, 12 Mar 2026 09:05:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: -device T,help crashes
In-Reply-To: <2bdcb31f-b53b-44eb-ae70-b36e73cdad1c@redhat.com> (Thomas Huth's
 message of "Wed, 11 Mar 2026 16:14:35 +0100")
References: <87pl5abgpl.fsf@pond.sub.org>
 <CAFEAcA_tJRFKGCFdG-x+QAwur7VuqZUqhJg_U-hKi1iym5=+Ng@mail.gmail.com>
 <2bdcb31f-b53b-44eb-ae70-b36e73cdad1c@redhat.com>
Date: Thu, 12 Mar 2026 09:05:48 +0100
Message-ID: <87jyvhzd43.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Thomas Huth <thuth@redhat.com> writes:

> On 11/03/2026 15.55, Peter Maydell wrote:
>> On Wed, 11 Mar 2026 at 14:10, Markus Armbruster <armbru@redhat.com> wrote:
>>>
>>> Watch this:
>>>
>>>      $ qemu-system-aarch64 -S -display none -M virt -device acpi-ged,help
>>>      qemu-system-aarch64: ../hw/core/qdev.c:858: qdev_get_machine: Assertion `dev' failed.
>>>
>>> A number of devices crash this way:
>>>
>>> * acpi-ged (aarch64 arm i386 loongarch64 x86_64)
>>> * fsl-imx6 (aarch64 arm)
>>> * fsl-imx7 (aarch64 arm)
>>> * fsl-imx8mp (aarch64)
>>> * microchip.pfsoc (riscv64)
>>> * riscv.sifive.e.soc (riscv32 riscv64)
>>> * xlnx-zynqmp (aarch64)
>> 
>> Largely speaking these are pretty useless to try to create on
>> the command line, of course...
>
> Agreed, but note that you can also query help for non-user-creatable devices 
> normally, e.g.:
>
> $ ./qemu-system-x86_64 -device port92
> qemu-system-x86_64: -device port92: Parameter 'driver' expects a pluggable 
> device type
> $ ./qemu-system-x86_64 -device port92,help
> port92 options:
>    a20[0]=<link<irq>>
>    port92[0]=<child<memory-region>>

Correct.

QOM introspection needs to create and destroy an object, and this must
effectively be a no-op.  I don't like that part of its design, but it's
what we got.

> ... so we likely should fix the crashes anyway, even if we decide to mark 
> the devices with user_creatable = false.

In fact, the devices mentioned above are all marked already.


