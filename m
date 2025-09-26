Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D97CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27Cy-0004MI-As; Fri, 26 Sep 2025 08:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v27Cs-0004LA-1d
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:05:46 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v27Cl-0005G9-6Y
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:05:44 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-635380a4a67so1925131d50.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758888331; x=1759493131; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ik/pSOfUU1/PyrCmMcjuy5Eq3q6NiDXKe4C/iLknJs0=;
 b=MDQS8KU8jlVM3IZKeIkFN+hA/JoWtz5cfl9R//PnPPcx+C8krbV/ygs37U26eZOQ+d
 Edm1jSrb/7Zk8pAuO2+MQ1udfZr418hb0YkFpv01F7xjBGkGIhg1GORlQ0WCkzzCmYjT
 bWqLAdPH+7yLLaTLNRScnfKMHH23dZntxUh/D/7DVtwYMjbQIAr4jaKxMOjr954um5Jg
 QEfswNYacjxzjp/fANOyeLMMaZkIgMN2ojJJ2xwkq5wBdqL80NO0jjF5Yi+eX2JZheOT
 AJv038ToVBYrbl0b3lQBmZYh1WfIg5p6829gACVIvXnJCu+YsQ06Ur2MmaQO2DHNp6aX
 SkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758888331; x=1759493131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ik/pSOfUU1/PyrCmMcjuy5Eq3q6NiDXKe4C/iLknJs0=;
 b=pD+OUDBh+U/reORJB9AgYH8e4hCh+xrcwc5hmcm2ln/XfObC2eNpULQvlPkEnfBJby
 IeLE1/7CzRFhUpUNyqAybRQd9UhhjKJvo6vS3pgLPLQ6DK7yAEp0h4O3ErHVf/R3BMkb
 c6B5rBzZVXndhQTnRuRKpQF2TBwysY4M6a9h/qehd/DddTZ9GqpVpExziJXK8dCRbOR8
 l1w86Yi1Ctw03H5nEporR5cetYuZM0jAgPqfjV5wuZpHN53ZhLX51Ly3jrGApvUrtAxo
 rE5MqEdLY/ijyT0lOVabZZRueLLlQlyVnA4GB17yIqcAcFplKb/N++jfGmhlYWh5g3QK
 gsHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxSbbkoQsPEirQrglvImRpc7+TOU+ThVELj/z2SAsTVbSrXWR8g9+3TWmC0oiHYwE0DhNNbEJe49Az@nongnu.org
X-Gm-Message-State: AOJu0Yx3KV4InavkbZ0rZIM3M95ROIUabYT7zteb5gXOMy1pKm54MSl9
 I1toO1jYt9fR0BzrCxCzUocp3VznhEAu5F2NhFVt9sinElc9Mm2TGn5KaVFu0ldxLE65bJEK8GP
 WAhCnWkb08+G4FiNk5W3lXAMVzPQbht36jYVOktumMw==
X-Gm-Gg: ASbGncvWUXZN1tzU6+eZ5c90etWE+bNsAd3EdifTAQXdiebSB8JnZW3d/Cy/XHKrmEa
 EW7icBXNtzUbWqN6fPavtX51PHTKpuQZrZlfNvaGLg+m3KADLywhhafVUBKHH8woIUsGDubSHxZ
 XWLQcdqEUfyWKwgq4sIEn+9mKfkbh6Q53/w8aX2VLLcQufl2lbZd4GGhprYRsMcLXx+dTx63nvk
 yaaWYtDYeMdeVn6TFeFA61cJsOvNg==
X-Google-Smtp-Source: AGHT+IFmeCWkD9+zuTSAR7e/5IDRavOtkIpURleTnsiyFxyn1DZTPV6JVkX9/9IccOmlGIFWEEp+jvPyPoWwIXvF7jE=
X-Received: by 2002:a53:d486:0:b0:636:d286:485e with SMTP id
 956f58d0204a3-636d2865083mr3663236d50.0.1758888329528; Fri, 26 Sep 2025
 05:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-3-mark.caveayland@nutanix.com>
In-Reply-To: <20250925160453.2025885-3-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 13:05:18 +0100
X-Gm-Features: AS18NWBs7iEil6qkfTbn3fx1cG5mxMkgHIRlmrLENSjRTQv2yOS3JfuN8l3WwcE
Message-ID: <CAFEAcA_w1QkHACeb9y6GGUOPunu1YHYVQQwat4zdFWODG3u2Nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs/about/deprecated.rst: document new
 restrictions for isapc CPU models
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: imammedo@redhat.com, philmd@linaro.org, berrange@redhat.com, 
 jdenemar@redhat.com, armbru@redhat.com, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 25 Sept 2025 at 17:07, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Add a new paragraph in the "Backwards compatibility" section documenting that
> the isapc machine is now restricted to 32-bit x86 CPUs, and -cpu host and
> -cpu max are no longer supported.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  docs/about/deprecated.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index aa300bbd50..4c7000650d 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -514,6 +514,19 @@ available firmwares that are using the current (wrong) name.  The
>  property is kept as is in 9.1, together with "riscv,delegation", to
>  give more time for firmware developers to change their code.
>
> +x86 "isapc" board restricted to 32-bit x86 CPUs (since 10.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The "isapc" board represents a historical x86 ISA PC and is intended for
> +older 32-bit x86 CPU models, defaulting to a 486 CPU model.  Previously it
> +was possible (but non-sensical) to specify a more modern x86 CPU, including
> +``-cpu host`` or ``-cpu max`` even if the features were incompatible with many
> +of the intended guest OSs.
> +
> +Now the "isapc" board contains an explicit list of supported 32-bit x86 CPU
> +models. If the user requests an unsupported CPU model then an error message is
> +returned indicating the available CPU models.

This should go in "removed.rst", I think. "deprecated.rst" is for
things that still work today (perhaps with a warning) but will stop
working in a future QEMU release, not for things that we have already
caused to stop working. (And we should only go directly to
'removed' for features that we are sure nobody's using, but
I assume we've already had that discussion for the code change.)

thanks
-- PMM

