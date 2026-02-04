Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F54E8B383
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnS3G-0005Ok-45; Tue, 03 Feb 2026 20:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnS3C-0005O0-Jn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:51:27 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnS3B-00055n-5v
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:51:26 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso5509402b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770169882; x=1770774682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sNzngwMk7RegSKbLyfQU1ODir0CS1RKLTcC8JXPa8Qg=;
 b=Wk9HWV55GsrR57U64e4XeiW21eWgzyVuKe47ITe8HQgQ1TfpV+JiOeNeb6AuRtmVHx
 1Pvt5njwT+pF/xDeDOz0xH6LdR5CcQa7IgFUtCa8bxrjSlRFLCX63h5UJ+lUxvp2jFNp
 349QymoUQ7wk/2AFgwZYzFBUjc2/VYDSMdncclJnZm/Q+a2bN0ipP9VAklXtuGNtct79
 ycg1YZHOSzGLen0Ll9b+NMSxOhq27MRrwukozbtKgW0dZVtW2JaeaUVWW43Hn6x3nzvq
 P89reHUKi/ql0DGKnpRBwSRBD6+s0sLZtQzJR3A3O6hZSrdzD0+rjpP1g6XhW4/4OFJ4
 loKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169882; x=1770774682;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNzngwMk7RegSKbLyfQU1ODir0CS1RKLTcC8JXPa8Qg=;
 b=cQGvj2L+66cqN79dc0ZwtHnhrMStR0KmM98jfA3IKs1J/ytFBf12M4ynNE83/0OF+i
 c8I0D3GvmXP+PxIJ1vjF2846NCsAC9QjXU9fRqUCjEybScf5aqC5oCPHrYLMH6EnDnAO
 cEr9QSJvdApltASGiqSTu7fvjKOYku5+M6Ys0EPnDSZWnnZmX+ZaxCeWhTKxf0jJB+ud
 27kkofp91KjN69zl7j+7+G8iwz1I2ObdZzY1oGCKEBKm7qjom/lh4fdYh3AQMbHg7m1u
 DSVqXXZh7kO1ys4bptv4JTUivdRisI1l3zA9UFSJq6ydXOV4Mgmf+5kHJIb8//xYOe/L
 Twww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL53zu0f8WIQmArtouWq14qT1BlbsPve+IfBga1LT2Zp71l1z2W+GRxl6Ygl4YPXIzmUkGw6iYMX4R@nongnu.org
X-Gm-Message-State: AOJu0YzWlx0gDXzEAFCNXno2cPMF9BTuvkPQeHLcmxtXqUi3G53szEoY
 EB+S9QBFXVmZjhuBncS3XXw5YUi9tvwas06I3azDIQXR9edtykR1XPA+uYAGHqBV70w=
X-Gm-Gg: AZuq6aJE3OX0YWwihyH8th7TSCKf2R3/e+yguor0ckUHOfeHRfaQ3h1Bm++FzBbCANB
 BfXSZtKd7ytpVKpYBOUoRIiBE0e4SLdrCWaPkpaoTFEjL9LE5PaOnoj1OcPXPI2XfhzGDeeaiRm
 RrQ40WUwD/aJNrQ6wtuUn2T3z1On44avyFPEteVlxQH7TryrSVcKHBORfKgzm65jLItIg5AxiWP
 hsywgSyeWHJFxCk07ZFzWiDKhHNrYnQbYIHtY7tIkaM2cjJd2zaZaFxrHU8AGlwwlFCSRmxPrft
 vjJ5QUobuPOb6vG88/+qK29yuEtTpzWsSWc8akxglXODx3j2D5WGU4d6Tf1v/zoBrFE1wdK5gRA
 oLzfHpeCIbzUNawvS93vUO8ETvXeiP7I3Mgt2pHcacTt7R8Us15saRloHf23MvuazASeNcvbb2Z
 QP9rMruMCEStxGZUB+djgK7q74y1RmpLy2FowKPeXuah00CqWxYz99ju9rEb3lUhhbYYTH+SFGf
 wEckQsq3OgkXnQMj33PfPxhG00p1gHXoopE3yfAjarFQus=
X-Received: by 2002:a05:6a00:12db:b0:81f:4d18:65c4 with SMTP id
 d2e1a72fcca58-8241c679e9amr1412603b3a.59.1770169882155; 
 Tue, 03 Feb 2026 17:51:22 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d4ab4fdsm568085b3a.63.2026.02.03.17.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:51:21 -0800 (PST)
Message-ID: <0303578e-27f9-49f5-990d-79300c06a828@linaro.org>
Date: Wed, 4 Feb 2026 11:51:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] target/sparc: Replace MO_TE -> MO_BE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260203230054.23667-1-philmd@linaro.org>
 <20260203230054.23667-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203230054.23667-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 2/4/26 09:00, Philippe Mathieu-Daudé wrote:
> We only build the SPARC targets using big endianness order,
> therefore the MO_TE definitions expand to the big endian
> one. Use the latter which is more explicit.
> 
> Mechanical change running:
> 
>    $ sed -i -e s/MO_TE/MO_BE/ \
>          $(git grep -wl MO_TE target/sparc/)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis<manos.pitsidianakis@linaro.org>
> ---
>   target/sparc/translate.c | 58 ++++++++++++++++++++--------------------
>   1 file changed, 29 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

