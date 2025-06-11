Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB43C71141
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 19:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQft-0007Jr-W6; Wed, 11 Jun 2025 14:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPQfh-0007Ig-V9
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:59:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPQfd-0005y1-Ow
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:59:36 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2363497cc4dso1996885ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749668371; x=1750273171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LXkUHG1ZtTWZJwyqWKLCBAmvTYsIdGWVTYQDG88w7u4=;
 b=WgI4i4zwNAHQtTLnbvxKmHmjL5WN3uHIPM3LOfaNpMPVYXlG864YshzRRSVEZkPdM2
 h0pN54gGonTulfSp0QACbvMJFxOO8Nh09WpeTLYllWCnKPqBKi/aGDpV5sVht/6tdElG
 kQKFtl3tdU7DSF7eE7bdqyMKyMdTunkK6b1kiTI4XG6HVZe21umisaUu65UJnRGoQLPL
 A0FJNgshtN6dLoBxo4AcNCt9ltAp2FXCndxfN7qL5L5tamzSvhDaIoV5D7pPpAYcXvB3
 3UklEyB2HrJl1xWIqyhQcPU9ejWGdIQkCgM+JjbLnnFhR2IK3rewO2m8K3vGgID7HF1h
 vIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749668371; x=1750273171;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LXkUHG1ZtTWZJwyqWKLCBAmvTYsIdGWVTYQDG88w7u4=;
 b=SowzMWEKiOebdsOvY0mCHZb3ijMpyhvHym2XAMvEQBvrGaAUPIKlh+tpJGN0UZ+gE5
 YsOrc8ZhmVVh/4C8ARh+PYqH/3GslB9Ma3fXpTtkhlENtRftLrFCsgNOImq/758J0q63
 Beu8DvVnm3WUcxQdqOT5+PtUcZPAKZ6oHXC7FTrSmx2BawPF1MuikYNM3qAt8RG8WDez
 T+l4O/vAxTJ0MZoyrcTMjlMP2aYQc+9G8xCyrmIJTaLY32Z9YKB2qoy/eQ1AJ4w7uN07
 2CAodUHTd7/YLrM4H7KPuM8rhfLzG/K6B7GQmKchAbX1rNYg9QUp4lBL0CTUu88/TOu9
 CPfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiJQbV/7eqyXjOnduIT1RvoRs+v4A+lz+cXJHH6EA8ikflEvc88mJLDCdYCWO7TSq2r0BJ2x07Q4ho@nongnu.org
X-Gm-Message-State: AOJu0Yw2vMCaQOQUpItSD4OcxfzU0OWzlQolq6m+f0Fi2l594N+od88i
 WZkgSONI9LdzvpZ9idZA/nYT83z/g3twoTWpkUkccI8+pfXwY6lEP10JotSnJa7D1Eg=
X-Gm-Gg: ASbGncvi2BUoW3k6p2oLxII9S5QM1wLIjmz1J6LzJ6zGUauWc6xz9jFB1FXV+WN25q/
 j+0hUhdpS9eX/4xmQdtUbSDit2Pzsef+fgG87F8+8U1VXPhOP1T7uIeSQIDtlTvoLpMbUc6Hvz2
 c9+EJsh+q7s4JL3gT5gQTjqBSqdDKmshyO5DGmPqZewZ+wkY664LQ0cmtl90t7UddPVyBc5FfAO
 lWy1tGw8C8hGLsWTggm7QbEWzouxXPwzR5jjBa+HHBqGoLqfcdnTAfpGPqyJm0rMOtVK4iI0LGQ
 FvHnrhon9lhxlo48zjJZqLG2x9X7mwLMmF7ACzNO5Gr84eYx4fVoe7EOc9hCclMMuhh7QqKaFEM
 =
X-Google-Smtp-Source: AGHT+IE8Ozc8xF3bhxztOGg8cPyFnfxwsECZc/JfRWpzg+OKJXvU8gHRU5ST5Mbex+BjB5Ze1cznfA==
X-Received: by 2002:a17:903:230d:b0:235:eb8d:801b with SMTP id
 d9443c01a7336-23641b19915mr67470425ad.32.1749668371432; 
 Wed, 11 Jun 2025 11:59:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236032fc9ebsm91270385ad.106.2025.06.11.11.59.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 11:59:31 -0700 (PDT)
Message-ID: <8eb388d5-15fd-4614-a41b-17caf53cd9be@linaro.org>
Date: Wed, 11 Jun 2025 11:59:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] plugins: Update plugin version and add notes
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
 <20250609193841.348076-9-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250609193841.348076-9-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/9/25 12:38 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch updates the plugin version to gate new APIs and adds notes
> describing what has been added.
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


