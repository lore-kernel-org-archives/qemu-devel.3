Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6BBC98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jK9-0000sz-Df; Thu, 24 Sep 2026 09:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1x9jJv-0000sX-75
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:17:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1x9jJs-0003jp-Rr
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:17:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC65912190525; Thu, 24 Sep 2026 13:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6x/WU7
 B795GuO6bd44uf5jfhw4/mWkXamwyuWNfXH4Y=; b=B1bYnHFdZkOceMp01X7/nr
 uSZmmUenzEFmiiwVD1gwJvZwhB8WP2h2n9+SPwkClmzb8KxqJSKWkZHMR4t/GR11
 Q0GxgknteoanafDzMPr42aOIsKhfbl4N+TaH/LSqO3TH+Y6wR4O5WlderYhDVfS3
 cT6AMOx1oDP/vMbXI62SEkJb5tdgmAiUXxtWMQhohQNQ87JLkQhQeVbyB7gpr72q
 /xMMhDSSkq+rAxP9VeG/jIwycPU2Y51SbTLXazaVH2cTQFMLwG8OOg5I/6Wd26Lo
 0g/aM4ETGMwbXOgmUuyFTsH3V578VtSmch6yNmHTKoUw3CNBuh4oXg43LNqtaNFA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2sbqn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:16:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OCHWHb720138; Thu, 24 Sep 2026 13:16:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ea6w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:16:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ODGoRt44368276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 13:16:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D758E2004B;
 Thu, 24 Sep 2026 13:16:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 935EC20040;
 Thu, 24 Sep 2026 13:16:48 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.19.125])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 13:16:48 +0000 (GMT)
Message-ID: <59a6c0de163178a7571de6cf8a9530c14fa36c4d.camel@linux.ibm.com>
Subject: Re: [PATCH] accel: Fix qtest deadlock during unplug
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson	
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@oss.qualcomm.com>, Chinmay Rath <rathc@linux.ibm.com>, Doru
 =?ISO-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>, Magnus Kulke
 <magnuskulke@linux.microsoft.com>
Date: Thu, 24 Sep 2026 18:46:47 +0530
In-Reply-To: <87ld8s9kz1.fsf@suse.de>
References: <20260918140037.3082357-1-farosas@suse.de> <87ld8s9kz1.fsf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6HNuKzJor1lUImpLuVV1mSdPMQSqOhW0
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab522c5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=iCBkOSEqlL-OfskIUvMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX/H/tJtT/4HBL
 B8OIF4j/wCL+5i79aWFxv5M0arhZ3CrqH31pn9Gdd5oyQvcdQKEjagCbwFpFAv+yltltZ7Be7jW
 N9mWLBB0yyIpKgrb5Xw75rcvJQFp4OFKfTUtUFPs/V2F7CdWAEnW3GSoXIcZ6Z1YC9TaSn5l/qy
 XLOL7sV02dp8YMApm0q7rhc90YSpQHwfDs+5E5K2O0Bu5s/lga3HbKfwg647sTYuZR7GiTx2nzd
 eDaI4H3PQiexlcUvNheWBzkwjdT7lpiLIGe5tMR4j6e0lIlrPNem2YL49vVGPUV+L0+TE29GgxD
 L2exddX36YLboUAqSyj72Xu/jaOlDAKbcyiA55mqW4CPBZJ8Zwyr4cWl6vQWq8HN5/Qq67bmw49
 e67NCJ8kbWiQTCeCJqvqHqpI3Z0yYJBYAF+lnixUraXuMTMCoQtNxUtnPksFrM3lfz1N9HAyyPR
 fOQ+eplv5yHj1FWmCZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfXysZMUPy2ldA4
 Q5oo+jM5G9r8jYEUio7fD96wo+2k/kd/npBRlaD4ZPV4uhwvP6F6IfUjlABbA/I6FDYa+4LjMtL
 s0j0KpwMD8XOX0rWriMr8Hqtkxm5BsE=
X-Proofpoint-GUID: 6HNuKzJor1lUImpLuVV1mSdPMQSqOhW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240054
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

On Wed, 2026-09-23 at 10:05 -0300, Fabiano Rosas wrote:
>=20
> @Shivang, we're discussing about cpu_remove_sync() down in this
> thread,
> maybe that's of interest to you. Philippe is suggesting we could
> maybe
> move the call up a layer.

Hi Fabiano,=20
 I checked the dummp_cpu way to working, I can see you changes makes
sense here. I couldn't understand much from Philippe's suggestion. Do
we want to handle the case for thread waiting on sigwait, inside
cpu_remove_sync ?

Regards.
~Shivang.

