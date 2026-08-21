Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CBBC5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxSPc-0000NN-3b; Fri, 21 Aug 2026 12:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxSPa-0000N9-Cc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:48:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxSPY-0001jY-EI
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:48:10 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LFmCjf3876604
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aWugJZIEhPp933tg/6ZVBahkyCK8i0nxWqCIs7v4BKE=; b=FKgNWbEGOBflP1hX
 RJVB6KCCOsMIHcSgMfIa8Qn6XunzgLmwVUUVcbDhnm0B9ETgtaOgy5gWo9issfxz
 ZHiA8C58wuw0biMJ4/oPzlk99r4cIp9UjEgeCTknBmJuE/1V4B8qYn5W5cHfV/k7
 PQPJ/SsHURf7bRlufGUmApSt17hqPHroLL3FNvwEPhkMTvA5G9PAvebcpHdL3dHn
 ily1pIJ550pU6w+a4yKkTB2dgNZfjdW7q0jTO7fiS0H4CBFUyweFAOgxg1CNHGFt
 bXd+lUKrvOA58yNm02Yhl22+C+EDi7QR18nBU4TDMYgvDwvi6VHj4e3g4wG7BemO
 daqlVQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9tpj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:48:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so17686315ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787330885; x=1787935685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aWugJZIEhPp933tg/6ZVBahkyCK8i0nxWqCIs7v4BKE=;
 b=W/mDD4/8Jsx+lR+it4lEr/Kf77Je6ocHikQm9gnzGnQGC+VEM02F0UbzAUHpTKq1xz
 zg/uBgrWrwDE4cnPFFHDrwdLG4FDGNugdj4WfYFsFPFrDVJ6TOpagNlTy48m94eKqnMA
 ukYAXWC9nN6O8nLRmgbApqO07gTHp+64NrcnwY3F6R2Wz7eLMuPPfRVZ9fQC9Gahj1k2
 RKjW24Cbomf+1/HkkUk46mx4KZZbKbUpQtB8BkXmXFK/jBhdEJMCTlUJAvP94uOh9sqt
 KLOw/qFIk/2rsiGWO7rQvHDyr17LkhbwcEU4rtiiq6HbCTQoUQ3Oviw0m2tMv/ppiZye
 ODcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787330885; x=1787935685;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aWugJZIEhPp933tg/6ZVBahkyCK8i0nxWqCIs7v4BKE=;
 b=iprx205N+8LeoadOhf0LfxQMnCD/dQJ6Isrtd14lRj36AhJWdSl3dPZXdLEz1ztDQ6
 iNZopQ581zGCwkv8bfgagEMW0VU7a0AgLrlTgGKV57nwbuIfAG3LAtOApE2nOkJARG4v
 8NW75JjBIS+f0PAdQA6NGm6KvTJZMU5RDIZnhw1CwhB/zoU/nfxAVC65ozID2Lt/Jptc
 cmumBvxilADhY+so/YapCrU4EWxBoYKtdOHzh30f4Kr36VNkHs2ZOYwR3qKPsAoeGmji
 fCjqTkVoMFaqO7PK5yIcRSVhUJRCku/C6KmUI+fWtSpL6idk6z2Ih/Msrkovxf3iZZiA
 HMow==
X-Gm-Message-State: AFuF++kgardlkRAwB6n8AIkCensKEDutvzRFnFlEpAsLL83S2csB02ld
 rvwOFVHzpxX8d7cNScOORIo3TdqqC1783zlhNDi1YQQ7iZG1Bz+gXws+zk8/hHj43Y940VqN3AA
 2SC8ODiRkWm3oMKZgsi4bVoVAxeFdDARY9ZLOEKX8wOmrsXEqaEH3qlMOKw==
X-Gm-Gg: AR+sD13bSmbhjdvnmqoT5PZ+qDV/J1pq9CZjHPhWXQ0rp+pZ7VgoG8OSQNLabIi2bHC
 PPmTQz2xBv17JVbEu+tRtFIBDWH0GvtkUiuXIardj/2Q0TMmE6imIP8zMiOqkEYuYoeQK7C0Ckj
 JN2UiMisQdMU/Mi7Uu1cIvCPS1ByXf851jH7jBDvQctF7K70rLkwq/8+mAM+Cb/NyYXe0Mpn+Y5
 4xIv6cQoPEQttNqR1wqRJU9Os5D7HAW/zN+cymZXoFOfgcsru+fluZ+b2LgtE64Ssq/zErMT7zG
 wX3n8rqioz5U7f5NHSL1jUAklUeS6Qkt004jl7x2SfjpQLkuCjLXBpM3yl5zNVYcBZUNPOol9UX
 EUgMgzMUQaUxmFF8VA0zphHgtKqZcyMpqMJNK7Oj9peyTRHDQtJqJk1L4/7UanXOp80z9
X-Received: by 2002:a17:903:94c:b0:2c0:d94f:50c7 with SMTP id
 d9443c01a7336-2d61a0c9415mr204627705ad.7.1787330884786; 
 Fri, 21 Aug 2026 09:48:04 -0700 (PDT)
X-Received: by 2002:a17:903:94c:b0:2c0:d94f:50c7 with SMTP id
 d9443c01a7336-2d61a0c9415mr204627035ad.7.1787330884321; 
 Fri, 21 Aug 2026 09:48:04 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327c3fc6675sm41208898eec.13.2026.08.21.09.48.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 09:48:03 -0700 (PDT)
Message-ID: <258d24cd-309d-4f15-bd91-20e549fcb08a@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 09:48:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 033/104] tests/tcg/Makefile: skip user/system tests if
 target Makefile is not present
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-34-pierrick.bouvier@oss.qualcomm.com>
 <87y0e2p4hy.fsf@draig.linaro.org>
 <397f9e15-8be5-4e7d-8f5d-0eb686283154@oss.qualcomm.com>
 <87ecfsppz4.fsf@draig.linaro.org>
 <a5860c50-9839-4b46-8b36-0e4f4ea3c130@oss.qualcomm.com>
 <8733w7q2om.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8733w7q2om.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEzMiBTYWx0ZWRfXz7UgIAZIWwMo
 K7kcKH0rcWVwPDirkdNZv2zYc9LKEX0WA2Cg2FP8dtqScGPX0E0DPoPSWP0t9j8QMyp8ViKvQB0
 QMIxHhm4Erw6IEraAppsv1hOtEITt8llyD1jNOqs9+me6/x64sQMVChzVBIVmqhN1e4+veE/GOa
 vtv1qLpOnodmwRLqOQNfVbekZM8v+1XbYlkC5T2SpyokOmvEcqbe5M+jImMdc51aZlG+F5+dMZ3
 AZhPHublUVwCrAys08V1agyuwLREQ3+1vgQqJc7znl+UGYpcr03/12uRwyKHo9UJldcDN66vHYm
 L/tjhvBj7fyEnqYrC0gMj1USedoTpoDWJ/bdS+osGj+v0DY7sRkYZksCLvbIOhgIRzYm94jka1S
 owMhqcZBVL4DvJkoWhSMQJcCN44sFV6gogfLv2iITmbB29l4cKrBC+icTf6CwT54N9un1ULLcTM
 I/4MnusIv7J5pZ1kNWQ==
X-Proofpoint-ORIG-GUID: nZ66fi8WrDr1QCrz3UiOp0PjA5VoxPAC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEzMiBTYWx0ZWRfXzDMdF9L/AT5Q
 /iFv2OSpfBTniB6WwIIul50pR3s6HNOzGY/k8ySs94prSb3SBDImsP3aeuwSMSj4liduM+6ZnCH
 UdZu6OKaizpEumrPFTGQCYEjT/SnUio=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a888145 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=kfuGkC_R5-TUWadlOwgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nZ66fi8WrDr1QCrz3UiOp0PjA5VoxPAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210132
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

On 8/21/2026 1:48 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 8/20/2026 12:10 PM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 8/19/2026 7:30 AM, Alex Bennée wrote:
>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>
>>>>>> In the next commits, we'll port each architecture from Makefile to
>>>>>> meson, and it's easier to review those changes if we remove Makefiles
>>>>>> step by step.
>>>>>>
>>>>>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>
>>>>> Acked-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>
>>>>
>>>> It seems like you are the official maintainer for
>>>> tests/tcg/Makefile.target, thus I'm not sure what is the Acked-by
>>>> semantic for a component you "own".
>>>
>>> It means go ahead, I've acknowledged I've seen it although not looked
>>> too closely. Generally when a maintainer acks something they trust the
>>> poster taking it forward via their tree/pr.
>>>
>>
>> That's why I'm confused. In this case, I expect you will be the one
>> sending PR for current series, as you maintain tcg tests in general. It
>> can't be me, the poster, as I don't have any authority on this
>> subsystem.
> 
> I was under the impression with the rewrite you were going to be the
> maintainer going forward anyway so I don't see an issue with you sending
> the PR.
>

You suggested it indeed, I'll add a patch for next version to add myself
under your name.

>> This series will have to go at once, we can't delegate all architectures
>> bits to sub maintainers.
>>
>>> Given its a temp patch for the migration I don't think you need worry
>>> about having more review on it.
>>>
>>
>> In my mind, it was expected (ideally) to have a reviewed-by on all
>> patches before they can be taken to a PR.
> 
> I think we are almost there. I'm just looking at the prot-none
> workarounds at the moment. Have all the architectures been acked or
> reviewed by their various owners?
>

As mentioned on a previous version, my plan is to get all the
infrastructure code (+ multiarch part) reviewed first, to make sure
there are no last minute expected changes, which is why I insist on
asking you to review for a few weeks now.

Then I'll ping all the arch maintainers to ask them to review their part.

Meanwhile, you, Peter, or Richard, could also help on aarch64 and arm to
save some time also. It should take only a few minutes to review those ones.

Thanks,
Pierrick

