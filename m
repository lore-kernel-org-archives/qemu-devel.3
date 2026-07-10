Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F93C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiHaN-0000YE-7n; Fri, 10 Jul 2026 16:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wiHaL-0000Xn-Ac; Fri, 10 Jul 2026 16:12:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wiHaJ-0001C6-Fz; Fri, 10 Jul 2026 16:12:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AHIMo01724471; Fri, 10 Jul 2026 20:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FjNxsU
 6vDB5aclWh48hU7L4JnhPRgBzcvhGIVH+Ni9I=; b=Drwt6F2w1dvh9ZaS424nxG
 YJQNhMTyrOcflCtqlQxuydL1G7J9czdalVn9QRWYjVmo//i8JfUremmUM+52gfvc
 Otr8MRIm2aj27kQeajmqdsmBR8bqpohbuyVj1otjRRJBEJ24Mhi3MqgIm6Gd/pN7
 /rogYs0R9J1g1ny1vM8w2x3naZWFo3wTW0PQ9gh+xvjXvJZNFWj856tUXkR119vL
 gWRycbzVFU8HGopoXppre8Vyps6lXM/fMNljaWfzaqrErzsolvgNMq7nd6eBV49J
 8ANfMKW7IW2dWlOp1thj7L086vHCHKa1PdilbmxC/2E2KH6hvIi/LmAa3exFLsKw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0dwtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 20:12:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AK5mB4020582;
 Fri, 10 Jul 2026 20:12:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0humqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 20:12:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66AKCMDt42664192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 20:12:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3729858052;
 Fri, 10 Jul 2026 20:12:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EB9958063;
 Fri, 10 Jul 2026 20:12:21 +0000 (GMT)
Received: from [9.67.136.45] (unknown [9.67.136.45])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Jul 2026 20:12:21 +0000 (GMT)
Message-ID: <d9d2c528-44d5-441e-9018-51cf520c07a4@linux.ibm.com>
Date: Fri, 10 Jul 2026 16:12:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/sclp: prevent re-reading the sclp header
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-stable@nongnu.org
References: <20260709142906.197474-1-borntraeger@linux.ibm.com>
 <20260709142906.197474-2-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260709142906.197474-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a515229 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=ZJU-347c4brpoGBYKIEA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: r-jP6ajmdlTGsMFVh4WiWSf0_YQvotLz
X-Proofpoint-ORIG-GUID: r-jP6ajmdlTGsMFVh4WiWSf0_YQvotLz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE5OSBTYWx0ZWRfX1DRIo1vhxw53
 14tNvpE5OvdbcV4ReXen6A0gRpeAi2zmFHklJ83aM9pWVoCH+eLsz5X7S5bvdTW/mkEYE0/jxjI
 YfZH0o3b2bfmvUpFSg05rTfI+EuYZXk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE5OSBTYWx0ZWRfX+tvCL33ZKGfK
 OJCg7bGHpncnNcNMWP7K7vZP3+gUX7jprv06jx9bV7nYjUUhqmoLUNI9rVwCq/jZhzUICQ/l2mE
 OqsneuMtNSAI04GpDimTJBLPrQ/2VI7amCUlC2W6KjI/J8nREbpuk/INbmJic7ssrztBBsHjDzi
 J9clzK9YzhkYPIOl7/e/J5KltZeMYcq5jnlNxVBxMi26wyrEeMNQSu0wS8rFxw7XGHqYxmzZEbs
 lOy2UF1D5ts58XzrGyoNNs8lUU0CTgWpg7e5HdJhb97AMOp6wdQCPureZQXNHPVHF/E8u3jqcq9
 em/It/ASgQWNUySXLdL7UscwSRB/6iHEA+NbNwJEF+a2Lr8pxHQ3+iiQR4Uh1KRCz0Zpirciqvp
 7XjHwClm/kEtECFOmDi3uobOWSoBf1ZEHT5jxRSdBBlG+1KszOk4BYhJmPy/18fbBtDF50x7Y2O
 bYPOV2bpXQS8TC0INng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100199
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 7/9/26 10:29, Christian Borntraeger wrote:
> We verify the sccb length and then allocate based on that length. The
> following access re-reads the sccb again. This can race against other
> vCPUs overwriting the length field.
> 
> sclp_service_call_protected does not need a change as the ultravisor
> provides a consistent snapshot.
> 
> Fixes: c1db53a5910f ("s390/sclp: read sccb from mem based on provided length")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  hw/s390x/sclp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 2d2cde7803..3c8cb16488 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -329,7 +329,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>      /*
>       * we want to work on a private copy of the sccb, to prevent guests
>       * from playing dirty tricks by modifying the memory content after
> -     * the host has checked the values
> +     * the host has checked the values.
> +     * Reuse the previously fetched header
>       */
>      work_sccb = g_malloc0(be16_to_cpu(header.length));
>      ret = address_space_read(as, sccb, attrs,
> @@ -337,6 +338,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>      if (ret != MEMTX_OK) {
>          return -PGM_ADDRESSING;
>      }
> +    work_sccb->h = header;
>  
>      if (!sclp_command_code_valid(code)) {
>          work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);

I guess the alternative (and messier) approach would be to re-validate
the new header.  This proposal looks good to me.

Reviewed-by: Collin Walling <walling@linux.ibm.com>

-- 
Regards,
  Collin

