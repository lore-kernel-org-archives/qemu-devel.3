Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE19C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyV4y-0003md-4g; Mon, 24 Aug 2026 09:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyV4r-0003li-JC; Mon, 24 Aug 2026 09:51:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyV4n-0006vr-G8; Mon, 24 Aug 2026 09:51:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1kjR827102; Mon, 24 Aug 2026 13:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kX9ITE
 iB6ngJenI+5uyyGG+eM09WzTpCZxw1mDKJ7GA=; b=UNME/NXQG87eRv/ZTe3zOY
 mZ/2MvGDIPf6kw0mzvtyH+M1MyFPluzCrbS6U6XgQBoPozZunGlB/9Cz40JOWCna
 ZFaAgJ2EKKBGSSRlMutTad88ODUyqdC7vHNqKtPyP2dZ+m+sbihUVrufchjhsPtA
 HoM3cO+f2FL559fdBFanQ1qfNtl0TvZeoY1TFHLDqch9AGGzXbf7CL1tf/KPcwbR
 3eWITxCZVbVUCcN/06oQ6Ol+S2aRLBXtaoF25++KgN7V0AVJ10+dl/1LPmOnUT+d
 UqzQfHu58QcyHN9cTES+GAavbkngmmvRXjp7zKTdhVxJ230NAXLLAn7u4JRvM41A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e9q9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 13:50:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODfI7P012520;
 Mon, 24 Aug 2026 13:50:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag6285-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 13:50:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ODouro24707778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 13:50:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E769A58056;
 Mon, 24 Aug 2026 13:50:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 160265805A;
 Mon, 24 Aug 2026 13:50:55 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 13:50:54 +0000 (GMT)
Message-ID: <b3ee53d8-1fca-4023-be3d-a312d485d7f7@linux.ibm.com>
Date: Mon, 24 Aug 2026 09:50:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] tests/functional/s390x/test_secure_ipl: Skip test
 if SIPL not supported by hypervisor
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-3-jdaley@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260812152112.3330493-3-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c4c41 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=tjU8C3MUQQN9MwWinqsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX55GdpxdDEBl7
 tMFMK7vS8zKHXZr/UxwvuDf8ODv4UZLZEiihORKrFymYIo26dlQsam+e56KYzzmuSyppcbFkeXP
 qayuCbwnc+rFaekSvxHAs5irXsbVVlc=
X-Proofpoint-GUID: LjvitC6RrHD8GSdlx4XyBy93H6W67UtZ
X-Proofpoint-ORIG-GUID: LjvitC6RrHD8GSdlx4XyBy93H6W67UtZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX2kklK7W7a18r
 nBEZ049AjvTwMJ/Ea6NeUeAesSukFNdiqwSFHUK5RMdXPmfjf7o/xozOKCoTPXOylL64d/xXQFZ
 OJsEz9RHHFd2qUJMFU9DF+4uZe6DQzcEpwA2Ck93A+JiuYdB9d2EkouO/6i5ydwSQMM7lav6W8M
 rJbkLz61o2kXcHKAyzUya7HQbq/akS2I/2hkGLsCHvnTs/af84cAqJgDHuSwM4eMBOAdrnsKiFL
 KSVOWrClWZtIWHsK8DCQIGLPRU8LPpiq2umZ2KmE3/aPwlx/JaKrGU8HrEY4HLHYS9guoJRQgBR
 u/w8u2SI873D3rn+O3UGRXGSX14M1xeJxGQEYd2PU8SBp2Sux6Afe6gBOXTMp7eHqpYWtJrPWMn
 E+56yrPqq5OndPRgDQFJ6sxquRlTiBVsafZJIbsvufBnD8M7vD16vEOhj/1a2+7gPqINPeApM4H
 nQGqe73k02QymZ9Uzdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240114
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 8/12/26 11:21 AM, Joshua Daley wrote:
> Currently, if secure IPL is not supported by the hypervisor, the test
> will fail because "Verified component" never appears. One must inspect
> the console log to observe the cause of the failure.
> 
> Add a check that skips the test if the host CPU model is missing the
> secure IPL facilities.
> 
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



