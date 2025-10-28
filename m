Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841C6CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDguf-0001To-Nz; Tue, 28 Oct 2025 06:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDgud-0001TP-Su
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:26:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDguY-000319-44
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:26:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S2KKwf032230;
 Tue, 28 Oct 2025 10:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Hs5e5c
 5AgKhcNhncTG0Lw1PdeQ1Wm0qn1/6HFdrPlTs=; b=FrXlbRnTNZGbD1hSX7HQbQ
 aO/ZQafUFsgisT8eX0L+fwqdKWYut7O/Z8OPJ+2Fw2D28PQwp3YClYmTnLga5CbY
 UL7AYviIXwSwCNXhYwqdQF4hyX6Yt9HLwfAwDXzi1+1o1WoWCP6Aqemm62IwIoJg
 jmjXYJnmjf+7ozxlgQdRYeACrGeolwpOSMMFPxEkmdGc0k0QwYlUKG5VeFbIv2uT
 IphypZqGmLwtnGnjMEiXV8gw9H2mkCsObjWuhMNsszQ/nYjzasys2+jLcwmJzifk
 vdMIgEALJV/orF/1W8pipOdYveqapFg5k2EyB7lvETbC6BqJKnExPVH1wAJYVnBA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kytb964-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 10:26:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S9Sv4i006764;
 Tue, 28 Oct 2025 10:26:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk11w96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 10:26:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59SAQVGk33030540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Oct 2025 10:26:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B58C62004B;
 Tue, 28 Oct 2025 10:26:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C31420040;
 Tue, 28 Oct 2025 10:26:30 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.28.67])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 28 Oct 2025 10:26:29 +0000 (GMT)
Date: Tue, 28 Oct 2025 15:56:21 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 qemu-devel@nongnu.org, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2 2/2] hw/ppc: Fix memory leak in get_cpu_state_data()
Message-ID: <6latikvfa5655eqib5sa6erpqw6ezqj3sufu2ywr2ng3lporsq@wgz6bwe5h56n>
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-3-shivangu@linux.ibm.com>
 <7ab9ffda-0229-4357-a4d2-aec451c1e301@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ab9ffda-0229-4357-a4d2-aec451c1e301@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CJyFmxPTYJLOpUGRSE6lgWhyqEfiZmLD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX7qEdJxVuPMh4
 ZehR/PhvwPq0sCNOhYMKLWHc3Gb7FZNA17SAT2s+UhMDftzEOjczPzrytbfty6mHRKJiMit2/Jv
 lHRBx6Xze07XNKdJzk9/2C9zutrBViZq0nXgUJfGqT5gkuksaNJhAZAAaixjMKI8EfUsYam70y+
 pz2qnRw0Ovga8O6DUNZn9JhK757xeb1CyBDVzD1MTLRk76yOACF5mw2PUjs7GqExqU3fB2eCkum
 ECqmhuCauGv8zNXGH/F5I64CohtCCggoFoScbj5bUN7Y9BuXOYXTgX5iT58CxQ9gQ40e0GSUAuO
 LG+Cz2wYH0l3dh5ASZRdXvf/fQdjS4ZegQfYQR6HF/tQPEQuDGePWRNQFcTVu29jaM303+JF8Fk
 EX7DHG+WKeBQQDA/QdvtOahoPxN25A==
X-Proofpoint-GUID: CJyFmxPTYJLOpUGRSE6lgWhyqEfiZmLD
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=69009a5e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=TUQEyA71JNhs6LHU3ZwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Tue, Oct 28, 2025 at 09:33:49AM +0100, Philippe Mathieu-Daudé wrote:
> On 28/10/25 09:05, Shivang Upadhyay wrote:
> > Fixes coverity (CID 1642024)
> > 
> > Cc: Aditya Gupta <adityag@linux.ibm.com>
> > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Link: https://lore.kernel.org/qemu-devel/CAFEAcA_Bm52bkPi9MH_uugXRR5fj48RtpbOnPNFQtbX=7Mz_yw@mail.gmail.com/
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > ---
> >   hw/ppc/spapr_fadump.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Thanks

~Shivang

