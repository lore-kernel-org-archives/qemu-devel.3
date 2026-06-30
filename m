Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F520C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 19:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wedh9-0008Ej-Kb; Tue, 30 Jun 2026 15:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wedh7-0008E2-JD; Tue, 30 Jun 2026 15:00:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wedgz-0003GQ-SZ; Tue, 30 Jun 2026 15:00:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIK152428613; Tue, 30 Jun 2026 19:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ElTZQC3ltpWU8XHXG0tTGEayNitJcZ
 fvL+dMd8vptQk=; b=AZjEU9t7x9lweDtVI9S3zDBWbyasYQ+DucxzzJbZOvCBuH
 QN+xN+uHF+T875ibmEhvxxzEy+G4n7o7njVmZMgqSe001NWIEGhpeF+lH309QcLW
 CuiOrnlVeLsJYBinodG0C7ZYlRSVAXZiqTj/DX2QGPgr6kUcDm+bVYZ89PyA17kO
 PSL9FNUmnnU5h8fXKTgdP3DS6q9TQxSQUKXyovRaugh05lpKSuU3RGXCV0Z0FA1Z
 DLMj7WUd1CxkkkPhArip2SWyQWTiDpY4sVTCFtE6FJ+Cbi86fJo2AC3aReX7QiTR
 ukfmhjDAwFBpyjBnMbcFSbhxpzP8lqLABX5gnHEA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg0ktt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 19:00:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UInb7P011224;
 Tue, 30 Jun 2026 19:00:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w3wee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 19:00:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UJ085661604280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 19:00:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 849192004F;
 Tue, 30 Jun 2026 19:00:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C8FA20040;
 Tue, 30 Jun 2026 19:00:01 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.35]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jun 2026 19:00:01 +0000 (GMT)
Date: Wed, 1 Jul 2026 00:29:58 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Message-ID: <akQRrF4jFTUTPxSz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <2870a679-dc81-45d1-a686-c1b0aaee98f2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2870a679-dc81-45d1-a686-c1b0aaee98f2@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a44123e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=mwgEtBXlT-Sc2TMNPJgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MSBTYWx0ZWRfXyCYKn3UpIR+k
 wQpCtjzQ83Op838D6gqt5bDtJSWPMf5FVPYcw4ps3J6P7eQQ8OOq/2W2IdlmT9vAMio0bgTMo56
 llHsh29KKGo3WWh0AMJZybCkUvH8gPc=
X-Proofpoint-GUID: eiGriTlqa3wDTInjW5TI8xwbsY1D1_ja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MSBTYWx0ZWRfX0Pt9DA8xK2dh
 wExkxZK4LikVZk0BrweVJDIrPGku5G1H6nZdBgBiOmA35WhWG2Boi0fWc/0CNAWr6ArwcgXvwcf
 ycYPQPywSeqO8wxgq9cNceWA2DgSO/O/Mr9Unz/GZVpAd1oaMqK2v2IfBuMjILgapEI8/PIAeUD
 BW65XGnjDrEmdWSDCNQBGq8C41qWh61qtbv3pQbEEEWwsu5KivDbxoRSFrVpJq7GSskpyfWjnWM
 QXhpe4QXjXqBOr2SwUzq5XNsQhwgZRnH+BwXVyPWnhcgIeaT4aHags6Jd8pz8xeNkS3Zl9FTlXb
 ssnevMLISQnwi6EI1ibo24xAM6u1gRhUByeQyuK3pqpUY6CL9gwbuHFHWNcFfjP7QZdxQbb7Uyz
 5u9mM+2Q0zBjrnvQ8Js5MP1lx1wsn1Ry01TeuQYFYOxXtFvB2UgZhkNT5LPJ1O5vLQmXX6I0YAb
 Ly9df9I94hrkXNZEa7w==
X-Proofpoint-ORIG-GUID: MvG9Ho1s-CiVUgFPwc0ESMWww5axuaXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300181
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 26/06/30 10:08AM, Nikhil Kumar Singh wrote:
> Hi Aditya,
> 
> One comment below regarding test coverage.
> 
> On 23/06/26 19:49, Aditya Gupta wrote:
> > @@ -548,7 +548,7 @@ static void test_xive(void)
> >   {
> >       QTestState *qts;
> > -    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
> > +    qts = qtest_initf("-M powernv11 -smp %d,cores=1,threads=%d -nographic "
> >                         "-nodefaults -serial mon:stdio -S "
> >                         "-d guest_errors -trace '*xive*'",
> >                         SMT, SMT);
> By replacing the hardcoded machine type here instead of testing both,
> QEMU will no longer exercise the XIVE2 path on Power10.
> 
> If a future change breaks the Power10 machine initialization while
> Power11 continues to work, this test would still pass.
> 
> Would it make sense to run this test for both `powernv10` and
> `powernv11`, similar to how the SPI qtest iterates over the supported
> machines?

Since power11's interrupt controller is the same as power10, power10's
xive breakage should break power11 too.
But I get it, safer to have both, will do it in v4.

Thanks,
- Aditya G

> 
> Thanks,
> Nikhil

