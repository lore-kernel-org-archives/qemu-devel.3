Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE112FC6179
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 13:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vc1JF-0007s5-8J; Sat, 03 Jan 2026 08:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1Hc-0007T2-VY
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:03:13 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vc1Hb-00050l-AD
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 08:03:04 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so2704885f8f.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 05:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767445381; x=1768050181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4D7zAZzX15Yitx7OEmCi8jMqe6J5O5RM0xcI53samB8=;
 b=IHshF2jIwKXFLHLr2AB43Z6e5w3/Ybp4S67JWooio/iObsys0ACUsVJEuVXpolIaPB
 dexYWfVsI5RLLvZTrRC1KKNdf1Nq7miZ37rEuyccaRITznl4fn5ZiSEsHHg8wggP1JCV
 kpASvUI3s751yllZ61vuIXk7MzURaSGpGF69U3S7czKUhfC6i38WgQgXQI8zlvRT1jG+
 JywHPw+eIqMvwJW6MpsDUfIOWrbenuxaE7qPBpeJOmwkbTmjp4LK3I90dAzmcvf6X2I+
 R5Wp2WLAf7EI74rJaXH+Q6ttP7utGISdiyn432NYSa6+NwcKVJsYpG9W8gV2wPRL3vcO
 918Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767445381; x=1768050181;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4D7zAZzX15Yitx7OEmCi8jMqe6J5O5RM0xcI53samB8=;
 b=r+rJ+drZJuHdyJ6NLQPmF7SyV95uPZup756VilCzxYlkr8IU0pVSzgl5ps9bJuiT1s
 Q78sMgqfKAK8ejhH4yWM988a83MjsXOjbJoIWK/iNK+f7bk6LO7aVG2q2CJx5zzIEXzZ
 dTUro1/zJ2QTE3+wlyB1szALkbLmuy2UwqlaDSJgGg8aUfhTjhFgE+QfrP7NDSR3pySi
 oAw8NNc40848EMoj4x5VwKSZhpjk7Cg7qca0998m8wY3UF0vK8z6GX0wzXIuC/4LQtM4
 l5m33JOtvO7tZfQJPlQts6mgusqvPM9+4H4uCKbdNDyJ+b9td2axXs6ZQdXFlcN5UOnY
 fE8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/GdFbyBKzLHcfhn98ZI06fLxuWCjQba0yUFQiIkEtBG/2Thn3PdHKFrk4jyfgvPCnDDP8A3cw1f0r@nongnu.org
X-Gm-Message-State: AOJu0YxrYydnB1SBwZlBrlJfwPG11nD3F/PbsYoVZb++amjIoopGev1n
 /+mB1wPmCUzWZ9p+MfofZvgZapKqZ3ePX+yUH59H+h3k/3AqkLqZOjj6B1u6j0r7GQg=
X-Gm-Gg: AY/fxX5i3a9SnTWc/xqezVpwKHJjSJJnOkEMsjxig+QZ8limg5kd8WtH779JKF7C0P7
 ewsM6Wif/qS467kOLTJecdAhWljwGfq5ODtKGfO1Lxw716HPgcD5pWtUb4rHeZtQpPacjZQA9dF
 S4ArEO/uGFOzpSLUEwLXFXXjRxCsjNJ2Fe2tBR2NdCsiqFy/5gA2JQPSYbAAEfzWGZFYESCQn5j
 B8nh2jhDbjRHZd19npaujlb8gY61tautOcQEu7Jr+cENGPY4BQ0Lqk9PDCiUdQV1WkybLDpTICQ
 iUQ+/wyBJN464P/XsUYuXWVWNXaUUBu0EoErNC5UGe7ita009tcEpm94VPjtwi62Oj03OLQC7pW
 2YjgxZwlpX35qAe1wY2gWk4fEK3qLr1JCzisbwnQA18eRi6o7Cu74aQXQnVa4/HLEaoJUep7Pk0
 ZouCPjAs3JcnRl1p57Kdw50rVjG8pQz0zpDsa4nBbnpFJu6oTJef3XZJFjsTkzCeNXD+aNsA==
X-Google-Smtp-Source: AGHT+IEVddUmF4S+Z9k14P+/jb4Boo7czvuprWwQqTI5uW5/uWFmFUFONP0m+YXm+m33WunxSzantA==
X-Received: by 2002:a05:6000:609:b0:431:342:ad41 with SMTP id
 ffacd0b85a97d-4324e6fa1a7mr59175461f8f.61.1767445381638; 
 Sat, 03 Jan 2026 05:03:01 -0800 (PST)
Received: from meli-email.org ([109.178.218.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm90473350f8f.20.2026.01.03.05.03.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 03 Jan 2026 05:03:01 -0800 (PST)
Date: Sat, 03 Jan 2026 15:02:31 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 08/11] meson: enable cpp (optionally) for plugins
User-Agent: meli/0.8.12
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-9-pierrick.bouvier@linaro.org>
In-Reply-To: <20260102214724.4128196-9-pierrick.bouvier@linaro.org>
Message-ID: <t8ahkz.3or5mwb2bqvkf@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Fri, 02 Jan 2026 23:47, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> meson.build | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/meson.build b/meson.build
>index 256cc0cdb21..38767c2c68a 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -77,7 +77,8 @@ python = import('python').find_installation()
> 
> cc = meson.get_compiler('c')
> all_languages = ['c']
>-if host_os == 'windows' and add_languages('cpp', required: false, native: false)
>+enable_cpp = host_os == 'windows' or get_option('plugins')
>+if enable_cpp and add_languages('cpp', required: false, native: false)
>   all_languages += ['cpp']
>   cxx = meson.get_compiler('cpp')
> endif
>-- 
>2.47.3
>

