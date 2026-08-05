Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208DAC55822
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrWQd-0005X3-D3; Wed, 05 Aug 2026 03:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrWQb-0005WG-Lk; Wed, 05 Aug 2026 03:52:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wrWQZ-0005bm-Si; Wed, 05 Aug 2026 03:52:41 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6755lm5V1121570; Wed, 5 Aug 2026 07:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=ioKdZWyckejtrlcHZnvwqyj3Ij+1jW7743/yv+pAAso=; b=VltvAfsiCZgz
 LJUwXaeYdjf8w6tPdNeApDHN8s/Ks3xqvxANwB7KGxIQDNBtmU0CSiAqm26n1rKN
 8ncwsZ9M1Dbii8GBCosoYtFipDBt/ijM/XS8peIpOOUqZ25ttE7nL02TSyViPM66
 IKF8vLMK8M8VAiFW5etQEAS4ASJkUnydHaoNxlAJStMIl9h8MgWkyO+gX6xj1IWf
 yTxL/Cv8BcmyZG5IVMqeAOli5WZAAdZ3u5JUA+Ghyn/w9nLtdpfc/Smub40KpWwn
 82OV8b8Den4wGUsSRhCcTu9PksWBlN1PDWM5B4RDTV0dNVDM4MJrmeIT6gGFevm5
 zB/bueHc4g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqsvrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 07:52:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6757pwYe032540;
 Wed, 5 Aug 2026 07:52:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgddc4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 07:52:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6757qUVM17891936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 07:52:30 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 340E55805A;
 Wed,  5 Aug 2026 07:52:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F6135803F;
 Wed,  5 Aug 2026 07:52:29 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 07:52:29 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 05 Aug 2026 09:52:29 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v13 01/18] target/s390x: Rework s390 cpacf implementations
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <59cb2b9b-06ed-49a9-bf54-0921e25d275a@linux.ibm.com>
References: <20260803161235.228704-1-freude@linux.ibm.com>
 <20260803161235.228704-2-freude@linux.ibm.com>
 <59cb2b9b-06ed-49a9-bf54-0921e25d275a@linux.ibm.com>
Message-ID: <50bc5c3447f43d6df3e4329dae8f176f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t7zqKaD_z_BGbYWwflaOs3exI-xAWtzq
X-Proofpoint-ORIG-GUID: t7zqKaD_z_BGbYWwflaOs3exI-xAWtzq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2MCBTYWx0ZWRfXzj3va73FGeXG
 iAxEPx60g8s4YdiW/YMj8q6ww0VntCfhSBWJZAopBMoNNrIYfosSfCGBumFfri446f0gS4S/X4r
 nYUCCyfhZQn7E0pPuRqcd72bDt3BURw=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a72ebc1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Y9c9uQpRRzBNGCtdfwIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2MCBTYWx0ZWRfX7+yHNvUEN0KF
 MCSDQXdGQ/pyoRIAfv9Bq6s+RM3KK01DZrZeTcEjWQ6IGsR+/oJ2jIJ9a4C6/L1gTWUpYEGW++I
 wtIkCZ6MjXPxM62/RokwDsNYB9MQ/1EPBDDKujjcBNmMP72pjllYGY2Z/vx2d+asjxkwQm/z/7+
 PhBZ3prwjZMo/BiPu0QfBl5QSEnbjcLpsojflJssVlLmixA6b9rMI4sqoBuE5Jr09c8QPY0+Xpv
 3iKPqPl08blD0T92FUq77X9Kjx6hGhEavBI8usnCGMO8pXwfdfDNsLUskccueSVLWssOL4y6mX1
 fKC/QmqTjqrz+gVh/03T9fwvJqC27j7BZNu2tu8/JKqaZM94Pc5hVAG1LFtG+zPzV9NZPzciDjd
 mJdOzZh4DPwj8phbWPAQ+tN9AjA0i/ss1kFAK7/JmkhMG82ukEaclqan9hhTbU4QWJoylEbdRDa
 QKka6Zx/L+koLR+0zew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=freude@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-08-05 00:23, Ilya Leoshkevich wrote:
> On 8/3/26 18:12, Harald Freudenberger wrote:
>> Fix missing parts for MSA 9 kdsa and rework the cpacf handling code
>> so that further extensions can be made in a clean and structured way.
>> 
>> Introduce a new header file to hold defines, structs and function
>> prototypes around s390 cpacf. Use the cpcaf function defines in the
>> existing code.
>> 
>> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/tcg/cpacf.h         | 226 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  90 ++++++++++--
>>   target/s390x/tcg/insn-data.h.inc |   1 +
>>   target/s390x/tcg/translate.c     |   2 +
>>   4 files changed, 306 insertions(+), 13 deletions(-)
>>   create mode 100644 target/s390x/tcg/cpacf.h
>> 
>> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
>> new file mode 100644
>> index 0000000000..49496d39ed
>> --- /dev/null
>> +++ b/target/s390x/tcg/cpacf.h
> 
> [...]
> 
>> +/*
>> + * Function codes for the PCKMO instruction
>> + */
>> +#define CPACF_PCKMO_QUERY                      0x00
>> +#define CPACF_PCKMO_ENC_DES_KEY                0x01
>> +#define CPACF_PCKMO_ENC_TDES_128_KEY           0x02
>> +#define CPACF_PCKMO_ENC_TDES_192_KEY           0x03
>> +#define CPACF_PCKMO_ENC_AES_128_KEY            0x12
>> +#define CPACF_PCKMO_ENC_AES_192_KEY            0x13
>> +#define CPACF_PCKMO_ENC_AES_256_KEY            0x14
>> +#define CPACF_PCKMO_ENC_AES_XTS_128_DOUBLE_KEY 0x14
> 
> 0x14 repeats twice, should it be 0x15?
> 
> [...]

Yes, the double should be a 0x15. See kernel header file
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/include/asm/cpacf.h

