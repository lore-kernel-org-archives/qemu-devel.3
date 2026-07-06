Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F631C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdew-0004dO-0f; Mon, 06 Jul 2026 03:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wgde7-0004Mh-NY; Mon, 06 Jul 2026 03:21:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wgde6-0007HL-7S; Mon, 06 Jul 2026 03:21:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIQCm2250692; Mon, 6 Jul 2026 07:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=opUwRaj7aOIzKyyI6t6AvNTZ0+NEJHYINFDT082qZLY=; b=sSi1mX4PG9uC
 Opkh2Kj0Tx4+p1IA0RXKiiSp/Ii9oj5g1Ut8GkwLOgKJnPoFwWZ0F+/4ULDMm6gC
 J4P56XMh6tRjM5f6jEkwv2GDBmlGyT4qh9z/fhBsuI/4GpaL4VqWRS0KI34rNIXi
 0Ze/6/yOrXueL73P6M84yAXDZjjI5OVKCDFbD57IxRm84VtSVou0T3qRgylNkHZb
 +az6SXcvv7VmBPqsMmJO8ech35K6HTlF/WakZ3BK/ir/ZRHC+PCoakEry+M4l6Yn
 kkvIr4NGwawWF2373FNItpq99gpDzRqfQaggCDgjDSg0+6CDfUI28bBMmM1sfVXJ
 8UgSG8h2Ug==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn8awe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 07:21:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6667K0F3026810;
 Mon, 6 Jul 2026 07:21:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4e4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 07:21:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6667LV4j64094608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 07:21:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 516C658056;
 Mon,  6 Jul 2026 07:21:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5C1E58052;
 Mon,  6 Jul 2026 07:21:30 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 07:21:30 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 06 Jul 2026 09:21:30 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
 dengler@linux.ibm.com, borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v9 03/21] target/s390x: Move cpacf sha512 code into a new
 file
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <877bnckuuk.fsf@redhat.com>
References: <20260701164650.95760-1-freude@linux.ibm.com>
 <20260701164650.95760-4-freude@linux.ibm.com> <877bnckuuk.fsf@redhat.com>
Message-ID: <3ea0066d4b1f2e1e4a604286e49ef12b@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b577d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=0eez0NfR2cIk6WOmlF4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jn5-VCa8DSmlqjxVeLl1sO_-k4tGEP2c
X-Proofpoint-ORIG-GUID: jn5-VCa8DSmlqjxVeLl1sO_-k4tGEP2c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3MSBTYWx0ZWRfX8/eHzDuYoLyy
 hhvw6ZI5iZZ8oEt/mi/ctLDGuecZpXN08PlZROJG9fmkkx6y+Hl+J1oLKebQF5/hJFwiJgQXqd0
 AjSGC3V0EzAf8n9xaaMV630HMMq6v8I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3MSBTYWx0ZWRfX9ik1Fus7YcA7
 7lk5tGBr3WnK27T0OM2aBLnDahGUnnKg3/AIlDbKB/ka63mvtopoZggtpUnqzlSu8RsAqT7RMfZ
 VqR9m9GjSceDw1QSSDzVvrIZYIGdyFBb561wrPAGh3mR0GKsoH/5cATr1Rzs5PJSup0WpB2GJZ+
 iB/bjTmVKTIxNVkKE/DxLv33t34E+ukeVxj5jAEoRg6Htuhz1s+Tb+Qgp1c80wTCAlwt0WnYrlf
 /ndVZTpvcG9aLaLDfcDF8rKLbcjJ4XRBMNNbl33gc/B09yJ8iyysGcN32pQvY57iWdqfWGR4wWh
 ZQuJ7but2scbar2VqwDQ7Eiq77BANnVSberzhwbXf6HI2cJ32MU4Pi3R9cHrpA5tMV1VHGnIYeD
 OGdVsKlX5Hl3tS1JGTQd+ZP8URFii+uA1yn36KabhKKYVCHbcTyFzNuspF2ZrvjiePpaocJ0m5D
 0XOctMfNrkMl40TrxCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-07-03 16:31, Cornelia Huck wrote:
> On Wed, Jul 01 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
>> Move the cpacf sha512 implementation into a new file
>> cpacf_sha512.c. Add this new file to the build and use the cpacf.h
>> header file storing function the prototypes.
>> 
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  target/s390x/tcg/cpacf.h         |   5 +
>>  target/s390x/tcg/crypto_helper.c | 222 
>> -------------------------------
>>  target/s390x/tcg/meson.build     |   1 +
>>  3 files changed, 6 insertions(+), 222 deletions(-)
> 
> Forgot to commit the new cpacf_sha512.c file?

Yes - the last rework ...
Shall I send out v10 with only this missing file fixed ?

