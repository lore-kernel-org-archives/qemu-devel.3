Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2737C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHsIS-0000nS-Gp; Wed, 21 May 2025 18:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHsIQ-0000nJ-Nm
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:52:22 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHsIO-0008TO-He
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:52:22 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-86135af1045so875382739f.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867938; x=1748472738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1B++cQmxos+dfYIXtLQo397NHynOEGyB/jL4Q5kAEAw=;
 b=tnulpKi+zSHFGIPfIcBTplJAuMcYoWg+kUZtVLDPv804TNkaw1nS1VGpROYnhSmA8a
 qNAew2KEDHCneLuEi99fb8PKQTxuNwrkuttn1GtYyyCHfQr5nOSbJWTEl+0oO7rau5+7
 DzRWgQaa1i7+uDSuyBLNfrXOaeR07I4fmWRfJI062SRbjhYjxEnFvbDS4txnOUxKZzE3
 rO6tfXh4eLdE833msRsu9Ng4IpnI/IGZONPN37fXtm1aUEqBEuV3dhDOEAx6BayEt2NH
 poa6HeI6WHgpsbajcxzfZKRZsiwoNPB3NiiQwiGaeFDx46GZSECXjchl9YQUz6SUUsxk
 CtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867938; x=1748472738;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1B++cQmxos+dfYIXtLQo397NHynOEGyB/jL4Q5kAEAw=;
 b=CiQXXDgZozN55wHUzBAC+iryJ7dq318w1ZNvnxQFgscU8qB9Jgk0l/Fd39WgJ19dTx
 9naqf/rWsPcEAbb5zZ3cfb3HUU3ZWDFXA13zkm0VTAlqGOpcxNfyq1PLfCfgEgUbQ+qJ
 65Fd4pJS4vxTcdFcp4ALYhdl6MqwZz9TBE0FW71pQ5l7NSWWLk0A3Ig1fnKA/g72a0Bb
 dMH3a8yR5ZI+vOBj6fnC+zhc1YU7nB470RrkbAH3MIS5/cL9TnKLB4GyX4WbR1MZYi9t
 Uf81lO7p9d+qxp8JdRH+LGNsJmyALiwCqZlqDHES9z+3m3yfeomfratanR6wk8o+HTZI
 JYTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAIQ386L46vwJyL7n9ptesUP/SHNNHe4ZdbWdPhb2hmqTqU3uNImMv+od/YpvDNDs6SLdVcseMY+9I@nongnu.org
X-Gm-Message-State: AOJu0YzWqO0gNzHVzRHFWXLyhTsAsQ8hipSJ6mRGvdLKd+wjYVgxumnk
 Ad7JOtWRlqTy5oLrAAhbZpIksj1EYA081jNwymbdf4AQXLhjcjkCVVRM5/jdCBHAxWOMu3QrgnC
 tzsCb
X-Gm-Gg: ASbGnctMizsAe0ej11nEaGGxZpiYb+r6ueQ8UQ9VHT4FMBWBa26P2NjaLVccfD2qktd
 6vWK83cH99x3HAfvExodBcLG/Abzhw/SJrX8qK7vCI0aHaqsBDr+hjCFh+hp8570y7aMEIefRoF
 bTkEXIdAm4Iqvagw7Lv5Ar9aAhtrfx+8eyCnZt5k8On4N1G0Ci0b08OkekC9+6UebhT/fSVLxV1
 Pn7YOn/9rJ0tcqmZa1MDM1lK692/3nLV2EUDfPOD+GJU3aGlYcn31qyjXsOqQfkizbGgysIh0l3
 3O1EwkDPqefB/iVHyV+BasvWEzUrch6aS4rOvQBitV/kViPoUnR7Gz4u/JD/JYIrQWiW/R1JCww
 =
X-Google-Smtp-Source: AGHT+IEZhLbBf/vkETtE0NeILXd2JKyxwuEeaZH21yUWS4Nt3LHzLYLj7p6xwm3IXyC5cbICp3dM2Q==
X-Received: by 2002:a05:6a20:7353:b0:215:ead1:b867 with SMTP id
 adf61e73a8af0-216218c3e42mr36291139637.14.1747867928111; 
 Wed, 21 May 2025 15:52:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb0a032esm9958160a12.65.2025.05.21.15.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 15:52:07 -0700 (PDT)
Message-ID: <af63dd4c-d205-4adb-84c1-8ab69a39e163@linaro.org>
Date: Wed, 21 May 2025 15:52:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] Expose gdb_write_register function to consumers of
 gdbstub
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-2-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20250521094333.4075796-2-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-io1-xd35.google.com
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

On 5/21/25 2:43 AM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   gdbstub/gdbstub.c      |  2 +-
>   include/exec/gdbstub.h | 14 ++++++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


