Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEFECEFC3A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syEvh-0000gF-P6; Tue, 08 Oct 2024 14:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syEvc-0000fl-6C; Tue, 08 Oct 2024 14:27:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1syEvZ-00085f-IU; Tue, 08 Oct 2024 14:27:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498ILVaj015516;
 Tue, 8 Oct 2024 18:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=a
 uA9kJFoi6NaWO1pKJCEnJqugAuoVcDLAGcXgc/IVVg=; b=DMsfeAKbyh1HD9mDD
 OuCRItwntk15Y2MhRtlEViT63VOSXo0JmkCRUa4Q5wwsFdnlHfwen56wo/BItN98
 WEy4om1JwdXUG4hQOWQqQJClPKOQ4N8aQHSVBqPyM4TQKQdjHsN8b/G6iAF9MtDo
 kQ7WSawxCZEhDMIvZxhjMqFL3puwS38zEiR6f8LfaOU3a46S4hWG0ixVLmzAlqJ0
 +VmB96hhuoqIfKdsDMbAXNIAdvlM+0k9g0/mwv5jtEfDS8RcWbIgN1IeCjlw2Eo6
 gUuXPZxF1a4rYupq6rQ6RFho0JftRc8xcIcZBZhMaXqbmnyJetS4fAojWhvh273o
 /1OBA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4259xar10a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 18:27:19 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498IRJ29028719;
 Tue, 8 Oct 2024 18:27:19 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4259xar104-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 18:27:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498H0soB022861;
 Tue, 8 Oct 2024 18:27:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0wmk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 18:27:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 498IRHpP41746744
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 18:27:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA6445805C;
 Tue,  8 Oct 2024 18:27:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B4415805D;
 Tue,  8 Oct 2024 18:27:17 +0000 (GMT)
Received: from [9.61.79.151] (unknown [9.61.79.151])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Oct 2024 18:27:17 +0000 (GMT)
Message-ID: <5728799c-3c12-405c-ba96-af4b70e180b6@linux.ibm.com>
Date: Tue, 8 Oct 2024 14:27:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/19] pc-bios/s390x: Enable multi-device boot loop
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
 <20241008011552.2645520-18-jrossi@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20241008011552.2645520-18-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jjAhwb0f1TV6Rk-6WaC0p3bpuwuFJlu0
X-Proofpoint-GUID: JI13RcifjNAKWI4F45xyGaTAIXv1bZIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_16,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 10/7/24 9:15 PM, jrossi@linux.ibm.com wrote:
> [snip...]
>
>       switch (vdev->senseid.cu_model) {
>       case VIRTIO_ID_NET:
>           puts("Network boot device detected");
> @@ -271,11 +275,9 @@ static void ipl_boot_device(void)
>           dasd_ipl(blk_schid, cutype);
>           break;
>       case CU_TYPE_VIRTIO:
> -        if (virtio_setup()) {
> -            return;    /* Only returns in case of errors */
> +        if (virtio_setup() == 0) {
> +            zipl_load();
>           }
> -        zipl_load();
> -        break;
>       default:
>           printf("Attempting to boot from unexpected device type 0x%X", cutype);
>       }
>
> [snip...]
A small mistake I found after posting is that the break is missing after
zipl_load(). This causes the "unexpected device type" message to print after
a failed virtio IPL, but it is fixed simply by not removing the break 
and will
be will be corrected in the next version.

