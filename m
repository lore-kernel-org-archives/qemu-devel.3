Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C158D3CC81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 21:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg8oh-0001kF-Rl; Wed, 14 Jan 2026 16:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vg8og-0001k3-NV; Wed, 14 Jan 2026 16:54:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vg8of-0001fv-4U; Wed, 14 Jan 2026 16:54:14 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60EHtU7J011825;
 Wed, 14 Jan 2026 21:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T0/H9b
 OfcAMcZrjcz0Av1zDWH8rSKVLxu6+w+tkEMFM=; b=tNasg7pexOhNdloBpQe0os
 SQPbQfeApcHmLqKrP8/ifaQvB5wTX8xWNs1LcpqN3ypcaNjTjasGWec/d5OmENxu
 DoNmc6SvyWNfgUD1b3d2yykpY+o+5KauawB3nGseWPWX2tm32f+UkUm8aWTeld+f
 +6BH13hVWRRlSFrlua+afN3s49dYpkH2os3OdYOVxQld8TH5F9zTZwNvMZhe2VHI
 d0tSQnxFiSixcqvSVte68xwZTriyOs4MQKUWbRuqaA7e6p8BBw7nDZKBKuEUJhZD
 zC0rHUlzJTMC+kDx7tp/AxfH48ilrio3IyyEmA65rcZXkLF5w8Sj9NM0lB/8c/lA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeeq3pej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jan 2026 21:54:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EJlPGQ014303;
 Wed, 14 Jan 2026 21:54:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm1fycrmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jan 2026 21:54:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60ELs7Qn65995252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jan 2026 21:54:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 992B658053;
 Wed, 14 Jan 2026 21:54:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0F6358043;
 Wed, 14 Jan 2026 21:54:05 +0000 (GMT)
Received: from [9.61.11.245] (unknown [9.61.11.245])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Jan 2026 21:54:05 +0000 (GMT)
Message-ID: <d31a747f-d2b3-429a-9ee1-924e55ea3aea@linux.ibm.com>
Date: Wed, 14 Jan 2026 16:54:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhuoying Cai <zycai@linux.ibm.com>
Subject: Re: [PATCH v7 09/29] s390x/diag: Implement DIAG 320 subcode 2
To: Farhan Ali <alifm@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-10-zycai@linux.ibm.com>
 <b3a03c68-c011-43e8-8c85-e14fb7f39399@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <b3a03c68-c011-43e8-8c85-e14fb7f39399@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DI6CIiNb c=1 sm=1 tr=0 ts=69681082 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OkEAUxHlVwn2UpCt1b4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uwPwL_ywwUM1_DpQXJSocAiqY7q9b0Qj
X-Proofpoint-ORIG-GUID: uwPwL_ywwUM1_DpQXJSocAiqY7q9b0Qj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE3OSBTYWx0ZWRfX8wVer2aaL5jS
 xwIcZZEuZTCqMnTHqGBkudju28AJcPsamWmWi3njP+ssAJ4Mm/uKgWCRPbu4RF2vuIJyjkMkON7
 eDPaUR6WgOzfFI6yXhL/KAkCPSGWAvqhVJfGyiPYiHFVg09mt6xGtdDc07kJ2tPwL89OQADd/5X
 CWkJ7cNnt/PAEGtKHejJ0GRfILHWUfodDtUZiOiq5Yiev/I2yFuynDUYP2dqibRb4sLiGQZ5eFu
 R8yZfhKSf3eXi29jOX6/BRZEi7KS+SV5umCNDUa1/S3uvQI8DYaO+cELjPh3ttPWD0XRUQ96BYl
 F4pqvLyLsJ3h5EZ39D1bI5EnMUwtfMgXxmiIpdKqaK0asIpo8l4Q9YSpsKaLe5F790/81OKbyu4
 oQ5DM+OsygeaRZw2yMrr/BJXf4cqTz0i9jDZyzMQikjlvlcWSuaUfQX8rxwT/1tsHkju5L7+y75
 J/E+etF+PAZOh2LoMPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140179
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/8/26 5:54 PM, Farhan Ali wrote:
> <..snip...>
> 
> On 12/8/2025 1:32 PM, Zhuoying Cai wrote:
>> +static int build_vce_data(VCEntry *vce, S390IPLCertificate cert)
>> +{
>> +    uint16_t keyid_field_len;
>> +    uint16_t hash_field_len;
>> +    uint32_t cert_field_len;
>> +    uint32_t vce_len;
>> +    int rc;
>> +
>> +    handle_key_id(vce, cert);
>> +    /* vce key id field length - can be 0 if failed to retrieve */
>> +    keyid_field_len = ROUND_UP(be16_to_cpu(vce->keyid_len), 4);
> 
> If we fail to retrieve the key, does it makes sense to build the VCE? I 
> think we need the key to verify the signature of the certificate, so why 
> not mark the certificate as invalid?
> 
> 

The key ID is used to identify the public key in the certificate, but
it is not utilized in the current patch series. Therefore, I thought it
would be acceptable to continue building the VCE without this field,
though I am open to other ideas or suggestions on how to handle it.

>> +
>> +    rc = handle_hash(vce, cert, keyid_field_len);
>> +    if (rc) {
>> +        return -1;
>> +    }
>> +    hash_field_len = ROUND_UP(be16_to_cpu(vce->hash_len), 4);
>> +
>> +    rc = handle_cert(vce, cert, hash_field_len);
>> +    if (rc || !is_cert_valid(cert)) {
>> +        return -1;
>> +    }
>> +    /* vce certificate field length */
>> +    cert_field_len = ROUND_UP(be32_to_cpu(vce->cert_len), 4);
>> +
>> +    vce_len = VCE_HEADER_LEN + keyid_field_len + hash_field_len + cert_field_len;
>> +    if (vce_len > be32_to_cpu(vce->len)) {
>> +        return -1;
>> +    }
>> +
>> +    /* The certificate is valid and VCE contains the certificate */
>> +    vce->flags |= DIAG_320_VCE_FLAGS_VALID;
>> +
>> +    /* Update vce length to reflect the actual size used by vce */
>> +    vce->len = cpu_to_be32(vce_len);
>> +
>> +    return 0;
>> +}
>> +
> 
> <...snip...>
> 


