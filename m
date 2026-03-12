Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE9F106703B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0h9V-0002nO-J8; Thu, 12 Mar 2026 10:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w0h9T-0002ma-Pu
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:36:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w0h9Q-0005ci-NC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 10:36:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CDHjvh2279034; Thu, 12 Mar 2026 14:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tc5ygu
 UQlzuI5fbvTVdWlzgeEGCa27SiAPmbxYv5tGI=; b=ORYJF/DVqdZvoQWhdxgBr/
 5fFX6/JO54CNFuEm+mEKuEO8REP95XWU17aajsVY2Vu6EmDN7VJFApEP4tDgI2PF
 x0mjfkIkmv30f3m/PFwhqZxUhl2guwqmMmNrPgv/U+MsXpyLofyek0iPv9m/bZfS
 OUDCKTTsLU7kpj9v6/UULH1n5/jjiX6YlZdL+LM6tyoqDj4nlcKFwk8d+unmKuZQ
 PzUbp3AT2B0avGviT+PH98E+2FXILyt/TBbdxAF/xbPQ8q27rt6rpUInObCiG80F
 /AYQLYzdZLs8OfALhSrHGwiKlSPxIjQzIfvA6Eepr8K3R9c0aYrAdYW+voI0QVww
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91k5tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Mar 2026 14:36:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62CEN11G025674;
 Thu, 12 Mar 2026 14:36:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8apbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Mar 2026 14:36:32 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62CEaVur18940462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2026 14:36:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4010D58055;
 Thu, 12 Mar 2026 14:36:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48A025804B;
 Thu, 12 Mar 2026 14:36:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Mar 2026 14:36:30 +0000 (GMT)
Message-ID: <c4ccc082-2c52-4698-9538-cbf4fffa9318@linux.ibm.com>
Date: Thu, 12 Mar 2026 10:36:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] hw/tpm: CRB chunking capability to handle PQC
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260312041650.181411-1-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dK6iHQndDcTnaioGkRV-zgGb0LPxepKR
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b2cf71 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=xt6ew7UTAAAA:8
 a=l_-q7lcJLEWib7x2CmsA:9 a=QEXdDO2ut3YA:10 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDExNiBTYWx0ZWRfX+iwDi2vrdAWG
 Sn1UOQlU9dztbsI5BAtNH33tGXfMBSbsStpLc6GloM+ddHTG/phMY27lEu206oLAlVB23GRRsmE
 ytXDPRV7X4BwGfSvMz10QPjAqDTYSav9gVo63cVcdjVAbP58pIoDx6nKp8x8l7zsBRyaeB4CHZe
 3xVjtRf65YRGGyOXbQwY8xa1FGkmAQ2Gqif04rTlvYhbH9L8CyFHmUEkLle2oPhBg1j9kIe93js
 QhnXm6eLP7tCStwRdTKjDXGZDvcE1MO0byqSqgSiH5UzTj5anSUlgcpkbtR0KBuO/+TyMKIuBzc
 NVZqySB+xfufYkTF2YW7NHOT9q3a0Ylw4mtlYr4/5eveMZxb2uHkLWYmC2xr7f1ipmaW1fwMKGl
 Bl91Oexn2xBx6IGrDHI43I8K8ChQnCy+6WOJ5oJH9CiOu/42GdwMBTutmsR/87I9FCrnu9OrF9z
 HCHXn9u9l1d2otqRJOQ==
X-Proofpoint-ORIG-GUID: dK6iHQndDcTnaioGkRV-zgGb0LPxepKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/12/26 12:16 AM, Arun Menon wrote:
> The move to Post Quantum Cryptography (PQC) changes how we manage
> memory buffers. Unlike classic crypto algorithms like RSA or ECC which
> used small keys and signatures, PQC algorithms require larger buffers.
> 
> The new version of TCG TPM v185 (currently under review [1]) supports
> sending data/commands in chunks for the CRB (Command Response Buffer)
> interface. This is in line with the initiative to support PQC algorithms.
> 
> This series implements the logic to send and receive data from the
> linux guest to the TPM backend in chunks, thereby allowing the
> guest to send larger data buffers. We introduce 2 new control registers
> called nextChunk and crbRspRetry that will control the START. We also
> add the CRB Interface Identifier called CapCRBChunk that is set to 1
> indicating that the device supports chunking. The default maximum
> chunk/buffer size is 3968 (4096 - 128) bytes.
> 
> During a send operation, the guest driver places data in the CRB buffer
> and signals nextChunk for each segment until the final chunk is reached.
> Upon receiving the START signal, QEMU appends the final chunk to its
> internal buffer and dispatches the complete command to the TPM backend.
> 
> For responses, the backend's output is buffered. The guest consumes the
> first chunk once the START bit is cleared. Subsequent chunks are
> retrieved by the guest toggling the nextChunk bit, which advances the
> internal buffer offset and populates the CRB data window.
> 
> For this to work, the linux guest tpm driver will also have to
> a) probe if CRB chunking is supported
> b) send data in chunks if the command length exceeds the chunk size.
> c) receive data in chunks by sending a nextChunk signal and accumulate.
 > > At present, VM live migration during a tpm command execution in chunks
> is not supported. We intend to add support for TIS interface in

.. and also VM suspend/resume. Do you intend to support these? The 
problem will be state incompatibility with previous QEMU versions then 
since we now need to save the additional (bytes in the new) byte 
buffer(s) and possibly the new control registers' contents.

Thanks for also thinking of the TIS support. I guess we will have the 
same issue there then with state incompatibilities even though with the 
TIS it should just be a matter of just using a bigger buffer. 
Theoretically we could write a 4096 byte buffer to the state if up to 
4kb are held there and switch to a .version_id = 1 state for bigger 
buffer size, but then we could migrate to an older version of QEMU and 
find that it cannot do PQC transactions (anymore) due to older version 
of TIS there (I guess migration between major versions of QEMU is 
supported with all kinds of machines). Also, nothing will prevent one 
from running a PQC-enabled swtpm+libtpms with an older version of QEMU 
but one will find out if transactions don't succeed (assuming Linux TPM 
driver can handle it) because the QEMU TIS buffer is too small.

> the future.
> 
> The included test demonstrates functional correctness for standard
> buffer sizes. However, validation of PQC-sized payloads was performed
> via manual buffer-size overrides.
 > > [1] 
https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> 
> Arun Menon (5):
>    hw/tpm: Add TPM CRB chunking fields
>    hw/tpm: Refactor CRB_CTRL_START register access
>    hw/tpm: Add internal buffer state for chunking
>    hw/tpm: Implement TPM CRB chunking logic
>    test/qtest: Add test for tpm crb chunking
> 
>   hw/tpm/tpm_crb.c                 | 167 +++++++++++++++++++++++++++----
>   include/hw/acpi/tpm.h            |   5 +-
>   tests/qtest/tpm-crb-swtpm-test.c |  10 ++
>   tests/qtest/tpm-util.c           | 106 +++++++++++++++++---
>   tests/qtest/tpm-util.h           |   5 +
>   5 files changed, 256 insertions(+), 37 deletions(-)
> 


