Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A9AE7DEFF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmwmL-0002Fk-2W; Mon, 02 Feb 2026 11:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1vmwmJ-0002FD-0b; Mon, 02 Feb 2026 11:27:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1vmwmH-0007BR-H3; Mon, 02 Feb 2026 11:27:54 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6123jWGf023248;
 Mon, 2 Feb 2026 16:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:sender:subject:to; s=pp1; bh=rXBseiwrz41JCTRc6vCb8PE
 eMR5XOcksa5Auws/K+ck=; b=nBnxneMqHIh9VG3s54Z+vKJXMH+McSYipXjmbW0
 KE/pgZtJswvUvxhdUkqO1To0bXvBHLgT/azyQmW0VU4DI5al/RK1bL3yak+tI2CV
 dEXyTV8fclxpdJOl6MMZNaEQQJ74jneuni09TMDolRNvFYn2jnKuDFAOdSbQtujZ
 +zRj6rTcgC7p3ZJeZfC7u5/53GSjEVoq5QW8MnDHRKxl/q3UnY3SIaqTWjXBZOy9
 mbzlOWEHGzmCAWRUpcfI5NxFwxmpzzeQKDpLZUubH7y8sFGD+aWOCmsrIigiELWG
 Gl58IqaGx+nfPxKLqpNUOa4+JFGUDgF8qXMsZpYJnscU6oQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19869bgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 16:27:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 612DFhCW009544;
 Mon, 2 Feb 2026 16:27:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1vexwv6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 16:27:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 612GRiOw60752372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Feb 2026 16:27:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD09220043;
 Mon,  2 Feb 2026 16:27:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C248720040;
 Mon,  2 Feb 2026 16:27:44 +0000 (GMT)
Received: from vela (unknown [9.111.10.25])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  2 Feb 2026 16:27:44 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
 (envelope-from <brueckner@linux.ibm.com>) id 1vmwm8-00000000Mxy-0jZN;
 Mon, 02 Feb 2026 17:27:44 +0100
Date: Mon, 2 Feb 2026 17:27:44 +0100
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Replace backup for s390 PCI
Message-ID: <aYDQgE7pHgWK1rpc@linux.ibm.com>
References: <20260202144702.1783102-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202144702.1783102-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyOSBTYWx0ZWRfX8GtrKlpEwIJW
 obosfIlWMOd94Xl1vFAcpMrtsXgfTaGXc2+t+gMwARcqJyyHsMqg/IlSh25f3ILptXqDRoSy4VV
 oy9na8Ada7Ksu2lC2X6tziZjbgFB/P+eBpoed6p6LY84ioJymMOBK1nuNrt5AlTPyHE0SKLeRAe
 K5BJVZZDcSrpyxl9+UAheV6uCWl4pDP+SALC+83QifkUFwQptlh9pKS1V+JVdUb4exdsAB60EZX
 UWsNmru7LsAAS0WpvikdhWn/3d3Ig7Ehk0y/EFY00pRtH5M9wndYmU50cT64SteRje1PFz1rB8f
 hAmMR4QQqTzJN2ljxMd+XPvIfwJkDjDgVbi7jYodY/RHHfTwKjlIdqs0YmqXwPCERDddpdM3tQk
 sDR6XU/zG/dvgHNOPMhO72E+LLqR0kRdO/3UGttRw70gZhIggfIHyQ0UjOfIpav0BmK8Ssv+Kzi
 v0mMiBHlPYonUGz0m7Q==
X-Proofpoint-GUID: sws2frFFIxEXBEZj6LYeSmBxtGmqA7SZ
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=6980d086 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=STK_0p3wlTkmVyiQI7oA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: sws2frFFIxEXBEZj6LYeSmBxtGmqA7SZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020129
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 02, 2026 at 03:47:02PM +0100, Eric Farman wrote:
> Farhan has been doing a masterful job coming on in the
> s390 PCI space, and my own attention has been lacking.
> Let's make MAINTAINERS reflect reality.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Thank you Eric and Farhan!

Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>

