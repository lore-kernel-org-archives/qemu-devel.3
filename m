Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FC5E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt3f5-0006JO-Dp; Thu, 19 Feb 2026 08:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vt3ew-00065j-Ou
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:01:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vt3ej-0005po-I0
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:01:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483a233819aso4123275e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 05:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771506078; x=1772110878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3uD2NPCSyNL69bl5PSjtdV8d7QWdzWlAsp+kcF85/g=;
 b=WDOEwr8c5c1YnVkgQ0tfjSTmZO+Scu31qfjRGH4I0seweM7EhU+IyphWEHjlgFZIMb
 H54hTXXdpbbxizW9mdLQI0mROkmjKoPS4LkyKMHqm9D7GN5x+EfyFt9lDHUUXOnZISks
 ogYRTGLqliYbKgJo9/BthiOgVjVFk3XMzwfIwd9gvvrGuyf5lyrq8tYf9ogPrGhz7Ncf
 SibnM2lgeRfMP5nkjZKbZHiHPMbo2loAAuWWO5p4oQ1R9nt/tRTUGYCTnosuO7U7bLJ1
 yTDfoZW1v6Q0RUO/5erqbATOssg/m3mmDIAkNNx5K5/+gNXjqd0TP/WwZvlbxKB16V+m
 49FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506078; x=1772110878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3uD2NPCSyNL69bl5PSjtdV8d7QWdzWlAsp+kcF85/g=;
 b=pwvBIRgaWpqZUT4gYWRZCNUotiqh4CFRJIBpuWor2nVY9OhtiUqQJFuM1ZYnBweUlI
 1w14m+4hRCPIsFouDNnGV7jMS08FJHL3Egg+2/u5z/tfbsmFJrC3FByD3yUFmScR5alF
 pXhU1DICrq9Smi8g+geub1aB/9LD4ZxkWuKau4AEEUpYkW37ew3ijD4p+IHhhVN5kPjg
 8EVCMBTXnTGzFQXmL9T5RdeK9BlZ56d3MK0pRm/1J5H6hV/QLXQhq9OLToAVS58wI69a
 jnTV8uqQiHF2Cv3phV5VU2SI4sYMFSaLftRrCnj3fZmVVXeDVFZXa9PLncO4sBcMA+7j
 RAOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvrC5ZeTwsFdDNaPUwaEYINXgrJpU62IT78fyuJfbheu5hb2x8WPv0clNxTQYlSMBOphtUCyOkWs+J@nongnu.org
X-Gm-Message-State: AOJu0YyoZBClQH3whTuoz1R7y2fSV07Sbg98/cJeXGP2wJA/f+XnWC2L
 M4Zex7gAPIMcpxONlth5ENVWMTk+M7yBvKoJcjmLFMhJ8bk3QukYUp4YfHhGnbtUPeg=
X-Gm-Gg: AZuq6aLwFVgtN7OZU2goEV+vBMUdrYwluP0by3wEFY0clLyrR0ejB1M8801XaFHQdR8
 7R58ekbAPjVOAG+O1dIaundRJtEn7Afuhos9wnxh2tmyfs4uYzsq9EPsqxbWAo32g2Pajg7NSnR
 c/H8z25onXR4bxDMQKa7a7mz7exzXJsMi+5SBxP59g1ppSEUnMdLNW7Hk17X5QgPqrkkQ5svbut
 aDB4viAsO6oeoiZXwircmsEMKScC96Nkv8M54LSdAeqdB1fXCmxbV9airIrEFCSeLXHL1HVmOqf
 dMxJ4pB/92hr/eJlY5PegOTQXeGKRM6YvyQujpfv1dPjZiFdq2AJKQOLQYYIl3yGVApcs98xI9Y
 bVSKEuSwkwQD8+TEWMxOt2i4I7u1XUjWAnKz+cDpRk6C2GlJzXw85P038SVa3r3Y+NYQ8ikw4vQ
 kyCM+Y+c8hvIX7//DkHCAatsqW0/V91VYKVrsrClg4gVLaDyuoYR74he1Px1XluTRNMW8=
X-Received: by 2002:a05:600c:8219:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-48398b5d5bbmr88626175e9.22.1771506077522; 
 Thu, 19 Feb 2026 05:01:17 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:afeb:9934:f5df:3905?
 ([2a10:d582:31e:0:afeb:9934:f5df:3905])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-437969fd36dsm51734521f8f.0.2026.02.19.05.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 05:01:16 -0800 (PST)
Message-ID: <4b9aa2cf-140f-4b3e-ae7c-224530f0e93e@linaro.org>
Date: Thu, 19 Feb 2026 13:01:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Reapply "rcu: Unify force quiescent state"
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/17/26 06:34, Akihiko Odaki wrote:
> I could not reproduce the alpha issue when I tried a bit while ago, but
> trying on a more conventional setup (x86 without ASan where I usually
> use Apple M2 with ASan) did a trick. So here is a fix for alpha and a
> patch to reapply commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85. I
> confirmed no failure occurs in 100 trials with the alpha fix.

Very glad to finally have a fix for this. Hopefully a suitable location 
for the cpu_reset can be found. I just wanted to add that I've also run 
the func-alpha-replay test 250 times with no failures whereas before I 
was getting timeouts roughly 10% of the time.

Jim


