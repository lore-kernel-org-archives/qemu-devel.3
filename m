Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FABED5C0F1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RD7-0003C7-Bw; Fri, 08 Nov 2024 10:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1t9RCo-0002qH-B6; Fri, 08 Nov 2024 10:47:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1t9RCl-0006Iy-D7; Fri, 08 Nov 2024 10:47:25 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8F5J2i008616;
 Fri, 8 Nov 2024 15:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gZ+2+z
 ofVNkvefmRHYR2PlIb/r+LTQ5WuMtHingiU6c=; b=g/Sr7Yl1SjVNLsoWQAx5Pn
 YyS4NYE4Qpoff0nUav7YLRt2BVCPtAqB1wPBw2vZQw4/j3eNDiH3OiASVJHgPkLi
 p9y/rYk3P8bPEO70oeqN76thF2YEoK6kFzZWdbhl37LOACwIRchcJwgR7P7+J1We
 t6mvo6BW97TLQGICPgHCYpJ4yr4kDoOhDORvLjsgF4G95z4btyZZACG64WyhRnJ3
 iNWS1g3LaNE8u6f0Affl+1VCHSu+CzaVLl7hRlUDxURT7673VYYOqnz1YxxGezK1
 E0OPeUuY27Y1fGQv7l0U0RrkVxKh8xUXDiaHV1i10OeFaNQuTdi08K5BUk/07htQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42smkxgegm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Nov 2024 15:47:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8FOb7o023916;
 Fri, 8 Nov 2024 15:47:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxt0bcr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Nov 2024 15:47:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A8FlBX125887378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Nov 2024 15:47:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6439158065;
 Fri,  8 Nov 2024 15:47:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01CE658052;
 Fri,  8 Nov 2024 15:47:11 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Nov 2024 15:47:10 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 08 Nov 2024 09:47:10 -0600
From: dan tan <dantan@linux.ibm.com>
To: undisclosed-recipients:;
Subject: Re: [PATCH v6 1/3] tpm/tpm_tis_spi: Support TPM for SPI (Serial
 Peripheral Interface)
In-Reply-To: <c54deb74-b5b4-44f2-bc6b-b514ac0a2356@linux.ibm.com>
References: <20241104171815.13853-1-dantan@linux.vnet.ibm.com>
 <20241104171815.13853-2-dantan@linux.vnet.ibm.com>
 <c54deb74-b5b4-44f2-bc6b-b514ac0a2356@linux.ibm.com>
Message-ID: <3512b243c0a4e0807ca15c81928ab21e@linux.ibm.com>
X-Sender: dantan@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DE1Vz0JvEQMGTTRf-GbPGVkaOSX9v178
X-Proofpoint-GUID: DE1Vz0JvEQMGTTRf-GbPGVkaOSX9v178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411080130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=dantan@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Good point, Stefan!

Let me put it through our CI tests, which, in addition to unit tests, 
also does both Linux (rhel-9) and AIX (ver7) boot exercises

thank you,
---
dan tan
power simulation
phone:+1.7373.099.138
email:dantan@linux.ibm.com


On 2024-11-08 09:38, Stefan Berger wrote:
> On 11/4/24 12:18 PM, dan tan wrote:
>> Implement support for TPM via SPI interface. The SPI bus master
>> is provided by PowerNV SPI device which is an SSI peripheral.
>> It can uses the tpm_emulator driver backend with the external
>> swtpm.
>> 
>> Signed-off-by: dan tan <dantan@linux.ibm.com>
>> ---
>> 
> 
>> diff --git a/hw/tpm/tpm_tis_spi.c b/hw/tpm/tpm_tis_spi.c
>> new file mode 100644
>> index 0000000000..079972de03
>> --- /dev/null
>> +++ b/hw/tpm/tpm_tis_spi.c
>> @@ -0,0 +1,357 @@
>> +/*
>> + * QEMU SPI TPM 2.0 model
>> + *
>> + * Copyright (c) 2024, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/acpi/tpm.h"
>> +#include "tpm_prop.h"
>> +#include "qemu/log.h"
>> +#include "trace.h"
>> +#include "tpm_tis.h"
>> +#include "hw/ssi/ssi.h"
>> +#include "migration/vmstate.h"
>> +
>> +typedef struct TPMStateSPI {
>> +    /*< private >*/
>> +    SSIPeripheral parent_object;
>> +
>> +    uint8_t     byte_offset;     /* byte offset in transfer */
>> +    uint8_t     wait_state_cnt;  /* wait state counter */
> 
> #define NUM_WAIT_STATES 1
> 
> Are 4 wait states actually needed? I ran the test with 1. More wait
> states just have impact on performance and I don't think we need to be
> emulating the real hardware entirely.
> 
> @@ -236,9 +237,9 @@ static uint32_t tpm_tis_spi_transfer(SSIPeripheral
> *ss, uint32_t tx)
>              trace_tpm_tis_spi_transfer_addr("reg_addr", 
> spist->reg_addr);
>              break;
>          default:    /* data bytes */
> -            if (spist->wait_state_cnt < 4) {
> +            if (spist->wait_state_cnt < NUM_WAIT_STATES) {
>                  spist->wait_state_cnt++;
> -                if (spist->wait_state_cnt == 4) {
> +                if (spist->wait_state_cnt == NUM_WAIT_STATES) {
>                      trace_tpm_tis_spi_transfer_data("wait complete, 
> count",
>  spist->wait_state_cnt);
>                      rx = rx | (0x01 << (24 - offset * 8));
> @@ -274,7 +275,8 @@ static uint32_t tpm_tis_spi_transfer(SSIPeripheral
> *ss, uint32_t tx)
>              }
>              break;
>          }
> -        if ((spist->wait_state_cnt == 0) || (spist->wait_state_cnt == 
> 4)) {
> +        if ((spist->wait_state_cnt == 0) ||
> +            (spist->wait_state_cnt == NUM_WAIT_STATES)) {
>              offset++;
>              spist->byte_offset++;
>          } else {

