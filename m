Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD78C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZmQF-0006sf-JB; Thu, 10 Jul 2025 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZmQ9-0006oz-Kc
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:14:21 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZmQ2-00071E-On
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:14:20 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8275f110c6so476729276.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752135253; x=1752740053; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1IHzzc6C/yZZS/WhRHD3wUKG06scagrHJZ+IrHZ2gYY=;
 b=vaiYy7bcri50ysGZzNosMhzMf4W285h38cQPMTl99xJHv6FZFNspVgjlsDLAFZsi+W
 RlqohDA/CVNUXv0uHygNPodYRaPwNLOi+osraVFrt21TYch+m3OuEMUjFbQFfa3xS7cu
 DEVX2ExNzAmLHicE4N9cg8rfjp8/y0i1ZKr631gC6VeXAJknK5l5GkXrv8VqhitYUEGw
 yZAZ6aFlMuLioQ3IwTwmB94OshGvIR27GERvPMKKKOo66znrJzvT8ZNhlTZIUfIgEYwO
 2+XrndLNGENEpMmbZsCVie//fqD2JrGvlPQfCMqRmxqnWWVKtTdf81XyyQ/9h3Tgz7Up
 sVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752135253; x=1752740053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1IHzzc6C/yZZS/WhRHD3wUKG06scagrHJZ+IrHZ2gYY=;
 b=BjfbiKyiwFWUvRU+IkxVDjNdqlhoPGEuTof/T98ml16UBfVkGaSo5E/qy+T0qrYlkx
 ztq9bIThTa2s1HY/BKlhxdAVMdfT1fGdmEUbmEPXNlqZ/es+wJbb4P3bPj+24Hmcenc4
 KD+Qti5uZKFyx4ZAsSyXXkZHUEfVgcJNtTapZC+62I5evnagvol1elAvsUROym6P+/u9
 qyvJC8E6lon9BUlHYG9f3LA9ozuLmb0E1J4/58ZbPtMnCfZvJDz9yFsoSbT9AmAvZAZw
 W8tuz0q4Tr6U/53p6pyc5eM7q4vnPhy7F7PTlL00B8ObXyvwdrV/QlLm/JMnIWO7UGM+
 ouqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHdqxsi337rud0S35l/BDXzt5lh8w/L8WIaJtTNcZdZmNlSD2d/dISxoDfC1XrdYV9pfNBDd+iQVr+@nongnu.org
X-Gm-Message-State: AOJu0Yys9ki+Tmsa+6N+jU0srWTv4z6cyB8dtt+6IgszICmxSpXqmCaL
 2SwDo1Hic60NYm+EuosqWiI0zhcRCOSLH8bozdoXQz1IoLfDM32AFgw6kgQfue4OPv0CJQyocQy
 wHM6WDfN0XSc0fb6sk/CkKQBkZ52JJjVR5n5dgWd/gQ==
X-Gm-Gg: ASbGncuVCrAgSCbkgOT3HCl6jW5y4eIYloBmiMQ7LRleCzZZnJWzhxuRVqVOARG/+XK
 cjjWfyqKVtitE+ncyA1OHAqVMST6ZVKjLWuOlk5ssXHpCppds4dBTeq6tyMd4j83p7tEJ5lLzSM
 bAExdJU1sh7lfCztcYWrC0Dw/0V7CHdl1RFWy3ren+4VXI
X-Google-Smtp-Source: AGHT+IEgRGMavqkmnEAh3ihnMRKU1o8ECFl81+banPmU9m89fL6tfb6875f+5JJ1n/NG+v7t34OLobrmFJyyH6NFw5Q=
X-Received: by 2002:a05:690c:6908:b0:70c:a0c9:c648 with SMTP id
 00721157ae682-717c1774a36mr42990637b3.19.1752135253020; Thu, 10 Jul 2025
 01:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250704141927.38963-1-cohuck@redhat.com>
In-Reply-To: <20250704141927.38963-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 09:14:01 +0100
X-Gm-Features: Ac12FXzWdUoz8j8Zll5t6-ezJ1-6gAtg-cJJQOot_KDGA2xDn0vcyWA5YAWecfM
Message-ID: <CAFEAcA9yv-BQQ+3JpiaXpYf+gc0FVKsOy9Np-3BkR+UvB7Enhg@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm: followup on the ID register storage series
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Fri, 4 Jul 2025 at 15:19, Cornelia Huck <cohuck@redhat.com> wrote:
>
> This series tries to address some low-hanging fruit on top of target-arm.next
> (move some more registers, some cosmetics; see discussion following
> <20250617153931.1330449-14-cohuck@redhat.com>)
>
> Also available at https://gitlab.com/cohuck/qemu id-reg-fixup-v1
>
> Cornelia Huck (5):
>   arm/cpu: store id_afr0 into the idregs array
>   arm/cpu: store id_aa64afr{0,1} into the idregs array
>   arm/cpu: fix trailing ',' for SET_IDREG
>   arm/cpu: store clidr into the idregs array
>   arm/kvm: shorten one overly long line



Applied to target-arm.next, thanks.

-- PMM

