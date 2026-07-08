Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C01C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whRkt-0003g4-Ve; Wed, 08 Jul 2026 08:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dengler@linux.ibm.com>)
 id 1whRkr-0003fg-Tq; Wed, 08 Jul 2026 08:51:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dengler@linux.ibm.com>)
 id 1whRkq-0007F2-Dm; Wed, 08 Jul 2026 08:51:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668CIYjb2611696; Wed, 8 Jul 2026 12:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4fr5Z8
 jaeJAnVtnDCEgxtiyjvoXNWEUtgB9Au9CM2Vo=; b=VulJZy/o6IyXXMLUc939Vv
 LGwqRl4dnYZOcr3DxFwK7T67TRLiKEeVvuU1/ckhAEcMYE7dP4hl9o7TZy2mN61i
 lNgL+LjPptrXBjkHf3v9k8jspb+Xqy9Hdg/JL9DHwHBYPEXf57SzON1sJ5UgFIlC
 Ax4IaZBHrOCOsqdZ07Dv6fNijHMFtqiSG2GqCABTp4S9rigxJx9+P1J7PBDqNisu
 eK7Yw/8+FWWyo9X/+G8mveyGFqU61fXjKcoHfvH+R5g7t4DrrywSuTIeEYQPVjX5
 pqPj6FHj6RhvFX5WcNywxPSF1W2MyqMCVVEbg1GvX806zSZSsDBtyXdVQM917ZEw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdvvq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 12:51:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668Cneir018141;
 Wed, 8 Jul 2026 12:51:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg7tcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 12:51:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668CplLW42795434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 12:51:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C0572004F;
 Wed,  8 Jul 2026 12:51:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 320B32004B;
 Wed,  8 Jul 2026 12:51:47 +0000 (GMT)
Received: from [9.224.91.220] (unknown [9.224.91.220])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 12:51:47 +0000 (GMT)
Message-ID: <b3f83b4f-50f3-4ce7-ba11-3222189dd12e@linux.ibm.com>
Date: Wed, 8 Jul 2026 14:51:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/21] target/s390x: Move cpacf sha512 code into a new
 file
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260707161815.40919-1-freude@linux.ibm.com>
 <20260707161815.40919-4-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260707161815.40919-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4e47e8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=NEab9b4qFYDd8GPIx-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyNSBTYWx0ZWRfX4jRbVUJkUpcI
 ya5chEiwbScXmstVGvUlvDNDJNP5M06HUQsVezuGcC1KTJEvJNs8oEjdwRFGP30mwBMyxjzwAur
 Py3AVoZeeUzXqqE2jkEqYO8tJ2je9ZS0SR3OzRa07+r0CoWmxmu7CBG1bA3snq4nSmDE9tAJB+e
 Pj6+HH5xITWFei6DhAEXuFWCSNSVJ08y7KH4wgEsXkS//yAd0ooUsGfP5Aq9lSOlTALv3JNbLn1
 9IsJoEoyF3cbSREjWsJHgc5XJHzp997t1r/YQxyQ3Tu/la4IUiLwoiHjg9ZklqJcNTudvy7iLGL
 2mk2+d95TL/CF6i5oG9wjKTM+esaoD1E1uxSofSUhs/gTZwk9nmcvID7af1GR3SVs/kBMB4Hjkx
 rM9umW3xOXgGmNwTMsHfeV7wt7yzMxLZ26AGuPtSxo7gGfk6Vfvd6o2uFNE8Ld/EO5akVXI6a1h
 zZ2HZNMjUR4CzhGQb0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyNSBTYWx0ZWRfX13+erYrgpNoa
 9t8KSnnp2Fx7pXiRuWT/in4iLOnoYps4PNi7o9XjKuxO1xU6Qo5eK74Mk7IVMD7S85UTtZHc31B
 4kzNhaIFr5prYkO0ZLKXeiHEugqDkXk=
X-Proofpoint-GUID: Pbyl8WMYHVv-3MH3guog_nYQi3uT8oTZ
X-Proofpoint-ORIG-GUID: Pbyl8WMYHVv-3MH3guog_nYQi3uT8oTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=dengler@linux.ibm.com;
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

On 7/7/26 18:17, Harald Freudenberger wrote:
> Move the cpacf sha512 implementation into a new file
> cpacf_sha512.c. Add this new file to the build and use the cpacf.h
> header file storing function the prototypes.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

I already gave my R-b in v10, so once again. Please pick it for v12.
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler


