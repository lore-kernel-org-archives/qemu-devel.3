Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302F3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiI1-0008Cn-IT; Mon, 06 Jul 2026 08:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wgiHT-0008Aa-QR; Mon, 06 Jul 2026 08:18:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wgiHR-0004RY-UQ; Mon, 06 Jul 2026 08:18:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666BIIGx318945; Mon, 6 Jul 2026 12:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=uA7GvmH83Vnhjmt1HPiPWRXyLHeFtZVCa1P2v7bW7zE=; b=Uc/jPrHVR/lw
 JJFIA9GXdUlOAxOyyTGLJkh3iUl0oWnOzP7TZpz3iuZcPfsy40xJEPzprX8miUtC
 WbWuttUbyMd7q6TdmZCeAeiTexmqwngzXfFIWOrdqiAkSdJi9x8hVaoUiwx1/gnb
 d8f00sxr5o6+34eEhkF1dXjV2kJV3MVrVeyUj2f9eAbfFhyhBXtRAHk/ksj7AwMQ
 pnlQ8oLN0dJZTLLgYNmVf17pNAlv0/IfN5gG/w+zSKv0uKB+Ltv46+gxm5uXLHBg
 3g14pcgbrNDJr8ywhtUTQ4Ig/SeeYrW3ggQ5oBWzfLRfHFWE7nBNTP6Sf+rfdOZI
 dj2gBUjOcA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqh77u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 12:18:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666C4iiU023125;
 Mon, 6 Jul 2026 12:18:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjwge3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 12:18:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666CHrfm10945070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 12:17:53 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 131775803F;
 Mon,  6 Jul 2026 12:18:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 158B95804E;
 Mon,  6 Jul 2026 12:18:26 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 12:18:25 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 06 Jul 2026 14:18:25 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
 dengler@linux.ibm.com, borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 10/21] target/s390x: Base support for cpacf protected
 keys
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <87v7asjpzc.fsf@redhat.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-11-freude@linux.ibm.com> <87v7asjpzc.fsf@redhat.com>
Message-ID: <26e04f8752e3235d6e8819cad1a5d9df@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyNSBTYWx0ZWRfX/Z0NaF47Vorh
 LebeMpyWfJAC4vT/RmP8QfPuJyh8ORKn/X64qPCsS9P8HRyaJ7yfcltwJj17duvDECs73Vwy1Hx
 n7uk7EOoSKkr9WEvz5y8FV72DRmfYqM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyNSBTYWx0ZWRfXwyY+FwtrqLlV
 m/YW7CIEGeiV7umWN1HJGRSnhHz745iPXTQ7VbPKgPcszwwCNUWhoyTnC1uVs875X9Kqsk4HMyk
 8r250cBJ+N8nc6KxMCGt4rCg/6SH3oLWT0tE93dAOyqd/pZ6561C65Q1jGSkUm6Dw7N6j9jSpv/
 kGXoEPW9kf/DMS1FaBEACJBSwa2DrlnIyrqYHyGkqjAfnDXewM2BJiKIBFnFH8/hWzGMz0DZDZI
 vGiMv6pi2IBUQg21XotewBeg57zMllLh+tjfLhyLTB3D34EOb9MGOaLnG7FCJXenbBIJz2hgVr6
 G5AhucCCbLJzsCkRD2ORyvnevRkv/gREOFoljmlbD5Nfh2Ghig2N+MrkupHG0vuA46A+hENizV9
 MHWn2gmcN6rBVRnXJZxFevpS6bZ+WGPgpJbJwlW2+RMSOHvDa7q+rhl0cWNP/Y6ODXB6b9A5h0N
 SZ3rbqAmFnE25YEmJxw==
X-Proofpoint-GUID: i4SVJqHdWO1Dya5I3N5bKGFKa_z9yGOp
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4b9d15 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=RpqUTlpZVrBo7_kUrrwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: i4SVJqHdWO1Dya5I3N5bKGFKa_z9yGOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060125
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

On 2026-07-06 13:51, Cornelia Huck wrote:
> On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
>> Add base support for cpacf protected key handling.
>> 
>> The qemu version provided here is only a fake intended to make
>> protected key available for developing and testing purpose:
>> * The protected key is 'derived' from the clear key by xoring
>>   the fixed pattern 0xAAAA... onto the key value.
>> * The AES Wrapping Key Verification Pattern is a fixed
>>   value of 32 bytes 0xFACEFACE...
>> 
>> Add preprocessor defines for the xor pattern and wkvp used to
>> construct ('encrypt') a protected key from a clear key value with
>> this implementation. Also add some static functions to 'encrypt'
>> from clear key to protected key and 'decrypt' back to cpacf_aes.c.
>> 
>> The preprocessor defines shall be used later in testcases to
>> construct and decode protected keys.
> 
> Hmm... so does that mean that we only provide the protected key 
> handling
> in the !KVM case for people who want to run via tcg for some 
> development
> purposes? Does the user actually get some kind of notice in that case,
> if for example they run with !KVM due to some configuration hiccup? 
> IOW,
> do users get some clue that they are running with a fake placeholder
> implementation, other than the setup being slow?
> 

Well, there are 2 paths leading to protected use:
1) you have a secure key and want to 'derive' a protected key from that
    to operate faster. This is for example the case now when you have an
    PAES encrypted filesystem.
    In such a case you need a crypto card with the Master Key setting
    fitting to when your secure key was generated.
    -> this is not a practical way for qemu on !KVM as you need a crypto
    card AND the s390 firmware stack.
2) you 'derive' a protected key from a clear key value. On a s390 system
    this is done via the privileged instruction PCKMO. On this qemu with
    !KVM this is the fake I implemented.
    In general it is absolutely not recommended to go this path as the 
source
    of the key is/was/needs to stay in OS memory. So you don't win any
    security by using protected keys this way - in fact you would have
    done better to just use the clear key as it is. Please note also, 
that
    by default this path on a s390 system is disabled - however, for 
testing
    purpose there are ways to use it this way.
    However, this is exactly what this implementation here is for. For 
testing
    purpose you may 'derive' a protected key from clear key or any other 
way
    as the algorithm to derive is clear documented here. And then you can 
play
    around and run tests with protected key implementations.

I see your point: How can a innocent user see that his/her vm is running 
with
this fake installation instead of the real one. The answer is:
If the source of the protected key is a secure key - then there is no 
path
on the faked implementation to get a hand on a protected key.
If the source of the protected key is a clear key - honestly does it 
even
matter which implementation is then running?

Hopefully I could explain the difference.

>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  target/s390x/tcg/cpacf.h     | 25 +++++++++++++++++++++++
>>  target/s390x/tcg/cpacf_aes.c | 39 
>> ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 64 insertions(+)

