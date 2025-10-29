Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2331ECCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6Uh-0005gl-St; Wed, 29 Oct 2025 09:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6UH-0005Vl-Is
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:45:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6U7-0002qm-DA
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:45:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4710022571cso75580645e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745501; x=1762350301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j0UZJUesIkyNDkiDrZBjXLzYyoQGF+99QP8wq3RHeAU=;
 b=alI4bpXn+R6nRG4OKWtKLZDNxBz/3vAhzqkmS8jZp2MILCGM1bnCwlo2yGUTGMvllz
 3RyRdMmkwc3H+WgnjV47QC/x3A2w8UEdU4eRtXpDApx2F5V34y66R+jWJhZqvayz3+ZT
 8WXlYO5TDic0TFptdPHsdVTwhraCYZak+mT+x8n6fBOFR0qFkvARd/9FX4gIS2oI2O9D
 5+h4RXxfWPFiw3FR1YCbBN3TwUElQd1/gnSq5cjl+ByAWJqcsCHPsbTMxB9evINt13Tm
 aC6mn6Tn93qyETVF+yFyttyTEs3z2g0Vd/1JTrWUqcQbb4vp+3ns5FYhvKXgdkrJZUhY
 Ra/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745501; x=1762350301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0UZJUesIkyNDkiDrZBjXLzYyoQGF+99QP8wq3RHeAU=;
 b=qmTYbO3kTcoXWY98WIFF4Jwt0JaQvAGuRWRKshs1MSqBEd+Kg7qclUFZAK+RuSeTX8
 e8u68agMji6DgJRXZagR6royQY7puqGl2ecTjdd6KXWG/7Ylcvzxv9ZjqVHzOsetN++K
 VgGXYs9QoU4xC/J+E9gV4Znx82E8VUw682uUEH1SRj6ZCEholWdtKh6kjFcw6hB/7HNt
 7viSt3aggqnhFfEnALx/a+XcQpsFnqB+MiYcNBEXsoe6hlEN3cUbYWO1cjkP3L6iSi8X
 rmeHnVA0LBjLHQSCqbxs4Wt8oIBoN3r2tnwNwau4gU1zSg3SPLivL+XZAJ/kkgQKNtcb
 Mqrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU63Adba1dbgfS3oue2v2BQRh4po3c82uerOJ5aj/OI0cIwmFh1Xx+aLxghvKRqyW0wr25H6OVzSjqW@nongnu.org
X-Gm-Message-State: AOJu0Yw8fXeufV9BdCvaUvWchtYYYf4v1UXvAaNxWbDBaUMDCoiQFKmW
 a3NxDq1mN0taA1GC7dKuiy9xtecrT6Ym5XqhTJt5J4rsJpprHCr5oDxgFFDAo2Q+redJSUDksOg
 ZQTCnl1Q=
X-Gm-Gg: ASbGncuYeX+DzJFynTI/12BYrIzn0gSh8Xap6EGxPu+2Ufp3+l9Li0unW+3guvaDwtp
 JY1y2NMhg1g5/Rys28bVho4SBzc/rIWwISivTK0pPhOlW4y4r0BXJlfzMApslB9JZxpTETjv8ot
 w0rDInRfruZR933I1ZTfmWHw6fPUy1NH1N3//r7fcriWxTuLpAAPiiXYN2dHzSTBQwkbkiQxkyl
 HsqBojbfvE2iruMtrIvcUJbm+RcAWOJRs4gB5zuGIMJu8p9SlDNvPmKRN5fM5GYme3SIX1SxR2y
 /FSsxsdIkQ5N3lV1SGqEBdWiNPJtN2jp7H1wBgAZI6+4JFZD5f48e7u+Q/LMzvfDZTENqw2wWzV
 4RADu5y+NQQyrRHEh70jDzKkzveY4cD1oblQ8MSpbv5cHnY/12lzyQ6hbI/sE9S6OsRlGy9Qw3t
 2sRrJql0aA+UQ1SeFiF18fAcBB15qjIvLtPCP72c5qNO0=
X-Google-Smtp-Source: AGHT+IGMrVUnRB444z2jvh++Bb1WPiBixGvNlnbra0gJqmVOpMbfvl6x51/BZwzJiKRdm9dHhFppHg==
X-Received: by 2002:a05:600c:8487:b0:471:152a:e566 with SMTP id
 5b1f17b1804b1-4771e183fecmr28390215e9.13.1761745501385; 
 Wed, 29 Oct 2025 06:45:01 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3aae1fsm48245995e9.12.2025.10.29.06.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:45:00 -0700 (PDT)
Message-ID: <8f74cec4-d7fb-4ce7-a673-571d6d562e63@linaro.org>
Date: Wed, 29 Oct 2025 14:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/35] audio: move period tick initialization
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-17-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-17-marcandre.lureau@redhat.com>
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Part of QOM-ification.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


