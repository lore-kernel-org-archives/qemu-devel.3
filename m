Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA0CCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE5M-0006HH-1f; Wed, 29 Oct 2025 17:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE5I-0006DW-P8
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:52:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE58-0007pY-Op
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:52:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4298a028de6so1023124f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774705; x=1762379505; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nIc13SZQBDmIQ8+zujnMI9gijPzWOXDFfbaZsmNomsg=;
 b=eCs5yxFQzOHJPDaQ5UdUKu74mbRBtLSG4nQ0TbPewkvC+eHG1+eCt2BizZej1S0EgC
 Odi8700CHpRR3SO2SauoXr79I4O3HJyB/sm8GJRJaa7szmtc7GR9tHqy59LIFaAUt2sE
 A+mhwwGDVxbCUbAu9stt3JC5Hp/CH/5t+41jEFP5JnC8MhlOr+AdskIP+uamV36A4YCk
 aK24WO4KAsZvvCwJvZzacxb+A2sJwfTS+XaXUhdKIa8f1vbBX/wwnGarZdTaC05D9qXm
 yzBF8K2Scl3jGr4nqwhH1fGUzUQ81WPGgQuT3yr6OZI3+KV9ca4zLb3mpj777SzKOX9m
 SwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774705; x=1762379505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nIc13SZQBDmIQ8+zujnMI9gijPzWOXDFfbaZsmNomsg=;
 b=lcfbHlkziZasH4QTloAATogwU77PAVETiksZnV9sFlbPP/R+hzIFmdkjETJUyvom/Z
 sDu8JGyjBuqYXaitvKAtKL/1tQHCN2p5yECDABAf1SLcgVoRvoxAL93PelnmzvPcWNSa
 yPMZmD9IwNoT2pmkNKVOxocOt6k6BZEU+Euj6ZiuLe+yPdrW4kDn7Tmkx00NSW3M7b+9
 T7Nnd9ZeCxt3w1s/zd5Ptbm+iKLBS5oQAPiSAOJh4CefGFVDtB97mh3q9HOovxLpabLE
 KN/PnuJOQPez3OISezYsXy2H25t6UA9ktwKu9CW2h/yvKjN0s6fvzShP8Ro66+nZrzBJ
 7cGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNoOmM17PzIgmcuIohPwZn8+Ph+pnlCuFmym/Tl5thUtiINlHAap/czs+U9msp86ChG1A1F8w3KC4x@nongnu.org
X-Gm-Message-State: AOJu0YzS8pljy/UIa3xvambhEhY/ouTfINFd9Apx8w/35P10/XaLAprs
 2BBHmSJE55zPdY0ai2XsJlyuqxhnE/ItCFrXHdIm+gn5mFfrFjHXTaHxyHcy4BvaJG0=
X-Gm-Gg: ASbGncuCeHrC4jqbDstOe3/UbCmYkJG9srsuYmrqneoSxQbo8bmMahmxm99mu5g4poN
 oyzmr8LjO3sYnZqaDx2jnO+L/eWajwPF/gvCXtyXAuB2hDvo+4enmA88SIGxqbhnbi7w4e/yGbn
 gs7je3yHE4/rWSZyCzd3zxnxulwl0RJYreAXya9U/1Uxc5ZS+FbETjNH/pUS+Wq5wQqCjAD1rOS
 Vq3k3n2XcHWXi3KPS7Hk1aIeCTDnpFK/Qk9ZxyLNYga/Kv+xFlQKjH/NR6BlO2d1i9N3tGLI88Z
 IYwLhwWSdCcXddGDqbqJtLOofYmNV6aQUvZ+LwoU7Tyxi86nBAymvpAemzXUoIMpdUx6DBig+nJ
 wNcDf6vSUCrZvsAQe4PPW8S8QkIDFGhheVySUktis94sLei6AUo5skNEweNDgzEDAYP9Ys/cjpT
 A5p0HsDw/S2VMzwta1pprDF1OrwRJhRo+pTSccuasK01c=
X-Google-Smtp-Source: AGHT+IFKBwXOGSNuwF+MfTP6NWYsZQYq5U8SbSN7wDe5uZELAIktJv3AlfH72FX3m8MQrfDTTA+K7A==
X-Received: by 2002:a5d:5d13:0:b0:410:f600:c35e with SMTP id
 ffacd0b85a97d-429b4c38275mr899593f8f.8.1761774705245; 
 Wed, 29 Oct 2025 14:51:45 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db839sm29580402f8f.34.2025.10.29.14.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:51:44 -0700 (PDT)
Message-ID: <2f7a3fa1-bd36-4717-9949-2dbcd5842d18@linaro.org>
Date: Wed, 29 Oct 2025 22:51:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/35] audio/replay: fix type punning
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
 <20251027151045.2863176-25-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h           | 6 ++++--
>   audio/mixeng.h          | 1 -
>   include/system/replay.h | 3 ++-
>   audio/mixeng.c          | 6 ++----
>   replay/replay-audio.c   | 2 +-
>   replay/stubs-system.c   | 2 +-
>   6 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


