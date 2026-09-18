Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841C1C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Tat-0004Nj-6X; Fri, 18 Sep 2026 04:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7Taq-0004NB-76
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:05:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7Tao-0001e6-A1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 04:05:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I6029c3304798
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PK5uF7I7b+OGJkZsuhXrY8V8/a6MgSMqCSARLhHiSHI=; b=FIZ6+kgpi1ars8ea
 dgEVXa/P1rmCHIGM4JZjgoUoXECLX87krpw+SoIhW3yMT231aCjfsLfxRJ/pZ00E
 8wdz1oRWThA2EAdvKxNzfDqH+stHPqvRqjTi/2idkiclB6+RRZRcQUu2PJ7vnH96
 z+t8/SBkRuIJ5EeHuu+nE6erQ3CMIw6opgJSGLPRTbsYH5V7U/r2Say3FjLxY+Hy
 2sr9hVOpHbP9avnqvusEUzTYLceiiP4536NRatBSbtTd/Dj6D9CeKYVo0oNl1Y+h
 avOW/9zc8Z+sdu18vAIPbgIsrCJW4RMgiCkv3qNPpX+UbtznFhYZ/yB8TfFjCRv1
 +oGwCg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grq2ktgbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:05:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-854f274dd69so727602b3a.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789718706; x=1790323506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PK5uF7I7b+OGJkZsuhXrY8V8/a6MgSMqCSARLhHiSHI=;
 b=ftfcFz6qLoYDtCYVXOjKx/VcTvlZ8PK3SxMXH/Qi/zv0CY+1tHPyWc6ASoKwGL3xm3
 lPbg3ZVDOmGlN6arGikcIQH/uoYaw+T+bqU7WyoMt8tO4A1xmX47vQ/l9I1yKSXRtiO2
 SD7FJ9p/o+XieDR+1cBI2MZPksxwY6EgIhVsb5F9+RXLWfmlPgNkY9euxcrFQyka5bjH
 cOGG4ueofopyOA64+dwvO/p+AeTL9grc9S880Yl18Fv8QJhPBWtBeriDgxnst2JPPvAR
 vCrwmRwnlzhjLzlUSztje68Po6iZtXk3RCtOLcp1UsJ2++ohV9zlGwHGBFyef6nm6cu/
 xA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789718706; x=1790323506;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PK5uF7I7b+OGJkZsuhXrY8V8/a6MgSMqCSARLhHiSHI=;
 b=PAUS5+NJ6KKctr2B8LGPyXTqhECA7MZ70mTAKwlPw1TOqv9OOR3d5QFLHpu9QQcPMg
 nYNXgNY/3vodtnNYFr0k1nAEo9VqWcawIAOmrTYvawMC3E8ASkkJLdm5bMsEXpQtmeGC
 smay2UlidkAyoG/vQUBrXj69HNUiOBcQSUkcZvu4hlTjWPCMMvnk0mUnKRTLwCkXFUlx
 XQ40OKU/5S/m98LI/w2GtJxXZkzEwA5OtYIa1NarA17GLrDX8N/Q209VRuRf+yfTLJR8
 +Z1VLTttE4T/KhZ8YcKi9sNq5pn16F7sZu65AeQ5kGPI8/fqza67GenvdED1HabHdBpS
 cM4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJFzTA4k6DFKAfbWJjFBdlHqo/xrx/+ykTdCoqOLhK5BdNVfHDUfRnmQBIix2SiNBRCaruzF/vJDWv@nongnu.org
X-Gm-Message-State: AFuF++ldj3sqKjswR3vLpXKST1mDTxPwV/m7Iftxukzq0rvhyThm42X6
 BZ1yfXEbvRVO5av42sPZrJg5hZsOm3+t7tFOW8L5DRpw2lRgYFG89Jd1fMkQxBb/jpQTKHrVmOw
 anuu9m7K4qIGMYT4s/Kchts/r0VA7513HbS/z32n+VcmSXXxGxoP8fttCsw==
X-Gm-Gg: AYBFou1AbXGezYwTfF2c3pGHUM+s3M4DvEdP6szzx6mjJG7gCH3oszfx64V4tFxihbP
 c0eLBFNR+TyqtY0/WbtUjFD1UYh5cA1F56FYMYY4JCnlYDj8ESN8nkMMi0lCgVGsBpOtTDfsuYl
 c194Qaj3t9oa77rNmzrdypkGb5friBUXC9HaMMnM5t8R1cP2PZF4Zm2SCV2PuNBJSQC7gblqst1
 puHNnMohDdAFIinnWGaC9CLEwRFZ4FuDs7jcs7Rp5hYDvhG2BFSXoYW+W+gKO8Img2Ztc7bc2W/
 O3CPfVbXMv6RmMi4SesZx0nUlaYZvmxZ3nrnPNTCqmyYKOOu3gTlJWH71Z6767bPeIsBIGU9Lf/
 kDAldIIIobA5+tPwgI78+6KaYEJwvna/vGVa2U1RYTztps4LunU+hTWn+KjHFfIM139ZC
X-Received: by 2002:a05:6a21:4d14:b0:3d3:af85:eb98 with SMTP id
 adf61e73a8af0-3dd8c4cc200mr3829766637.26.1789718706224; 
 Fri, 18 Sep 2026 01:05:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d14:b0:3d3:af85:eb98 with SMTP id
 adf61e73a8af0-3dd8c4cc200mr3829707637.26.1789718705746; 
 Fri, 18 Sep 2026 01:05:05 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c28180a4dsm3120972eec.0.2026.09.18.01.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 01:05:03 -0700 (PDT)
Message-ID: <d1cf4f82-5604-47b1-887c-99d69cf1b754@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 01:05:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
 <87a4pf6moc.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87a4pf6moc.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExMCBTYWx0ZWRfX8L9FYjybyQcy
 ZnXEoBbc+X0yitTwKzO42y1UxgSF2NjqPGSark5kP0EKwIWFxutUykNiwgNhIP3Ditk8OETWXzs
 aHW9lNn1Nn+P7J/nmY4dhZL4f3EAiR0hCAN/dnkCEG+kOG3LP6UKcYVzMJobbyCYRxDENygkVXF
 odoPmhc/OuEyVqWb9zkrUUn+lMa75IQotUOAIaAZnJOhVMX0SaQhasNjmnbjy0ysjBDDNkW1IU8
 9SwU/QdbudiwXcqeyVNqeWvOVW0Hd2G2Imtt1nq7gKPPVbYJEwXCiw+n3oAF61Vv4XNNTCgo4on
 9gnDlMSkPOHtika2FxXzotBHj8jvaqP2kZ/7kDHpRrOAgLeVzNifP8YOUdck04pzxOg/UO7ONIA
 lqVPHCBDKkpfH0+NYBBapJ2A5YwGOrmuVaztgsez7i+fKFBhKTF6C2XnuHhD1bgu7WkjwLwZMwI
 l3uB5Mg2BxbJBhEPjYQ==
X-Proofpoint-GUID: E3C_MQbHqkpCWEjDcmvTwUMwZ1iyBmY9
X-Authority-Analysis: v=2.4 cv=bcD+w+PB c=1 sm=1 tr=0 ts=6aacf0b3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Kw0r6GTJeXToWZxFxjgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExMCBTYWx0ZWRfXy6MYtMC8QVmA
 eJJd79kMhc9j0IK4f5VZBDAAEK199u/13ZLXuuya4zGNhbfhaZZgFEgUpc82de3Hv49tY+XcWxt
 CfYo3530uDB64U9kjxYc9LV0i4GfF7s=
X-Proofpoint-ORIG-GUID: E3C_MQbHqkpCWEjDcmvTwUMwZ1iyBmY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180110
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

On 9/18/2026 12:30 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/17/2026 3:18 PM, Richard Henderson wrote:
>>> On 9/17/26 12:00, Pierrick Bouvier wrote:
>>>> On 9/17/2026 2:49 PM, Alex Bennée wrote:
>>>>> how much time? it flies past when I run a rebuild.
>>>>>
>>>>
>>>> For a no-op tcg-tests build (i.e. with tests already built):
>>>>
>>>> - With current patch:
>>>> time ninja -C tcg-tests
>>>> ...
>>>> verbose pull and build
>>>> 320 lines of output
>>>> ...
>>>> real    0m15.817s
>>>> user    0m1.342s
>>>> sys     0m0.840s
> 
>   ✗  time ninja
>   [1/114] Generating qemu-version.h with a custom command (wrapped by meson to capture output)
> 
>   ________________________________________________________
>   Executed in  515.16 millis    fish           external
>      usr time  433.82 millis  968.00 micros  432.85 millis
>      sys time   86.05 millis  253.00 micros   85.80 millis
> 
> Not sure whats going on there then. The whole tcg suite completes in
> under a minute (and would be shorter if i386-linux-user-test-i386-fprem
> and riscv64-softmmu-plugin-discons-with-interruptedmemory where in the
> thorough test suite).
>

You need to run "ninja tcg-tests" explicitly, as tests (and images) are
not built by default.

>>>
>>> The variance from the middle of the pacific ocean, and associated
>>> network latency, is between 20 and 27 seconds.
>>>
>>> Amusingly, with the network actively disconnected (airplane mode), the
>>> no-op build completes in 1 to 2 seconds.
>>>
>>
>> Funny, on my side if hangs a long time (timeout 30s), then retry 3 times
>> per image. I tried it on WSL on my windows laptop.
>>
>>>
>>> r~
> 


