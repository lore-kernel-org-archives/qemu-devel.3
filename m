Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B29BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 14:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg320-0007mV-Pc; Mon, 19 Aug 2024 10:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sg31z-0007gi-Ag; Mon, 19 Aug 2024 10:06:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sg31x-0007VI-Jg; Mon, 19 Aug 2024 10:06:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J6T4Fg013820;
 Mon, 19 Aug 2024 14:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=x
 QNc4irgh/BAzXeN0jjzShJxuK6av+L1JG7jf6otzqw=; b=T6z4ujruCvoS5G8KV
 my0LSwXaZ1lK7vELPus1yTp8lofOO2frbv/+gKb+8EFMEn9FIls7BqXfdRqkwzZF
 l2zSHrfifINNf6na5C/Phk+yOI7esAxqdhC7jymvF7IkonaO8AnvhcpfIyhbohOX
 KtWe1aIAxykMgLn3OpGEh1xdgNOukvVH7uLupgwYRsOapUc9aEmpSPb+W+loX60+
 Aca9HavINFZSy7iEPaaexfl7b8SveDMyctexN/BrFseT8yTSycOZDo0UG9liPSvW
 C4A0Qymw3GcpqGPcwoJNTXgAvdz+rQ5K6UYhOtXQLTOmS7ttmQG4+XDwWrnWYYUf
 xslGQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfrmmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 14:06:36 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JE6aG4021426;
 Mon, 19 Aug 2024 14:06:36 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfrmm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 14:06:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JBrGH5013110;
 Mon, 19 Aug 2024 14:06:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366txmst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 14:06:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 47JE6Tbj53805506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Aug 2024 14:06:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0CF22004D;
 Mon, 19 Aug 2024 14:06:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1240320040;
 Mon, 19 Aug 2024 14:06:27 +0000 (GMT)
Received: from [9.195.36.7] (unknown [9.195.36.7])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Aug 2024 14:06:26 +0000 (GMT)
Message-ID: <142e8cde-ba89-46cd-80bd-525de88fd6cf@linux.ibm.com>
Date: Mon, 19 Aug 2024 19:36:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/ppc: Implement -dtb support for PowerNV
To: Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240813134536.1204513-1-adityag@linux.ibm.com>
 <D3GB5QVADVQ1.XZM3FFV52LIW@gmail.com>
 <6c0cdf26-9795-4998-9d80-1d0095700a59@kaod.org>
 <D3GZ6RL9K9OQ.1A1YQ9YSZPH3E@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D3GZ6RL9K9OQ.1A1YQ9YSZPH3E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ygja7rZKIoe21X9BRi3ZfhAxG2E7J91E
X-Proofpoint-ORIG-GUID: vvYDkIwUjOiY9OkKvGdng21uL9WVG8UW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_12,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408190094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Nick,

On 16/08/24 07:50, Nicholas Piggin wrote:
> <...snip...>
>>> One little nit is MachineState.fdt vs PnvMachineState.fdt
>>> which is now confusing. I would call the new PnvMachineState member
>>> something like fdt_from_dtb, or fdt_override?
>> I agree. this is confusing. machine->fdt could be used instead ?
> Yeah that could be another option. Test pnv.dtb or add a new bool
> to pnv if you need to check whether the fdt has been provided by
> cmdline.

Sure, I will use machine->fdt. Testing pnv.dtb should be good enough to 
check if -dtb was passed I think.


Regarding the conversation about CAS, I don't have idea on it, other 
than the minimum basics. But thanks to you and Cedric, got to know 
somethings.


Thanks,

Aditya Gupta

>>> The other question... Some machines rebuild fdt at init, others at
>>> reset time. As far as I understood, spapr has to rebuild on reset
>>> because C-A-S call can update the fdt so you have to undo that on
>>> reset.
>> C-A-S is a guest OS hcall. reset is called before the guest OS
>> is started.
> Right, but when you reboot it needs to be reverted to initial
> (pre-CAS) fdt.
>
>>> Did powernv just copy that without really needing it, I wonder?
>>> Maybe that rearranged to just do it at init time (e.g., see
>>> hw/riscv/virt.c which is simpler).
>> The machine is aware of user created devices (on the command line)
>> only at reset time.
> Ah, I should have followed a bit closer. riscv, arm use a
> machine_done notifier for that (and x86, loongarch for ACPI / BIOS
> tables). So that avoids fdt rebuild after the first reset I think.
>
> Anyway I don't really mind then, following other archs would be okay,
> but keeping similar with spapr and avoiding code change is also good.
> Maybe add a small comment to we use reset rather than machine_done
> notifier of other archs to be similar to spapr.
>
> Thanks,
> Nick

