Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C31DCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpKU-0007W1-3B; Tue, 12 May 2026 11:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpKR-0007TK-Ts
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:47:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMpKQ-0001q9-Br
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:47:27 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CCgrrQ1409927
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U6MyCqbUnjpNb4FSaTEo1FBDObGtEZefDKQFMrW9zBU=; b=bYlvrsGRwtEk6IiW
 ojzoeylJ1S91Ra07aBqGm5JA+wif6zNRfaLlp5l2QuXscoiTvIZC9WzeleuKkl0f
 mI1B9P/CCHv0KebwkYTDyqBH1cg6V0r63g9/UQn0D792ezsbaKl94hzsUOBohCOV
 cx5+vq9EVHGViQNki+gLgEuhGFypZLF3eLFUGU6KrX1DN+Q+JHYVUSyQp8ZwZq66
 /yVcsSFX2VbjWRHEoMlWE0+ukytxhOhtLfgFZYf21ILtTMgdvDK5uZKQ094W3l2e
 WeQvpr5rwwehdrBqzL52PbhbjQ631CkEjm1zIGPd7ySyHtjjB6jV4K3AYizgSp9G
 1BJIeQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f30pvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:47:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f485961555so12037539eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778600844; x=1779205644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U6MyCqbUnjpNb4FSaTEo1FBDObGtEZefDKQFMrW9zBU=;
 b=YIUQG1riNFq+l5KWNL+i5q/CQMR1pkiF297hv7QqukF65M2qp9Xzha9W5E4CM19frI
 4LP9AH3e9RN2Rn67TqQdyQKBQlfJkmpdCMjpnhIKGPhpWtncoPAtpJ4LT+ule8Tp4Q8q
 ZCVMUWsjbAT245eyWA1SMJsC6EsYLY7WdhGA9vbZtUaf7zZx5Heuj9yufTIh15yoba77
 DeMdf6DMplxz+hnOsp68dxXWOP319w1apbg0CiQ6o/2RHCCupmO2djxkS/GVxDdIYpJO
 nw+RP47/R6LxU3uKtjnBHavCgAloG1V4gwKz8A0/sgpns9qikC9haizglA/plsvovA26
 BdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778600844; x=1779205644;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U6MyCqbUnjpNb4FSaTEo1FBDObGtEZefDKQFMrW9zBU=;
 b=b5Ouv9nqZsPAbvMu62p12kGveqTHjKVUKzgLhgZD1lsh3CnFq8MV80H6LenAqMJzRw
 L4egI9vvWPr41f8PQFKPz1Zq24iwieMAYQPOroH7o89hiGJLEQ6O+XnCcK3QNPfQc3B1
 Dmd/yL4B7XgXxiTEwB4sfE1WwiPiHeYX4FEdbeqLjCDtgeKImHSAfwwzf0WXc8SSgLjE
 FjB2VsYfEvEa/7g7Iiv9agqd/EFzta+l+yMIwsa1uidct9FlhNPeSjTBEQmFsS2MOUZy
 rRHs9+8MjRURmwdhVrcO8daqACUvknx24rXJl0F8z98lFTnOQ+e/Gng9xqg1rvZ65I1u
 Y8ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ9m+IkZ/fgOUV0FIT6iu2+mqMIAA2jfDY7IOSGD8NrWTUj+H4fd55X2FPByLEQ2mGzXwTNgF/apfjXD@nongnu.org
X-Gm-Message-State: AOJu0YxTIi8zZlEMgoQvbsuhsXKXaN7YgqJIRlAJbcMI0qsrbzb/WvZn
 LhaQp5E5/CUGXe+chsMGk6l+LgVuvQKE6hBG3Bl9mPOa1zh2GKFsEePRuAMlTE225sfO5zk/1Fz
 3GPGNSy+whfARjHwKLK4CaGdbViZGgL9MMdxt5rK1QvAewMkYLOs7LlM75A==
X-Gm-Gg: Acq92OHrxfwNhgZoFEvP6ZMWtL1DniYG/lZFcoFf04NU6Wf3uBXgCuMgjiy1TxoXgal
 DHGsSGZ1FGMdeT/2YmU9LIVA3sL8kMjssHZXz3h9SZI7gurPbdEuJhaCFc5ImFBF6uIkqEYtHhk
 abF//HEpsZGHZUmhvhZL/tDfi8KVKTSzcEmceZXKBtHS+Dj/8RVulE7BQoGPu4AL+SCVO/WxvCD
 e/qELx6Qd/DkzpAO9439WW+HL5ny2h+eQh+1FM/B1uiLSxySFCf7jXAX7ikmKkFHHA/ges05LWm
 RCL7HAi8CbhIyAa+jeiyU6Gj5eReaUX734EMU9Z6WMKDELRMM1FWgymELRKoH1A4SaAOrPaw4ee
 ackiNIUdeUrqRb0wdBPDMyFLfuZzBbe0fBM28mFR66OkqnL2OfAJ6HIn5TlKGEpvACr+Sy1l2Pd
 +8II6wOPOrTCU7KA==
X-Received: by 2002:a05:7301:1008:b0:2d9:b466:5e19 with SMTP id
 5a478bee46e88-2fb4b733d76mr7548203eec.21.1778600844131; 
 Tue, 12 May 2026 08:47:24 -0700 (PDT)
X-Received: by 2002:a05:7301:1008:b0:2d9:b466:5e19 with SMTP id
 5a478bee46e88-2fb4b733d76mr7548176eec.21.1778600843601; 
 Tue, 12 May 2026 08:47:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8860ce1bfsm18962595eec.9.2026.05.12.08.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 08:47:23 -0700 (PDT)
Message-ID: <8fad3679-a56a-4307-8ff0-08aa557c36c1@oss.qualcomm.com>
Date: Tue, 12 May 2026 08:47:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] tests: add nbd and luks to the I/O test suites
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-11-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424154205.364268-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vcrU946FVama6jur7B9iR7AZGmSQ_fEO
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a034b8c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=9kk393UxS22pZ2ExWq4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2NCBTYWx0ZWRfX6gifyJdcR0GA
 XaDypRnmuns/x75ywE9kaHjc3P3ewemAlbbC2lxGQZ482KSlofAWeI73Mj5BriXKBI30rNEFfNh
 1oIKVaArb9E4SLx+8bHryXvuNrRu+9Bakfsdke8M39OgoRIRhY1243mxs9ywig4B+Tl6gwO+CML
 4PiuC6zeXyn9cOWlU8Uyw9ktwTKzSTX0p0u3T1yVVAEXGfS4kaTNmK5/FqEBK92W3+0vkOuhi21
 BjCKPMRrKy3XV7akMI/aBP3cY6cOAwnpKkyjeKRacmw5EUxaXSbyU5Ui4mjfNHTpiRFx6fU+6mn
 3Vxye/vG8wz1dKgUHE+HWltz3CCji91DWdcboKyBcf12gHBGISvwuC519Fgc61V6eksfTB7e4du
 lnZL9eisoYJqN5CW5b16G/ETCuhD6/aZUMMomGjyl1SepRm+tdh9TKh+zYlcNZbspg6iNfk3rpb
 NxoZFbbWF315gCZDIng==
X-Proofpoint-GUID: vcrU946FVama6jur7B9iR7AZGmSQ_fEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120164
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

On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
> This introduces new suites for running I/O tests on NBD and LUKS
> drivers, giving new make targets
> 
>  * make check-block-luks
>  * make check-block-nbd
> 
> as well as adding their tests to 'make check-block SPEED=thorough'
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/devel/testing/main.rst    | 4 ++--
>  tests/qemu-iotests/meson.build | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

