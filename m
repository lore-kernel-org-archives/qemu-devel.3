Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48295D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByRC-0002OO-DU; Fri, 15 Nov 2024 10:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByRA-0002O2-9R
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:40:44 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tByR8-0000Eu-Kf
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:40:43 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ff3232ee75so20994031fa.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731685240; x=1732290040; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4/qPaRuvXJi3c3Pg5/36tL47IsoTPpDod4rHoX+HA4=;
 b=uet5wdUrk090e4sgiiEUJb5e1AK3nKUIvxI/XmFkKXhl31kGsn3K4yVVR8x7fst+Pe
 Fwu0Apm7CfHGWnbZ9lLRPQ9c7ycNk/arKPmhADdlvvOmRLmXvo9XxAUHrDfSaPtmADDX
 2Rc8kpMsY3Qcd7vl02ueAQM9ojNp7yrLQD6NxCmq2v9h1w+PHLh7hIJqjW3hou9Nx4oc
 mq+ZSA73hBLqArRapeAcizJN0ZBbBe5o/+tR3F77PKckmR6pQ+MOEf6B/f7xxWu2P58U
 /SYtO0vmNkp/iHYrLkSDhhf40ZdDehfdDmkyXe+90J9kFAxrdG1iZc8x9vlhb3emDtpt
 8kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685240; x=1732290040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4/qPaRuvXJi3c3Pg5/36tL47IsoTPpDod4rHoX+HA4=;
 b=HAAnGMl+NuoPtfXNWWwdjiffhFtEiGN2MSk3vz1ncep9XfDVMW52gq+k1RbhuXcW1d
 rAKtjPn8MofIxkPhMD1z/2IpgNdyej3WHWnHFlQcgNdrpoV+UIELSejcEyvAV2btoZfJ
 QgaqFLWVQoXOuj85sedhB1J2oL7oWUnduR+nvplxwZQSHfrICrFxKKp31W+mrCj9rwP5
 vl0/PAyandUj1o6pXS27KL13dCsfG6+e8flathEWE32nmtQnH6MX//haOkX1LexE6vLI
 De6g27hVzPecRwnOzXWIUT1HLBz09k8i2+dk1gGc0deu0vJqI+uLxVfsApmf/ciwg0Gv
 gjfw==
X-Gm-Message-State: AOJu0YwVbt8ghX5Ayl6kML51amgCFAQ0q/zxWve64XB5dABGBL41kuvM
 6JMQl8jSnKL8+suUq0G7oSqBMM8vCRxdowhY1xsdezQ4cIHfpo5FQGXefqu8bgbvrfKqf1bKzuU
 t3GUP8TkQy6r7pJgODoYoG7NIKT/7/NpzF82nJw==
X-Google-Smtp-Source: AGHT+IFylSYs5m7QLTCv6xv7jfPyQLN479kym/VA0T4MjKxU6eCj8ZPIQLcvuEQJsZ6uz61MDIXmLDOYUErqBw0eMGE=
X-Received: by 2002:a2e:b889:0:b0:2fb:5014:aca0 with SMTP id
 38308e7fff4ca-2ff609b4c8fmr19741871fa.25.1731685240525; Fri, 15 Nov 2024
 07:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-3-philmd@linaro.org>
In-Reply-To: <20241115152053.66442-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 15:40:29 +0000
Message-ID: <CAFEAcA_YcAMB4DPRaakL-bNq726oTx3-W2GNuwuE2KN5pXiUpQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] target/loongarch: Declare loongarch_cpu_dump_state()
 locally
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Fri, 15 Nov 2024 at 15:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> loongarch_cpu_dump_state() is not used outside of cpu.c,
> no need to expose its prototype.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

