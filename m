Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98EFD111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 21:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOjwn-0008Qw-VM; Thu, 27 Nov 2025 16:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vOjwc-0008PD-OL; Thu, 27 Nov 2025 16:54:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vOjwa-0001PW-9a; Thu, 27 Nov 2025 16:54:30 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARF7DMo007498;
 Thu, 27 Nov 2025 21:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DcGOWM
 Rr+MDCjkiBDnxHJo6ZyiP+vJw4OrQ0e/IyLrU=; b=iSAztWTJEAYYlwVRHHrBpx
 HhwFXQhlOwzCmpmwdc7BmvE/3qaGHwZ8ubiz5Mm7v5Km7q7rhXNgUed1rqRm9MVM
 ZguQMag/DvaX4ACf4ChbEZlpBUJitnOhe2ELquKxMncg1n2ialJc7129IF33V4Uf
 s9Br0o3RQJDO+nSirSl1Sa0l17QsnSsAgL8UqUfOkoqan99OR9hTYnLTo2S8j8rI
 H49jK7CUge/w+DgLXzeTcXpBkxcTw8sgAM6K0WaXTcYM4f5v0jGqS8C8ZwgnjN1e
 0hTwcEpxscrFCBiOec0V+M5jKTLtI8OXeKfgTJQqCoYCMJDoV31+qu2KOnut9I+g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kqa8kq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 21:54:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARIjGKk025139;
 Thu, 27 Nov 2025 21:54:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71sskc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Nov 2025 21:54:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ARLsISQ26608038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Nov 2025 21:54:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00C3520043;
 Thu, 27 Nov 2025 21:54:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A042E20040;
 Thu, 27 Nov 2025 21:54:17 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.1.154])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Nov 2025 21:54:17 +0000 (GMT)
Message-ID: <46efeae205376fca9b23944f6c453d19c27b540a.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/4] target/s390x: Fix missing interrupts for small
 CKC values
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Thu, 27 Nov 2025 22:54:17 +0100
In-Reply-To: <115d74c6536473d1a3ec8d9431f186b0d09c2aff.camel@linux.ibm.com>
References: <20251016175954.41153-1-iii@linux.ibm.com>
 <20251016175954.41153-2-iii@linux.ibm.com>
 <a0accce9-6042-4a7b-a7c7-218212818891@redhat.com>
 <115d74c6536473d1a3ec8d9431f186b0d09c2aff.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX22HFGVY2zxk3
 E+ilKVdZB7S49rsKQFY4BFtayMPqsTybbH2L2oxhgZskhdzv2rJtOBLoDgL3QCMGxCLJoc2ssaZ
 0tcugOeoKn4T/bpSOnFV/1eKfp/TLal189hjc+J+uJ62UrnoHKrC9o2LMNBfA0B38IMMCbDMfKV
 tl8uNJBCLEZxTxZ9XrGaMqhlLQNest4UUQdicwO9dCSXWf5fsyWuFqXt6MKsp8LDOMph7whd5F/
 jXM1s8p+pST79nmZnq/pGjrP+Fo3HgdvoA/4ld+kXd+7ECB7lgLI4AR3P6rQnYA4iXOjnEsVsCI
 c4Xuz/2fbIUtEqTsuhyqxFNYRTkOMuT/hklw8azvAI5Q6AgXQqQ5KfOhugGoS/LRiv4TWIaFb6r
 ex4ag6DJDLmW5RSlWfDBKFfTWHEzXw==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=6928c891 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=R2Hq113kbEfVEy8uZm8A:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: rVofZ8-mPLVdcCgekmSbuQT0DEaptl3V
X-Proofpoint-ORIG-GUID: rVofZ8-mPLVdcCgekmSbuQT0DEaptl3V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 2025-11-27 at 19:00 +0100, Ilya Leoshkevich wrote:
> On Thu, 2025-11-27 at 17:43 +0100, Thomas Huth wrote:
> > On 16/10/2025 19.58, Ilya Leoshkevich wrote:
> > > Suppose TOD clock value is 0x1111111111111111 and clock-
> > > comparator
> > > value is 0, in which case clock-comparator interruption should
> > > occur
> > > immediately.
> > >=20
> > > With the current code, tod2time(env->ckc - td->base.low) ends up
> > > being
> > > a very large number, so this interruption never happens.
> > >=20
> > > Fix by firing the timer immediately if env->ckc < td->base.low.
> > >=20
> > > Cc: qemu-stable@nongnu.org
> > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> >=20
> > =C2=A0 Hi Ilya,
> >=20
> > this patch unfortunately broke reverse debugging on the s390x
> > target.
> > Something like this used to work before:
> >=20
> > =C2=A0 qemu-img create -f qcow2 /tmp/disk.qcow2 2G
> > =C2=A0 ./qemu-system-s390x -nographic \
> > =C2=A0=C2=A0=C2=A0 -icount shift=3D6,rr=3Drecord,rrfile=3Dreplay.bin,rr=
snapshot=3Dinit \
> > =C2=A0=C2=A0=C2=A0 -net none -drive file=3D/tmp/disk.qcow2,if=3Dnone
> > =C2=A0 ./qemu-system-s390x -nographic \
> > =C2=A0=C2=A0=C2=A0 -icount shift=3D6,rr=3Dreplay,rrfile=3Dreplay.bin,rr=
snapshot=3Dinit \
> > =C2=A0=C2=A0=C2=A0 -net none -drive file=3D/tmp/disk.qcow2,if=3Dnone
> >=20
> > With this commit and later, the replay hangs somewhere in an
> > endless
> > loop.
> > Do you have any ideas what could go wrong here?
> >=20
> > =C2=A0 Thanks,
> > =C2=A0=C2=A0 Thomas
>=20
> [...]
>=20
> Hi Thomas,
>=20
> Thanks for letting me know, I will look at this ASAP.
>=20
> Best regards,
> Ilya

Intermediate finding:

update_ckc_timer() is called only during replay, but not during normal
runs or record. The call chain during replay is as follows:

main()
  qemu_init()
    qmp_x_exit_preconfig()
      replay_vmstate_init()
        load_snapshot()
          qemu_loadvm_state()
            qemu_loadvm_state_main()
              qemu_loadvm_section_start_full()
                vmstate_load()
                  vmstate_load_state()
                    cpu_post_load()
                      tcg_s390_tod_updated()
                        update_ckc_timer()

The end result is that during record CHECKPOINT_CLOCK_VIRTUAL is not
written to replay.bin. But during replay it's expected here:

        if (replay_mode !=3D REPLAY_MODE_NONE
            && timer_list->clock->type =3D=3D QEMU_CLOCK_VIRTUAL
            && !(ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)
            && !replay_checkpoint(CHECKPOINT_CLOCK_VIRTUAL)) {
            qemu_mutex_unlock(&timer_list->active_timers_lock);
            goto out;
        }

The lack of it prevents the timer callback from running. So the timer
associated with s390x_tod_timer() remains active forever and causes the
rr_cpu_thread_fn() to loop.

IIUC these things really have to be symmetric between record and
replay, so we probably need to add this call to some strategic location
during record.

I will continue tomorrow.

