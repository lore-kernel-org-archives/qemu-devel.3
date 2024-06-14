Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FE0C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 12:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI60E-0001P5-Cf; Fri, 14 Jun 2024 08:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sI60C-0001OC-Je; Fri, 14 Jun 2024 08:25:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sI60A-0006fF-Dv; Fri, 14 Jun 2024 08:25:56 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EC6BZZ005017;
 Fri, 14 Jun 2024 12:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=6
 viIaOcaVme5NKyCLSpR9y4eRUM7VZiReg8xGRGEbFI=; b=Jf/BWKzuvs333mB0W
 cfPW84jM/IFhmaqczK/1boO65iOiOpHh0FxRNfxUp4RV5+W2Omv0U29zkgnVu6CY
 P1vmOGGTqDW06C9rJFR0JviofQObVJoysSdRqp39krP3dQyz9tPVyVotkbVJDzBx
 oPWTa58NDlOZS/DLaa2cIFwkmV6yF2vXpBlWOKzK32seODZ24bZKwsbvYzdWGlvp
 0RPEpsPrwxwqGD4lmWwxqA3KaAfZ391AgdmCi/RKkkMVntEwq+D/ZSKs17MXJxx9
 7oezq16qPF1iKXIQk+ckTCB3zZwW3P45cU172WmXxvERL+SGJuxXiV4Lh4L7Qdkn
 ISpWQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrn15g479-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 12:25:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45ECPhmL001476;
 Fri, 14 Jun 2024 12:25:43 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrn15g44y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 12:25:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45ECD2C9028690; Fri, 14 Jun 2024 12:23:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn1mv1m09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 12:23:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45ECNE6747644980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2024 12:23:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EACCA20043;
 Fri, 14 Jun 2024 12:23:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 157E020040;
 Fri, 14 Jun 2024 12:23:11 +0000 (GMT)
Received: from [9.43.14.142] (unknown [9.43.14.142])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2024 12:23:10 +0000 (GMT)
Message-ID: <0d3b4ece-a41e-4108-843d-067d56f3eff2@linux.ibm.com>
Date: Fri, 14 Jun 2024 17:53:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ppc/pnv: Add SPI controller model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
 <20240515174149.17713-2-chalapathi.v@linux.ibm.com>
 <a671f38a-f7b0-433d-b016-a024964be8be@kaod.org>
 <38161823-19d4-4cd1-b85b-33b9beadb56b@linux.ibm.com>
 <ceefb013-7e8a-47ae-9450-2601db9872aa@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <ceefb013-7e8a-47ae-9450-2601db9872aa@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O3QxuIH_ecKib5CsgOfVvjrXL9YNbgCG
X-Proofpoint-GUID: bYi59NQWrpn20yB9A_nhbengqm3_4Bsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=662 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140085
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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


On 14-06-2024 16:57, Cédric Le Goater wrote:
> On 6/13/24 3:45 PM, Chalapathi V wrote:
>>
>> On 20-05-2024 11:19, Cédric Le Goater wrote:
>>> On 5/15/24 19:41, Chalapathi V wrote:
>>>> SPI controller device model supports a connection to a single SPI 
>>>> responder.
>>>> This provide access to SPI seeproms, TPM, flash device and an ADC 
>>>> controller.
>>>>
>>>> All SPI function control is mapped into the SPI register space to 
>>>> enable full
>>>> control by firmware. In this commit SPI configuration component is 
>>>> modelled
>>>> which contains all SPI configuration and status registers as well 
>>>> as the hold
>>>> registers for data to be sent or having been received.
>>>>
>>>> An existing QEMU SSI framework is used and SSI_BUS is created.
>>>>
>>>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>>>> ---
>>>>   include/hw/ppc/pnv_xscom.h    |   3 +
>>>>   include/hw/ssi/pnv_spi.h      |  44 +++++++
>>>>   include/hw/ssi/pnv_spi_regs.h | 114 +++++++++++++++++
>>>>   hw/ppc/pnv_spi_controller.c   | 228 
>>>> ++++++++++++++++++++++++++++++++++
>>>
>>> The file names are not consistent.
>>>
>>> Please rename hw/ppc/pnv_spi_controller.c to /hw/ssi/pnv_spi.c.
>>
>> Hello Cedric,
>>
>> I could not compile hw/ssi/pnv_spi.c because of target specific code.
>>
>> /FAILED: libcommon.fa.p/hw_ssi_pnv_spi.c.o
>> cc -m64 -mcx16 -Ilibcommon.fa.p -I/usr/include/p11-kit-1 
>> -I/usr/include/pixman-1 -I/usr/include/glib-2.0 
>> -I/usr/lib64/glib-2.0/include -I/usr/include/gio-unix-2.0/ 
>> -I/usr/include/slirp -fdiagnostics-color=auto -Wall -Winvalid-pch 
>> -Werror -std=gnu11 -O2 -g -fstack-protector-strong -Wundef 
>> -Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes 
>> -Wredundant-decls -Wold-style-declaration -Wold-style-definition 
>> -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self 
>> -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels 
>> -Wexpansion-to-defined -Wimplicit-fallthrough=2 
>> -Wmissing-format-attribute -Wno-missing-include-dirs 
>> -Wno-shift-negative-value -Wno-psabi -isystem 
>> <qemu_dir>/linux-headers -isystem linux-headers -iquote . -iquote 
>> <qemu_dir> -iquote <<qemu_dir>>/include 
>> -iquote <qemu_dir>/host/include/x86_64 
>> -iquote <qemu_dir>/host/include/generic -iquote <qemu_dir>/tcg/i386 
>> -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
>> -fno-strict-aliasing -fno-common -fwrapv -fPIE -MD -MQ 
>> libcommon.fa.p/hw_ssi_pnv_spi.c.o -MF 
>> libcommon.fa.p/hw_ssi_pnv_spi.c.o.d -o 
>> libcommon.fa.p/hw_ssi_pnv_spi.c.o -c ../hw/ssi/pnv_spi.c
>> In file included from <qemu_dir>/target/ppc/cpu.h:25,
>> from <qemu_dir>/include/hw/ppc/pnv.h:24,
>> from <qemu_dir>/include/hw/ppc/pnv_xscom.h:24,
>>                   from ../hw/ssi/pnv_spi.c:12:
>> <qemu_dir>/include/exec/cpu-defs.h:23:2: error: #error cpu.h included 
>> from common code
>>   #error cpu.h included from common code
>>    ^~~~~
>> In file included from /<qemu_dir>/target/ppc/cpu.h:25,
>> from <qemu_dir>/include/hw/ppc/pnv.h:24,
>> from <qemu_dir>/include/hw/ppc/pnv_xscom.h:24,
>>                   from ../hw/ssi/pnv_spi.c:12:
>> <qemu_dir>/include/exec/cpu-defs.h:34:10: fatal error: cpu-param.h: 
>> No such file or directory
>>   #include "cpu-param.h"
>>            ^~~~~~~~~~~~~
>> compilation terminated.
>> /
>>
>> Hence shall I keep pnv_spi.c in /hw/ppc/ ?
>
>
> Can't we "fix" pnv_xscom.h to be more friendly ? with forward 
> declarations
> of the Pnv* types ?
>
>
> Thanks,
>
> C.

Sure, Thank you for the suggestions, I will test and update the patch ASAP.

Thank You,

Chalapathi


