Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0A3D729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH3BU-00026A-R2; Fri, 29 Nov 2024 10:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tH3BR-0001wD-0j
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:45:29 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tH3BN-0002Mv-RF
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:45:28 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d0062e9c80so2465825a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732895123; x=1733499923; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zWdZccxwTuNLCK+pE6JIXS7NaFlznnTkcu60RPmmRbM=;
 b=PWzEhp10YDN5pKkfCD5VaSmRkUmPwEOtw9lpKZZRE22mBReBoHP2i9l14d06TPttDA
 PVU/6zDTiSJ5+EKFWPaEShoY7H5mj6EF5PqxbBsfyJsz6yjZDh8Tulcn60rzAjKFldK1
 mfXM6upMpKRN4s5FXmdj29U4zM4tImDeeHosXF0Y3Jhib8ndt52fSaWlDwP/ygHgigPp
 yW2pA3KELZD9r/+XE2MHZNVgdyw4tHYvlE4/Zo5gAyOtP+pJ1VA3BGMREhsTjWNkTnw+
 KHGtUBqXGsYHiRZIWG7/N5UQaEbPCl2yl0u3mXNArNKdunS+TcCTHeSAKRyrY3g7Y1de
 jYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732895123; x=1733499923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zWdZccxwTuNLCK+pE6JIXS7NaFlznnTkcu60RPmmRbM=;
 b=GddNxidn+Y3KlKUPFXcDkTP3NyVj0KfiTzR63/C2eGVwcnUjnQzz8uGZ6BxXhFrv+y
 qxodBMYY+aZ3EmI0Uy4SI7RIo50R9OT0lSFfppK2GubpXs+x+Vjbx9kKpdYVGNMjib1i
 wRt+evNZaYmGI7Clgnm0YW+24JUT6WQ6de17e4nPjcA+7vqtXjn++LwA5fibT2YJ729o
 I1z2xcoFMEKbFCFVk22AAvgfep6XBNPBRaN4IfqupaUIJlN5wrxSRpgf/pWP5l+S3bGR
 xqG8eJY4PhCGTTggJKFxpNR/pQ0OTfZs8jTvfXA/1OjSi6egvlsWYYK1PrD2fg3vcmjU
 UCSg==
X-Gm-Message-State: AOJu0YzOJNhxZcgdr9K91q+Okw+4hhkpWFlVgyr39vFhPLzvkYS4F/if
 Fk6SK1WNhKnbXNvgQ3fW5MKHmer0Kdxx2Dnrz1t2wpkW+RIXVgRN1H9keiKaM1ajApbjNB4hBL8
 2PgiW31EHP8we3K7HNbRPyND+pYbVYu3+7J4j5onUXbj3avtZ
X-Gm-Gg: ASbGncsjO4iI+a2qV8MHP0XGIQIQfD7qfE/G9sxQ0mlisxo3wC3SlNPi+KiqUJ4Uyo1
 TlqN5WqQLv8uw1zEt8lZktqP2ytxweOVF
X-Google-Smtp-Source: AGHT+IFDMjCqVkys5o4OE1vJY3TcHVRWg7pMuUH3Lq6N5CLl4Vef99FoHeegTcCamekNRPJAWB/EsduwNV0kNNrzTIA=
X-Received: by 2002:a05:6402:d0e:b0:5d0:224b:d54e with SMTP id
 4fb4d7f45d1cf-5d080c5de01mr10197659a12.33.1732895123601; Fri, 29 Nov 2024
 07:45:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1732820037.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2024 15:45:12 +0000
Message-ID: <CAFEAcA9OARF143-ZiRWoidh71_1Nk6_sbZbOhvVNbCevu9m1Pg@mail.gmail.com>
Subject: Re: [PULL for-9.2 0/7] 9p queue 2024-11-28
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 28 Nov 2024 at 18:59, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit 24602b77f5658ae8377958c15fdef2f44affc743:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-11-28 10:50:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20241128
>
> for you to fetch changes up to eaab44ccc59b83d8dff60fca3361a9b98ec7fee6:
>
>   tests/9p: also check 'Tgetattr' in 'use-after-unlink' test (2024-11-28 18:54:00 +0100)
>
> ----------------------------------------------------------------
> * Fix open-unlink-fstat idiom on Linux guests.
>
> * Add test to verify this behaviour.
>
> * Cleanup patches.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

