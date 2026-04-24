Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF1FFB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGB9X-0001Po-2H; Fri, 24 Apr 2026 03:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGB9V-0001NA-ML
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:40:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wGB9T-0002eQ-TY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:40:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b0046078so67776435e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777016438; x=1777621238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h8yL3odyhPrO2s0aCA6eGvSBe2pLsIa4gvh/0BggZZQ=;
 b=DW51G/ru3se3onfXl/Eh+sacpKDySJgrdkbkMruFIIKSaRi0qzM0xL4IxyothNheC4
 /SQI/pAbI5u/jb1KgvsnTNYcs2+GLesSPUfwulhsQlUSPOCNAbPKcU3OLuE2Ffcfm+8d
 pu60K9tlFt7gNXbVvrrGsC34ExyjUeRfgREgXU3Y8CmY012mK7cEsTuqqx/jqD83ayGY
 EeDoe9QjhkO0stn7USloM1Snnv7jKIHB760MgetCXizc5S9Wb85064htJqahEzQgOP0O
 fAILN6mMGEq3Ryezxjw1RUYJqnFe4anUN5lWaFjwlB7lCBJOrvg4wgF8NfPGks26uiu9
 9THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777016438; x=1777621238;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h8yL3odyhPrO2s0aCA6eGvSBe2pLsIa4gvh/0BggZZQ=;
 b=eVTnWzUtEqlcSO+rfSn5BRsG9qlEeL8S8bJ+Z2Ad19KwCdfWtZYyKxM5bm5e2fqv08
 MO1UcZNvknkinjV3EBYz3GaTXR40QDq/TbYwf1FBlg+X/m6uwZPLAG7I7wDNyvbiQLhd
 /prx1zcHyk7Bard93vt9tnhNW4My4EGNJKTVhkuxaa1U3oA6FoQMRwwGRyRiYplP7IE6
 WKS7UDHMOQgEY/1lzp/G1714UQKsvYVWzh3uAd72r2ZX3jBKsXVw6qTK0gATRMV2Jd9o
 VGMWEuHfpyQH/H/cVeDUFDQ/+FsN/vk01LwpoyV84d3PGtFpqyeqqy3WxdsLkL+Y0Cy0
 lCTQ==
X-Gm-Message-State: AOJu0YwFWg8tcfyBshd6KWE4RLBlH3GCK8X+YRY4OFc4GBllOG0hytec
 DbaiYUxCrNpm0N3CTkxfCoe7qKy7wiVuxpqz5USj4JnAIjuaHzpDj+uTrFxizPu3CerBSg1ncYF
 nLzveP6U=
X-Gm-Gg: AeBDiesjAO5IvdlZppxQ920xu8EXScfo9TDxxzDY0/PBgedsIInsuPAMRNepvAh/Cx3
 6VOXI/gM76plLLQL01qlcvXxJJ/bcsH0cvB/4AyZgX6C4D+i3xNQOmDDmfYj1IHIRnnfdV1CtnC
 EQ4WuoZa0uzVGWHZXbUBLa10Czu2Adxd2y9X13tPFgU3mFputC/KtDi5lMSf48c0anpOMCdBAe9
 N2Aw7vEaZ1M90iAZblHpKr+XYObqMojA4Du2FyyOOGKu0HkOXAM6ctxILNMyg8ECKwWwsBxvqZ3
 dmESZ+gF7i9ovf+l3cOQNczCVviEbi92sk6L08rPm6OKZopRfHfQrFqtM3s7ujRfK1wCA7bR9rJ
 drbqgXRGXtUeWbyE4czfCy+ILqroWelljJmswT+O4/69w3mxcyey0xzaiJvXYRMwzxGp0PfvBdu
 Jj9tLoqikZDdApb2x+9IC47lNSP1HfWBqnmhfOVud/3KyJzpJ/7ci2mLGPHue13i585GT3bc2QL
 wi3AnHXX8zTAsLW5bgADiCgCMwuxME8+Dx3DDc1nzMnhS+5KYtEmYH91/8NvoNI8KLtjswO
X-Received: by 2002:a05:600c:828d:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48a568fb048mr213507425e9.8.1777016438020; 
 Fri, 24 Apr 2026 00:40:38 -0700 (PDT)
Received: from meli-email.org (athedsl-338307.home.otenet.gr. [85.72.177.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc14a61asm528999295e9.15.2026.04.24.00.40.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:40:37 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:40:21 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] contrib/plugins/uftrace_symbols.py: fix symbols
 reading
User-Agent: meli/0.8.13
References: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
 <20260423213838.780814-2-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260423213838.780814-2-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tdzmno.ffmka4n6ptcx@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

On Fri, 24 Apr 2026 00:38, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>When running this on hexagon binary, we observe some undefined symbols
>without any address or size.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> contrib/plugins/uftrace_symbols.py | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
>index 02d1221228c..895fa1a6b7a 100755
>--- a/contrib/plugins/uftrace_symbols.py
>+++ b/contrib/plugins/uftrace_symbols.py
>@@ -36,8 +36,8 @@ def get_symbols(elf_file):
>     out = out.strip().split('\n')
>     for line in out:
>         info = line.split(' ')
>-        if len(info) == 3:
>-            # missing size information
>+        if len(info) < 4:
>+            # missing size/address information
>             continue
>         addr, size, type, name = info
>         # add only symbols from .text section
>-- 
>2.47.3
>
>

