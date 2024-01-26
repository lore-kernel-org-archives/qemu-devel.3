Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD436C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 10:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTJSm-0002d4-Tz; Fri, 26 Jan 2024 05:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTJSk-0002cL-3x; Fri, 26 Jan 2024 05:29:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTJSi-0003Dq-Aj; Fri, 26 Jan 2024 05:29:29 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40Q85rn6006782; Fri, 26 Jan 2024 10:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9AVV3gY0n8mg8oeX8eDJdhxe+he3fWMtz9jSbUaYEaQ=;
 b=ZmeqbR7+/U9OvJmYOV9jpqZbx99ZaFYYftDs+Fl9CmOX8mdfW2bJJlXvOeD3yXo4c+EU
 nXkXvHazdEnMqc4KdREsJRoBnORXUYUjNGztLPQdue6OmQqqUXpaRm8fHP9Z7aJENFdQ
 JK2xD6CwSuXf9oFMnFehbk3ZCgYscpSnB44IBL2A+9LtzrxrYfLlqVhYJOmj6th00P3c
 ADx9G/lfFsk9fgFjq08H7j7Qv8CYAdWqmbqVPG4kh0qHATlZiHb8JV1qR2dkJuafHssE
 64EKES/lNIX5pB6y7xtG+skGqss2UH4ZHbzm1B6WD3OrMeA6AqLuwIhq7htS2YKT4u9o +w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv89sv1us-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 10:29:12 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40QAS2UD015020;
 Fri, 26 Jan 2024 10:29:11 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv89sv1tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 10:29:11 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40QA2sqM026876; Fri, 26 Jan 2024 10:29:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgttfkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 10:29:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40QATAN149283478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jan 2024 10:29:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9A2E58054;
 Fri, 26 Jan 2024 10:29:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F32025805A;
 Fri, 26 Jan 2024 10:29:08 +0000 (GMT)
Received: from [9.61.160.70] (unknown [9.61.160.70])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jan 2024 10:29:08 +0000 (GMT)
Message-ID: <15cd2acb-9467-4b50-9ef5-5b2e705b7091@linux.ibm.com>
Date: Fri, 26 Jan 2024 04:29:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/11] hw/fsi: Added FSI documentation
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20240126034026.31068-1-ninad@linux.ibm.com>
 <20240126034026.31068-11-ninad@linux.ibm.com>
 <03fca693-5ade-401e-a7a2-49872ac3854b@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <03fca693-5ade-401e-a7a2-49872ac3854b@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MmwFzsxgaRRZYtzLWvpSafXHxp9WEtHV
X-Proofpoint-ORIG-GUID: UIoV99302p6_2rsmftkK30U3J8g3v0kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 bulkscore=0 mlxlogscore=488 priorityscore=1501 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401260076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Cedric,

>> +QEMU files related to FSI interface:
>> + - ``hw/fsi/aspeed-apb2opb.c``
>> + - ``include/hw/fsi/aspeed-apb2opb.h``
>> + - ``hw/fsi/opb.c``
>> + - ``include/hw/fsi/opb.h``
>> + - ``hw/fsi/fsi.c``
>> + - ``include/hw/fsi/fsi.h``
>> + - ``hw/fsi/fsi-master.c``
>> + - ``include/hw/fsi/fsi-master.h``
>> + - ``hw/fsi/fsi-slave.c``
>> + - ``include/hw/fsi/fsi-slave.h``
>> + - ``hw/fsi/cfam.c``
>> + - ``include/hw/fsi/cfam.h``
>> + - ``hw/fsi/engine-scratchpad.c``
>> + - ``include/hw/fsi/engine-scratchpad.h``
>> + - ``include/hw/fsi/lbus.h``
>
> Please remove the file list above.
Removed files and listed only directories so that people can easily find 
the code.
>
>> +The following commands start the rainier machine with built-in FSI 
>> model.
>
> rainier -> ``rainier-bmc``
Replaced it.
>
>> +There are no model specific arguments.
> I would also add a reference to the docs/system/arm/aspeed.rst page.

Added the reference.

Thanks for the review.

Regards,

Ninad


