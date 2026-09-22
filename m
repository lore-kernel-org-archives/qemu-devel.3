Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1342C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x90sd-0002HP-DC; Tue, 22 Sep 2026 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x90sR-0002CW-6s; Tue, 22 Sep 2026 09:49:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x90sP-0000kr-DL; Tue, 22 Sep 2026 09:49:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBZMcM314040; Tue, 22 Sep 2026 13:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tXeUcY
 5IsfpmtprNJt8kosSnY8UiaMffIS4eXNeN8Fg=; b=aGMSDG1SJwDzv5Q4MDHVPj
 hZOY0Mlqtb3TTYXSJHIk9S4YZGb8jowG4zASq2EiK3AtUzpadv0U9+VuO9otl7l9
 3Ke5bAt9g2AeEOF20ll0A4qTxd9hkg6HDmwAHSysmwu/9iFrClyR8dXYC+XBtGOO
 7IDsH/JVvGOdAvm6pRhMDA1PljEqkUITlsgF2dUr3Nsm1ePh9Y0acdY/626WyFK5
 BLobmaU23vie7rTt3kc6WGG0FryNGZIxi0+Im+wQjOToqivhdO/vAwMa6lgnskWi
 +pacUDZxxzdKrvsBj8Mxa9VDPiP+b3UAQ2mIwcpa0wAP4feMA6Z9snHa0FWx2+mQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2e230-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 13:49:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBWWNK1521398; Tue, 22 Sep 2026 13:49:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkckn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 13:49:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MDnaKO16777930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 13:49:36 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E93158055;
 Tue, 22 Sep 2026 13:49:36 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49B825803F;
 Tue, 22 Sep 2026 13:49:35 +0000 (GMT)
Received: from [9.61.69.195] (unknown [9.61.69.195])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 13:49:35 +0000 (GMT)
Message-ID: <43d81c3f-937a-4f68-a1cc-b593cccddec3@linux.ibm.com>
Date: Tue, 22 Sep 2026 09:49:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] s390x/css: Use datastream pointer for checking
 no-data CCWs
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260921184305.3791311-1-farman@linux.ibm.com>
 <20260921184305.3791311-9-farman@linux.ibm.com>
 <28aae7f2-5522-4034-a23c-6b36135d8d3b@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 xsFNBF7EiEwBEADGG0EtNKnjp+kQfEVqlqxXoBHjnaQptFpMgxNlz2GtqOujY6nzEWnybIXY
 63XUTmMS/tWUf2DTbNCNoWwumGM/I2Gj1uGyMnc4Q477BQlL/e2/9MRaut11rwHsi4zmWylc
 jO0eFTSLFA8yFBj9osT3uZzk5TwWkD8sf+rD916fFVk0G39uYEd5sjEzjeOf9/dwXyZpjJY6
 api1pUHEw7weRvOnllJAfIKFz+KoR6d7ezvMF9zOYHF73FGeSVIYoIEUhA5Cdg60rSlTtHb2
 cftex3/cEapvY5bK3CKJ33BVVK10Bht9XfVaA/AOcg/3o5ZbhSIwz4xScGsEVf/Yr368YMdr
 3VkCZrmN2ppmVRz/RvAmCyItnmzoVDlSREA6Faw6S0x8Oi7lN0cKh2hy9VPcVupraXJZrdAh
 GtdU+jrJvSbpdsrX8F7K3RwynbiqGrqC0izGla04hhtei/uwthatglukuxep4PknDGbzijg8
 Ef7A8t3qEVklUDrsnNPN5HbR9QQdeF0HuWsDTfILbZv1MICfOK3BCDeT5mJWaJCoQ2rbuljM
 e1hFSt+mr7GV4h6NcBE+uGIqDSzQORtyTo0uBV4et3cSE84JxOfXBMrj0TlL1855JaIoPWEN
 uhDRB/dHW8+Fumq2du5hLcaXPka+MO26cNVKVLF0/JjwMTZ9bQARAQABzSJFcmljIEZhcm1h
 biA8ZmFybWFuQGxpbnV4LmlibS5jb20+wsGuBBMBCABYAhsDBwsJCAcDAgEGFQgCCQoLBBYC
 AwECHgECF4AdGGh0dHBzOi8va2V5c2VydmVyLnVidW50dS5jb20WIQTSxgUEyej1aM/lh7U4
 J7IScb+VYgUCYel8TgAKCRA4J7IScb+VYsHAD/9BSQj7HeJf90PttOmVh35Bb4QyHLZ4g+9x
 waM59JCKGbiURuNRIGnoRarYXHk6vfy19v8v56Dy1IOlKWaRnizp5Mw9zXBBTCs4fgNbOzY/
 SggFY2UzcziXDG29X9zznq5LgY1Jf/cwm1O+rn89GKCZWZhLEB2wKzBj7hum7NBdW+lxfVwp
 2qONGDerttWDwAHxJ995k9aDJahq9kIKEMEZbrTQ8JI8KZGoox6+HA04EhoNzxvbV0J+/gLJ
 2DkvxN5/xmcD3z+s8B5ev3NarOF17AIA9oCdfu8CPAupcNqJW86m19P5q6AyRB2ZLyAIAAhr
 HCXrnlh/8HJW1yCOVXxprFdpg1SX1fuArjbFAh53vVVDfkZlwHeTeE7+3y1rtDLfy830pqdD
 ymv94yey2y1+iZBdbaW0fSC/JkjkOCy8oZawkH3geM4MXV4ze4gbBH6BhxW/0gbEYjnLm3FA
 53JcXwhHQFPWIYEYYPvATJi0JUiMY1Znkm3QBWDOCXSrG0tHpAclBa9L40zLRwA1h9YOMFEs
 qvKijUdvcDf4sTdJ+A6YL66grzul5vNt06NlqsI8HUDHE6vghqyWxupCav2+9b1BuLie++er
 b8OCo5n3TUHsVMjYJEePU1EkcCa84dCm+CXqPthgRv0sbe4UQEd/qUoVMdWj7Q7FL96mBn0G
 zM7BTQRexIhMARAAp+k1sC4y7Wtwjqtfu9wIihvY/Vot0v/sKg8CRGRIIRGLiCeA9o+2ZlxC
 jYztT3Leri5Vo5z09OmRMvoFLJjcHMCG5sYeZwOWNAbeuAxGkIMDSB4pLl3t2c+1PQuMBCd7
 +mRZFaMEJfT3nhdUKxy2rp1+YucnA67xGXUJCiD5l9UmhPqa7SAYlpMAqDz7cmBo25c/UNm1
 Tpwjrh70jq/4guV5gnprawH8nkRjdKH1JvKWvkuaB7FNZ9IuSHlWclcQX4IQMsaxsU2emAbP
 VYv7l4YNlKfdlJd8tuEodjuMLOBnr7e9H0hVNUWGFN9bkBNRu3zi/jvhyu15Iu4euR/WdVNu
 2K2iYxIfiGMnv0F/a6R1bm10lCJrjyf23J8DYIeH4YmHvOOqYFkq3DWOctlXbb3+aABqjYt3
 mkiOLXeplqbo/m3rWcGNd8Q/d1aVA0wm5+Nt3RdSuXG2FHOFdVUQKPLpf1NUH/LInBhS/9Ys
 ajm6tWXKv7hxwWmyz0u/th6gUra3KpARB1ypebWHULLNzKGwVS81XNs76QhXwX04cyiwLqKb
 WqLqJKThz+rLa09Ap+eO/UzPfFXvWYWfTeFRIQ/tKF332ZzRR8Xrh/fk//YXyRfpoE/7i5uz
 ve0HZWp5jXg9Yb+S6g0+XUKznnN9B8WLLCcuRIuSa722070v7KsAEQEAAcLBdgQYAQgAIAIb
 DBYhBNLGBQTJ6PVoz+WHtTgnshJxv5ViBQJh6XwwAAoJEDgnshJxv5Vib28P/1BYT5gvjuEB
 A80AXo/IqycicXxDJtrfmyw4COP7bi7AuiDcKyA1wRzC51paKwPFB8Unk2GvG4DV6aDmGTJY
 +GeCYgthQ+znW461S8B6GqDCAQt2VDNNFVU+gTuh7vYQOgt/OjtiiAvMIJBVRbXoNSRokKOF
 tpTiXf3ZOsAkot5ZmxE0TV94v18sp/bC84YvFyaxpw5bilT7bmpcq8B8/3yb0kmy6gXLcQAp
 OnomV3sQBmm050amiO3tvxMNv8J71AvNdTG/rojTDKUl2Nw4f+aw4nVw874m2XpEe9JGRw54
 5d2dN8k3GpzcTBe9fCQPOFHOGkQ1CgptDkQuQVD3DIeNzQjXf6xehEymIKnLOkukT2smV0zh
 fj08z7eiv+dsmnBsbhdM6DKU8qIgkTu77TfHUKjjOY/Mj0YHPuH/J4b1AZFxBhGP0BTKiB2W
 CR6/49XVKvY1jHxgadSSNCD+f7tEqUNBlVl+P0emMJaYpK1+gy88ma4g3nvyOVe/VzDPjGDC
 4HX/6RAR4Dbzry6/epWTTji+7ApzePzmJzPcuzD31ICsgT2dJ6ydxyxxXikBFJqx6BPOF+u+
 1BtKcTz1ek3I2sWvBM1V5CKaFw7iNXxS6HgS2scuAT2awKq+BQlt778/GfBWpXonfqixMvit
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <28aae7f2-5522-4034-a23c-6b36135d8d3b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 89M0vBgZysN7_L2EgxzCL1X56wqi_qoO
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab28772 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=MdFSUtoD9ge8hejsK1sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE5NyBTYWx0ZWRfXxz1LhGH33r3E
 kFZML4XRzl611OK11oQaAz1DZdeQHqXfxjPaZqBTa7GOpxeQmIhCNL0B1xVtm1HxTwkFSdooYKZ
 N9bvmN8555JLxTdAReN3wCpL9L2TQtym5TSwb8QoPBfVxrT3KtV7/nE+yQVZOTQaRQe1xb9tcO1
 xO0hCTPmz0YeRU0sLYlONsh6+1S9Cpk3swbrh1zjLgsOJqXlBtTWGMUSkCpG0dAPvneRTzeHgfu
 dXxj+mOmtlnhA1DLgVAeol9wREOqOe1fb639+xlsfsdwDD35Hbjxyvq2Tk1HyUn5ZnDIkHrXak8
 W4+aGp2DYkZW/4IwIXGq01rD326UJAu17/LfvjLc2St7nqrWB0bXCR1i70tYQn54un4c+CRz6Ml
 hJrLKMbC1In+HtdbnE5eVmartk8LVuKqbcN9ASQGxut7FgCCJPI5incBuXmSLoy+c1c4BS3cy4s
 f9pxlA/xxBgXKq5bdSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE5NyBTYWx0ZWRfX6p1PdXUI3w+7
 fKl2EBkhIqUhloff6lhotQUosjyCrDQRmpl6+WhmFVA8jYDvnNegvwMf+3gUgR5uEHDLLa5QGC9
 ReMyIfLXZBQs+Hpu+nPZduOzBCQ01eE=
X-Proofpoint-GUID: 89M0vBgZysN7_L2EgxzCL1X56wqi_qoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220197
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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



On 9/22/26 4:35 AM, Christian Borntraeger wrote:
> Am 21.09.26 um 20:43 schrieb Eric Farman:
>> The channel subsystem will reject channel programs that incorporate
>> 256 CCWs without a data transfer, but the existing check to account
>> for this only does so for CCWs with a data address of zero. Other
>> valid CCWs that wouldn't transfer data are not accounted for.
>>
>> Rather than re-inventing the wheel, use the output of the datastream
>> at the end of the entire CCW parsing tree to indicate whether data
>> was moved or not.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: e8601dd5d0 ("s390x/css: catch ccw sequence errors")
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   hw/s390x/css.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 9da9128d88..10bebdcb1a 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -1016,13 +1016,6 @@ static int css_interpret_ccw(SubchDev *sch, 
>> hwaddr ccw_addr,
>>       check_len = !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & 
>> CCW_FLAG_DC));
>> -    if (!ccw.cda) {
>> -        if (sch->ccw_no_data_cnt == 255) {
>> -            return -EINVAL;
>> -        }
>> -        sch->ccw_no_data_cnt++;
>> -    }
>> -
>>       /* Look at the command. */
>>       ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
>>       switch (ccw.cmd_code) {
>> @@ -1110,6 +1103,19 @@ static int css_interpret_ccw(SubchDev *sch, 
>> hwaddr ccw_addr,
>>           }
>>       }
> 
> These two context lines are the end of
> 
>      if (ret == 0) {
>          if (ccw.flags & CCW_FLAG_CC) {
>              sch->channel_prog += 8;
>              ret = -EAGAIN;
>          }
>      }
> 
> so by the time we get here, every successfully executed CCW that has
> command chaining set already has ret == -EAGAIN.
> 
>> +    /*
>> +     * A CCW that transfers no data is allowed, but ensure an upper 
>> limit
>> +     * is established to prevent long-running channel programs that 
>> don't
>> +     * move actual data.
>> +     */
>> +    if (ret == 0 && sch->cds.at_byte == 0) {
>> +        if (sch->ccw_no_data_cnt == 255) {
>> +            ret = -EINVAL;
>> +        } else {
>> +            sch->ccw_no_data_cnt++;
>> +        }
>> +    }
>> +
>>       return ret;
>>   }
> 
> Which means this never fires for a chained CCW. The only CCW that can
> still be counted is the last one of the program (no CC), and
> ccw_no_data_cnt is reset on every SSCH, so the counter can never reach
> 255. A chain of 100000 NOOPs with CC now runs to completion, while HEAD
> rejects it at the 256th CCW when cda is zero. As posted this removes the
> protection from e8601dd5d0 rather than extending it.
> 
> Moving the check above the CC block (right after last_cmd_valid = true)
> should do it, no?
> 

Oops, I looked at that and still missed it... Will fix on a v3.

