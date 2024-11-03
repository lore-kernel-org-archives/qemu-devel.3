Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C14E67819
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 00:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7OkW-0000y7-U7; Sat, 02 Nov 2024 20:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t7OkU-0000xm-Ny; Sat, 02 Nov 2024 20:45:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t7OkS-0007Yv-4D; Sat, 02 Nov 2024 20:45:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A30ABXv015100;
 Sun, 3 Nov 2024 00:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tHdvUL
 9FIWzMGCDQML+0/gqDGoJidspQygCHDCn5nRc=; b=clzk6w3wY4aX7F50jTIGVT
 pB93tdU8ak0zH5iOtUJpYTE/JDqCARrxNKH37s3U5bXRLYM6XKPXjACp80GP2KjC
 7aqhGIKisiMJzV6xedvBf63lQoEL+xDe5iMlCnzv2AMZ/mz6J4Qg9bIDmU7VeQOF
 ttb+wLSzG61vwMfSHFbguODARakLyMWxZkRiT3UAYSMU1Ahb3HLCPSi442qiPZ7V
 ESLEYMCtYFPXSpjcqhufAlpWixOYzrKUKzCv2O8kN7PidINCqpCvNDqtaN29W9G9
 ZQcYUKVje1CYl9d6bo7r5Dd4ZjGZxGerpaKDoNP7kG6ORU2rpPA+kcQbxqOg8DQA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42nxd2r29c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 03 Nov 2024 00:45:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A30bHwP023916;
 Sun, 3 Nov 2024 00:45:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsxg1hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 03 Nov 2024 00:45:33 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A30jWKs55181792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 3 Nov 2024 00:45:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6B7A5805E;
 Sun,  3 Nov 2024 00:45:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F98858052;
 Sun,  3 Nov 2024 00:45:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  3 Nov 2024 00:45:32 +0000 (GMT)
Message-ID: <1fe46f63-bf39-4ba3-aa25-f9573bc3e80d@linux.ibm.com>
Date: Sat, 2 Nov 2024 20:45:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tests/qtest/tpm: add unit test to tis-spi
From: Stefan Berger <stefanb@linux.ibm.com>
To: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org
References: <20241101202727.9023-1-dantan@linux.vnet.ibm.com>
 <20241101202727.9023-4-dantan@linux.vnet.ibm.com>
 <823dbf7d-f33b-4c3f-80fa-e4e9230166ee@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <823dbf7d-f33b-4c3f-80fa-e4e9230166ee@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z13dwn8HSF393kQUjzxd1UwN3gFT88-J
X-Proofpoint-GUID: Z13dwn8HSF393kQUjzxd1UwN3gFT88-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411030003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 11/2/24 10:01 AM, Stefan Berger wrote:
> 
> 
> On 11/1/24 4:27 PM, dan tan wrote:
>> Add qtest cases to exercise main TPM locality functionality
> 

> 
> 
> When running `ninja -C build test` I get this output that should have 
> its lines prefixed with '#' 'somehow':

'somehow' = add '-serial null' to the QEMU command line parameters

> 
>   42/424 qemu:qtest+qtest-ppc64 / qtest-ppc64/tpm-tis-spi-pnv-test 
>               OK               0.31s   5 subtests passed
> 
> stdout: 34: UNKNOWN: [    0.024173382,5] OPAL v7.1 starting...
> stdout: 35: UNKNOWN: [    0.024724739,7] initial console log level: 
> memory 7, driver 5
> stdout: 36: UNKNOWN: [    0.024778210,6] CPU: P10 generation processor 
> (max 4 threads/core)
> stdout: 37: UNKNOWN: [    0.024795001,7] CPU: Boot CPU PIR is 0x0000 PVR 
> is 0x00801200
> stdout: 38: UNKNOWN: [    0.024925108,7] OPAL table: 0x3018a960 .. 
> 0x3018af00, branch table: 0x30120000
> stdout: 39: UNKNOWN: [    0.025103930,7] Assigning physical memory map 
> table for p10
> stdout: 40: UNKNOWN: [    0.025411575,7] FDT: Parsing fdt @0x1000000
> stdout: 41: UNKNOWN: [    0.028505988,5] CHIP: Detected QEMU simulator
> stdout: 42: UNKNOWN: [    0.028683295,6] CHIP: Initialised chip 0 from 
> xscom@603fc00000000
> stdout: 43: UNKNOWN: [    0.029247139,6] P10 DD2.00 detected
> stdout: 44: UNKNOWN: [    0.029267261,5] CHIP: Chip ID 0000 type: P10 
> DD2.00
> stdout: 45: UNKNOWN: [    0.029276249,7] XSCOM: Base address: 
> 0x603fc00000000
> stdout: 46: UNKNOWN: [    0.029339220,7] XSTOP: ibm,sw-checkstop-fir 
> prop not found
> stdout: 47: UNKNOWN: [    0.029409300,6] MFSI 0:0: Initialized
> stdout: 48: UNKNOWN: [    0.029419734,6] MFSI 0:2: Initialized
> stdout: 49: UNKNOWN: [    0.029429173,6] MFSI 0:1: Initialized
> stdout: 50: UNKNOWN: [    0.030012352,6] LPC: LPC[000]: Initialized
> stdout: 51: UNKNOWN: [    0.030020186,7] LPC: access via MMIO 
> @0x6030000000000
> stdout: 52: UNKNOWN: [    0.030108378,7] LPC: Default bus on chip 0x0
> stdout: 53: UNKNOWN: [    0.030193313,7] CPU: New max PIR set to 0x7
> stdout: 54: UNKNOWN: [    0.030743076,7] MEM: parsing reserved memory 
> from reserved-names/-ranges properties
> stdout: 55: UNKNOWN: [    0.030828672,7] HOMER: Init chip 0
> stdout: 56: UNKNOWN: [    0.030862569,7]   PBA BAR0 : 0x0000300ffd800000
> stdout: 57: UNKNOWN: [    0.030870164,7]   PBA MASK0: 0x0000000000300000
> stdout: 58: UNKNOWN: [    0.030899260,7]   HOMER Image at 0x300ffd800000 
> size 4MB
> stdout: 59: UNKNOWN: [    0.030943460,4] HOMER image is not reserved! 
> Reserving
> stdout: 60: UNKNOWN: [    0.031114747,7]   PBA BAR2 : 0x0000300fff800000
> stdout: 61: UNKNOWN: [    0.031121980,7]   PBA MASK2: 0x0000000000700000
> stdout: 62: UNKNOWN: [    0.031136886,7]   OCC Common Area at 
> 0x300fff800000 size 8MB
> stdout: 63: UNKNOWN: [    0.031171139,4] OCC common area is not 
> reserved! Reserving
> stdout: 64: UNKNOWN: [    0.031231035,7] CPU: decrementer bits 56
> stdout: 65: UNKNOWN: [    0.031321664,6] CPU: CPU from DT PIR=0x0000 
> Server#=0x0 State=4
> stdout: 66: UNKNOWN: [    0.031427205,6] CPU:  1 secondary threads
> stdout: 67: UNKNOWN: [    0.031441159,6] CPU: CPU from DT PIR=0x0004 
> Server#=0x4 State=4
> stdout: 68: UNKNOWN: [    0.031459259,6] CPU:  1 secondary threads
> stdout: 69: UNKNOWN: [    0.033492258,5] PLAT: Using SuperIO UART
> stdout: 70: UNKNOWN: [    0.033826231,7] UART: Using LPC IRQ 4
> stdout: 71: UNKNOWN: [    0.036351187,5] PLAT: Detected QEMU POWER10 
> platform
> stdout: 72: UNKNOWN: [    0.036415869,5] PLAT: Detected BMC platform 
> ast2500:openbmc
> stdout: 73: UNKNOWN: [    0.037499517,5] XIVE: [ IC 00  ] Initializing 
> XIVE block ID 0...
> ERROR: Unknown TAP output lines for a supported TAP version.
> This is probably a bug in the test; if they are not TAP syntax, prefix 
> them with a #
> 
> 
> 


