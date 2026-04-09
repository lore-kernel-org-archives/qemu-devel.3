Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA5EF31E5E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAs5a-0000pg-27; Thu, 09 Apr 2026 12:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wAs5Y-0000ob-4M; Thu, 09 Apr 2026 12:18:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wAs5W-00040b-II; Thu, 09 Apr 2026 12:18:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6399Avcs2210139; Thu, 9 Apr 2026 16:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RmVOPf
 xVfNgzv+/Rljv07lzY1NMjyMkMPAb2fL7gG0o=; b=dYefThA1B8yKXr3UGdthGi
 vlAUbiGyAnQ98OJsPgDZ1X58FIoyCAilM3XdUe/I4/qOxLaKourYGU8GTB7UbPqu
 e4i2I9HkxineVxUs6WCotHSwTEW1QEIjivGtU3EPtkx4QL2sQXYanak1PDKlxAxG
 GcpasCUo2lkV4mnPid9XvsK+v4cyL4vJm6f7WtKGByfHuFpHmB1Cty1ggU0hjHPN
 6hGcDfNOoc8t+t72ETMpUGCwdQNXZsa23pYM9UstmakBNf8FVKSaaZu9NyonG91Z
 hmK7+6f6jT7sX121njX3fg72oAe2TN6Z3wDZE8oIwASCQvxp7ZgwfdY5LZWFuwxw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hn1db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 16:18:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639CAfEt018952;
 Thu, 9 Apr 2026 16:18:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9mc3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 16:18:35 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 639GIYrg8454880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 16:18:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 962A258054;
 Thu,  9 Apr 2026 16:18:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78CD65803F;
 Thu,  9 Apr 2026 16:18:31 +0000 (GMT)
Received: from [9.39.24.136] (unknown [9.39.24.136])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Apr 2026 16:18:31 +0000 (GMT)
Message-ID: <d522e029-21ce-45eb-88a7-b9236e94b37d@linux.ibm.com>
Date: Thu, 9 Apr 2026 21:48:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
Content-Language: en-GB
To: Misbah Anjum N <misanjum@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>, 
 Pbonzini <pbonzini@redhat.com>, Qemu Devel <qemu-devel@nongnu.org>,
 Qemu Ppc <qemu-ppc@nongnu.org>
Cc: npiggin@gmail.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
 Gautam Menghani <gautam@linux.ibm.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
 <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
 <7bbeb3cb105934e95bf1a5356cfc4613@linux.ibm.com>
 <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
 <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
 <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
 <526d7172f3933baf913bf4b105a6fa9a@linux.ibm.com>
 <9794AFF9-DFD9-48D0-B4EA-7745ABDED6F7@redhat.com>
 <DCB3A7E9-412C-402D-A4C9-EA558CD1FE29@redhat.com>
 <ab72cb8395bcc2b1f489c5611bb7c00d@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <ab72cb8395bcc2b1f489c5611bb7c00d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE0OSBTYWx0ZWRfX03OAAU/HBDvH
 3NdGLCwdG07HiZLEpWhR9Ne0JdZvIpTf+LmkXH3rRROShDyFVtDklWNBn45JsA+Tsj+zyccHQAk
 BFsOd8MdVJVgmINMwY68SUSaIJDb5oDzlwtykjyWkU1//LIrIYb+XONf8ZHW58E6kklfz6pwNTK
 appIqCx8+Im82OzUtiAS8REzYQQZLYrtl9LaiEbQTv26UUja267zKuL+upJTlXPwuFfoO0Fib0k
 bRVHtXduzm6xiM9IAbTzJv9j7laVuPZ5I5w0aPOx6iWqZwEGRxREe5gq8kMJNLAyZsRAl//7BzZ
 6O81sVy21tdL6e7dHW4h9VxiNZtoM4JFt54ssY+cjtkO0FDI2bXc4tFFSHxPtlXub28Ufmt/dti
 684NXSRvb2whaqbyTqiErPjqqHFM35+32GZ3tFYoTV4JDfNhJXgl41O0kp3w3LpT6PcRipb9bOS
 hKiNSJ0Cwq9X16lIt6A==
X-Proofpoint-GUID: GXw5xhA0KSxavhYvJn3BnBcOXw68KR1F
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d7d15d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=HZCDa-MAzmLoNKJ9Xh4A:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: Ksdvg09qZfAJdw6GGbDBNRGpbPlSiMvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

Hi Misbah,

On 06/04/26 2:24 pm, Misbah Anjum N wrote:
> Hi Ani,
> I've completed the testing you suggested. Unfortunately, the SMP hang 
> still persists with these changes.
> 
> Changes made:
> As requested, I reverted everything in stubs/kvm.c and the related 
> changes in stubs/meson.build, include/system/kvm.h, and target/i386/kvm/ 
> kvm.c. I also commented out the calls to kvm_arch_supports_vmfd_change() 
> and kvm_arch_on_vmfd_change() in kvm_reset_vmfd().
> 
> Test result:
> The issue persists - guests still hang indefinitely during boot when SMP 
> is configured.

I have posted a patch here which should fix this smp hang issue:

https://lore.kernel.org/qemu-devel/20260409161042.55281-1-harshpb@linux.ibm.com/

Could you please help validate for different scenarios and share feedback?

Thanks
Harsh

