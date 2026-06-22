Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83512CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbmHw-0002fi-NH; Mon, 22 Jun 2026 17:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbmHv-0002fY-RN
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:34:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbmHu-0003qz-3r
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 17:34:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaEFs2101461
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NdegVV91+KIuv31DP7MMWE7NAc3cNONUByswJ//Kquk=; b=lgTXsRB2C5R2N3is
 8m0sduSvaqV2J65i6julv+ZVg3hdUsnkglz6E2l1iev+f0ljq1oJOlmPn0CDhF5t
 qO+anN05xucLHNXUNAJi7aVcHGtCqXA8BkkreFe7P6518doAfrPc2RasaLgBfUel
 9VEWhCFUAzMT8wM5pwL9Fzx8gF9ThAe+CUk1p0/P75aAIAy+x+vSeqrDXG8JILZR
 Ln/q4bJdP0CS5uEdU0yo1WRfqHCf6hkyLMjNR3Hy684RQjcMYgBvdOQuU/dKUiab
 sJignwfaNqrPwQwyu1eqkspu6LIVsLdwmYcSo2XeuNyDfSnnGJ9A1EGbZGE4hO/r
 oyU2xg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebaa6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:34:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so15050937eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782164075; x=1782768875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NdegVV91+KIuv31DP7MMWE7NAc3cNONUByswJ//Kquk=;
 b=kYj/ySYz3YQz8mLWcEjRunNHa93u4wUds73b3aOLW19SmhCruyJ1FWfiNrpolF+J1+
 Xrkp8tKvwdS4e9+39pBt3f7lRaTcbhyyXRnZNkhvUuASkgQnzWK236dJ6bXiyCuX2IQw
 3sVhxLhC35k5JSfvmRU0cN9+QPB1gI+We0zIiw88Dj6CC+koE1KVof5e8LD11eWlPkuh
 v1gM4uo4R2uBND4rNyDDcc16w4IOcCNylPiulYTerSS90oFOtjX2ok4guYlDKhnlfWEb
 cBk66g1jSOLaV1bhfZSSzGxAt1d5jaO8qNZERg0EHdBsM+ZuZMPJMHU/g21Ogk1093bg
 LGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782164075; x=1782768875;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NdegVV91+KIuv31DP7MMWE7NAc3cNONUByswJ//Kquk=;
 b=P9nBrk32SMAJc0AXDQ1tL2E8Leole14BVmy2yuVbrHiwPyNvWn9MhKjWbw9gm2d7YK
 TlZ19nt/6o9dxbD/dvamkTRPaIeZXZxJk6/cKaGmIVJt3j1+Tuvy+blr2p+tyw+r4CqO
 VcFmLrjZyXT22rxDvgG3hzSw04c/npxbW+nAnkUgx9jHXslIW+6uGnh4jKaToTbkyD4C
 RKnC+LsvaC/y70vpeD3P7QCtRA95vaH0QyJqUdils/epcDFQanYz2kVjhOUWwavAAmnY
 KtOlmpUuwV4gPKhs1TPjARYQl1SWD/Fbvc809C8g9cDKPg8WDMRDm+ZyHIQSzeyUgBZu
 KTgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+i/HJSkIgqbOT4q8SVeurZOsc6Z+GK42aU6BqO8lMvc5n/IEnJlfvK+TD8E67OsnZuqVnIpbRhBi61@nongnu.org
X-Gm-Message-State: AOJu0YzXaADwpYVAifVOqTQFxf6nJT0t4Tg1RwjaUuvLA98Gai/7ggd6
 RI1/u/S/JiaxWibpwgaJRQB8SWcZGBah4NIsmHRCpG+TrdN/qYdJXNq3LeW576xwpRhjicukGDK
 D8rNZD7HVoTZc7NpNT5DtsLA1ll6DgOJXqi3ShdlMO+CHizduhDcVjUV5VQ==
X-Gm-Gg: AfdE7ckDCFemIe0WJmzeNxpawA54zWq3qx3CrYBQU3kBvpaxoyyoVKMCDEqZu2megr9
 ct0NaYrHktNovuzZSkW6mWZWNYadi4mM4aQ/m6iHmTgcUVmGkw6NwTIXf7h+Z+B0aQj/b4oiIgJ
 n4JhaT3CGfQ74OMw1DRn/mF4ZwlJXKMn36xzMUgydT/kyOtj/TbhG1By1jZN6nTCWrtY5Q2rhMd
 7jeixbSU6sz68OhDkMF0oqASJTKcwsoGcRbkj85Rn5ke2io4+aVaRNfXWGxaSmYDTkWUa0LTSoG
 DRnfIk1NZU6jGBrvmdpp3bYGuwTPkFyprxxDiXlfp50Q0qUOH3ZO0rwhUdfSYDYO2yHH5mDs/FE
 mO2DsSa44oTTUpuF/iK1spLIvggXl0HqlaM8jwqfQaTJOO0xd7AnIEUe3cAw+bFZU8djsCRn0gY
 4gr/U=
X-Received: by 2002:a05:7300:1904:b0:30c:52c5:6e52 with SMTP id
 5a478bee46e88-30c52c57c78mr1725365eec.22.1782164075541; 
 Mon, 22 Jun 2026 14:34:35 -0700 (PDT)
X-Received: by 2002:a05:7300:1904:b0:30c:52c5:6e52 with SMTP id
 5a478bee46e88-30c52c57c78mr1725326eec.22.1782164075061; 
 Mon, 22 Jun 2026 14:34:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bdffa83sm14732350eec.23.2026.06.22.14.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 14:34:34 -0700 (PDT)
Message-ID: <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 14:34:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
 <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwOCBTYWx0ZWRfXz7PUY8TLAFRw
 Ywbl8/JVVf+Aw1Tc7NjpERe0e1x5NCjfKM7vbEsNIvVECzy0OVugGUwfOVQlRz18gLxT9ROQm7a
 E7sSGfhlSIaKTIXEZyX2Hm0WEK1EFWU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwOCBTYWx0ZWRfX4x4JxttXwfGY
 ord5e9iPXyChLqS+baMR7B/ekHcgXJKPbub3ZMPVt86lh38R2zTK70OPdjWmRsU3lNrlQVKtayB
 onfaC90ZprNZYCTQNT4H8IrL0Dc4xUL6QtSOa5JHRbxvzKJoGCXwTvcxxIzO3CU0PKN4O3LAY3/
 htvP5CZLoabxLI90/8J06q4yIw+m/IAyqljQuJfRWy/Lbn0n/+hcHAdpUBF3qytIkLrGOpb0zVV
 h+mH6zDlAXvjcLH3ekzB734U1k0qtHG8wHK/9HMZoMdjTqm5KW7E6+ZktMzQXiivfV1kn1ZlVLS
 242Ek+LduPBX9B7s+qvwVbvxeec3QCSmVNzo5oax1jNGMxRRDsRBu97d/UQ8RLW3V5A253EXarM
 85WWBLIhZmPsdunkRbPo6BUCPqGrdoRQz38lz0GcHaeaqYwreChsTa8HciCa85trrgoFbdykyew
 KddIZLb6Od15rs6p4uQ==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a39aa6c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=7FkO25ltchWHTzeOLesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: enI3qjT0kkGVhRjPpXJw4I5ML_ajYkjn
X-Proofpoint-ORIG-GUID: enI3qjT0kkGVhRjPpXJw4I5ML_ajYkjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220208
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

On 6/22/2026 2:23 PM, Philippe Mathieu-Daudé wrote:
> On 22/6/26 22:52, Pierrick Bouvier wrote:
>> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
>>> Hello,
>>>
>>> This series looks scary but it's mostly trivial and mechanical work.
>>>
>>> It is yet another attempt at fixing --disable-tcg.  We have a recent
>>> work sent to the ML [1] and we had Phil's attempt back in 2023 [2].
>>> Phil's work didn't get merged and it's now too hard to rebase and
>>> revive, the most recent attempt got misled into the 'what is common code
>>> between TCG and KVM' dungeon.
> 
> 
>> It seems like series does not apply on top of master, would that be
>> possible to rebase it?
> 
> For some reason the RISC-V series are handled distinctly than the
> rest of QEMU, Alistair queues work on his repository and developers
> are custome to base their series on top of it (otherwise Alistair
> can not apply them on his tree and asks for reposts), see the
> riscv-to-apply.next branch on https://github.com/alistair23/qemu.

Unfortunately, it makes it hard to run any kind of automated testing,
especially for series like this that target specific configs.

