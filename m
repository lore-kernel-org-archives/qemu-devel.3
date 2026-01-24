Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3676D715C6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 12:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjcQi-0001OA-TL; Sat, 24 Jan 2026 07:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjcQg-0001NQ-VJ; Sat, 24 Jan 2026 07:07:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjcQf-0000hk-EV; Sat, 24 Jan 2026 07:07:50 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60OBOQQO009131;
 Sat, 24 Jan 2026 12:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=bybDDtTOH7sedwGrpLp3To3sRmZjl1
 sKskDVhrvJZ40=; b=eBVbmTWxJ7CO2NGvMp++jvk4Ld3VGcroFCPTwezLOFvpRI
 1xOE7OXZJKX1YXWo1g5g6CB6VDSkmX3VDDbXsnX3ZBT1A2NExtEbZcodb0irYadw
 0zJMolxGvCD5AakwYDIKlmjLK/9pbqrLMpsxy0SVEamoDY0UaXaQHL0oHdK95UE5
 AsTm21auYdXbf6bNqA5z5xRIEGiN+jSjTB2/UKdxr9mukC+4Ai8K+eotcE4vcogz
 96CElfLsrtpYk2qjT0iV4ykx4KRzVThGwFJoe4YaM/NRgnFzxy9FgdEypw6MDqNf
 uQ3W4Af+X3JY2AoyE/GzzYwXoMV5U3qCKwnUHG/g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr5s1kr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:07:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60OC3BNF011806;
 Sat, 24 Jan 2026 12:07:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr5s1kp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:07:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60O70EpY024610;
 Sat, 24 Jan 2026 12:07:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxasbskf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:07:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60OC7hg746596490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Jan 2026 12:07:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1583020043;
 Sat, 24 Jan 2026 12:07:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E5FB20040;
 Sat, 24 Jan 2026 12:07:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.49]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 24 Jan 2026 12:07:39 +0000 (GMT)
Date: Sat, 24 Jan 2026 17:37:37 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, chalapathi.v@linux.ibm.com
Subject: Re: [PATCH 1/4] ppc/pnv: Suppress some "pnv_chiptod unimplemented
 register" messages
Message-ID: <aXS1oRLD55eczjg0@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-2-calebs@linux.ibm.com>
 <1fa38659565cf4dc1dfe24cc365d685554faecf0.camel@linux.ibm.com>
 <5e13f2c3-2075-4d31-bddc-06dcc31f6eae@linux.ibm.com>
 <aW3wVCdyn3WkeUoF@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <6072a537-e18c-4d46-9142-36e9c25bb11c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6072a537-e18c-4d46-9142-36e9c25bb11c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA5NCBTYWx0ZWRfX77ccB8Icvqgs
 bjsYSabM/UtS1dSK+8fotQTNWjT448ql2sgR0JqqKTYsrv6zjqRMxdXARmTwCC2arVb0aAcHgTN
 lQx06bsjQVlrTRAyq24giw/vpCQP4LxfJbQlHdZxTsNFosbrqMzy+KpgjgHutRjJZE3WjZTO9Hf
 103dPPMfR+ZVlnVC+GVCysEWXk3Wgxnt+46yxToFq+k71kdU8lv9IbFuxDW6tKPuft8YuWRjbBh
 pUHTe0mWA2d5pccyQ1eTXYBdoHfvAgjE5wiqWCkXdqCZ2DAuvZcwoqP+TPmfUF6NLaBSTBMLKj1
 iVdJ8+8vUrru87ghYyqVP/5RPxD0b6CyFy/74+zQ2259cbxrIZsO+7zrdMzPwU/wgVrsgxzETSf
 cy11zx0QkESgOnsDPyz5y+DMGeAkI8QnuoM/E4/TE4jqzIYS6jKfuY/gc2hBiQAPBwC8O077Pli
 lwX6KFUatZB4uvL2j5A==
X-Proofpoint-GUID: SvSy1sKpVG98wT6KJC9zncnpBHEbTVwj
X-Proofpoint-ORIG-GUID: jplxo0QGOAQ3h3SHewFb-KAy5Co6QrGt
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=6974b614 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zemG__UicHLbtfz2P7kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601240094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/01/20 08:31AM, Caleb Schlossin wrote:
> 
> 
> On 1/19/26 4:18 AM, Aditya Gupta wrote:
> > On 26/01/06 11:07AM, Caleb Schlossin wrote:
> >>
> >>
> >> On 1/6/26 10:49 AM, Miles Glenn wrote:
> >>> Hi Caleb.  I wonder if it makes sense to upstream this commit since I
> >>> suspect that most upstream users will not have the "unimp" log messages
> >>> enabled unless they are debugging a problem and in that case, we would
> >>> be erroneously masking these unimplemented registers from the logged
> >>> output.
> >>>
> >>> Thanks,
> >>>
> >>> Glenn
> >>
> >> I understand your point. Here are my thoughts:
> >> - Cleaning up these logs for valid accesses (PowerVM bringup and development) reduces the overall log output and helps find real errors
> >> - In the future, there may be a customer that wants to run PowerVM with upstream QEMU. The more we upstream, the easier that will be.
> >> - In the future, we are going to have a number of cases like this where we accept accesses and don't log for every unimp access (to clean up log output). If we choose to keep those patches private and don't upstream them it's going to increase the number of private patches we keep, making future rebasing more difficult.
> >> - I'd prefer to upstream more patches, and focus on keeping only the patches we need to private (for confidentiality or other reasons). To make future rebasing easier.
> > 
> > I agree with Glenn that we shouldn't mask these warnings for everyone.
> > 
> > Since a warning saying a feature is unimplemented is better than
> > silently not doing anything without any warnings.
> > 
> > Maybe the excessive warnings should only be masked for PowerMV
> > development work, rather than upstreaming, or we can always upstream
> > once those are implemented.
> > 
> > - Aditya G
> > 
> 
> Ok. Would you like me to pull out this patch from the series and send out v2 containing only the approved patches?

Yes Caleb, thanks for understanding.

- Aditya G

> 
> Thanks,
> Caleb
> 

