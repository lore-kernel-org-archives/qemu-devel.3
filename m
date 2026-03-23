Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1742EC01D4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dpu-00070d-5g; Mon, 23 Mar 2026 07:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dpt-0006zv-0n
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:52:45 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dpr-0002ag-Mu
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:52:44 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-79628fb5c05so30473737b3.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 04:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774266763; cv=none;
 d=google.com; s=arc-20240605;
 b=GdtaowL6GBBZ4IhRXICKiH/aoa1n1+CmGTvy49WlGViz0X3k4IJFDASoWrqwTTPbOQ
 kb19arEguDFdZa5VtaKE9kVRy+N3TSB3x/Om5smY3speuix5zHwKHyU6DPD3dii5ZmVL
 fDBng1vaxyIsNyj4GQRX8H5AkbgUNKgIIC/ewZGXSXWyVypyKrWeb9O7Falqxl8J82FI
 lUghIyYV1ZSYJAWBrNvG9FvO2mRmZwG2BALvagsfHzJUxoU8JBWKQOMCI2fBAlcR1kJ6
 +AR5VaKnTM2VUTii8itNxvVtXJLATbUZHTiQ07bp9PncvDAF0SQbilzZJVsQZm2I5qCR
 UPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gGqQMEt2AfULCoaSIfJ77Iq8a7/3Li/Hgp3I9lr/Jf4=;
 fh=DHe74aVkgzv45cXSYE8qV78PZVbc812l8aeC8EniNdI=;
 b=TmjFpCazZPWQh8cOIKdrVoBSSnXVWaRySmzItGPRo8VN2Tunv2gaLNmv2vTN3CI3v/
 6XPb51Od/JjpzZUQ4FbySoRyh69uW5xNznx68AksOBDJ2muHjwSDvDevLRhtRgc41t28
 U2nr3wap95JrQOEh/jKRGM71eqgD0YlHzSMOulscGJcUarDzGhLD1F5ZQst7s98Xd43P
 Ht2E1SM8Z+5t2uaLLYIPKCByb/uTsvI6xlmly3nR32OEGirA3NkoA3o+nlP/tGAWmbYQ
 QYRvdFVmhC4MbT9NXCT7p1RjZSSJBbC7bO3RPafTXUL723iDwf41vaRgWmOrgzHgWeKs
 2wvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774266763; x=1774871563; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gGqQMEt2AfULCoaSIfJ77Iq8a7/3Li/Hgp3I9lr/Jf4=;
 b=rUi+liPw81kgOR7umV3zZZBspGztcLJO/08Jq+39pfTxiViPg80VLddK6/Z85yYyxZ
 sLY0Ivm9FU2nuon3OZ72RW2uHkc8TOL9WGQgiNqZHRhsvHjyDaadNVnjLXG9J17J6YhQ
 0ILHMrSmvhGWD5g6XD+Sou3T5t8PcRx/6gycSTaF3XDJHqeK4VXCjvldQbF42IwL6iVs
 NtjRwJQsArCVkFKKaS8E6zkSuqKRCO7ANWq6BseQeTNv0aQeDD2V+FNmzN2Q8UKgVIcA
 FUhRuBvc/Zu/2vnI+K+S9HBsNQFxSeeTUSzdoa3286OjUt9oqbcKkVA5cWEQL+ZF3qbF
 D1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774266763; x=1774871563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGqQMEt2AfULCoaSIfJ77Iq8a7/3Li/Hgp3I9lr/Jf4=;
 b=PiDHKP4LIZ4pQC3fZi6maeOL4zNixMARUHmGQ6o59qHzTFZtWnulBHXhI7tNwBmHCg
 dyeAIVOj3wxwiGtKUNzQQieEno+Q6/wFj1MvIka9QoXBAy4QdBzDxz0x5N4LlTF2tsIo
 otDuEBKu2RU8dC5feXf4rthgTXOYoBNpJ1jBkT3w2ALwwNFTorcX9RbAe3t3YwIouH58
 4mRXPW2zjsMlqvqvJLCvySYMDE/t/OnR6PIOIKkohTEecdp/5jdDMAREIA2rzqaKjQjn
 Va5K13kxRJ2yLmWxvLEAfIYWmHFzS/6zGxladOrABS3eDFgXmsKVG/iFGFi124NMpVgg
 vnvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4Rja9mKpzEPBGH1NdWOX2McPy0Z3RGPfrnzpUKmfhYEgpyKKplM9khKNoJh43rXCp0ZSIgp3IzYkT@nongnu.org
X-Gm-Message-State: AOJu0Yz/VDhLC5RmZTrNpAR9eArXXjoQDORgVkA3b4PlDEeIhUGXmNAt
 bosuGVk5XqrAJTcbFvbVF/bCo8eZHBg6tLmW30Bv85MFzFwrRGPSbxG08DwwdMMWE+36ZkaHlmo
 YQu/8Q1HkCW5zzQAME6IgA9jmIWBxhCCe0lODnRNE5pzjHjZ+30+E49U=
X-Gm-Gg: ATEYQzyPG3neQ42ed3tp4fZh8etO18wnykuzhThc/a94OOhOtvbmA+3SHUzeKmwcWfh
 4NvK9y6InLeqyfUvEbwWjXBSpmThY6muXE1qYYmssndRcyO2JvSEeTZQY1XkBsAq9hlcUeaj1ZC
 WvGupBEWC+2rBDX/zDzqAGt63uaAfoxCCReORAE9JYOb7cslX9GQynjVQN7Gwm7LeVYEYTeTYvy
 2S3/KfQhwcErEnbKPnWbc/OSFwXKWyrL4Tl0m9G4lp/M74ljt7d5vByIdnxwi4WiCMdyf1OWLq7
 XKFdGofkDukCaOrAcY9qanXHvinCyHVw5S80ofRY1gCH9FNE5lrnaQj6UBCU9+9E5KnbfWbxvF3
 XxQ==
X-Received: by 2002:a05:690c:348a:b0:79a:668a:b6e8 with SMTP id
 00721157ae682-79a90c567f1mr122755107b3.61.1774266762655; Mon, 23 Mar 2026
 04:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260321231916.2852653-1-josemartins90@gmail.com>
 <CAFEAcA8N4kMYW1zNmSpiMPXG-MUjh2awiZbZuFtOnqzRW+ir=w@mail.gmail.com>
 <CAC41xo14hePcRU_=FMug5tCfJjygo052EZc88MzBEukfcMxUyA@mail.gmail.com>
In-Reply-To: <CAC41xo14hePcRU_=FMug5tCfJjygo052EZc88MzBEukfcMxUyA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 11:52:30 +0000
X-Gm-Features: AaiRm51umNr6rLDPvUu6ZQ15F3-mpRe7_Cv-jpPhu2Gh-38BEMxr0jJD4Egl5JY
Message-ID: <CAFEAcA9Ntz=9_K00JtAz-JYUzBZfQxphgtG-iNanCXjvAeZvcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: fix s2prot not set for two-stage PMSA
 translations
To: Jose Martins <josemartins90@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Mon, 23 Mar 2026 at 11:33, Jose Martins <josemartins90@gmail.com> wrote:
>
> > Hmm? That commit doesn't add the s2prot field or touch the
> > get_phys_addr_twostage() function. I guess you mean
> > a811c5dafb7 ("target/arm: Implement get_S2prot_indirect") ?
>
> Yes, sorry about the confusion.
>
> > The code change looks correct:
>
> Perfect. Any other actions points on my side?

Nope; I'll pick the bugfix up to go into the 11.0 release.

-- PMM

