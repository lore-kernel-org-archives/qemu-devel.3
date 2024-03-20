Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9BDC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 18:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn0JQ-00037X-13; Wed, 20 Mar 2024 14:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1rn0JM-000373-Jd
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:05:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>) id 1rn0JK-0007vB-Ti
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:05:12 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42KHLuc1018977; Wed, 20 Mar 2024 18:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oCqsQOg9a9GWGwX5ar56+8hBbWrcY0+ijdFkdIu0pHI=;
 b=NOVmgNrwk/bIjRbTsSm4EFjBEWzpBJDioe9ECa596OZQfeA8CCH9TBA4eAEA3wkpQ66I
 +t9Rvq65FJ9ESE3RCe46FNWP+D3Z8WbWDPCM1HOHp5YquolewlrOYswspf+3gXKzYqIW
 1rVZmVDtS3+gwyHza9Xk2coVSNvmI/7CcVGvp4GRIz6nDqSAwhEEWe5tBcBu+FF6/HSv
 VbvLl/UR2b7GmCSHWuP5z6jNS/vwlFlXV/gHuSXIruaPtXIvS8DtcMGl/uCGoQsW7g+k
 NBKEazs06cHbUA0gYy7KUtJXyCkkQq2nypFK2Vbsg8vXx9nY81rSgejdQ3D8qRFtbMrj tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x044s84nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 18:05:08 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42KI57bd028352;
 Wed, 20 Mar 2024 18:05:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x044s84nb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 18:05:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42KGwo1C015781; Wed, 20 Mar 2024 18:05:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50845e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 18:05:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42KI526Y10092856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 18:05:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C3DA20040;
 Wed, 20 Mar 2024 18:05:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 452AE20065;
 Wed, 20 Mar 2024 18:05:02 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.238])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2024 18:05:02 +0000 (GMT)
Message-ID: <87e832c1aa59b81860f4c6a7fa6935d5c1268e85.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] migration: Drop unnecessary check in ram's
 pending_exact()
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Bandan Das <bdas@redhat.com>, Julia Suvorova <jusual@redhat.com>, Thomas
 Huth <thuth@redhat.com>
Date: Wed, 20 Mar 2024 19:05:01 +0100
In-Reply-To: <bc88f4572649084cd38a0880d7e096a939f80b14.camel@linux.ibm.com>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-3-peterx@redhat.com>
 <bc88f4572649084cd38a0880d7e096a939f80b14.camel@linux.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZYaae2uyHhXamDd_4CEbz7vE2f9G70bT
X-Proofpoint-ORIG-GUID: wHWjOQZCpOLcNGJnj1lZPrVRTDM8Zk1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 mlxlogscore=516 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403200144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

I cc'ed Juan, but it looks like he is no longer with Redhat.


