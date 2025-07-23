Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A508DC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZxs-0004pu-8p; Wed, 23 Jul 2025 09:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZuW-0003VZ-AL
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:53:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ueZuS-0003pP-Dk
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:53:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so50975485e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753278806; x=1753883606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d/b863zWek9PWM/Q9ZeGW/jBjl43HCgu24r9qViBKhU=;
 b=Oq8nVsSa4lvpjS6w0tq8YPVVEtCnkd257nrib40LP6Z5Foh3ThtqqCusilJycsOz0D
 x+Fnbn5FXeaselJgZeS9sNf2Gfj095MfA6YXE8IP0oor2GVGd5KkPzK9UTnGuEYZpitB
 +UCkUIyMwsLlSQPQLyqB9wtCyJSpcSSrApdhjAAw7Jrfuj60tamgm6UgmvjQB4yP4qed
 HeBjB8cAbVNrmge1FqlFUBspuIEZSR2F+TOKeNr0+qU4emrSE6FnXd6x4CptF4WyNeTO
 HhiZXRJ34Om5eA8UT8iwUA1WHymDKsK1t1WCtzVEn2eXOiz+yd3N/CkoH4aDNy0L7+nV
 yiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278806; x=1753883606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d/b863zWek9PWM/Q9ZeGW/jBjl43HCgu24r9qViBKhU=;
 b=W62BBaV0LzsQhSKe4te8QLvjCxvjGuSM/y0orDoQW+GgndNkAFvLiyOzlMBHjO0TGp
 G6kb+C9UxIoub1ZCrQ0uCRwOSEekoDprxBimXRUvaVN+sLaiCJ0twuYTJuhG9rgycMBd
 WlqMNw2tUXni9EmtBxILohVFRHRrz3smIL8v416LCmayyqnK/URJfTnXttl/wvzwRCdd
 f24SVjiQy5bFt/Scn1Jo/IqHpemOKZVGTZTUTbF+X2KbWA8Rf06swZSKEXqVjuqx8A7L
 Ilwgm+2Q4x2liHDem/RxWBojEtI3e0jKCiQxRqjpsyfTkaqz2UymjQZp43tujmSamup1
 51pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXpKlWk2SOLAJZAJeCjmf+TYrR02P9tRnS9XIzIHHigcuaCjbKgRSpn7Mt8EeX9KqRuFiLXs1MZEBO@nongnu.org
X-Gm-Message-State: AOJu0Yy+kgST8xdW6GqPRgzg1wqShk8HcrFDxy4j37nulf5GSEWskOKw
 j/vZlc3oaHROWZoi2HenSlIiSkBSW+Sde9Ya/fTyeUZE5NuQMCq6ywfQrybXdIKRAa4=
X-Gm-Gg: ASbGnctZ2gmkwgvR0FG9gf2lKCSyJMwlfYQUlmvVjDBWcakwFgfc1BTrovfns7mdqNg
 7VOO1HQ0YZ4drf7+puMKFJR/Cxw3zleS+FXZHVJc7fMa8fkIcAJbQlouN44vP/NGFi+CcjVaebI
 +nJBFmDf8VJP2RP9RzjigK5xrJIqW1ZscTNaPxZuxlr3e7gVYPEiNzGO8GPlthmLGH/4F57PO+O
 z67IlrmQOoqYInTMfu88mIhwBsRn9vpgQvuVc9NwVJzmH2EMHv2enl2v+teW8MLsQTUE6qvCNbv
 ccQ4bnp2Ao6GTm6R5D7gpudNu6PdPMOeoxtIoFrQbgFRCnDnJ5aEMb43UxQTvHPyeFJU05hUYYK
 bvOAA3UqN8pFwzvTTGwlSih8iI43kSFEvrR+hhmOkPph0i7tz2Lwh8LF2Q2y+Be9ciA==
X-Google-Smtp-Source: AGHT+IG0jTn1wP8XJQPQF0kQDTZXAsKYJzE4JpT78lDZeNBMPuucWm6mMF6hFBk0yK9SJQEFqJ5G1g==
X-Received: by 2002:a05:600c:a08e:b0:456:76c:84f2 with SMTP id
 5b1f17b1804b1-45868d6b4bfmr28698565e9.30.1753278805721; 
 Wed, 23 Jul 2025 06:53:25 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45862cf142esm36013075e9.0.2025.07.23.06.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 06:53:25 -0700 (PDT)
Message-ID: <a17f72f3-3778-420e-ac08-995eddb9c059@linaro.org>
Date: Wed, 23 Jul 2025 15:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/keymaps: Avoid trace crash and improve error messages
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com
References: <20250723131504.1482657-1-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250723131504.1482657-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 23/7/25 15:15, Markus Armbruster wrote:
> parse_keyboard_layout() passes a possibly null @filename to
> trace_keymap_parse().  Trace backend log then formats it with %s,
> which crashes on some systems.
> 
> Fix by moving the null check before the trace_keymap_parse().
> 
> While there, improve the error messages a bit.
> 
> Fixes: d3b787fa7dde (keymaps: add tracing)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   ui/keymaps.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


