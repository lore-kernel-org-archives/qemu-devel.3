Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C4CCDE001
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPQk-00062F-B9; Wed, 24 Jun 2026 11:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcPQa-000614-Hb; Wed, 24 Jun 2026 11:22:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcPQY-0004Ld-9P; Wed, 24 Jun 2026 11:22:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEmOvO1229091; Wed, 24 Jun 2026 15:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=goJ4v1
 nhY/z3nlmgG0teKC+QhVS6raLvFZ3QsdvBVzg=; b=iBjNAQOWu1J/4MvE/wJ8TC
 fyfGQC2FM7od5uyikZ0BlLMMvEnm+20aiIrnLzrCNnJlXXxRfDXxEfsVdOfpnl7m
 425Uv74wjDIHCw7kI7Or2gpCabh46vHCJKXhuNXfNA60FMZfHzanmWbHwVgCaDPE
 6tAl4jhQtBeW+mcj9unM2SGPGhxUpJk5QGfX+Ey7JbjQCHj4QUKSo7F3i0SJlTHR
 tWVfjVGV3VGFAw3isae4ENlWunOxhTtnZIW0HS/+qc3CZXaqJewBKC3assj561Tn
 FP5WCssc4bTjAC1WScKTSjB9jVAW2YKhX/qFwr7+/3ONcBILx/R2vf9JQNxYB5Ww
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gms9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 15:21:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OFJiiX029008;
 Wed, 24 Jun 2026 15:21:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwhdey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 15:21:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OFLoWF28377446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 15:21:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98C2620043;
 Wed, 24 Jun 2026 15:21:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C168520040;
 Wed, 24 Jun 2026 15:21:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.19.28]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Jun 2026 15:21:39 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:51:35 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 1/8] tests/functional: Add remote interrupts test for
 PowerNV
Message-ID: <ajvr5gPPLsu7GcA5@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-2-adityag@linux.ibm.com>
 <4de3eafc3c47799d0b503076b0d71be7cf261b61.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4de3eafc3c47799d0b503076b0d71be7cf261b61.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iKYhyKYc85gGO_m8A2cbWXoE9orJb-ia
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEyOCBTYWx0ZWRfX0EP5lrMlLL3M
 T1+/aeaAgDUsMA/TRM5y+3BLE0mXSKcKupSbGsMG+BDkQ6ku9wiZPULNfD/3xbm6h8a7qagD2lW
 3co31WNhhHNVDJN+xHJYUMSReSe/5MU=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3bf613 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8OfXivTFFpb-axvt66UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEyOCBTYWx0ZWRfX9W2slgDuvEk0
 FwR8Q1zsLbEUDkly5nh+/xFZKc2eT3WHDRxmBlMJMj3Y9FDaf+g0QoDZMeU96A9PT9FX94t9IuA
 EY8ra5Lp16jA8MDaJDwB2730yI3Qwi8h6MKH6+5dDjOk+ZgE2RP48PqkuV5hLnbbzjEht9fukAG
 mRyEu3NkuoMlRXj5YJvUD41ks8kp2W6bcKRIW4RkndAzZY+2d7ff7bXpWAvsoLNtwEWzwIWtCey
 JXaYfShj9bp9SC1H3SPa5sGaNaO55Jxnd8f9vdCPFiEc3/KkySPl6exjqvLdwev2jQEe7Ip8R9X
 6DTBVZuBlv/1OQzU6TkPXKbqa12jIQqCJUBbOmbzR8GM0owXlOVkDAS/WevjrZNIbmLwkSoDRE/
 0vpQMcxObe2Y9opczJ7PHUs9t0jM85ReRlRxRBMHHVz1ihco4bfY6g9oUk2XKK2ArywfUoGnuuQ
 BKf4vjjN/j9mjc4MtHA==
X-Proofpoint-ORIG-GUID: EcV8BSPjPxMycR1mjL20WeJsoQWgdFl1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240128
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/06/23 09:17PM, Shivang Upadhyay wrote:
> On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
> > +        # Check that interrupt counts increased
> > +        success_msg = "Interrupts increased"
> > +        self.helper_exec_shell_command(f"export
> > PASS='{success_msg}'")
> This is a great idea. Maybe in future we can pull this to a saperate
> function? something like the following.
> 
>   self.is_booted = True
>   shell_check_pass_fail_command("asdf")

Makes sense. Will have a helper in v2.

Thanks,
- Aditya G

> 
> ~Shivang.

