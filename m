Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E75FF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDv5-0003MI-It; Wed, 29 Apr 2026 19:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDv1-0003Lb-TF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:02:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDuy-0008UE-Nd
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:02:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbkfh3203481
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kb2EPVyh+YBChmNjKr0CX38yXgiixNqVlGyRVKsX/GY=; b=l3/wxsConzeKIWaD
 nJ24lzJ82iHDrPeOX2WkOkMgZviob6wj/6RMP2/cClX2jt/6sljifAm/XLPDZF4m
 bTekWyRTrkyPYha4WGLlIhYIMAP7oDlYeiBixl+vLW3QG/WrL0m6Uq08LsHWGFX+
 aRkhfyJ+VmI0vFtrf2jmIrdHuFW+f4eKrE9jGUfR2Iv0epHuzY26KmQg+E8574lG
 3hPFOVkGwyP+lLV7ArPQ47uKI0YTETWLWdudbSKdtlGBvF+aXtqDUaT6t+dgjob+
 gapkSkXPcCe5Vgq5AzetDiNKZY4UU9RbEbklfWRx3Fazzk4IjMWJpB0DeAW0UiDB
 hYOsuw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj83sss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:02:07 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c66fdd4aeso578800c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503726; x=1778108526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kb2EPVyh+YBChmNjKr0CX38yXgiixNqVlGyRVKsX/GY=;
 b=auAERgrVqx9AMEZF2x2JmAQQnhoYmh9S7M38qa6o7DloYecIm5FRpvsvYh6sMIA7sx
 BKa6kshR4YAgRMvmZ9yheWDh9+SwxF/FT0nGeFqNUeFdaULtp0cQZui2/jDtScFYdRnc
 11N9TQZlO6l7XHJeUUJEMRp/C7plFzCO4ewnN7BlKATlM4Ldqed46OEyQAL/nxTvXzX8
 uETg12r24hDHq5EEy1AUefRoYghVqcfiwsZZr+xEfBqvMOjvPMYgRcF5DFto3OdzMBXq
 3cTsVqIzRxPJ7xM7XaeusPGMyghTXJuOYk01clrIaq/OmkkXpelsgzfEycJZ9Df8WC/A
 GlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503726; x=1778108526;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kb2EPVyh+YBChmNjKr0CX38yXgiixNqVlGyRVKsX/GY=;
 b=PHyDy+NLWvFLLsYRkzaCxK1TXyaUrRQBOelmyT1mXuCU6MuREf56hY5/i9BaklFK/f
 kDH901cNLjkrEwONIKpGgDrC7eqiYiqs7dYXEPuFa1TUuzMzye+0s8SDu1jacErnAVIN
 f5Fkr1MqetOmoiPwGDEe3vefXsEv/98GGOWHXIP4f5gHIMY+tpu1Ij04vjmKf18ngQS/
 ch60/49I445CWxABANsETPpyCA8W65wh8yf/83DGX7UWOPNO0mx7g25cb1FW8M3MjVYB
 hX+EmpCO5ucoTboDFC3c+g53l+qO4GbIRJxLuGyViMUUn68Y+PWnn2wv53GCmS8dwNDi
 QR0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/20GgGH1khC4vtS/t+VF4+ptLdj7uPkjB4ZtPuL7KiaCkyDFTJzXst1aUJF8fCkOdKXZptHn1BQJfF@nongnu.org
X-Gm-Message-State: AOJu0YzlVirtNPbfDmKUlXcSyTOWg4Ty8OJaYQF864FKuBcbSquTBfer
 pGZqywUeTXbEunyhc7EhDsRciPyZjEmxBZcE6TYBNSs6dVym8qIVwv4pZgs18iib/cBzutfmqxN
 MiDgYj5mblu/OBtsHW9DRBsPQ1lOHK+mtTugHPl/F0nnNpyQM42hffsvLPw==
X-Gm-Gg: AeBDieui/P+FxqdbX80vU2LRb9ITVA1mUH8typ7iHuLgbE/FjLppsqtSjqvEqsaoChy
 cbIMSjuBx9+3vHvjpbZ9uwQCTcFyVuRDSPjZWVoZM4BvPtC/JZ6XMpAZSffpYSib13SBjSoQs0A
 Zy0qU7ES4/rOvcv8bU0Px2ydzwc/cf55UkOUmSMaLMh4kcWnO3IVsookheaDgBP3WbAQYXcwEoQ
 Sb+wAC9qH1ZR+yHfoaNV+Z7fYJpb6kZzc3NB/T6dZtmXSzK8jrmobzHgPyjQMIcB9QXMJ/UHCbx
 /UvaldyB7BECC/Vfb+ibsVnpTvlasOyT//OFdGdnm5j0d3lRUk1RXYkZvRjdkq3p70msStkrera
 i3uOcj11HTfbGfCs3zPzko8OArpDFciQRsmRyHdBNeNkpoT9iab0KytQxEv4S+XZKDTcCKe3Nzy
 FS6MriFdONrxK66wwvd04YZp8n
X-Received: by 2002:a05:7022:124:b0:12d:de3f:f3df with SMTP id
 a92af1059eb24-12dead32e3amr221434c88.41.1777503726090; 
 Wed, 29 Apr 2026 16:02:06 -0700 (PDT)
X-Received: by 2002:a05:7022:124:b0:12d:de3f:f3df with SMTP id
 a92af1059eb24-12dead32e3amr221417c88.41.1777503725390; 
 Wed, 29 Apr 2026 16:02:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3269b41sm4341152c88.13.2026.04.29.16.02.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:02:04 -0700 (PDT)
Message-ID: <9d13d6a9-e974-45e6-810b-b6ee321565c3@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:02:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/17] bsd-user: Add log_unsupported_ioctl function
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-12-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-12-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Iln5iGsRKNm3jcrO7rZLVNTB0fKuVhuh
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f28def cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=okkMJKDRB8BPCfBrv10A:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: Iln5iGsRKNm3jcrO7rZLVNTB0fKuVhuh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfXwPBg/EG2RGX0
 cRcE1umU3VtgK25RCIAiDdbrkDoYU7z5cQYlXkEwrKJlrj+bWmxDg586Yscqy072j4Zs91fqW5Z
 h/2FJnghWGy86pwEkerdF9la/uJE2UIiwlJnSm71uWkdTwXJgxG3q3dYO4BcnI5erGlj2SXKgmf
 eHJJXUMAa4YktNhaULzuDQbkhEL6oIfmnYd4chJVC6v35s6/fvzHLxUsTLnRKwPv42BANyZuCGn
 9ejMJTRfOfWXQqPN/Jfq68jIQ420qw5+e8plVIgz2UX5K7HBLOHzX2EPbR9VPIar3emrqn9smLZ
 5WdsiMMaylrDquMKq6nAroVz+UG48RVvSMi6Hq9geTr9UFKNLw2NslocOz4Ako05uC8fOy/i5v4
 yudZepQxIjnGq/oF/zuWnDCSY74ZYz8crShNe16TlmMm9ETNsK3SkFUFx0hboTjPQ+U0HD2v5ZE
 9JaawH54uQ95umpyEqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> Add helper function to log detailed information about unsupported
> ioctl commands, including direction, group, and parameter length.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-ioctl.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

