Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E428CC54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAvA-0003Hy-EJ; Thu, 22 May 2025 14:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIAuz-0003Cd-7y
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:45:26 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIAuw-0002y5-GL
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:45:24 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-afc857702d1so7130596a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747939521; x=1748544321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DmgZMTVrjhwdSiJamkaoXvh2gYFyEAlZs0OwyQFKR40=;
 b=C2F3odv2WdYFpgCi7cbcW89NUgrX2cp9lBqGTNoNST2MKCuNOklRC3vVwM97fL3Re9
 2JBwCiRIqEb2Vw0pVqi3lRLSrLyyvUb+VmmLeRYSeT6WgU1dOwuGVKPhtDPeUZaDQh4x
 wjZ8wqq20uGCHmBtvrNW89Du2afLFxm9hHHlRhaFItMM2DisHNeoJqeQBx7JnTzQNKvt
 t0HjKvzifyi9xIMxqpEDHeIB2eMXJiCGToiZk+U7flMb5seGzvwy32eQrt8jAdwMa0/1
 PMWv2WRleQJkFjZbtj2786sPfVRI+F7BBHyBBdD16MBA6hKVazO8Xsb+JWcp+Gob8m+8
 yIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747939521; x=1748544321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DmgZMTVrjhwdSiJamkaoXvh2gYFyEAlZs0OwyQFKR40=;
 b=vawRScGqFsjhQa661j7La8ADwGMyq09wQm+afO32sLyXCkW6Qm2Hce3w+u3PNssFMw
 pBb2TULrNYlGOw95pF34ACs4vE7UBacQbN789x9H1DObGsWM28QZHok9sQYOFBD7itP1
 nr8MBLybYZQfuLbGaiu8JWEYP7rq6ZxfNPwbPN9PARuZ4XVxyATk8wUS6DmgXMqN5N2U
 YWiRyincFOP/s8aOhLvpFt/DBhReYB/yn9Hw3ZkHaCDEh6GWOU9HmZIo6+jH/3iEUOI1
 I4I7XTz7gueZS7SvoSoLwMHwHDrcNzORMinTWvhgh9iXbb5xvM0Zhx9bPR/prP03LNpE
 jWag==
X-Gm-Message-State: AOJu0YyCd2fPieE+wFpn7yDiaIKsvMdqixl2Czu7g3x5pxp2gr7GV27p
 qCn0WXGNbYBvGpWW/xjQcMwnqdodTbmkV9JcH+SCBXATChItbcjvu9AGW3ekXPEDywc=
X-Gm-Gg: ASbGncsP1u9HLLMqvmAxDEq2GiCJKaoyBNax88Y1x0SEUoHfLWRYzHrbHghqyvkL7y7
 I8CO4LBh6g4b3I400PIQTGIKk+VoPlZeDGb4vWkCRAZs3xTbSZrYxiaS4sVVEneQF5V1P+fJ0ke
 K8RTHMHXWDk7SI4SYbLbRZzDNTAgW4sGfVjxlNXTgE7rQlhglPo1l9XG7T9yBKL6fW/S417wCYB
 ck++oT9Gze94IUNFJaykI9vlrvvW/QcCHSiRsGduG+BK5iKhgvTjN6s1RkHoN2f0szHVMKLFlTm
 2AQMqqDjVQKuBtXwp7Jx3YK4AOUZrApL6CKPyy5L3lcN0Xu7EC5SM3v61W+fogKy
X-Google-Smtp-Source: AGHT+IHAp4Ety/ev0wn1yyCjhmkh1ctGDe24lpyRMduMRgojD8/IM1CSzZAKcaB37z1kPzA/AfoR2Q==
X-Received: by 2002:a05:6a20:4329:b0:215:d217:2194 with SMTP id
 adf61e73a8af0-216219ed0cemr47858025637.34.1747939520589; 
 Thu, 22 May 2025 11:45:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2c0a8fe1dfsm898633a12.26.2025.05.22.11.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 11:45:20 -0700 (PDT)
Message-ID: <238797e0-3f18-40cb-b4d1-f3940002908d@linaro.org>
Date: Thu, 22 May 2025 11:45:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] qapi: make most CPU commands unconditionally
 available
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-10-pierrick.bouvier@linaro.org>
 <875xhxjeq3.fsf@pond.sub.org>
 <8e2df5cd-0cb4-4c0c-88f1-30523c6c5315@linaro.org>
 <87r00hxm7g.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87r00hxm7g.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/21/25 10:12 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 5/18/25 11:29 PM, Markus Armbruster wrote:
>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>
>>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>>
>>>> This removes the TARGET_* conditions from all the CPU commands
>>>> that are conceptually target independent. Top level stubs are
>>>> provided to cope with targets which do not currently implement
>>>> all of the commands.
>>>>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> [...]
>>>
>>>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>>>> deleted file mode 100644
>>>> index e153291a7fc..00000000000
>>>> --- a/qapi/machine-target.json
>>>> +++ /dev/null
>>>
>>> [...]
>>>
>>>> -##
>>>> -# @query-cpu-model-comparison:
>>>> -#
>>>> -# Compares two CPU models, @modela and @modelb, returning how they
>>>> -# compare in a specific configuration.  The results indicates how
>>>> -# both models compare regarding runnability.  This result can be
>>>> -# used by tooling to make decisions if a certain CPU model will
>>>> -# run in a certain configuration or if a compatible CPU model has
>>>> -# to be created by baselining.
>>>> -#
>>>> -# Usually, a CPU model is compared against the maximum possible CPU
>>>> -# model of a certain configuration (e.g. the "host" model for KVM).
>>>> -# If that CPU model is identical or a subset, it will run in that
>>>> -# configuration.
>>>> -#
>>>> -# The result returned by this command may be affected by:
>>>> -#
>>>> -# * QEMU version: CPU models may look different depending on the QEMU
>>>> -#   version.  (Except for CPU models reported as "static" in
>>>> -#   query-cpu-definitions.)
>>>> -# * machine-type: CPU model may look different depending on the
>>>> -#   machine-type.  (Except for CPU models reported as "static" in
>>>> -#   query-cpu-definitions.)
>>>> -# * machine options (including accelerator): in some architectures,
>>>> -#   CPU models may look different depending on machine and accelerator
>>>> -#   options.  (Except for CPU models reported as "static" in
>>>> -#   query-cpu-definitions.)
>>>> -# * "-cpu" arguments and global properties: arguments to the -cpu
>>>> -#   option and global properties may affect expansion of CPU models.
>>>> -#   Using query-cpu-model-expansion while using these is not advised.
>>>> -#
>>>> -# Some architectures may not support comparing CPU models.  s390x
>>>> -# supports comparing CPU models.
>>>> -#
>>>> -# @modela: description of the first CPU model to compare, referred to
>>>> -#     as "model A" in CpuModelCompareResult
>>>> -#
>>>> -# @modelb: description of the second CPU model to compare, referred to
>>>> -#     as "model B" in CpuModelCompareResult
>>>> -#
>>>> -# Returns: a CpuModelCompareInfo describing how both CPU models
>>>> -#     compare
>>>> -#
>>>> -# Errors:
>>>> -#     - if comparing CPU models is not supported
>>>> -#     - if a model cannot be used
>>>> -#     - if a model contains an unknown cpu definition name, unknown
>>>> -#       properties or properties with wrong types.
>>>> -#
>>>> -# .. note:: This command isn't specific to s390x, but is only
>>>> -#    implemented on this architecture currently.
>>>
>>> We lose this note.  Intentional?
>>>
>>> Perhaps because we also have the "Some architectures ..." paragraph
>>> above?
>>>
>>>> -#
>>>> -# Since: 2.8
>>>> -##
>>>> -{ 'command': 'query-cpu-model-comparison',
>>>> -  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
>>>> -  'returns': 'CpuModelCompareInfo',
>>>> -  'if': 'TARGET_S390X' }
>>>> -
>>>> -##
>>>> -# @query-cpu-model-baseline:
>>>> -#
>>>> -# Baseline two CPU models, @modela and @modelb, creating a compatible
>>>> -# third model.  The created model will always be a static,
>>>> -# migration-safe CPU model (see "static" CPU model expansion for
>>>> -# details).
>>>> -#
>>>> -# This interface can be used by tooling to create a compatible CPU
>>>> -# model out two CPU models.  The created CPU model will be identical
>>>> -# to or a subset of both CPU models when comparing them.  Therefore,
>>>> -# the created CPU model is guaranteed to run where the given CPU
>>>> -# models run.
>>>> -#
>>>> -# The result returned by this command may be affected by:
>>>> -#
>>>> -# * QEMU version: CPU models may look different depending on the QEMU
>>>> -#   version.  (Except for CPU models reported as "static" in
>>>> -#   query-cpu-definitions.)
>>>> -# * machine-type: CPU model may look different depending on the
>>>> -#   machine-type.  (Except for CPU models reported as "static" in
>>>> -#   query-cpu-definitions.)
>>>> -# * machine options (including accelerator): in some architectures,
>>>> -#   CPU models may look different depending on machine and accelerator
>>>> -#   options.  (Except for CPU models reported as "static" in
>>>> -#   query-cpu-definitions.)
>>>> -# * "-cpu" arguments and global properties: arguments to the -cpu
>>>> -#   option and global properties may affect expansion of CPU models.
>>>> -#   Using query-cpu-model-expansion while using these is not advised.
>>>> -#
>>>> -# Some architectures may not support baselining CPU models.  s390x
>>>> -# supports baselining CPU models.
>>>> -#
>>>> -# @modela: description of the first CPU model to baseline
>>>> -#
>>>> -# @modelb: description of the second CPU model to baseline
>>>> -#
>>>> -# Returns: a CpuModelBaselineInfo describing the baselined CPU model
>>>> -#
>>>> -# Errors:
>>>> -#     - if baselining CPU models is not supported
>>>> -#     - if a model cannot be used
>>>> -#     - if a model contains an unknown cpu definition name, unknown
>>>> -#       properties or properties with wrong types.
>>>> -#
>>>> -# .. note:: This command isn't specific to s390x, but is only
>>>> -#    implemented on this architecture currently.
>>>
>>> We lose this note.  Intentional?
>>>
>>> Perhaps because we also have the "Some architectures ..." paragraph
>>> above?
>>>
>>>> -#
>>>> -# Since: 2.8
>>>> -##
>>>> -{ 'command': 'query-cpu-model-baseline',
>>>> -  'data': { 'modela': 'CpuModelInfo',
>>>> -            'modelb': 'CpuModelInfo' },
>>>> -  'returns': 'CpuModelBaselineInfo',
>>>> -  'if': 'TARGET_S390X' }
>>>
>>> [...]
>>>
>>
>> Yes, those notes don't have any reason to be present anymore, and the
>> new "Some architectures..." paragraph replaces them.
> 
> Okay.  A brief mention in the commit message like "Adjust the doc
> comments accordingly" might be helpful.  Up to you!
> 

I add it on my side.
In case you'd be ready to pull this series, feel free to add it directly.

Thanks,
Pierrick

