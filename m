Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A05C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNqr-0001pD-UC; Wed, 08 Jul 2026 04:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1whNqn-0001oj-LQ; Wed, 08 Jul 2026 04:41:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1whNqm-0000Wb-9a; Wed, 08 Jul 2026 04:41:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6688IY3v2880550; Wed, 8 Jul 2026 08:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5QkuOc
 H1QlC/4+kiDm0MR+zkwlKHYlXDw+WFAOlOyoM=; b=AHHRz1Du+xMLqrFQosW0V1
 TJb8FpAHjtbWx6JSf028VTQ1msGqUxhTcneBwNKM8tFeFYoY1PnooJWx2Qh06r+F
 f4XsPJtyRqD6vx3NuLd6c+caZ/QfcoZR7KvFccxaJrcagf7m7W3dgmPdDwzPdhlY
 QF9Jj913aYffgpO+h9TP7R4LlQFKVmXpue62E4gqNkAhPONGuW2FOdvxQMfA5XKx
 WQUlY1W8WNmhgr7gJAqAV09hbzkM8OMzI04AP0F1ToITZ599IkKhyoddHxxEWvby
 pvDoxakflRbyTJHC/JxpU/P4mSyVHiQsWbg1KOLb/imP8qbp9bKI/dMyVymO3dgQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknk28v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 08:41:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6688YZn5021126;
 Wed, 8 Jul 2026 08:41:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq72pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 08:41:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6688ff7356230326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 08:41:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2FB920040;
 Wed,  8 Jul 2026 08:41:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF63D2004D;
 Wed,  8 Jul 2026 08:41:38 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  8 Jul 2026 08:41:38 +0000 (GMT)
Date: Wed, 8 Jul 2026 14:11:58 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: amachhiw@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Subject: Re: [RFC PATCH 11/28] target/ppc: Move fixed-point byte-reversal
 store insns to decodetree
Message-ID: <20260708141027.e38a92dd-c2-amachhiw@linux.ibm.com>
Mail-Followup-To: Shivang Upadhyay <shivangu@linux.ibm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, 
 harshpb@linux.ibm.com, richard.henderson@linaro.org, peter.maydell@linaro.org, 
 stefanha@redhat.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-12-rathc@linux.ibm.com>
 <abd149464ebb8c0dcff389b09ff7d1158c237feb.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abd149464ebb8c0dcff389b09ff7d1158c237feb.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4e0d49 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=zvxekdvM5XC3g2N4LjkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: gu0H0tYMgzNmIdyK8_S97rv1qKRbA8N_
X-Proofpoint-ORIG-GUID: 4oSieGaFrlAIIJjTU-VBPRClvEZdmb7u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3OSBTYWx0ZWRfX2f5bOxy47zMQ
 XuzAw8MDBt1YuqNNNue4rUSQgOHKMahrFRqrF2za7z2RorCT/Hk1Q7DBl0YEhRvYynBXb0cCHnN
 xsL/2Qufrg4RSrr59Abd3RGOUkQh++M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3OSBTYWx0ZWRfX+4zHJRc8RONV
 XtYTbyYzk8qoJPxF/7WFrnVB15vxLzMGjLb1mWrEiVoXa50lX4U8GNkBOhPtET7fMA2G1WICsTp
 2POGXXFK1887GDzHR09qKWjsoLSEqK53Qf/DBhZSnhyPQF+g28umpKx4zvI1lYwVcex+J28inBB
 5Vw8HWHn0dhAho0+1jjHc2mTshhxTfX7hnMvbKo+7HkXhkFNRu8wuGcwDHQzaGnO5BALwoH0c/3
 2JkhZk8ZL/sNcDttwralGtU0n5V4ypPYiSC7z/lddkUTzD0fzRpvKoKRsiOyJr5Nwx+WfB7JNjb
 BmjDAwWSzTfwG1rRMIJ4a02luDOilPkO4NBTp6yCQEc3oYCq0shfUWtp1+QyGp/noPzWjcv8Edq
 mNFX+AuvkSNZYNL1kT1sK6qdWbmkv/i/qV9m+0Vs3g+6t3gAcKXjVvK7GzEoByVOkxFn7bjy1Ju
 V/0XlbevFF1hRB5lHiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080079
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Shivang,

Thanks for taking a look. Please find my response inline.

On 2026/06/12 08:46 PM, Shivang Upadhyay wrote:
> On Wed, 2026-05-20 at 21:37 +0530, Chinmay Rath wrote:
> > --- a/target/ppc/insn32.decode
> > +++ b/target/ppc/insn32.decode
> > @@ -372,6 +372,14 @@ STVDX           011111 ..... ..... .....
> > 0010010001 -   @X
> >  STSKU           111110 ..... ..... ............. 0 11   @DD
> >  STCXU           111110 ..... ..... ............. 1 11   @DD
> >  
> > +STDBRX		011111 ..... ..... ..... 1010010100 -	@X
> > +STDCIX		011111 ..... ..... ..... 1111110101 -	@X
> > +STWCIX		011111 ..... ..... ..... 1110010101 -	@X
> > +STHCIX		011111 ..... ..... ..... 1110110101 -	@X
> > +STBCIX		011111 ..... ..... ..... 1111010101 -	@X
> > +STHBRX		011111 ..... ..... ..... 1110010110 -	@X
> > +STWBRX		011111 ..... ..... ..... 1010010110 -	@X
> > +
> >  ### Fixed-Point Compare Instructions
> >  
> 
> Hi Amit, 
>  It would be good to align the instruction format with the other
> instructions currently it looks little odd.

Looks like the patch got re-formatted while applying somehow. Will check
with Chinmay on this and get this fixed.

~Amit

> 
> Otherwise LGTM.
> ~Shivang.
> 

