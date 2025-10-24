Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ED2CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHsO-0004xD-Nu; Fri, 24 Oct 2025 09:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHsL-0004tD-Av; Fri, 24 Oct 2025 09:30:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHsI-0006Xb-KC; Fri, 24 Oct 2025 09:30:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O5lHhI010767;
 Fri, 24 Oct 2025 13:30:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NYw/Yp
 /iBuot1rBZc+GcB/Y9H15wso16IWBRHPnjyZM=; b=o0gM+bldXaaQG2rCylUGWy
 VOgVTItzWkMSkQAHcC/7OtJe4hcc+Ngpz8PJKjj2+0CgrXJRYvS4n3xqXhVdNSKG
 cSxs+bdx4fzVhMPtgprlF2Q+Ewoy7R3IAKxCKFGrc28V6f7cSSJ8g3nnLZFRJUNC
 VcgVg8Scr+Bk5umwShWfM3ESazg8DI+W+9/kYZB54OZ2hL2aHWz9A63j2lmVaNFJ
 mSRUUZHdBy7j8upLXoE+v9EjX4p4VQsm3cV39549pp6Ap+qOcpNL1BNkQ63uF6qo
 Up8MIjRY4ABHlAA1B+HQKiAhZUJC2LgIn117fN3oA2WW2zOmltlFtvWq6ALbgZ+g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hwuay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:30:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59ODOfEY005448;
 Fri, 24 Oct 2025 13:30:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hwuaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:30:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OA2xWc024677;
 Fri, 24 Oct 2025 13:30:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqkb651-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:30:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59ODUP1D53608894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 13:30:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A97982004E;
 Fri, 24 Oct 2025 13:30:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 847CD20040;
 Fri, 24 Oct 2025 13:30:23 +0000 (GMT)
Received: from [9.39.24.189] (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 13:30:23 +0000 (GMT)
Message-ID: <50812d7f-82b1-418e-b92d-3aaf8396c5d7@linux.ibm.com>
Date: Fri, 24 Oct 2025 19:00:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
 <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
 <5c2da466-1e2f-45be-a3be-d1dbcfaba8fa@linux.ibm.com>
 <75aa6f52-4bf3-4e07-a8ea-29bda1cb42a7@linaro.org>
 <5bfb5c2d-5215-4ca7-9a8b-48f3520add20@linux.ibm.com>
 <c76ee7b7-5eb2-4124-b70f-c437b787c241@linaro.org>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <c76ee7b7-5eb2-4124-b70f-c437b787c241@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9D1JLNIoNlUo
 PazN+ObylDoA9ZMfN/lFyUrt2v2l/4ODKcuAWjpI9dsD+zW5zSHnuqFHh1c2ZSEpF6Q2fUyDmqj
 pFKEgJrqea+HxOvvTo5X+YqKKKzW+LTPYZkmfG70FF/R+Jq5FtTjvXPoZ9MpH98FhK4HFPiW92f
 gFMqFnkXlAeeXuxY9QiG51DmniYyP9iCL2/lhDvKffMd0cvniHvPtHqkgKlo22MdsYTEeo9UxT6
 kXJxP8BB2Lm+g8jdUEVIVtSznYxX6tjdvrWVMfF2xq/k103fwqIhQ+lZV0aoOiA1OH25+e6nAtN
 MUcSRW1/oEJEBCR2xaNQBMeATnkoYnIL1RJdsj23h2MLpKaqAlM1ucT5HqR3Ux8gWP7J3wPOrQt
 0ubOJSD5G4tXIyAFm9O/HMktlSgsJQ==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fb7f76 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=DIV08GD33MYrcka1EU8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: xgyrPh1QDN7C3yXiahX2uj34cTabsxi0
X-Proofpoint-ORIG-GUID: 5GbWNVydMoysIXQ8Lxqbk0SikgkFwHre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 24/10/25 18:52, Philippe Mathieu-Daudé wrote:
> On 24/10/25 14:58, Vishal Chourasia wrote:
>> Hi Philippe,
>>
>> On 24/10/25 18:17, Philippe Mathieu-Daudé wrote:
>>> On 24/10/25 14:11, Vishal Chourasia wrote:
>>>> Hi Balaton, Philippe
>>>>
>>>> On 24/10/25 16:55, BALATON Zoltan wrote:
>>>>> On Fri, 24 Oct 2025, Vishal Chourasia wrote:
>>>>>> Add error checking for lseek() failure and provide better error
>>>>>> messages when image loading fails, including filenames and 
>>>>>> addresses.
>>>>>>
>>>>>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>>>>> ---
>>>>>> hw/core/loader.c | 16 +++++++++++++++-
>>>>>> 1 file changed, 15 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>>>>> index 7aca4989ef..48dd4e7b33 100644
>>>>>> --- a/hw/core/loader.c
>>>>>> +++ b/hw/core/loader.c
>>>>>> @@ -79,6 +79,10 @@ int64_t get_image_size(const char *filename, 
>>>>>> Error **errp)
>>>>>>     if (fd < 0)
>>>>>>         return -1;
>>>>>>     size = lseek(fd, 0, SEEK_END);
>>>>>> +    if (size < 0) {
>>>>>> +        error_setg_errno(errp, errno, "lseek failure: %s", 
>>>>>> filename);
>>>>>> +        return -1;
>>>>>> +    }
>>>>>>     close(fd);
>>>>>>     return size;
>>>>>> }
>>>>>> @@ -129,14 +133,24 @@ ssize_t load_image_targphys_as(const char 
>>>>>> *filename,
>>>>>>                                hwaddr addr, uint64_t max_sz, 
>>>>>> AddressSpace *as,
>>>>>>                                Error **errp)
>>>>>> {
>>>>>> +    ERRP_GUARD();
>>>>>>     ssize_t size;
>>>>>>
>>>>>>     size = get_image_size(filename, errp);
>>>>>> -    if (size < 0 || size > max_sz) {
>>>>>> +    if (*errp) {
>>>>>> +        return -1;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (size > max_sz) {
>>>>>> +        error_setg(errp, "%s exceeds maximum image size (%" 
>>>>>> PRIu64 " MiB)",
>>>>>> +                   filename, max_sz / MiB);
>>>>>
>>>>> MiB is arbitrary here. This function is used to load all kinds of 
>>>>> images such as ROMs which may be 64k-2MB or even executables in 
>>>>> generic loader that can be a few kilobytes. This might result in 
>>>>> errors saying max size is 0 MiB if the allowed size is less than a 
>>>>> MiB (e.g. amigaone PROM_SIZE = 512 KiB) and integer division 
>>>>> discards fractions. Do we have a function to pretty print sizes or 
>>>>> maybe this should be left as bytes or at most kilobytes?
>>>>>
>>>> Yes, for images sizes less than a megabyte.
>>>> Perhaps we can leave it at Kilobytes
>>>>
>>>> I will send out another version.
>>>
>>> If so, then please use qemu_strtosz().
>>
>> There is another function size_to_str() suggested by Peter I was 
>> planning to use it, as it was doing the expected job.
>>
>> It seems qemu_strtosz() converts size strings to bytes.
>
> Yes, they are the opposite ;)

:)

Hi Philippe,

I have sent out v10 in which I have used size_to_str() to pretty print 
size information.
I have retained your RB, but now I am unsure if i should have not.

Can you review again perhaps

Thanks,
Vishal



