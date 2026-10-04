Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E258ECA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDQNw-0005PY-B6; Sun, 04 Oct 2026 13:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xDQNu-0005PC-OJ; Sun, 04 Oct 2026 13:52:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xDQNs-00088F-K9; Sun, 04 Oct 2026 13:52:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 694F5kB12138807; Sun, 4 Oct 2026 17:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=klR4s/JJWJvNbJtP6DohWDso5wDgVd
 wDAk4ZLNvB13o=; b=bszE8gAsJoi/4sXXtEIWIj7ruuUo2wONG3BxtOzwCeVfES
 lxMK7ZefTbLNIfbsj1w5cSVYuLlkw1OJ+uUe4EjwttgvWo3mxWLl1lfB5PH3N9yf
 CSQk7VlayqoOz0fgBRD3ReSIjHervnI3OJxqsT0pa+WI+ZXpCsKXBB+//xlNXY4a
 uge5EAI7sYLWY/629swnKrrM/DvbAMe9OB4AW8hHmikRShNBLQOVY8nq/XnQ5X28
 mEIkW6W4AnkNjeTggqCTNHbWsNhvNkms/89jTj/287NOWw++sw4RAwxrFpMyRSW7
 mq8M+O9Y6Qi4rArPsx/jX81MWFsZ/BI3hZLbsYUQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbuww3u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 04 Oct 2026 17:52:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 694ElYWB248355; Sun, 4 Oct 2026 17:52:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g2382-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 04 Oct 2026 17:52:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 694Hq1iV42336680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 4 Oct 2026 17:52:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4B032004D;
 Sun,  4 Oct 2026 17:52:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2E2A2004B;
 Sun,  4 Oct 2026 17:51:59 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun,  4 Oct 2026 17:51:59 +0000 (GMT)
Date: Sun, 4 Oct 2026 23:30:10 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Kirill A. Korinsky" <kirill@korins.ky>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PATCH v3 2/5] ppc: Raise decrementer IRQ on zero write
Message-ID: <20261004232816.f03c1a83-be-amachhiw@linux.ibm.com>
Mail-Followup-To: "Kirill A. Korinsky" <kirill@korins.ky>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
References: <20261001230058.11465-1-kirill@korins.ky>
 <20261001230058.11465-3-kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001230058.11465-3-kirill@korins.ky>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Hk3pVMX2-FeeM-5xzY3ueOGcP_kmFFPb
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac29246 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pcZqCyVeAAAA:8 a=mGm42c9pDIVS9U7J-8UA:9 a=CjuIK1q_8ugA:10
 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-GUID: ixIzEelWmFngriIEgwy46UWZZf0S5tJu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDA3MCBTYWx0ZWRfXxP3WgJFgoEAy
 I9CiOYkGvwlHhphPxrXCWQseiX66uReI5dqJFSeaHx3YWr6lGQyTlddecrtE43MMq+sjSIJS7Tj
 tqBK9JDJWMpQ7yfkKj8lHYLGSimkVYOT0s517ll5is0CCRTP5TQYluM+IRDjxdpYWkHGkCQh5tz
 hoLkFVYSzuPtQspuXSdpwOV6/6Eg1Qt8OK4kccWrE51I/B6s6H/0wkTa+KMgAa8hoXBIL87eNTW
 6w+kKIN5+ydQ6K/rSEwL0atyCRUgtI9gt5lcVEmvqS4TuV3XpQogSgqcy9WOe6hhGbrXxXlCmNX
 6be4Y4COm7IlN8bm3okaxvRAThD7trDy2B44UMd2QqO6YJU7sqyvR8kuAd8IJNLmyLjrkj0ekRN
 du4lZ3PvuHWUvGibhF6/SMlp8JzQMSDl82QXKLUyjdPuiVgUxM8bWyVB7VPGDlc6v4rjrunBrmk
 dVkS3EKQfNQcCezdhBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDA3MCBTYWx0ZWRfX13+Ldwkf1SH1
 Zd/lAo7ijDffeTlL8dlkpYhUeeWTmFLacgyNN6Q+gr1b9vTz2E4yQLbQxm+9eJV5gO1OVxLs8EP
 2VKZYCtx/jy/FN4FDND+gk9yghSf/Tg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610040070
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 2026/10/02 12:59 AM, Kirill A. Korinsky wrote:
> From: "Kirill A. Korinsky" <kirill@korins.ky>
> 
> OpenBSD writes zero to an edge triggered decrementer, then enters idle
> expecting its interrupt. QEMU defers the already due edge to a timer at
> the current virtual time, leaving the guest stalled.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  hw/ppc/ppc.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks for sending the correct fix in v3.  LGTM.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

