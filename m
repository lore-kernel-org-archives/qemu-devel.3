Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EB2E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 21:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS0c6-0001Pv-0K; Sun, 29 Dec 2024 16:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tS0c4-0001PV-8I
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 16:14:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tS0c2-0003xt-Pf
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 16:14:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43635796b48so52478685e9.0
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2024 13:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735506852; x=1736111652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jVgwEu6HLtBWljS4ls/InwOq+d1T+uEgP7+qDjFqs1I=;
 b=LnzizZQYHP41wufYIB2aW0gMCFh7NWw2xr4jVu8sCnC2ZtUb9ccpT5GYXYop9zDBnw
 WKxkaBz41F3vYNb5JtAopvCZx/v8sHVLMPHQdIWqf167isPPKny2Up+fmOqCHEy+6DJZ
 k+fXX2/4yxc6qGK+El2JuVzO9i5Df/72IsHbbUmxHYosn7mwH9PVYYG5hPn5cCJiafE3
 2S7o9Jz1LhSs3Na85Jl9vsprFKYv3g195dA6CbkHaF6PJJ1F6VZFVNxsspj7igfTLW9s
 PgCf/jQ4pE41mq/5+KUYUeBjTuP0hwKEWKkBwXJqyfeCTIWwSD3zl0EYlVAfeIvepV+g
 KY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735506852; x=1736111652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jVgwEu6HLtBWljS4ls/InwOq+d1T+uEgP7+qDjFqs1I=;
 b=N15wYAZmRrQ6PVvRas14hUXQdizNT7N4HCmQgThvo94iLNP7FRzZ8IHaknh2C5WxaI
 PEW8JalAbnWT9Hg0gvcPx856OmbzRUty8JknbfqJ/tJ1zQ6/Y4BCH19rsvixSUplO1bB
 cbswcLktqAF+hVtrJ9iDHR3zsmpHypsiqB8Hi7p7iFCZSQWckP3nO38M9SKek6dJfcCm
 /ZbBVayCk684VG2CnPGtPDlXksuym5MQCT7U8FukcnzgWoPX6tH6lSbhB+DuEDgEWX8e
 uMzgiXQqnb72aEBqTUPsMOFt1Eqxj+HyIxNdQx0hPT0DQlDl2G7txnCiPDAMTQi/b5fD
 LVKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZoDGRoZaGZetfAObHcgezolr2P0BPMzDu9pKenPYuigH3SUPQ91AGEhFsagyQRUJnodvJqqGWlGOw@nongnu.org
X-Gm-Message-State: AOJu0Yz/yOl596e5/hdWAAzaz+JMeqLgjpaNdmKXDKCt6fbI3GmGFERl
 VqgKeX1lSVzYRiHStmQMe70rDtSaN4U/MWKSg6AqhghO4wODX3ivSAlQqA+0u5A=
X-Gm-Gg: ASbGncvizjLRB7oJzEZkI8asQ3ET2gYDVOeJ/vcQDzz5KeeLL+8FLGbip/dB8q5jASq
 ivjRIaEoHCMcagj9Gqwj7XAnI+09opvzkZDBzy6+m/mESL7dV00jYQn4PLgm0U6M9roItwqvnz1
 iVrqaOqtxsDvrsnWyeFH2s9YXLS5w2NxqdCfdkSgZ0F2NKmoDzmpKSsnm/CSHmtqUlfem3UM6yP
 whdJ1qu7jLWL8aeyetyJuZn+SA8aJyTQF6nAMaXn6cTbd7Ox8yrMbjH3S41KIvHYHON0MDTsFCG
 ye667kurjemIHxoyoMqPNjav
X-Google-Smtp-Source: AGHT+IEUGZsjG3aKXqSOcP9DAr56GsE0QWseYOXONYW7LeOtMGn7M6bPpuaAbpbO0vk6qDPxgGVGPg==
X-Received: by 2002:a05:600c:3b8b:b0:434:f2af:6e74 with SMTP id
 5b1f17b1804b1-4368d6e8d7bmr137038115e9.15.1735506852173; 
 Sun, 29 Dec 2024 13:14:12 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acb85sm27991891f8f.103.2024.12.29.13.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2024 13:14:10 -0800 (PST)
Message-ID: <ad3c526d-3544-4374-826c-e33eba59a571@linaro.org>
Date: Sun, 29 Dec 2024 22:14:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "vvfat: fix ubsan issue in create_long_filename"
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
References: <20241229211246.3202574-1-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241229211246.3202574-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/12/24 22:12, Michael Tokarev wrote:
> This reverts commit 0cb3ff7c22671aa1e1e227318799ccf6762c3bea.
> 
> The original code was right in that long name in LFN directory
> entry uses other parts of the entry for the name too, not just
> the original "name" field.  So it is wrong to limit the offset
> to be within the name field.  Some other mechanism is needed
> to fix the ubsan report and whole messy usage of bytes past the
> given field.
> 

Reported-by: Volker Rümelin <vr_qemu@t-online.de>

> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   block/vvfat.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index f2eafaa923..8ffe8b3b9b 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -426,10 +426,6 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
>           else if(offset<22) offset=14+offset-10;
>           else offset=28+offset-22;
>           entry=array_get(&(s->directory),s->directory.next-1-(i/26));
> -        /* ensure we don't write anything past entry->name */
> -        if (offset >= sizeof(entry->name)) {
> -            continue;
> -        }
>           if (i >= 2 * length + 2) {
>               entry->name[offset] = 0xff;
>           } else if (i % 2 == 0) {


