Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FA1CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 19:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVZvM-0001Eu-KF; Fri, 05 Jun 2026 15:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wVZvK-0001EE-Pd; Fri, 05 Jun 2026 15:09:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wVZvJ-00040i-47; Fri, 05 Jun 2026 15:09:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655DokIn2403947; Fri, 5 Jun 2026 19:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=S/lmjb
 2DzrR1VNdxqY09WXox1RZcO/QjS8Sbm/G4+lQ=; b=kCY/9f8mJ1xIXdamEEBz1P
 O0NyP8Owx1RxfkJl6YaZObwXsy42FB9/48up8Ssf8eD72QyndQtkeqx3GfGssPSA
 WWdTo/f4sXnAwAha+6bnjrj5ziCpG80Ji8Rn5XJRXXDfwQNUVDGkBwBPO2qfJriv
 ziOi1JnXQSsIiYLkOUVHaAOAVjblKf8uWRbFF1N5G/SmeoFYwm6cLEpXILwdEg/j
 3j19uAliOm8vfnNUxN7BZiinisTrhA3GH/zdvNkWjYZ+0C1arUCNecLXViRKzzW3
 HLOEpae/6Cautm6H9SuzBtxRQF7BGqGV+tp3NPknnXzNTW4VCIMwSuMUgVuO+mfw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaen8cw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 19:09:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655J95TT030706;
 Fri, 5 Jun 2026 19:09:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qu9mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 19:09:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 655J9ZfF4194936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 19:09:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED38858067;
 Fri,  5 Jun 2026 19:09:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD68B58052;
 Fri,  5 Jun 2026 19:09:33 +0000 (GMT)
Received: from [9.61.146.40] (unknown [9.61.146.40])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 19:09:33 +0000 (GMT)
Message-ID: <00dba930-3820-4089-a6e3-44211ba253cb@linux.ibm.com>
Date: Fri, 5 Jun 2026 15:09:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/32] hw/s390x/ipl: Create certificate store
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-5-zycai@linux.ibm.com>
 <7e410b08-2a87-450e-87db-2cb218e57d5d@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <7e410b08-2a87-450e-87db-2cb218e57d5d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a231ef1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=C23UrBuFxKJcSJhX7B4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ArAeQqy-2sF3M2hjU1HC866fyj4IbVcS
X-Proofpoint-ORIG-GUID: ArAeQqy-2sF3M2hjU1HC866fyj4IbVcS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE4OCBTYWx0ZWRfX3c/sx05qRBS9
 KSjPoljhRGHD3qwHqq0DLUtzEabtJuLdBR7XHZRJNSl9JMZp1P8OcDr8aoRTkxnviUgGq/j466Z
 pYgtNtUdGOaUp+SYvBeBtFs+/PQsEMbonJCY7/sstNIG1r0v+j15fySaXoQaWs/3MzsndddX/Dh
 9IoV6DAcIvXEOg5iPp1cxekxnK6Z4HrOeBDoFoGUcOIKPPEYImO+5AEfdH3hajcqZYHgVZrRRow
 ZyM/G2spPmsnSkfrnx8D72Wm3pSpJJH25eC3JWbpFCdiq71lGf8gP0oi4pTpatc8/uzACWHjZBW
 WfeMTGkWgnASU3YY55JE2XB45Z82RO6i2b0k9lKKIv2sQMbnN+DcwEXFxnlfJpWO1JYIZjIvg7H
 NZPMrv+q3achOwiqzbkb3unqDoQnYKhx46Rl+pPc1dxukQ2tP1kFG+g/wFk0pwJyA22/YO2RYQE
 QOzQLek+ycmY4+zqnWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050188
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks for the feedback!

On 5/22/26 4:31 PM, Collin Walling wrote:
> On 5/5/26 16:18, Zhuoying Cai wrote:
>> Create a certificate store for boot certificates used for secure IPL.
>>
>> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
>> machine type option into the cert store.
>>
>> Currently, only X.509 certificates in PEM format are supported, as the
>> QEMU command line accepts certificates in PEM format only.
> 
> Let's add more context here:
> 
> "The raw Base64 data is stored, as well as the certificate's size.  The
> binary (DER) size is stored as well, which may later be utilized for
> secure boot (signature verification)."
> 
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

[...]

>> +
>> +static void update_cert_store(S390IPLCertificateStore *cert_store,
>> +                              S390IPLCertificate *cert)
>> +{
>> +    size_t data_buf_size;
>> +    size_t keyid_buf_size;
>> +    size_t hash_buf_size;
>> +    size_t cert_buf_size;
>> +
>> +    /* length field is word aligned for later DIAG use */
>> +    keyid_buf_size = ROUND_UP(CERT_KEY_ID_LEN, 4);
>> +    hash_buf_size = ROUND_UP(CERT_HASH_LEN, 4);
>> +    cert_buf_size = ROUND_UP(cert->der_size, 4);
>> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
>> +
>> +    if (cert_store->largest_cert_size < data_buf_size) {
>> +        cert_store->largest_cert_size = data_buf_size;
>> +    }
>> +
>> +    g_assert(cert_store->count < MAX_CERTIFICATES);
>> +
>> +    cert_store->certs[cert_store->count] = *cert;
> 
> Should a g_steal_pointer be used here?
> 

No, g_steal_pointer is not needed here. This line performs a struct
copy, not a pointer assignment and no ownership transfer. The entire
S390IPLCertificate is copied by value into this array.

>> +    cert_store->total_bytes += data_buf_size;
>> +    cert_store->count++;
>> +}
>> +
> 
> Functionally, things look good to me.
> 


