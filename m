Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19C7CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIUx-0003he-8u; Tue, 21 Oct 2025 15:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIUv-0003cf-DX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:58:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIUt-0008LH-GF
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:58:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so4185961f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076698; x=1761681498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v/JG2A61AFTHbxScHI2kgOyOavzxQU3W8Rq7xF91G/o=;
 b=GpQC5CAGdUxjKbPuR+pOKzF7ZpbKXvp9sxLHb13pU9iVQcoJtS1sBo9FVsPl+dwbid
 4wwu9XP9mz0Jd/URp3k1ssu3xdEhlodcXxdZGnzqNGXDSpAUf5aA0K6pHXuHa+jvt25v
 v/TNo5xRhUIVshKoQSbG3lATJNBjr5j0Db5k4Eu9YSPjJy/ZhE8QEaNirVRSgixmBJl9
 KF54PhU4NpGFtZh2fRMA/qw3vSSaOA6qbCnpe4EPGifn0ukom4Tu3J/bu2xZA+r5NkBM
 7K2QQ7ynoAM70wqbpOBCAdPwDaNK6Uw6b5BIrrAKgnD0MWPy7u5vC13Te/oesqXPchM1
 HbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076698; x=1761681498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v/JG2A61AFTHbxScHI2kgOyOavzxQU3W8Rq7xF91G/o=;
 b=e9q0smciQFHEg5PgSVcD1WfRKE7NyONfDyi4Ig9ObCBQbPW8wdlnn9Y/UC+Hd67SFY
 L8ON0xUroh3OXx5Czr2O4Qp8pON4l/HuaehNnDVFoO9iGp3wLG09nvHopmwgGuQRSa4k
 5AlwF21FUTerG3+lpjbP0jemOeoHG68+N5JAahWtS6AE436O4RLtqj/fTzwL38BrZtZ0
 qb928bRB7CuE37KMfCJsbeUhoeDqYnvZkTSNgYqxJo2z1YCP2tTPKARrnnDZsWiDrJWU
 6CzNYt80G1BQk+PuRCh6cvOpjCxiwiARBksVOYcQpUJMtMgu0xk2+722LfFlISFtlFQc
 zX/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgmzWhPzaqrU3LW4JBpOWwddtzIlOvKWy2D/1u8BDQbhz/IV4NaYcsd+iKhJCAxWDpTQ5/qomwB2wk@nongnu.org
X-Gm-Message-State: AOJu0YxggdIXh2kZo9PxaCAGykdjMNHGgZqjLAvtVEW4J6kl1CHZPsEc
 mVl0/n64hFKvIOpY3pbMk9rD9/Uqy3RxqcUoxpBqAH1VoqocZmYx3Uj6ujVPPWWe8G/qk6p4RC4
 JzjgFLbA=
X-Gm-Gg: ASbGnctKyxsyw7SrIvpozsO+6DiQOLxyXnfF8zEbSQHFDYztlTbIsU2/0J6R2wzgp/G
 QLNkahpPD+/l03NYlc3bnpu8f4+CMH5eXLUqj1QgOo9G24VoD+kdBGGB5r2EC0w4PoK7rtxBWOp
 1yUx6aTJxtcg6QdU5rp1ovudqmSaCFIGwcaHijh1tvmhymbhyziRRwViuCxLGECtI5xWPv2emkg
 q0a6bQP7a2kcft369qbseSN/Xe/UFQ6EgmPrpSOXsYH0KHy8UhnOqc19TlC+Oat25q+0isbtbpA
 WjC+kFkqbJtyLAxCOSqJwHtsyAnZ9ismAuOq4QJ9PZRjYfdia94LiAyaZGW6l5J3w82IxqT68Y3
 boeOjOS2QqDDDc2AMF+lT0y5nK3ErUUaZX/flSsLg7V6vGIgX2hlMN88Y+54KtEqzFoDWXxox2C
 q5jejKl4TdyRvLkWfGfuLio2cDBcx9paTcyhtDhIfEYB10P3P10ymC3g==
X-Google-Smtp-Source: AGHT+IG5qKbBUnee6OpI7Hz82b7NS/YhuXzmiLtycdzsZLb4Vl7yUoGyxXEkSzUc3z6osCZHVvsV4g==
X-Received: by 2002:a05:6000:22c6:b0:3f0:2ab8:710f with SMTP id
 ffacd0b85a97d-42704d83514mr10124474f8f.8.1761076698126; 
 Tue, 21 Oct 2025 12:58:18 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342373sm9177905e9.12.2025.10.21.12.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:58:17 -0700 (PDT)
Message-ID: <76792ed3-6bed-43cc-ac4f-d3ce71f2c4b9@linaro.org>
Date: Tue, 21 Oct 2025 21:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/25] target/m68k: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <cover.1760884672.git.neither@nut.email>
 <5443bb9ab89d96f0f8670060734226f04d40a668.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5443bb9ab89d96f0f8670060734226f04d40a668.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 19/10/25 17:15, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Motorola 68000 targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/m68k/op_helper.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


