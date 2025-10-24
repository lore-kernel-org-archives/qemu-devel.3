Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9780ACCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 12:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCGmY-0003S2-OC; Fri, 24 Oct 2025 08:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCGmW-0003RK-NK; Fri, 24 Oct 2025 08:20:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCGmU-0003x9-Ab; Fri, 24 Oct 2025 08:20:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OB5mAV007202;
 Fri, 24 Oct 2025 12:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VPBDaz
 z0Q17gfG1B/NoLUFTpiajaLRTkqeRJL8A/CLk=; b=MkimkkjvZcRnx3HY+xM9k4
 RLP/Rid+loPXll+SbefD0vQ7nrr2I2aDOkSTro7WVUvbwZ2NKUBqfkkcgiSynNOa
 JjJ5xUE61x59nBDj7lTlN8i3Ez2XKnpfyMk5OLAjVrYw9O4nXOa2ajl/QOPpwRc+
 MUmSjGiW0W8tyA/F8feurnMtia6uQ62Rliy92sxCAhjZ6dJbKmhPzcELq5+EPXT2
 ZjiXAUF2xm2UGz8qMLJlFLRgcJA4o55+Gl3UtPbMwzcfO/P4kwq5KW5zbJJHRqn6
 IKu46TFq8n6tNYCXhe3/dMBYllVpibhlS3XGRnxhZR5ti+Yx4m9yHBwj10UCAOtQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w5mp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:20:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OCKOAN007571;
 Fri, 24 Oct 2025 12:20:24 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w5mnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:20:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OA0uhO002320;
 Fri, 24 Oct 2025 12:20:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejtstv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 12:20:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OCKKBi61800824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 12:20:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20C3A20049;
 Fri, 24 Oct 2025 12:20:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBF4C20040;
 Fri, 24 Oct 2025 12:20:17 +0000 (GMT)
Received: from [9.39.24.189] (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 12:20:17 +0000 (GMT)
Message-ID: <430dd09b-6630-4660-862f-6f012727af17@linux.ibm.com>
Date: Fri, 24 Oct 2025 17:50:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 3/6] core/loader: improve error handling in image
 loading functions
To: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, alistair23@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-6-vishalc@linux.ibm.com>
 <aecf60d5-8bb2-48bb-28b5-20b58729fb56@eik.bme.hu>
 <CAFEAcA_2B-Q9QzvT+dEL3DFnkfuG6hh0cUObqcKdaqiatQwgaw@mail.gmail.com>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <CAFEAcA_2B-Q9QzvT+dEL3DFnkfuG6hh0cUObqcKdaqiatQwgaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ZL66njdEqMGnMaCUlSIvLpDZ1cvZLo6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7+TYkBgIdyLJ
 /ezzwAJZV1V8qxXquO/6vDsANdsqTPaiGXoTILF6pOVgBUaPlWYwl+s8J32axKWInawh76B2pUx
 aIfuWIMCwPsxyzPLs1rbznmw+cxq8JF5n3pSE+5jyfouc3K6fz1G1XVY/aYrU4OHAOoh6sAx92f
 6Xh3hs/ICwxttujZWWO7z9EF7L2aN/ABQ624hkllZjbtvRA4lDUBCeMdx8qDPuh/P9uEUQZ93mb
 n/OMdFMS4jovSFUXr5xr1KR1ndhE8I2flhAbmA/Ip9FcN0Sxc97/S/tTZPoq+phbAv2maJjO4dC
 ilStjlycdCryh1pLRIPhDTkDj53BHxBV7IjAIyrrA5PyGLieL9RGQuHmXv01FXlWPK0yh+SP8Zm
 pEKruwK+UghOROL0kiI14EGumEhUJA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fb6f09 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jLlASQL0FiaRDCC9RHQA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: h6oZjv2yM7gZ7JvCSUq0shoxWEBeE2_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
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


On 24/10/25 17:48, Peter Maydell wrote:
> On Fri, 24 Oct 2025 at 12:25, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Fri, 24 Oct 2025, Vishal Chourasia wrote:
>>> Add error checking for lseek() failure and provide better error
>>> messages when image loading fails, including filenames and addresses.
>>>
>>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>> +    if (size > max_sz) {
>>> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
>>> +                   filename, max_sz / MiB);
>> MiB is arbitrary here. This function is used to load all kinds of images
>> such as ROMs which may be 64k-2MB or even executables in generic loader
>> that can be a few kilobytes. This might result in errors saying max size
>> is 0 MiB if the allowed size is less than a MiB (e.g. amigaone PROM_SIZE =
>> 512 KiB) and integer division discards fractions. Do we have a function to
>> pretty print sizes or maybe this should be left as bytes or at most
>> kilobytes?
> Yes, we have size_to_str() for this purpose.

Thanks Peter, I will add it in next version.

vishalc


