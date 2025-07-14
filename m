Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BD2C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLY2-00073l-AD; Mon, 14 Jul 2025 11:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1ubKZo-0003HH-Gz; Mon, 14 Jul 2025 10:54:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1ubKZm-00071o-2o; Mon, 14 Jul 2025 10:54:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E6S5gw008825;
 Mon, 14 Jul 2025 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jURorE
 ojdPOr+SZetn2oQy6EpdD0K/o+SBjLaQsr47g=; b=Bxx9Nb1cCMTGSWp0QX7gyE
 wKXuJnUkXkmobtYK3TYIdxWufzOixJ2ENXNqmi8HHFV1Jf77m/stAEIu0e9dl73n
 ylG5EyvHKyCjQMIsgYpuwEkV0jk7CQ2Xx+W2t2EF7DsE/409JsVndKfS3uyYmuf+
 +nf1HH3YhMN1qz6ZemIo+1c982AuP7rvEC3l0jTAHXPRguJbPwlbxfqVXtPDOHmt
 LBglkjlYc0QE6K6ObAqbj01NPcM8iYA4s+5KtI9C9x85YR/PstNJghNZirsavJ7D
 WHog8eieu6jkrev6K7tNWajLEUQbGe19PxWlQdO4moYz26pKUq/G2sZ32ZqCRViQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7ctb40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 14:54:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EETuxj008909;
 Mon, 14 Jul 2025 14:54:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hme80g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 14:54:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56EEsWW631130270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:54:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3C8F58055;
 Mon, 14 Jul 2025 14:54:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7694658063;
 Mon, 14 Jul 2025 14:54:31 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Jul 2025 14:54:31 +0000 (GMT)
Message-ID: <80ebd632-5b56-4391-b60d-f6a64f311e7f@linux.ibm.com>
Date: Mon, 14 Jul 2025 10:54:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Collin Walling <walling@linux.ibm.com>, Zhuoying Cai
 <zycai@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-21-zycai@linux.ibm.com>
 <eccbac31-7c1d-4b75-a284-a46ad98675db@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <eccbac31-7c1d-4b75-a284-a46ad98675db@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 32AjINsE4p7dyd6ME5ytgkHFfvNL9Zme
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68751a2b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=URZce_mYXXF1vBoKqvAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 32AjINsE4p7dyd6ME5ytgkHFfvNL9Zme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NyBTYWx0ZWRfX0jRw22KgJpyP
 dVpxKHjp+nIQo/ADHzNltnJy4xKhY4eBs/M7MbQAwZjjjDdq4D+0zls2yYQuFhgkafpZvy42tcN
 XO7HecIPk2iCE33Axrnw2CTxp0gn0CZf5wdrtvdVAa8H4gV84kihgixROCVYCSJToHcGD3jLWvQ
 UTdfxxustY068IOK9uNbULmD4oPgPuL180Q4KiEO1MH5X4a/rhMLfimUDhAo03pgLsvsvwUYq5e
 8mv9rXrbI7EN0X9D7d2zT60OzlQkYjQ7c29BjArFhbVhTZcYcN3hRiAPM0La6WmXy1yk/m0QuEa
 IGg/8MpwJzMPqjQomUD8eV6Dyl/koWqnAmG+7TgZ4gBuSWy5r1KcnjLOg/X9vfIVShPOKVAF+La
 s2X6i9l4WBv+2JunyX5whkfcfj0/p8DBWt5YovfNNipzjFu0cWje/3SdYCwLnnYiEolP0G21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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


[snip...]
>> +
>> +        entry++;
>> +
>> +        if ((uint8_t *)(&entry[1]) > tmp_sec + MAX_SECTOR_SIZE) {
>> +            puts("Wrong entry value");
>> +            return -EINVAL;
>> +        }
> Can someone who is more informed than I am of the IPL process please
> explain to me what is the purpose of the above check?  Why does it check
> if the next entry, the one which isn't going to be inspected/loaded, is
> within the bounds of tmp_sec?  This has been here since this file's
> inception and I can't find any documentation or mention that supports it.
>
> This code precludes any of the secure IPL changes.
>
> Was this actually meant to be entry[0] to ensure the actual entry we
> want to work on is not outside the bounds of tmp_sec?  Or perhaps it was
> meant to be done before the increment to entry?
>

I noticed that as well and came to the same conclusions as you, which is 
to say,
it has always been that way and it is not clear what the purpose is, but 
it does
not appear to have any impact on the proposed secure IPL functionality.  
I agree
that it seems somehow strange, but I believe any changes/fixes would be 
outside
the scope of this item.

In my opinion, since this is already a large patch series, it is better 
to leave
it alone for now unless we find a compelling reason to change it 
immediately.

Regards,
Jared Rossi

