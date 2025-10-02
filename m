Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5EFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4JyI-000726-8c; Thu, 02 Oct 2025 10:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4Jy5-0006zf-MV; Thu, 02 Oct 2025 10:07:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4Jxn-0006je-UM; Thu, 02 Oct 2025 10:07:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Dnhcr018268;
 Thu, 2 Oct 2025 14:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eZ8mZp
 Snp3dIq2wMpMSDkr4FugwAU+cb5lDPjHGGpIk=; b=JH+6d9pceqjuPIQblMBsYn
 Kg5qHopK4SDcM+QPwVZwNMHNSnvqm7wfnR3WOODGBGCdVffGE5yrFIdE0Ns469Gw
 asWFNH2DH2IonOiXjabfebR4iTTrqxxIGXKE1Oxsga8G8NzZLf7MVlZQucTlKobA
 JRSo35WldYoCv1IVGFDw8XB8tmckjNBjiEP+ckUBIbQ7HxRbvjWr0Dklx4bqSyQP
 1lYIdQHrwbpGcd5m5bAMCtwId+yuRa7qPaC67NfoqE561ZAiEQ/SBIqCT3iPcAlM
 h4PiWVwlB4jtGFhCSla3HlLb766Xm/R1qhwl25cfX+V+xNneDobUl5vjSrKKXLtg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhvwpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 14:07:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592DIJS8007293;
 Thu, 2 Oct 2025 14:07:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk66k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 14:07:00 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 592E6xTp25690876
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Oct 2025 14:06:59 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C78C58060;
 Thu,  2 Oct 2025 14:06:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EB755805E;
 Thu,  2 Oct 2025 14:06:58 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.134.141]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Oct 2025 14:06:58 +0000 (GMT)
Message-ID: <6f3b9f98913ba738f724cb8086d9bbc2f6f6f265.camel@linux.ibm.com>
Subject: Re: [PATCH v4 04/17] hw/s390x/sclp: Use
 address_space_memory_is_io() in sclp_service_call()
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thomas Huth <thuth@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Halil Pasic	
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, David Hildenbrand	 <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>
Date: Thu, 02 Oct 2025 10:06:57 -0400
In-Reply-To: <20251002084203.63899-5-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
 <20251002084203.63899-5-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68de8705 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=TDcfOtANP4GnBCsQLmsA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX3NwCWmSJppLp
 7MpvChm1MGydtXqsaVGxEIz8sAac8copHypMcmHe86072VAt31k5SMra1Oplib3bEhafZSWAI7M
 0eaq2fJVogf2/azlia/SttMfapnwYuusiAzi4kS55NDSKwfrJzDgW3Qx9DvBjEYmqA09AVViijh
 8/BO/VWCfDnOs1f1OJT8v4Kqxu+ymhQH9PveKI7WjZFsu8kZ/0SpWHvVFcX45j/khLt4cGgLKEF
 PWdgwpf8u/OK5ou06sGlcFFkAwTruDjIE6sSPLG0owltwJh87JKDsp9Mkyn9BA8dSr8RLrOUNDj
 zajSQezW2xY104swtBFOg+JaoLSurQyuS9E28V19YcejRW7z3hlF7rzOs03w7YS6lm2S6fjQVy4
 UG9vwQO8iU8peq5h5OpBkNR+5suhIw==
X-Proofpoint-GUID: yeSTTqESg1gtVaOOzXRYuBOTHp0QMtDm
X-Proofpoint-ORIG-GUID: yeSTTqESg1gtVaOOzXRYuBOTHp0QMtDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Thu, 2025-10-02 at 10:41 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> When cpu_address_space_init() isn't called during vCPU creation,
> its single address space is the global &address_space_memory.
>=20
> As s390x boards don't call cpu_address_space_init(), cpu->as
> points to &address_space_memory.
>=20
> We can then replace cpu_physical_memory_is_io() by the semantically
> equivalent address_space_memory_is_io() call.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/s390x/sclp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

