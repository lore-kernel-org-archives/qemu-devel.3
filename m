Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4A2CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc3LZ-0002yV-11; Tue, 23 Jun 2026 11:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wc3LX-0002xf-Ce; Tue, 23 Jun 2026 11:47:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wc3LV-00021z-La; Tue, 23 Jun 2026 11:47:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmTYA1826484; Tue, 23 Jun 2026 15:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Gtkvmz
 yOvMSiHb7TIr9pNrovy7WPNEp1CAGEcmPtwpc=; b=gWjEUJW1uCS9An39qLAg+K
 x2NEOgaQs8U6w1hl4c1LqHJJQPl2CT6WEKc4hrWq2sEngqe7k/LCqRcz0OOnitZQ
 jbfSGRSJy2ET4MHWxVBr2McEVlH+AeryPFYfbzvpqZ376fEq8tf5QIRAq/sZcwvh
 E9uhYCgc0Gj7uLWzXeH91Zp/ebX3yos9dQ5uEiePRZNYwFPsINNiADEBcot1AiJK
 FpVmepOIDmLPeUuMHRJZugJcXNmrqddGy3wR8cEhBS/WxT41hB1vv8aHC8Om3L9m
 QnPZgY3raM+P8GjkulF/E21fU5iFeRtA7ElHCOKApZrk9VakWB/ZxlcVmWZdB9YA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsqarm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 15:47:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFYelR004474;
 Tue, 23 Jun 2026 15:47:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg3v42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 15:47:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NFlMgw60817686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 15:47:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5262720043;
 Tue, 23 Jun 2026 15:47:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F03620040;
 Tue, 23 Jun 2026 15:47:16 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.220.40])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 15:47:16 +0000 (GMT)
Message-ID: <4de3eafc3c47799d0b503076b0d71be7cf261b61.camel@linux.ibm.com>
Subject: Re: [PATCH 1/8] tests/functional: Add remote interrupts test for
 PowerNV
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini	
 <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Miles Glenn	
 <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier	
 <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>, Anushree
 Mathur <anushree.mathur@linux.ibm.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org, Gautam Menghani
 <gautam@linux.ibm.com>, Chinmay Rath	 <rathc@linux.ibm.com>
Date: Tue, 23 Jun 2026 21:17:15 +0530
In-Reply-To: <20260623141933.577981-2-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX1xDUMZUjEflh
 8n6g3ymadaI2eM9Y0xCB/RMEykbQp4sU5v8+VAndh0OapyMuTa7wdUkIH+QVw0JV9euM7Cfq167
 VFiocndsfrMUfr+IH1ptb6cE9O90UYjPQ/npWJON1JQ9WAIO+KbMeC7OEX+PQCM5wzYOcow7ekD
 RjWJlKmSP24qSGjNJUdOjUDSz5e91HZY169spr7SZqWGZulE+Z5U/xbUqn6REDAw+JyMK+lKH/p
 lQAq/7V+2VwxgTIJq+dpRIa0HoQYmQQnLSY1YaDeB05gXpZtiQCgUB7tiHXD8KlI6Lr7+KeLajr
 8IDQYsxBktjdIV98KTXxxgiQpxTWKlTflCA/TRD78hEtm6JfwUPe/qlryxYa0QSIE3/OZUsw1r8
 LH1rZVCjy8YcEuYWkRAiw4jTjxIxNRTSgYVhnCFao0JOdEMKykua4CMizlZxMlF2yQBhoedk83R
 Ube/JsHrRkTtLlZ5zCA==
X-Proofpoint-GUID: O6XELPUimcVOMayUyA5uwUOYXGhCVKcb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX8T61LkzWp3Af
 JFLp1WV8L5/rlvM6nWENiiEu0OVmJcepCZkDNJ5CEbnybkwvBK1SsQdGt+gOcfODWkcrtAt+f+q
 irjMFk0hzau4FeKEUZHQgS9VZKTJwvs=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3aaa8f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Z75tzEJdkSRbXBlqtPMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JCECIRRxWS9Q60fhhPtVc-jXZyykSRF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check that interrupt counts=
 increased
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 success_msg =3D "Interrupts i=
ncreased"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.helper_exec_shell_comman=
d(f"export
> PASS=3D'{success_msg}'")
This is a great idea. Maybe in future we can pull this to a saperate
function? something like the following.

  self.is_booted =3D True
  shell_check_pass_fail_command("asdf")

~Shivang.

