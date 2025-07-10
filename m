Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E77EC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 19:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZx4m-0002Ki-Do; Thu, 10 Jul 2025 15:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1uZx4j-0002JK-MF; Thu, 10 Jul 2025 15:36:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1uZx4g-0003Wy-Qw; Thu, 10 Jul 2025 15:36:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AAbUxg006198;
 Thu, 10 Jul 2025 19:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rLOez3
 1NopuGksNr3NsgudXmFAYKJDF1nS0KPCvtuLo=; b=m01nfBNXqbCUS5quoekRcP
 R+rci9cXe7I9MXjbkWy7TJ0R8ZGm6rAlGZh6aqvedGomaSCsj2vYY3/PVUccyFfM
 QNiUK24vmxSxnwqaMbFY7AOI0wJidSPFrN05C7cshdnUuR5sAedTyBLFHzHiBZ5S
 eJJvApEFyBVMqPyji5wAxKKZMR9RAwwkC5/NPu5cEhZ/158frZo6PaRfOpvq9DR9
 yJSJ2Qk4PyfE99rjs4zt2cYxFJ0yGRNsB+fpqQvdQDrRlqyWJZc2jSr646jbQwuf
 w1C6ostSYb3/QWGAqmMCHCEE2riSPGavDI5S7fCRM3ZUSHxWTkIkQpZPuWh52f1A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4evdx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 19:36:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56AIToL1002888;
 Thu, 10 Jul 2025 19:36:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmq30b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 19:36:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56AJaiwp58458594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jul 2025 19:36:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB36920049;
 Thu, 10 Jul 2025 19:36:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5068820040;
 Thu, 10 Jul 2025 19:36:44 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.142.138])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Thu, 10 Jul 2025 19:36:44 +0000 (GMT)
Date: Thu, 10 Jul 2025 21:36:42 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Matthew Rosato
 <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] hw/s390x/s390-pci-bus.c: Use g_assert_not_reached() in
 functions taking an ett
Message-ID: <20250710213642.05b84fcb.pasic@linux.ibm.com>
In-Reply-To: <20250710161552.1287399-1-peter.maydell@linaro.org>
References: <20250710161552.1287399-1-peter.maydell@linaro.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE2NCBTYWx0ZWRfXxCW6bFxTpL6o
 SoHOc4Z8zLP4roD6Xbz9COISJgBhRPU0q1iodY+3J2Dd1sTTOtXr9/BxpMeXs8r/Re8RIMy0hme
 EPXDwIWRyOBo+RZ17V+o8L1KQ4BbZ2fnZfY38NropZWQ08ajIb6JLyGtS7/paG2LPB2hEI4ybHU
 J3R0MCFM4/TzXc+e8JoYbgG+hlSo+ZoVVfK1RUAZmvXzUsCSRVEopVSY6HnaqaSZMKvHVqiK7Gc
 5QsIQpXXZ+PZuDUWyVgA5Dw6jKN0KVw0Tuees39OSPjcqrXhKrOIrIBi/Dgusen31Oo8LGWTM2O
 bjC9zrLt22wRjVDrON9eeYIfRwNw/ml4aYkMM2uIv3jvFetoPaIr8pL0mcHEu0y7vOQDAojrtrF
 Z6JM4tZ+3FV45i/PbpkIrGT/SDZTLzNoAilHyACQBaNq3McZMzIkSpKkZVrIESd6TsK163Sr
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=68701651 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=qypPl32umXsh2WFSjfYA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: UaUIzHj5pD8fHO4sCX0LLMbzUMvwM62G
X-Proofpoint-GUID: UaUIzHj5pD8fHO4sCX0LLMbzUMvwM62G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=405 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100164
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 10 Jul 2025 17:15:52 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> The s390-pci-bus.c code, Coverity complains about a possible overflow
> because get_table_index() can return -1 if the ett value passed in is
> not one of the three permitted ZPCI_ETT_PT, ZPCI_ETT_ST, ZPCI_ETT_RT,
> but the caller in table_translate() doesn't check this and instead
> uses the return value directly in a calculation of the guest address
> to read from.
> 
> In fact this case cannot happen, because:
>  * get_table_index() is called only from table_translate()
>  * the only caller of table_translate() loops through the ett values
>    in the order RT, ST, PT until table_translate() returns 0
>  * table_translate() will return 0 for the error cases and when
>    translate_iscomplete() returns true
>  * translate_iscomplete() is always true for ZPCI_ETT_PT
> 
> So table_translate() is always called with a valid ett value.
> 
> Instead of having the various functions called from table_translate()
> return a default or dummy value when the ett argument is out of range,
> use g_assert_not_reached() to indicate that this is impossible.
> 
> Coverity: CID 1547609
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

