Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE53CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU52W-0001WQ-VR; Mon, 01 Jun 2026 11:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU52P-0001Pr-Rk
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:58:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU52L-0007RO-TC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 11:58:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651Ewpf9144951
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 15:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hzm8pqWeVRhSVORQGCoHO2SX3sIopgTRGlL2jqN3EMQ=; b=C6e4rg1SoWaE0E4i
 0FZEqQBcXvVhuwQNg6BoS4Hb7689oJsM2rNxpnt8xaxz0H5G5Smk20sQeTmrbAOZ
 WLc2uAThoWux5hce5s0lC8608Wi6Hr7gzo2utmMspl5o0AJdcD2GH4vas5umBRPf
 N0NimMylk1sjAH975DVJW90YhE8dnanYIpRFz9hh8PrpxSvyf90IPNXECEy8QlUg
 dgoRBaQdkLSNlpLLDDo8CtBDuzl003vYph57wg/NNVqPao6MJVznFHaytBAR4OU+
 gJ1t630KtXsG4g4Cbp79gf/bVLMPi17J3+GY/7ndTlpuX01s1JUU9wny6WD1iGro
 zyBAlQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6stsrak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 15:58:44 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-135fe34cb98so18932826c88.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780329523; x=1780934323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hzm8pqWeVRhSVORQGCoHO2SX3sIopgTRGlL2jqN3EMQ=;
 b=HOXF3/9er61O6k5zt7iMqKrfiCkXjkbKr//ITFNJv2DBKzkNAObQv6wLG+3BdDALo9
 7nPjGZcI5HB+7gEQN4dfLf55TGWNG8VgtlS0vXmpTPbNJjnrBV8o+XCchd0PLsr9LcEG
 hKv8rZAJUIyqiFzWHatvGPsHPpyCUabYG2F+1r7CsEolrCd4Wy8By/gICaGr91gn7gpZ
 Bdy40/RTGumYV3GiwdmQWzFf21wcmPl37rjYxLpe9kNCbvqSFfZGM7fgmOZFAwFyJgQu
 FM86VuEKrJ9DnyJvIpjxoKCWpDFdfHWssWfe+46iXfAFz4EvxW6eSFcAcLJSf1cEeEKm
 cNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780329523; x=1780934323;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzm8pqWeVRhSVORQGCoHO2SX3sIopgTRGlL2jqN3EMQ=;
 b=euEG+fQF2EorjAwehXTzqZlj8THSXIjicnHlE28QwNB5+eljzQR2TRf+KpSPX6UwLp
 YdX4ZOEuTnA8v0ZiNbZtj8es5jtM18mraxpcGl5Qwl/UovVcS1VC1l0Hunlzmaam0N0w
 RkpxL0BQ6bS00mXaSi1Ctqwz6BZwRyrHDU2jRPka2QcWtUd39OKKVmB//SzdlEt4ZLhg
 bsCxIt6mNbLozTAvnUksg0oUuudYy87+6GFkKp88/DYhQk1fNWDkB4Uvn4pUhDA21+iN
 n+vN3z//hr5HoruvrLqU3QQRMO6DHeJTbuOkc1x4OusO3ZLxEDiYe16HocrkAp+t+z8f
 MuIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8U/6E6ZW/xIZldX6JhSi9r3kxsy2fT735CN4IJImX5SkDoxCJgxbdcMWk4gchBDlvWcUaJ38QwAt5x@nongnu.org
X-Gm-Message-State: AOJu0Yxy96Vam2pzzPZlQMnoOTLSzZh/R1K4cpZyEy3MuKV8FONB6bn1
 4rTh+inBoidMYF2EYvCQn1JKtD1JZRm0HWzO0CMCtdeZu9C4VlyLEXEALXWHYE5R3M1tnzRgIY6
 BFm93NmlvNKqkqF3jCDPqIJL1en/o+YwxlWjDUlaLgI0KIkEez04BsZla+w==
X-Gm-Gg: Acq92OG7bxFOAIb5sjT86DoyV1UvG76swb5RKXxpAY1irVS5NQsnNezboQYVvGXoJiw
 K89V8haHLp9+WQiQHQ15jz/SbZgOkHH5NvjWrUL69Bfcos4GhOt9c23xRXTJZFAv/qkljepcZo2
 KYW8aC88q3UdZkcvm3+2Ip5bByGr2iZbdG3KGNbyKlPCQeZmUXT3dSjod7VUA8xHM2mRA0484DA
 32WO9wmKyUbyOTquczlHL2JYW+tq1DzEd6M9bCnX6OP/F6ZoWMqfB6QmZHpEsVUOasf4j1R5n8M
 kHuZgmvPytADjWxMZVKYZEXtWXB8xK3ACvyqDaeqeji+1LWZb9ofOq49BzqFysDlcHKlDBglkce
 VJ71rX2qWfWMKPECaDFEPcpbd+s3Jx5SneA6bNxLzLDEDRTBTSqv66sKv641le4kqiidXEFmpHp
 /yy47lyu/fOtrbO306NVAZzrE3
X-Received: by 2002:a05:7022:204:b0:136:6b4c:a8ea with SMTP id
 a92af1059eb24-137d426fa58mr4699257c88.40.1780329523409; 
 Mon, 01 Jun 2026 08:58:43 -0700 (PDT)
X-Received: by 2002:a05:7022:204:b0:136:6b4c:a8ea with SMTP id
 a92af1059eb24-137d426fa58mr4699244c88.40.1780329522836; 
 Mon, 01 Jun 2026 08:58:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b36c6700sm7056007c88.6.2026.06.01.08.58.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 08:58:42 -0700 (PDT)
Message-ID: <5cd3849f-af52-43bb-9149-cfd97f9ed237@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 08:58:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configure: use debian-all-test-cross for mipsel tcg
 tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Brad Smith <brad@comstyle.com>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260601143129.144786-1-alex.bennee@linaro.org>
 <20260601143129.144786-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260601143129.144786-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1OSBTYWx0ZWRfX+hOJZJS3V5Ai
 pjX+3NRegAxB34lmvf0Wk5Ed6S+e3/42ACLkeZ9gTBophPmp4Qg8GMwTh8Ls4tJjzA7lSXq2TFs
 DVx2MFoRjsNfZgm0YjZ0lIzxk85cTiPbSQeHJbaeRabSSpCezsfywMG3N+wSh2gySAdyQkwAoQ4
 n7G+9J6gAXVwEoVkOM6uJxxYUpV836OAWltcsVbdklGgg1ns2+iU1uX7RbUwzeDnpaBys2wYLTx
 rKy1wkxE9yZRRhu2H6VeUqqiw+AwFw2FVGvUPzyyEjjlkYOkKCeu6r1p+Hy+5o/+fOKQbKldzLz
 HPiQj9LUC6CI0SG4FHCMw8daEypI8ETe9a+dadM1Pxm69j6Y759TMFGMSvsftN3vMiIjeimDzrg
 UiAPSVEs5NmEhMhOd9W1M0y033DpuhBGBmhWRbE1JMoqr1/P8xctSchxKjHxDH8CVWwCsgJ2l1p
 XtZFoIC7XsdsMwwxsWg==
X-Proofpoint-ORIG-GUID: hZ6Byp1xTpbitmTu93Wv0sSZ6202Zokh
X-Authority-Analysis: v=2.4 cv=HrNG3UTS c=1 sm=1 tr=0 ts=6a1dac34 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=M-7c5tFylfstYRC5cyQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hZ6Byp1xTpbitmTu93Wv0sSZ6202Zokh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010159
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/1/2026 7:31 AM, Alex Bennée wrote:
> Although we have had the mips compilers in all-test-cross for a while
> we had been surviving using the mipsel cross compiler image. However
> when that was removed we missed updating the container to use.
> 
> Fixes: 366bb88e785 (buildsys: Remove MIPS cross containers)
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Message-ID: <20260529181713.612230-1-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

