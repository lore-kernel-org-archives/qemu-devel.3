Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56460E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhxx-0006AC-G7; Thu, 12 Dec 2024 07:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLhxv-00069u-VU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:06:47 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLhxu-0005Uw-A9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:06:47 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so441827f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 04:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734005205; x=1734610005; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kyGKAxVmwE8MYMk1FCcZs21m1m6GVnwgUCjvJ7zTJCg=;
 b=bKOGJCNscz/9nGkIEv12QVRlalmT2O/3ASarRqEDG0SlIgnzBXx+J3O4zeptrezSHa
 HkvBlBZKZKZ7gjGyAdlv5obLmtDT3+0MAyrfrtuDrvV2MwtKw3DC+E8P3xVkNfYE7HCs
 XJK+C2VFWzGUBIq8F9tvciNuWP9xMj5aHqAcJG56BPUy7UDOEIWkP5EWYyDPXv6GysNc
 cVqRe2Ht4ouBVHeT2AgLKLk6+9yNcCr8ks/c1IcE77wRECt3Yyu90JCbyUkx7juSbLur
 yWTuJkO/EyQt91jjh8BSibxbBPHvdc5qZ5H2zOrxngCtgB8VEbODH2NUPhiGWoGuQw7l
 /Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734005205; x=1734610005;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kyGKAxVmwE8MYMk1FCcZs21m1m6GVnwgUCjvJ7zTJCg=;
 b=wyPeqYp/Po+kKJmBrfY2er/Vy4dnBp+7ct6saa/kHte+S/sKjIbx7XNZJvc9oX9OUV
 nrb+GZjuF95KeADGtnZh7nwsqXcM0KLp2dCptLjhyB2Nn3KzlDMDBIvJmMs9TfYOx/jS
 Ha8sPRvH5SCRiTHdL17bsIllXn5oOoKHzFDiA/MnZRP9QVHfQW/8xGw9CuAmT4BmbXBV
 JxFAYUD46T5AQxuzbD4IsthL9JvmBLdVIfytecXfkX1y6UOYZpvPfeUkbod2d/uvUCHt
 rYuJEd9/kh91YXTEZZGg/PBMj8wsbpMcfSrVIGMGsL9Y26IJ5p05EAefV62zT7qJl8Nw
 sEzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1mg/+d1BNq/5nHu82bVkNG1IRJubqrGDwQKR86H3jdFZbGjFBLWS+TwLX8DcojrGQvziDcZFroo6X@nongnu.org
X-Gm-Message-State: AOJu0YymRvnDbrhalGbmmp64K7s7eDADJyp/dSZCTtDk7Jeo3stvp+AT
 7H4dsdyDfoeiJecN69mt3gpigpUoywFUQ3K+sVcNchKtfjBakeKvtaClM3bSNvg=
X-Gm-Gg: ASbGncvYPI6kd8a01vOkycbpq3Z0ldMofZd22Nrou3QdJK0OVcY7iYG6JVArd9uzcJq
 2UkvN9E7cvoWTBuKCSsz+3JKZF2SshhL17eD1y/7AXlZJJaqtMIN2Yhif2GQaRAiyXC4J1cr87p
 PiCSDjN6HkvEbFjvU9AfQ/7gBZX7K4u3lBjrFPUiyb3+bSYar+hhLFl6GqaiPDkVQtPhdJKXliw
 FjUiD1BhKyy72etHum0Xfk8SAqNscBGl2TdLanVgfftSZBrw85XKM00ihLZo9+W81wckrdmQ7vN
 QA5HiXhppdJwIdtUG7NZIaJgZECc7w==
X-Google-Smtp-Source: AGHT+IHNz6ggqMuNTUszUqoIhfbN0otVneLud4wtviCwESc9FJBEqLISoCYGxCb96V2+KoBJmAxMNg==
X-Received: by 2002:a5d:64ad:0:b0:386:4a0d:bb23 with SMTP id
 ffacd0b85a97d-387876850a3mr2787417f8f.11.1734005204847; 
 Thu, 12 Dec 2024 04:06:44 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387825296desm3816268f8f.111.2024.12.12.04.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 04:06:44 -0800 (PST)
Message-ID: <2eadcb6c-10c0-452e-b174-1fe6298fcc68@linaro.org>
Date: Thu, 12 Dec 2024 13:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] qapi: rename 'special_features' to 'features'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster
 <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241212110616.3147676-1-berrange@redhat.com>
 <20241212110616.3147676-4-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212110616.3147676-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 12/12/24 12:06, Daniel P. Berrangé wrote:
> This updates the QAPI code generation to refer to 'features' instead
> of 'special_features', in preparation for generalizing their exposure.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   scripts/qapi/commands.py |  4 ++--
>   scripts/qapi/gen.py      |  8 ++++----
>   scripts/qapi/types.py    | 10 +++++-----
>   scripts/qapi/visit.py    | 14 +++++++-------
>   4 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


