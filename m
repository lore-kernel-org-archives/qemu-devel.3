Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F352C106F31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5hv5-0002v3-Ld; Thu, 26 Mar 2026 06:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5hv4-0002uS-3r
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:26:30 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5hv2-0002ZZ-HZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:26:29 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso827953d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 03:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774520787; cv=none;
 d=google.com; s=arc-20240605;
 b=JBlsQL7jauWZy/FXYkj1Drk3vN6R5mluMMgNlWz9qMm6X93TTDZECMes2QU1dqQNZ7
 mfUlDeNZK2/eLDbgg5divSnpmgvRqxo2hhlTFONUMsTii6OLbnO6dZHopkFPWfC+MgI6
 X+d8UJx0FD1NV1yu/clb0POthcx0I1MKXRNIBjocbGz+esSztTeCbb+lHymnf3autAWd
 ZVpmniYnf3+b+RC6iDhWU78RcCyV0JXIDCVwDpVpu3i5imt31BmU+K9V5Ku++M3TCcny
 tdr7fbM0yOCFCMHLEix40nGaSNzr+d8XV1mv7YnaEz4BWrCq7+lgJakKBWUzbOYknI2S
 QrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eZZ63iWkY9Qbftomucs+/uNF/5Dxv+67B8qcYTQlI8k=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=VLs2w8KWADSbFuZdYCG1OrOE9aqP2j8Rr9y4KgCgqyqeC7henRNrw48xYOOZ9e4zKa
 yUx51WZGaGM1gVNiS+7scFA+f4+fXeNIBIyYg3eC3F7+oHcuEj/T1qX13ij+HNqlxT8z
 9Yi1QgN+fYgHdC+AvI7tGwJb17AUkkPri2fC5oGcAKxas2Mg4t1EIdwLL744JTBr/w7y
 +pbLg6trjk6Sdm3MDHb/yUhDatTesg+GAcA9eJ15p7SQFJFzM/DS9H8KkNlqd+KrUYPU
 ddnw1/Uvo+HEcpmsFsUQt6A3wKA6UcKhaFUyUKu9z10A5KK+BeuqyfFPBPCa/XuRNi+M
 o+dA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774520787; x=1775125587; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eZZ63iWkY9Qbftomucs+/uNF/5Dxv+67B8qcYTQlI8k=;
 b=mqFAhmlV/8gOnl8Qj4CHaUwg4vssOKA04Z8p2W+OqQzSugVHtIlk8iyxFqlqGxS0rf
 5iRD7e5xqcIML68aOEGqzyDDP6MQyDQUlp8CK0ZVN37Z/MIo6+oi6viphTbprP9836xG
 JCyGprk+9hI7S7LjJ6DMiijW9OgivqoHk3FsoaqJjizvtxdohn4gNDTodZfxvMyeBNkE
 uPDJ4Tk0Jf9hImW941+i0uUfhEzzxnTYxDuv+WDk4P8LwGb3xe0rg1yOhcqJC3pCz6PQ
 WzKJxcRDSffq2g+RX4IDTsMYr+yjObazzsMjiX/Zvwbu1NT96GY+CKdnbXPev6IbhVU9
 fXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774520787; x=1775125587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZZ63iWkY9Qbftomucs+/uNF/5Dxv+67B8qcYTQlI8k=;
 b=G/zJP1BSgjU2x3nXOzSlWTh4/wrpBn7hCT1RDinhDgweH9Wv8fkgyQhBhPageegny1
 ZHoJtDZYZTIn4u9DhsAdtDhiO9RGgPZ+2dVQymnjbaB2B3BGTMmL+EtNPb34drFidfl4
 BHiUTLb0sFxJzMK/nANDoOBYaGnRrjSnsNIWMzeIxdmZdv3JW/zoPNPnEbpbE8XrSywQ
 8Qu6HNHJzWvMpjCHw4E+D4alh0FHxjh7ZMKKQFSaAFU1BCaLWSoudQbx7p9/+YVbuzN8
 4/okJid6HesnfUgYKmRBB2NwenRD+1vgttyFf43KWlCV5s68E0dlp+SxyIqaRPu4KmzF
 izIQ==
X-Gm-Message-State: AOJu0Yy2Zflr7r98UAPsltkqMnnnxRdHTACO8QHOcJ2+XpnT8bBFeTCV
 sVnCVkKDZ+kXyH5I4ZiqibB5N1545RBHfSezUr4MYU/MhKiloJyZ1FQ8TWYct/khRJOKO2XxTbP
 S0rI5vs7bbUQLUoek7RJY4Rt3BVhIV8CUVMVJt3liIw==
X-Gm-Gg: ATEYQzwe0yom4uO0Gq9aK/F8xB1nQHh6/KdtVwGrbSCn0PxUPKELoAnuMM7bW53yirq
 Kl25BUGLQc3YcIbaI9UydBJIqg1obZsCDU1EfcMKf5gNnetUQgPkJ8xMieUJ0p8ZK57boOYosjd
 QzcuouuC657/zwtstb+NPCheesk5HpKUYH1Zv7EowoSbME4kpzCOR+vI3VR3CkJrCNF02e5wAg+
 kU6PmMqSPcGPpQrdWAFFnsFd6Eb1Jzvc0/sJ2ds1xuPBG1YfiDrIaWy8jjvSiq1ulE042rKByis
 edf+JsPUdvXyRc4aE0tCbEbhT4in7+VRXW7NDzM4CTeRbjXU2iaHo4jirlQ0gYgSwjI=
X-Received: by 2002:a05:690e:2451:b0:64e:9e67:4956 with SMTP id
 956f58d0204a3-64ee6148106mr5207299d50.61.1774520786837; Thu, 26 Mar 2026
 03:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260325172337.87212-1-pbonzini@redhat.com>
In-Reply-To: <20260325172337.87212-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 10:26:14 +0000
X-Gm-Features: AQROBzDXKI8UlUjnCGVxhWpJ97Ev81eNdZxS_zZXo1BPgOcObFzqbquCRbrqLhY
Message-ID: <CAFEAcA88uOYUHVf-4U2aCLDNzW4-Fm8+8zzP7+3uW8PE6xn-HQ@mail.gmail.com>
Subject: Re: [PULL v2 00/19] Fixes (including big i386/emulate performance
 improvement) for 11.0-rc
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 25 Mar 2026 at 17:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 007b29752ed06e467d3c830bc2c17a8851f8bcd3:
>
>   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-25 09:16:13 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ba41e525413906473ed004b3a45f565783f3533f:
>
>   target/i386: emulate: follow priv_check_exempt (2026-03-25 18:22:27 +0100)
>
> ----------------------------------------------------------------
> * tests/functional: preserve PYTHONPATH entries
> * target/i386: show GMET feature
> * target/i386/emulate, whpx/i386: on-demand access to runtime state, MMU fixes
> * tdx: fix use-after-free in tdx_fetch_cpuid
> * treewide: replace qemu_hw_version() with QEMU_HW_VERSION
> * sb16: detect invalid migration stream
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

