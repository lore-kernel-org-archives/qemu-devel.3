Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10A1CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 16:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcQuL-0006vo-Qh; Wed, 24 Jun 2026 12:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQuI-0006pG-TH
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:56:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcQuH-0004kG-EK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 12:56:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OFfLur3301062
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qk8KGIdBpbFiHPYe5HHDPWfL6vMXIqcMtoGt8LbakO4=; b=mSwci/wckBMCofr1
 1RaxIj9LlQyfFaYUa+3ZqWQP48GwMnlXzpqnIUd8qnk3JmMY7FD/Of7W7uctd2lk
 K/ia7TAtudMLd0IJvrhDX3lbdEIbfg4+pzZeMU1/nRzDO/2g4fzcCmlEb4Wihh/y
 KVyMlGS92Wf5QARMzklfIY9OsNovmX2wjiEvH5ClCIjB6/94QAaDib/5/Dl4nICu
 /mclW9bFXobWnNkL6rx1DBohlFx6AMhKehwUxNivRKueMtfTQeyxDYHBXLLimiof
 GhsDvUlNilIZnB2fXEz4heakpPdoL/ZJq2BhUo16f7aTrQDqpkEHoztVXql0kd1h
 RPI6kQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05aqbbjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 16:56:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c7406bcd0so557008eec.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782320215; x=1782925015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qk8KGIdBpbFiHPYe5HHDPWfL6vMXIqcMtoGt8LbakO4=;
 b=f6Y1HC96C0rrhCaRpK/4/4ymqRSlqHjrxDmajkie7RdDKMsos2i3oa5oxD3fQgO+wp
 M5N9+OMqcFhOSGhcUnrhKa6K/kUR0ZzjKYvsx7qA8xnx3lTwGux43HYxqlyBGkBn3MoR
 nSlMIweT3dNgtVupn8ZUwjEbRFjn7zsZHF1YZ1rau8jex87YgJ9COZ/T9wZ8xBCCQAEl
 R71SV5+VgoM1ANQh2Fe1jasYflUics93Bq3dtRvgh/wNzYgbFvir3N/tlKnlmEseyzKR
 B7bS1C/n0NVJ9QxMHQ9l1Ce1Ysh0nZfbGEi2MZFJFBGyClvJioSAxRrwLAKHx8hA/zA/
 iTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782320215; x=1782925015;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qk8KGIdBpbFiHPYe5HHDPWfL6vMXIqcMtoGt8LbakO4=;
 b=AH6WqHNEaxSI5zU1YGeK2iVTurR+3tVGgqIEvq9RkqYOPQW/JbTHoUO3A5+uU/mlhZ
 frMxofZIRTzF4h2qTC95K5e6YZgh7k0Izi+TYXOHSUFafzTMhmy3FK/swIpr3+TG5w0Q
 q5oCMcab3m18tXBgQgkDUWrfmHb5Ts39fUNF9urQxJRY+SBRWpEOxMPfCNV6rhg+yLxh
 r3u3ESTk5MIbTfG8VU2uSgn3tHD5ZjPh+C0sWTLJKRh4v/Q1+o1skc+pPSpAhWJqUj0H
 5RbfCXFhmLlJ8liaEsAx8Jrmr1KSlRSn7bf7VTy2acZ6Kwjx1RRv1o72UwqeGVd/WP3O
 y+Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaTFf0yQey5tyxi/8GlULXDR0WO03NMOWFRlhZ+WYaXkBSq6XTBeA3dP74OwNnOxxawokAJ1GWn1Mn@nongnu.org
X-Gm-Message-State: AOJu0YwpmiOUduKMJlsAh7pZJcGQ36WmpeBpvNaVvGSBbpOpbmgSz9XO
 8X8gwcIO/B3JtpnSqWhT8mr8HqgeF6zdZn6R2A9cy0i6b+RFIiWHaLbmnqjSIBM/J436eojqUKI
 5VsyLShvSbnTGLmkEUW/TDZl9Qrm0E37tJVaNNFxeg23piPQLZjpT8N+aOCiiD8XDEw==
X-Gm-Gg: AfdE7cmd3fSCu8bFaMgnRQp1vO41vzJf11C9sYfG5TD7XZux5dIDvag8FdUZap4vJEJ
 mGUNOYZeM1AxLUI3/xdG8DYrqSc/2iPLv2fTauAXknxs009++R3NQuxWeTJ80UI7O5rU2S4xB4s
 b2r116A/WCaT14mfr+p2xxXNdaz8wEJ698nS9Eav8BMjyc7qRZzuvBngBFWAiuqFAYGzAtENFiF
 DT1Ifs33q2cjfXCkofY+OnyDy1NDWKnxS+4kUxVdNEGcntLDsoeXSO38uX3G4MqhF0jVAJvRPEH
 H7zq/fw7+negNepC00jK3KaEM1CozrwZ4zd6VwLdEb+5c790dU1oohM082X4zg9LIN/lnBYTHSX
 pkcPBANxVxdwlIZHVZ8puCNgDF+LnMcHfUT+KDCuAoWsUFnRlBaZzKDqPpnyzP6uawtE4BgDC3U
 adTfA=
X-Received: by 2002:a05:693c:2c92:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-30c68d14f0dmr3549965eec.13.1782320215353; 
 Wed, 24 Jun 2026 09:56:55 -0700 (PDT)
X-Received: by 2002:a05:693c:2c92:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-30c68d14f0dmr3549942eec.13.1782320214828; 
 Wed, 24 Jun 2026 09:56:54 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab28fasm418102eec.30.2026.06.24.09.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 09:56:54 -0700 (PDT)
Message-ID: <2a8dd2d8-ebe9-468a-9adc-2545bc37be04@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 09:56:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] gitlab: use .base_meson_job_template from
 crossbuild jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260624124657.2725376-1-berrange@redhat.com>
 <20260624124657.2725376-4-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260624124657.2725376-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfX8gJ/a1lnqQNu
 y3mecwC0TKpjR0RMoZgAckn9R/J5qhe1Y3UDQKc/FYA0pB35W4uMnNxNhPIiLQsplieKFOKFbHV
 5biYWfIgUR1pwVto2t5Y5lE4ufkBsaM=
X-Proofpoint-GUID: mzrdBX4FB3LOg1WV7zWj7evZBZFnE-6D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0MiBTYWx0ZWRfXzZLPo2j9dGhR
 It5F+lVSqfDrlUDvWoAH4OWJVeHgV1xF29JmUuaExhin6qYrjnA1MJRmh9lxZ3N28PN51vKQHCR
 l9RuTemXWXFAqhnUMOnsUPJzHZ3tWR9ihMkgZS0ma+XnazOL+BRxynHglccG9cuLKebLLOXMoxo
 Vpvg/TL6GTrTLpyQIQjPwzs81ch0HBfBgEkHaVBof6ZS21oH8MY3mu7wdM04KnTP8RL0iXS8Se8
 T6p54DcteL2y48TdqfypPZcQOBGitcCRgh6F7JTc8AKaU63mO0U4qPSXEu/UAmVZBQb0ewDLArm
 1Alh2foHhLMEEXxp9uoP3HLeUdDstgMz/s8fXiuEJU+KQmHmQJzgjnOlJP9+46Qr1lmocsV42Cr
 12F20HpLM5zlldaRgoNTMgcSogeSnw==
X-Authority-Analysis: v=2.4 cv=UphT8ewB c=1 sm=1 tr=0 ts=6a3c0c58 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=MP5XhwvWHR9a9NRlifsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: mzrdBX4FB3LOg1WV7zWj7evZBZFnE-6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/24/2026 5:46 AM, Daniel P. Berrangé wrote:
> This ensures that crossbuild jobs capture the build/meson-logs
> content as artifacts to aid in debugging.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/crossbuild-template.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

