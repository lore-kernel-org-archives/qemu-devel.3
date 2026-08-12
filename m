Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B45DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2Yq-0000X1-0M; Wed, 12 Aug 2026 02:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2YV-0000Go-Ut
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:35:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2YR-0004ua-Ki
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:35:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C629D44090956
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PIm8nzkDw8izLQw0R7SbH4rIK5CZli3VK3581QUTHGQ=; b=CwOKUjRfWzDuxGRA
 YkkPuMG+ghOGeQp0BG+RPZPD6oJL0yYBqH7sef0aCnHQU0UlcjWlcGd5kJxuX9cp
 lmFQLp1MXgszVfLudZDqpvHCkshHIG/PfRJypIb8EGe9s+qfcbl15KEG0aOeEAMh
 2p8fJbKDZPXdZt71hd29A5pnStNPWJE8kbga2UDgszpU87zCJMmRLDYTeBi8j1VS
 It6TBq/XTvZib2mcBkC6ztNFOXzGe1AJee72DX7/ENVM3bOthvpMRnb5xXoBGnDz
 OeHkuibwIdm4vrko24d41RS7tnzlP5Wof/vtvcy+l/rpYm23SsThcNwvEGyO7RLh
 BeKRDA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049buuew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:35:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa3d9fbeso76941785a.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516509; x=1787121309; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PIm8nzkDw8izLQw0R7SbH4rIK5CZli3VK3581QUTHGQ=;
 b=Ampjn9xkOij5m/2KHuVmbzdkhJbTdHH8Q7MFWGOZ/dAogodKmI2c/oOu2SE/LNltkN
 lgnOitEizQpmL3lZJZlxWxMGcmaowkDpf4wCEoaSDNr/gC0akcGlHNnH2HcZwC/CDUHg
 fVkKwOsut+dFZoPmxvAecDJ87viBNU2QIernDUxHEDqBKKqFuOi3/vmWlEdld5JkVAfl
 8lusjOlQ0rIfJrshiieQrYGWuRNWAdM5FXsHHXwy9lNjgVaq/PELCvmZZdDU04FG2He8
 GhWUMae2pfDoI4qLycz3VQrC37AfxC0h+qpxnCVGe5tBAJsLkmyU7UHutEDR4R1uTa6n
 ZOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516509; x=1787121309;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PIm8nzkDw8izLQw0R7SbH4rIK5CZli3VK3581QUTHGQ=;
 b=LkXsnDUem+FCgGzcIt+J+Fiie4bKLgrUkT/700jddS+PTiWmo0YwkwCInJeXkVaQa0
 0wZvHCvzZ4gLpNyEaJSHl+CzvNojf3T9xFdy/iEMA+WwMX5lXLg5QjSO7sFbDbDQAxOq
 AlCo72EtTIN/BYkZJlTjeOO3YZGrH9A2HQHlW2WrYpb61LyV1KW1MJZrHkQIR8e/QUO/
 CJn+rz2xSPEeNuWRQS5LPm0BtL1pfiuePmiFnHdz+m2lGEY94AtSgEp07+CCQdcIz+nL
 x3tYosJ6kU/m75qSssTL89Z+oi9LbPoPELN+NzgnfTCkZ8vgsUje4sXW1FLcqWqj9Ntz
 phIg==
X-Gm-Message-State: AOJu0YzZ04xe92qEAJRWuMl+isCK64yuCt21iSsTQE2i74j0HBMj9xfD
 Cn5p+0AYe0oz7eT68Sw01tBqor9qIQABkr/6vFUKM87y/vGC9+4bYPtTxqNfgnRztIwGult5mBj
 wEcZBSK1XXJQtEX8EF1qZFJeAREWBLWXfItqSohYz//LrgKhv6PNss/7E4xpzI/fgEQ==
X-Gm-Gg: AR+sD12UJXCdeeCCDsOb43NrRq4aH0Mtg5wL0mITdcxmfOZyUbq8M+PFlkZlot3eqyi
 1LJf/s4dOTcIKSETVfCYg1JYIxxXK3htzRlLOc8A9qanw3K6HrLPlJ8G8128heE08YTFN2Z4xUy
 j5bFZzcWeB/+YnFFeW6xwq11Ck7tuA9rwGTGfDkSdpZMoAU6FSN7/T1WO55AGRFEWwpyjgzQwdf
 zx+XKVbxke0/21KlbejR7t5JdiZpLkAIJIKQvuM6eiKjGUGpMLeZwP+VKKLKBhgjpzBaJS3xAYL
 39KIrWcVcjj3waG10dt+3iTfYFeVD8BTiXaIqC3pJV/YrTRaFOjPWppO1iT7rNVKoI542JGo8mb
 lUbeIsmL4cTY3Pru6DWf8WeQPhctRp/FyVMLpO0YuC85ObCyWehQkRDPtclje/l1P8Sz3wntWYx
 touM30
X-Received: by 2002:a05:620a:29d6:b0:930:a38d:4030 with SMTP id
 af79cd13be357-936b3d539b8mr191097785a.29.1786516508857; 
 Tue, 11 Aug 2026 23:35:08 -0700 (PDT)
X-Received: by 2002:a05:620a:29d6:b0:930:a38d:4030 with SMTP id
 af79cd13be357-936b3d539b8mr191095985a.29.1786516508314; 
 Tue, 11 Aug 2026 23:35:08 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936b5f5ed49sm59698185a.44.2026.08.11.23.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 23:35:07 -0700 (PDT)
Message-ID: <43768a99-f9df-439b-9048-03a40a3eb3ae@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 01:35:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/41] hexagon queue - disregard
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D96sMvk68qMa_Uh7E6bkWKc5HumVfpzU
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7c141d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=skoJhHZsW5WYc2IUAdcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: D96sMvk68qMa_Uh7E6bkWKc5HumVfpzU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1MCBTYWx0ZWRfX1rVd/uIePTW2
 abkn7ATdmrS+S+glr+9xmTKwsoCrNYnxH0EGbCgYr9JRUG9ukqy1ODUYCZBxcjUINKTe9ZSUVqr
 yKM9J67rvmHs/7CjPtfyl+9QU9kMDO/oM6csqiPOWU2NtZ9rWoswcXerJioslOwUDaM7kWzRpLw
 dg5gtUAjfl1sB0eCIFlwI/5wXndDytPHCC+zGG4OoXAD1qm2aueI8QxotSH/ig+aQxwk8hv+MXK
 7xKhYP1FFPo9+ILibdANH8Gp+ILE6J9HGwd2NbuLKgJ8trxZ5gxncAL2eyI+c0k5boWBwcPsOlg
 wy8iInZOiaec7LAKqssQbCJ27iW9yIWZ8qiQ6diHUQ6YwKz/4ZOkbNMgDppSglPw2HIWQUPrBX0
 pBjzbmAU0FelDef9WhV0T4K7So0q5YdZLSn60PUa8b2q5pOwqgn1xNnlYXRJ++Qnn9f9Apn041u
 HHLDtO7ZYjawA17Zfjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1MCBTYWx0ZWRfX3fOEwbxm1KMp
 6EBuJ35dRaP20MZtx4Fzh9ABFTCgdUglEMKFn22293/XJzmzEs7zS1Lq4vBLhEq6DUUgTgpxMAO
 JsqUTJ+tUW8F0V166r8BYZx48bHnT5M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120050
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 8/12/2026 1:28 AM, Brian Cain wrote:
> The following changes since commit e8d693e12af9cbb89d724baadfcc08559669e279:
>
>    tests/qtest: Do not use versioned pc-q35-5.2 machine anymore (2026-08-11 16:12:34 -0400)
>
> are available in the Git repository at:
>
>    https://github.com/qualcomm/qemu tags/pull-hex-20260811
>
> for you to fetch changes up to 87a03d3fb03d4450fdb7b4ef26e6185496555d1c:
>
>    tests/hexagon: add tests for HVX bfloat (2026-08-11 23:20:45 -0700)


Sorry, Stefan!  Disregard this pull req.

I was looking at the wrong test results when I thought this passed.


> ----------------------------------------------------------------
> Hexagon queue
>
> Fixes:
> * ssub32_saturate, ssub64_saturate fixes
>
> Features:
>
> * l2vic device
> * qtimer device
> * HVX-IEEE instructions (v68+)
> * HVX GVec overrides for v{avg*,absdiff,sadd,*}
>
> ----------------------------------------------------------------
> Brian Cain (24):
>        hw/hexagon: add hex-subsys
>        hw/hexagon: move VTCM to the common machine state
>        hw/hexagon: move global registers to hex-subsys
>        hw/hexagon: move the TLB to hex-subsys
>        hw/hexagon: group the CPUs in a cluster
>        bitops.h: Add find_first_bit32()
>        hw/hexagon: extract get_reg_value/set_reg_value stubs in globalreg
>        hw/hexagon: connect l2vic device
>        hw/hexagon/virt: instantiate virtio-mmio transports
>        hw/hexagon/virt: add l2vic interrupt-controller and virtio-mmio FDT nodes
>        hw/hexagon/virt: connect pl011 UART interrupt
>        tests/qtest: add L2VIC qtest
>        tests/functional/hexagon: add arch_tests functional test
>        hw/timer: Add QCT QTimer device model
>        hw/hexagon: connect qtimer device
>        tests/qtest: add qct-qtimer qtest
>        tests/functional/hexagon: enable more arch_tests cases
>        host-utils: fix ssub32/64_saturate return type and clamp direction
>        target/hexagon: add GVec overrides for HVX saturating add/sub
>        target/hexagon: add GVec override for HVX vmpyih multiply
>        target/hexagon: add GVec overrides for HVX absolute difference
>        target/hexagon: add GVec overrides for HVX vector average
>        tests/tcg/hexagon: add HVX test for V6_vsubwsat saturation
>        tests/tcg/hexagon: add HVX tests for vabsdiff
>
> Matheus Tavares Bernardino (15):
>        target/hexagon: fix incorrect/too-permissive HVX encodings
>        target/hexagon/cpu: add HVX IEEE FP extension
>        hexagon: group cpu configurations in their own struct
>        hexagon: print info on "-d in_asm" for disabled IEEE FP instructions
>        target/hexagon: add v68 HVX IEEE float arithmetic insns
>        target/hexagon: add v68 HVX IEEE float min/max insns
>        target/hexagon: add v68 HVX IEEE float misc insns
>        target/hexagon: add v68 HVX IEEE float conversion insns
>        target/hexagon: add v68 HVX IEEE float compare insns
>        target/hexagon: add v73 HVX IEEE bfloat16 insns
>        tests/hexagon: add tests for v68 HVX IEEE float arithmetics
>        tests/hexagon: add tests for v68 HVX IEEE float min/max
>        tests/hexagon: add tests for v68 HVX IEEE float conversions
>        tests/hexagon: add tests for v68 HVX IEEE float comparisons
>        tests/hexagon: add tests for HVX bfloat
>
> Sid Manning (1):
>        hw/intc: Add l2vic interrupt controller
>
> Taylor Simpson (1):
>        Hexagon (target/hexagon) Clean up disassembly of control and system regs
>
>   MAINTAINERS                                  |   7 +
>   docs/devel/hexagon-l2vic.rst                 |  55 +++
>   docs/devel/index-internals.rst               |   1 +
>   include/hw/hexagon/hex-subsys.h              |  32 ++
>   include/hw/hexagon/hexagon.h                 |   6 +
>   include/hw/hexagon/hexagon_globalreg.h       |   8 +
>   include/hw/hexagon/virt.h                    |   4 +-
>   include/hw/intc/hex-l2vic.h                  |  61 +++
>   include/hw/timer/qct-qtimer.h                |  43 ++
>   include/qemu/bitops.h                        |  30 +-
>   include/qemu/host-utils.h                    |  24 +-
>   target/hexagon/cpu.h                         |  12 +-
>   target/hexagon/cpu_bits.h                    |  12 +-
>   target/hexagon/gen_tcg_hvx.h                 | 170 +++++++
>   target/hexagon/genptr.h                      |   4 +
>   target/hexagon/helper.h                      |   5 +
>   target/hexagon/mmvec/hvx_ieee_fp.h           |  69 +++
>   target/hexagon/mmvec/macros.h                |  10 +-
>   target/hexagon/mmvec/mmvec.h                 |   3 +
>   target/hexagon/printinsn.h                   |   2 +-
>   target/hexagon/translate.h                   |   1 +
>   tests/tcg/hexagon/hex_test.h                 |  32 ++
>   tests/tcg/hexagon/hvx_misc.h                 |  73 +++
>   target/hexagon/attribs_def.h.inc             |   9 +
>   disas/hexagon.c                              |   4 +-
>   hw/hexagon/hex-subsys.c                      | 175 +++++++
>   hw/hexagon/hexagon_dsp.c                     |  45 +-
>   hw/hexagon/hexagon_globalreg.c               |  65 ++-
>   hw/hexagon/virt.c                            | 130 ++++--
>   hw/intc/hex-l2vic.c                          | 556 ++++++++++++++++++++++
>   hw/timer/qct-qtimer.c                        | 667 +++++++++++++++++++++++++++
>   target/hexagon/arch.c                        |   8 +
>   target/hexagon/cpu.c                         |  23 +-
>   target/hexagon/decode.c                      |   4 +-
>   target/hexagon/genptr.c                      |  70 +++
>   target/hexagon/mmvec/hvx_ieee_fp.c           | 137 ++++++
>   target/hexagon/op_helper.c                   |  37 +-
>   target/hexagon/printinsn.c                   | 108 ++++-
>   target/hexagon/translate.c                   |   5 +-
>   tests/qtest/l2vic-test.c                     | 249 ++++++++++
>   tests/qtest/qct-qtimer-test.c                | 385 ++++++++++++++++
>   tests/tcg/hexagon/fp_hvx.c                   | 226 +++++++++
>   tests/tcg/hexagon/fp_hvx_cmp.c               | 275 +++++++++++
>   tests/tcg/hexagon/fp_hvx_cvt.c               | 219 +++++++++
>   tests/tcg/hexagon/fp_hvx_disabled.c          |  57 +++
>   tests/tcg/hexagon/hvx_misc.c                 |  77 ++++
>   hw/hexagon/Kconfig                           |   3 +
>   hw/hexagon/meson.build                       |   1 +
>   hw/intc/Kconfig                              |   3 +
>   hw/intc/meson.build                          |   2 +
>   hw/intc/trace-events                         |   4 +
>   hw/timer/Kconfig                             |   3 +
>   hw/timer/meson.build                         |   2 +
>   hw/timer/trace-events                        |   5 +
>   target/hexagon/gen_printinsn.py              |  14 +-
>   target/hexagon/gen_tcg_funcs.py              |  12 +
>   target/hexagon/hex_common.py                 |  27 ++
>   target/hexagon/imported/mmvec/encode_ext.def | 126 ++++-
>   target/hexagon/imported/mmvec/ext.idef       | 369 ++++++++++++++-
>   target/hexagon/meson.build                   |   1 +
>   tests/functional/hexagon/test_arch_tests.py  |  38 ++
>   tests/qtest/meson.build                      |   2 +-
>   tests/tcg/hexagon/Makefile.target            |  14 +
>   63 files changed, 4657 insertions(+), 164 deletions(-)
>   create mode 100644 docs/devel/hexagon-l2vic.rst
>   create mode 100644 include/hw/hexagon/hex-subsys.h
>   create mode 100644 include/hw/intc/hex-l2vic.h
>   create mode 100644 include/hw/timer/qct-qtimer.h
>   create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.h
>   create mode 100644 hw/hexagon/hex-subsys.c
>   create mode 100644 hw/intc/hex-l2vic.c
>   create mode 100644 hw/timer/qct-qtimer.c
>   create mode 100644 target/hexagon/mmvec/hvx_ieee_fp.c
>   create mode 100644 tests/qtest/l2vic-test.c
>   create mode 100644 tests/qtest/qct-qtimer-test.c
>   create mode 100644 tests/tcg/hexagon/fp_hvx.c
>   create mode 100644 tests/tcg/hexagon/fp_hvx_cmp.c
>   create mode 100644 tests/tcg/hexagon/fp_hvx_cvt.c
>   create mode 100644 tests/tcg/hexagon/fp_hvx_disabled.c

