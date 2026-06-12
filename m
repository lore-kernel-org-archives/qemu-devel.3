Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC9ECD4F2C
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXxPV-0002su-Sj; Fri, 12 Jun 2026 04:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wXxPT-0002s5-JX; Fri, 12 Jun 2026 04:38:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wXxPR-0000n3-UG; Fri, 12 Jun 2026 04:38:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C0ku7g3872855; Fri, 12 Jun 2026 08:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gcBgbB
 GUOCD3ZwSrD2uVkR4e8R7LbmX63xKp00JodTA=; b=Gb//6tAEbhUE38ZCkC+oBR
 SCwCKTc/7TwxLphIGjlqgtwX7o2+IwJLrGbTAFWZHOHckRH7V2iY6K3pCVOV376H
 5bx3++LFuO+idxGioChXSIZtBcHyP2VKqMwd02JAKnXOG1cFr6nCbVX/21gUJkkC
 da+qO29Ej4+0z2wvmotfP5YXi9ZGZRrDYnHJH1E2lk7ERVafE5CEVPNczzqdYOwa
 UDsWGArseLtKlH01Y2+n8qYLXGl/X68as0FHhLMI71ziSrTeMMVzunUd//qDEWGP
 PhyYxPPGonn+oZOk0fHrgQ+rQ7lNw8hUSbE1xs+5S3D/IkeyFfLqAKf0e/o5hKKg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8f011t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 08:38:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C8YfGi004178;
 Fri, 12 Jun 2026 08:38:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08y19p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 08:38:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65C8cTVB49414538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 08:38:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4533A20049;
 Fri, 12 Jun 2026 08:38:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5003520040;
 Fri, 12 Jun 2026 08:38:27 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 08:38:27 +0000 (GMT)
Message-ID: <f2d03d6e8b00fac6bf2b53f7ef8a8704edfddecb.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 09/28] target/ppc : Convert mcrf to decode tree
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: shivani@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Date: Fri, 12 Jun 2026 14:08:26 +0530
In-Reply-To: <20260520160728.2283628-10-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-10-rathc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3NyBTYWx0ZWRfX5JJpJ/Ph7Jzh
 RZFWxuO7AZ/8zWcHNHFPHA0sQSKVmDxFkNv7hPnwnch3jdM1e3wNLCjv7mhbXECGGoD03SpwgmJ
 PIq02hUI3hPRoGl/koL5EkMWrNj2biyYVGMdBQ21SujIKxeKGZwNkvls/+vr4VRXDLHHUS0RKPF
 0/PYyr9PzLilNxL67VPSxXUtncdaKh4n8hjaVGy7DdusIKPhBw1WWzUpNwk7kPAaElkvzz5EPze
 5qjJw7q74BcEulZ4aQHvSM9VBoOrMjIPxj3LAtw92a6DJwXpueMt18+QTBCeS4tHjD18kq/zshl
 hOcfb8cTncG+vu1+utXph+YQHcqvO6TDkknmKczZn/ihacbTe6P8v+8ku/7wD+JAYqi4sG6vr3P
 XzJqt7O4rIsxyVvQSLGY7j4HXsHypHHlkETCO+Qz1J2X0xMIV7haBUPxj9tM4xC0g6dsQJUxyAz
 rgWscoexDZf1icZSS5g==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2bc58a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=A97UytvfOSDpyFMRTnYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WpUAePFCdpi29asF5e3tcT4V7tfsfS2u
X-Proofpoint-GUID: JAqNanZ6zmJOA-bMOEzUYwPgrnPCfKAE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3NyBTYWx0ZWRfX2/HdijqQPFNQ
 R5EW/M1S/vD/aDCqwP8BYEyIRbU3t8aFNYyayP9s72RRPgg38iZpzN9WB5HgnGCs83zzjlnwsyt
 g6g0o0ldoJHdcmmlDslu7sDnvsQZQrI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120077
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Wed, 2026-05-20 at 21:37 +0530, Chinmay Rath wrote:
> From: Shivani Nittor <shivani@linux.ibm.com>
>=20
> Convert mcrf to decode tree specification.The functionality
> was tested by comparing the qemu -D log -d op,in_asm output
> as well as single stepping gdb.
>=20
> Signed-off-by: Shivani Nittor <shivani@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>=20

Hi Shivani,

 It would be good if you can change the ':' in the commit message.
ill list down the before/after.

 target/ppc : Convert mcrf to decode tree
 target/ppc: Convert mcrf to decode tree

Patch LGTM.

~Shivang.

