Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6729BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OT2-00088w-SV; Wed, 24 Sep 2025 08:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1OSp-00086c-Aq
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:19:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1OSm-0007va-6n
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:19:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so3407068f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758716348; x=1759321148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xcKQmiNzA+d1TU6yTKF54QkpJV19S4hDwbzqBOcmF+c=;
 b=uQsaSsVrOpZXe2ltCp/Ut9BfZ66Owz0FN/8QGPLbpsBswcMTjBoaXh8NMXiYvwbLRt
 k598ccms2GspGoYcwZ5ZTnjI4oGZS23IPXh/FquNgZysxrjv5+80cLWtG+giTBDcuAHp
 pPXoHzFBeke7Xyku0m6cvS6RKx1DRvp3yNYyskzycL59ygcFTHDi2JiL44lkqO9UfIjg
 uftGIG+dbUoPnoZtdXcrbCxvT/y7/grk5HYbjzE3D/zAEPFAgyavcb2+rTw2eFg9aeQg
 0FLuUyX+/Zn6DI7481RrA9DKDwEhAXttfSQhKoH4Lodj9YWNJBMmdeG45i01sJFZmf7n
 9ECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758716348; x=1759321148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xcKQmiNzA+d1TU6yTKF54QkpJV19S4hDwbzqBOcmF+c=;
 b=kuDu0NmTsi9bvDGQFD9yzHigOnTrU3lESw1M8uq2lr38sAln03ESbp7UHt7xLkE89n
 bVd+VUVuAAtgdYN75OCiX56TD+Hf3l/j0NQPKpy0eYv7BCpoZ+DqGUKfuTGspye1Yh1N
 nzlxssXDEdJsokNwiKaCoolIdDCWBPdV99Aqt5pxNgv+avmgIoRxBdAtwySpAgvhTnSw
 938Xe0lDCXwAPByMU2ciA5I2ugsgQyPPzjHUCObPuPcdcCGZ33SXBzxXn0LZcwP24p2M
 eDEgJhlTOGaofXWhYIzNy14oa9/yyXWPQwPG1Uzdgns9GYBVA4yhAaJbm5PXwj/XuUO7
 NtBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT23q0q9AJ5wR61+H3VfdBJPuHkdCxfK/fwyxIhHNEjU4l5ujpQ5XzVepi+OtHkSbn0Jiuewizcq3D@nongnu.org
X-Gm-Message-State: AOJu0Yzx7L94yy3AExWx/GJ8Zl/YulQ1wpwDwjHYoIvvTY757VuYISbq
 kqm+k9n8BuQFfeYO+lR3J/n/hb1uzU7Z7hEO7cVQvjJVv/UaXQ5gpt2oekxIRDaGV40=
X-Gm-Gg: ASbGncv2z9ovJkbjkUHmDsHIS/O82jyAzxFS0ADmzK3J/E1+qgpzymzpJvEfvebvBqM
 E0UNjpdjqdPjQ3Gk7KBve+AfCzy2XTRYx7ONu/TDVHnK65C34RjL6ofOvFm29nAI77KTCGd6OOq
 OgVJD2v13xMCDmMjfSdZrr040PZrOc96nIdQYHekJguiffWMKG2FoWs0ZVAQmIKbQDN0LJAJdJM
 F3oUFScKQlTsX2apEnVNVGn+XFjzzfe04zbebA7f6aE8UN98KAYuWl62AqT4w7M6HPiEnlHDvSz
 q/vJRuN5ZBZ3UME+sDd8w0aTmYAUxlmC0lQVyMyo9jHhHcSSKAD5EE5Ma8cuoGo3x8nsvjnVloX
 iHStV4+AsEUDLGgZ8aEof+lmjMbABuV4EFadY7D/R/SGpN1fjpxVw1sBZMo6RrCuZ3g==
X-Google-Smtp-Source: AGHT+IEmMaQ+Xc/Ag4A7vHfIlWgjKBpf62/0ITUpXr1iuYNqpBDqSGeZUtBCCdIqEFXMDB6Tj3dpgw==
X-Received: by 2002:a5d:5886:0:b0:403:8cc:db6b with SMTP id
 ffacd0b85a97d-405caa502fdmr4936255f8f.35.1758716348047; 
 Wed, 24 Sep 2025 05:19:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f88de2d09fsm16561628f8f.36.2025.09.24.05.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 05:19:07 -0700 (PDT)
Message-ID: <c2fe2847-d8ba-4339-97a9-c3951e3b5d18@linaro.org>
Date: Wed, 24 Sep 2025 14:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/27] tests/lcitool: update to debian13
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-17-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250924120426.2158655-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 24/9/25 14:04, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .../dockerfiles/debian-amd64-cross.docker     |  9 +++++----
>   .../dockerfiles/debian-arm64-cross.docker     |  9 +++++----
>   .../dockerfiles/debian-armhf-cross.docker     | 12 +++++------
>   .../dockerfiles/debian-i686-cross.docker      | 11 +++++-----
>   .../dockerfiles/debian-ppc64el-cross.docker   |  9 +++++----
>   .../dockerfiles/debian-s390x-cross.docker     |  9 +++++----
>   tests/docker/dockerfiles/debian.docker        |  9 +++++----
>   tests/lcitool/refresh                         | 20 ++++++++++---------
>   8 files changed, 46 insertions(+), 42 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


