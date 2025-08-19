Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C3FCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 13:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoMKO-0006Qt-S4; Tue, 19 Aug 2025 09:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoMK8-0006PZ-Gl
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:24:25 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoMK5-0001A4-IE
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 09:24:23 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e94eec0de32so317201276.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755609859; x=1756214659; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LMinEjCbiigB/Wv0BKtvA8XYhpLXZtX+Rgam8GgX/kE=;
 b=BosDZxKRVInUU9y+5GeWcfesizZWOQkLl7VEIehuP3hntHKlrPPaKPG38c8fZmqSaL
 vvrH+FLnn6bC0f2rUQec0uEJ5OVOWe/pzWCbywzPoga9pi46EN0MO8RKpAoLuh3oJNWE
 EAgOdcWrWLPdle//7aErP4SQ5PnD2jbRuAjSrsJJ2wo9XqNzHhFdWzvV/fan4e/yyB1l
 spIZEwXdEJp32ql308NVq1CspJhIwKps9P/SM1oNHp9PHH/+3pcbwgtT02fdKoBmludO
 eyPrxn7dP9kcWF77up302zHuI5LsY03Va7eEZ0ji5XtZ19RiGWGI2wgouLhlSjlrsOij
 lCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755609859; x=1756214659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LMinEjCbiigB/Wv0BKtvA8XYhpLXZtX+Rgam8GgX/kE=;
 b=rW/WR3lgAER1vWCjpqnsthwf5jlSFD2ePJARBkAw1nn7wsZrsdJhGhpL2eCHjFwxgQ
 3Fa5+j6XkqtXD/UARx0JTg6D4Az6MlmLp+VrGmxxcXjHxFuUv85X1uSQ7E45hWxBBAsc
 lE+3Egbt30g5oLr/EFfRXlqUrkYKY5Wb2zgBkhzcy4yvCb/q3p/VVvS89dZd8yN8ao9M
 SIHH3DLHIbsBxljYh2TGE+n2hhZOO2RJxJyDr5T9vx8gmAjlC9VwVWfi1dVwZ0pmFy9o
 rPH8HQ7rM+y1+1oihgOTpAJ4EqNzxc7pcJY2oDinZsLSA94xGl9VY8zMI9ltipQci2rb
 IvAQ==
X-Gm-Message-State: AOJu0Yx43B8qa+JYEA8G7ioC3Qek8C6+q1fL2DVebab1BhjRDXRmHIyV
 ReKNZJgXg5vUzRVGOGawx8Hhj9hU/KoSielA1lcpZ87aaqXDje2na7be0breOlH0wEZVYgtLK6j
 JJGb4R9l3bm2DISMPFkhkoHutIRSpAw0+48BbFIoH8A==
X-Gm-Gg: ASbGncuhicMbjEI3mxQnkG3gt1qct6OY7AzKcDUxN3EzZ1BLuVDVeZIl6dMpZcY26D8
 fMPKQH6OO5hJ1Kcal24bIyvlJQivXGyOXqzYqjCLbigDExDUe5/A/HiesQFawy+7zKi12yzONaz
 ZvgrULuY1IU5NWzmZSoXfOb+/u3afIqu9lw/G8PNE5KpIlrjEX+WdvHyyeZW07YE5I7BBUi1vI0
 wO//5Ejak2nj/6IBEw=
X-Google-Smtp-Source: AGHT+IHji7XyJ4OvwbYw1BL2nsbRVYRNV54vGoPjANdobtK7tAAHvelLrFU0o9gRQ5y3QWVBlPE440BViy5VF11ZPFQ=
X-Received: by 2002:a05:6902:318a:b0:e93:3f08:86e6 with SMTP id
 3f1490d57ef6-e94e6108048mr3116783276.5.1755609859234; Tue, 19 Aug 2025
 06:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-16-mohamed@unpredictable.fr>
In-Reply-To: <20250808065419.47415-16-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 14:24:07 +0100
X-Gm-Features: Ac12FXws_rBETXjrcWqjmDL6MGULYbrN9gXbrfcfhBvnHNbO1IbmgxOG8yS-K-M
Message-ID: <CAFEAcA9iQnrKWXPXw2wG3c6gmevOMFQtt48HsJdx8GZz2sd+4Q@mail.gmail.com>
Subject: Re: [PATCH v5 15/18] whpx: arm64: implement -cpu host
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Fri, 8 Aug 2025 at 07:55, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> OpenProcessorKey and ReadRegU64 adapted from:
> https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c74/Source/Windows/Common/CPUFeatures.cpp#L62
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> +    /*
> +     * MIDR_EL1 is not a global register on WHPX
> +     * As such, read the CPU0 from the registry to get a consistent value.
> +     * Otherwise, on heterogenous systems, you'll get variance between CPUs.
> +     */
> +    HKEY ProcessorKey = OpenProcessorKey();


Can you follow the QEMU coding style, please (here and elsewhere)?
Variables and function names should be all lower case,
and variable declarations go at the start of a C code
block, not in the middle of one.

thanks
-- PMM

