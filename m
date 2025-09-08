Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEABCA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYi9-0006O1-Uv; Mon, 08 Sep 2025 06:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uvYi6-0006Nb-W1
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:02:55 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uvYhy-0007rz-Bm
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:02:53 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b04163fe08dso724196666b.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757325759; x=1757930559; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JO44p/T7DJE/uGhHBwHW39oIF2aWZO/cZnsQHjtK1BU=;
 b=bGpNunWGDDTzh8QdOEIlr7VA/5z9NAdbshGYyAos3Tjd5bjlnWpI0eJwb4ZnvCGqJZ
 TxvuwchRs7hCECS8iTdQwtF6BEIHbkr8tuDcaSTKQa8lBnweL6G69fjpJvWeXzqDJP3R
 a3XcbICwIfMGmIIF9cjy5x28qgj0BSiL4QNr9+oh3L9zXSLTOQRzOwPdbic6CzBGZDhw
 BkXGrBTYTD3RcCrZfcf0pT3+aI9GmJ9QI17BCaaOxn5idiuJWRxASQVbCk4q4wMBOOBT
 xSDiGfe38Ef3FWpGgu0GQuSj9B7hwZH/wYKjWzg0iEwGohp3ECOw2kx1gxBjg/3jN+yy
 WbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757325759; x=1757930559;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JO44p/T7DJE/uGhHBwHW39oIF2aWZO/cZnsQHjtK1BU=;
 b=dd7lUPQev2YpgAemKn0xYvJrW9wqelUtkMrSQz78ahaLbYTgs/9fsc09xiNbmFyB/L
 16k4fpdm5naxsURKSqZag+nEEMAJv1FZvMul6W8FB896qYyXuA1sjWyyXC1+2PfKVW92
 BpNOoOLDfO9Z4X7OiLs6PmPbr4/J9y4d2wXeP82+aPRqA1YkkZBU2Y+I9BtBL0UVl7/K
 5cJ54HdBVnE8OgnkFU/9jqauz0pIheg3aHqARAVGk1C2s7V/Pf3ZEKvgQoWa7SyQQaRr
 9c6qFLvvUiL46JO9Iw4pcfwZ/FuN5v5H4upgugV1sLQKepi/7RIg8ak5KOp8ysFm2DHz
 ZI0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Rh/N8j4vZNH6E2RkCyM8ZUylmX0dWu2PSHwKtCsY6b9bcDGTg0QizUV4qvkGOAuWGbbFAvC1ABmi@nongnu.org
X-Gm-Message-State: AOJu0YyqXr0YWeCNt+TSBjvcZ7sHvQL+y1gJYLDVSzHzNxp7DaZ5uYpi
 WyxBeh/HXq4IbdIFLDgJVTet/LKe4R/KwySgvXUhvSIxIpslnzxVpe9HBwenYq1sbPK7NzvsH9X
 fBM67uJrVv2VUDih1jJi00fYNrTX8neVsFF4imvZgqQ==
X-Gm-Gg: ASbGncvapf+jog3WW5j911+DCaKpTj5bwDJhsMA6k4Xjea6szSagOMUQAZ8fRy5e3o7
 S3mfy9rXfGPEdxcwjNypldmmC9kMlkzPa5Xb6ozF0lu48o07+D6+cnBpU+uzqAeJFyEiT1a/5hJ
 Hdiyo2Y++o2rvjuu0YiQbVKwa8wlwmhbNETLspo1zyl4BENeeC7JY745ObwJukcR+nRtnla127s
 P7+TBIG
X-Google-Smtp-Source: AGHT+IHKkMvZNSM+d/mw2mhhq7Oy5KnjzpnzYWKRN3cBAlY0dJmNCf2VbNF54f21uDK1fJP5iksP0vkUR6if8cpIxtQ=
X-Received: by 2002:a17:906:b3a5:b0:b04:6858:13ce with SMTP id
 a640c23a62f3a-b04b1547825mr555298566b.38.1757325758335; Mon, 08 Sep 2025
 03:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
In-Reply-To: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 8 Sep 2025 13:02:11 +0300
X-Gm-Features: Ac12FXx3YY5DxozR-9Fhf1L-JAu-mOlBxxKUp6PE7h3fQa_ukCDLXxzCHjxD7Wc
Message-ID: <CAAjaMXaPM0qrCwrMY_n531R4d5X3h+GjRHKzjHLeY3FprT5_TA@mail.gmail.com>
Subject: Re: Rust high-level pre/post migration callbacks
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nondevel.org, qemu-devel <qemu-devel@nongnu.org>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Paolo,

I'm not familiar with how migration works under the hood, but this
data transformation design looks very clean and neat to me.

On Sat, Sep 6, 2025 at 9:45=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Hi,
>
> based on the low-level sketch in Zhao and my presentation,
> I would like to propose this more high-level implementation
> of pre/post migration callbacks.
>
> Instead of dealing with pre/post callbacks, devices implement a
> snapshot/restore mechanism; this way, C code sees a simplified
> picture and does not have to deal with Rust concepts such as
> Mutex<>.
>
> Using it is very easy, you can just declare your state like:
>
>      regs: Migratable<Mutex<MyDeviceRegisters>>
>

Hm it's a shame we cannot do this with a trait since it requires state
storage for migration_state.

A suggestion: we could declare a "mirror" struct to hold
`migration_state` with a Derive macro. This is what the `rkyv` crate
does with its `Archive` derive macro and trait
<https://docs.rs/rkyv/latest/rkyv/trait.Archive.html>

