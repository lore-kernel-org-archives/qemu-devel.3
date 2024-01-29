Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7D4C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTX7-0008UF-6Z; Mon, 29 Jan 2024 10:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUTX4-0008U4-Qy
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:26:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUTX2-0000mc-Su
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:26:46 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TFCS8f006760; Mon, 29 Jan 2024 15:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4CnSOlmJgM2kEWYWncPNst85EqVWUky/63X2kdH10Ro=;
 b=GWtNVow1pDp9zpFrj1Bp9TwxFsYWUHTivkEcEh+wIPDNiqYfIuzgyLFVabYqKS9h0k5m
 q7MjsVHiEUXWnx+URvgHFTYTB1+OtpkCkN0AaY886DaGva2XKWiZSJIYosOvc+Ya3AM4
 uqeTqAccTVa7TD4JkZEhTAFQkIKQbRsUv0VlHaMN+N1oFOdj3QlYdkZTLAONqiHHTcKJ
 I6ZJGs1kD4cjUB1kgUnzUQJigLS98dIG39i9qEYpy77CUiFgtqXMj1XOzG25ghiaO+aN
 NgbMbt/uS1uEhZM/XQUEHhDt5nWvTIv0YdKO73e7jDjZ6J6QstxcsUSrD1PArzJRCcB2 jw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vxdy319kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 15:26:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TD3L7G010858; Mon, 29 Jan 2024 15:26:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweck8mwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 15:26:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40TFQdZL30933570
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 15:26:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2D622004E;
 Mon, 29 Jan 2024 15:26:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B81DE20043;
 Mon, 29 Jan 2024 15:26:39 +0000 (GMT)
Received: from heavy (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 15:26:39 +0000 (GMT)
Date: Mon, 29 Jan 2024 16:26:38 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 22/33] linux-user: Split out mmap_h_lt_g
Message-ID: <ogglz7yhvelvrnmfyhvpx7hjdl5rgl5gh3iioomtagi3mlckcd@qaa6w4javinb>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-23-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-23-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iOAiOz6qB7mLKmL5xIGcleKUjveSyOBq
X-Proofpoint-GUID: iOAiOz6qB7mLKmL5xIGcleKUjveSyOBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=697 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401290113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 02, 2024 at 12:57:57PM +1100, Richard Henderson wrote:
> Work much harder to get alignment and mapping beyond the end
> of the file correct.  Both of which are excercised by our
> test-mmap for alpha (8k pages) on any 4k page host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 156 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 125 insertions(+), 31 deletions(-)

[...]

> +        if (fileend_adj) {
> +            void *t = mmap(p, len - fileend_adj, host_prot,
> +                           (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED,
> +                           fd, offset);
> +            assert(t != MAP_FAILED);

Is it possible to recover here? Of course, we are remapping the memory
we've mapped a few lines earlier, but asserting the syscall result
looks a bit odd.

[...]

> +        if (!(flags & MAP_ANONYMOUS)) {
> +            void *t = mmap(p, len - fileend_adj, host_prot,
> +                           flags | MAP_FIXED, fd, offset);
> +            assert(t != MAP_FAILED);

Same here.

