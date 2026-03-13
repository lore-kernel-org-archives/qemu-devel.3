Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78877105F78C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10fN-00046l-2W; Fri, 13 Mar 2026 07:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w10fH-00045w-E3
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:26:49 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w10fF-00022h-PZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:26:47 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64937edbc9eso2033704d50.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 04:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773401204; cv=none;
 d=google.com; s=arc-20240605;
 b=AzfAV6S4cS69PvvCaYHjQRIGvdx9wii99Hws03U06O62L9/6dh6qBr715FdH/IJdio
 17P1HSr7fO6mdmpH3Kq2tJBCICw/FGFMCoiij+Cv6erOuEyuaC09uvGNr4DH45Z73W6J
 0NcCcU4K0QHALIEs42xABLsPdqqviCnuoZOOb4ShVDHcWq9W638kQqIen9Srjf1No6Qg
 R02BCKP/xjNrtmXJayE+xGL/Fo1vw9oMKWO55tedoYGNl4KvMDyR0JPMDCtCB21vpWL3
 RiCSmqIC9lQSWwkXiICaE2/IEDrSw9TW+RaMjP6MzgvbeM1A9QcnnQBnRhJo/Gyw7x6k
 fD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ImeyKg8e1/RCe+sviCmGQ62cfhyCCC4fRWK0o9FNl5k=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=N9ZMwjGeCTXYSlk92scvhLAhrlqKN0j2OYwf8sxU3KTZYVF6B4AMT050GgsRuulv0p
 bbDkPBY1rRhXMPiBm0OT0EXcFzJ/BFNT36IN9NnXJhTHb3iNcBb359pFvtdBH86s1OG1
 Hc+GyvFZYSYevVDn7MVuWjvaR0exuL3/ZtnjX+WULNG3UBZv+s1n7TcGnA3fSlyJ+yla
 ry7uqwKOEgGrrdLcNqJWUur/Rnm9mIUPE780a+kUXrc+d2cMS5bZ3BzxZWual5m3kJDe
 F7XRUlDrB8iUN5kfNI+DsUWZVXSsLETLwneAcCZzbJa+NmdLdEFNfSuYirx//gBytUps
 X+aA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773401204; x=1774006004; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ImeyKg8e1/RCe+sviCmGQ62cfhyCCC4fRWK0o9FNl5k=;
 b=iHyk229CcWH2FOJExpr0z9ztBfxxb65fAMl6nGJagHktJavaaZ62/IgOzfJ2lzSxu+
 aFx8sQdsnBkr/sn3FDHs6htBqM9NlC57dhK977Gv+Rc9MMaD0Ur/1lcoPhvhxUTM57tD
 k5/blP5DYrqSH25Wrbq3p5LapJPDW6aUJESCjBTQS8FpZoGvI+EZ3Vlq/nohgMmX9Qkb
 mtiuV9TJsH/gyGIHE4G5d5Vf/W3zaqlhgRvVddvcsiAbn8ynIJYQ/kNrwyCp4ZYeUYFq
 /BZExQkk5FNxxhlG+YpVlxQay8ROWGMsD9RhqhKLlW4HPSauHNsr9V8MLHDRA6qREDVN
 mmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773401204; x=1774006004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImeyKg8e1/RCe+sviCmGQ62cfhyCCC4fRWK0o9FNl5k=;
 b=Rmifd85P/hHL/V82b5brpFHwp/PRKUPFypWY0EPvzEg7wu9tIMlzRjjxzBn2oX99CL
 m2d0nXvI8k2EJXXMDMD3ml0JBWtZh6B7bRwZdK3/eJwR7xWyka8nI9hX5cBsyhXgThMB
 6rUyqInqVRfX36GOfNoyP1mJ3Udz2nFz0cUa5UEIfLJGM9F0MDKZwdnUqN8WDByr1upD
 6zpBAszHGPWtGiU3WKyFgdSL+sp8dQD27+V8tTcEjXTI9cpFOk823YAXjsIg5Go1akBp
 H7ZFzjOgXDphi23nKZ2h6jPyBvpTh1GGupSKfSAk5tujQjSd9F5F5KSabfFwEoUFdtlj
 dD+g==
X-Gm-Message-State: AOJu0Yw+IbDATvbvHDsvcFZtn9fIcqg8NbL80mhxry0uZ6blVXksY2ax
 eLmUFExlPbceMas35fPtFW4S4DIIwwvJEw7w1GaqoRCRUjDh2thQh8afATbkGHIyuw/gvNm5S1g
 KQlNbhbi0bD+1Hqd3ojqmHGPQkprodEbkltZS5b+0dAy4lTp0AukmmXo=
X-Gm-Gg: ATEYQzzaT9+PQ+RtlrFMvz7AECFF15l1pdzVr/IWheXTm4WfHFdkVbJ86w/GcWewcei
 RmBuCVJukMZO3Sp/NsNAr4YeNIuXXkojQ1skk6l/LfmQrsBMRR+YJRnWTxmpT38n8DCrJ52XjSI
 ecnErYOWXS9UhxXsLub/phsbPlECERfGZmtffVB4Gz7MnEKN1U0ul4jsi+cAkUYJLKoaS6j8ZLX
 28hAO3CZli2DKUm6W6u5klwonZ7ZcYu0HCcKXWCXFQSnfqBc6P+RQFg9JSxLQB3TDuls7E2YcqP
 Ai1/qKGJ6p69yJpU9sHGj5SQSYsKewGVQ60QSr3yWr4CE9xHhl/3fAtwSpeTEt7rve4=
X-Received: by 2002:a05:690e:ee6:b0:64a:f160:2376 with SMTP id
 956f58d0204a3-64e62fc21ffmr2097989d50.30.1773401204448; Fri, 13 Mar 2026
 04:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773301927.git.dingtao0430@163.com>
 <cb35c1b622674da7a2b70691402132f691933f2c.1773301927.git.dingtao0430@163.com>
In-Reply-To: <cb35c1b622674da7a2b70691402132f691933f2c.1773301927.git.dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 11:26:32 +0000
X-Gm-Features: AaiRm51fGPeoFMrznG5OT3ujvcRce3eHSSZTfAcg8NVtI3UuefdN9hd23jhDDlw
Message-ID: <CAFEAcA8+t_Us0wZ6=MQAJV7ZDWCNQ8pKVTSR86L+_wA3U9kpww@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] The LLI of pl080 should be aligned with 4 bytes.
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Thu, 12 Mar 2026 at 08:02, Tao Ding <dingtao0430@163.com> wrote:
>
> When the bit0 of the LLI register is configured as master 1,
> it can cause incorrect data reading, and even lead to qemu crash.
>
> Constructed 1 LLI item. The initial LLI register points to the address of the LLI item.
> But the bit 0 of the LLI register is 1, which mean read from Master1 port.
> According to the description in the PL080 manual, the address for the next LLI should be word aligned.
>
> Configuration
>     ../configure --target-list=arm-softmmu --enable-debug
> Reproducer
>     ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
>      -device loader,addr=0x00002000,data=0x00000004,data-len=4 \
>      -device loader,addr=0x00002004,data=0x00001004,data-len=4 \
>      -device loader,addr=0x00002008,data=0x00000000,data-len=4 \
>      -device loader,addr=0x0000200c,data=0x9e4bf001,data-len=4 \
>      -device loader,addr=0x00000000,data=0x44332211,data-len=4 \
>      -device loader,addr=0x00000004,data=0x88776655,data-len=4 \
>      -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
>      -device loader,addr=0x00001004,data=0x00000000,data-len=4 \
>      -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
>      -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
>      -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
>      -device loader,addr=0x10130108,data=0x00002001,data-len=4 \
>      -device loader,addr=0x1013010C,data=0x1e4bf001,data-len=4 \
>      -device loader,addr=0x10130110,data=0x0000c001,data-len=4
>
> Qemu Crash.
>
> The result correctly after fixed
>     (qemu) xp /1wx 0x00001000
>      00001000: 0x44332211
>      (qemu) xp /1wx 0x00001004
>      00001004: 0x88776655
>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---

The crash only happens because of a different PL080 bug where
we weren't correctly handling invalid swidth and dwidth values,
which is fixed by this patch I sent last week:
https://patchew.org/QEMU/20260306152140.2191653-1-peter.maydell@linaro.org/

but we are certainly mishandling the LLI register here.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

