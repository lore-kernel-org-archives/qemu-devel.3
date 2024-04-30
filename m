Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D838C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1i2c-0000TJ-17; Tue, 30 Apr 2024 03:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1i2K-0000SF-24
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1i2F-00041j-Vo
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714462577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRwvZv5W4b9sr9KIyZCYA0fPwcvOhPMI97ef33cQdfQ=;
 b=LGIXsfIvd0ZKrdB6q3jpA/j6pDLy0ahi4S3TGmMleHNE5Wg+RtaIpNoqPccgCQAOWK3D+i
 BC9aPjt9blq2TkY/ujipbbCBYpdLpgm1DelkaQ1RXLa32BPgUhlhZq98kNUEvWwF/SV2MB
 NLmKiVa819cxeKj2+U6wEyYwgDjuw1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-LRGHqIWQOz61XkIxhys96A-1; Tue, 30 Apr 2024 03:36:13 -0400
X-MC-Unique: LRGHqIWQOz61XkIxhys96A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4174803505;
 Tue, 30 Apr 2024 07:36:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85FF440C5C2;
 Tue, 30 Apr 2024 07:36:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7935B21E6811; Tue, 30 Apr 2024 09:36:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  QEMU
 Developers
 <qemu-devel@nongnu.org>,  Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  afaerber@suse.de,
 ale@rev.ng, alistair.francis@wdc.com,  Anton Johansson <anjo@rev.ng>,
 bbauman@redhat.com,  bcain@quicinc.com,  Chao Peng
 <chao.p.peng@linux.intel.com>,  cjia@nvidia.com,  clg@kaod.org,
 cw@f00f.org,  Damien Hedde <dhedde@kalrayinc.com>,  eblake@redhat.com,
 edgar.iglesias@gmail.com,  eduardo@habkost.net,  Elena Ufimtseva
 <elena.ufimtseva@oracle.com>,  eric.auger@redhat.com,  felipe@nutanix.com,
 iggy@theiggy.com,  imp@bsdimp.com,  jan.kiszka@web.de,  jgg@nvidia.com,
 jidong.xiao@gmail.com,  jim.shu@sifive.com,  jjherne@linux.vnet.ibm.com,
 Joao Martins <joao.m.martins@oracle.com>,  konrad.wilk@oracle.com,  Luc
 Michel <luc@lmichel.fr>,  mburton@qti.qualcomm.com,  mdean@redhat.com,
 mimu@linux.vnet.ibm.com,  paul.walmsley@sifive.com,  pbonzini@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,  shentey@gmail.com,
 stefanha@gmail.com,  wei.w.wang@intel.com,  z.huo@139.com,  LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  zwu.kernel@gmail.com,
 eblot@rivosinc.com,  max.chou@sifive.com
Subject: Re: QEMU Community Call Agenda Items (April 30th, 2024)
In-Reply-To: <Zi_C_xHx33Q7T_96@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 29 Apr 2024 16:55:43 +0100")
References: <b534d873-9be3-4a24-800f-603ed25c0803@linaro.org>
 <ebdd9766-04d1-4908-996f-e93c0cd4e6d5@linaro.org>
 <Zi_C_xHx33Q7T_96@redhat.com>
Date: Tue, 30 Apr 2024 09:36:07 +0200
Message-ID: <87v83zcnfc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Mon, Apr 29, 2024 at 05:06:36PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi,
>>=20
>> On 29/4/24 00:25, Philippe Mathieu-Daud=C3=A9 wrote:
>> > Hi,
>> >=20
>> > The KVM/QEMU community call is at:
>> >=20
>> >  =C2=A0 https://meet.jit.si/kvmcallmeeting
>> >  =C2=A0 @
>> >  =C2=A0 30/4/2024 14:00 UTC
>> >=20
>> > Are there any agenda items for the sync-up?
>>=20
>> I'd like to discuss two issues:
>>=20
>> 1/ Stability of QOM path
>>    ---------------------
>>=20
>>   Currently we have 3 QOM containers:
>>    - /machine
>>      QOM objects properly parented go there
>>    - /machine/unattached
>>      Orphan QOM objects. Missing parent is usually easy
>>      to figure out, but we need to post patches to fix them.
>>    - /machine/peripheral[-anon]
>>      Devices created at runtime with CLI -device or QAPI device_add.
>>      (-anon is for devices with no explicit bus ID).
>>    See "Problem 4: The /machine/unattached/ orphanage" in [1].
>>=20
>>   The /machine and /machine/unattached trees are stable, although
>>   by adding parent to orphan objects, their path will change.
>>=20
>>   Objects in /machine/peripheral[-anon] depend on the order of
>>   the device_add commands / arguments used.
>>=20
>>   In a dynamically created machine, everything depend on how the
>>   device_add commands are processed.
>>=20
>>   How can be expect to easily reference a QOM object by its path?
>
> FYI, for reference libvirt uses a couple of QOM paths
>
>  * "/machine/unattached/device[0]" - path of first vCPU, but
>    this is an historical artifact - nowdays we query the
>    paths from query-cpus-fast

This is the only iffy use.  The numbering of devices in
/machine/unattached/ is not stable in practice.  #0 may well be stable
enough, though.

>  * "/machine/peripheral/%s/virtio-backend" where '%s' is the
>    ID we give the virtio device, for virtio-blk disks
>
>  * /machine/peripheral/%s/%s.0/legacy[0] where both '%s'  are
>    the ID we give the USB defvice, for USB disks
>
>  * /machine/peripheral  when enumerating devices we've
>    assigned ID aliases to.

/machine/peripheral/ID is ABI.  No worries.

>  * /machine to get the rtc-time property value

This is an alias to the RTC device's "rtc-time" property.  Only some
machines define it.  Useful because the actual property depends on
machine type and configuration.  For q35, it's
/machine/unattached/device[N]/rtc/date, where N can vary.

If we moved the southbridge out of the /machine/unattached dump, we'd
have something like /machine/q35/ich9-lpc/rtc/date.  Stable, but you
have to know the machine type to find it.

[...]


