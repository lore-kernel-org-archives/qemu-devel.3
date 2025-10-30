Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC69CCF9F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOca-0006Xk-AY; Thu, 30 Oct 2025 05:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOcX-0006X6-G3
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:07:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOcN-00016X-CK
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:06:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TMr9ob008678;
 Thu, 30 Oct 2025 09:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=S0E+DW
 cqhK0AXb/cmRDHJrt+f7j8Or7wzmqHhJe4VRo=; b=nYLtVduFPyGyKR71z6bxLd
 eyuwFxYFG2kSyBBChxn5NGtOmXMnRVEcn8hGwHvYLcf4juFTeDGZGPCryqSgRkD6
 k/mgwHj/6I+vDOUQwNzXyqoHHG4zeX2xiLaI5qkD9kYKBK0n+M6/NXiEYwFZvvpV
 eKVZbaBE2aBgTmRqHb0e3lUn3PONu/WzAz/1rqRq0671hGItDfiUFD7mWU6mBqNV
 YB3fLSPYMQ450dqt2CKQQIpc2qMC9WKyWa75YHSuVRTbOkZDiGNK97LslpW++7lT
 P8y4n4/5qHdkibbQ1awNMOP1pFwcUTQPtgGs1v7207yk3+ON33RYeyeGkrXB+JlA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34affgcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 09:06:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U5rRbZ030753;
 Thu, 30 Oct 2025 09:06:41 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwquk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 09:06:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U96fqd33882466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 09:06:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00E875805A;
 Thu, 30 Oct 2025 09:06:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 955D658064;
 Thu, 30 Oct 2025 09:06:39 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 09:06:39 +0000 (GMT)
Message-ID: <e41be786-df4c-41e5-ae29-c9e8875ee0d2@linux.ibm.com>
Date: Thu, 30 Oct 2025 14:36:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/32] hw/ppc/pegasos2: Change device tree generation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
 <20251023121653.3686015-16-harshpb@linux.ibm.com>
 <CAFEAcA8qbC-1LhHXxiYXZjiCvstch1UFtMNxGdR1fquLB9i2PA@mail.gmail.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAFEAcA8qbC-1LhHXxiYXZjiCvstch1UFtMNxGdR1fquLB9i2PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CPKTk9BI6FP2dpzTrsNAKK1L9B8AdRpn
X-Authority-Analysis: v=2.4 cv=WPhyn3sR c=1 sm=1 tr=0 ts=69032aa2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=MHk2ux3hTTbxPN1EU_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXzEJY1Vju73mn
 wXK5yj2WbjzV+IObgUzQP04ufn52dXmJGtWzOLK61/ME3Xkg3h1loiFo6RDPTnFoa+IQCQPP3W3
 7zc25PJ2Pw3FxjwIfQodjWxBO1xw7xf1YftSPLhbvOTSc8EDS7Oph/IdecfZ6dXrQ5zwQSqjhcK
 LlNPcABSyUpRsSc6kW+UcJsbqbPjpdSPHI3pZz3V5R+7jWY4Iu6darX6/jn4/wimeyiqPtRHC2O
 41VAPgQHzWcYvBVZNN7P4lsZuNtRPVUFtbndgGaDCr9vWfENkIDdvUjkfdr+Bay3TN4FXfNrwiu
 yfyZrpV0xUXOe2Lrz27ywU1PkbwHMWMVsEjwJLZ72zSslolXIhqviVHfaEvwaNKyMreSanuo364
 NYwhCndSegF47lT0OMtSmbK2NnbD/w==
X-Proofpoint-ORIG-GUID: CPKTk9BI6FP2dpzTrsNAKK1L9B8AdRpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

Hi BALATON,

Would you be taking care of this coverity issue?

regards,
Harsh

On 10/27/25 18:44, Peter Maydell wrote:
> On Thu, 23 Oct 2025 at 13:22, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> We generate a flattened device tree programmatically for VOF. Change
>> this to load the static parts from a device tree blob and only
>> generate the parts that depend on run time conditions such as CPU
>> type, memory size and PCI devices. Moving the static parts in a dts
>> makes the board code simpler and more generic.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Link: https://lore.kernel.org/qemu-devel/383891fc2696609b27d2de9773efe1b4f493e333.1761176219.git.balaton@eik.bme.hu
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> Hi; Coverity points out (CID 1642027) that this change
> accidentally introduces a memory leak:
> 
>> @@ -780,7 +675,10 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
>>                                        pci_get_word(&d->config[PCI_VENDOR_ID]),
>>                                        pci_get_word(&d->config[PCI_DEVICE_ID]));
>>
>> -    if (pci_get_word(&d->config[PCI_CLASS_DEVICE])  ==
>> +    if (!strcmp(pn, "pci1106,8231")) {
>> +        return; /* ISA bridge and devices are included in dtb */
>> +    }
> 
> In this function we define at the top:
>      GString *node = g_string_new(NULL);
> 
> This change introduces an early-return which does not free
> the GString.
> 
> The simplest fix is probably to declare node as
>     g_autoptr(GString) node = g_string_new(NULL);
> 
> and delete the now-superfluous g_string_free() from the
> bottom of the function.
> 
> thanks
> -- PMM

