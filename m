Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AA6C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfrp-00036r-7f; Thu, 30 May 2024 09:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfrc-000363-Lr
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:30:40 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfra-00029v-Qx
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:30:40 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a183ad429so1026079a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075836; x=1717680636; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NaFgQ5+ryCdBEjXimHPlevJmdxRcKYvcRx6KROGTIAA=;
 b=c6muQU/0s5B0R/0mLkhBgILJgjeOPxqHprZNkyxTWhw9iODy/6vmI+hrw46GvLSauX
 pqPgS4L2Iy5SP5D3M7Jv6GjPUh6x1eJR4fcgkYrrhJHX/fv+2BfB6/k81tBU+EqaWzsT
 RYmVroLbVhZBOyMCfz/XPq3OrIm7RxoOB2DXmriMgJ3al3IgpM1P+HucnSZIt0M1sPSV
 VsijXG86Vf+w9OHkVMu8RTFgA+N90oaUlexc2xQ9nNIS5gBsBdtOn4cJdDe0aLgUHrzN
 TRVr1ujVzY1GHWOKgvRnzxyGByRffI/ZFDZXIUFgsbEV5kqnh/sRv2vbUZp0JD30sVz/
 57yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075836; x=1717680636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NaFgQ5+ryCdBEjXimHPlevJmdxRcKYvcRx6KROGTIAA=;
 b=ppQoxS/SrCgRoHmF6vzShm2eAZ8WeLr+EVqOg7ULEg6Cv1WC0NGuVy6ZLc1PD7yjZT
 eDQij21Mn21afaubNgQfGdtxj6QELUomNaSwIAYDm32YrFdi04ItHHnjTQNh/VxDexti
 Mdkrw3q+0VQrf0b9rH1qY4gpMxTtIFziqvsV5url10IxGLGcNU5TsKLnp46f3IgnwuhB
 nLACpsSutymcW6bnOTZ8PgwYOaoVNwhuVfcaDqCyFEgZFzl2OYMZvsB4IQnrvzyq++EM
 /tPIqeIEi8PnSYRNt2pKIo0LE0I3XJ/ej2k9EgrHUpoHaixBYg702dUD7+Mau9z/G/6j
 wy0Q==
X-Gm-Message-State: AOJu0Yzk47LCKX0uCFD5otRVatBJF3AJxXr50H1h1pSGEh86Qu1XZRwO
 fY+BTfvV+AOTx85j2mqZwJFQvmWt4HwryzNfGi+OFRTbqlsZN/D578FVWRzZErRPKvxKC+Y2mWB
 0pvdu86/tlfazi4DQcwURokEXsENp91hoxsKPn7qZsM63g9Re
X-Google-Smtp-Source: AGHT+IFshb92s2yxSDSlvhQfx4OrcJcrfFmrqYZWoGQRdnSqU/4lZVpdWEUA7NmAhrizq73KK2lVEhCMNDX/mvsWWkc=
X-Received: by 2002:a50:9557:0:b0:57a:2780:e679 with SMTP id
 4fb4d7f45d1cf-57a2780e6fbmr623502a12.16.1717075836042; Thu, 30 May 2024
 06:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
In-Reply-To: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:30:25 +0100
Message-ID: <CAFEAcA-Qv-JSH_tAoieh52Es0injZZ9AmMnh9puLOkgrZz6C9w@mail.gmail.com>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 30 May 2024 at 14:26, Itaru Kitayama <itaru.kitayama@linux.dev> wrote:
>
> Hi,
>
> When I see a Realm VM creation fails with:
>
> Unexpected error in rme_configure_one() at ../target/arm/kvm-rme.c:159:m
> qemu-system-aarch64: RME: failed to configure SVE: Invalid argument

The file target/arm/kvm-rme.c doesn't exist in upstream QEMU,
so you must be using a fork or not-yet-committed patchseries.
I would suggest starting by asking the person who wrote those
patches...

thanks
-- PMM

