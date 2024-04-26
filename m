Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16837C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0JLF-00010p-VJ; Fri, 26 Apr 2024 07:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1s0JL0-0000my-Tt
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 07:02:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1s0JKy-0000Gh-Sm
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 07:01:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43QASUQx014977; Fri, 26 Apr 2024 11:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GG6Um5/vczsa7gsxrIsDjUsbYKM/BPPlRNbs0CMfiTE=;
 b=nO+CTHtk1MzcrXY4B2uMV1FyjMNHCJ/SOFCT+2ZVZXrXZM7wbCFILbu/1AnA5WdpmzZz
 lZpM8lr5jW0Jm8eQPYQyCJo/htbNjD9IAHez55CaJchprZPg6/GZpNlv2FLZeSSX2KeS
 gDRTnm9IT0wgOG0zmR0qDbn+u5+GBjPO3W+PjOFaHYp3ztPF3Q4fQB73tv48rLltAGh2
 z2ZpnQoKUwvZfEonArU/koI5hscWTuVDmeiP46r8gnxCQID8yjkwquqHF1Vbu3H1eBuY
 /r/8BCjUBzt3ja9P8mWUytLsSp5S7hJiOdk3K9TATSPSIHJUgiosozBwD8nA5NfJqokO Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrahtg2gp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:01:51 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43QAxh1Q027818;
 Fri, 26 Apr 2024 11:01:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrahtg2gj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:01:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43Q8YFiH023050; Fri, 26 Apr 2024 11:01:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1pfanp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Apr 2024 11:01:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43QB1ib952625708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Apr 2024 11:01:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BA6C20043;
 Fri, 26 Apr 2024 11:01:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D74920040;
 Fri, 26 Apr 2024 11:01:43 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown
 [9.171.47.169])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 11:01:43 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "vsementsov@yandex-team.ru"
 <vsementsov@yandex-team.ru>, "yc-core@yandex-team.ru"
 <yc-core@yandex-team.ru>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
In-Reply-To: <121531714120162@mail.yandex-team.ru>
References: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
 <8734r8k07s.fsf@linux.ibm.com> <121531714120162@mail.yandex-team.ru>
Date: Fri, 26 Apr 2024 13:01:42 +0200
Message-ID: <87v844ie09.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JIz_s8Kj0buXpXP69T6mjAdxqekkfiaQ
X-Proofpoint-GUID: CVRY4CxZQJby_omlzg1W2W-u1xKIWwZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260072
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 26, 2024 at 11:57 AM +0300, Dmitrii Gavrilov <ds-gavr@yandex-te=
am.ru> wrote:
> 26.04.2024, 11:17, "Marc Hartmayer" <mhartmay@linux.ibm.com>:
>
>  On Fri, Nov 03, 2023 at 01:56 PM +0300, Dmitrii Gavrilov <ds-gavr@yandex=
-team.ru> wrote:
>
>   Original goal of addition of drain_call_rcu to qmp_device_add was to co=
ver
>   the failure case of qdev_device_add. It seems call of drain_call_rcu was
>   misplaced in 7bed89958bfbf40df what led to waiting for pending RCU call=
backs
>   under happy path too. What led to overall performance degradation of
>   qmp_device_add.
>
>   In this patch call of drain_call_rcu moved under handling of failure of
>   qdev_device_add.
>
>   Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
>
>  I don't know the exact reason, but this commit caused udev events to
>  show up much slower than before (~3s vs. ~23s) when a virtio-scsi device
>  is hotplugged (I=E2=80=99ve tested this only on s390x). Importantly, thi=
s only
>  happens when asynchronous SCSI scanning is disabled in the *guest*
>  kernel (scsi_mod.scan=3Dsync or CONFIG_SCSI_SCAN_ASYNC=3Dn).
>
>  The `udevadm monitor` output captured while hotplugging the device
>  (using QEMU 012b170173bc ("system/qdev-monitor: move drain_call_rcu call
>  under if (!dev) in qmp_device_add()")):
>

[=E2=80=A6snip=E2=80=A6]

>  Any ideas?
>
>  Thanks in advance.
>
>  Kind regards,
>   Marc
>
> Hello!
>=20=20
> Thank you for mentioning this.
>=20=20
> At first glance it seems that using scsi in synchonous mode caues the glo=
bal
> QEMU mutex lock until the scanning phase is complete. Prior to 012b170173=
bc
> ("system/qdev-monitor: move drain_call_rcu call under if (!dev) in
> qmp_device_add()") on each device adition the lock would be forcibly remo=
ved
> allowing callbacks (including UDEV ones) to be processed after a new devi=
ce
> is added.
>=20=20
> I`ll try to investigate this furter. But currently it appears to me like
> performance or observability dilemma.

I tried the test on my local laptop (x86_64) and there seems to be no
issue (I used the kernel cmdline option scsi_mod.scan=3Dsync for the
guest) - guest and host kernel =3D=3D 6.8.7. But please double check.

>=20=20
> Is behaviour you mentioning consistant?

Yep, at least for more than 50 iterations (I stopped the test then).

>=20=20
> Best regards,
> Dmitrii
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

