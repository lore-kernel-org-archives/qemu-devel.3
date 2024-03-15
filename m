Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F382C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 05:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl0b8-0007Qj-TZ; Fri, 15 Mar 2024 01:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl0aw-0007Q5-4D
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 01:59:09 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl0ar-0006MB-Bd
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 01:59:05 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5683576ea18so2347809a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710482339; x=1711087139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BZjL9ZqfvtWNM1ZCUEfyeVikeJAyJNJDFLOu/oNOvG8=;
 b=NcKI9XUdZNabAzxMkqW9kTNUCVYt8YO/TbNVEuKKjYARPyG5hQNV8OOibWcv+t48xR
 nqpq2X12K+K2jvH5dG1Ut09OkP4SZtbzNYLUk698zfZAAPjHvZks0Ct4Hi2H+YzFxMUv
 NgJtxmMpw+NKuqOXCW1fUs6mwCWvArHDsgG+9137ClVuxin56mr46biv8KdeDa3d1lhC
 UHlVwhYATvZMlKbvrN6rRZoasXYL+qlEIo5gqnmy/xyOdk8SgicqFXsfguGsFDoVqj5B
 nNnSVfNZe78/YZ6qjfIg6qn1AY2al0UD9eN1FnKDOlsskJKWx3fEMKyCzbwyztWIBRk4
 LLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710482339; x=1711087139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BZjL9ZqfvtWNM1ZCUEfyeVikeJAyJNJDFLOu/oNOvG8=;
 b=aQd46N9LRoSquSbs124fcueoJ0xKosAjQkzGLH4u8gRUIulTItQHvCyzJ/SDArdYQc
 PEOLXMYd2J8T+40zkBMvreHNKSL0NTxQs2vFvgtt8KC56wwQrbgUs1wiARo7lYu7vxT9
 o2ZYBYV89fYvPTfNua0Fs6SkSSmjvZ1yde9Kv7HvSFJs1oOaTFxJfyzOQBHjgh4MfYSw
 OPCP2DnuALllNvHYFl/FtrXWoFDaWx0SPrfFMXsJU/NmuIfmzCZlq7sf0lqzl+ckcGzt
 sqeXCBt92BbmImXRLa7wLCFuC1cSMoYY4mSb44mRN12W1r462473OAD1IWyT57KgeFIi
 QFYg==
X-Gm-Message-State: AOJu0YxGT1iKQ3S9s9KjCARqTqKRbvgovO474gm1RDSLgREhaftjdWI/
 2sidM0SYyGfNzFx37I4mQJKi/Irc73vpYE9piYNC0Y4wdis1acS2y4eTCSO7KM4=
X-Google-Smtp-Source: AGHT+IEqa3HbsuvZX2MCbZJ7TpLVjHWSD+H6E+/gCE7uvV5hluTP/QHbJRVv6jqtPcLcweNC/i+96A==
X-Received: by 2002:a05:6402:1f83:b0:566:a526:21ea with SMTP id
 c3-20020a0564021f8300b00566a52621eamr2966262edc.33.1710482338778; 
 Thu, 14 Mar 2024 22:58:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.77])
 by smtp.gmail.com with ESMTPSA id
 ev19-20020a056402541300b005689c2c6508sm1359971edb.70.2024.03.14.22.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 22:58:58 -0700 (PDT)
Message-ID: <70cae0ae-148f-4b6a-839c-423a5ad54b31@linaro.org>
Date: Fri, 15 Mar 2024 06:58:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: improve cpu compatibility check error
 message
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240314213746.27163-1-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240314213746.27163-1-cfontana@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 14/3/24 22:37, Claudio Fontana wrote:
> some users were confused by this message showing under TCG:
> 
> Selected CPU generation is too new. Maximum supported model
> in the configuration: 'xyz'

(Note for the maintainer queuing this patch, consider adding
  few extra spaces to indent the previously displayed output).

> Clarify that the maximum can depend on the accel, and add a
> hint to try a different one.
> 
> Also add a hint for features mismatch to suggest trying
> different accel, QEMU and kernel versions.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>   target/s390x/cpu_models.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


