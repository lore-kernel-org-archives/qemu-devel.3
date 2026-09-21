Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0591DC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f0M-0001Rq-N1; Mon, 21 Sep 2026 10:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x8f0K-0001R6-Cr; Mon, 21 Sep 2026 10:28:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x8f0I-0008TX-OV; Mon, 21 Sep 2026 10:28:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LE5STu569071; Mon, 21 Sep 2026 14:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=wWYT12yGRJMewJpr4L4YJ9SoIVM9Wo
 Ovm7fGfebVhEI=; b=eNmYUfcbJ2tL2EbTUDcu9cD9fh9t9BI3u3/ntXcon/LiM4
 LFqkpaGTVO3SZd58f3UBkEakCym45oDkQMKkVCu78mDLTqy0n8yXtzPpBPSudpvz
 Zb1Us023ZxdKTvrHxNSnnn2JGVRMAaTSysAbOC8iUUs5t2MrnZX/U6A+0GvOVyI5
 WU6M/Fu8x9kFeHve1y588+fIKzwq8nAEQRXdHn9RlSboq78AvFGjE2v1w2zaSK3r
 jno55y7/G39HOuVCFNdhsHMkllDJuQ0CpWYc9t+RsTuSIH675K3nhO9+uWiQ2Gzn
 qsiSYx1GvmzE4x7kG2unvoF25jrDQY3ptn09uCNw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq8usd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 14:28:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LEImPB085247; Mon, 21 Sep 2026 14:28:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bk882n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 14:28:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LESEXx48103890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 14:28:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2129920043;
 Mon, 21 Sep 2026 14:28:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A2C220040;
 Mon, 21 Sep 2026 14:28:11 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Sep 2026 14:28:11 +0000 (GMT)
Date: Mon, 21 Sep 2026 20:05:58 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Aniket Sahu <asahu1x@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peterx@redhat.com,
 farosas@suse.de, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 gautam@linux.ibm.com, thuth@redhat.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v3 1/2] tests/functional/ppc64: extend pseries migration
 tests
Message-ID: <20260921200424.d70a1a1a-d5-amachhiw@linux.ibm.com>
Mail-Followup-To: Aniket Sahu <asahu1x@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peterx@redhat.com, farosas@suse.de,
 npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.ibm.com, 
 harshpb@linux.ibm.com, rathc@linux.ibm.com, anushree.mathur@linux.ibm.com, 
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com
References: <20260921081010.31778-1-asahu1x@linux.ibm.com>
 <20260921081010.31778-2-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921081010.31778-2-asahu1x@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab13f02 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=MxYpeiGA4uIaQIGk4oIA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfX6GEM2NxYcPHc
 UavAywinJn5UOv0mQL+Y95MxkselapOoqdUkO5wNc1RPKfFtQaeT1zA09D3BGs9I6DpBFV7d64z
 h8jYHgRJiKHds3BdkEek5X8E6+02Byc+Z7WyPaK0VkHvE8RMIXHYCuSYvwUL7vsNDBAdAA+nAyy
 9ejU4kumkaIA7pEbLt87ZxObRxvZkU8apn3wCkNZcv6zEwERZn6xcdhz/JBHFrJlR8qR+kgvx/N
 B5MUe6IwzB8mMCrn0K4MKObZc4X86FVCtTVY198v8XqsrRXXcF0RbYl7j1PsV6ZNZI5YZh3KHul
 zE1lh96Hnol0F+G13x8khmUA0cJl+7+ln6WXLEtp2nr4bZ59IhWfbho2WdhYZQ2Dxx2XpA9oMzO
 1oXJIqsvZs8WZxavuLqX+LuRZRZjJxIa6ueqaz0n0iR32uhxuGfja8sfxyxvhQ1t735ApGBpg/1
 /kyr8r33fUPLE7ORT9Q==
X-Proofpoint-ORIG-GUID: Ho14F06c6zjArZ7r7KUKAaLCn_13e81k
X-Proofpoint-GUID: bDEhimkmI45FlMNB8eVNVgyzSeuXZi8u
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwNSBTYWx0ZWRfXyX93sO0ZcmN5
 BkUDrpuREqt0eV0aIyiIDBwhxQU638v7FBsWjLYAzvndxY1PXEOMm7fitYOIld4vP2/sFM6ygGL
 K3XaDkeQAx/E7tKtyC1TOc1GaSrR8AA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210205
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/09/21 01:40 PM, Aniket Sahu wrote:
> The existing test_migration.py exercises all three migration transport
> paths (TCP, UNIX, exec) but only against the mac99 machine type.
> A regression in pseries-specific vmstate save/restore handlers would
> not be caught by migrating a mac99 guest.
> 
> Switch the UNIX socket and exec (socat) migration tests from mac99 to
> pseries so that these transport paths are exercised against the pseries
> vmstate.  The TCP test is left on mac99 since pseries TCP migration is
> already covered by test_ppc64_linux_migration in test_pseries.py.
> 
> Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>

Yes, this covers exactly what we intend to.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

