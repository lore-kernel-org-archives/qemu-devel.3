Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BB0C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYPD0-0001e7-Mu; Fri, 09 Feb 2024 06:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYPCx-0001cf-S2
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:38:15 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYPCv-0007eZ-6i
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:38:15 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d0aabed735so11578361fa.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478691; x=1708083491; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCFjZ63NE6kiKIue25LSKxMqWgDxTEwFg2x09lhs4q8=;
 b=caB8b/y2YnBqyKhcl8OEzGb/6iHgLQ40/A1iAz7PQLhnAoSTDnlq6lrJnKqfHXoIp9
 TQ3F7Oy2hxqafMAK/81CyxwqWOEsgqmf44Y2HcRhQGPpW2JYkrsjO4E6DtZjAk7EyDH1
 2HgraKqNE2Gh69cwSvOM8C0NuzjXncj/6wfX06nyc5J1+lC2C7zR4Z+6QcOGAHht0Qi/
 zJH2YP9/mDRgufivlNDsXO01r9IH3x/iQz40oYsF4r4qdR+Vj+Ml7vjecyCNYvc4OCP7
 bOpjAH9caGoTgDn76tgvnXThM30JTCdo58U4Pty2oQTceT8A+Y+C2l4CyvtMAE5eq+qf
 IwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478691; x=1708083491;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCFjZ63NE6kiKIue25LSKxMqWgDxTEwFg2x09lhs4q8=;
 b=GlGYqeuFrHEKtXHDeHRekTPixd8A0qH3vsVpMl+7fE6xRyUYGY25hVEadgOe6DBA6j
 XxkyW2D719QPaTPtdZPmVFHlQCrCJJYHMq6vtLybwbnVUac2N+u2EFyAeIHGFzsYp8LD
 NuyvdYTueBh0aosmaSFFDBBvOkCwzwBPrGs3IZnXBvIYrDA1L0h5ZYgPoLameVYsygpt
 /HU9DrL3+jQGdc5tK40cftql7mUH9dCRUlZsdtscBw9j1WTbXUS3hDB6NePnHJhqAdCS
 /MFzDlNWZhg0TEzkjc23OyE461EnlQfwAF3aQtZCfKOdwjATZ4S6aV7dJvfi/stZUHW/
 TcSQ==
X-Gm-Message-State: AOJu0YzNK1KS2RDcJ60xRRMgQQKb8GQECWepfIzRTzducmI/EZtQwhkG
 /z4NPJdfwIiNWdjIGtt4nAsGjPwEg6pUYkmK2yvkC3s/s+dr35s6DKzId0N3zLU10LeP6BiKA2O
 CklpjwxGNp6gJeghXm/EFUH+2ObgyOrXo2MKqag==
X-Google-Smtp-Source: AGHT+IHUy1PQ4fx4xqjQTx5lJVryV6Wr4PGapkimMRUDdKQ7C1q+X75yd6Oyvbx5RoTgf0nVXCMNVSvhqeQy0fc/HIc=
X-Received: by 2002:a2e:8814:0:b0:2d0:dfa1:6f53 with SMTP id
 x20-20020a2e8814000000b002d0dfa16f53mr944808ljh.43.1707478691519; Fri, 09 Feb
 2024 03:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-10-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-10-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:38:00 +0000
Message-ID: <CAFEAcA9OeGDCR5F_4DMhZvk1AFgYUG0VuADkZj0ZNhNawTftcg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] hw/sparc/leon3: Realize GRLIB IRQ controller
 before accessing it
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 8 Feb 2024 at 18:15, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> We should not wire IRQs on unrealized device.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sparc/leon3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

