Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEE8C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzidj-00057m-Lo; Thu, 27 Aug 2026 18:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzidi-00057c-Or
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:32:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzidg-0002pB-Vx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:32:06 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLokq547095
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 whV1HHS+aIHshFJUcVolv1m8ZhdUfOwUkvJJ7GPyAwc=; b=ijE7+gKopRbK7nhl
 x6uhns54i09HLl9PpJMhuxBIoDX7qN2IwknZQ0b34Tq0R3XxOYv7njUP868H7vhS
 cxVAUbWoBDVjU+1fCclRF3nQf59x7JGsSJrESzYRsR8Kw9Jl8W8Y2pJiUa2A5qEV
 qlGlCXgATCwtbUB/iiyAl6J6thfcTKZeje2FjG8tP9PG0VhlEKNH3apSMXlkfsOr
 z/Ao7pvwSG858d4uo3MuyJkDHy9Hhk1lEKEgZKI5akXaiMTlZUhoWCyBuPfYUfCw
 sLIH84eOumj3T836Z9mPR+QJq0au1VWWGIStqQ8P97f02uZy0pkwro5UYtdHRRI1
 8EgAcA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562v85-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:32:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d001671a54so4275365ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869922; x=1788474722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=whV1HHS+aIHshFJUcVolv1m8ZhdUfOwUkvJJ7GPyAwc=;
 b=DrGkkm05/Q1vPcBaZTZz2VcCWYlxWkmiqGnfYmdYdeElyhwCRvOxebr4AGwrQ5+x68
 6k9C2+0cVlsm2y03IxmhwhZLmRG6arDznwSbyflDvbCDKdUdWkml9HOjc09r41mcYpUf
 ijwIuGpuz9rXIQOaV6KOFUKwvwdkGgjNlzhLnnn1odjXaaBrLYx3VYOcLJOZlm/Va6TZ
 A8sgXnhkD4W1/cERTXDtzEUbUkC68TLTcYdeK1JnKQLMbBKV3tb1ABB340my37/wCXxr
 CfWbIrBz+EGfk6H4pklWzlnUiqwWkoM82tU/TIi8yZXMAV0LJ5z9xBLhIxp9rb0eNOP9
 YMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869922; x=1788474722;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=whV1HHS+aIHshFJUcVolv1m8ZhdUfOwUkvJJ7GPyAwc=;
 b=rIdbAOQ8EgzKbrI8l9HT/+iQM5kOKYBrnlCWm48JvftOQQYpnQkuROd9ga3uDQdko3
 uHtwOHJsSiucmYeTHuODa9rKJaaoRpkrrUZSkfDvM342uuuJkBIpfXH6re2b85NoVf6y
 6rCZTReHsv27k/27pezTgjBgdFhodLBGhGk+/7BBgP+pWxiXWGlsMHgW7o6avNbvMN2V
 1znJlIJ0dhVNUt/ObFVPMYcyRt3z+iwKXg/g1rdXbG5Oj508iHB3kxfCbAXd6oFUP8j/
 +MMopQpMvmm9ZsBk7wFjX2mzxsgYzAwm9UqqJ1JLi4H4FcpfIB0B7DmsgNe2IYWiaqpU
 mPBg==
X-Gm-Message-State: AFuF++khOH4OG4pSxX0K9wmRaeuV6ch1BviVuKRxXaQuLmIdzoTPvMuu
 Ow1elU5MUergUi0yT+0foHLeY8loMOdS1QPl0tk95oIUe4Pr+Fc9nJDN3DJZuBlBIorJVXbBAX7
 xERyTpPHxHAmfeDklEuoyJLumIifhF+LLGzHgvJYwwEdsp6tdVyWa2GLyOA2G0RYzww==
X-Gm-Gg: AR+sD124LoDV/qDtA6531idnQSsVAIlUBJTb0bRUQy3HvKfNdHlxfGKxzxAiGOaH+Gv
 4QRIa6XQDBh9iQaBQ5ybaVN8mWD5jyy2rM/wJRPRucBMoOEuoTn9FI3A5jW0Gq33J8yKYa3q597
 /KdQ4ityL0c7f9t8h0qIpxRXEPFrNPLjZKIG8YnrIIzZ+Y3apW7Z3lOfqHGdqdrl/oOcJSHbeKV
 cg8yJAlkYMZ7/5cD+HAZhBj0+WULAheVh4ONeBT07v9FF/szzswgRjpxCkS1c1xtfBFknd7bz+8
 q0tOPEHWS5e5AtokBPeKl6DYCQGdJSYW8dhzjES+ydGch/fER1bOahcQm8/rtVjew8nyFJtUdgq
 EGe7lIoEmABt8PZx7LasuIhussDZ4mGG3rQeowS6PZM/YmAxNuZZGq7bFl0LKh1NOIbKJ
X-Received: by 2002:a17:90b:5405:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-396d0de4c19mr4689671a91.6.1787869922394; 
 Thu, 27 Aug 2026 15:32:02 -0700 (PDT)
X-Received: by 2002:a17:90b:5405:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-396d0de4c19mr4689573a91.6.1787869921951; 
 Thu, 27 Aug 2026 15:32:01 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d1b38esm214540c88.3.2026.08.27.15.32.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 15:32:01 -0700 (PDT)
Message-ID: <c6825ac0-9e0e-49fa-864b-c5f7dc5e963c@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 15:31:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 000/105] tests/tcg: run tests with meson
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MSBTYWx0ZWRfX42goQ9iORIxs
 6zudFXZt/adwix38eAM7WcJWVU0szKHBxecG09xXBCHgfUw0jXhOvYsALcQl3ZPogv+9BjsNLAa
 gS+GpKDWMFau6q23vdQo5ygXz5hQXT4=
X-Proofpoint-ORIG-GUID: EIDp7xkMFRRrwGp5qdVVxVslZgCbsvl1
X-Proofpoint-GUID: EIDp7xkMFRRrwGp5qdVVxVslZgCbsvl1
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90bae3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Byx-y9mGAAAA:8 a=cplnpDx6AAAA:8
 a=pGLkceISAAAA:8 a=_O3DOGVWAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8
 a=YEB5RgzmAAAA:8 a=20KFwNOVAAAA:8 a=rWizVMdDOaL2eUb1aZoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
 a=bHwCOBSOUrNypjIvOSWD:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MSBTYWx0ZWRfX0TSUsSJxxBhE
 cVkWvDhvXKRXbfNEoMcYV4Zkl6RLddREMRpUTIdMRmKKbjQ3LoIpPwH8VMvmjyY117RiRTkHl9o
 kHROsAhxPWDakTGT4x48CxJHlIrp7s/NvEHZn90h90gLuy7V30MVFzxFCQd38EEPJv/baorxKmF
 7hgXIebx7Q6tNV/LBklKB/Gn533OIu4+mk2ui0qBuuIyq9ZyVCmUK4fKf2NagnGLRQ2xYEuBj/V
 DKW57Rm0IAhScwXpCMi9/aeLyB/FrThLRS/aQyA82MF3aDqovKRIHgOlrdfI81ekDNaG6yLqrLe
 G/qeLPj4y+RcngL6JJ+8M/X351szj+f/GXQZgiwaUffubYhT3lk8iFFJZDnRk/XK/Dz5SaTWWaj
 0w8orTyFzh6g4PQe3pFF3x9h5Un4XJkP6HZSJJYhcsUWezTDwncD8xUYv9Ksd+pCprmulq3nAc0
 cD1MU9wV2SZEV0PR3hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270191
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 8/27/2026 3:13 PM, Pierrick Bouvier wrote:
> For reviews, this is the list of maintainers per target:
> alpha: Richard Henderson <richard.henderson@linaro.org>
> arm: Peter Maydell <peter.maydell@linaro.org>
> hexagon: Brian Cain <brian.cain@oss.qualcomm.com>
> hppa: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
> loongarch: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>
> m68k: Laurent Vivier <laurent@vivier.eu>
> mips: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> or1k: Stafford Horne <shorne@gmail.com>
> ppc: Nicholas Piggin <npiggin@gmail.com>
> riscv: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>
> s390x: Richard Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>
> sh4: Yoshinori Sato <yoshinori.sato@nifty.com>
> x86: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
> xtensa: Max Filippov <jcmvbkbc@gmail.com>
> tricore: orphan
> multiarch: Alex Bennée <alex.bennee@linaro.org>
>
Patches for target tests (36-96) still need review.
Series is ordered per target, in alphabetic order, you should find yours
easily.

Since tricore is orphan, I would appreciate if anyone could give a
review to patch 89, adding tricore tests.

Thanks,
Pierrick

