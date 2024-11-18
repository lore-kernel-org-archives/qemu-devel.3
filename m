Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CFDD4920F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD0yd-00024l-9m; Mon, 18 Nov 2024 07:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD0yb-00024d-Ve
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:35:34 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD0ya-0003o4-Br
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:35:33 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53d8c08cfc4so1741853e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933330; x=1732538130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6UAFXom+XALtAMw2cnKrLBBTqhcwP/Gq9F7GQq8/Q9Q=;
 b=UXqga9otcHS294bm3Z3YtFlB7HOPy9UImFw3ogAPzIBjo7EVt2msuvpwLJallp1UbD
 B514x77pZxCfp2RrmUbUghJXh+Jk1CtQjf/MBl0ke2q0cdls7MXHO9OQBIns4xl2fMxd
 PVC0esaXJDs3H3bfunRpnxaSuEeh+Ym0kqiw9VN/TPgLMmEEDhvqXyuE6R+hZAsEbUaf
 kLHyhy+FirlV0qqzrMeLlG6uaICw0YDLtNctHxP04I2gkTWuuWmHNBCOjtpA9B5Fl+k6
 P/BVz24hSSfXC46hY6rXOWCbqN6aK3SkmS4WQPW9DhFLvfHylJJkZ7riS/c1a7eRCqF5
 o1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933330; x=1732538130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6UAFXom+XALtAMw2cnKrLBBTqhcwP/Gq9F7GQq8/Q9Q=;
 b=P4eomQupjNb13k8dV2+Ssp72ZP7aT/+KIjT3A+85LVilR2EmBxvKrsOd6DTPo4U26M
 fQos9kOen8pEtYijrKcjVCo3olmSnqu4QaZSyeJ60HFvSl7hkwnEQzbWZXp8JsAu+2BI
 YE34rZg2TikUfliDcYAACmPK0+OW9Rh4xj5r5dv9XQaUvE+DGD7RYm/imzPTUQextZTH
 mNidro4mrPc3R0rjGUGMYb5hGY1nX3CZNzLdWmnC3WKBEnMKXMLGansEeZ+EfbPtK4Fe
 +Zkjg9TcUOLUjMyOxVfvBMVXAX5Ts0asGvZpnmjLGA7onyO+PKqSsOxE4TB5auE3psMO
 o9pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlSRCiOvpdRQbY+tXyEOpMdvl8cEwRw0GlSlNpJSpWxX5GlN51jBgT3ZIDQpOWvAstSqNHjbQn5kkD@nongnu.org
X-Gm-Message-State: AOJu0YwR+gJasYCV7GzHqaRNRKzrfHO7mEZ939HIPtcWTV8kohrN2dIO
 9D9BkEPYwDdWjkwLgy9N9xHdauWXcdAW/IWT07rLaIETEEmQ86ooiPx5aC8kjcA=
X-Google-Smtp-Source: AGHT+IEc+i2zSzu1+63e8OaXE/P4xL8XIuG87Uxot6Z686iUVJo6We5yb8KUG2oG9IVPoU+ixht8XQ==
X-Received: by 2002:a05:6512:398d:b0:53d:9ff8:edcd with SMTP id
 2adb3069b0e04-53dab3b6208mr4563522e87.51.1731933330294; 
 Mon, 18 Nov 2024 04:35:30 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38236068b44sm7241934f8f.65.2024.11.18.04.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:35:29 -0800 (PST)
Message-ID: <11b419c1-8c2b-4593-b319-692f4b831c01@linaro.org>
Date: Mon, 18 Nov 2024 13:35:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vl: fix qemu_validate_options() indention
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20240411094830.1337658-1-kraxel@redhat.com>
 <20240411094830.1337658-2-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240411094830.1337658-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 11/4/24 10:48, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   system/vl.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


