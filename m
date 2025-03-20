Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18788C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 16:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvIrE-00005y-8a; Thu, 20 Mar 2025 12:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tvIrB-00005K-JJ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:34:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tvIr0-0007WQ-Gt
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:34:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KCS74I031139
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 16:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:reply-to:subject:to; s=pp1; bh=UIndsL9Auh5+YWWWQjK
 dUv1t4Cc9s0M+FoU8+wO8ab0=; b=YnQHGzclzB8NoQLDBbLVtxMMag0iUw5BHl5
 yDlPYjciXbhjfGpgniSzGOOYM/2gPel+igr6pkIdqyuJJE95V9LejheNdu6idADM
 6wJTz9FULf8ggNEdMtku4Y9mTG1dch0CpB/Xh0gaJIV3LwnrKHEZTBCmb3Apg4Y8
 9bSWSZImpRZDyNtCTMELQdJxbJ+QDGBTftjoBIbon0kpc8KoDzbbDGpW4U2SesHJ
 Yzg3wjO6x294PJ8bL/9QsbfkxFUFxqFQZolQVO1kscB9FB96hH3E3utTMMiE9gAZ
 rNgBSiJ5euE02UPi63ef6wkJmj1UskVeQ8EOvNHia0Mn0PuHiCg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gk21sdp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 16:34:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52KGNwlJ027900
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 16:34:41 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gk21sdp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 16:34:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KEUPBg031961;
 Thu, 20 Mar 2025 16:34:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvts72x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Mar 2025 16:34:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52KGYdei26608302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 16:34:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CB8258055;
 Thu, 20 Mar 2025 16:34:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C0B25804E;
 Thu, 20 Mar 2025 16:34:39 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 20 Mar 2025 16:34:39 +0000 (GMT)
Message-ID: <9d87fed729b2697605bcf5b6062669b6239e5c0f.camel@linux.ibm.com>
Subject: Best practice for issuing blocking calls in response to an event
From: Miles Glenn <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com
Date: Thu, 20 Mar 2025 11:34:38 -0500
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e77NKd2ffri314GvKeuJTO7k7ntV4Y8Z
X-Proofpoint-GUID: b3Z4I9pB0RcRVs-OV5tzXTG5XUNV4Dyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

I am attempting to simulate a system with multiple CPU
architectures.  To do this I am starting a unique QEMU process for each
CPU architecture that is needed. I'm also developing some QEMU code
that aids in transporting MMIO transactions across the process
boundaries using sockets.

The design takes MMIO request messages off of a socket, services the
request by calling address_space_ldq_be(), then sends a response
message (containing the requested data) over the same
socket.  Currently, this is all done inside the socket IOReadHandler
callback function.

This works as long as the targeted register exists in the same QEMU
process that received the request.  However, If the register exists in
another QEMU process, then the call to address_space_ldq_be() results
in another socket message being sent to that QEMU process, requesting
the data, and then waiting (blocking) for the response message
containing the data.  In other words, it ends up blocking inside the
event handler and even though the QEMU process containing the target
register was able to receive the request and send the response, the
originator of the request is unable to receive the response until it
eventually times out and stops blocking.  Once it times out and stops
blocking, it does receive the response, but now it is too late.

Here's a summary of the stack up to where the code blocks:

IOReadHandler callback
  calls address_space_ldq_be()
    resolves to mmio read op of a remote device
      sends request over socket and waits (blocks) for response

So, I'm looking for a way to handle the work of calling
address_space_ldq_be(), which might block when attempting to read a
register of a remote device, without blocking inside the IOReadHandler
callback context.

I've done a lot of searches and reading about how to do this on the web
and in the QEMU code but it's still not really clear to me how this
should be done in QEMU.  I've seen a lot about using coroutines to
handle cases like this. Is that what I should be using here?

Thanks,

Glenn Miles


