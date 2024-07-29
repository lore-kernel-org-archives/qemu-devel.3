Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEE1C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTAU-0007jX-NT; Mon, 29 Jul 2024 12:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sYTAS-0007gY-3X; Mon, 29 Jul 2024 12:24:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sYTAQ-00040k-AW; Mon, 29 Jul 2024 12:24:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TD3lP9010617;
 Mon, 29 Jul 2024 16:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=l
 fdxeXslzAyHQo2HhSceckYvUfvtZiJZEVuGxPYxk58=; b=NcVytYaOprK1PCe7r
 su4IVy6ZvwPl4l16UIkTAyjPCrRVGtYed1pp8gRY4HJJPzJcejddca3L4xHFtMEJ
 276jlyGJ7WNxM7350f9T6cZTFVh87WsNkOAEHfqINwZwn55OfBcCrNik4g4+RVaG
 eRLtQSIiZASalRmMprrMvvsj5OZpmPwI8RwzUpFBfR9UcpNoqQJkdjoR2QaPhmf0
 BbIw09xYMLDQvaUgk/zacrNc+FPatQB3pmLC1AeS+cAgF/x5gNKqbpddw3TE/hk3
 3+iqBTuhYreGmow1YaBpiTTZX2qylysrc9IT9XZmyHn7su6DqjJwEiJmP7vB1+lh
 qchYA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40p9bwgyhe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 16:23:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46TGNwc7014204;
 Mon, 29 Jul 2024 16:23:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40p9bwgyhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 16:23:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46TGKqDk007483; Mon, 29 Jul 2024 16:23:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7tyvnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jul 2024 16:23:57 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46TGNra452167008
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jul 2024 16:23:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AAB720043;
 Mon, 29 Jul 2024 16:23:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ADE020040;
 Mon, 29 Jul 2024 16:23:51 +0000 (GMT)
Received: from [9.43.15.8] (unknown [9.43.15.8])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jul 2024 16:23:51 +0000 (GMT)
Message-ID: <447774a4-2320-46e9-8560-47ffb91c3989@linux.ibm.com>
Date: Mon, 29 Jul 2024 21:53:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 38/96] hw/ssi: Extend SPI model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-39-npiggin@gmail.com>
 <51155ede-a34f-40f0-8122-540e25974466@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <51155ede-a34f-40f0-8122-540e25974466@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _x0DHGuaYIqKAltnTw4_lOh9ANmLCRVm
X-Proofpoint-GUID: pWAgl5WhH9C2WhDBCqm3anrs5Zibv_Pg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_14,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=902
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290110
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 29-07-2024 17:38, Cédric Le Goater wrote:
> On 7/26/24 01:53, Nicholas Piggin wrote:
>> +static void transfer(PnvSpi *s, PnvXferBuffer *payload)
>> +{
>> +    uint32_t tx;
>> +    uint32_t rx;
>> +    PnvXferBuffer *rsp_payload = NULL;
>> +
>> +    rsp_payload = pnv_spi_xfer_buffer_new();
>> +    for (int offset = 0; offset < payload->len; offset += 
>> s->transfer_len) {
>> +        tx = 0;
>> +        for (int i = 0; i < s->transfer_len; i++) {
>> +            if ((offset + i) >= payload->len) {
>> +                tx <<= 8;
>> +            } else {
>> +                tx = (tx << 8) | payload->data[offset + i];
>> +            }
>> +        }
>> +        rx = ssi_transfer(s->ssi_bus, tx);
>> +        for (int i = 0; i < s->transfer_len; i++) {
>> +            if ((offset + i) >= payload->len) {
>> +                break;
>> +            }
>> +            *(pnv_spi_xfer_buffer_write_ptr(rsp_payload, 
>> rsp_payload->len, 1)) =
>> +                    (rx >> (8 * (s->transfer_len - 1) - i * 8)) & 0xFF;
>> +        }
>> +    }
>> +    if (rsp_payload != NULL) {
>> +        spi_response(s, s->N1_bits, rsp_payload);
>> +    }
>> +}
>
> Coverity reports:
>
>>>>     CID 1558831:  Resource leaks (RESOURCE_LEAK)
>>>>     Variable "rsp_payload" going out of scope leaks the storage it 
>>>> points to.
>
>
> rsp_payload should be freed.
>
> Thanks,
>
> C.
Hello Cedric,
Yes, rsp_payload should be freed everytime. Thank You for catching.

Thank You,

Chalapathi

>
>

