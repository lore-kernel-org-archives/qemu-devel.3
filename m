Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEA8EF8FEF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnK1-00039X-Ki; Wed, 04 Mar 2026 09:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxnJy-00039F-DH; Wed, 04 Mar 2026 09:35:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxnJw-0002UV-Tl; Wed, 04 Mar 2026 09:35:30 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6248xfTZ859950; Wed, 4 Mar 2026 14:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dr8o+F
 ukLEPJWFlLEL9kN2SrtH1Z7PVub1hER9vDfeo=; b=D9z5Z8POb0vv/PrDACvuip
 EHdJmBzdLfYiywSeVjbbCjr+4oPpevudr9im9uIJnMVBvxC75XhoTuNbyYIGCZn7
 t9G8pwpkgnKZET/x3utGL+6/BpMKatX9V5OimbPvfvmbKehIq31wLJ4oG1lTXBdh
 bjVYpJlMqrQUvel9AkqMcQzR/bTUlly02S/V9/taMJ3bOCvJ+iO5uY7cIk3O48jx
 wPd2yshKLAhNclmuhS32C+Vi6hp+aGQGT7xmqCv/tz2zurde/3uwE2V0pBeE9wx8
 kw3C6YAEM2Tyu6NVclVRnm9AHJsWoZtD6ABDreJfi/f5U4Kz4ExqQpEdIjZT5JAQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbya59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 14:35:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624Baw6K027658;
 Wed, 4 Mar 2026 14:35:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjerq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 14:35:25 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 624EZ2MV17564390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 14:35:02 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37AC258058;
 Wed,  4 Mar 2026 14:35:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 482A25805B;
 Wed,  4 Mar 2026 14:35:23 +0000 (GMT)
Received: from [9.61.180.105] (unknown [9.61.180.105])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Mar 2026 14:35:23 +0000 (GMT)
Message-ID: <4dde1725-1f80-426a-837b-ba5500e7d820@linux.ibm.com>
Date: Wed, 4 Mar 2026 09:35:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] pc-bios/s390-ccw: Introduce PCI device
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-11-jrossi@linux.ibm.com>
 <b88f3358-2c15-4430-8263-d4538df8e2be@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <b88f3358-2c15-4430-8263-d4538df8e2be@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IWt_a2pCaYoIt4AbdNqhla5D9eSXbkHk
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a8432e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8caY_EQD-FUNGMuDqdsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDExNCBTYWx0ZWRfXz0vbVQXsLV9X
 bKxkIPa7WSNc2H+si2wpdUEEqOp9ZBTQFvuoB9ufgjiizsAz/t3jKcDiy390MMJPhjkHsrCxe8k
 G4UmWcm9llECAg1MYEY8JQe0/YIzQyS5RoCBSJBUu9uovb7sk5l/OSZ8vx5f+Yj2qJcY0sdDrZk
 kb+EEN8qCkeqzoYjsGySlWdFARm5zOYrauT4pJsVf5flkMBWCH2/fWhPpE9g3ntZXrufqF04jYu
 zqKyn/kzp40dIRLIpEp8Fhp2a0fzF+DSFiLm7kTio6NKp1fAujWkbMaqSJelcIZ1Wwda69yQluR
 NkRuwV1xC4H6qbiW7Oj0NtKO364ftxGzkw+5vLRZZytrxrHUphYfcsCQTo3DZkJV567XWSAOXss
 D7LiNgYjsQ6RUghAxu8JPJ6m5jg2VltGqXGK6mEQk7g3tmKPaTLSlM7PAnRMYTW3DoIvuEfqRNu
 2d8w3oy1YZzEP355lfw==
X-Proofpoint-GUID: IWt_a2pCaYoIt4AbdNqhla5D9eSXbkHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


> ...
>> +}
>> +
>> +int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void 
>> *buf,
>> +             uint8_t len)
>> +{
>> +    uint64_t req, data;
>> +    uint8_t status;
>> +    int rc;
>> +
>> +    req = ZPCI_CREATE_REQ(fhandle, pcias, len);
>> +    rc = pcilg(&data, req, offset, &status);
>> +
>> +    /* Error condition detected */
>> +    if (rc != 0) {
>> +        printf("PCI load failed with status condition %d, return 
>> code %d\n",
>> +               status, rc);
>> +        return -1;
>> +    }
>> +
>> +    switch (len) {
>> +    case 1:
>> +        *(uint8_t *)buf = data;
>> +        break;
>> +    case 2:
>> +        *(uint16_t *)buf = data;
>> +        break;
>> +    case 4:
>> +        *(uint32_t *)buf = data;
>> +        break;
>> +    case 8:
>> +        *(uint64_t *)buf = data;
>> +        break;
>> +    default:
>> +        return -1;
>> +    }
>> +
>> +    return rc ? -1 : 0;
>
> dito, you checked for rc != 0 already earlier in this function.

My bad.  The previous version didn't check "rc != 0" but when I modified 
the status/error message I forgot that it made the later check 
redundant.  I'll fix it.

Thanks,
Jared Rossi


