Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F323AC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUWm-0006vh-Br; Mon, 26 May 2025 05:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUWj-0006rJ-LM
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:53:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUWh-0007Bt-Ck
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:53:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a3758b122cso1230593f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748253224; x=1748858024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=85HDzICi/6ar20bBTGjSM63t/lJ0Q1zjjkaB0LM00M0=;
 b=edFwPYBe5zeeNJkToZ/uuOqvB8pN5dX37+MDuayfctU3CnyQj1YM+1UwU+cajBT3NP
 0PDwzqV5Ea+eF02Cp+IC3GM5tv7O9rGpbzpsOz87C8bcqMn7fiviS/rBmWAdoUN/nVv2
 KlM4SQjMMT+CrTWTvE/f3Cm7x0ezCSt8bNRBEArmCYo9GbQoEpKCq17FByxjDfHFi/a4
 zcbyM/Y1eN4DvUch+ymphSjM+zTciLHd7Z55KQ6eQKbuoc1XF6qa1frI3ws7VwBzvdhg
 f4qINBHPk8Tw2MoaxUVvjIcvePteaYPakEDuRvbj+yeR6kkm2KqZq6LM0le6uSO3vh9X
 njVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748253224; x=1748858024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=85HDzICi/6ar20bBTGjSM63t/lJ0Q1zjjkaB0LM00M0=;
 b=GHF7mbE0X4YsSoDeHVQcXmriZGuQLRnCIYcHJySLxoq5h3ABqxUhUPBHs4s5EABTtZ
 +v4WdQyPOKurnSY+AmuXJvTdZoolsAUB8RdL+9fhUvcesxg8ni8EJZ057RP9nl1OBVgH
 Jr54XBS9Q4Rqv4B1y33j9MTeylwEmZmw6LeU3y0pzosBaNrc+bbKyhUupEdVBNhYC0nl
 bmr+yiT6KTNJ+HRrQKAv4JpicBH94n2WFsf93map9AoCWopt/ioDvVLsbQql0W3bE+JE
 HhAdcZKqD9rVrlnXerCIzWKxUIPSA5wuPE6FqwlISD3W3K0wZoH1bRmdHSHUcGdY38vO
 5a4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGzvXs70KIvxfgEB4k0qmtHEuEcPuLwE1zHjCKmiD7TP/dTb0iY79XJI4F6vKt791joc8cl36wEwFX@nongnu.org
X-Gm-Message-State: AOJu0Yy55Nn3PQRcKhvETSVrW4q1GSZSqPFBvhSOvrD18PsB1QRX8NFS
 s8c08Mh1WVchkQOlx054W0aL9+jKQea57mfcABj7W4r6fodv/sCfW7trbbsAQdiXvWI=
X-Gm-Gg: ASbGnct4wDw353SqE73Lk6izo6f/9zOnf7cS4xFknZyO0O4PJa22uuE5rBiSkay6J+w
 4x8K/HfgP5PLboDbbALSZCv9qk4ga7dQ1J9i5IxyNTaD2Q29kwPaKoE5PiaN+gTmBlFTHaJ7Hc6
 UT74sKxJn/09L7yssmbSbaBjoJyTrjPzJaQUNU/vI28062/eaeKZv2HHlF/aVgl/ChWkyUPTEVp
 szxolZYonk3sPem0o56JzktSxhBhrXAdd61T5qXTlMqg6Ic2wZIRr5dCubRLqmBd8Me32N7t/wr
 xoADxV7zDmusJA1ukN5L5f/kzj3ePplJ3ieLQUkzP8g+DwyInhS/UQG5CI0Gc9uepe67iFtW4I9
 6Khnw1Q4ezV8iCU9ymR8gagKq
X-Google-Smtp-Source: AGHT+IFY+RK7CtLVqOmChjcupJxLU0JzHdNsoc4ubNdkbQoIRuVY3Kf5d+xCOB/ceMYHHaoDPvDX4A==
X-Received: by 2002:a05:6000:248a:b0:3a4:dd02:f724 with SMTP id
 ffacd0b85a97d-3a4dd02fa8dmr989808f8f.43.1748253224245; 
 Mon, 26 May 2025 02:53:44 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d3332c01sm4579866f8f.92.2025.05.26.02.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:53:43 -0700 (PDT)
Message-ID: <467e47ca-9cec-4c07-aeb6-4ac94c00563c@linaro.org>
Date: Mon, 26 May 2025 11:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] single-binary: build target common libraries with
 dependencies
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, thuth@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 22/5/25 00:34, Pierrick Bouvier wrote:

> Pierrick Bouvier (7):
>    meson: build target libraries with common dependencies
>    hw/arm: remove explicit dependencies listed
>    target/arm: remove explicit dependencies listed
>    meson: apply target config for picking files from lib{system, user}
>    meson: merge lib{system, user}_ss with {system, user}_ss
>    meson: remove lib{system, user}_ss aliases
>    meson: merge hw_common_arch in target_common_system_arch

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


