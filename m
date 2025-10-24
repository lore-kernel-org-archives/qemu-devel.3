Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C0BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHNl-0005ah-1D; Fri, 24 Oct 2025 08:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHNj-0005aN-PH; Fri, 24 Oct 2025 08:58:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHNh-0001Tp-DO; Fri, 24 Oct 2025 08:58:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NMbb1u001179;
 Fri, 24 Oct 2025 12:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=q8A5rU
 ulhrzaQjQEp2L93UJS8lmxqJ+SYtp30c8xfUU=; b=V6GPapj7u5/pKf1ArJAzQj
 gJ9QBElNVTWbeFmnJ7SQqqpAOcvr2MSgL1CnQuI6K189giOX6st1QYbNNHf+MhFd
 8MkRjC4spHzJ5qwnmkoMnZN2rV4pQzwKJlAz/BgFfzCtJtm35cbCy1SWmfqQzFpg
 xJdpcEaznZTtHHK825pzzZRHM1yKtzw8GJXx0VQdhhIsKUscxhugaSHVIoMnL5JJ
 Xu3OEAmElG8MYfd7E+9f0+n2EOvba62NxzHnjA4NMIIE0hMgBo+JZs2rGfsfZJGG
 5v0vlGAoNu/jfNW8UB6prvoSummxdWoIIRCaOYiaILNMZN7cTXywBfdPcHlDX4NQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fqcgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:58:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OCd2eH023916;
 Fri, 24 Oct 2025 12:58:50 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fqcge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:58:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OAlLRv002306;
 Fri, 24 Oct 2025 12:58:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejtxhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:58:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OCwjY720250994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 12:58:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 218DE20049;
 Fri, 24 Oct 2025 12:58:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93EA720040;
 Fri, 24 Oct 2025 12:58:42 +0000 (GMT)
Received: from [9.39.24.189] (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 12:58:42 +0000 (GMT)
Message-ID: <5bfb5c2d-5215-4ca7-9a8b-48f3520add20@linux.ibm.com>
Date: Fri, 24 Oct 2025 18:28:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
 <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
 <5c2da466-1e2f-45be-a3be-d1dbcfaba8fa@linux.ibm.com>
 <75aa6f52-4bf3-4e07-a8ea-29bda1cb42a7@linaro.org>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <75aa6f52-4bf3-4e07-a8ea-29bda1cb42a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fb780a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=SMKQLPHlYt0khzW6L5UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: f6zhggBH6nrMnnNwnReHvL1uJfZw4h0t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2dOfq8f8o2Pb
 gcfZbRyfGoLfwCDQvwOmenQhyyliod2pxvsa3ddC1ao1xQM/mn8X38rRyY+E1SbVuxN+WitXwiA
 UsksQGEyanu2c4vSiTGMwI3zuWqTjZN2Fxgdp6APHCmQ0h+3NK+VyCHSA3eqX5d4/RVB/7FospU
 480Zbdn9XvAon0hqOgCewOnJzCjLw8iGWvbGHLIiE+3QhwufO5dPLiq+EetFJvIWluBTi9fiYaz
 PBaj8tgxM6mzzlc+F8BkuapJa9N0CxHj7H3KRoqzALus7BYgbBBZlUjcG0m2Wli2VRE0PY1q2Qo
 oqYiQzAkUkV/MIEFJ/iI0LXcrMvji7R89/OlHLjpFBFbh37qyw8kAUzQMiWDbtV+/44ur+M/EhB
 eRZ4tVJ6hgFRXlP2Nu+Q6cU2tCEMWg==
X-Proofpoint-ORIG-GUID: 7YbLJ1YMZIrvdvKmbbLz0-zgAStYpGMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
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

Hi Philippe,

On 24/10/25 18:17, Philippe Mathieu-Daudé wrote:
> On 24/10/25 14:11, Vishal Chourasia wrote:
>> Hi Balaton, Philippe
>>
>> On 24/10/25 16:55, BALATON Zoltan wrote:
>>> On Fri, 24 Oct 2025, Vishal Chourasia wrote:
>>>> Add error checking for lseek() failure and provide better error
>>>> messages when image loading fails, including filenames and addresses.
>>>>
>>>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>>> ---
>>>> hw/core/loader.c | 16 +++++++++++++++-
>>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>>> index 7aca4989ef..48dd4e7b33 100644
>>>> --- a/hw/core/loader.c
>>>> +++ b/hw/core/loader.c
>>>> @@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, 
>>>> Error **errp)
>>>>     if (fd < 0)
>>>>         return -1;
>>>>     size = lseek(fd, 0, SEEK_END);
>>>> +    if (size < 0) {
>>>> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
>>>> +        return -1;
>>>> +    }
>>>>     close(fd);
>>>>     return size;
>>>> }
>>>> @@ -129,14 +133,24 @@ ssize_t load_image_targphys_as(const char 
>>>> *filename,
>>>>                                hwaddr addr, uint64_t max_sz, 
>>>> AddressSpace *as,
>>>>                                Error **errp)
>>>> {
>>>> +    ERRP_GUARD();
>>>>     ssize_t size;
>>>>
>>>>     size = get_image_size(filename, errp);
>>>> -    if (size < 0 || size > max_sz) {
>>>> +    if (*errp) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if (size > max_sz) {
>>>> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 
>>>> " MiB)",
>>>> +                   filename, max_sz / MiB);
>>>
>>> MiB is arbitrary here. This function is used to load all kinds of 
>>> images such as ROMs which may be 64k-2MB or even executables in 
>>> generic loader that can be a few kilobytes. This might result in 
>>> errors saying max size is 0 MiB if the allowed size is less than a 
>>> MiB (e.g. amigaone PROM_SIZE = 512 KiB) and integer division 
>>> discards fractions. Do we have a function to pretty print sizes or 
>>> maybe this should be left as bytes or at most kilobytes?
>>>
>> Yes, for images sizes less than a megabyte.
>> Perhaps we can leave it at Kilobytes
>>
>> I will send out another version.
>
> If so, then please use qemu_strtosz().

There is another function size_to_str() suggested by Peter I was 
planning to use it, as it was doing the expected job.

It seems qemu_strtosz() converts size strings to bytes.

Thanks, vishalc

>
>> I will also address the *errp vs size<0 comment from Philippe.
>>
>> Thanks,
>> vishalc
>>
>>> Regards,
>>> BALATON Zoltan
>>>
>>>>         return -1;
>>>>     }
>>>> +
>>>>     if (size > 0) {
>>>>         if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
>>>> +            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
>>>> +                       filename, addr);
>>>>             return -1;
>>>>         }
>>>>     }
>>>>
>

