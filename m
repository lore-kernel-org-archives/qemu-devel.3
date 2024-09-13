Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8800DEEEC08
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 04:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soy7G-0000NX-Ut; Fri, 13 Sep 2024 00:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soy7F-0000Ld-EV; Fri, 13 Sep 2024 00:41:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1soy7D-0005iM-NT; Fri, 13 Sep 2024 00:41:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIDKKh032547;
 Fri, 13 Sep 2024 04:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 DtNAOovy8oDSzilCo3wg1dZdFOrnDpXA+0TLAmlLsQo=; b=dTGZ+apZTpR33OVX
 9t1k/lWWRkHS0C8t85Z4jS77wAklqE/hkMIvTyFa6Y1QUCC/h1bdfASWcGPbDac2
 byxGDoBNtRgQtKUPMe4yGkHxtTvYa7jZDupt/3+OGOgtW67mZJ44AJwp44HwjTEZ
 lUDuVPe4qCWsalerhrNLwhcFrKgCirlaJJaOH0Tm27u2VbnPTjbVI2L7UbrSfDrs
 bS/1qK9uCgEzXBZv0XCAdAzBKIwYpyiwYxJMWi86ae3K6wyResmQ6hqergYvUHif
 Olra1ksd1N6BwGuf+mz0MvrYHE62h89atpf5iEY5juDkXjy1XBRhahjN3v8aL7MG
 QK7lgg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx7mrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:40:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48D4ekvY014644;
 Fri, 13 Sep 2024 04:40:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx7mrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:40:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D2Cr2s010770;
 Fri, 13 Sep 2024 04:40:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41kmb6yhyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 04:40:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48D4eiv046793272
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 04:40:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20C2358045;
 Fri, 13 Sep 2024 04:40:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D13D858052;
 Fri, 13 Sep 2024 04:40:40 +0000 (GMT)
Received: from [9.124.214.206] (unknown [9.124.214.206])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 04:40:40 +0000 (GMT)
Message-ID: <feb4dd6d-4cf9-4821-8e78-19f643d9da90@linux.ibm.com>
Date: Fri, 13 Sep 2024 10:10:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix lxv/stxv MSR facility check
To: Fabiano Rosas <farosas@suse.de>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Lucas Mateus Castro <lucas.castro@eldorado.org.br>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Joel Stanley <joel@jms.id.au>
References: <20240213083933.718881-1-npiggin@gmail.com>
 <87cylcl94u.fsf@suse.de>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <87cylcl94u.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wIyYKLkcA7Mg95me0HwijsUU8iiLBKm3
X-Proofpoint-ORIG-GUID: o0HMmYvpZcyZNdnpn7iVdvyEWM0xAT9n
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_01,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=814
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130030
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Fabiano,

On 9/10/24 04:36, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
>> The move to decodetree flipped the inequality test for the VEC / VSX
>> MSR facility check.
>>
>> This caused application crashes under Linux, where these facility
>> unavailable interrupts are used for lazy-switching of VEC/VSX register
>> sets. Getting the incorrect interrupt would result in wrong registers
>> being loaded, potentially overwriting live values and/or exposing
>> stale ones.
>>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Joel Stanley <joel@jms.id.au>
>> Fixes: 70426b5bb738 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1769
>> Tested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   target/ppc/translate/vsx-impl.c.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
>> index 6db87ab336..0266f09119 100644
>> --- a/target/ppc/translate/vsx-impl.c.inc
>> +++ b/target/ppc/translate/vsx-impl.c.inc
>> @@ -2268,7 +2268,7 @@ static bool do_lstxv(DisasContext *ctx, int ra, TCGv displ,
>>   
>>   static bool do_lstxv_D(DisasContext *ctx, arg_D *a, bool store, bool paired)
>>   {
>> -    if (paired || a->rt >= 32) {
>> +    if (paired || a->rt < 32) {
>>           REQUIRE_VSX(ctx);
>>       } else {
>>           REQUIRE_VECTOR(ctx);
> 
> What about the X-form down below?
> 
> static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool store, bool paired)
> {
>      if (paired || a->rt >= 32) {
>          REQUIRE_VSX(ctx);
>      } else {
>          REQUIRE_VECTOR(ctx);
>      }
> 
>      return do_lstxv(ctx, a->ra, cpu_gpr[a->rb], a->rt, store, paired);
> }

Thanks for catching this. I have posted the fix here:
https://lore.kernel.org/qemu-devel/20240913043827.914457-1-harshpb@linux.ibm.com/T/#u

regards,
Harsh


