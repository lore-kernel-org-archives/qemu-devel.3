Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E13C98317
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jq6-0001we-MI; Thu, 24 Sep 2026 09:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9jq1-0001vr-6G
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:50:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9jpz-0007So-FQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:50:12 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC63qg314256; Thu, 24 Sep 2026 13:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=C9e9xB
 W4rPXTY35SAjocFmnH+NgKjtuDNaj9/6fqRpY=; b=XrHnhN/msD+3rE7vGzOLEG
 h+MceafWPqUhUzqVXiw1iIp5lCkOcJe80UlgnMqNjAi8rviCbk2l+3UjXtKEWX0z
 740vvMziTnscoSZjtgGp5lVvMyYywmeCIil1CfDRFp4Klix9Tc6M9pUn46iHc9Do
 2F+R+SRxcBPUAl4eH02Fbz0RxoTd04Upsrqr1fvXU9xN4e1Tv38r7Ot0VXSDhJ0k
 Uibv4lV6Ahr/q/Q6gERwxWAE8cMQmat+mjQvqcXNlZoJaIxzFtw+JJ9W7hMXW6aE
 O00QoqS0JfMr6UnE0yMt+MoXw3RSjGQEZjkCeO77t/dnLXeYpEhrnNI15+zAxfSg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske21ev1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:50:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OCHYHc2004077; Thu, 24 Sep 2026 13:50:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8wyxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:50:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ODo7pQ58065330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 13:50:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0D3258052;
 Thu, 24 Sep 2026 13:50:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4559458050;
 Thu, 24 Sep 2026 13:50:07 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 13:50:07 +0000 (GMT)
Message-ID: <e0417583-9bf2-42bb-aed7-4abe92d7f488@linux.ibm.com>
Date: Thu, 24 Sep 2026 09:50:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/tpm: crb: Do not clear internal buffers when
 backend is busy
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-7-stefanb@linux.ibm.com>
 <179023566486.1794827.4547558565411422420.b4-review@b4>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <179023566486.1794827.4547558565411422420.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LPl4aHAN38xSPkF99wDRmgrUoMh26PQ2
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab52a92 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=2a8yVmhj0dxH-vjGAIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX/BcyOTvKU9H+
 K6orebW5wMit2wzgQ7+p5iH4UGRPOb9OTZIex0Cyg4NHgOdFBOCgxbHP0dgcmkpPnqhFpMFLNxC
 3RPhOB6NJpE1XRJAMufEAd4vjWEXGvQ=
X-Proofpoint-GUID: 4Cd3fmh5fEi287p1xv_e184eiy3BOoXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX5SPRR80/dz+K
 wAq6/QTKNDQ1F+hp5a5UkknTyngOdE5b2+snifFxn2IX4MrdZK2NvlmHi0hMZVn4l8e7y2RfpZS
 BQRWwdLOL3UucmvXVjW8mtnBfYKPYZHgHKBKV8u+l0A47LUubfYia/dC765iYLzh8IpqFoXuBet
 wQYjCzdRhVheMs4t9p130tyGY3Zaor6QBY6axonKigaJEA8lLN9d+GxJw5ET5Wccg1IXXwjrfHE
 VjbMLpOhKdFaawqNF8E2uekTjqHI1GDos/ayeuBEZKmnzDleXDaaJu9J7XYQhnfii3szP49AnDc
 cxWsjYyAI17yO7EuQnURGUTYdJlsnfGTFrP2z1gsUQqu6XVIDBY5JeMOt90pHy8Vnz5rTq8RHR5
 G5z2AODSOD61CLqA916Qbeh/MYY9uQxzU5M6FcqHGriRhTzStJm3Zru+GuLECxQ0883zGDasxjv
 yuQb7btL1gc1pDszqhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/24/26 3:41 AM, marcandre.lureau@redhat.com wrote:
>> While the backend (thread) is accessing the request and response buffers,
>> do not clear those buffers upon a command cancellation. Still clear them
>> in all other cases, though.
>>
>> Fixes: 29315d22b259 ("hw/tpm: Add internal buffer state for chunking")
> 
> It's the following commit that makes use of it, but ok
> 
> This may also lead to OOB read/crashes from malicious guest driver.

For example g_byte_array_set_size(s->response_buffer, 0) does not seem 
to deallocate the memory in s->response_buffer just because it was set 
to size 0.

Running the tests/qtest/tpm-crb-swtpm-test with this modification here 
requires me to disable asserts for expected responses but no crash 
actually occurs.

@@ -254,6 +254,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr 
addr,
                  .out_len = s->response_buffer->len,
              };
              tpm_backend_deliver_request(s->tpmbe, &s->cmd);
+            tpm_crb_clear_internal_buffers(s);
          } else if (val & CRB_START_NEXT_CHUNK) {
              if (!s->cap_chunk) {
                  break;


> 
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Message-ID: <20260924012527.858527-7-stefanb@linux.ibm.com>
>>
>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>> index 54fa2042b5a8..e5e33a3a2ff4 100644
>> --- a/hw/tpm/tpm_crb.c
>> +++ b/hw/tpm/tpm_crb.c
>> @@ -218,8 +218,9 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>>           if (val == CRB_CANCEL_INVOKE) {
>>               if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
>>                   tpm_backend_cancel_cmd(s->tpmbe);
>> +            } else {
>> +                tpm_crb_clear_internal_buffers(s);
>>               }
>> -            tpm_crb_clear_internal_buffers(s);
>>           }
>>           break;
>>       case A_CRB_CTRL_START:
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 


