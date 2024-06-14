Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A4FC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 06:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI064-0004lR-NE; Fri, 14 Jun 2024 02:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1sI063-0004ky-1o; Fri, 14 Jun 2024 02:07:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1sI060-0000HD-7M; Fri, 14 Jun 2024 02:07:34 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E4U1hu026778;
 Fri, 14 Jun 2024 06:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 JXrsJKstxKq8wswjFJ1S5wxfQ/Iy5jkfmrcpg5jrMv0=; b=aoWHnVUx9+uPWnuM
 xPVxlMUdtJtY+l3EiUN/l96TNsm2yf6p1HGhivjAwOc+xpJWiIOqxC1JPWI2YL5d
 Nfx0uhZy6WsqXJ1l3P5+NGywlofUORDUfmD71ieXcBuD8xAVQJ1ey1D3YRYMR6Iu
 QBv7IPQdHUE4WI6yzZWL8wD0p0GT7n2RM+de68oOuHcg/TR5YC44eVyMRw/aOoGi
 C3/RyzK3Cu8qeJ5762SB/qJmyG8Pdxo6zp+VYZW9aUbVhVyoLf3Vf3jkGbPgqQc7
 hJ+DFpkIIGKQf1giGYyEGwuPUtwk7XvTDhwUotQyA6c+sYzoVnC1SpOFQi0HSvaF
 SNY89Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrev687v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 06:07:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45E67ST5012187;
 Fri, 14 Jun 2024 06:07:28 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrev687v3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 06:07:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45E5DI7P023566; Fri, 14 Jun 2024 06:07:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn3un6d6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 06:07:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45E67MNV14221706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jun 2024 06:07:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25D792006C;
 Fri, 14 Jun 2024 06:07:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E0222004E;
 Fri, 14 Jun 2024 06:07:21 +0000 (GMT)
Received: from [9.171.17.142] (unknown [9.171.17.142])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jun 2024 06:07:21 +0000 (GMT)
Message-ID: <3c138eeb-83df-4953-bdc9-3cf8343a0533@linux.ibm.com>
Date: Fri, 14 Jun 2024 08:07:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Add a CONFIG switch to disable legacy CPUs
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20240613170702.523591-1-thuth@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20240613170702.523591-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QwNcGeXX-jNnop0UYdYY1Kry352u6Sti
X-Proofpoint-ORIG-GUID: an5o5ve2EebZ3LrJQq13zFFZPy9gn0-S
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=902
 impostorscore=0 suspectscore=0 clxscore=1011 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140038
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 13.06.24 um 19:07 schrieb Thomas Huth:
> Old CPU models are not officially supported anymore by IBM, and for
> downstream builds of QEMU, we would like to be able to disable these
> CPUs in the build. Thus add a CONFIG switch that can be used to
> disable these CPUs (and old machine types that use them by default).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   If you're interested, the PDF that can be downloaded from
>   https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history
>   shows the supported CPUs in a nice diagram

z13 is still supported so the patch needs to be fixed at least.
Furthermore, z14 has the IBC/VAL cabability to behave like a z13,
same for z15. (we do support VAL to N-2)

I fail to see the value of this given how stable this code is.

