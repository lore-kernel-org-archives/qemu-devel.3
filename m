Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08640C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 19:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyF5Z-00013S-El; Fri, 28 Mar 2025 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyF5V-00012y-TH
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 15:09:54 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyF5U-0000mP-2G
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 15:09:53 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3fea0363284so1434604b6e.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743188987; x=1743793787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0pkNn25HUpzF4wfTpeaHB2/k6L4VqHJEjzBNWGIc7s=;
 b=SwOxRFVdnN8jf6ujf9OvJZfXdyVGWBkCQoi5hgnqgAJqnSkNqiXVrfsgkEJPrwapl1
 d9XKfCySvtsxxPV7A2ODA+mL+K+r0BePdvhsbkN18xMF1cZ1GDGy+Seh5cAoZk+RKpiu
 7JxMByQ+6xXcd1tiqJUSuZpTP+v5o4SLXaULOArmNtCe+z+v9Vt+QnKpGRENgZIm31GF
 Pb50vIeH+sMPR/Guh6Afhm+0+YL86ntBDKAplhgd2yN6tcViAjsHlbxF6+2J7K3buFUm
 wPev/IB+9lJFYXkCdTO8IwQc52M/+4Y2VHRGHDznSp9ylxbtSLqoAtFPHOoHwkw1MThq
 1PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743188987; x=1743793787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0pkNn25HUpzF4wfTpeaHB2/k6L4VqHJEjzBNWGIc7s=;
 b=C12cYPwBKa2AV5KE3sQdNLJNJ0xiHdIsEejRGDL4b3oOVnwRNBTiZZ/v9MDU/JZPNP
 LGx3ZxBs3tF/5h8/RXY0YceWG/6mS2/IYWlAyoKKUHtLetXkkz4G1E+aU/mNiGK7lYnT
 voFOe3iZnJC7BsKp+ofdE57J/RlGsUK0sUy9QXjXTfARyiJcsv6sy1lY370I5ozYGc/g
 J0CeW6Lv3s3BaDM2bliGKA3+kNVksgFZ8dReo72ppdO4CMDewHdQOPY5Eqyoodq6/Az4
 VKL54OSbQTC5vHVMZ0MQXTz+REddCyebcCAYTj+CkQmXmO8iLAyRHpxnMS3Yoo2b9dJf
 6HHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgD5qlSyg8N0l8+TgSgmFPdA1kvs4j9VU14WuPEJUcj2gOydI8bHDzMqXplHJyb9EU8W7LNjk+xcb1@nongnu.org
X-Gm-Message-State: AOJu0YxtkS4DCtOEdSEZyYhVR+MZLXtFoe221C1Md7xgU+UE/JBEquUi
 8vNv/q6bPthRZQ3J5SHbvovysIk/bV5W+46/QTl/jyBcTLFSlhyNKplM4QDGL+o=
X-Gm-Gg: ASbGnctwbOF8Mh10YdAySaCNzpy+FIuwaDwt1YlhrqEuTmX0wuvi5BL60LQ2wWSMCta
 ovW+ojCrBc17rlIiAHoxOr3wJ6DdN2LY58l4vrdXjOt/zTD+dsU2Q90vuYqg6iOAsdjTDuhrV1S
 mBGZiyBhwWnsv/D43P7LiLtNSoub9t8OuXMOSU8bdt0/KNey2W7hAj7zuTfWxHodRzGu5yAqgxd
 wQyoVYOOCyWPv/IMXI1iJSwAZJcJra1/YuUfHLuwFe/iKUKLsKF2cv7po1gO/EI9csSOVzSrweq
 UxCce4AR9Gji7WIjKQa5K0PbUcynsD2nGKmOxZ0kSrgP9d3UdY1ciuY5yhSxCzLwiqYRSSsVWMi
 xZZ+E7x41eBRQBOQB7hNa2g==
X-Google-Smtp-Source: AGHT+IEJuBqpfVJSqKSWvwJkyRmirpRVWtacAIUF3uTfxr02T/HFWO6KK5fCfteLQ/0TeGILfM5g7Q==
X-Received: by 2002:a05:6808:19a9:b0:3fe:af0a:a264 with SMTP id
 5614622812f47-3ff05c8ea80mr2791593b6e.7.1743188987165; 
 Fri, 28 Mar 2025 12:09:47 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05185823sm441662b6e.17.2025.03.28.12.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 12:09:46 -0700 (PDT)
Message-ID: <de560d94-d7d8-4e49-b4c4-68341c2b0fbd@linaro.org>
Date: Fri, 28 Mar 2025 14:09:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/test_aarch64_rme_virt: fix sporadic
 failure
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 qemu-arm@nongnu.org, thuth@redhat.com
References: <20250328183816.2687925-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250328183816.2687925-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 3/28/25 13:38, Pierrick Bouvier wrote:
> This test was randomly failing on our CI, and on dev machines,
> especially with QEMU debug builds.
> 
>  From the information collected, it's related to an implementation choice
> in edk2 QEMU virt support. The workaround is to disable KASLR, to avoid
> accessing protected memory.
> Note: this is *not* needed for the similar test_aarch64_rme_sbsaref.
> 
> More information is available on the associated GitLab issue.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2823
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/functional/test_aarch64_rme_virt.py | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/test_aarch64_rme_virt.py
> index f4ad4d33d58..a1abf584f0e 100755
> --- a/tests/functional/test_aarch64_rme_virt.py
> +++ b/tests/functional/test_aarch64_rme_virt.py
> @@ -87,7 +87,9 @@ def test_aarch64_rme_virt(self):
>           self.vm.add_args('-fsdev', f'local,security_model=none,path={rme_stack},id=shr0')
>           self.vm.add_args('-device', 'virtio-net-pci,netdev=net0')
>           self.vm.add_args('-netdev', 'user,id=net0')
> -        self.vm.add_args('-append', 'root=/dev/vda')
> +        # We need to add nokaslr to avoid triggering this sporadic bug:
> +        # https://gitlab.com/qemu-project/qemu/-/issues/2823
> +        self.vm.add_args('-append', 'root=/dev/vda nokaslr')
>   
>           self.vm.launch()
>           # Wait for host VM boot to complete.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

