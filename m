Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81ECCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNsx-0002MO-GM; Tue, 19 Aug 2025 11:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNsv-0002K6-47
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:04:25 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNst-0003JT-05
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:04:24 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e934c8f9757so2436547276.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755615862; x=1756220662; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IGfn9RS1Bu04ZR6L8dA94ph9BmQBYpiMXe5Y+YWdxlI=;
 b=mESmMqyVKD/1+tarjAXZNI1NeYLA7xfhFVKGVC8R8R7g2UUBRuqvw6edx7eBxGVXWa
 ayAkWwF4msiGS+DQ5f5UtX5LKZeUOg4gdHcNgGRSW7gILVbbpRjAkQLNclxTGc2uWObg
 cUoRydw9nHn26u+FAICgpvD5bmPbUSpIMFtYLNUU4aePYOgMdlhrqmGXnMEc5GY+CmR3
 /McfEoEsl6z0AMSKELBpvtdG3tmFzlbxMPx/otB/Nn75yn/oezDK9bDQDZol1hlBW4+K
 UAzfXGSiN9CZf70hO5LCE+yxhp71fqvYvyqPDfY5uo9mC9HeudnIyx0NyW4sKgihPZ3U
 xeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755615862; x=1756220662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IGfn9RS1Bu04ZR6L8dA94ph9BmQBYpiMXe5Y+YWdxlI=;
 b=iEDVXVqH/Lta97X4LGsHrUYDjmh4mN3MIOWGqE3oEfA+fokKCD0JOwK96cBX/YclKe
 478c55jilZ/fsQaMdsmrNZ/OBW+m0+jwNsVYx3sqzU0tfSKrXAOLVQdEJQDg/xrkNbXg
 v8MSdDvdst/wSq5uZ5xAcDakmCXv6tibHFuhjHp3wZbrnlCEN2nH/Q1laltvmaFb55mO
 JJt2lV3Rps8EXjkfx/kiAegMiiFJSfHyhH+mGdKooHdF3z4yAT9fXC8H75swwUKBNiE8
 Ra8DpruScqcCaRbFS+yWQOkpYqyBIqUV33CLxHcCAv6LZJzcGPeTBUXF37ZtOygUPNdk
 RqWw==
X-Gm-Message-State: AOJu0YxqYONkefG2SwVSD/gGSQI+EoP3Xqk7a1MkwfY7vq8vicEkv/El
 Bbl6LVeSYtkO38PO1IT60L7iX3V2h+cW1eZVIg6beHmeBzYKf/Y4D0XJfKP5QoGbQAeNJMzHkka
 EJ8fzcK6PPtpm8ZkIIg1AFY856sjU2g5guu7SQqowrA==
X-Gm-Gg: ASbGncs6SR4SPhqns0fo5yEVvo0rXRZIOhiHdCGdyJgRrTYUE18g7xvl47sAzFe5m67
 av7KRqlFBTE/RCp8waBLC/JkzN0qDUXhpsKO6AiMVuhi67DYTCaWZ/aU3Kugd6gS95yuTy+lVQS
 xbck5x0ZpKT3t938EDQ5gRX5lpkMFOvu0WbzHHhHvkKl39aiiBcqaVyhFp9xTPqOhxmSQif0Gs1
 fs2baJ7HJoB5qGF/JI=
X-Google-Smtp-Source: AGHT+IH9GLN3G7YILzmKcSzrFNCNy/Oe5I0Z0zjCrMTijTBTrUzhcs0i5wnIdGLCPRBVDpnJ+gyyiWxEXHaK7dxZskM=
X-Received: by 2002:a05:6902:154d:b0:e93:47b2:752 with SMTP id
 3f1490d57ef6-e94e62a4c16mr3666207276.34.1755615861581; Tue, 19 Aug 2025
 08:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-9-mohamed@unpredictable.fr>
In-Reply-To: <20250808065419.47415-9-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 16:04:09 +0100
X-Gm-Features: Ac12FXzSBe1DHLCX_ytlkJ9BuV9ZQ4rc-mxnEGrgfcl1f9gTnywcpZ_XiLR_gmA
Message-ID: <CAFEAcA_ZokV90NRuWY7PGgk_Jwh-ZfZfNO+Ubss0F8AWDBTwoQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] whpx: interrupt controller support
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, 
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Fri, 8 Aug 2025 at 07:54, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


> +static void whpx_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
> +{
> +}
> +
> +static void whpx_gicv3_put(GICv3State *s)
> +{
> +    int ncpu;
> +
> +    whpx_gicv3_check(s);
> +
> +    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
> +        run_on_cpu_data data;
> +        data.host_ptr = &s->cpu[ncpu];
> +        run_on_cpu(s->cpu[ncpu].cpu, whpx_gicv3_put_cpu, data);
> +    }

Why are we calling run_on_cpu() and telling it to do nothing?

Also, run_on_cpu() implicitly drops the big kernel lock --
I'm not sure that is valid to do from the pre-save/post-load
routines or in a reset handler.

thanks
-- PMM

