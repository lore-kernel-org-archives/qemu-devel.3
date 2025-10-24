Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00593CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 12:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCGdg-0000pt-KK; Fri, 24 Oct 2025 08:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCGde-0000ky-4m; Fri, 24 Oct 2025 08:11:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCGdb-0002D9-Cr; Fri, 24 Oct 2025 08:11:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OBFD4Q027377;
 Fri, 24 Oct 2025 12:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F/EVhf
 yZkjJrEmXyijzfrXjowFbOWu3oE1ELrPm7o5o=; b=cxfvSja3IH5jH4SUAVJ0KN
 NTE1uKO9FUD2yvh9YjwTJ41noGl8g5xOj9niqnpWV2q5RvpGS8hsriGWcnCvziNl
 59d62LGNLzkUIIVROYTjdKIcOUtxgVVJQiuzWXxaYK3JjO2tUzgQPM1Xesf1dj9F
 eQKuqpTySFAd4rknH8aLkCDEquOWKjpPipLN9a0+RRikFM8bpJ3ty0qdodiG4nN9
 04EOl8jV2tOWe3RsaZ3MhXTWCONbY2WtwugwmRpBvpbMyG9ax/L1AL5bFfd29JP/
 F5b7UT30LdqeJD/b9fBHmgihm44IwlYTf/gHvdC1ImUQVZCEWMIB4JplWf7NF9aw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32776fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:11:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OC5e0l003627;
 Fri, 24 Oct 2025 12:11:12 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32776fg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:11:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9XZFq032092;
 Fri, 24 Oct 2025 12:11:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7nawq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:11:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OCB7hv35782924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 12:11:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10B5E2004D;
 Fri, 24 Oct 2025 12:11:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB9AA20040;
 Fri, 24 Oct 2025 12:11:04 +0000 (GMT)
Received: from [9.39.24.189] (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 12:11:04 +0000 (GMT)
Message-ID: <5c2da466-1e2f-45be-a3be-d1dbcfaba8fa@linux.ibm.com>
Date: Fri, 24 Oct 2025 17:41:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
To: BALATON Zoltan <balaton@eik.bme.hu>, philmd@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
 <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fb6ce0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=PITxE3U9i_yIn8GRDFYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXy72Py4WeBCwt
 8MfkOf6dyt87V1YpooIORiaQJPZP5h1kiAA+KErpFy8nxZCNdhEJp8MVniHuJzeNj2GIF7h4IoU
 UO9M6F7tEJhzw/kZTW8MrhYKdC/2kTBcxPpyx7xEC0dxQfPG80X92ScPUIxgy79bq5DLl11MEAK
 AIK823nW0qVeuJM1/L17/n97VBaZwb+BKBIltobyxGCZSQInEMe6ONmD6m8YhmuK8ga15uFjqlc
 7IZOYm2jGCYwTC4KX8hY9lihRhJn1ktcuGYEPXKqv+IVLj6+gTIia3muWFx/iixux5SER63crHD
 9yK8hQlBFXnQ/8K4cW+mUbOm9jJ4LE8XHoVoh4y+8EVmyg+JxIo5H3ez33sxoVGNrlB6VuRl6cg
 X8ixnicjjFI+zREUVVNcfDZ14p6Jcg==
X-Proofpoint-GUID: KB2eTv9hDNixhCZeo9ytz5Y3xbxGngp0
X-Proofpoint-ORIG-GUID: nnubcSg7TovNlQ5dyCXGMmb2uVW5hwrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Balaton, Philippe

On 24/10/25 16:55, BALATON Zoltan wrote:
> On Fri, 24 Oct 2025, Vishal Chourasia wrote:
>> Add error checking for lseek() failure and provide better error
>> messages when image loading fails, including filenames and addresses.
>>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> ---
>> hw/core/loader.c | 16 +++++++++++++++-
>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index 7aca4989ef..48dd4e7b33 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, Error 
>> **errp)
>>     if (fd < 0)
>>         return -1;
>>     size = lseek(fd, 0, SEEK_END);
>> +    if (size < 0) {
>> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
>> +        return -1;
>> +    }
>>     close(fd);
>>     return size;
>> }
>> @@ -129,14 +133,24 @@ ssize_t load_image_targphys_as(const char 
>> *filename,
>>                                hwaddr addr, uint64_t max_sz, 
>> AddressSpace *as,
>>                                Error **errp)
>> {
>> +    ERRP_GUARD();
>>     ssize_t size;
>>
>>     size = get_image_size(filename, errp);
>> -    if (size < 0 || size > max_sz) {
>> +    if (*errp) {
>> +        return -1;
>> +    }
>> +
>> +    if (size > max_sz) {
>> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " 
>> MiB)",
>> +                   filename, max_sz / MiB);
>
> MiB is arbitrary here. This function is used to load all kinds of 
> images such as ROMs which may be 64k-2MB or even executables in 
> generic loader that can be a few kilobytes. This might result in 
> errors saying max size is 0 MiB if the allowed size is less than a MiB 
> (e.g. amigaone PROM_SIZE = 512 KiB) and integer division discards 
> fractions. Do we have a function to pretty print sizes or maybe this 
> should be left as bytes or at most kilobytes?
>
Yes, for images sizes less than a megabyte.
Perhaps we can leave it at Kilobytes

I will send out another version.
I will also address the *errp vs size<0 comment from Philippe.

Thanks,
vishalc

> Regards,
> BALATON Zoltan
>
>>         return -1;
>>     }
>> +
>>     if (size > 0) {
>>         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
>> +            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
>> +                       filename, addr);
>>             return -1;
>>         }
>>     }
>>

