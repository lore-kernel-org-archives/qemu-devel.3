Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1912C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgIY-000195-Uy; Thu, 30 May 2024 09:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCgIW-00018C-Cb
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:58:29 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCgIU-0007Z4-Jx
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:58:28 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-578517c7ae9so994009a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717077504; x=1717682304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1u47p8ZJCmiehY5hwIdn5YelXPJ+vbS6WtB6PEv4Gw8=;
 b=NjeLwP11w9GWmfE2m8kfduPzLuzEb2K/Rk8WrGFJ+C/NsuNdYLP0+407p9derRsfGW
 UkaTrnEg85cimuK3OMPGVhvP/egPBu4w6yhRAj1sABSncbsSyip1KIzZcEdJjIjRbois
 MXp31taC0G04Y2/WFb46oOICoEKXmZx7N29bNR9uq2U6spk2JLTt9ShplgOsGlB8JXzQ
 HdNWofFvuf1WaxUxy/G/o6sahxpwxS3BPpMNaFHctKFK7hFV3J4igmoBcchMyTY5gl7P
 svrZVn68VRH56VWQI9XbkYfRQVVtn6zVftTOeqgpR3xPLEFZ64IU+QZTjy7Z+NO7sm6b
 TeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717077504; x=1717682304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1u47p8ZJCmiehY5hwIdn5YelXPJ+vbS6WtB6PEv4Gw8=;
 b=lQE+SnjpT1sUVJoEvpWAhIgblHxddoQa1YvaaRmRTBgQ9sDAMqAC8p+r9/f5Rj9NzO
 N4zdWVZitxqKDkm+rfAz2TjwXYoUZSxYArHWLH/B2LsuBspRKBN7UbCO9G++W9V2+IWb
 xIy5Kdsl4+Ls6qUN/ChmIt9nNkpobt+io1fcpeVzpxr3HUhexjKEMcRCXbd2yFbAi206
 nR77cCMa2UPpoZh4AJxAFtl0tnR/7lztkGDFDmUJfAY6VU+8oYOG3NgJIR/urOqj2MOL
 GkGbw+HgIW9QbaGOB32xoP4idehDHDzyIv2joJW23I9wq2bJghTMcfAQk4Bj0UgNt4rr
 s9DQ==
X-Gm-Message-State: AOJu0YzkUBaxpoqqSExJtPLI/fzIwIY1kDVtPk4+/XIB/DgCyBvkw4x6
 rBuXm8UZZO2MlvhW6+8OWq/Wem0xBBnsoDiMquBSsoFYDXNbT29ggYdE+QMDK7sdgOD3WHzimFE
 M
X-Google-Smtp-Source: AGHT+IFV+lWPOxijsaCgE/tkhhu9nIkpdEJoVcgfgc9D2OVVUVAtyZ4o0L0jtQGAxNLPdiTmRNXN2w==
X-Received: by 2002:a50:99d7:0:b0:57a:259a:489a with SMTP id
 4fb4d7f45d1cf-57a259a4aa1mr781099a12.14.1717077503855; 
 Thu, 30 May 2024 06:58:23 -0700 (PDT)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579d1f94e72sm5718824a12.24.2024.05.30.06.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 06:58:23 -0700 (PDT)
Message-ID: <d2b81c56-a57c-4fbe-a65e-86e9755e7c48@linaro.org>
Date: Thu, 30 May 2024 15:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] semihosting: Restrict to TCG
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240529155548.5878-1-philmd@linaro.org>
 <20240529155548.5878-4-philmd@linaro.org>
 <CABgObfYmuvMq80Xz0ZBZQiHmKgoiSTVVqio8FmmpttT8rg64kA@mail.gmail.com>
 <7ce86375-779d-43d6-9871-7f9587c95ba6@linaro.org>
 <CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfbvjG9bBgCwM-kL+YhjhMw1qLnQdQToCEkKW+V3trskoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/5/24 09:31, Paolo Bonzini wrote:
> On Thu, May 30, 2024 at 9:22 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 30/5/24 08:02, Paolo Bonzini wrote:
>>> On Wed, May 29, 2024 at 5:56 PM Philippe Mathieu-Daudé
>>> <philmd@linaro.org> wrote:
>>>> It is pointless to build semihosting when TCG is not available.
>>>
>>> Why? I would have naively assumed that a suitable semihosting API
>>> could be implemented by KVM. The justification (and thus the commit
>>> message) needs to be different for each architecture if it's a matter
>>> of instruction set or insufficient KVM userspace API.
>>
>> I wasn't sure where semihosting could be used so asked on IRC and
>> Alex told me TCG only. Maybe the current implementation is TCG
>> only, and I can reword. It certainly need some refactor to work
>> on KVM, because currently semihosting end calling the TCG probe_access
>> API, which I'm trying to restrict to TCG in order to ease linking
>> multiple libtcg for the single binary (see
>> https://lore.kernel.org/qemu-devel/20240529155918.6221-1-philmd@linaro.org/).
> 
> Ok, that goes in the commit message though.
> 
> "Semihosting currently uses the TCG probe_access API. It is pointless
> to have it in the binary when TCG isn't".
> 
> and in the first two patches:
> 
> "Semihosting currently uses the TCG probe_access API. To prepare for
> encoding the TCG dependency in Kconfig, do not enable it unless TCG is
> available".
> 
> But then, "select FOO if TCG" mean that it can be compiled out; so
> perhaps "imply SEMIHOSTING if TCG" is better? Same for RISC-V's
> "select ARM_COMPATIBLE_SEMIHOSTING if TCG".

You are right. Thanks for reminding me Kconfig "imply" :)

Regards,

Phil.

