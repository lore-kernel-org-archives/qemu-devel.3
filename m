Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68252CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwzq-0001Bg-BO; Tue, 09 Jun 2026 10:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWwzo-0001A5-5L
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:00:00 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWwzm-00042D-QP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:59:59 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-660e9ff0587so2415216d50.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 06:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781013597; cv=none;
 d=google.com; s=arc-20240605;
 b=DarpXVJpF3QvkbwOiMpYvDbPFdHYkJJnr+SHbrdtw5TZtJ12UNk8ljjvzqbhv0yKvj
 OQVhmWiKNviF/OEMNrv/1ZE5f9EB97hVDPxVexG6JTX1JlwCMsL+GLJytA/zkLWE52QZ
 9Dk0Z0tSSQVa5UBhv6NNSLRSl8J7kLxR5/sahPRLtEJXzMdBfowPP5N7aw4GbXUeJ24N
 7v8gthUxJr5rP4k+0JB2Gz9cyz2f01qaV96d19HAQNWlOlIPc0p2/qarEPTikbqFN9Er
 jmxtaC2gRbWTQ/A1VLTImtjZngJ8zmaC9L0HqZBf4w1e8/Hw65JtIHAMj5uupK1CX860
 H+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OhyJqPZjg1+M3+Hnd/IypCSNajvZxsN9GFvQ8gg4HO4=;
 fh=VdU0ZIHHM7Xuu0AoHAY9TnsLw+Rmx6THNQ8Qxyqt4ys=;
 b=KO9ydo1CfBnBrxtfjsg+1LSxLaftO+35RAUiGaw7EOvAUeQZkfnZTkB4upXYONbY21
 82wQ9H+3ix8yRrU+ZowEayupTr4aa1o7UzgMfnvoTZsfLKpDfkLv6RLsrnISAy4TSRkt
 IZ7TMq/wy7rOm2LuhqP4zUmkODMSQBVi9jwKW/q0CIdEHILgPaRMiHSwW6RC0Pn7XpCj
 OTIzk4F7+GN+5KUAfwvRGJcCrk6a8q1l62oqqv3xEQ1UXUwPYHcubT1sj1XUf4YdfS1I
 ntxhH/8zXSniqnuWE9LcqJxVX9E+AbLHTXoXlTvzCNU3TyYxlvS4eOx9tyZLvNbpd3gu
 N22Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781013597; x=1781618397; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OhyJqPZjg1+M3+Hnd/IypCSNajvZxsN9GFvQ8gg4HO4=;
 b=zgtorxHTdnMY1KCJVbbG80U8tS5VlnfXW3g+H5fB7Ib7TklpzeD/nYhqS/IsshKgoy
 HRWxo99nX5MTysqJuGey36mwaql5s1Zjqm3AzSh6uVic+u6bKrGS3cNtvK7Dr1iJApqz
 gu8nj/TV/s2rPpRZWw1L3UedO4o8KC/XHjMFM/XKkidfMOMiHI8BP9U/9srgHCrfhOuM
 y44YPnEdy/HDAkdppDT1m/y5aswj5zclNqqSNFWOlKWO9a68qc2MH28GCFlBzB5qjuTl
 SqbmDf/unEY9gf41v8WvWGwmqxKq8PU3UNImsDH61TUp3p59Ip1vztkCCtM9BVJCB/xC
 X+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781013597; x=1781618397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhyJqPZjg1+M3+Hnd/IypCSNajvZxsN9GFvQ8gg4HO4=;
 b=YbGHmvL0nokbYxJ7I8QN1gtsFzz8tQO1hb4bCFE272hW5jAq6wANfFI0bM6I2Lcpsh
 61T9Tsgbn8Ai2WKAMvMre2ZLENC/eurTGSls50sDdl1x7Upo98oveLWHNmXe/UyP9roV
 /Ucm1yLFVCqUFPF3ZlexZV4wsrvTrYBnXQD/iObRFIQ7nZHIEL4oSwdrH4dFHaZ3fnAO
 ArOJCwPJbNEhzkzFE7AgV9Rb5sFSmSqbzH8Wwmk9xg7TA30hEudUvaMjq8rqPx1QDUEz
 nqFfoSQfE0Ajd4TBbuPqS7XBNoDaiKpq46ANadrUFSJFkmLnfYsSyAUAtWqw9+6sLs9P
 gcwA==
X-Gm-Message-State: AOJu0Yzu97d4r4kaZvOIkQh4eK8bIOGxvVxOGW1EnfAjFfoAIlBpAwqK
 zjqY9BKvNOMYcFQ8V2Yt/C9WD22FC5g35ZQOmqzS4Md9xZHjBTpQzUgb5VdpNugCYcmcwaTT91d
 d4JZCSAn2TCjsidwLHqIZBbI5v1/diZh3nlnawaKJLA==
X-Gm-Gg: Acq92OGylenU7l2IPdn7gdGJSzgXeBWdC8sMWPIVycp0mgCIZLq8DvScoSDdsqwZzjN
 3AAygwJjd/h5ARKPyFfYfus6Kl+gMgLWL3bNbf2YUaCj1ivf5FSQ+cOjx0NluVBHQDI5Emipaj1
 lm3/DHkzxmkZSI8S1doW494N/r58jcpklb4noCFZgMUPz33CpQeCvStvJhRjeBFW0zzdTd7rx5h
 A056El7zt0yvLHthS6IWR7GK6pjlRhVInHtq12mEHIUTeRa/skoJiarE4ZoGSpQmhpWcN0h2Kb/
 pqNwhS8NXHA20Oqr9DvQk7t0Zgur8CAe6nneXs2IgeO4H8VxrBG6FHi4mcPhYX5MKWBoDNzfRUG
 6iQ==
X-Received: by 2002:a05:690e:144b:b0:660:f0e2:8dfa with SMTP id
 956f58d0204a3-661073da663mr16335881d50.1.1781013596955; Tue, 09 Jun 2026
 06:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
 <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
 <aia8iXGozAclWQCb@sirius.home.kraxel.org>
 <CAFEAcA9oB_-ao5C8fGYonE7njUMWLHo5-iETeN_XtnFL4PzyvA@mail.gmail.com>
 <aibALjyPTXVUDpDv@sirius.home.kraxel.org>
 <CAFEAcA-VQWKzJ-aNnzYHZ7a+sVP1y6tkUnE3YCPydsqP0uVXvg@mail.gmail.com>
 <aiflCrf0iDwcpj27@sirius.home.kraxel.org>
 <CAFEAcA_+fZnFG_2xH2gXF7ZtGo-WVwAhwkz9ucuS5kXZOYShnw@mail.gmail.com>
 <aif6QGPxr4oMhb94@sirius.home.kraxel.org>
 <CAFEAcA_qjzLjdqi3NWfY3cTDfkE0HmuvxSV3yVuBb+O95zvV9w@mail.gmail.com>
 <aigTPdBzp0q4sbKc@sirius.home.kraxel.org>
In-Reply-To: <aigTPdBzp0q4sbKc@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 14:59:45 +0100
X-Gm-Features: AVVi8CcfahVoBYUIDG1Vy8llPuh-x_5fqiB4RpS62V7JtWWgosyva6O7Nxs4Eds
Message-ID: <CAFEAcA9VLSRgLS8vMUQwip=AT0Zic+T7xQvNRUYjGhwxd4=-dw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 9 Jun 2026 at 14:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The rpi4 with tcg takes quite some time indeed, but edk2 isn't
> exceptionally slow.  Booting until the kernel panics because there is no
> root filesystem takes ~30 seconds, and those are roughly 50% / 50%
> splitted between firmware and kernel.

Put another way, booting via EDK2 is doubling the time taken :-)

> A good chunk of the firmware time
> is probably the zboot efi stub for kernel self-decompression (would have
> to instrument the firmware for more details on that).
>
> Comparing that to direct boot without firmware does not work for me:
>
>   unable to handle EFI zboot image with "zstd" compression
>   qemu-system-aarch64: could not load kernel '/boot/vmlinuz-7.0.11-200.fc44.aarch64'

That error happens if you didn't have libzstd-dev available when you
built QEMU. A QEMU with zstd support should be able to decompress
a zstd EFI image.

thanks
-- PMM

