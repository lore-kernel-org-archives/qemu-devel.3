Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5613BCD4F48
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtKI-0004W2-1K; Fri, 15 May 2026 10:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtK3-0004Ni-KO
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:15:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtK1-0005Mm-Ig
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:15:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso7705132f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854523; cv=none;
 d=google.com; s=arc-20240605;
 b=E2SBBi2lh23kLJVo6ne1m06if8LjyJtobFKB2nvB/5lAtIn4VAGYR38CuyG6EAc33R
 FlC86mi32Fr2ZRIU/977np4MLO9yyw2PS+lM1vNyAN+TLIlLoM0NAbEjmUTGpO4VY6hU
 7XxNc+wPAJV+BeG/aB7tqOGbm/vfP/68scVLgTLN7Sb7ovDod5NVT35rsSVRdYFS18Ec
 qczjN4ydsJhyNWb+KEkhN7J89DoWnAU+SoEmOUTLkmo9DFNZynZQ125JMtQ6cZkEwSE/
 vpf0vPZ4kOHQjx4j5xaOUFLA58u7GWuhdfiESvT9iAxHTlWUJphxASfQ9nQDdpm9RQOR
 /YKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KpXZHB+kDlNhT0NyY42JfPpcBVeskn/dfBQ3/alXHXU=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=TWMyHo9FEUnHRr+pjPs9pkEWOYLGaTe9u5PclEamACOwL2/GUlbf4g6MDAnlHajye/
 bVftixSnSc+JA+YvnRi7zK4gRZaWzBkQUugAGk2pahs7tX3RI2NAg8pgvGeBs/cupBRO
 VhK9a8IbYQqwQMBrOltwzuxR7M4thZ5SitPjMBi5qn9BzZmpnsmBYDXASN2Qdf5vrhTC
 9eE2Mm/lCpc9Xcs/VNIEKA340gHZiMne+ZWo/1SKrYad+KrF9zzoHj+vDdjT58oKoA6D
 T1RKwEsRSoihoKFTf/gZjNpG0+CnRngEVncrlYT1Lwm8QCU/tMFNWmXY/KqJyCW5GQzw
 tn1A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854523; x=1779459323; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KpXZHB+kDlNhT0NyY42JfPpcBVeskn/dfBQ3/alXHXU=;
 b=MD71SUcqW/QN8lV5kDnCo5lTj5Oyjlg9N8LxNA73+tiKVZuQXTGTFSNt5wfMLYnXc2
 mH6eGtmhm48IvF96JtLpu+eKDwR/n8pCBOZoY9ddFtKZw/pSDXAZJgM5GiFPR9eYBKxd
 xpCTaN484Ow5Lhn2e65QIaMh0/d22RC6nqRaW5pGkKInj0sOMU93aovdF9glL7ua3Tln
 7MXtOS7pXQY1tYHPW2JPD4pWUA92EgP/3gJx7P/8CaCHzZOSreSFl7JN1JrIGnXWfMmk
 d4ObxLtGnG3Ne+HLWCtsuMtH6qWbE0umUSTPHZIpYhzrbMODr9ZzTG3Wrd0Swxc5UU+v
 B5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854523; x=1779459323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KpXZHB+kDlNhT0NyY42JfPpcBVeskn/dfBQ3/alXHXU=;
 b=GbXxjcVX/CReyqILVW1ZLbO1G9JftDBzA38L46ilVq6TMXS6BSnPiIzvH7it9F0Ifz
 cP5MeQzeWdkf/DTyUd9wKL5ejZRg8PCowhVsEIRkBXcjCtOlnVQ27Gaz9KE264d+HGDo
 ROpLEY+2Pr7q05K/13SjkMHT5z9p1uEoFkD3Ilm51g+JM/Ud6S0JhV2nINSevBs3aoHb
 4f95cRLI3dFkouKOpNjvij1COccmN4SURg9MUFzhdNl1QQlPVR9UPrDelkyDlHBBhMv0
 myv+mqEWEt3+j/tSAa3sqRBf0WhzW0hs84hwwmimemPAy79A0azGP5JwqUh0Dp7YOU2T
 slWg==
X-Gm-Message-State: AOJu0YyAugs6oqfyxH4dHHvVlroXo20xSKtAXacp03C+TW2jeLdNp2kN
 bxulDQXdH3RqzhZNLHROpjNb79UvKz6MDaOoTrX0KJ2ohPMEpmSsDPVS+nf1pYrL9Ju0gW5VfEP
 NPrOxoj28u3YlACXvGZ6O4IGYuWw5V2V8dc/3v7qZ4Q==
X-Gm-Gg: Acq92OE2jDrW2+wT1qud/dxbNVLxpDaJJPdY32apLXrwraiz4a3j+mmv9CI0bDYHVff
 ySALv9xplJmmp6qETTmeB8l4CmJg8zzaLri3NhAq0CqFNO6zNEh+F3Xy8uz+Ua6xnvQ4WewtDLr
 HJxJJyotAKjYT+BafCPG4C+0CfuEyC3WYSNrOQBJGzgbYEdz1xBeAJTQR+aaZCsXKVkHM7ArMhZ
 Lp58iJVu0tX8a7l67pVBq455MSrjixdk7lmETj9ta+5/2nHIhpSsJJVqovewmUtecsNvKHC1Ns2
 6cq9xDjes5s8Pix5JHImEZTYlUkYnmrtnGn1oAllkT0qAasqcg==
X-Received: by 2002:a5d:5d85:0:b0:441:2335:ac3f with SMTP id
 ffacd0b85a97d-45e5c59f46fmr5588686f8f.31.1778854523383; Fri, 15 May 2026
 07:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-5-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:14:56 +0300
X-Gm-Features: AVHnY4IxwooRJB8jhnP3pElR_5TuYYNfIw8UutdaZgwIQDOpOMZH6MnuQbP0Cpw
Message-ID: <CAAjaMXaNxSGQqoRaYr7FFQmH__9HvFoesUd-+h5u8NSnX7VZZQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/20] hw/arm/aspeed: Initialize 64-bit CPU types
 during DeviceRealize()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Fri, May 15, 2026 at 5:11=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
> CPU (Cortex-A35), only available in the 64-bit binary.
>
> If we build this file as common object, these SoCs become
> available in both 32 and 64-bit binaries; however when running
> the introspection test on the 32-bit binary, the init() method
> tries to init the Cortex-A35 type -- although not realizing it
> -- which is not available. This can be avoided by deferring the
> CPU type initialization to the SoC DeviceRealize step (this is
> safe because nothing uses the CPU type before, only the GIC
> access them, just after their realization).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/arm/aspeed_ast27x0.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 87dcb82e1b0..e50125bfeec 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -418,11 +418,6 @@ static void aspeed_soc_ast2700_init(Object *obj)
>          g_assert_not_reached();
>      }
>
> -    for (i =3D 0; i < sc->num_cpus; i++) {
> -        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
> -                                aspeed_soc_cpu_type(sc->valid_cpu_types)=
);
> -    }
> -
>      object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
>
>      object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
> @@ -701,6 +696,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)
>
>      /* CPU */
>      for (i =3D 0; i < sc->num_cpus; i++) {
> +        object_initialize_child(OBJECT(dev), "cpu[*]", &a->cpu[i],
> +                                aspeed_soc_cpu_type(sc->valid_cpu_types)=
);
>          object_property_set_int(OBJECT(&a->cpu[i]), "mp-affinity",
>                                  aspeed_calc_affinity(i), &error_abort);
>
> --
> 2.53.0
>

