Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563D5C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOteN-0004aN-Pa; Tue, 10 Jun 2025 03:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOteE-0004Zp-E8
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:43:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOteC-0004ZO-Q6
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:43:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a51d552de4so2741716f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749541431; x=1750146231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xG4h4ZhIA7FtaRzpje2P6+0d1qrwmc4KBfQJzhpXwqs=;
 b=sMsXDs170OxHQkJGh4xMQ3+1DoyYt2SZUow5aw3zEwxduG8EwNg74QmznKtcPHsk1a
 4DH/FefdTUdpSgHVbEGuqBQVmqP4rqNQ4tLAQpH+IKnYJ41iis6N7jqPcQlcvDRUjDQj
 A3sGU3PQLTHIkrVjVZDn4IIVD2t83GayB8mYQzxotLbowMwUcXYaXQJ2iS3Tpavs3Rtt
 RdobTH6qxnuM3NPiLhNxCTvdTuY1sUzxNMjC5az9gF6BK1qQ2T42ICSGa4ExyTugI4r5
 ElyX4mTpvDOSsOfO/xyq2RYIE976I98Eo6QKCm/pWrhRjcs1oe58MucYOom3JI3tMit7
 P2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541431; x=1750146231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xG4h4ZhIA7FtaRzpje2P6+0d1qrwmc4KBfQJzhpXwqs=;
 b=TDzvh9QiAJFSSmNmrMVD1ua6pP00okPSpOiaIMSzRM+XMaVNAE4xNwX/IIBWEAZlhk
 aqkeCTwqRUqA45phqBTOMWKRdqO05M5KrHEzaP2P7fzmbAjYevP6G6QLb1ntWgAAy7H/
 HwO/GiCf91Vtt1tlTHfZvRR28Gd0UnmuGk5LPMrSjVqOG2GKwGHbkNYhl/UPJitC2EAy
 2iB5fiTVUooyc5EKdbig77x4X5P5CAE35lPxdcYfrohflwMUQHUZf5iVH7RfP+898wbr
 nOCXacyNA03hYi2uhj3Q1tctquj2OYkC3bQKj6wh9i8MojUfQFrscU4SWF0F33aG/x+f
 2ruA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiPMc3RHv6G61k34zb0egJsR8K77yYna/mArSIUVCrhEmHjyWiFsdkq6kEYcjT/Oib1pauC1HqTDhG@nongnu.org
X-Gm-Message-State: AOJu0Yzxfyo50D2/byFVA2qIsep70jgT+UZKfR9RJ19ah8aGQ5gCJ8Pf
 Q2f73bU6XPz9K5zgm5skl7qCPRD24qcKSEbReoCz8nzuqMYLWodg4J6y4LFSB4D8tvo=
X-Gm-Gg: ASbGnctXRyl9BcyOPap8NqjqiWi/m6n9Dsg3OiN2psaVz7jNO+y6VhUqr/gJsxBg8ld
 /vVYHDHN2THpLcuwWhw11OW0o1nWDtMpdEqpNoDUcOsExRaz8M/JYesiUYzczuBL+czQDPqrQMF
 UpAMX/KUOcgZTqf1qGJ/n6OpOFZzWc0811Br6ibGVY8gxelvdOLPDUk2SKBKIGWCDNBwhuZ4qaB
 cEZAcPP6ONBN3Ks7AFCjuOw6RKh/TbrLll0k7yESV8KQcHh0dYFO3dRM087jWEJDOfVCVqffCEY
 PgDOsGaQQLe4FGIIrvxndDW2ein9eOZmAQqAPuwl2/8inRhCIF2T5QS2SvUwnbNYiEBhngv2oaR
 E4cEzku6WlmydH65jrQI9WVeFuzFZd/6FM+U=
X-Google-Smtp-Source: AGHT+IG60wTsArUk61y3G3/GI256coSBnSSkyElThMbmskoY7xShVVD7PS2nZd54XI93ujCH8nedZw==
X-Received: by 2002:a05:6000:2dc5:b0:3a5:2f23:376f with SMTP id
 ffacd0b85a97d-3a5318823d2mr12081367f8f.13.1749541431146; 
 Tue, 10 Jun 2025 00:43:51 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de70sm11234195f8f.5.2025.06.10.00.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:43:50 -0700 (PDT)
Message-ID: <fb1aff3f-dd5a-48d0-a722-1eb4266dcde2@linaro.org>
Date: Tue, 10 Jun 2025 09:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] target/riscv: Add cpu_set_exception_base
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-3-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250602131226.1137281-3-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/6/25 15:12, Djordje Todorovic wrote:
> Add a new function, so we can change reset vector from platforms.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.h       | 2 ++
>   target/riscv/translate.c | 8 ++++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 229ade9ed9..c0e048a66d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -656,6 +656,8 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>   target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
>   void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>   
 > +void cpu_set_exception_base(int vp_index, target_ulong address);

If we need that, that'd be declared as:

#ifndef CONFIG_USER_ONLY
void riscv_cpu_set_exception_base(int vp_index, target_ulong address);
#endif


