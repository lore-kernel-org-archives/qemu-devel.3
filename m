Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BFACAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 18:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2DRD-0004VC-Pv; Fri, 26 Sep 2025 14:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v2DR3-0004Sf-26; Fri, 26 Sep 2025 14:44:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v2DQr-0004Ex-QD; Fri, 26 Sep 2025 14:44:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QGPkGt028993;
 Fri, 26 Sep 2025 18:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ScHnOx
 9JQXctBK1q4LFO7n1IrA2JhOZ45/YRNj0QswA=; b=H7cJHFE96f7LTa7/jfH2pd
 Z6RrvFn55orduiqsYZU3zDha3GE/baP/Vqn7RGWHEYm9A4I3VOatwV3agCIdYh2B
 IyrJIfv0dZ2I882gOcbanuJSXPp0yhhxhOKk3lzy5xJxXyWV3eEcnqcgidKdd4AD
 VDsmUv3X3wbtfcoszGstK1Wkd8EWfJ+7AmX52YmFs4Hr8p07us7uJEy2Jr5CUsQn
 AR7Fve9PzEED32+bOJTioqREvGt4xxXbI3dF/5iHhGRjSvkd4DxvwBaw2kgQ2YkY
 UVRVmGafQrBqfaKTAm8W0zMTfUgAbwXRGSij3E2DK/HR/JPOpQIqXGGrSWTeKjnA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbbbpnwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Sep 2025 18:44:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58QHSAf5014323;
 Fri, 26 Sep 2025 18:44:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawm5prj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Sep 2025 18:44:25 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58QIiOcd33554746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 18:44:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B59CE58054;
 Fri, 26 Sep 2025 18:44:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0090F5804E;
 Fri, 26 Sep 2025 18:44:24 +0000 (GMT)
Received: from [9.61.249.51] (unknown [9.61.249.51])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Sep 2025 18:44:23 +0000 (GMT)
Message-ID: <b7dd06f1-f00a-45b0-b43a-dc8d25ec1e46@linux.ibm.com>
Date: Fri, 26 Sep 2025 11:44:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mjrosato@linux.ibm.com,
 thuth@redhat.com, alex.williamson@redhat.com
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com> <87qzvtstd7.fsf@pond.sub.org>
 <1b384231-fe7a-4f13-a30e-2c8c1b9f1563@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <1b384231-fe7a-4f13-a30e-2c8c1b9f1563@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cHXOYWPbEYsPOQ51HmzymE6tqCpX2Vd4
X-Authority-Analysis: v=2.4 cv=LakxKzfi c=1 sm=1 tr=0 ts=68d6df0a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=eIN5sIIRehRY17YpvvgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: cHXOYWPbEYsPOQ51HmzymE6tqCpX2Vd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX1WLqCkss6tDC
 3iOaWM0qRxmxr0Wz9c21dfjLn+HS9t+c7ecJssSbjLqG1ogXUvEUAkUesuwsKLdoCvRMszIkpUk
 i+6wiRSjUYCGOA/pJgNNsflCqQzDiTcf4oi5jyW3wxknUkU8ZNonDGI7LpAPA3Sz281GueB+68b
 qr3xBWyrgJMrddveAeZv3wNQCGbk/gjmgbJ/r8DiofHUSMWlXvxeHTh8nNjC5NhV7jHLmJHDcVd
 aU6g7EEBbqD3FXSSSFhrGK+5gaVaI8wrzgUaj/lvxqafVge9/pb1QHjf2ISJetoyOhatWkBhJIf
 FDY+WFIHZ6+fYOen4Zm502+R7K5IBxe5dhD+LNwoBKuQ+36MBScxM0+xo8wEjWkgoEQSkw0wYho
 J1Doy9BIOopUhDJRf1mu8EvJZUhTvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_06,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 9/26/2025 12:40 AM, Cédric Le Goater wrote:
> On 9/26/25 06:57, Markus Armbruster wrote:
>> Farhan Ali <alifm@linux.ibm.com> writes:
>>
>>> Provide a vfio error handling callback, that can be used by devices to
>>> handle PCI errors for passthrough devices.
>>>
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   hw/vfio/pci.c | 8 ++++++++
>>>   hw/vfio/pci.h | 1 +
>>>   2 files changed, 9 insertions(+)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index bc0b4c4d56..b02a974954 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>>   static void vfio_err_notifier_handler(void *opaque)
>>>   {
>>>       VFIOPCIDevice *vdev = opaque;
>>> +    Error *err = NULL;
>>>         if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>           return;
>>>       }
>>>   +    if (vdev->err_handler) {
>>> +        if (vdev->err_handler(vdev, &err)) {
>>> +            return;
>>> +        }
>>> +        error_report_err(err);
>>> +    }
>>
>> This is unusual.
>
> and the compiler complains :
>
> ../hw/vfio/pci.c: In function ‘vfio_err_notifier_handler’:
> ../hw/vfio/pci.c:3076:9: error: dangling pointer to ‘err’ may be used 
> [-Werror=dangling-pointer=]
>  3076 |         error_report_err(err);
>       |         ^~~~~~~~~~~~~~~~~~~~~
> ../hw/vfio/pci.c:3066:12: note: ‘err’ declared here
>  3066 |     Error *err = NULL;
>       |            ^~~
> cc1: all warnings being treated as errors
>
>
> C.

Compiling on s390x didn't cause this compiler error, but indeed 
compiling on x86 it did.

Thanks
Farhan


>
>
>>
>> Functions taking an Error ** argument usually do so to report errors.
>> The rules spelled out in qapi/error.h apply.  In particular:
>>
>>   * - On success, the function should not touch *errp.  On failure, it
>>   *   should set a new error, e.g. with error_setg(errp, ...), or
>>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>   *
>>   * - Whenever practical, also return a value that indicates success /
>>   *   failure.  This can make the error checking more concise, and can
>>   *   avoid useless error object creation and destruction.  Note that
>>   *   we still have many functions returning void.  We recommend
>>   *   • bool-valued functions return true on success / false on failure,
>>
>> If ->err_handler() behaved that way, it @err would be null after it
>> returns false.  We'd call error_report_err(NULL), and crash.
>>
>> Functions with unusual behavior need a contract: a comment spelling out
>> their behavior.
>>
>> What is the intended behavior of the err_handler() callback?
>>
>>> +
>>>       /*
>>>        * TBD. Retrieve the error details and decide what action
>>>        * needs to be taken. One of the actions could be to pass
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index e0aef82a89..faadce487c 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -146,6 +146,7 @@ struct VFIOPCIDevice {
>>>       EventNotifier err_notifier;
>>>       EventNotifier req_notifier;
>>>       int (*resetfn)(struct VFIOPCIDevice *);
>>> +    bool (*err_handler)(struct VFIOPCIDevice *, Error **);
>>>       uint32_t vendor_id;
>>>       uint32_t device_id;
>>>       uint32_t sub_vendor_id;
>>
>
>

