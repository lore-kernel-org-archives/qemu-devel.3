Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A73C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYJL-0003G4-2m; Tue, 17 Jun 2025 11:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uRYIC-0001Fx-Lk; Tue, 17 Jun 2025 11:32:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uRXkn-0006GZ-3x; Tue, 17 Jun 2025 10:57:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H87JP5014347;
 Tue, 17 Jun 2025 14:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MQWX+6
 9YNKZeuPiRUz9pug47O/6QaZc6bZ2mffAdzB8=; b=OrPk/eyKCRgZehOPNfaoZN
 1SC5MlZI/bVL3Kl00iTC+rHftjFaQrDu917vBxze5A/w598ie6RJZ5xqYjo8dWUy
 0USCEe66bYW04lqFU/eCVjr9/3W7mWLx6vb2yyhf133r8Qfe0Y+5ChlbtqgdiwJl
 5O9W6dx0a2jMnW8Y2I4OzNm8qkd2yUPovVCZOOa1nMUUe3ueZ8xvSxVmWrKH9YAP
 tMo5mdmo7tjOPczbmwVGCUnHqr7UT0CwLNhm1+MDRjeNuUQg0Z80LphrUYmKoWQl
 SP6EPbbnxY0srBuIQqqAJBnxRwDZpS6HJp2rkP1QPWAnXTkDVIpDZC94/JBDXYLw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4h6pc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:57:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HC9D52000724;
 Tue, 17 Jun 2025 14:57:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mdp437x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:57:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55HEvPIi32309648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 14:57:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0853058056;
 Tue, 17 Jun 2025 14:57:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29A0958052;
 Tue, 17 Jun 2025 14:57:24 +0000 (GMT)
Received: from [9.12.79.241] (unknown [9.12.79.241])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 17 Jun 2025 14:57:24 +0000 (GMT)
Message-ID: <41e788ad-77e2-46d2-a384-2c8f524391c2@linux.ibm.com>
Date: Tue, 17 Jun 2025 10:57:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/28] crypto/x509-utils: Add helper functions for
 certificate store
To: Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, walling@linux.ibm.com,
 jjherne@linux.ibm.com, jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-3-zycai@linux.ibm.com> <87sejyskgj.fsf@pond.sub.org>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <87sejyskgj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExNSBTYWx0ZWRfX88ZmDWIu+juY
 BvThgSNPvRl+Qs4RIGKcC3xzz8cIzDTyZ0urGSHytDbSc8epVTTMtKdBBCrFmnnOPaGlTvwuicb
 8EZ5dzIl4C42Vw8JlHUoj84V9W8AkbQCyjQOn3SfpWau5wr7El9GLL94R03AAXlLEQaQwgOp/HO
 gcq3n3n4OBiNA1xVpyus8zzeH29Y9HKyeY2Wl4Ijn7Y9FKAPBsPxCTjqaumkYcF1rUuxFwEJbsn
 2UIzpIC9WoIYxS0zXJdtBgpNB9CSgWyIyIs5DHkvWetuZvpaiqbzK3C2uarmtMByms12KxWsQXF
 Mb6xLAsQFsd9Hknc5zDwnjY1GJIoaWYaChwJTyjxmJ4TKdSR5+EPVdkqVxjxDevbiAqWZ4YJLJS
 kzY0w7EtgYf9y9qB4FVtvuwlRSdlMtJelgJBWaa0EuSyowQTF800ImoxwiFTXY5N2ztqcnTw
X-Proofpoint-ORIG-GUID: AMD-p3PLIFkSJn3TzDrYcLkw08i1dgtI
X-Authority-Analysis: v=2.4 cv=Qc9mvtbv c=1 sm=1 tr=0 ts=68518258 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=iHqiD_Bf0ui-M6XZcwgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AMD-p3PLIFkSJn3TzDrYcLkw08i1dgtI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=730
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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



On 6/17/25 6:58 AM, Markus Armbruster wrote:
> Zhuoying Cai <zycai@linux.ibm.com> writes:
> 
>> Add helper functions for x509 certificate which will be used in the next
>> patch for the certificate store.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> 
> [...]
> 
>> diff --git a/qapi/crypto.json b/qapi/crypto.json
>> index c9d967d782..af487dcecd 100644
>> --- a/qapi/crypto.json
>> +++ b/qapi/crypto.json
>> @@ -612,3 +612,83 @@
>>    'base': { 'alg': 'QCryptoAkCipherAlgo' },
>>    'discriminator': 'alg',
>>    'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
>> +
>> +##
>> +# @QCryptoKeyidFlags:
>> +#
>> +# The supported flags for the key ID
>> +#
>> +# @sha1: SHA-1
>> +#
>> +# @sha256: SHA-256
>> +#
>> +# @sha512: SHA-512
>> +#
>> +# @best-known: BEST-KNOWN
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'enum': 'QCryptoKeyidFlags',
>> +  'data': ['sha1', 'sha256', 'sha512', 'best-known']}
>> +
>> +##
>> +# @QCryptoCertFmt:
> 
> For better or worse, we tend not to abbreviate things in QAPI schema
> names: QCryptoCertFormat.
> 
>> +#
>> +# The supported certificate encoding formats
>> +#
>> +# @der: DER
>> +#
>> +# @pem: PEM
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'enum': 'QCryptoCertFmt',
>> +  'data': ['der', 'pem']}
>> +
>> +##
>> +# @QCryptoSigAlgo:
>> +#
>> +# Algorithms for digital signature
>> +#
>> +# @unknown: UNKNOWN
>> +#
>> +# @rsa-sha1: RSA-SHA1 or RSA-SHA
>> +#
>> +# @dsa-sha1: DSA-SHA1 or DSA-SHA
>> +#
>> +# @rsa-md5: RSA-MD5
>> +#
>> +# @rsa-md2: RSA-MD2
>> +#
>> +# @rsa-rmd160: RSA-RMD160
>> +#
>> +# @rsa-sha256: RSA-SHA256
>> +#
>> +# @rsa-sha384: RSA-SHA384
>> +#
>> +# @rsa-sha512: RSA-SHA512
>> +#
>> +# @rsa-sha224: RSA-SHA224
>> +#
>> +# @dsa-sha224: DSA-SHA224
>> +#
>> +# @dsa-sha256: DSA-SHA256
>> +#
>> +# @ecdsa-sha1: ECDSA-SHA1
>> +#
>> +# @ecdsa-sha224: ECDSA-SHA224
>> +#
>> +# @ecdsa-sha256: ECDSA-SHA256
>> +#
>> +# @ecdsa-sha384: ECDSA-SHA384
>> +#
>> +# @ecdsa-sha512: ECDSA-SHA512
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'enum': 'QCryptoSigAlgo',
>> +  'data': ['unknown', 'rsa-sha1', 'dsa-sha1',
>> +           'rsa-md5', 'rsa-md2', 'rsa-rmd160',
>> +           'rsa-sha256', 'rsa-sha384', 'rsa-sha512', 'rsa-sha224',
>> +           'dsa-sha224', 'dsa-sha256',
>> +           'ecdsa-sha1', 'ecdsa-sha224', 'ecdsa-sha256', 'ecdsa-sha384', 'ecdsa-sha512']}
> 
> Ignorant question: why are these QAPI enums?
> 
> If they need to be QAPI enums, then I'll have some requests on the doc
> comments.
> 

Hi, thanks for the feedback.

The helper functions in x509-utils.c either take QAPI enum values as
parameters or return them. These enums are used later within QEMU.


