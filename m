Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91529D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 14:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viCsQ-00009W-KT; Tue, 20 Jan 2026 09:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1viCsN-0008O5-Oi; Tue, 20 Jan 2026 09:38:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1viCsK-00067Z-VG; Tue, 20 Jan 2026 09:38:34 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60K3bdNM030811;
 Tue, 20 Jan 2026 14:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DL+6dR
 dLL+gnyr87LC+XBanjuKkWH7OYZMal4/wH5iM=; b=UU2ZhG/Sv4feU/jrfDdRVt
 35yY7bvZZ4p8DPlcdJKkyHDASAfuTMaCWSV3VP95qaK5zB4iRICE772nK+u2S34A
 KOUg/Fy1d7EjhgGNMVDVT2UxKT8++PgBQYF+p9rPJpAtK7M5ueC3odhicblkQ5qe
 RLlIWvIhp6kPbj9dormdGrGxDZapQnMZ+dzcevEUQUlweN4EI9lul4ax1zWn2gWe
 QKwUox2HHW7nrfPN5YdJhsfNykFF2m2SOzrBeOC5TZufJmRQ5BmT2/Xnm4EwOVss
 JFHl4z4dwCBOJWaLE90/AWY6xsJ6TagiHVdGr9MjXTOy0CbDysJuwgZbEwBh2XeA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255x8u8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:38:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60KEJGK1029312;
 Tue, 20 Jan 2026 14:38:28 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br255x8u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:38:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60KEQQWS002002;
 Tue, 20 Jan 2026 14:38:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjn6fb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jan 2026 14:38:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60KEcPHh32571888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jan 2026 14:38:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 970705805D;
 Tue, 20 Jan 2026 14:38:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 048E858043;
 Tue, 20 Jan 2026 14:38:25 +0000 (GMT)
Received: from [9.10.80.137] (unknown [9.10.80.137])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jan 2026 14:38:24 +0000 (GMT)
Message-ID: <9c85e853-2c43-48de-b433-99fc110247db@linux.ibm.com>
Date: Tue, 20 Jan 2026 08:38:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, chalapathi.v@linux.ibm.com
References: <20251216154503.2263755-1-calebs@linux.ibm.com>
 <aW3VANPAcyejWJ4Y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <aW3VANPAcyejWJ4Y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDExOCBTYWx0ZWRfXz8CBNSr518BR
 JT6sfpbc7kBN4qhdPfzvafOCHvc+TgjGiQSw9SqtmX2x73mzUAXIy7+RF8EA8eEkQgUJGvP2sDU
 zNWQeDw4h2uxahP7F9AtABhDxtW8/hLTK6C9z4oSUyZKxfr9eURSjTOkFGz/1s+b777YOrLtQQt
 FE+Xr6NBztDlQjimKINmHafGTe+4e3YDL71KxT/8eM7aQKdVhhBk8XCr2oR7Or+7BuD+isaDXiK
 Uswvwb2E2E5aRiZwXJMGJN448o0J8XTPZSdt+8Gz35xfmKEoVqQkoUHk+YX0M2usTpZrj8j6rBR
 Znwg/ToLrsOtGFh6HfEyie/p4CNbMM1Q6ZOAc+1AHMjXdmCf/n9kfX4Hmvrg4zA/ZERhAf1pSl6
 VjDfgqHTk10imlWaKsDqdviJ9U04R6PbtihJ7gFY2sGN1DaJryoWdvHVo2s+PeNFsexdvRwKXRM
 fSIiKOqvvPpcs1zhwNg==
X-Authority-Analysis: v=2.4 cv=BpSQAIX5 c=1 sm=1 tr=0 ts=696f9364 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=dhUF3OugxwqxtIcJtT8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kdPv1HudR3oAD-pMqkGoUJgveiuSz1a3
X-Proofpoint-ORIG-GUID: Vos_Zezgmm9wHSdOLUNquIelwjS7As1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601200118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/19/26 12:57 AM, Aditya Gupta wrote:
> On 25/12/16 09:45AM, Caleb Schlossin wrote:
>> unrealize should free the fifo8 memory that was allocated by realize.
>>
>> Fixes: 17befecda85 ("hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure")
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> 
> Hello Caleb,
> 
> Sorry for the delayed review. The patch currently doesn't apply on
> upstream, as there was a merge conflict with vmstate patch and this.
> 
> Can you send a v2, rebased on upstream ?
> 
> Thank you,
> - Aditya G
> 

Yup, I'll rebase and fix in v2.

Thanks,
Caleb

>> ---
>>  hw/ssi/pnv_spi.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
>> index f40e8836b9..5db440be9a 100644
>> --- a/hw/ssi/pnv_spi.c
>> +++ b/hw/ssi/pnv_spi.c
>> @@ -1176,6 +1176,13 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
>>                            s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
>>  }
>>  
>> +static void pnv_spi_unrealize(DeviceState *dev)
>> +{
>> +    PnvSpi *s = PNV_SPI(dev);
>> +    fifo8_destroy(&s->tx_fifo);
>> +    fifo8_destroy(&s->rx_fifo);
>> +}
>> +
>>  static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
>>                               int offset)
>>  {
>> @@ -1208,6 +1215,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
>>  
>>      dc->desc = "PowerNV SPI";
>>      dc->realize = pnv_spi_realize;
>> +    dc->unrealize = pnv_spi_unrealize;
>>      device_class_set_legacy_reset(dc, do_reset);
>>      device_class_set_props(dc, pnv_spi_properties);
>>  }
>> -- 
>> 2.47.3
>>


