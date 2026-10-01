Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6488BCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOzI-0001gw-4U; Thu, 01 Oct 2026 18:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOzG-0001g8-5R
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:10:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOzE-0002yi-Df
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:10:45 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691IxHBB3522815
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b2osu4VWN1+/miZ+Q6gjoKW/eim+n1EQ4/GWLGQ0CxY=; b=gajuH556S9w33fVW
 OvSRwAZeYGkyhaPhKV569vo9dQiTg/rxgxKVWq6BcTDi6Cue3EvWHtqGJE3HudoR
 9M7kBSapQNiP5wXGR/UzQYtv2Op1ePr2HuMD8SQCzBrHMhzx3y92S+JqLrI+Skdh
 79PdDtwGnZUyhv1zXULDL+qlhb02lfbJjy2VN70hFCVTDs2hLysi1yRr5VRfJX99
 +tyrkBvnChdN+/WPLz7S0GQHWyWMQKcj99yyYA3M/cXzXUucbSq874rg3drMkrGT
 MaUL/+uJThDm7Igi/MKiiCR4SJIREQMpvaug+A2fVKHSs2cY96tj5gKKN/ezdOcd
 RoPUPA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tgm9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:10:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34ef0362d95so747055eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892641; x=1791497441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b2osu4VWN1+/miZ+Q6gjoKW/eim+n1EQ4/GWLGQ0CxY=;
 b=VGVzn1iDOXkoRVyP53euVwTrcPgIX4Xj5FXT1SBXZNw4YnapEYQMmKCWd1llCAnd+0
 7cxoEO00vXdL2eLJ088TrcoNAy3aZ0eJW9Jx9Fbqsq64eqztW4jhbO+rI+S6UvjNpM2E
 aNZRHZqZIDrGDCHawh2mNN17yc7B3JEfGfvZMgn+Mgj9zpj+QbPkPgEnF/lkJvEabd1x
 6IHd/5zm+6bS+4qCSQ2SPSqdprtXFNxUXY6qA9St9CB9vGUh5uNjp3EVuI/lppyrhjAM
 l+wh2d8EQtPGT3U+JFKkHUCzOQYK+sSpO8DCeam/6OkE4RR0dFQOpVi+1hYb1RkB4dKQ
 CEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892641; x=1791497441;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b2osu4VWN1+/miZ+Q6gjoKW/eim+n1EQ4/GWLGQ0CxY=;
 b=Xrznit3Cg3axm1RYRn/sKKTs4FfI/GMhN2Nig2CXiIUUmQEuyeVKp1sG2oGReMGZZD
 YsCGa0K6yJGpCtDfJKOYyFnt+Tn44e3fyZi+q8ZK9afbsHkwx9R2zbaShVmZdzSWtATK
 1oI1PfDaXX0NuMeqrR+evavGhsSxZYzprIzeTI9+sLeovx2zvXbV0dqSimlNR7fjgHKT
 hHbXanCgk4QSEWRXJuOSeVhjgTLtYMauLsbdX7Qd5Bgtpc91huYj3AaaU9YyodhrRJ6Z
 xqJXnSwszwRD9n5Ih8oAdCvmXZkEuXHEwVgDxXmH41lPD4zik/rx7HPe8kPjPHoAcTNw
 07ZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqIwz0zl4O2VuzfouztEGM7XYWdXy1PPLhZ3JF2HrJIuphEByUyhZOzpb1JS+xn6QUxHhMv9oWttxf@nongnu.org
X-Gm-Message-State: AFq9FYIhy/u9ltwCcEXcPLYxZDCXTANFlRejG4KxfvXqSL/XoNtmee8N
 6WL2L53wG++vbhEPKYQSmUvcQPJIl4bmMYcwcXtHDPcli2SRt9O3xebGlf16Cr2l0zXBcVLVKAV
 qnxvGHKfUjzg0r41D9XQj513yv3gB17j9D8yD/LlcB8bUj+eT2vJ0nLDDCQ==
X-Gm-Gg: AYBFou3hMv9lyam5Rc5WjpvQ2/tpvU8nnVkAcbhgEasQMfkTy7eVrIFd0n/Bu6RuWuW
 FfcbbhRmlPEr7x7/LpIDBzDZ3I37Z4M/UdTbvIUmbLRTEcypSiq+Pch3ffMFAG76ZK+B/bJWvF0
 fsfyjkI/kJ15XUx0XgAhH/drqwEojmhGDiQn4bxzTckdSEnA5E6NujtalYzw2ivn63hC2DQvkN9
 4LDTgI16wcPoRVdsAZpPEQd2aJAW49PzxU0bX2QpQSpzweDSYQz7wcFHZDa//GbVTU9l3adzCUn
 WqyvKDFsECVdDvhKmaz48fyFbNLGUCOBBelo5u64wpll7CkHHFgNY/prPJpMsZGeeJzO86UerK7
 ESTj86mKCLScJah6AIarObju8ObqHwQoREkG5+wKAbKatP1k16MS5kBdrE7B40j33I39fgA==
X-Received: by 2002:a05:693c:66cc:20b0:34b:ee3a:10af with SMTP id
 5a478bee46e88-34f14f2df95mr727595eec.4.1790892641322; 
 Thu, 01 Oct 2026 15:10:41 -0700 (PDT)
X-Received: by 2002:a05:693c:66cc:20b0:34b:ee3a:10af with SMTP id
 5a478bee46e88-34f14f2df95mr727576eec.4.1790892640681; 
 Thu, 01 Oct 2026 15:10:40 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f65202sm1521702eec.11.2026.10.01.15.10.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:10:40 -0700 (PDT)
Message-ID: <9037243f-5a8e-44ea-bc21-5a69a89a2510@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:10:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] target/riscv: Runtime CPU registration
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-6-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-6-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ou8JL9xETzti-v9LWVOJHKTV0ERZweS-
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abeda62 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VTu0sFp2lcWg-p98E9cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX9WX2wUZSgXIq
 +mmBJFu4foiotebQI1YldAhsnl2JODbXgy/M9C+yxKycyDRAyloU5afqx+hgTE7FLkOnpAKKMuX
 fhKqS1s9kf94nrq4uM/lp2W37cHgRrdePWUwG4OQrm3/Ay+LW1GhsPSproVrHZFqZaXHcj9yBcx
 2eriRiOUWlUwajWfUGdroRC9+GcejxTU7avqD15MQfBgj+e8nw+lTePiOIIUIrHRm7hLq7jWU/b
 zO+02g88wRtiwHT9rgMMR64QCUNAXAb9T5DDC8u52W7E0lgxqehWyG26JaGJEBWxrU9VA2BFYh9
 BqZAKXDhny/GE5IciC9X99EqOFfUSqP4s6C17EEwasHEMFsqTsOCnrPBxTJXrGuF4S7yIfheylz
 e0AWtYauxb5mrrphEqdfk1jkg+JrvTNIdBKGH76vcxiQ3qlVm3Q3t06TQfWuxfsxnROshMVM/Cx
 W+VoljdZwR1Htm3SoGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfXzYW3czYFoLWl
 vfeqQLDq9ly0V3xeA4eNovkyOKUYq/W9leESe7N8txbhJU+CYeoj3vKjGAjsYC9jbVrbx8wWHRf
 IpTi8CwZo5rtgWYEie3dOjSGJCnIX78=
X-Proofpoint-ORIG-GUID: Ou8JL9xETzti-v9LWVOJHKTV0ERZweS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010088
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> Uses TypeInfo::is_available to determine what CPUs to register,
> convenience macros are modified slightly to make this conversion
> more ergonomic.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/cpu.c | 156 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 97 insertions(+), 59 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

