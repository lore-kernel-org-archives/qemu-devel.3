Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F14CC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpaS-00005q-CG; Fri, 17 Jan 2025 11:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpaQ-00005f-VO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:52:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpaP-0001lv-4O
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:52:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so22383455e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132763; x=1737737563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fve05+1tgrWphwW07Q/9nUax0o1BoXa3OlYeOeoTkpE=;
 b=qhXMSLExsD3+TI9xmYruWsm0OS6ljEfPsytYxbYsB+pDfyO0rIMlohZFn90uA9Pw8r
 S3jay85tOnX/1/ZlPpsrJFZh9eGf1mI6XOqLeayG1I1nln/Mmsd1bBeQikqSomNcHJoH
 CS4qLX4QgfiGSmnjzltitoSwNCulplvQTGVTZx9Ez7DqRbFnUwrmPEczsfuSALI6KWQE
 XrwAYzYujyJjbeXfJmoUmrWGvfyblA2kPy1aruMZAzYMboU3bNSwtdEGi79ISRLSJCaw
 jHRMbaSk8aQZNDaJ+tvj/s4MTqcBtJVRDqbxCRZhD5AvgU7peFDhj7uMSaursrruFRMG
 +bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132763; x=1737737563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fve05+1tgrWphwW07Q/9nUax0o1BoXa3OlYeOeoTkpE=;
 b=julYZtUeqzqzBdU2f0Efghfiv95mCo6CDipGK3B/cWeIMfBEomuVFfzyi1Y0+9VQ0r
 9RRv9R1VOPtcypAtf0oLvl18romxPIDF3209dAk/LbAV9bULxp3t2ChSccIYQ6obepvM
 v6q0qmb50tg9q1TJrzFyPtpdr/j3aJef6XTQWs906zXNX/8muAfb3bkTlYINsbmeCHrv
 WzmUX7KDIbdgnhwlT8grlPc5LXaiNUaILgopnHInzLjisF++3JOiaaa/CMXAvtlANcB1
 4QMSCaiuioGCY8oGj4UlghcsfH2I9pvlN5qE0f9lwCSGNBHpIxLDn39c9N26vjLBX+gx
 yt9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4n5/7ZuN7YWA+idPLlQIcwjwmN8m/EBNBPritn+03MVJZw4dZZLJct4j+8jisIq0L67cUssMrLbzY@nongnu.org
X-Gm-Message-State: AOJu0YwRQeDogbDhr4FJ5H02GeIICq7mkl4E0wIgBHznOc6obMR/XdWC
 XdnPiLVR/BJWMffMPR+ZqFk8AFxva0ibw2hpqZhWeF0mXt58safJMKXhMVprxyY=
X-Gm-Gg: ASbGncttAsQFfPlOuT0xuxIKOVP8RoBcMOlRUlKDSOjsT9BCpXo0rQ3AeT54S/M5NtR
 1q7dydZPJClfJO/nQCK0WGabGTy7wfxijsDaIVc4BlTKXSvVDqLFcXCO8cIvDJ3+jMVI6p/55P0
 7Pmok44dypYgTbOYmyyzZcIP54sFpPxi7OaDMD0PjLlEFC7KkyO1mFdkkghQAK4owVkAX9iKP2A
 8ePZKIrSpKiyYsWgGwUeOwzRrfVADEaBjvi8lNfJ8MuoMkC8Gttzi1DH0I3VZLsN5H3/6fhxw05
 dNLQKT1AD5qJTS7KWfDBYwlU
X-Google-Smtp-Source: AGHT+IE754bTzTMzgsRHiwKCFS+Bj+Rsd8w0KRoVGWhgsjIEl2jYEu/tt4MyoWUnR6tRMCLUpzHRwQ==
X-Received: by 2002:a05:6000:1ace:b0:386:1cd3:8a07 with SMTP id
 ffacd0b85a97d-38bf5678239mr3202971f8f.7.1737132763468; 
 Fri, 17 Jan 2025 08:52:43 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3288f79sm2908134f8f.100.2025.01.17.08.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 08:52:42 -0800 (PST)
Message-ID: <b4d5ddf1-8825-45c8-8cab-5928df60a232@linaro.org>
Date: Fri, 17 Jan 2025 17:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/i386/pc_piix: Remove pc-i440fx-2.4 up to
 pc-i440fx-2.12
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: devel@lists.libvirt.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250117102738.59714-1-thuth@redhat.com>
 <20250117102738.59714-3-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117102738.59714-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 17/1/25 11:27, Thomas Huth wrote:
> These machines have explicitly been marked as deprecated in
> QEMU 9.1, so it should be fine to remove these antique versioned
> machine types two releases later in 10.0.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst       |  7 ---
>   docs/about/removed-features.rst |  4 +-
>   docs/interop/firmware.json      |  2 +-
>   hw/i386/pc_piix.c               | 95 ---------------------------------
>   qemu-options.hx                 | 10 ++--
>   5 files changed, 8 insertions(+), 110 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


