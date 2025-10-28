Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BB9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiLr-000738-4Z; Tue, 28 Oct 2025 07:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiLp-00072r-TS
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:58:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiLm-0008At-9Q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:58:57 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b5a8184144dso933601766b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761652730; x=1762257530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wy2BlbrxqK5kccqEE3t4oM3+Zf5sY388xcAHOtsVmlg=;
 b=av8jBkydKjQp73oG24MD2IK+9W39D5AfQ/sTzOQVp4LQGn9YoHb94yxoArscG7LDsA
 hEceN3MTf4FaTP2EO9EEEN3vGVxpfKYDfGfT6cMqxytBBJ6q5Ad9BmEsl2io7Oost8cV
 eJXTwJWS/sN8G9oqXipAKYNasjMDqErjvew75aZvb9k/Up+1/cmIIPeAZObnrdLZH5ar
 yKpMQ4lB0eQnMtqdC9/+MdQhIa5GSFuIGnFV3/8IIAKxdMEjZyPpQRt39zGFqeKX70QM
 kHMveqJ9sItFQPJ7eXfDeWnakCCtIzTxMTTi4NzF7MsmY59EWaoUCkBij2INcPom3Neb
 X9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761652730; x=1762257530;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wy2BlbrxqK5kccqEE3t4oM3+Zf5sY388xcAHOtsVmlg=;
 b=Chj3ISW+xCgFAdjYEYQLFt8APj+Ae+FU0eusiZ4iAuD51kJADbWqucVNcslAzl3yXm
 9+bc+9cQkTtxFxaS+3eF1jRmZoyEV54dTO1PCbEIgMjyM0uenv9s5E5lID8I9HJniwFQ
 vPl3tCo0gljqyFCXbYDTiOK2v28PW4HQG33TZrAUO13U3e11OL4Wij45mthMXtkAjFog
 xy9EdjZ2hroFJfE/1MuKv9dJQXwSz7FcrLNtbmttTqsm2t2l2el/Nxeo9fpjuvmcdqsg
 451Yzq9RDpdo1JZJa5c0Uq25vnbAaO3avcXbOOaAVuAmWDtS7R/IYrO5OO0OK9BnwGRF
 4txw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH9PCNfLZJxDhoEmZgmDQXjMXZ0B3rmCVKWsy03ITZl9C3rx0UZz2CXxfRcIKY7cQqXx2rjnDUgetu@nongnu.org
X-Gm-Message-State: AOJu0YwA2SBSZkf0eeSXja3pnM9Y5gkLKd612ykyNY1+wHMzORBCln7c
 iWIUThk6AE57q3Epqq8dztFviwA6Sh67bKB1QwmjFQ3yUlTT/oI5wFS/9+i+Xk/9sBA=
X-Gm-Gg: ASbGncuSp3oZ+IGM3YPlGsC4+2akAHREJ5sfbdz2E/EPBzqbGUBzVH/vTUtryd4UpFG
 AFTXnGWPY74QP9/wr9AlhqtupvIM88CqrIx0owISuMfVd+l85UCpIke0YOs4VKNJR2rfFJlce7l
 /wyIDG6LPUOQUFEekgR+SQfcJn10WEEn230DAvzTkDQdt/u08LaNhn++TlKOTi/55qrqu6TDIh5
 Ilbx7ypc4egtIa8SbpWhPkDq1847MIWC6RzgMugTiYE5taasQhLFsmh/8iHeKOaHUQ9x9vWyKR4
 1Rcxpj3vx3qSQVuC3v3fDdVPWqx9l0hD8tEmd2f5YOctRYLwqL1SGSOJsCdisS36msmJJu9OTrQ
 lxfrFruXfXFh4XKY40kR5qcj9vvmFfRAoxYwCjG6m9bb6ThQng/60ghLynNw5qeTdglTw1lvHlh
 NFAgOJ8IfmlCfANh1d
X-Google-Smtp-Source: AGHT+IHXiCoxFla0G3jkdf0kzf3uOGdZNKHg5UeyhsvibzUa33gUAF2pOXQ2ASTh0pP6h+6Xuf9aTw==
X-Received: by 2002:a17:907:6e88:b0:b50:52a4:8f9a with SMTP id
 a640c23a62f3a-b6dba55baf3mr360297866b.45.1761652729686; 
 Tue, 28 Oct 2025 04:58:49 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1057613666b.75.2025.10.28.04.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 04:58:49 -0700 (PDT)
Message-ID: <c58dd19b-5bf5-4cf3-955f-e98a89fecc89@linaro.org>
Date: Tue, 28 Oct 2025 12:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 41/59] target/arm/hvf: Implement dirty page tracking
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-42-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-42-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> +            if (memory_region_is_ram(mr)) {
> +                uint64_t ipa_page = ipa & qemu_real_host_page_mask();
> +
> +                /* TODO: Inject exception to the guest. */
> +                assert(!mr->readonly);
> +
> +                if (memory_region_get_dirty_log_mask(mr)) {
> +                    size_t page_size = qemu_real_host_page_size();
> +

Call qemu_real_host_page_size once; mask = -size.


r~

