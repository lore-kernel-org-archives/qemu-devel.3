Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462DAC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURQT-0007SC-0D; Wed, 25 Jun 2025 10:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURQN-0007OU-Di
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:48:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURQK-0005Fl-5K
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:48:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-236470b2dceso71436645ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862905; x=1751467705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=stukoyOk9iMGAM1gmkl3iwtcxBj1fLuBD4S88UGDUTM=;
 b=rn7wzDjxIgLVoHElKDWVmFAyQQX0estjFIW4dPD9xRuU9VYE4xRi6RLeqRUuFJ8/la
 W/8zKJ5YmeywmY7tzUB20hy0jlsmf+QpFTcjK/SHFLi/J82Fi1bwxkaanEARC9BN+PSl
 MGSbK4RoqaFo8nQEvv0MpCoF4jYJWtSYR8pFBCFTSLI3I5Cr2JADtRiA9IhxjbL9B6o0
 SH/NmuToq5GvKoz99TLwUE3bh3c2GwlfHqLjJL/cQ6k+XgV6SdAqVkHn0f9Y5kDn9IOs
 6wk0DAknLSEKm/7ypq6SEkCOHpF8PmTkvuhOsRXURCRWMiRfFzusOFIH9Ozjp6Cu9fa4
 AqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862905; x=1751467705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=stukoyOk9iMGAM1gmkl3iwtcxBj1fLuBD4S88UGDUTM=;
 b=f4yvB3lSvZU5NU5544FOkn5hFmP8xUKvEjDpYFycNWdLVH7lnJpDpF19OocxHbRAyE
 iwJ25jZeJemmU0FpR7UU2zVc6bHNfvn+hKPEtDjZ8soXH+DvgtB3knDi/0Rw0bc4JOrh
 gwnzqHpRvRgKYD4fEOrMCKn8YAjCd7xIKZDpBm0thkqQS6vFW/AAvuU4IdyEobYMDFns
 lViUAqAOeuUQnon2NC1wmjFtFrA+h1x/F+HFxh+GCbUXuNHbDyuGIkSygAmDEuuH2H7w
 KblnN1dlWPoow6DQoiENZ4ElSeuBLJfxg3HNt0d9hfZeY6IKYk8ApcqVN2VmJ1VAGXlf
 X0Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEj27pwQfYdJNnq1RNj1xlEyexX49S2Ayyc9uEVDdKfBTXQ0twnursCm0j+biElxx2hMRLLbHvID3U@nongnu.org
X-Gm-Message-State: AOJu0YzTcalNvxsZA9hW1IBN2uCTTg8dgW4k7Y/qR6Q03pAzB/1YXILD
 24AYYYqgYW5R51f9Ad9BrIk4SHEop0ERQHUK4EquBVcse5l9xCVd55fQsFcVkrJdf+U=
X-Gm-Gg: ASbGnctwmmCa/U2gFxul0/c/Cg15PVKlQ/rTYm9tJUOL7kW3N7iteANP9F2c+JMUo60
 Qsi0/DcI/XWAldIRL2ahG/zykZegfwL86sMTcUTteIO5wd20qYAEpIb2eRnTChNYush1BKWohTC
 qUATi1+4Lu7vvI7yXh7DIVrUB5/kYY+KINqV8yXeaCAaVo+/AWJbKzCHWyG1tMgDc0rFXkfJ/JH
 82RNf3Exoqi6vPQgsm3cij79iTKjnDe9RDyEJB18ypc/x0UpsK5c46WnURZPfV3zEv9eeizP/Iu
 poWY1zbbfeXqJErGdIfFV8lmkPrx325LIiMAWj7C6KwUmMmFVMfZ7tYBoM0SsNon0rFYf1Nglle
 PENpEwWPtkA==
X-Google-Smtp-Source: AGHT+IFrNinVAXtpNvyLS/emjX8/fPWcq6zy2oJ1oIwYPpI0Cky3s6kmdP2VmYn6bCSRVyhxqQ2VMQ==
X-Received: by 2002:a17:903:f8e:b0:234:a139:1215 with SMTP id
 d9443c01a7336-23824061bdamr67817635ad.35.1750862905511; 
 Wed, 25 Jun 2025 07:48:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8608e24sm138729005ad.127.2025.06.25.07.48.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:48:25 -0700 (PDT)
Message-ID: <22069f2d-8802-4693-bb42-8b9ffd68e033@linaro.org>
Date: Wed, 25 Jun 2025 07:48:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/27] tcg/optimize: Build and use z_bits and o_bits in
 fold_not
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


