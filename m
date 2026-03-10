Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B1DEB1054
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyRC-0008QJ-Nu; Tue, 10 Mar 2026 10:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyRA-0008Q0-Mz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:51:56 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyR9-0007cT-6Z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 10:51:56 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso10927888d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 07:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773154314; cv=none;
 d=google.com; s=arc-20240605;
 b=kXmqLPwXkyhX3Ek60yfmR4SWalTMw4cBYHTQiNWW5PMVnb32AbJ4GPUKBBW27CZj7u
 M+35zsedla/n1kvGfcfbQPTzbTxHbVWRKPXJl5mZh9S7fgynEcolJvLTaaGysCMTilT+
 EsL+MlwDyyxsC7JkHQ3A1ILO/Un7xnLI7mvjM0RNcnZ7+AkWNPVNbJcpBqog9y85cXj8
 U0X1dJTAIz0R1TkroQPd0Rsva6bBxOThIuh00r3XaDYhjt7CSn3uhhutFp2zNuDOOBdO
 haCdNJy36o4fBsX7czdVU/63EPIEPjmY/Zy71i19wDgohx6yfXxC6Kmc8xzcZAgMONOb
 8Uog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sSFDL/vWWCX2LAxmX4mIpD/WNopgJ8FdJdsCFors+6w=;
 fh=bQWo+lpWV4pkOMHXzy0o8JNJvbYBgZP0Roft/57stKU=;
 b=WTxyJkN1CsfCKHgjXnTGkIKx7o7uui+51s1OoMtFVev19AOn14c6eI6nDcBQw6hIoF
 NumSznH2aaHKVNgf5E79jfN2RPlrxtOyBsY29eE9xdR4E8tQvjAlKMtsdWOdIHjway8D
 0DgBtHv1VvvYh/y1p33qxBK6smzZ4Oo1CXIEIKoev3MmodUqBLahj0hBWwcMAJYv6a1u
 v5TgZv5/xJwtgo29dsIGJDYhusM90JmwEt0AaIBFFgkvs++PltQgX2kDrp74V2Oxrz6U
 6QVGKfErdpsmkqnQv2hog1pridsZNpjw2XfoDO8uQzDPkx3ORvhEipJf8Jv284P68IcB
 yrPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773154314; x=1773759114; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sSFDL/vWWCX2LAxmX4mIpD/WNopgJ8FdJdsCFors+6w=;
 b=QfOhs5R/roeHrCe4UVFb18I9EG6hlRgGcxo0vuSCqyWieF751hMyGBeHbLL8LOrDgE
 lK9hM9qSpALU2LSeBu62ANebXDtsujZKGhCI8D4XZsX7i+OfhhQywij4n+Y3T61QD6w5
 cmExSuMhUBFNvPsvJC9IZCOBLtVGsz82xHDol69/Tqq3HC9iETjbWsndWHpeXW9k8qXk
 Wops1OaeR8/zVVT2OA0CIXztCKhpYO4QOMxWRPVMfh39+obB0547ICC9chuDtmodE4aX
 KrIqYX1YW3RAtlYT62M5o7UUhi7N3YwfOhIlx+h5bxtfLKDcEuNPl8xXvFdKwAheI9OR
 +RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773154314; x=1773759114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSFDL/vWWCX2LAxmX4mIpD/WNopgJ8FdJdsCFors+6w=;
 b=DmPlWNOGvV7FtivFhpHjgJhWq0v8kevJr9LqG1y6NR2oRon/nPAu+cyY5el52ViQZF
 Zrl8VuURZG8XfMow4YL9vL40K8xBNEPzILhVwAiUXXxbz/fC1xcjgHhqkKSOLyA8ZC/6
 1P52A4Ty0dpOGDgotMCJ0wrhWAd01LiTb/ZumPhVVf26rruHtlwr73B69JS5GL2D9hFV
 Xp8cryrJR0f75EaGfrmuLERAFHdsE2oEMHVA8npC0kn8FPgetD7xrpWAMoxa0fLyFq92
 SclgGaL7Je4DJKXn7rbpZZdkihWTGw2hd/cW0n6K1BzDGJeOK6GCqnM1XWrZnzrKD2Qq
 CGQw==
X-Gm-Message-State: AOJu0YzEp2Bb6bE1tpXf8W192qraZSUxym+woEk8ayceAjp9uTLzFli+
 0DsoZWEmjZXWtzfFUeBXHVVFaMToUkUYhJ3z0am+imkjVWkm/Y3DB452LLo495rkiHcRNVCwmUr
 p+0AsJbEDF/NVj8rQ6nJLYhApbbiNZDvcOaiq1hkkCkv6XXN+TwOh
X-Gm-Gg: ATEYQzz45rHACzJgkgjdScoe65Q7bQ2+vcD92Rit8VjYu2/TswPmvw1hyttTxcxd5WN
 VJPuQEB0gVNlOPSD6HeBhNqORsHwxV6IXwvG5k6kHB7+xeZxQ5nVSQUyy76wIKyDAE+Fw+pOJYa
 xfLpW9SKBFoCbWwmXRn+bgqr+UAjSJmIccdD3grS0ffyBEJMKqMqK/Dk71Kdg3WUZVRy8koMG1s
 t0YY5QGybRtHbL69nibUqZru6RZrMuXy98fr3etn6kJ/qLPzCxEw/m++yJdp7vIiuwRi2XF579x
 UrgQ3SWAXfVRHXnpbkmR0zeBdcO+NBkSQ43BU0RSsvfDJ9Ur/TQXT434d4hVkSWmhM8=
X-Received: by 2002:a05:690e:d45:b0:64c:f78b:1259 with SMTP id
 956f58d0204a3-64d1433f689mr13153554d50.62.1773154313832; Tue, 10 Mar 2026
 07:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260310114442.1025328-1-gaosong@loongson.cn>
In-Reply-To: <20260310114442.1025328-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 14:51:41 +0000
X-Gm-Features: AaiRm51fp1LI47ZX8YDCRb72BQoAN07QzRGY61pCxU-eMZWwnUe72qFr3FMTIAU
Message-ID: <CAFEAcA8bu9oMbg=FW1pXBr1rLqmrXDvFL5ZTzs-9hRh8P52wSQ@mail.gmail.com>
Subject: Re: [PULL 0/2] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 10 Mar 2026 at 12:10, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 31ee190665dd50054c39cef5ad740680aabda382:
>
>   Merge tag 'hw-misc-20260309' of https://github.com/philmd/qemu into staging (2026-03-09 17:19:26 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260310
>
> for you to fetch changes up to db2325f79481fab87211e5a287580d753f582cb8:
>
>   target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch (2026-03-10 19:50:01 +0800)
>
> ----------------------------------------------------------------
> loongarch bug fix
>
> ----------------------------------------------------------------
> rail5 (2):
>       target/loongarch: Preserve PTE permission bits in LDPTE
>       target/loongarch: Avoid recursive PNX exception on CSR_BADI fetch




Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

