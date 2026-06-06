Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DDCCD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 16:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVtl6-0003hH-KN; Sat, 06 Jun 2026 12:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wVtkj-0003Wz-Dn; Sat, 06 Jun 2026 12:20:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wVtkh-0005g4-UD; Sat, 06 Jun 2026 12:20:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656FG2DZ399924; Sat, 6 Jun 2026 16:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FDDhww
 /H1YJvNkflohNyhTn8sTUv33BMmNs7KI5N6tQ=; b=isJIcj05Ue/TyQ2IYqkBaS
 xv+nFePfYwWJFBNBXnLG1R9p2rNovLtDvddhSy7kkS4Cyuuog313gPkgwWPcDzWN
 pKRinUpGjwyOLFum1K+egaThk8dInZXIoVABK2ATnPKQ/KsYhUgZVFJ/WIe02VVp
 +GXoYUVQh5BBsvaebYPnlhRjajimIXdpHDrtFbG7zajB6yqsV+SFDbbHG1+vVjKc
 ynF6wk2seZEZNOxhxleF5Y72KX9zEURTr2Q/9yOZLVEoxybpdYGJ0vQB4/aZCG1m
 6xgKsEg2FiZhiXPNt+UFJRjYsYT8N5SD7Yg5GhftiRy2VVwRYua2PSNIDHY/2e1A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23hgh9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Jun 2026 16:19:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 656GJqhW019043;
 Sat, 6 Jun 2026 16:19:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7kp8s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 06 Jun 2026 16:19:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 656GJome37749086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 6 Jun 2026 16:19:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5A7D58053;
 Sat,  6 Jun 2026 16:19:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCBC558043;
 Sat,  6 Jun 2026 16:19:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.143.205]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  6 Jun 2026 16:19:48 +0000 (GMT)
Message-ID: <86cc9f4e6492b169b48e33793208215f6f8c2265.camel@linux.ibm.com>
Subject: Re: [PATCH v11 30/32] tests/functional/s390x: Add secure IPL
 functional test
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Sat, 06 Jun 2026 12:19:48 -0400
In-Reply-To: <97f3b33a-17ca-4ba9-a714-20e70f7a7edf@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-31-zycai@linux.ibm.com>
 <ba1b75db4c3c110a7edae5a1753c32e5854a3ee5.camel@linux.ibm.com>
 <b82d095dd3616822279151e562e06689e3bd4b7b.camel@linux.ibm.com>
 <97f3b33a-17ca-4ba9-a714-20e70f7a7edf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a2448a9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=waOdMU7LWt82WyP_VOAA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: g0AZ_A4GLUR6OYcI0QG5ZKXu9koG_ZmP
X-Proofpoint-GUID: g0AZ_A4GLUR6OYcI0QG5ZKXu9koG_ZmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2NiBTYWx0ZWRfXyptF1MFSg182
 u4hbZpFEO3MT2Xe76FNr/503kdFB8rBV/dpxnen8HiBgGXnG8TegaaBu4W3Zzhw+uHzSvgFxC4F
 32f5pP/HdT1vGtncFmpA8QBSsLewJJFcIcig/EjoKPJ9cMOfEuvRhzpO3Q8aJb8RxPdMKS/4SaP
 wa9IGDouUufv6s9F1zSfuKJZYNRZbrLm6mLsaBNYtsFIA5Rq3GT4YR+uD3MpWrIeIYlSdepYyNM
 AVGWjnvwFlBNPfVkS8bIrD36O5zfNAdQAkCTZfICXRgg5seWeWJ9yosN+ecbVkxKYSjt08CkUd5
 8KHhFJd0MzrUJ1+fm/MhLPXP934dVbdxBbx18W7utO81kTG+jFCCBgD4AJL790dpu2BRs7pT1n+
 0ZeopNvcM1tcfQUFiXTY6pZFr8KvH3otjHbDZCWS6UHpwN5UjuSwpacbwCcRTuyl4zzxbGVREsk
 hMc/axDilNj3hsXUfUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Fri, 2026-06-05 at 14:58 -0400, Zhuoying Cai wrote:
> In your console.log, it looks like the components are being loaded, but
> the verification step is not performed. This might be because the test
> is not using the built BIOS image?

Ah, of course. I missed this bringing the system back online I was using fo=
r your changes. Sorry,
must've been Friday. :)

>=20
> For reference, here are the build steps I used:
> # ninja -C build
> # make -C build/pc-bios/s390-ccw
> # cp build/pc-bios/s390-ccw/s390-ccw.img pc-bios
> # make install

