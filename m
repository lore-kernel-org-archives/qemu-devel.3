Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4BDE6781F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 19:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXlu4-0000UA-Jx; Mon, 22 Dec 2025 14:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXlu3-0000TT-2Y
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:49:11 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vXlu1-0004sH-Mc
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 14:49:10 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c27d14559so3404144a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766432947; x=1767037747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4RDqC2s5Rf7CR4RPBV2y3Y9+CGFfykEDEtuoCILmXic=;
 b=sxEPE6+esXhaBRBnO7bVTqw5LKp99AVKiY44fV4/sD0Mjayx2BzuhtVjcXo+5RzpDV
 7BQpAoE23TGa7fch69KWUDn6yfsnBpvK8wYdUB4zLLc0lsQtzPIMpGUTvCvejSWN7ZuT
 xj1l8gGek0Y113de4oqFdlr2RQCUhWnvlvKbkJZww4UKXj5+GFknUikrnBppCQ/KQJBb
 ZvIh84fs0YAdOcDqjGi7PJQfuUAAIl/O99p5gK5UcDASPHQV2K+bEmgR4zOkk8e0oAh9
 elukddrTptFIAWAMQeszB3byKoH/xcMJwD255sVs/aVXNX9O6dyWYW877lSk8pwJmSYd
 gNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766432947; x=1767037747;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4RDqC2s5Rf7CR4RPBV2y3Y9+CGFfykEDEtuoCILmXic=;
 b=bglaS0JVvWM+V2jjJltD8yUJs60PNl8M2DcKe2v/lLec8hXbnVp51eVLgo8SgWIAW7
 qwng4XguiTZMOfdNJgg6wJtfVRak8gaXcYyOZSChL+RbhTba5YN7FKrP6UIxiyZyQs66
 oKyG+yYgCLQ0jjCqPN7hxtCU6fxTU8uDObrjqDGBt3bsYS32yuGRzRxAzqI7t0rUETRp
 8euG7ECwBZ4xXiWOpQLpzmvaq3uX2fFGDIrcJ6XGEniATpZ6d/kV1pWgR/HmRqiy1Qo3
 gsIG/NQlh8wTKNL5Ks5WO7razeANpDCOIszFOM4NlSfGW/lvhyx3isIC4zOIZ0tfOnsD
 jCzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWolxe2UDf0qP+8PKp8a0tic0evST+b4VJDNziuk9YWCQre9VQZJunqd6e5OI4Go+GS8aAfa2mFrhDR@nongnu.org
X-Gm-Message-State: AOJu0YxgMU1x4Rvwh2R31g3KHPK1V/als6Zobu3nKxN76aYpX8TaL5XE
 +71vIZtqPGF+jnAsc1tu0XQrTj/HT4FXhq/ldAZCE49NcREsCCjTyIYAFTAeEEUuU9U=
X-Gm-Gg: AY/fxX7WEcsrYX/UDBXiQLad7z5WH8LMkyJ9yQDTWxNp1RifrQI6fijUcUaaZ2AodK1
 XJ6AzOFulUsLW9Zo4h7aa2ptT3bjPzRvlLeDDW14LSoPeiovwLSLlT5x9+9f3M8Evv0OHvBxCaA
 2k4BIlpX+z1NDntkAbLqfGXfPT92Z3oAh2OULfQCPUZ+J5QL6q0UVa40za8x15yCfsWvhc3RJjE
 2Z6zSrOsHNNPEzMQ2cvJWtPqZgnAumUn59yhJTbEV7FaVdqS/kExPf/EeYcl9Y2UgCQ8uIz/xbe
 mA8L5im4gFw6ZRtyUd1Qxl4m1M8UVzkDFbAGxmeSel/21XO8vE9x8DA/aU9nj83JmlDAniGPAi3
 sOxoIgEx/P3P3KfprIbakvKcJnJYmvNj8Mjl8sddMXW2q+VkZMNlwwnDCw0zNNaiH5auEA5WA9b
 In3oWeDpzsJN7al1oIHQ+iASjSlZWVpoNo5QKGBRVf7dxNbiyeuqab5Fc=
X-Google-Smtp-Source: AGHT+IHeK/OpXJbJiRVUu5y0Ij/X8x4UHsFQcuPvEpk4f7EGOJCSDOZug8PzwsZnEcpcLo4tkR285w==
X-Received: by 2002:a17:90b:2246:b0:34c:2db6:57a7 with SMTP id
 98e67ed59e1d1-34e921131b8mr10360572a91.8.1766432947390; 
 Mon, 22 Dec 2025 11:49:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e921b1666sm10660841a91.7.2025.12.22.11.49.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Dec 2025 11:49:06 -0800 (PST)
Message-ID: <3b55fef2-4f8a-4b4a-877a-737ce39a86af@linaro.org>
Date: Mon, 22 Dec 2025 11:49:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/12] target/arm: defer creation of gdb register
 until machine created
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mark Burton
 <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
 <20251219190849.238323-11-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251219190849.238323-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

On 12/19/25 11:08 AM, Alex Bennée wrote:
> When running machine emulation we may create additional cp_regs for
> things like the GIC interface. To include them for gdbstub and plugins
> defer the creation until the machine is finalized.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/cpu.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


