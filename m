Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF320CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 20:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVbT5-0004Y6-Eq; Fri, 05 Jun 2026 16:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wVbSw-0004WQ-6Q
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 16:48:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wVbSt-0002EF-Mi
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 16:48:29 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655G6KxA821374
 for <qemu-devel@nongnu.org>; Fri, 5 Jun 2026 20:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hxMz9UsKxcRybBopNCoJbtRzhhGoiVSn9fMA94r+tlA=; b=AXGBN8ZerOdi1ZBs
 FMPHk18OpVH0zai6Vxg59HPEK4l1FAjv+ecJ3b0g7SzmrDI7blCXMwi1wD3FrdO8
 hQtInS0YmozMVAeTqyloBqMu8mGflOzBtA18FkCVPosErcCnQR0aqB8Wj/1iL540
 ltEs/VWaARLms9YBZ33Ze4mq9qt/Evm0GltmJLf+QpuPRJ4bP/6x9bbh/dyWYadP
 S1cPhJBP9TuWPt+CHUPOmVnCS9knL+dlB33Mo+h6uUTsxwa+bgGA3mfuNUecQdFj
 Ws7YCPvts8cspW7mIXRuU+BcCwKkXZwRIkuPBQtKhX6hoTMGQyA8pAkaLXOdUDTK
 OnnXCA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekncbmm47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 20:48:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ccd719a2f2so55147406d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780692504; x=1781297304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hxMz9UsKxcRybBopNCoJbtRzhhGoiVSn9fMA94r+tlA=;
 b=STOHjLkgu3EZfHkxSsIpDgjB7Sn6/lJzbC6ki6LpKFbAxz3keSbpXr3NxBOe0WopvF
 YooSvLgy06T3/3nChex+m3ito6lsuDWHqtcwmyXF1F/DO7kcK0YPdogbJsAfnhB4HeWC
 WWWjnmztvNRlI7Kxd8bCLw44PKr+LoBqiD9nZK17043sbN0r07bYorHwUgTgJ86E/66p
 zzqKbu27L8DmCbLbQAeyriZxds0yhybGmy3FHWnGXmIMlpgk1ImgYbJn9TGbNPMBpKs3
 uBM8F72PMiPYzvjqi6l1iIk4A2eXmdC6PSwNfPOi64ONdrqdxLR4OOlQd5c4A4iu5CKF
 V5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692504; x=1781297304;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxMz9UsKxcRybBopNCoJbtRzhhGoiVSn9fMA94r+tlA=;
 b=qLTSiMbjHCLDSPv2ny7KB2KwcHtmnsUvgIR9JUuevgN48p13ASGkbOUGcioBUuVFpC
 ewU6eI4FfRxv+9rungoTEge3vFAr0sJFcvsOHSRkTz6FKYmUVKdF1yw5WCytXD0KYQhf
 CVRU3WyF9Bc3h+jNpVXPEeNmJVYCcCNJngXc1rW8QUMEsR7XJDJkZl38/ZGW+lSpTQo3
 gzFkRivgdpPEVj+HV50RcAegXmYMDsU2sn9kpbvy8nrdD0Ihvt/alfCPHpaHFssBilSv
 tjDmYloENGh18+AN+IcBLKr2ewkWAl0S0bSaVv7gTGZoW25NGdJVwMvFOKNeAVuQM/2G
 krog==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a199P6dHaDGkTjz6dDj1kqufHrA456cxjpsznh/3jK0w3YH2U5cZ5M2XlNl5OOwmdlToWxQ7VCCYK@nongnu.org
X-Gm-Message-State: AOJu0YyAEwW2MjN09Ep+h/0NW5xtt80N4SUFU9YBKPx44jEAnFrFavAM
 l8kQCxcOqi1eZP1e2x/eY5f6rZtRIPfqakdWrktDmIEabRW6wTQD2vijjI+n2GB1zXrVVo4BgH1
 qQYLbHQS8kB5fFTK3yA8Li+xqEkb3ycSRZ/RWEP/wAT2BwH0R8JsA6cbz5A==
X-Gm-Gg: Acq92OGDO6TxHJYb3ScxXZmhnbrq81x5Fjku1tjyGKssu0O97KLSbnViI5/t1QdOMJT
 ykAhWhE6hN55+62Qvxk7JdtAq/AZT6UauLtYMrPSwuUI9T1z/3IyHluDrEtRxaHT7ldhibdzJHl
 KbHqvJs/KKIRl075aHhBxE18zEgTjziqU9C4o/8Dk8j7sAwhE3frqSSi7yzrRrCz9/zshiff12n
 W2hAET8RxD6w1G+cUP8Aq29DSEz2zSG3ObAXOAiCJKvzUdkVm2f4cknwujv90y3ggLeW3hsPE64
 0shNg+9/7q2eSCsE1QQUM7zH3zIfIAia8Nx2CjeBCiUv35xFufhvBupdz13Wq44P1DsMT9DhbKm
 xC6am2DOPhB1KLd9zySxaVfMuniJ47JfgK0oRBo+/ZHhSe/cCS+O5gKpDdwSSNKcDxDKj
X-Received: by 2002:a05:622a:2616:b0:50b:86f5:8fbc with SMTP id
 d75a77b69052e-51795c6cfb0mr86140641cf.51.1780692503682; 
 Fri, 05 Jun 2026 13:48:23 -0700 (PDT)
X-Received: by 2002:a05:622a:2616:b0:50b:86f5:8fbc with SMTP id
 d75a77b69052e-51795c6cfb0mr86140111cf.51.1780692502983; 
 Fri, 05 Jun 2026 13:48:22 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd06f5eesm92921736d6.37.2026.06.05.13.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 13:48:22 -0700 (PDT)
Message-ID: <9b05368c-972a-491e-bddb-7e015100eee2@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 17:48:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: Icenowy Zheng <uwu@icenowy.me>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
 <4acb210eea217195fa733a4f42369c01591d5499.camel@icenowy.me>
 <a77a1891-214e-4788-8cc3-a5729f5cd182@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a77a1891-214e-4788-8cc3-a5729f5cd182@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OauoyBTY c=1 sm=1 tr=0 ts=6a233618 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=V1jnuoLLAAAA:20 a=uTRCLKPYAAAA:8 a=EUspDBNiAAAA:8 a=Ide_D7xp1xPUo5_TickA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=T-agBWn15iSmxapsA1lH:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDIwNCBTYWx0ZWRfX9OBRMI0DPZnD
 pQvPZ9TCWAjMBGmVdzsQmgsr2V8Kr1zJbqIgFaNwQbG0u4KO88i1xycU5Hoq74S1I1/pLjC1nMj
 ue6BZeZN3KFEl/8ang8Z4ZEuJ5fvIppkD7pXG9STWW2WZH9KnQniGCDdo9QFs+NHOoT7BQgzf1B
 0Y+VD7D8V4DDgdOPPqgs41Oxfqg7XrvgF3iuRBs57gfOy3JmMola9dtDWAptHKxEtYGHbX41A3b
 7C4YGeYR+qpyvsN6TWJCM3Aj5euoFV5JaaRgX4TJKi4/2uFF+TtRYyoUs2PjFhlxEkIczdeO6fL
 xQNCji/1+93Nu4v9TOCIhNadtTt3r2n2r8do5ud0fgBO5OPiY6eQRjy9RD7qzNeK4dLPmpS/CLY
 XN9HWn8LqNOQDWX0xeM/KaXdu3Ct8LdTBgfT3A+vS0gx0W/K2g5jM2bPr+3r73XF7pLzSaK1zf/
 dK24NJUBuJaf5RzywAw==
X-Proofpoint-GUID: _Bc6jEJltryp6VTnlDnrQX7HQ_82cun8
X-Proofpoint-ORIG-GUID: _Bc6jEJltryp6VTnlDnrQX7HQ_82cun8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050204
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 6/5/2026 9:28 AM, Daniel Henrique Barboza wrote:
> 
> 
> On 6/5/2026 3:59 AM, Icenowy Zheng wrote:
>> 在 2026-06-04四的 06:52 -0300，Daniel Henrique Barboza写道：
>>> From: Fei Wu <wu.fei9@sanechips.com.cn>
>>>
>>> The harts requirements of RISC-V server platform [1] require RVA23
>>> ISA
>>> profile support and others.
>>>
>>> This patch provides a new "riscv-server-ref" CPU to go along with the
>>> future "riscv-server-ref" board.
>>>
>>> [1]
>>> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
>>>
>>> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
>>> Signed-off-by: Daniel Henrique Barboza
>>> <daniel.barboza@oss.qualcomm.com>
>>> ---
>>>   target/riscv/cpu-qom.h |  1 +
>>>   target/riscv/cpu.c     | 11 +++++++++++
>>>   2 files changed, 12 insertions(+)
>>>
>>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>>> index 30dcdcfaae..a150acd151 100644
>>> --- a/target/riscv/cpu-qom.h
>>> +++ b/target/riscv/cpu-qom.h
>>> @@ -42,6 +42,7 @@
>>>   #define TYPE_RISCV_CPU_RVA22S64
>>> RISCV_CPU_TYPE_NAME("rva22s64")
>>>   #define TYPE_RISCV_CPU_RVA23U64
>>> RISCV_CPU_TYPE_NAME("rva23u64")
>>>   #define TYPE_RISCV_CPU_RVA23S64
>>> RISCV_CPU_TYPE_NAME("rva23s64")
>>> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-
>>> server-ref")
>>>   #define TYPE_RISCV_CPU_IBEX
>>> RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>>>   #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-
>>> c")
>>>   #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-
>>> e")
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 3f0f931335..c4a5a7f1cb 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -3315,6 +3315,17 @@ static const TypeInfo riscv_cpu_type_infos[] =
>>> {
>>>   #endif
>>>       ),
>>> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF,
>>> TYPE_RISCV_BARE_CPU,
>>> +        .misa_mxl_max = MXL_RV64,
>>> +        .profile = &RVA23S64,
>>> +
>>> +        .cfg.ext_zkr = true,
>>> +        .cfg.ext_svadu = true,
>>> +        .cfg.ext_sdext = true,
>>> +
>>> +        .cfg.max_satp_mode = VM_1_10_SV48,
>>
>> Here it only declares the maximum supported SATP mode is Sv48, but the
>> RVSP spec requires Sv48, and the RVSP REF machine created in the next
>> patch also requires it (because the above 4G PCIe memory space is
>> beyond 40-bit physical address space).
>>
>> Without `,sv48=on` explicitly enabled on the CPU, booting EDK2 firmware
>> will fail because of the out-of-address-space PCIe memory space.
> 
> You're correct.  We're not initializing satp_mode to max_satp_mode, so the
> default value is being set to sv39.  This seems to be the case for all
> CPUs, not just this one.  For some reason I thought we were defaulting
> to the max_satp_mode.  I need to understand why sv39 is being set as
> default (i.e. why not BARE?).

Got an update.  It turns out that what we're seeing is something that is
only happening to this CPU we're trying to add.

The way satp mode is set on QEMU assuming no command line input:

- "Bare" CPUs, aka CPUs that has just I or E enabled: default to BARE;

- Profile CPUs: default to the minimum required by the spec.  E.g. for
   RVA23 the default is set to sv39;

- all other CPUs: default to satp_mode_max from the CPU definition.

The riscv-server-ref CPU is a BARE CPU that is using the profile framework
to enable extensions.  So for all intents and purposes the code is treating
it as a profile CPU with extra stuff.  Which is good, but then the
satp setting from RVA23 (sv39) is overwriting satp_mode_max from the
CPU definition.

I believe the way we're creating riscv-server-ref here is correct, so what
I'm going to do is send a couple of fixes to allow riscv-server-ref to use
RVA23 as a base and honor its satp_mode_max value too.


Thanks,
Daniel

> 
> As far as -cpu riscv-server-ref goes we do not want to force users to
> specify sv48=on.  The CPU should default to that without any additional
> command line.
> 
> Thanks for reporting this.  There might be extra stuff to do in the code
> base before adding this CPU (maybe adding a 'satp_mode' attribute and
> make CPUs default to that value, like profile CPUs do).
> 
> 
>>
>> Maybe a RVSERVER profile could be defined for CPUs conformant to server
>> platform spec (because that spec really adds some requireed
>> extensions), and use it for RVSERVER_REF CPU type?
> 
> 
> Treating riscv-server-ref as a profile style CPU might be an easier alternative
> to have what we want but I wonder if allowing CPUs to set a default satp_mode
> is better long term.  I'll see what I can do.
> 
> 
> Thanks,
> Daniel
> 
>>
>> Thanks,
>> Icenowy
>>
>>> +    ),
>>> +
>>>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>>>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>>>           .cfg.max_satp_mode = VM_1_10_SV57,
> 


