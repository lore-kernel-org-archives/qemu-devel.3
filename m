Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEE4CEFC35
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 17:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syE72-00007g-LT; Tue, 08 Oct 2024 13:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1syE6x-0008Vz-6G; Tue, 08 Oct 2024 13:35:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1syE6v-0001l1-8G; Tue, 08 Oct 2024 13:35:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498FoVkg002888;
 Tue, 8 Oct 2024 17:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=T
 LkD5NvKnVhna51HTRjgn870rfQGWStCP5zJTDOOSfI=; b=Bf9nyeGboHJ/7kDye
 Py0y+/3WIdePtjdTtSJjXZwwmLrl1HO3vtUni1318bMJbFQtNw8SDr4I2znEvvLa
 KxicHSCMTUJwXnqg8LjILoi+Uezv76tew9Rt9juwKH4/3f595ThasIcNwJ8Yfz+F
 IM53ml80Vf8UMf863QjuCW+NzY8cIT9z6E3cl72pGcqExexVqSLU8ElTFTbnJkhW
 xHKfLYU6o4mkxKbFVFFrOrnFzICQUrCfxNRUFrUH9wnh9ci5rxFVJn5/sKxpnoI6
 I9IoX89im0xh/2Ve+spvIim1nmXL5QE8EgB0mz7bLpHrv6puAb3stXxSqNCCm4FX
 dWfEg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4257qp8m1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:34:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 498HVLXL009979;
 Tue, 8 Oct 2024 17:34:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4257qp8m1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:34:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 498FUhej011516;
 Tue, 8 Oct 2024 17:34:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xnu5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 17:34:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 498HYgTl42664348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 17:34:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E9EA2004B;
 Tue,  8 Oct 2024 17:34:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEBB620040;
 Tue,  8 Oct 2024 17:34:39 +0000 (GMT)
Received: from [9.43.109.153] (unknown [9.43.109.153])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 17:34:39 +0000 (GMT)
Message-ID: <2cb001a7-bf4d-469b-af66-f4a250238c11@linux.ibm.com>
Date: Tue, 8 Oct 2024 23:04:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/ssi/pnv_spi: Use local var seq_index instead of
 get_seq_index().
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, clg@kaod.org,
 calebs@linux.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
 <20240918165045.21298-4-chalapathi.v@linux.ibm.com>
 <D4Q9VWVTUFEG.WMMBR56BBTY5@gmail.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <D4Q9VWVTUFEG.WMMBR56BBTY5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MR0oosH2FfA-uC1A2MpJu2t3y7iY-gWv
X-Proofpoint-ORIG-GUID: 5YOeQ0mFRD6dwJmu56umbOWZXcF3XE4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_15,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxlogscore=618 clxscore=1015 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410080111
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


On 08-10-2024 13:43, Nicholas Piggin wrote:
> On Thu Sep 19, 2024 at 2:50 AM AEST, Chalapathi V wrote:
>> Use a local variable seq_index instead of repeatedly caling
>> get_seq_index() method.
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   hw/ssi/pnv_spi.c | 61 ++++++++++++++++++++++++------------------------
>>   1 file changed, 31 insertions(+), 30 deletions(-)
>>
>> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
>> index 2fd5aa0a96..962115f40f 100644
>> --- a/hw/ssi/pnv_spi.c
>> +++ b/hw/ssi/pnv_spi.c
>> @@ -210,15 +210,8 @@ static void transfer(PnvSpi *s)
>>       fifo8_reset(&s->rx_fifo);
>>   }
>>   
>> -static inline uint8_t get_seq_index(PnvSpi *s)
>> -{
>> -    return GETFIELD(SPI_STS_SEQ_INDEX, s->status);
>> -}
>> -
>>   static inline void next_sequencer_fsm(PnvSpi *s)
>>   {
>> -    uint8_t seq_index = get_seq_index(s);
>> -    s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, (seq_index + 1));
>>       s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_INDEX_INCREMENT);
>>   }
>>   
>> @@ -647,6 +640,7 @@ static void operation_sequencer(PnvSpi *s)
>>       bool stop = false; /* Flag to stop the sequencer */
>>       uint8_t opcode = 0;
>>       uint8_t masked_opcode = 0;
>> +    uint8_t seq_index;
>>   
>>       /*
>>        * Clear the sequencer FSM error bit - general_SPI_status[3]
>> @@ -660,12 +654,13 @@ static void operation_sequencer(PnvSpi *s)
>>       if (GETFIELD(SPI_STS_SEQ_FSM, s->status) == SEQ_STATE_IDLE) {
>>           s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, 0);
>>       }
>> +    seq_index = GETFIELD(SPI_STS_SEQ_INDEX, s->status);
>>       /*
>>        * There are only 8 possible operation IDs to iterate through though
>>        * some operations may cause more than one frame to be sequenced.
>>        */
>> -    while (get_seq_index(s) < NUM_SEQ_OPS) {
>> -        opcode = s->seq_op[get_seq_index(s)];
>> +    while (seq_index < NUM_SEQ_OPS) {
>> +        opcode = s->seq_op[seq_index];
>>           /* Set sequencer state to decode */
>>           s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_DECODE);
>>           /*
>> @@ -682,7 +677,7 @@ static void operation_sequencer(PnvSpi *s)
>>           case SEQ_OP_STOP:
>>               s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
>>               /* A stop operation in any position stops the sequencer */
>> -            trace_pnv_spi_sequencer_op("STOP", get_seq_index(s));
>> +            trace_pnv_spi_sequencer_op("STOP", seq_index);
>>   
>>               stop = true;
>>               s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_IDLE);
>> @@ -693,7 +688,7 @@ static void operation_sequencer(PnvSpi *s)
>>   
>>           case SEQ_OP_SELECT_SLAVE:
>>               s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
>> -            trace_pnv_spi_sequencer_op("SELECT_SLAVE", get_seq_index(s));
>> +            trace_pnv_spi_sequencer_op("SELECT_SLAVE", seq_index);
>>               /*
>>                * This device currently only supports a single responder
>>                * connection at position 0.  De-selecting a responder is fine
>> @@ -704,8 +699,7 @@ static void operation_sequencer(PnvSpi *s)
>>               if (s->responder_select == 0) {
>>                   trace_pnv_spi_shifter_done();
>>                   qemu_set_irq(s->cs_line[0], 1);
>> -                s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status,
>> -                                (get_seq_index(s) + 1));
>> +                seq_index++;
>>                   s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status, FSM_DONE);
>>               } else if (s->responder_select != 1) {
>>                   qemu_log_mask(LOG_GUEST_ERROR, "Slave selection other than 1 "
>> @@ -732,13 +726,14 @@ static void operation_sequencer(PnvSpi *s)
>>                    * applies once a valid responder select has occurred.
>>                    */
>>                   s->shift_n1_done = false;
>> +                seq_index++;
>>                   next_sequencer_fsm(s);
> Maybe could just open-code next_sequencer_fsm() now, since a bunch of
> other FSM fields seem to be open-coded?
Sure.
>
>>               }
>>               break;
>>   
>>           case SEQ_OP_SHIFT_N1:
>>               s->status = SETFIELD(SPI_STS_SEQ_FSM, s->status, SEQ_STATE_EXECUTE);
>> -            trace_pnv_spi_sequencer_op("SHIFT_N1", get_seq_index(s));
>> +            trace_pnv_spi_sequencer_op("SHIFT_N1", seq_index);
>>               /*
>>                * Only allow a shift_n1 when the state is not IDLE or DONE.
>>                * In either of those two cases the sequencer is not in a proper
>> @@ -770,8 +765,9 @@ static void operation_sequencer(PnvSpi *s)
>>                    * transmission to the responder without requiring a refill of
>>                    * the TDR between the two operations.
>>                    */
>> -                if (PNV_SPI_MASKED_OPCODE(s->seq_op[get_seq_index(s) + 1])
>> -                                == SEQ_OP_SHIFT_N2) {
>> +                if ((seq_index != 7) &&
>> +                    PNV_SPI_MASKED_OPCODE(s->seq_op[(seq_index + 1)]) ==
>> +                    SEQ_OP_SHIFT_N2) {
>>                       send_n1_alone = false;
>>                   }
>>                   s->status = SETFIELD(SPI_STS_SHIFTER_FSM, s->status,
> The seq_index != 7 is a new test? Is that a separate fix, I'm not
> seeing how it's related to the seq_index change.
Not a new test but to make sure array index of seq_op doesn't overflow 
due to seq_index + 1.
>
> Thanks,
> Nick

