Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E14CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHks6-00031I-4Z; Fri, 16 Oct 2026 12:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHks3-00030w-CZ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:33:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHks0-0003ME-VT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:33:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG17xI2551805
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yQZUf6JthiRNR7ZHCFYQfvbWaFKRsMlWhfaUalJ4oEc=; b=gVRk56Rj1EhxnrSP
 k6GocRZkKMgHal4xuGW+DTTuqHCUPUGWhWqdPms8VdaFpHRXnZpPtoemD74J2mS7
 mMbk1s6NA5DxY/N8OsPfUOyYE75GgyWXJfX40hPMsZoh6TG0z/nsmFkSvsyQ+dmA
 BWFM5FPkOzvjTjFPi0na44WPXE3AxANaxU5INMJHjegC5j6MZeCyiTEtz8I68UMn
 u0WfXYbPjHt5MGNiOO9w4/KtnO0p4l53ss6MECmqXPZn7H6aAZ17rdleCLqQbBQ9
 ppHxGiOyoBL1IYf73ebUaXofcutGRtggkmrMzbPpnbqN6m7zh1LFJCmx8w41xhkI
 5h9aHA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq2wrajs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:33:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35cbea41088so57502eec.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792168402; x=1792773202; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yQZUf6JthiRNR7ZHCFYQfvbWaFKRsMlWhfaUalJ4oEc=;
 b=IGOrB/x2L63iJsquEhnfL50WIluq1xgykGjM5iT1zHNWmLBFf/u5nsD+hJMddX3QuZ
 pI8U6CskVF/leOhVM3SFGDYQGQ4Lt0/98fYDoqfeNtG+uOI3Tq1lDkltbb3y0wKJBHRf
 MBsXVUpiIZeoB+c75Dr2Pq9Zylzs/EwLd9ZXx/JDFL8VVKhOlwrzY5g+2Nl3APTQV/lq
 Nlj6bwv2T4aBkaL+DSnZxELPMVIYCNQ/A4UEufi0gUUzf9rdsrFqCS9s8COsep2/O5OB
 jCbrseYuLHuOSnMYQWYXUQT6aufztvE3b0p1cDx2w97ic5qON14kE/rzGW8lwmyXxSyD
 D09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168402; x=1792773202;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yQZUf6JthiRNR7ZHCFYQfvbWaFKRsMlWhfaUalJ4oEc=;
 b=vNKeXCa/GGFpFhCbCU2gnQ65bxsexGzvxVnKnS1ksXWbCGvRpVr7zeR/P9TYOcWrE7
 nGo2Kp3XjkP5S0uDDRHThWdxe3l0Jjvj3VFET2nhM3I1Yxuulb9YIickXaoAI0RqOfAD
 Wu2HQbGFT6/r8W2EvwS9++j0gapnwrpTKpBgoUl0XHBKGPKTVFXQQimfdYFJZiCzyCyj
 0/Dee7OmJPnoVXk3YeNBNo7cPlGzDrVe5hYOYTOa8RHnPc/E0EbvhdGgZZweSV4n9OZp
 NtBa4z5waTn/6T/d8zjirBvjQfXtSgMv3IoVFb65DvrxBaA4EHVYfpo3srdKXVs5+AqC
 gFZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHEp8m5n51/XnXzidD9ZyHxVF2EkCBeIUJCJCOBx4NNhDQJykfscXRqmiXNlyWlXfAgWZ2xMQsclG8@nongnu.org
X-Gm-Message-State: AFq9FYJOl6htXzy+HVvNNbE5WUQdxe5DoUPLalLJtTGxh8ylULNEE+Hi
 g05g7pEhT8fXGUiX3V5CHVRYQYO6K4m7oZdKAzq9btXw1D3775NWHA3Bi8ZTNzXergxaZBImkDC
 CwPLV405z08gUOUJ0YZFw+VPuyrYf+w98O/b1HCMp0eHOmgn9LWc/wsMovA==
X-Gm-Gg: AYBFou1/E7buhFGVV1QQiEXh1wxHNPX4z1/w73UPIaVV579bUAsByIVtOitxaF9AiEE
 pypUDLZQO84YgmJgpY1V7/W7/EXH08JM+CWHgzPZ69K2qUVCDw7ZIaTPVpnaJAsTDqJYjOcPYIg
 GgNgYGRAKAlFejWEIZt/m5ByZC4lIbMpfXCm0VFTf02zVQhKSR8i4fZinYbCIZbqkOhD3K6XKeD
 1xQz1FCBTnaYpD+Mi/DZ/rhTW2NJG5OefkWfmUd7SKZIreb8ywauttuBn9jf2qWmzCuKUrWwZot
 Slw3tuU4Bd601BYtLvGw9TMy1PQmRN2Vw6nvCWLBDSdM2BrJDJ+MlEekGQy0fVuxZ+trfPvr+hP
 0jjKDnflfGchXdJn6Cl2WQemDql9skCNY0cLy4Sy0VE6tRcPPHPASp1mYTNpiena409aoDQ==
X-Received: by 2002:a05:7300:7a9f:b0:35e:c56b:fd73 with SMTP id
 5a478bee46e88-361a302b658mr376147eec.38.1792168401587; 
 Fri, 16 Oct 2026 09:33:21 -0700 (PDT)
X-Received: by 2002:a05:7300:7a9f:b0:35e:c56b:fd73 with SMTP id
 5a478bee46e88-361a302b658mr375612eec.38.1792168390593; 
 Fri, 16 Oct 2026 09:33:10 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081ea7e5csm7577114eec.15.2026.10.16.09.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 09:33:09 -0700 (PDT)
Message-ID: <e1930215-1cd1-4321-bd8a-bb0ea875f243@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 09:33:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] target/i386: implement get_dump_info sysemu op
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-4-pierrick.bouvier@oss.qualcomm.com>
 <ae92234d-e6d3-47e9-b8a8-2d43a8855e20@oss.qualcomm.com>
 <2ddc345e-4f28-433c-8b38-d0609a0aa020@oss.qualcomm.com>
 <ce002f54-0762-4178-a9a2-a0556fbee135@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ce002f54-0762-4178-a9a2-a0556fbee135@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WIHqzXsR c=1 sm=1 tr=0 ts=6ad251d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=dPabDgfo2KomVw9yNwgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: j8hkIanRkyHZQBLP_qVU5pnGcScEVOkL
X-Proofpoint-ORIG-GUID: j8hkIanRkyHZQBLP_qVU5pnGcScEVOkL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX8yPVFThrlFzB
 3TLNzvqBXrC9O2KKOQt8QXj6hVykkX4CfVr+fnhi9dpu5Lk6dY4NRgEd4OfqtU5EOeLMZardivR
 EFIydp0ruSKpdy4p6M99A+hfzXAvIob8F0Fs9Knza3XsQaOhhbeYlbuivIak1O/MvFGm0CRtSdw
 1UmjUPaIJPvLE9i9FEp39USt40ZaFAippB8B/V0j+Mc/sYN3aEygfaGse4E+p5IY8EBVEBR1RPh
 cCSAaYZo7X1NXxWmc04W0lwUQa19OQV6mvBLghxd393mPv78+AVLPxMdM0pO9TbEVikx4Nidx9b
 sPXDLeVEIXgx+eKKtDMisCzXX5wTwNtf1tMqEAK66EI3ag9KTcjHSVb0nTOn/Yd9FeUa5r5JLgS
 zLqLylzhkVS1xIYJt5fEsDe6nU0M2SVi/SaWr4rqa3cRUpZ6lNbFqX/3TozGWZ5AHRIDA9zq3w3
 q5G94UwtLmloT5LR1/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfXyZhbWiMxjwzx
 6KcNq0nEK4oR3turpdblrlZmJo9pwyJs0+dupNpQ/xihPArOSd68ZopB/sI+Rw+xhxOCNaTUi7x
 ymRO7ivt3Zz35tvczT287OGi8cnlg8E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160065
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

On 10/16/2026 4:08 AM, Philippe Mathieu-Daudé wrote:
> On 16/10/26 08:39, Pierrick Bouvier wrote:
>> On 10/15/26 10:43 PM, Philippe Mathieu-Daudé wrote:
>>> On 15/10/26 23:32, Pierrick Bouvier wrote:
>>>> For now, we keep the global cpu_get_dump_info symbol defined.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>    target/i386/arch_dump.c    | 17 ++++++++++++++---
>>>>    target/i386/cpu-internal.h |  5 +++++
>>>>    target/i386/cpu.c          |  1 +
>>>>    3 files changed, 20 insertions(+), 3 deletions(-)
>>>
>>>
>>>> -int cpu_get_dump_info(ArchDumpInfo *info,
>>>> +int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
>>>>                          const GuestPhysBlockList *guest_phys_blocks)
>>>>    {
>>>>        bool lma = false;
>>>>        GuestPhysBlock *block;
>>>>    #ifdef TARGET_X86_64
>>>> -    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
>>>> -    lma = first_cpu && (first_x86_cpu->env.hflags & HF_LMA_MASK);
>>>
>>> I know this is pre-existing, but I'd like to understand this check, ...
>>>
>>>> +    const X86CPU *cpu = X86_CPU(cs);
>>>> +    lma = !!(cpu->env.hflags & HF_LMA_MASK);
>>>>    #endif
>>>>        if (lma) {
>>>> @@ -429,6 +430,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>>>        return 0;
>>>>    }
>>>> +int cpu_get_dump_info(ArchDumpInfo *info,
>>>> +                      const GuestPhysBlockList *guest_phys_blocks)
>>>> +{
>>>> +    if (first_cpu == NULL) {
>>>
>>> ... because you kept it. Why do we need it? QTest something?
>>>
>>
>> It's here to ensure it doesn't segfault when dump is called for none
>> machine:
>> https://gitlab.com/qemu-project/qemu/-/commit/
>> fd5d23babf9838c1b099a9e8020e778aac0ebb4d
>>
>> It's a corner case, but doesn't hurt to keep it IMHO.
> 
> I don't see it as a corner case but a bad API design. Why get called
> if a machine doesn't have any CPU? The caller (dump_init in dump/dump.c)
> should do the &first_cpu check, and either call with a valid CPU or not
> call at all. The callees should abort for NULL vcpu (programming error).
> Actually dump_init() already does the check by assigning nr_cpus.
>

That's what we'll have now with this series: dump_init checks first_cpu
is not NULL systematically now. (see patch 9).

> Anyway your changes look correct since you pass a @cpu argument to the
> methods added in SysemuCPUOps.
> 
>>> (goal is to understand when this can be called on a non-vCPU thread)
>>>
>>
>> I don't think it matters where this code runs, first_cpu is just the
>> first cpu available and it can be accessed from any thread, vcpu or not.
>> Now, the day we'll cleanup this TARGET_X86_64 guard, then it will be
>> time to revisit this question.
> 
> No need to revisit, add the target_heterogenenous() check (this code is
> completely broken in this setup) then we are good / safe.

Ok, will add this for v3.

Regards,
Pierrick

