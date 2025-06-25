Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A1EC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 22:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUYTS-0003H4-Qq; Wed, 25 Jun 2025 18:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1uUYTJ-0003D6-9D; Wed, 25 Jun 2025 18:20:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1uUYTD-00066x-Fn; Wed, 25 Jun 2025 18:20:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PJ96ux000567;
 Wed, 25 Jun 2025 22:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AjK0vb
 XwdrD9WpqFJM8pGOncavRnpNJY0Ji7n61FGEg=; b=ncOk9duo7XXJZsMRtvrQ6f
 Z2CWuR02xDoxHoK26tqpS4VYGwaDWGXokS0Hl6VLW5gYoepN8B9ZNfo5obR5Gj7b
 3hdiIJJwFtsl4wlBJruAGon+fOr204C0Of8tfNYqoTZ6vgtXAKgvBTrJOimWD7oP
 0dtYY8jrBrcBQ/jyShGtKY4b4IiXpenGTCOXd43OtAo4ca02FQQkDF+AXWtGUnw9
 k8JGHdI97PA9rlWFkhT6rFUcy0QCzO+rXzxpfmwt+Uzcn5vKjIhnK+Uwc7J3lHle
 4/5LRZEYM2Q4OKQlWCeEQBgH3b9iZh8RQzSFOFh8WqjjiUgtxksYQC7CfsldFDvQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jjahp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 22:19:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55PKhfhK030487;
 Wed, 25 Jun 2025 22:19:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7f03pd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 22:19:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55PMJf0X54657304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Jun 2025 22:19:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C38220043;
 Wed, 25 Jun 2025 22:19:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87E5C20040;
 Wed, 25 Jun 2025 22:19:40 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.66.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 25 Jun 2025 22:19:40 +0000 (GMT)
Date: Thu, 26 Jun 2025 00:19:36 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 thuth@redhat.com, qemu-s390x@nongnu.org, qemu-trivial@nongnu.org, Halil
 Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] hw/s390x/ccw-device: Fix memory leak in loadparm setter
Message-ID: <20250626001936.69cd77dd.pasic@linux.ibm.com>
In-Reply-To: <20250625082751.24896-1-kwolf@redhat.com>
References: <20250625082751.24896-1-kwolf@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE3MyBTYWx0ZWRfX+w9kGbt/5Agv
 Q2GI1zwyQ+1UL2KD5jJhISur5JKE6CwNYjhdSR5myyvptZxFxNo450TNA3wFuPM2j6DBtrUJU4o
 1xRn3ajn/Kx86gy2nXTPboqfiopM1cLLk8twNCnTARLmyXKHtkVwo0GOjqOVRVK2Z7wwgpHsrjY
 xlIPKHhadI6u8JWQLxyMHqznC9BdjBLcJhOpDYvyt13LqK6o1L6I+kg0FqlFzQes75VShG/XGJV
 cCZk8Pm08ihjfh4TpiSpyCvDYRf9JATLaQwDkrS5eV2WTNSa15UgrQSaUGKoR0I71805Pat5obP
 S2tRYg4d5Prpom7GESWW9BJGXWo5tRA4ZWihoOFd45nspBl91DodmcVx66GIKS91RLJRj8hIXz2
 B28sdZ3F1686nV+1+iFnHuSCedf3Bj/Zr6x7KYBJXK7kpUVSvnS1HNOFCVGwLL2KzVe2Q0QI
X-Proofpoint-GUID: uVePDg6TfuONB9-v3zw8CJpHeyFGP185
X-Proofpoint-ORIG-GUID: uVePDg6TfuONB9-v3zw8CJpHeyFGP185
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685c7602 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=4aWnE0LmemOYjQLa29cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_08,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=866 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 25 Jun 2025 10:27:51 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> Commit bdf12f2a fixed the setter for the "loadparm" machine property,
> which gets a string from a visitor, passes it to s390_ipl_fmt_loadparm()
> and then forgot to free it. It left another instance of the same problem
> unfixed in the "loadparm" device property. Fix it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

