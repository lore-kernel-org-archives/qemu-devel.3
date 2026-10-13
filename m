Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB9ACC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfHl-0003kF-U9; Tue, 13 Oct 2026 12:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfHh-0003jn-CW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:23:25 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfHf-0004Ed-Cg
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:23:25 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b05bf699easo23469467b3.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791908602; cv=none;
 d=google.com; s=arc-20260327;
 b=M55KrwkwTEhouPmkYkCquEmzTy6YDe9XGP1lAmEGGPifv4T0/At8PyqdzVojXhdiWG
 IGqbS9zw3wuBVwq0BFuX54XbbVohBK8lf3j3ZJwgHtiu6+768253Seh99JDEwnR9Ws9D
 WJq8lH1LHUf/7Je6LkDKrKr6DIKu1i9Hw1qRRIeK3QyYJLoCUtL5ZUo7GjYj++T8A0dU
 ynXUb18qwXjcGtygTk3wMg/uikyP2AFUINJruMtOOgRDvABothe8f56akPnGu5ynCQXr
 NKkfbXVzVMcQjy48nHN7iT5KKWc8dnc68PUt+CIKID+iCf7aSFtcZ74dZkEaFLe98ziZ
 LL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0aU3xZ0O9qtDwjPihhb4Xe3w0i2uTKvAQPFqDUeHH/o=;
 fh=0qYOTldnrw/8zq2kAHRwGFzDGIoITl626PQDkdqHaPY=;
 b=TRWRg4bf1eZkTLD8qIgR27cB1Pf/bL4CTFRlX9pwT96ZcwyQJKgB+dMmvunDvHvK2g
 cbrBaCJ5YoscQkooIPSBCfYbWCbyg7IRRuv7eHxaZjCgjC8Zvt463Ba1AIItR/g4FroD
 eXd+6MfwXyDhgeJ7PiMxp7r8xHP+yvaThl01+sMLqGqlEmQd57Cn17XWlkj5kW1dcGFI
 +uf49cAf6Wc9+2Dwwk93hwYjnbzVEGyFGG5mU6+fnuFbOX1/EoS5PfhyvNFmund45sAR
 CrMHqVbUeacfeWrH7Zhi/1A1xC7tJn7vxz5GAuLQ1q/i0wu7jcyOImfI0rJWkTVOf7UC
 38ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791908602; x=1792513402; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0aU3xZ0O9qtDwjPihhb4Xe3w0i2uTKvAQPFqDUeHH/o=;
 b=C1e+ItBNSnR01CcSO5TEaEO7yFo8V6Llen5osWR33APYsPg/DowKrh3Bvvrpzs50br
 oKG3aKxgPyre73VdSnQSr+DdK5X3fyT39yZ07eY/wS+vvKDWF8HRddsVN5kYKtfeaqel
 kR1a7/PqVwPBfCrUcTaU4UFT8VTx6f7xSbWCvYl9OBF/8LcGQFPl5ffr1fEk/CSsQ4q8
 3fpm2u/xnBVE6I79P1K72Dn1qxKvap11NU9ykeAlWvPQb5Ak4fb9KQMkN+oMQAJkDY/0
 Krz9c7ruQ27i9gisteD6OCcDNj11E1UaxV/uinZlC88g5WNrd7FETsdIFPZjpFU4Y9c/
 7sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791908602; x=1792513402;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0aU3xZ0O9qtDwjPihhb4Xe3w0i2uTKvAQPFqDUeHH/o=;
 b=dLs/ZQtvHGDk4JB9Jm/9ueL87ZTuvss0hQ36biNJJNG+8qmEGZs4V+jspA7h0mBDCn
 MmS44Jht6QNlT+AmphMpgsGRDu/YX9rlGMTl8K+pneDYKNYkpHi6vtvT5YhtOfvv+AXe
 UuNdBaxQ9vCmZw1/AAtIOuoDfQApeslDkspki0WZQOva7J3gXvY/A53FtlFAX4ywdDpz
 JGHXJ189dpiHQYM1cmK3t0aTuF132lJhpaIu6A+F0DA9DxfiNL7UTR3+ldNofzsClox9
 txl4scnMsw0ncTdGhrf/stMRxRU4dbh1NqpUg/yy06NOg03tUFaE9tV0rf2kVtsG3yIh
 ynYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEUSrv/nQVfqwZQLaaGUH2DgTe11qaoPG8xK/Qy6OhmsoSyJRU3q0PyXbdG59nlsnRL58Ee5CTpI/A@nongnu.org
X-Gm-Message-State: AFq9FYJL7daMLdiIMjWTL38B2Wph8EZ5LPWCfnYl6sd3HYQPr4bWWrnQ
 Cd2u3B/KNyqLGJPUYGQ+TYIggwaso1h0SRgyyge8cNgbXXy876CmZZcDCHXZcanaxHHSrXrjeDL
 lQPb6oYyXBm2fKBytxVkpIL1bju34DO48O67wN/SYOA==
X-Gm-Gg: AYBFou3wlz3DIRsbpDcx9tWSk5C7J4rf+UAxBVPZ9/WY+vzv9uMYjwpjq47wS29nr4f
 VHpbxXacFFS4JP9yZxI4rM/p6fSdmp0v23J4+a+yGOG8SSw3uKwLuskTlEvAfzSs+4cGT+3Nn98
 h9cFFpTL0BAsa7u3EA3zD5x/46IXumKcYapUB+RHw7KjFIYBiA3cZdtm+Zbjy8LDn37yUU1KNfL
 fQcXYG1Zq+a6FJo+lO/MiuhcvUWJ2i36waLIXQI7HxvvRZ1t9FwNJ+pZhpMHFb7Ki73Gq4GstuJ
 PoB0UpkpWOKxXLnr6ViRm2xUlz4EpEBtuTuuK2vSk+MpZneHhEq/ooEbFVqworfOfiq6WqDepGO
 w7QEkJD11jmW238bCdFoAHhnjllyQ1Nc9RF6NwXY=
X-Received: by 2002:a05:690c:64c9:b0:873:5c6b:a303 with SMTP id
 00721157ae682-8b07ee3497fmr39132687b3.49.1791908601818; Tue, 13 Oct 2026
 09:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-20-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-20-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:23:08 +0100
X-Gm-Features: AclHuK-MjIAggBsDJMxmpzNkKaRTjLSJqxxUvhq9jeMG2XLDgmhSjMKS0aBvJ8k
Message-ID: <CAFEAcA91zCVb+ombgdcZOXVY7CVk1qXW__mbg=_G+Z2L6-Hytw@mail.gmail.com>
Subject: Re: [PATCH 19/22] i8259: move InterruptStatsProviderClass
 get_statistics() from i8259 to PIC
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> The internal i8259 implementation has workaround logic for storing interrupt
> statistics since these are currently recorded at the PIC level (i.e. for all
> 16 interrupt lines) whilst being stored in the master i8259 device which only
> has 8 physical interrupt lines.
>
> Move the get_statistics() implementation from the individual i8259 device to
> the containing PIC device in preparation for removing this hack. Note that
> this has a visible change to the "info pic" HMP monitor output since the named
> device displayed by "info irq" is now the PIC and not the individual i8259:
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

