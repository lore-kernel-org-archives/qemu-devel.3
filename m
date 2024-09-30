Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0540CE8347
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGls-0008SI-Qn; Mon, 30 Sep 2024 09:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGlr-0008RI-Ec; Mon, 30 Sep 2024 09:49:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svGlp-000469-Tl; Mon, 30 Sep 2024 09:49:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U6vYtF013463;
 Mon, 30 Sep 2024 13:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=j
 Jd+GiEKM/Gl83+VkisxrInYcg7kD+Ogv2+Ftu37fvk=; b=bSnFrYtDYk3xG/8rP
 cPpuB4QBnQV3CdQdccKwWiQ1A9O3FO3AH/RskRaUlyj+/GqdvPxDxvWawmeIXD10
 mtpu7CkmHWdCRXB/ZkLrLc1sYqMq0Lsl1h3G082cEhnOWdssh3f02326kOXDbSDe
 b+koPimpUbqYjvolE5Zhj2iNPuL2VNFILvYpze0w1a274LYV+lGp6Cz+D8U9Prtx
 bMlHao6tVuD9VcvGJ9xdaPIsJsrKPkW84wrH2Wvyg8oM4DZhJeM0f3e7ZzkByPpu
 k435KPUqN9FzUARh63kmG3BjlB3CmVBeOdYfVaVcpye/Jv0XEQ+sdSZac2JsD/j0
 dponw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb258x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:49:00 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UDmxu6032315;
 Mon, 30 Sep 2024 13:48:59 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9hb258r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:48:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UC7XQX013030;
 Mon, 30 Sep 2024 13:48:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbj6jad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 13:48:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UDmvIj42205854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 13:48:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFED858059;
 Mon, 30 Sep 2024 13:48:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 652AF58057;
 Mon, 30 Sep 2024 13:48:57 +0000 (GMT)
Received: from [9.61.73.98] (unknown [9.61.73.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2024 13:48:57 +0000 (GMT)
Message-ID: <19b1ff43-49c0-47cb-be4a-30365693c515@linux.ibm.com>
Date: Mon, 30 Sep 2024 09:48:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] pc-bios/s390x: Enable multi-device boot loop
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-18-jrossi@linux.ibm.com>
 <344b4f1b-8d51-4e32-8d9b-88bc71b0d3bd@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <344b4f1b-8d51-4e32-8d9b-88bc71b0d3bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CL6YiccxkbDWWyZmgMyuK_79AFr2crvc
X-Proofpoint-ORIG-GUID: uJB9FctrWWOTCLtgq7E3ksBxuMq7s3Ny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300098
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 9/30/24 8:32 AM, Thomas Huth wrote:
> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>>   -/*
>> - * No boot device has been specified, so we have to scan through the
>> - * channels to find one.
>> - */
>> -static void probe_boot_device(void)
>> -{
>> -    int ssid, sch_no, ret;
>> -
>> -    for (ssid = 0; ssid < 0x3; ssid++) {
>> -        blk_schid.ssid = ssid;
>> -        for (sch_no = 0; sch_no < 0x10000; sch_no++) {
>> -            ret = is_dev_possibly_bootable(-1, sch_no);
>> -            if (ret < 0) {
>> -                break;
>> -            }
>> -            if (ret == true) {
>> -                ipl_boot_device(); /* Only returns if unsuccessful */
>> -                return;
>> -            }
>> -        }
>> -    }
>> -
>> -    puts("Could not find a suitable boot device (none specified)");
>> -}
>> -
>>
> ...
>
> Can we please keep the possibility to boot from any device (i.e. the 
> probe_boot_device() stuff), in case the user did not specify any boot 
> index property at all?
>
>  Thanks,
>   Thomas
>

Yes, I’ll restore it.

Jared Rossi

