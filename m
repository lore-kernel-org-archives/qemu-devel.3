Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C83CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCELc-00048g-Uq; Fri, 24 Oct 2025 05:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vCELb-000482-Ll; Fri, 24 Oct 2025 05:44:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vCELZ-00068b-Th; Fri, 24 Oct 2025 05:44:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O8ZpZk019199;
 Fri, 24 Oct 2025 09:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Ox0IwXrq3QIqPPP9oQR0eeKwwQp9+C
 Ayjz/lAbNiMCE=; b=kTtCIjcJasTNSh1cI+3pE180DVdjbZ/RL1QjlwTUj9GwS+
 b2FSeGOvMtp1vM7TZB5BEjJMuD/ptz+ZS8tmKIFOkmUmE+D+Qi83G1IA6H8Q/O5z
 k/AVCJ7bspWt3rgQLppjnpOcJ7c4bQwrL4dUIDV7hk92e88qO6RTHAX0t6KdgnpX
 y8KaGQ2dOne7hb0SYSZWpzFFRuO9WtaN2iQ8SM4bbCt9M1FkU8XIlq4ZC8y/Kxtb
 dGH3G9fZBY4vds5HLImST5OkXQSR3L5FVn915EwiJCwWiykKDyR3FCCgdt00g+m+
 dZi4+P+2d1fN8Zeuyb2njCBz4MDx4dIZtg8W93dg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hw0vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:44:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O9btCd000589;
 Fri, 24 Oct 2025 09:44:16 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hw0vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:44:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O61uBj011049;
 Fri, 24 Oct 2025 09:44:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1j6ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:44:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O9iB0a52429056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 09:44:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D75C20043;
 Fri, 24 Oct 2025 09:44:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74A6220040;
 Fri, 24 Oct 2025 09:44:05 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.221.189])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 24 Oct 2025 09:44:05 +0000 (GMT)
Date: Fri, 24 Oct 2025 15:14:03 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 richard.henderson@linaro.org, alistair@alistair23.me,
 alex.bennee@linaro.org, deller@gmx.de, pbonzini@redhat.com,
 eduardo@habkost.net, minyard@acm.org, gaosong@loongson.cn,
 maobibo@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 hpoussin@reactos.org, david@redhat.com, chigot@adacore.com,
 konrad.frederic@yahoo.fr, atar4qemu@gmail.com, jcmvbkbc@gmail.com
Subject: Re: [Patch v9 2/6] core/loader: capture Error from load_image_targphys
Message-ID: <pg226vepbq7c5ckwguxpysgirdj4sydgfl54c6wshed5ifqbvb@lu5rv4gaxokb>
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-5-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024092616.1893092-5-vishalc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0/ktVH8i5CTa
 AGB8LGqBn7BeNaYf0t1pbJk1G3vzFA2LvRcpkGX5pt2fbMheKy/wxG2nEIeK292m9Bxnn56yn07
 oC0mILhypaPZ1iMa6nNAlcMFd9HImpDjdf3zRFzyReZ5GFTtHNeSjwJKrVzRlFIWTkjRBqqwl7N
 wOfxL3F3+X9fEFfMoT1rarjp4o+uRS0T9u9rkKl7voqfelIA9ZQOUVuRLwFqlKpqFSi4bGvu7Xd
 KM7j3tczxtqHdoBktFwUrm18jg9weKCaCj0w+0t2Bsty6sMuMAQOJQIH2aIx/Tp6WwIzGHl3nuI
 BXEVNqemVrXHmwt8sPBCqRNGjJ6HSkITlJLe2JTvLHtjEMlSMlALgusy+EVtyFSrznvhNFRKTxc
 9/UHivkwQYLu574at/ooo5R4pcv6gw==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fb4a70 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=LniPDNFaPioPFOIVJ8gA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: rmcenrPoeGx9IRebROe0IZ3UpnHQ-bEf
X-Proofpoint-ORIG-GUID: P8t21JINeBaiFbl4cRFaMATHE_dRYJ0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 25/10/24 02:56PM, Vishal Chourasia wrote:
> Add Error **errp parameter to load_image_targphys(),
> load_image_targphys_as(), and get_image_size() to enable better
> error reporting when image loading fails.
> 
> Pass NULL for errp in all existing call sites to maintain current
> behavior. No functional change intended in this patch.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>

All tests pass for me, and changes look good.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


