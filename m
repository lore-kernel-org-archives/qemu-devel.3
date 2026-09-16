Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA408C982CC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6s7u-0001wy-OC; Wed, 16 Sep 2026 12:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x6s7t-0001wU-Fi; Wed, 16 Sep 2026 12:04:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x6s7r-0000Y7-Ll; Wed, 16 Sep 2026 12:04:49 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1YKu3041099; Wed, 16 Sep 2026 16:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wHuQkR
 cqAz31seByJNGJZoA6PPrxojX2LrpP4NqKFNA=; b=OxosSGT9ZE3qm3r/ylvaEx
 3Cf8Uet53bhkgI+iqcMJXLRN5PjOfoIGqgKzjzLE3hxxmZZSGhyU9P2t+aIUVyQ1
 G8bl5YQScu4AfU82N3ENReFqDvdYoGVzem1wE9+r1x90eVkn7GGB6g0oWnkiS6x5
 2dSnos/155jxsQ5hcEivgIhN+bRGnZdrhezCQOL3mjS8gKBr4UOF5buRdp6AZXP6
 nKGSUCbQowwYPmspZHqJHUm8/NGuo+2OUnt0HP8HyaO5A6/iYujfjZHOciwJufm4
 fGGPALHn36vuJYZbzORikdF4Fdzv8jgPQhvKUp9f50v9WY9n4gLlo53pV7lZ5Gbw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e5aat-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 16:04:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFe1hF1712957; Wed, 16 Sep 2026 16:04:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywey5f4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 16:04:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GG4MmM38732158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 16:04:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 175BD2004B;
 Wed, 16 Sep 2026 16:04:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AFB620043;
 Wed, 16 Sep 2026 16:04:17 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Sep 2026 16:04:16 +0000 (GMT)
Date: Wed, 16 Sep 2026 21:42:02 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-arm@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>,
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 16/19] gitlab: update the @user id mapping file
Message-ID: <20260916213951.50d6cec1-2a-amachhiw@linux.ibm.com>
Mail-Followup-To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-arm@nongnu.org, 
 Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Song Gao <gaosong@loongson.cn>, 
 Kyle Evans <kevans@freebsd.org>, Eric Farman <farman@linux.ibm.com>, 
 Brad Smith <brad@comstyle.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, 
 Laurent Vivier <laurent@vivier.eu>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
 <20260916153013.2134555-17-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916153013.2134555-17-alex.bennee@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIxOSBTYWx0ZWRfX2olmLrDHKMfh
 Me90o3ssNvx6iAXPOUpvX1ELQ9auKOoJMA1WX3EcipOK2iFJOGTkwYJ2woAs7oxJW2BDM8slTmE
 vIH02lNeRLaxtBiTvT2TUBXJOG+gSRdF8PvcRuOO73xQA9ywZQ4QN6+F+s5oH+B7IVRWx7EKZLI
 nr73XLXQ0mtjZYKRsMiPFGpvuRQngb/j1R0fG+odCDrXZLWD9NakkPSj+K6CBSLtt8LcTefZabA
 OsnKrmJ+fJ+di6Oa4QFOqvnC0gLDGuXW07KJ6oCoAPdHRjiwUHILXNm1OOY7Pmx4q5ErVtmhmwb
 ebt8GYGso6iEAn+VdLMtft/0l5W16SEnz+y/7YiLGqg/8TTefNMWEuMuTYju+VeLupQu+vtpy+J
 TdJ2izEKExi/Lg1Wr2clY8KiYjDDsHFpPRtfafuINLssVTIzzQFdFBG+dOd9X1wllVaWTzy5Nt0
 natC9pEvDaNKIkhQPIg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaabe0b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=FYw9-_tljx6d6srUq_IA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ExjTRV5ud2S6FTkkMFQQPgk7GAqAHP7E
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIxOSBTYWx0ZWRfX5grjpXaxyx6X
 zDL7EZm4ztcUgA8XhcDqcU9UCFATgWbI8j2K1uBo6g3/YYeh/fm2abYLQrpJOTCgT6+Ml6a4tvA
 MZgO7kedyRipn5OPQUuQxXxZlBiFers=
X-Proofpoint-GUID: ASCxqupTLUHFrO9QKGzswEjV5a_MehM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160219
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/09/16 04:30 PM, Alex Bennée wrote:
> I needed to fix a POSIX-ism in the script as well.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260914184534.706637-1-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-map-auto          | 8 +++++---
>  scripts/gitlab-map-update | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/.gitlab-map-auto b/.gitlab-map-auto
> index 28ce448f1bf..3f717a15d4e 100644
> --- a/.gitlab-map-auto
> +++ b/.gitlab-map-auto
> @@ -12,11 +12,12 @@ a1xndr	Alexander Bulekov
>  adi-g15-ibm	Aditya Gupta
>  agraf	Alexander Graf
>  alex.williamson	Alex Williamson
> -aliang1	Aihua Liang
>  alistair23	Alistair Francis
> +amachhiw	Amit Machhiwal

Thanks for adding my ID, Alex!

Acked-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

