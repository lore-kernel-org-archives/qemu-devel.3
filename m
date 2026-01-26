Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47979D13C17
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 14:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkNM0-0007NG-DG; Mon, 26 Jan 2026 09:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vkNLx-0007Mc-3F; Mon, 26 Jan 2026 09:14:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1vkNLv-0007gE-FR; Mon, 26 Jan 2026 09:14:04 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60PJDxuG008292;
 Mon, 26 Jan 2026 14:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=jzh05cT8XYnzRjCIup1Y0ljEhkKl8Y3SsNCCkNdKCLc=; b=BGG0B7Rc9W0E
 7AN2AFwmCusz06ADP1Hss9nki8ye33l6r1wWr80OPq0zG9jkA7bQ+z2jopeZx+9+
 80j97I1kzDmSyBbT9D1MAgAGnYQh5pAoxO77ymrc5DNL5qCgyeVUECHk/epT1K8i
 wawz8vK6XXHqDzsHAcVZqlKMHSLpJmos3zHIViYl6ZEC7bwfy5bhPYfsrcmtUmKO
 BmuvfIuGjTT2b9ckJnYMNrANqd2uohdgDAOB/17/oiP8nwZWzojSmUF9ww9PWfrN
 AV/+9AEwfnnDXMO++ck0pidNX6YQ1TcnrZypuwfhPgQr7W+f5oMVhbjA8y2WdeEg
 p2UwwDkUWw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr5y0x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 14:14:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60QAlgZK031044;
 Mon, 26 Jan 2026 14:13:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dscy6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jan 2026 14:13:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60QEDvZR12386838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jan 2026 14:13:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A1475804E;
 Mon, 26 Jan 2026 14:13:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13B735803F;
 Mon, 26 Jan 2026 14:13:57 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jan 2026 14:13:56 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 26 Jan 2026 15:13:56 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: pbonzini@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 borntraeger@linux.ibm.com
Subject: Re: [PATCH v3 01/14] target/s390x: Rework s390 cpacf implementations
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <589a6d36-fe0e-4db9-b56d-3607263468e1@linux.ibm.com>
References: <20260123114308.19401-1-freude@linux.ibm.com>
 <20260123114308.19401-2-freude@linux.ibm.com>
 <589a6d36-fe0e-4db9-b56d-3607263468e1@linux.ibm.com>
Message-ID: <51c34d2b21962b47213a34aa38af15ad@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExNyBTYWx0ZWRfXzeCxnudgMkk8
 ZizA5QDnGaoRxpzGW6OFvFTTp6KYVzAgFvoRIB28w2nxgAa71VWIu2h5N/YGR1N//abh2CbFVVT
 gj36aVroIywOHDEQK28JK6vOcgG19dW/urTq1OM1jYKi9G3T3heVsrjVqD1Jt/PiRp9kKT0hKQk
 iyn4uwOwpYIMMDtgFcbZgoINaIjZ4mcPeMJpVG2O0z6ZTWpAoFOtlxx9L+yXwbTwZNMeyAU5wOZ
 H8ya5VQrLtBVK6RO3ZOZCK4Xoaj4shhd07Og+3aoVCpjfvp11WOnzMQmo+Yi59qNRjhZetJ7h7F
 SAaCXRoZDGqlc4z5uBYDjXnXELM92EBt3HDpISyhcbstQssc5PYEx7h5/SACRZU5592Vh3tGDgx
 P9AeoN+lZS+YBvTImgFxD900+JeyKHn0m9kd/2Kd7aduG0EG0+gsd2NRB3cXdHddWoLLWFypfig
 uTV0R5KAatuP53r16/g==
X-Proofpoint-GUID: C392hGkGwWC8LPjc9lhGJWlRFDOjDvWU
X-Proofpoint-ORIG-GUID: C392hGkGwWC8LPjc9lhGJWlRFDOjDvWU
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=697776a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=rIgMaQA2N66ND9FlsBEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-01-26 13:53, Janosch Frank wrote:
> On 1/23/26 12:42, Harald Freudenberger wrote:
>> Fix missing parts for MSA 9 kdsa and rework the cpacf
>> handling code so that further extensions can be made in
>> a clean and structured way.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> [...]
>> diff --git a/target/s390x/tcg/insn-data.h.inc 
>> b/target/s390x/tcg/insn-data.h.inc
>> index ec730ee091..b6095711f2 100644
>> --- a/target/s390x/tcg/insn-data.h.inc
>> +++ b/target/s390x/tcg/insn-data.h.inc
>> @@ -1012,6 +1012,7 @@
>>       D(0xb92e, KM,      RRE,   MSA,  0, 0, 0, 0, msa, 0, 
>> S390_FEAT_TYPE_KM)
>>       D(0xb92f, KMC,     RRE,   MSA,  0, 0, 0, 0, msa, 0, 
>> S390_FEAT_TYPE_KMC)
>>       D(0xb929, KMA,     RRF_b, MSA8, 0, 0, 0, 0, msa, 0, 
>> S390_FEAT_TYPE_KMA)
>> +    D(0xb93a, KDSA,    RRE,   MSA9, 0, 0, 0, 0, msa, 0, 
>> S390_FEAT_TYPE_KDSA)
>>       E(0xb93c, PPNO,    RRE,   MSA5, 0, 0, 0, 0, msa, 0, 
>> S390_FEAT_TYPE_PPNO, IF_IO)
> 
> @Christian:
> Is it time to do the rename to PRNO?
> According to the architecture we deprecated PPNO in favor of PRNO with
> introduction of MSA7.
> 
>>       D(0xb93e, KIMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, 
>> S390_FEAT_TYPE_KIMD)
>>       D(0xb93f, KLMD,    RRE,   MSA,  0, 0, 0, 0, msa, 0, 
>> S390_FEAT_TYPE_KLMD)
>> diff --git a/target/s390x/tcg/translate.c 
>> b/target/s390x/tcg/translate.c
>> index 4d2b8c5e2b..a5fdc05d37 100644
>> --- a/target/s390x/tcg/translate.c
>> +++ b/target/s390x/tcg/translate.c
>> @@ -2565,6 +2565,12 @@ static DisasJumpType op_msa(DisasContext *s, 
>> DisasOps *o)
>>       case S390_FEAT_TYPE_PCKMO:
>>       case S390_FEAT_TYPE_PCC:
>>           break;
>> +    case S390_FEAT_TYPE_KDSA:
>> +        if (r1) {
>> +            gen_program_exception(s, PGM_SPECIFICATION);
> 
> Are you sure that's a spec?
> 
> r1 and the 8 free bits in the instruction should be set to zero but
> the architecture doesn't say you'll get a spec if they are not 0.
> 
> The architecture reserves the right to use r1 and the free bits for
> new function codes. If you don't set them to 0 you might invoke new
> functionality that you don't know about.
> 

Yep, you are right. This check is not needed at all.
The code should look like:

        ...
        case S390_FEAT_TYPE_PCKMO:
        case S390_FEAT_TYPE_PCC:
        case S390_FEAT_TYPE_KDSA:
            break;
        ...

>> +            return DISAS_NORETURN;
>> +        }
>> +        break;
>>       default:
>>           g_assert_not_reached();
>>       };
>> @@ -6018,6 +6024,7 @@ enum DisasInsnEnum {
>>   #define FAC_MSA4        S390_FEAT_MSA_EXT_4 /* msa-extension-4 
>> facility */
>>   #define FAC_MSA5        S390_FEAT_MSA_EXT_5 /* msa-extension-5 
>> facility */
>>   #define FAC_MSA8        S390_FEAT_MSA_EXT_8 /* msa-extension-8 
>> facility */
>> +#define FAC_MSA9        S390_FEAT_MSA_EXT_9 /* msa-extension-9 
>> facility */
>>   #define FAC_ECT         S390_FEAT_EXTRACT_CPU_TIME
>>   #define FAC_PCI         S390_FEAT_ZPCI /* z/PCI facility */
>>   #define FAC_AIS         S390_FEAT_ADAPTER_INT_SUPPRESSION

