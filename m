Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6EF588F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErtX-0002u3-Mk; Mon, 20 Apr 2026 12:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErtN-0002oU-Iw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:54:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wErtJ-000371-5y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:54:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KBpkWd1598352
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FT46Wsw0gwIDoUww+FSqjIUVChZ47lSJHeBTrHuTfM4=; b=D+Jj8w220Fmy+ih9
 1oiXRnSUwZ7zOuQYfcECugMPCi6kJcKl7fAY1paCPlQ8dcuU4f3xS/vruerc2tqj
 B+DIa4SI6r86p5kFHYPMMShDMq4Nv4cztiBcRR9YaTk61nHaL5F8SO+SNeipuej/
 Ly87l+XTvI7r/M3rt9obyVZXgZnf+uBQBL53WkkOo3NcYDlvsXn6P4Ya1vG233cL
 q8uIfLGsu8mie4s+tqAMmmQajUSaIZxtPFRGw99Us4lrplVGVrKbu6mLYZO8r9jY
 CIk1RXyVvpzNx9v5F+xrWFSjs4eg++ACyhbj43wMu5U7VVflFOci7rwmH9hbO9BC
 nbrxwg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfgnje95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 16:54:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2d93379001eso3311790eec.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776704071; x=1777308871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FT46Wsw0gwIDoUww+FSqjIUVChZ47lSJHeBTrHuTfM4=;
 b=LNAkHFGcmh9PEJi+3pMMjpFs9eY8o3+C71L/aSlf7KJMGn862vYvmhnaNaIDenTv4S
 DBz5YoxRniwCBKVmrYmrOomc2n1HdgFU1Ke19z52aIqJKuhxn3i+fsjtCg6ZedOJkLGz
 bc9xsQTDv3/azyGgqFXsWzMsrtzPFg6/jLqtjUrQeTYJQ0K7nb99ic+i/bzGqwWtjbMt
 s/PNuh12g8mINt4eyLdHtGCZ6Lu9FgUhUKk1yy8IMhfV9aUwDXxKQ9XwJfGPtCOIgxf2
 cFw19kKN5XYpDa2l9dKbXQ8fulzV0CwrK2LPmbMoUCK/eSOwCQgzb/Et6CJTiKHVY8VG
 qECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776704071; x=1777308871;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FT46Wsw0gwIDoUww+FSqjIUVChZ47lSJHeBTrHuTfM4=;
 b=miPOOdwz7aP9m8PLSpWcvmeuWO6J37mCEpBHIcrlF31rNH+K6050gcZznQwSlrl3Ix
 QfYTwcLcgloAnNQ7GTT8x/8nRR6W2OCgmR1nY2B7AM3gsW1f54XWSBD5kZR3alvaye6H
 RMhBogom2DRq7PKM5Nw+QrylBgLmElL0LpOZnxtprh92wgPfhvbwrlrsIB/E69ps+yDV
 +WJT+Ur8sAjVRV3I7Qm5p0gQxT2YkQ5u4dV4ATQijmrNdSwMu5S5iQdLh06xAIIwz5iZ
 u9CzOn+RZ8gyIublpzkCJd5nk3zj3exsVJG6FiuZcox3AujIfjJ0J1QCN9B68YVhflSX
 V6QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JuXR2K3e9J14RVQRg0iJuQ4Tez2EnKYAXUTVnwIQr9GkQX9kuCfHhQu37pdE9YgUNtiNYeQfiCGsi@nongnu.org
X-Gm-Message-State: AOJu0YzzA20d90OX/A/baLHG9bcH32Av7KTjb7SUymi6h7rxn+LUhyIK
 /wSLAmB5vs5vDptH1f4qS0QJqCBq+Dh9APQQNtHfRULU+fXOz8ZtZI+LOdcNxbLi84432eNdQtP
 ShCyyE9+ntAnZrG+3Ca6LV2M6J/3beEcW54MNGg9fKkHMUOWj9EZwaVq2hg==
X-Gm-Gg: AeBDies4NpdG+ZfLpd3RNOIzaMUSMs7YrY3GeY8zc3+hs/7UKBRqEy5uTUn98w+aiJ7
 JEuHhR0nlvMIKdbr40D2w/LuLVqgfOjbOyapCGTlgB9iDhlKDPHXilTY/MYfwekOkBXnM5Lb4Q4
 4T76+YnEzhjR+ZoJy07fSYAfzhNEtYW61+oWKYxiuY4DENi/msm+DbY7hJXQC+XEN7r2TfkZ4Z4
 CDTU8Vu2fBM5X3MWR7Jeod2XAS0Dxv4HZUpNyb+f8Yu2g8mJANJq8P5YkAyvL/VpUDl7HB+TKtw
 z3HsSDkRd9+rq2YzHpyQ1YB5suRq8vvuFgI69VcZVXxp0kYgKlw9hV83gbUCRC1UeFqYGmu/koj
 QwtOxqnqTv6yuS+qklYVXVCcqD/du8SRHVhmbFWqUsFiZQF15Lh1JeAWJRCwOQHBYAWsY0DCyQb
 ojTjzTaRLkAlOXdxfNQpVDpEsC
X-Received: by 2002:a05:7300:8628:b0:2d8:1efe:51dc with SMTP id
 5a478bee46e88-2e464ea8c23mr8630090eec.6.1776704070825; 
 Mon, 20 Apr 2026 09:54:30 -0700 (PDT)
X-Received: by 2002:a05:7300:8628:b0:2d8:1efe:51dc with SMTP id
 5a478bee46e88-2e464ea8c23mr8630064eec.6.1776704070327; 
 Mon, 20 Apr 2026 09:54:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d2ce98csm14664721eec.20.2026.04.20.09.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 09:54:29 -0700 (PDT)
Message-ID: <a27af3e3-9c30-46b0-8616-1b3edaf5e65e@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 09:54:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] hw/hexagon: Add v68, sa8775-cdsp0 defs
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-5-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260416210305.2255579-5-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y8AsiNaRbJhSd7KzbwokT-NT7lXRWS-h
X-Proofpoint-GUID: Y8AsiNaRbJhSd7KzbwokT-NT7lXRWS-h
X-Authority-Analysis: v=2.4 cv=TK11jVla c=1 sm=1 tr=0 ts=69e65a47 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Jg-Ijm-e9e4bAIz-iCUA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE2MyBTYWx0ZWRfX6Tn1xzy7gJg+
 lfVzsG3F+JAq7rcSvvpkIE8HR7wWtJ8Ah3hmzeURBXQkMqxmH6h9P1VqPH2cje0gSxItIiFqye/
 gjXE9pfm2yh1OiqZJWT2biUtV2Gg1KfkLwTsPsAYLehZVzSU0Ub/ohZUu2UuyZqS2E5LIJKvQts
 AxO1mptbRtOPjUbFqnitfDe508Clf2ioTANhyy/saEydWe753XtBdSH39PiNjVKydS2GrYQz0y+
 MVjFijpxSgBnAMm42WhWfggMsjnYICQoD1Cbiz7uWEzH5ayYGhRnIyjBIDCWHASs+t/UDAsCuaE
 G5ocMg8OrBoEYN5DsmhJr+8jfuCXDSyn5gJp6TpAxsBZeGkhVtZsq65wZn6smAitCqWKz7pFQp/
 VN/D/sbUyq/GEVJwSNJiyP5jwOj7kHuai9sSJAk780P4nXROlRWVIKxArrdnWmJtulEkkWajbAB
 WqqxBkDkXy5wokuQQMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200163
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/16/2026 2:03 PM, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Acked-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc | 64 ++++++++++++++++++++++
>   hw/hexagon/machine_cfg_v68n_1024.h.inc    | 65 +++++++++++++++++++++++
>   2 files changed, 129 insertions(+)
>   create mode 100644 hw/hexagon/machine_cfg_sa8775_cdsp0.h.inc
>   create mode 100644 hw/hexagon/machine_cfg_v68n_1024.h.inc
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

