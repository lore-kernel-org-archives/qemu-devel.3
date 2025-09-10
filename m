Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A866DCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 23:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwU0U-00083C-HG; Wed, 10 Sep 2025 19:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1uwU0S-00082t-IC
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 19:13:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1uwU0Q-000709-5f
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 19:13:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGQevb006132;
 Wed, 10 Sep 2025 23:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=k5t6Vp
 Tzc3N/7GT+LTNxed80CzS8usLxqtv6zyOOss4=; b=GwYnaxpO7stq+Aear9zK9Q
 WeQaG58y/9BBc729PPFYI3iGh7Cqw0OtV1OgWct0GVOTLRK558EbTi4NL3pwtFVU
 CtQqFTWgwRq7fJgdTboWy3DwVDP1pqFnFn/KpgK8bvGa8HGEwj5It4tUuJaVhyh8
 vzfyw0Au+hJGtUomhoTJIDAYLVYrTWcj5lLeyuYuV4rLpLNZA9j22bxnoy8LD+TN
 to+mK/9mqTGbXxSCocH0mHSIQKUOspk7IrWusCAIgN7LYQvew3Ozsk4Cfd6L7dLm
 Q/zznWMFsX4gwi2JxoZyNymrV2EvdwXO7YatfkdqbIoWYSDwWDGctJhaqsNykr8Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx19fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Sep 2025 23:13:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AKPWIH011435;
 Wed, 10 Sep 2025 23:13:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uk7tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Sep 2025 23:13:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58ANDYl820841196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Sep 2025 23:13:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27EE858062;
 Wed, 10 Sep 2025 23:13:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5CF85805A;
 Wed, 10 Sep 2025 23:13:33 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Sep 2025 23:13:33 +0000 (GMT)
Message-ID: <8623c898-a0e1-42d2-8afa-35b64e41cc50@linux.ibm.com>
Date: Wed, 10 Sep 2025 19:13:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: swtpm persistent state snapshots by copying .permall file
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com
References: <20250910210849.GA379545@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250910210849.GA379545@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S_hmGn2SA8iKjn1XKs2D8mBqDalsWLRH
X-Proofpoint-ORIG-GUID: S_hmGn2SA8iKjn1XKs2D8mBqDalsWLRH
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c2061f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=QK0sd-mKpoOOYBSSQ6sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX17e7FKUu920E
 KVWeDMVCLyenRqHzllCTIqcgzLeE9VIdNqxNP3eWLf2FDDOM5LHqM+1fPA/TTk8EMPKfUdIYu/0
 c20GssSUMJRXEug3Djob/KJxaDxYY1K1Or4R6NfJSel1dlvuDvttLtjAvLwSJ8mWxANfhfTdO4t
 mzwOKSSXbtAws40OnGyjAj9aLXT1CMOS6VstkoTlNO6yZ5uXCGoGY403QbzhsHW/QmC/p/YHJn3
 jTWDGIIjueXdCM06BBaGHle0Y6WJjopsJ9Qa8rbyVeWUZof5ZaZ6XhA7rAy6KsMCC3EWll5k/Yu
 8Y0rC3S3IGKb3qVhrTAme4oamD0YPYHVXb0ZqzFpqN/2cBFxRYzHCtkrKGSBI9/Vmhx9tZ0Y500
 biatpmc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 9/10/25 5:08 PM, Stefan Hajnoczi wrote:
> Hi Stefan,
> I am investigating QEMU devices with persistent state like swtpm for a
> specific snapshot use case. The VM is paused while disk images and other
> persistent state files are snapshotted. This creates a crash-consistent
> snapshot similar to booting after power failure on a real machine. No
> RAM or volatile device state is collected.
> 
> My concern is how to ensure the swtpm's persistent state is captured as
> consistently as possible, but I'm not very familiar with the code. I
> wanted to run the following by you:
> 
> - Using --tpmstate dir= will write the persistent state to a new
>    temporary file and then atomically replace the old .permall file using
>    rename(2).

This is correct for the directory backend. We also have the file backend 
where a single file is keeping all the different types of state.

> 
> - If the VM is paused and a copy of the .permall file is taken, then
>    this copy is consistent. It may not reflect any in-progress changes
>    being written into a new temporary file, but that doesn't matter from

Correct.

>    the snapshot point of view since the VM is paused and it hasn't seen
>    the completion of in-progress TPM operations.

> 
> - The .volatilestate and .savestate files do not need to be captured in
>    the snapshot since the goal is just to achieve crash consistency.

Yes, I think so since the .volatilestate state would be written only in 
case of VM suspend or migration and the .savestate only upon suspend-to-RAM.

> 
> Does this sound reasonable or have I missed something?

No, I think this sounds reasonable.

> 
> Thanks,
> Stefan


