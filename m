Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9A4C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 19:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHp7z-0003lN-SZ; Wed, 21 May 2025 15:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHp7x-0003kx-HC
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:29:21 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHp7p-0002oy-8e
 for qemu-devel@nongnu.org; Wed, 21 May 2025 15:29:19 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so4971606a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747855747; x=1748460547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TnD0/WlVr7vjeaAiRr041svGe4C3YveaHI4Ld3ZWln0=;
 b=oyxzmw8pa7I+0oQECTKbtm3IX8GxVuZKxLM1g13O4pSKSPgeP1qrIxeJeCO4qF9Eod
 VH/FZuCzbYvazGPmj/s30R0Gphix/jIXR+YNUVnNKYEijxekD0Tpnw7jedDnok5skDel
 /ExY8k0rpB6BJVHktjnGp75RqChd/5+0lhBtfyDvi5ZQuPYbqAzvcPdiGAW3V24kkP6L
 +6cRDKLekW5DTIiP7PH4LOyTOX+5+erxU1sQjuaW2CKcZV2K/VCyExkjQeN6qnjSeEwi
 lbc2onjXZ2vWehY13zwJUD65szE+pKJWK7kkFVkrt0sd5+jBvauPzOQDM7kMdS6LTgG2
 PCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747855747; x=1748460547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TnD0/WlVr7vjeaAiRr041svGe4C3YveaHI4Ld3ZWln0=;
 b=IQ53OUBVdM56Pxsq0Zkax0HYQ09fEmWUvx5vsIQz5erD2oqMRRbvylbeNzaIYG7fqc
 tY8V8zrBOPKiCa/zyb/N1anips+pPLtAC83PM92vRagJ9PMTI/HIwpUqps4HfQNihQJw
 ooumse2+vXyXwldCsUNGehQo6+4snTxmmElhCh03DNP2//pwlDlqzuzgOqlEew62mGS0
 T06zMYcK5YfhClWSuSZ/4MC+dMRv1oFFJeRiVPL6LZemA3O2ncomjmQuWLQo6WvKdK7n
 1YrJ1WBcd7nTGkl6SAVFWX8rxaHwet2fwSYFFCiFek9a7IS9kJp+UnXUqhurJFGZ7GnY
 8TEw==
X-Gm-Message-State: AOJu0YyDrAsKMoBrT/4VykXeRydXZ/SQkMzk06JRZfJVaoB3iXd0OzvC
 wS4Lu5CasV+J9KU29FH4v/0TQvoZk5fcDr+ld8/8E2HIROng5/2PtS01zKEEtTQcSVpomY8U98D
 OuuOE
X-Gm-Gg: ASbGncs5xDQB1a4kYGGNFd/STBcxjhJ6laRHV0h3tx/NwOB8D4vnR2ztNZna4u092nK
 VOWj2zOA5mpOyvJKzJpytvRdQD+WXTdFKBMY5vO/HlkIt20jPTpG92/576OPyJ+GpKWg04snAC0
 Y+vjjhF6OVD9L8v0b6dtNeStayW6AjZP8dKhvNP67StRU+cmhZeOnqDn+jOLfZF+Oy/9UagcFx7
 bDJD+4LWqGpAZPf87q01kc1UE3YtaJAX4DvtxArc4zAaXg94199oNj1H7V1mdsBJdK8MIVXvA/A
 QSiZesB0krEW+pQVoJdhXqtQvYbqCDsDP6luuQqjjrqTE8tFjIAbJCniuGsde2Jv
X-Google-Smtp-Source: AGHT+IHrhiqBcQhAUwZIta07+B9wJi7W4YlkhdqXRf1u7iUcMtYQD1y5cudOJDG5l6aYojoAG16vNg==
X-Received: by 2002:a17:903:2cd:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-231d459a546mr313919695ad.38.1747855746801; 
 Wed, 21 May 2025 12:29:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4aee45dsm96737555ad.83.2025.05.21.12.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 12:29:06 -0700 (PDT)
Message-ID: <8e2df5cd-0cb4-4c0c-88f1-30523c6c5315@linaro.org>
Date: Wed, 21 May 2025 12:29:05 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <875xhxjeq3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 5/18/25 11:29 PM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> This removes the TARGET_* conditions from all the CPU commands
>> that are conceptually target independent. Top level stubs are
>> provided to cope with targets which do not currently implement
>> all of the commands.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> [...]
> 
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> deleted file mode 100644
>> index e153291a7fc..00000000000
>> --- a/qapi/machine-target.json
>> +++ /dev/null
> 
> [...]
> 
>> -##
>> -# @query-cpu-model-comparison:
>> -#
>> -# Compares two CPU models, @modela and @modelb, returning how they
>> -# compare in a specific configuration.  The results indicates how
>> -# both models compare regarding runnability.  This result can be
>> -# used by tooling to make decisions if a certain CPU model will
>> -# run in a certain configuration or if a compatible CPU model has
>> -# to be created by baselining.
>> -#
>> -# Usually, a CPU model is compared against the maximum possible CPU
>> -# model of a certain configuration (e.g. the "host" model for KVM).
>> -# If that CPU model is identical or a subset, it will run in that
>> -# configuration.
>> -#
>> -# The result returned by this command may be affected by:
>> -#
>> -# * QEMU version: CPU models may look different depending on the QEMU
>> -#   version.  (Except for CPU models reported as "static" in
>> -#   query-cpu-definitions.)
>> -# * machine-type: CPU model may look different depending on the
>> -#   machine-type.  (Except for CPU models reported as "static" in
>> -#   query-cpu-definitions.)
>> -# * machine options (including accelerator): in some architectures,
>> -#   CPU models may look different depending on machine and accelerator
>> -#   options.  (Except for CPU models reported as "static" in
>> -#   query-cpu-definitions.)
>> -# * "-cpu" arguments and global properties: arguments to the -cpu
>> -#   option and global properties may affect expansion of CPU models.
>> -#   Using query-cpu-model-expansion while using these is not advised.
>> -#
>> -# Some architectures may not support comparing CPU models.  s390x
>> -# supports comparing CPU models.
>> -#
>> -# @modela: description of the first CPU model to compare, referred to
>> -#     as "model A" in CpuModelCompareResult
>> -#
>> -# @modelb: description of the second CPU model to compare, referred to
>> -#     as "model B" in CpuModelCompareResult
>> -#
>> -# Returns: a CpuModelCompareInfo describing how both CPU models
>> -#     compare
>> -#
>> -# Errors:
>> -#     - if comparing CPU models is not supported
>> -#     - if a model cannot be used
>> -#     - if a model contains an unknown cpu definition name, unknown
>> -#       properties or properties with wrong types.
>> -#
>> -# .. note:: This command isn't specific to s390x, but is only
>> -#    implemented on this architecture currently.
> 
> We lose this note.  Intentional?
> 
> Perhaps because we also have the "Some architectures ..." paragraph
> above?
> 
>> -#
>> -# Since: 2.8
>> -##
>> -{ 'command': 'query-cpu-model-comparison',
>> -  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
>> -  'returns': 'CpuModelCompareInfo',
>> -  'if': 'TARGET_S390X' }
>> -
>> -##
>> -# @query-cpu-model-baseline:
>> -#
>> -# Baseline two CPU models, @modela and @modelb, creating a compatible
>> -# third model.  The created model will always be a static,
>> -# migration-safe CPU model (see "static" CPU model expansion for
>> -# details).
>> -#
>> -# This interface can be used by tooling to create a compatible CPU
>> -# model out two CPU models.  The created CPU model will be identical
>> -# to or a subset of both CPU models when comparing them.  Therefore,
>> -# the created CPU model is guaranteed to run where the given CPU
>> -# models run.
>> -#
>> -# The result returned by this command may be affected by:
>> -#
>> -# * QEMU version: CPU models may look different depending on the QEMU
>> -#   version.  (Except for CPU models reported as "static" in
>> -#   query-cpu-definitions.)
>> -# * machine-type: CPU model may look different depending on the
>> -#   machine-type.  (Except for CPU models reported as "static" in
>> -#   query-cpu-definitions.)
>> -# * machine options (including accelerator): in some architectures,
>> -#   CPU models may look different depending on machine and accelerator
>> -#   options.  (Except for CPU models reported as "static" in
>> -#   query-cpu-definitions.)
>> -# * "-cpu" arguments and global properties: arguments to the -cpu
>> -#   option and global properties may affect expansion of CPU models.
>> -#   Using query-cpu-model-expansion while using these is not advised.
>> -#
>> -# Some architectures may not support baselining CPU models.  s390x
>> -# supports baselining CPU models.
>> -#
>> -# @modela: description of the first CPU model to baseline
>> -#
>> -# @modelb: description of the second CPU model to baseline
>> -#
>> -# Returns: a CpuModelBaselineInfo describing the baselined CPU model
>> -#
>> -# Errors:
>> -#     - if baselining CPU models is not supported
>> -#     - if a model cannot be used
>> -#     - if a model contains an unknown cpu definition name, unknown
>> -#       properties or properties with wrong types.
>> -#
>> -# .. note:: This command isn't specific to s390x, but is only
>> -#    implemented on this architecture currently.
> 
> We lose this note.  Intentional?
> 
> Perhaps because we also have the "Some architectures ..." paragraph
> above?
> 
>> -#
>> -# Since: 2.8
>> -##
>> -{ 'command': 'query-cpu-model-baseline',
>> -  'data': { 'modela': 'CpuModelInfo',
>> -            'modelb': 'CpuModelInfo' },
>> -  'returns': 'CpuModelBaselineInfo',
>> -  'if': 'TARGET_S390X' }
> 
> [...]
> 

Yes, those notes don't have any reason to be present anymore, and the 
new "Some architectures..." paragraph replaces them.

