Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3C0CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64Ku-0007Eh-RI; Tue, 07 Oct 2025 05:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64Ks-0007E1-Rv
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:50:22 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64Kq-0003I9-2O
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:50:22 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d60110772so60582177b3.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759830618; x=1760435418; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dd3HAV1p80VpWKfyRd4aQR0J95DXAq/zpGcN7qI7ITA=;
 b=nGyLCvIb+1fqerjozO/MyNuoKtKoaLT8VKEYqP1KVmndxs0PoBEStVQooIEm36f6v8
 +Dhn9MCAfZKA4o+zdSbKpEURGZg9Pq1nGcDqTZG38nmROBFQHfvBgBwQ82k2auHWLHLP
 ib6KBFWG5AN72EIxroUjsWU+P8g/18KBHNjmSSBNk5utyhKzNvKLMQMJT3KS8HQ+FwWf
 pFCn4uAQjjUgQZ/9qQIh+g32jXzP4pkj9HlNmAjwbB3QkPjnfDltyDMBH+YqX3XWgvTU
 6eV2K9wRwoQciTmxbd8eEfy7cphWRNJUEHvn+KZSde9BBKENaMyxUXj6eu5tuDW4g9lr
 53ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759830618; x=1760435418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dd3HAV1p80VpWKfyRd4aQR0J95DXAq/zpGcN7qI7ITA=;
 b=u2351JZrl8MPbSDtreDUGHoURvM+PFGUAF/OVfCnIJMfTt3lIrD/qbmMoeHs1dYoZb
 GfWfUUQEN4lFFLGUxZVF8bB1H6Iu05K9LdUEG2NKjJd28XDKIdnBAo9Xve8Dki7M9pOD
 R/O3L7zeNsP7X/JVgWk4lw//LSnYaLz+37Zfe5H93ZHkKECs1TOg31WzbzxTNDkRNmbU
 CIeHFUqD978FNGI9sbJfxO9BOReJzUUBcrqduIaSdQ1wtG5qr9gCpEhZAru8lpBUilZO
 1YluMhieN/S/VZqsDIbpgo6h97S+pcGSb3bRpZsBVkdQLoAOKeyrd1J8cj6b7dNJki71
 rnGw==
X-Gm-Message-State: AOJu0YxSjhxJU9UtFepZAwlReb8QtqszZQDYgntvkLmiIsgYfBPWbzoL
 2b+HTcw0QOR7V4X0KVh1Q5mGTveOgbj9UxbLkMKao/MuShiiOPqx2LtR5YxEmRD59HnTPxe0VWf
 RxTYySZV/G1ui93MCOqU9HIG+WxItkOaYjBtCTMg4xWtkW1ULrvhB
X-Gm-Gg: ASbGnctRRNI2tp4tJEOhmL2UdWKiwYWJpsgyNHMRRfHpQKIEk9ddXTglGQCnPpdoP+W
 /h2jUQH5ei+j2p9yN7V0+2uWBaMvfWi9ncLyW3CvNV2C0IjDxNPQpFDMkb0fNM/XOMzs1+m43b2
 a3otsobf5NkPDOotcrZ3pHrG2cUhRLXJZxvULm2a2gyX41l+HphhSZFslMhws6Hs23NYHHCFIPQ
 QWAL95rVwU+C4raUrGsIADEbnBBnBL5l4TC
X-Google-Smtp-Source: AGHT+IFBSDZaRfUA0PhdtuZfWsUfNh++pegHP6ING5ZFSMqlU5Zr97ceSyexfYE6nBD6OvL5boyw32b+GV3jkA45qeI=
X-Received: by 2002:a05:690c:62ca:b0:77f:90dd:af46 with SMTP id
 00721157ae682-77f945930b1mr244167027b3.3.1759830618282; Tue, 07 Oct 2025
 02:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251001084047.67423-1-philmd@linaro.org>
In-Reply-To: <20251001084047.67423-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 10:50:06 +0100
X-Gm-Features: AS18NWDc_Dwl6juhRQ_ZxETKrD6zuLry2BB3t0yD1C3-mW6O2QHvLSHkTHTmRNE
Message-ID: <CAFEAcA9_Ysh7CEj5UcEadR-mDSGPcBFQN7V-PvkVg8yLLZnRjA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Remove sl_bootparam_write() and
 'hw/arm/sharpsl.h' header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 1 Oct 2025 at 09:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> When removing the spitz and tosa board, commit b62151489ae
> ("hw/arm: Remove deprecated akita, borzoi spitz, terrier,
> tosa boards") removed the last calls to sl_bootparam_write().
> Remove it, along with the "hw/arm/sharpsl.h" header.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

