Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6D5CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY3d4-0001cu-BD; Fri, 12 Jun 2026 11:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wY3ck-0001c4-MR; Fri, 12 Jun 2026 11:16:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wY3ci-0001G4-Rs; Fri, 12 Jun 2026 11:16:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C0ZtJW3872942; Fri, 12 Jun 2026 15:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r23yJa
 OFctilcxBR0WQfypszN5gMartS/dWnA0jdrjk=; b=saXbdjAnz2a3zp9WTluV7U
 kr9kbE/QwW/+8AKWxHC+ZKFI1oCvM0g5WR6myRSF09s9SBQgGo8vr84Tcc1ipjBr
 Xy+sYEipsJ5MmgQGE5GklPrl8ZmSLqYQ5sSw0EsNJlMSoIZj+vz3GFtRMYcexbnn
 eWAwqoBpdCwnNPRqErEPVM87rbTcpjSV9rh6YkLDs7kjoCr9mOTpy3Ra1LTqiBkS
 85LIxD2qc3GxSL6faHqNJkA8JoznGWgWbvA8MhqYsOPpvMJvmwcLNpgDzMADvamh
 iBv8pv3MKXt6s1vWbxGoizjXF2pmXAO0gOHkjW2EV93zc684LYMWjpKcugRuptog
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8f1my8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 15:16:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CF4bdK028064;
 Fri, 12 Jun 2026 15:16:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe090ddy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 15:16:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65CFGaOm50856294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 15:16:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E88FD2004E;
 Fri, 12 Jun 2026 15:16:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE61A20043;
 Fri, 12 Jun 2026 15:16:32 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.27.203])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jun 2026 15:16:32 +0000 (GMT)
Message-ID: <abd149464ebb8c0dcff389b09ff7d1158c237feb.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 11/28] target/ppc: Move fixed-point byte-reversal
 store insns to decodetree
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: amachhiw@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Date: Fri, 12 Jun 2026 20:46:19 +0530
In-Reply-To: <20260520160728.2283628-12-rathc@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-12-rathc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEzOSBTYWx0ZWRfX7bYxCEwoqqEY
 sT9ZVZZu6qFRQ89UNXex6mHki53EJiM8BkHXYyHtJU+A+lQxfUh+VpcHF0+mygcGCK5LntYh9R4
 LwkB0DvxwtE49RNBs3JfjuA1RwbmPTaWeWnUREM6phdX7iTZlYs/YvENTzuxh2Kh4tjM7Rmwu4x
 eIc3GOUqmcroRCGJhvYlYVjiDNUSgECTCsB/lmU9Fm97x/m1UO+xlcon4tjqaBp0s6RDo+Edr2m
 w/1dO42JnKoJsLArSAVdveazr3AEdc6m51Dv983EqtGWl2DLk8J57OYg/emUidYQ8LX53mY64Ut
 mjwoFdejoMzAJkimMRliNyqPzbWDr9fHV+uRHrHDS0MqpS54PxO6hmNI/vjBHduTnbRGyoRTII2
 V2Ywjfq+yvhKBwBTypzsHW4RfuguEDt1qijZLH7mxSTR+YO5N1Vpv/BdWfCFQDyaJ/68nyMbBsB
 NOiOOTGlh6XwwGd91mQ==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2c22d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zKdSJwAEEZ6l6oyJNpgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: N6BkMT-UUMiP1LQrmT8b1xGx_1ZweUsp
X-Proofpoint-GUID: IjGnBafpcuATGPtwS-GsC4lWPybloc1-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEzOSBTYWx0ZWRfX3xnxyASNxYlh
 1b9ClrU2S1Uf7rf/vsdQp11VcqibHxab6wTiK4vM+26jLbBIe29UOW8y+nwaDWjjSm4IosSeld8
 s1cEKqLAuEZb0ZAys7gw3MQmDgz9Ph4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120139
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
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -372,6 +372,14 @@ STVDX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 011111 ..... ..... .....
> 0010010001 -=C2=A0=C2=A0 @X
> =C2=A0STSKU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
11110 ..... ..... ............. 0 11=C2=A0=C2=A0 @DD
> =C2=A0STCXU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
11110 ..... ..... ............. 1 11=C2=A0=C2=A0 @DD
> =C2=A0
> +STDBRX		011111 ..... ..... ..... 1010010100 -	@X
> +STDCIX		011111 ..... ..... ..... 1111110101 -	@X
> +STWCIX		011111 ..... ..... ..... 1110010101 -	@X
> +STHCIX		011111 ..... ..... ..... 1110110101 -	@X
> +STBCIX		011111 ..... ..... ..... 1111010101 -	@X
> +STHBRX		011111 ..... ..... ..... 1110010110 -	@X
> +STWBRX		011111 ..... ..... ..... 1010010110 -	@X
> +
> =C2=A0### Fixed-Point Compare Instructions
> =C2=A0

Hi Amit,=20
 It would be good to align the instruction format with the other
instructions currently it looks little odd.

Otherwise LGTM.
~Shivang.

