Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DBACCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 11:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4gU-00058O-Os; Wed, 29 Oct 2025 07:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE4gH-000580-NU
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:49:36 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE4g4-0002Vy-NY
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 07:49:29 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-430a5fe0c5cso64517325ab.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761738556; x=1762343356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00t4+L6aRJs0vb2QCh0oKLCvh6LWzAQZxDTg52LqwSs=;
 b=yZESJYIiwgZW48dQFYsL1oLAgRDj3l6BoWqUJgmqm9sZB3qte5YWSZiEODokvK28lI
 +m0gU2dWqGH8YCA2ZGy1s1h+sNHb7pvavMvzvxc2cdXRXkBozn78kn2P96+RcqB5vbLW
 AftEjDgKRro7uKlIG2uA0PX4O2B5Q2niZY50A1AwKxlnhzInqOJS4TCNmGsF5ZoxYet4
 itQF0pGe4QSZyYhXgtPP4m8zucyMyymZhTwmZh1lTbL875nMuyOXa+QB1/0dojteQIsv
 lzH26FmW92f0HBZ3NodfM93qiMCF4v8i6qMInDwUa/Cy+GrWCYW5gg47YIxdoqHzujfx
 GfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761738556; x=1762343356;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00t4+L6aRJs0vb2QCh0oKLCvh6LWzAQZxDTg52LqwSs=;
 b=SfM62hMnAUxDRZalTeZy+QG2q4KCBWF+3xf5ofmylbO+SdruDYwbF08QHmH0GuS7ki
 BdDALI8FlRIJrh9aS0O8Ai/49yos8dht8XM4w5Hgzbxlm4yvccdP0FkAgumjFutn0iLt
 O2+jXEXwE2Edgtd1jJipMvTlPVvYxiem4Pi4AHUccKZzknRhzisp2EphywZLLFJPgi4G
 GUwpsgjJ1apzOEeY7cdI5ujCREhG4XK4XhLWOFKuLKeAPnkxWD+yJejMtmeMFvRpfxMJ
 av/7AT4dq9nPOpaZNrNCVjfpm9v9lrNM6gNcXImK+yCMZ5AxhxkX7hW+6X67cL8ylqvF
 dtTw==
X-Gm-Message-State: AOJu0YysRYc01d5rSyZRz9mQUh6fy2S3Gq2ptDQel3pRC9tv0vF8Yj2v
 +RL3j4kTQctTKTFfXmzNeuW/Xun0OsJl55NQNjBtMUDTaZcQJ5uJKoLhKmfLMRrHtk1mGRV/JwB
 fUwDQvNQ=
X-Gm-Gg: ASbGncvfF18jdo8GYu99J5koEsO3bcUkIK5+cHhAUiOWSQnCsPlA9+sNKWHZhgmtoWR
 5H7bbTWzK1oJ2GRZ+WTSHYaW8GY79CTN8hriiFek/Azr2jc+ZcS/jnZWp7ECUev2TvnT0v0jGLc
 9rfaaPNNL9BlZyu4EaI+yCy9C+mgOTmVIQ2ZGQMSZ2fpfdbKBWleKrR2pgs/dv2lqPFIbuzxv4v
 Z4n3p2rNw3oK4u5aXyb/FPH5PjT9WbrUAbDHo9fOpRW+s/TLNKgN6vhApilJSxDcGGlvRNlxQ2S
 WiPJTI8c/0rEpNzkKpiSiPT+yKLTFIrcOVjQe3ilmPa7qp8q0i9SXFK6jTxK53Mo6FBR/Km0e1v
 rW/IWwcMlC+G4Yz65W3y1G4MclhhphAi9sf972oW4Q+8qnmjMdSA2NkUK/Vgq/u+KZq8YXHpzEV
 qQDQHo9J8+q+scwmFEbUZ1HBo68ms9i4xS7F9LDOy2d2SJdVkpf6h14ujuV2oWxq/B+Q==
X-Google-Smtp-Source: AGHT+IFzxuC/6hQ0+brvVx/RZyrr0Ztni2a42B/J7XP9HExalk0EE2GoNHil4D3SFpDFXLQQcmIAlg==
X-Received: by 2002:a05:6e02:370a:b0:430:b290:b6c5 with SMTP id
 e9e14a558f8ab-432f9066e16mr30716995ab.30.1761738556526; 
 Wed, 29 Oct 2025 04:49:16 -0700 (PDT)
Received: from [10.240.88.227] ([172.56.16.75])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5aea73dc121sm5477697173.10.2025.10.29.04.49.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 04:49:16 -0700 (PDT)
Message-ID: <ca671928-564c-4633-9d63-c3103fc1a8b9@linaro.org>
Date: Wed, 29 Oct 2025 12:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/18] Miscellaneous changes for 2025-10-28
To: qemu-devel@nongnu.org
References: <20251029092724.2325904-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251029092724.2325904-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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

On 10/29/25 10:27, Paolo Bonzini wrote:
> The following changes since commit 36076d24f04ea9dc3357c0fbe7bb14917375819c:
> 
>    Merge tag 'next-pr-pull-request' ofhttps://gitlab.com/berrange/qemu into staging (2025-10-25 10:42:55 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to d4fbf6ff8d12cd11d53f7baa408f50fbb0441d87:
> 
>    rust: migration: allow passing ParentField<> to vmstate_of! (2025-10-28 14:50:44 +0100)
> 
> ----------------------------------------------------------------
> * char: rename CharBackend->CharFrontend
> * esp: fix esp_cdb_ready() FIFO wraparound limit calculation
> * isapc: warn rather than reject modern x86 CPU models
> * mshv: fix Coverity issues
> * qdev: Change PropertyInfo method print() to return malloc'ed string
> * qobject: make refcount atomic
> * rcu: make synchronize_rcu() more efficient
> * rust: cleanup glib_sys bindings
> * rust: Convert bit value to u8 within #[property]
> * rust: only leave leaf crates as workspace members
> * scripts: clean up meson-buildoptions.py
> * scsi: make refcount atomic
> * target/i386: Init SMM cpu address space for hotplugged CPUs
> 
> ----------------------------------------------------------------
> v1->v2: no change other than removing spurious subproject update


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

