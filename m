Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB9AC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 09:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzYKt-0007o5-Jr; Tue, 01 Apr 2025 05:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tzYKp-0007m3-5V; Tue, 01 Apr 2025 05:55:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tzYKn-0003xg-Ff; Tue, 01 Apr 2025 05:55:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318tbKj030174;
 Tue, 1 Apr 2025 09:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SzBQEX
 XccBivTCr0ImDQNwdyedqMvF9iEtxzmZKNl/Y=; b=rCN6TkcHdqzI+A4Wwcahcr
 4uyW3wUxCVw89NnR7DJQ5uipu1YD6ah14IfIqSZcGmiB64NagMR5DnsHj0WnYhbK
 wAg7f77bKqpqqIrwS7byXFQIL7R3m6sa+kHEb4dvkVWimN+9u+BohgCUsrZlxGp8
 jLQmrEKrJh/kWT3EqfSYMuRjpSI7tVciA51t12lk5Ul6vBrsvUPnJo+PVv3O4F6C
 JxGNPnR8FjYXe8XGBi6FxOsiAKdc5H9ziC0crINmQYZSI7fAxrgmzJr+jUm0gYKM
 EIOXk8Bov+m90D5dw7PDCJ9yLNE+48kMKADmcIBErokFgQ/uEcN+Hpq69Xg/X3dw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q2u2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 09:54:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5319k4HU009875;
 Tue, 1 Apr 2025 09:54:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q2u2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 09:54:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5318vOOV009923;
 Tue, 1 Apr 2025 09:54:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6nsvxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 09:54:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5319snhI33947916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Apr 2025 09:54:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D91EF20040;
 Tue,  1 Apr 2025 09:54:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3DF220043;
 Tue,  1 Apr 2025 09:54:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.128])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  1 Apr 2025 09:54:47 +0000 (GMT)
Date: Tue, 1 Apr 2025 15:24:43 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v4] target/ppc: Deprecate Power8E and Power8NVL
Message-ID: <k3ick2ilcc3h4nkq46uavibuw5zg7otanutr7syhyynpakcteh@uu4ia2nmm633>
References: <20250330211012.2932258-1-adityag@linux.ibm.com>
 <805a75a4-07c9-41f2-9456-d74b414ddf89@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <805a75a4-07c9-41f2-9456-d74b414ddf89@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hwp9FXCLr1J50RZIGCQJw8KiSQISmpDD
X-Proofpoint-GUID: mLDJKNwjQj1lUn1URvGg34vZcmONVRq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=662
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010061
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/03/31 01:37PM, Philippe Mathieu-Daudé wrote:
> On 30/3/25 23:10, Aditya Gupta wrote:
> > <...snip...>
> >
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for the tag, Philippe !

I will be posting a v5 with this patch split into 2 as suggested by
Cedric (one introducing the POWERPC_DEF_SVR_DEPR, and another marking
power8e/8nvl as deprecated).

Should I keep your Reviewed-by in both patches ?

Thanks,
Aditya Gupta

> 

