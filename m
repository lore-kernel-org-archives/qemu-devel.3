Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4E6CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyuM-0005o0-Ap; Mon, 20 Oct 2025 19:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyuK-0005nS-D1
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:03:16 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyuI-0005vY-Jo
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:03:15 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7a213c3c3f5so6323820b3a.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761001393; x=1761606193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6o+fgao+xR3zoHTFJffxoX24yvZBwmWhIFo4CHdugOM=;
 b=TOYaeynLkXyjPHtfCzC8LbvVWixtht/zKUoviY0qKT+yBADnYeOojtybDHoYnJT6IE
 yul/tTk8hPWFGFOSK06VkjDFcq233fLpPTfy9PhFf1xYfEcvhgf0KoXoRxRwq6YQ9Zwn
 7XKcZ/ZHLAZ5qAmpkBfQksAwDYXWe0KdC37fkk2evEg07GTdCQxoX0xS42Ou8BwDKHoT
 f5a0seBlL/9536nqSMu7ZspzZQbc7cuNr+QR1PR7gx5xfQAaKYfdZcv3LO3msTPtcoB5
 sTQjqCaJjXRDDxq3bmZcIvkn0bvbW4VUX0zuRZENrPHyLLAURujYO63JXoIa0YNEbR9F
 HR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761001393; x=1761606193;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6o+fgao+xR3zoHTFJffxoX24yvZBwmWhIFo4CHdugOM=;
 b=c79jMmqYWifRIjO8+vcJ5TLXtD5xbQvtJnWl6oBHCfMfRmUnulPfte3MX4+S8Y6arE
 7vhJMjQXkfMViyOyei15zjWD4wzrOV9BXFAgXo8+8kPiRw4jAOpQkomVQOQdMM0wHo0K
 3stTMEfavlYh1Yd3A1P5WgyPtgB74HzVyGSaYp+5ypnRTiy4R2UOpg0FxTfT5ReZZ04H
 Yezfemf/UZMx+trrGedRRddLA8vt6/H0OJaP6PRHKQC15jCQe+BVgVQNlBEK/KsC+Nrk
 Wbir44qxKoMQIUallv+XyIoksz6qZKMJDqoB7pROmEUGC3umWsE3kkR0q96L1XtVT9ei
 L58A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnqbTkWNkbQztqZCJcuguXo+dCb8emP+dwpcA9xDW6lycbxiwIMeqC9GYGlg+OpVHLG+kKIqa9vEuN@nongnu.org
X-Gm-Message-State: AOJu0Yyn5oJiHcARRjH22DlD/5CDfa4meR2gM1ESrjZpmlFPPz1Qoiy7
 sMGDgyLR72evaqX9/N33OKmm6hR7EnVzgzIY53wMoXqrDDmSMV5x99m5GouU6P+Denk=
X-Gm-Gg: ASbGncvdR/VzvzGBlIlcHNbx9v0dmkQM4ejWarDj213K0D52o7mvQkV3x84vTZqIs/R
 OSaWNvp5Q/WQDfduQ5AQ1khFVGHa4J+hkLUKV04WCRjHHYzfW5dfyADyBo/CEhTDag5I88BX3+G
 gKz5OnTfszIXVhBpakO7G8YxFlqSkC29xp88XM6yBO36tYp/6BxqaWwX4xm6OzYCFErCZQ1lGv0
 xrN6IzGof9K+T6dZtekIPf8mQod1OQWoF6ekV8PN+vOgQeVUuvKByFKBShm4nQQlqp61yc6EQXx
 Vs4y+dmsvXkBIBFOBMlXsVNB+uZACcu6xkS76AVvtuRlifRacAMrdAMglhx+Jxv2pJpG88bkIWw
 Miw7XtlmwpnqeWvMJyFFGlgSLr2qlX9Ai71cqjDJPYBzGr5seJVu9U6jO2uwWunFwgD7xOO5g8l
 7XIq+8Beda/W2cN8uczgzwtbtW
X-Google-Smtp-Source: AGHT+IGJZGStCCoVg5U1Vfh3jGGEEg7kmJ+akvU25mZyWwHHkVp0QSJCrdvEwDbanQOt2oyMPyr9NA==
X-Received: by 2002:a05:6a20:394c:b0:32b:6f9e:d62e with SMTP id
 adf61e73a8af0-334a85baeeemr18118061637.47.1761001393021; 
 Mon, 20 Oct 2025 16:03:13 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a7664a228sm8553342a12.4.2025.10.20.16.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:03:12 -0700 (PDT)
Message-ID: <c4754279-8cc5-4e14-a2e9-215e9963de15@linaro.org>
Date: Mon, 20 Oct 2025 16:03:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/30] hw/boards: Extend DEFINE_MACHINE macro to cover
 more use cases
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020220941.65269-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020220941.65269-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 2025-10-20 15:09, Philippe Mathieu-Daudé wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
> 
> Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
> versions with less parameters based on that. This is inspired by how
> the OBJECT_DEFINE macros do this in a similar way to allow using the
> shortened definition in more complex cases too.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Message-ID: <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


