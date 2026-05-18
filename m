Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77719CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsiL-0003HC-Lr; Mon, 18 May 2026 03:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wOsiH-0003Eh-De
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:48:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wOsiD-0006e2-BX
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:48:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I24krr2753028
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 07:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TAlBJlB+HRzVkumPBWr+YGfxiq+qAumbFMSLdPDTjZM=; b=CqR2ABtYC/+o9B6c
 5XH8X6dpvVZ0KnbIh+naN8KLDZw3NS8tE1SGAcq3ZUL7XFz/dO5bdA0dBuTLXPOB
 nromFXkBU9vWLzZMkUsJ14XB6+Nusvi5X0Au9eAkbcqi2eTOdawfhFK+ClbACcB2
 CIQYJfQNJz77iUFAa9SaNF04bseNAlephDWsjLJBjq2s+9G8R+LXIiC+q0aBC8Ic
 iNnqSBuKqapGJV27PvC1zxVb27VVByMYzTFZolgPSHRISMrWUB4IC4sgmRmFlida
 KAiuxSxuDsGeHmlqHBV8X/Cyk906EkVmhn2HPopb8benhvBsqZg7Nn8TxXe2DC3x
 LvGFQw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0qdb10-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 07:48:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee34588671so2245606eec.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779090500; x=1779695300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TAlBJlB+HRzVkumPBWr+YGfxiq+qAumbFMSLdPDTjZM=;
 b=fh2M2q5SsGtsV48SywFQLv/OzWuH5BLGydKLMnXIUC+wASIHNMMsvtFcK3nZQbHhEr
 w9M63xxa2DsoxK86n9AvrLhm6L9ZEhoQWrJHwUoxQ7EiiWAmeo7ILEcwjuffm6IgD1Km
 RjtMIVGiSzylWwp+vxnBzysdkOBozSVVS/oNPI+BSCTvzDxoTQvF25rY/xPCrHWOf2Ak
 8FC8+KxOnDMZLsta7rfhjViBxX+RfU3xIJ3eU7//9dfGUf1zOLD7628x65kSI9qiC1rv
 zL1LpkNZxEsqqdUEyE2wZL9dDU2kEWqDaM7uVq+CK7I/0eKEwgBtl5vRsd9EJvV6E7lu
 K29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779090500; x=1779695300;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TAlBJlB+HRzVkumPBWr+YGfxiq+qAumbFMSLdPDTjZM=;
 b=cOzzkjmvSC9yprOQDMhNAsaBEEDV8i4Ydy28zj6hGz/ni8+VARuYy8uB8M5oZTYDQy
 4GdF3cc8VXsNimgr5dMvUCaDE/EANrUAbeOnOPqGdkGpTqNrwifdl1w+VwETaoF21CvT
 S4y6cCV3K//lUJxfpReiC118SL5XeuiZGqRkc3mGNmeqsDAwcfQCNy+2DMF7YUwDHJwI
 75IEVoKAgf9oeQTYr9tftwrLQPWCMo7DprCkNcw5ZDlVhqNttFod5YVWSU9srtMpdEJ6
 yJIdr6iwxIqVTORw3RDXQhnt30tMuLKLS0iRQb5AVjOzs0h7NxWy34RRK+b4GmApiV5k
 03tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I+q00wnyAP713Qg+gJJM++N5YaYEzlkep0nXBpwb2/WS21QuB/yw+1Ko1IL3QK/o/gXzeM4shi4WH@nongnu.org
X-Gm-Message-State: AOJu0Yw3brH6nMsIlPkhqointafWaj4hiQUMQtRIQM3XzMFW0R81/Ypc
 h+a0J+sYYId+baOB8KWHiMks9s5G/Zx+r5ZEAcNuPGs/9INksD+57CNu1z2O9MXlhByfxuCuQMq
 1j3Z9uOtsfQbfuOlDowGjmRszWQJOGLqIfpIWvGwUmPexsq8IvqsyBHDVGQ==
X-Gm-Gg: Acq92OHddXTROuH2u+/Xj47szF4VWFbCmWMp6Pi0MplwQcnN7kQVLq7cEm4JLw6GM/+
 WX8/VQjsbFXlUTCOtwstQJW71tgquY5ayAjMXAErVS+MKQYSXSyeXk31MULvZKmnx8ryLZUoTs6
 aLR7m9zwdYOMz0+u5L4gV8TkCODb8blzXYrbU2x4XAhbBy4LojLahGbcBfoj0h2EVaQqT1oBYPJ
 upcuez3N8hiOYtM+rrGrf/oXdrqRzoMojJBXS7ae2UmHb4x/2Z925DsqSZKEpwee+8nwmTQM77o
 Z6wgAv7D11XDpTMC4yvU2U9fDMW4MqBJ7VbyJ3AiX13RDtdjR0swCH7y4weIx+qiJEYMCxi05NJ
 LsNHpYdd8KgXlgib3qPKx8TqRYCwKj/cK+ATHLOP5pTQ2souYHzElq4y19bjbL4Dgaw==
X-Received: by 2002:a05:7301:1004:b0:2e6:e916:70ff with SMTP id
 5a478bee46e88-303986a0ebemr4839341eec.28.1779090499475; 
 Mon, 18 May 2026 00:48:19 -0700 (PDT)
X-Received: by 2002:a05:7301:1004:b0:2e6:e916:70ff with SMTP id
 5a478bee46e88-303986a0ebemr4839324eec.28.1779090498905; 
 Mon, 18 May 2026 00:48:18 -0700 (PDT)
Received: from [10.11.7.97] ([50.238.185.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2ea6dsm13451082eec.4.2026.05.18.00.48.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 00:48:18 -0700 (PDT)
Message-ID: <5053ba4c-01eb-443d-b364-50a32be41e26@oss.qualcomm.com>
Date: Mon, 18 May 2026 02:48:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/21] target/arm: Restrict IDAU interface to TCG
 namespace
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260516171524.19184-1-philmd@linaro.org>
 <20260516171524.19184-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260516171524.19184-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DcdjqF9_kzZCUAJPfYmFJjurYO2NrDQP
X-Proofpoint-GUID: DcdjqF9_kzZCUAJPfYmFJjurYO2NrDQP
X-Authority-Analysis: v=2.4 cv=fIMJG5ae c=1 sm=1 tr=0 ts=6a0ac444 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=+WjNtiTvTqxFfZe9JAS8OQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=lYet2qYnc6s8ltbzrrIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3MyBTYWx0ZWRfXxPzD5/u/P8D8
 ZzVp0GdCtL6ORLr8LlR0QzVqTIX1KQIXxcSkoai7qsyGonJhsrqBHb5/rUPqUPe7i8Q2apTJx1y
 GSVVys1XqJ4ts3OWz7mrm/lm8ZpFD8/PUn7S/5MhWExKKASLFGN3wabdW8GXKzsyxk7kDzm+a7Z
 JlWdIUwXg1/YFI4HpPgtKjtJr7dPkUA5ks0ck3LY4TxueNXe9cSnbZkSalC8kMOafI9OLgMtZhu
 Ym8CGSvsuJo2d6KkLmed2dC886EoF6PqfiORlu/L6Yf+bghYXDupJ+7ueGDFoTd2PiUozjPEvul
 KKra9JkSN7bd7UqmlTKEhYWwhTyKFlyI2rpOfC1tHf8nNTzr7O42C2BNrsXpfRuaDPjLod0VK00
 0T6I9Fr1Wsl5ebHWBKfCRtcVeYbTkuhI2SImomq3imjgb+fmWo0TmARiwAN3UVrV368KraL2god
 bgkawqIflxEXtpd7/5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180073
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

On 5/16/2026 12:15 PM, Philippe Mathieu-Daudé wrote:
> Emphasize the IDAU interface is restricted to TCG by moving the
> header under target/arm/tcg/. Move the definition to cpu-v7m.c
> which also contains v7/v8 hardware (NVIC), keeping only CPU types
> in cpu32.c.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/arm/armv7m.h     |  2 +-
>  include/hw/misc/tz-msc.h    |  2 +-
>  target/arm/{ => tcg}/idau.h |  4 ++--
>  hw/arm/armv7m.c             |  2 +-
>  target/arm/cpu.c            |  2 +-
>  target/arm/ptw.c            |  2 +-
>  target/arm/tcg/cpu-v7m.c    | 11 +++++++++++
>  target/arm/tcg/cpu32.c      |  8 --------
>  8 files changed, 18 insertions(+), 15 deletions(-)
>  rename target/arm/{ => tcg}/idau.h (97%)
> 

This patch creates a problem with the (now merged) commit:
8d3e31c0d575b3265ae5cacfba10680718ba5a22
"target/arm: Extract IDAU interface to its own unit"

Indeed, it results with TYPE_IDAU_INTERFACE being register twice which
fails at startup.

Maybe simply drop current commit?

Regards,
Pierrick

