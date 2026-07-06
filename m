Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DFFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiPU-0002Ja-A0; Mon, 06 Jul 2026 08:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dengler@linux.ibm.com>)
 id 1wgiPS-0002JG-Uo; Mon, 06 Jul 2026 08:26:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dengler@linux.ibm.com>)
 id 1wgiPR-0007kv-FY; Mon, 06 Jul 2026 08:26:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666BIQhQ3447697; Mon, 6 Jul 2026 12:26:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hzloyd
 7p/2Wzx0QUJxr6FRX8Je7l5Xm93r2lV//8uoc=; b=GaS7jsyLK0ERjGPi+Hx3TK
 2GSpGSO18NR0oE2ejURg6uXUyFgWYfEi+7bhu85kYvCE9nr55xIHGf4qyfN1QlAd
 Ikdb58uCO1nBHaVEfNL8lcr46TEMZvw6FqjpwiDaZXalUD9Dg1L86BWTGj2YBY0C
 x7IsfW2ETOIp4hFmuWNARHG94frrYUifOuCzLf0u2p4Tcv/hl6Yoof1SgWilqNro
 GVIe20Q9xJ7aNluiduMrHyn7ZPIYlCDTdmWhbf/FeYALWigXx0HvjyksZDtElGKE
 GlnzunWONLNJqFyYApZ2BzjDMT9q1I0PB00esrB9vZlKAhI/40TD45BnxanyNhgg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stshup7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 12:26:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666CJciX030483;
 Mon, 6 Jul 2026 12:26:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfw9jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 12:26:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666CQe5I51380522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 12:26:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E834B2004B;
 Mon,  6 Jul 2026 12:26:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AB6120040;
 Mon,  6 Jul 2026 12:26:39 +0000 (GMT)
Received: from [9.111.8.43] (unknown [9.111.8.43])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 12:26:39 +0000 (GMT)
Message-ID: <28950379-427f-4b23-8247-721d25291799@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/21] target/s390x: Fix wrong address handling in
 address loops
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260706094317.17032-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2E0q2gMvM8wE0EOVMPe5jUEK9mgRdk5L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyNSBTYWx0ZWRfX9DGogk4eMUjH
 R0e9UxMwBBA69xRv6mj9P06qAv8uCtU5q23j0+krdNrASLlsw0CyV0pE+0NA0QtUS0i5VXIqPCs
 AIcikyfm2R9ntn/N6vElq12Q8nF7Vzs=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4b9f04 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=sR4FTfRTi0JzboByPSsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2E0q2gMvM8wE0EOVMPe5jUEK9mgRdk5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyNSBTYWx0ZWRfX48b2OgbuCXWb
 uHaPKmy8f2Q/ORXtQ9ANuCO5r9IS3DhRRiLdmq3r0GKfQezuensuF7Xn8325EQPaaMdOo1EliY+
 03DJ2DLAS4xJ7IHadK4/xDQvFN4M2enxJhQJRXpiiLVErFStwgVYV1qsbz1d4NX8xgkUzIQC1hP
 4/r6qRsFt+bhuyStwCQeRokqWsR70tDlRVAmXoLUwcKgxPIByboe4ELZ2OSxAKESKUpj0XgTOUa
 q4Yg5Z9dFVnsLAXZ23GpmpOnQEPdQzlds1h38XWUzmJhxPbV6JHmhYFOQ8lKW5uDjvlNC/l0ziO
 B/lGDOIb2GO4GUAao4wWnn7YvKHGdt6wjs5JoFHh+Rs+1ZEhJCWJnOtglcharzuIO2cdflhAIjJ
 yCoXJ8EEnc1vpDnRCzp5NssXadYtSGvOiwQuNEstIO9RmvdjOu+inecQGe0m/7tQ+hQvyb/4l2A
 qEPoH7ERzsdjpOMsrqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060125
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

On 7/6/26 11:42, Harald Freudenberger wrote:
> The loop increments addr by the element stride (+= 4) before calling

+= 4? The code says += 8. Which one is correct? Please correct, if 
necessary.

> wrap_address, but then overwrites the loop addr with the wrapped
> value. On the next iteration the stride is applied to the wrapped
> address of the previous element, not to the original unwrapped
> address. This results in every element after the first is read from a
> wrong (wrapped) address.
> 
> Fixes: 9f17bfdab4 ("target/s390x: support SHA-512 extensions")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler


