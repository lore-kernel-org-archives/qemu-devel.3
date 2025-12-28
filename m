Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F78D3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 10:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZnoG-0004Uj-Sb; Sun, 28 Dec 2025 05:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZnoE-0004Tu-Jw
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:15:34 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZnoC-0002Tm-24
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:15:34 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so62711385e9.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 02:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766916923; x=1767521723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uPw19BXrN17Du/CZfQSlpDZKGRKppz7MHBt6a0FNOUY=;
 b=t+fhGmCqGpyxmVBSsrizIpTkGBfwVYx75dcZ11tscFkTFVMso2Fsq+ayoh+HXKoUSX
 YhaljRJHmXCjSAYK7qo+9Xvw+gC1fgdTR6NZBr0Ve2/6mbm07d9jhgKEqoBq/09XXpVL
 rbmjdFbn0dEu8fXjLK112eXT3bR2SOmIawHpKVOQ2Yl/R3otEzR5IVHrysjt8K89mbnm
 V+D6xtlkCrf9xrpu/1q9kofYlCBy/I2UO/lxpcgJtvE1aKmGeFsOuGoeS7xC4dSfTHpX
 A/Xw8xQcQELx13ldIJNiQSFBqkEU74PxO+oaxQzENNx6iPAdwr/0syYwoDSlIP+luoBF
 K8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766916923; x=1767521723;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPw19BXrN17Du/CZfQSlpDZKGRKppz7MHBt6a0FNOUY=;
 b=Pqn1KQ0nTMhALqwsmoQZVeXWWzwSvcExLXRcotsRgqutZWotuxIfB6VV055GQ2UhBC
 7xOs+vKGPyZN0IbEXc9SmwRgYGehJwe8UYuecBi5FwHUxPvZS0hwjvkQ+rfMWRr8pXZQ
 ScnLO4o+1uWlBpGBcrjFyYLF8Fk0HIdT0MOCIfQWAGtMTJi+u1eM5oFu/j9EXg72J4xO
 JVMzF2xnsYeFej7USZeLIGVu/aSxIO29xUwZPidT/XGyAjM+W15MQYqgS3vs7NSPGMgW
 /QQ4I5WBOIrgOpxV4pTM2C1RxmdMy/uy76eD4r+/pTXhmNTBDzudpMB5v6snRXnm2yO7
 HnyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi1Qz9ir4WvUtkS7ydbJRV438i2ydDERzZqBUTZo+u5alFrnzsoSglb8DUvFPedM5ZE+ucL4uyO75B@nongnu.org
X-Gm-Message-State: AOJu0YwsdLDM8U/881/p9Pr0Ym5gGrAmKZ5Ai9bn0Y6nKUP6BRHBmZaR
 YGtOBwGUtcnQebdpgFCInqN95k1kTlNw2ReWDPyexpgm+4pLBgZUHd7hM8F985pEbbo=
X-Gm-Gg: AY/fxX6JkxYH574r8aTMqdLIb6zYY+V4x7Dqrbj+azaaH0h3aNhHF5TZqIGmWwn1euL
 ysE8M+VKX5+EVysjmwT8HYXimew7Ab8fnbwQ/fsbV7yf1PJ4h0hut4YIOj+8V7JH46pVoUtM+2s
 rummKIgJFJBdXgQTFGA1CFi5Jk1dlnIHWVlqpq6NBv0ONU0qX7fqZX59/m59lorz4tgYrWA6D99
 IKhMZej6wdnwKwo8xLK0DpemiKOpXQ2mgWGIbSeqAlIrIxc8mA1tFO/FdZS9x9zFfQszmfJSsdb
 DlPVaJHWrbZtg8Tcfo66FsEG+YG9polWwADfnZnhM1NvxUF6fuhtlx0EmJLPmbGIqS5EOBopXRe
 cEmHlteClqLho97wyDvnzGIyqfUzkY8DSdFG8mcMajmCtaYWuZ92jsNtsenEzwtxCYNpvRa3j2v
 FAth1y9PJyOvOtuKAgIVsnyscIeRfDWpLZAZdM1GRreaPiHS4KebbiI+cV1z3X9ICF5UU3Vubc
X-Google-Smtp-Source: AGHT+IEMF+2BYn986cAsQAaCTrK/ayj0UVoCZktxvqo6oPsK35BxazTaFxOc3PSySW+h+ilB2Be+Pw==
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-47d1959f714mr360394165e9.31.1766916923567; 
 Sun, 28 Dec 2025 02:15:23 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4327791d2f3sm23085127f8f.11.2025.12.28.02.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 02:15:23 -0800 (PST)
Message-ID: <1f86c213-1bbc-49fe-bdd4-f91e1c1e8b84@linaro.org>
Date: Sun, 28 Dec 2025 11:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 105/153] tests/meson: do not reuse migration_files variable
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227094759.35658-31-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251227094759.35658-31-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 27/12/25 10:47, Paolo Bonzini wrote:
> The variable is defined in migration/meson.build, reusing it is confusing.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/qtest/meson.build | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


