Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65614C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmYR-0005SS-S3; Wed, 19 Aug 2026 16:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gra@linux.ibm.com>)
 id 1wwmYQ-0005SB-3B; Wed, 19 Aug 2026 16:06:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gra@linux.ibm.com>)
 id 1wwmYO-0004KG-GN; Wed, 19 Aug 2026 16:06:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JI1ThH013300; Wed, 19 Aug 2026 20:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=LbaNCd9GeNRXM1bzLfc9GgTLmtJGb/
 8mX6RiOg62634=; b=fXkUgYzS3/88H0v1D3ip0U/FYBFKD7k4l/MydNraW9CW3c
 aiRdlPjr0/+imI6H2reANTIdOILUHArJUd+Ayn4KsfkOuTEU4y2oVhpVILyJOKCL
 T6ove/tNwOZKV6iDzqhI0O7OTBpG4vEC/WhGVGkfFDnWOI47AXstCmls+I0YZZNl
 m9NT6mbORodw/iCmaTSGsl2J6ns/ZX9bebR2P0+Z+Pb3TrZXG+LVOgHhCY0WhQMM
 h/w3qdYFPUufA7uV4CW3t+4cXXwfMjL3C423wE+mzzWwLB66zV2lirtWEXfpVBM1
 a5B5HSC9dUtpUcx5wNtDckcHy+VfZWRWJmtdgjSw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0e02t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 20:06:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JJuPaK031040;
 Wed, 19 Aug 2026 20:06:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhany2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 20:06:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67JK6IHx44171646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 20:06:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BFC420043;
 Wed, 19 Aug 2026 20:06:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D89C20040;
 Wed, 19 Aug 2026 20:06:18 +0000 (GMT)
Received: from localhost (unknown [9.111.9.197])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 20:06:18 +0000 (GMT)
Date: Wed, 19 Aug 2026 22:06:18 +0200
From: Andreas Grapentin <gra@linux.ibm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, philmd@linaro.org,
 qemu-ppc@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] hw/vfio: all vfio files can now be common files
Message-ID: <aoWvPGCSA54hg_Dc@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
 <20260318174733.1717643-9-pierrick.bouvier@linaro.org>
 <aoPw6-MGBcTOfxwp@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
 <29fca8f4-9730-4090-8c89-813ba5c248fb@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29fca8f4-9730-4090-8c89-813ba5c248fb@oss.qualcomm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a860cc0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zNgnGU9ftPZutWwzgxkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: izDBaksXE7srXo1eQpXTAl1H-QC0NxOC
X-Proofpoint-GUID: izDBaksXE7srXo1eQpXTAl1H-QC0NxOC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE1NSBTYWx0ZWRfX/dM/3/kGBmkY
 RF8NduIvY7qHuSmeQs4lJcoLUwBY0+5SLq+AM4ptHUA0c/Rv5crIeLEHqQrQOPQ8tE5cuIiuGYF
 e/k/RUBgL9jFT+O0w+Ip6D4XYyZgMco=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE1NSBTYWx0ZWRfX9LvH8aKmTdKq
 TbNjzOcfBHCkyMeJPyDLsxsovGq7iDWb4R4PHYaEusY9ZZvYZ+LKKHa4FXRw8ZWkm8+4TtQKJCH
 OlLd1CpzBjvxf/XjtIaj3FGgVfDFOON3c26vPmmSixhRaiOj8GmjneC5JYBIVAOABkqg6F9HO/L
 ufuENeaYAjEkaBooMQXsIHfgzByCU9ffWih+xeF1JsOEEdNiZN0qWdZOw7XmFCZI+7z9W5geC7e
 /VJq5U7CKyDXtefghDgcVhM0SGIwJVrq9NuhPcg4ZL5b4uORV0jqtrpNpnS9sH29fLd2tRL2Skr
 hoLJc4lwTUTremq7q87yBY/Z9Xg6LYX9C3/LCqlDFRoqS1MgFiTDUaAsALff3uABA7ODuRzML5u
 K3lSH9Yx3WO3iYJomfG5aRkrBbi/UPseavxNxC30Dq+KJbuRO1SxR7tTLocW8gwwpgF0LExAScw
 AnDnvzbwM/144atWAVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gra@linux.ibm.com;
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

On Aug 18 26, Pierrick Bouvier wrote:
> It would be better to keep it as system_ss, since bringing back
> specific_ss will break the single-binary compilation.
> It should not be needed to rely on target config within the C file
> directly. At least, we didn't meet any situation where it was.
> That said, there is nothing in CI (yet) that prevent such regression,
> but I would appreciate if you could keep it as it is for now.
> 
> If you need to filter a specific function per config
> (host/target/whatever), the right way is to isolate this in a new file,
> and condition inclusion from build system instead.
> 
> system_ss.add_all(when: 'CONFIG_X', if_true: [newfile.c])
> Also, you can add associated stubs for other configs in stub_ss.
> stub_ss.add(files('newfile-stubs.c'))
> 
> I don't know the details of the series you sent (and too big for me to
> take a look now), but if you have a precise question on a specific
> patch, feel free to reach out to me by email.
> 
> Regards,
> Pierrick

Thanks Patrick,

To give some context, the linked series enables s390 host linux KVM to
virtualize guests with different (non-native) guest architectures. So we
would need to build (on host architecture s390x):

a) qemu-system-s390x with vfio using asm-s390/kvm.h, and
b) qemu-system-aarch64 with vfio using asm-arm64/kvm.h

which (based on my current understanding of the code) would make it
necessary to build the kvm-helpers in the vfio code twice, once per
guest architecture s390x and aarch64.

I understand that this is a problem for the single-binary efforts of
qemu, and needs further thought. We are currently trying to come up with
an approach that more closely aligns with the single-binary goal, and
any advice you could give to that end would be appreciated :)

Of course this problem extends to all components in qemu that require
architecture-specific components of the KVM UAPI.

Thanks,
Andreas

