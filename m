Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B07CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRt8l-0001vo-KE; Tue, 26 May 2026 10:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRt8k-0001tz-0Z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:52:18 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRt8i-000354-GF
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:52:17 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65c7efdb7d8so11111413d50.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807135; cv=none;
 d=google.com; s=arc-20240605;
 b=YSXglGRqRLI4puzot5pGYdeqXHH3PE4Di/yrZA86IhTaeWy0VrBY2y7qUaHcGPxM2y
 jeCHpiNgH9q2IDRr/kpGeCXDcDDEP6MVU287qjdbltQRWY5GHsC3e6bAbMkaFgx1NXUS
 o/6DRqOw/b8OjoIwH9CXKvQh0iUqeeRtz9APyFBAZ4DRuCp25M+/ffxxwNGday5qRudr
 ZJV1osGgwLGeCPBs3BeqrCTcmS+5rFrQkQPA27wumRepDUffhwXj+4Eq4upOAYI/ah1F
 i04MlZ9U8gl0iGnrJzjbjcOfnAVe89xa/UREmLlJUcbY61wt1yywxsaZ185teuNkpEVw
 t5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2OZ0hDdUmFU/Rd+mxanPFcuODdtRr4vvvEm3SfjA1Q0=;
 fh=QL40MB7CQFme2Q1i2ysQGkkgBbnFncSyqwMVv3gqO8I=;
 b=EuIFemUy/i7nK78L8RG0P+ApHopJyOzpe8Ft8+0rp/VWGbHe8u6V000ylC5NOXge58
 5xiZTffrScuO3CS4Tmi45XzCmHVDg/TQ933epaFjTz/+RIPEx2DTwFrOLHW3p2xhQdwy
 eGZafdmmcTzuMrFp+Amq4TjPXUbufy5HNyvBs12NnGf7RKs1y5CELmENQFBXbpaDE1cu
 PKz72/cd3VH1L5E4iScN97eHak3Y25rcvk/6tmctzSEtDynU2dRrnoZwb1VPISXa2KQG
 0zk0nKyvxtWzucBFokZn4Mjj0HC1APGRriWbBt4kDyzNKcIf9hA7jJIAQbFD1HEyU/wg
 qwCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779807135; x=1780411935; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2OZ0hDdUmFU/Rd+mxanPFcuODdtRr4vvvEm3SfjA1Q0=;
 b=ku8cEPQ8LPXTrWQgsSO0NAdE4H3pfJ3g/2SzuYIFdmQ/la8liPO5TIApfOsLeUO74x
 RBqdczb8d1TQJigIRUlvZqa5wB/DtOtMB5xqauvwnd/CC+zpjXKmK3L2wF2ISIjN47zT
 AZ/ad9m9g6YxJe7MiU17YC7MCBqAWyNpJnMD1iIfBb4qYsTyTKq+KqjDtQrnU0nGOzJX
 /PJKOM6gYtOZoHZlu3OE42z7mEG29PFUMjLk1H8K4ZotBA+eK4Xbev3USkSYh4lNxJEV
 DB5VuH7OsCXqqvJeGxrMf7Y16MFV0LhoE62M6HYcsYwKcB8irEhQKSQLfdaScZlqilXH
 +rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807135; x=1780411935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OZ0hDdUmFU/Rd+mxanPFcuODdtRr4vvvEm3SfjA1Q0=;
 b=gzXG7Th0/e6fzg8u4wlABYmtfnQzRyXo1RXiy9gRSG9VU8f9iOS3m6LNifm6KKrdgl
 spj16e11kaUY5tOjOUQ8XmXmlE4IyCqaRO8Z3RCy2rTjEPvlzbiHizGSIP2k8gEJHLjR
 9mesusUUEvJKWkBgw+31Sm7ELOG75/kFPLZiDjtii/dkeak3yqYeojEzKCKZJTBxh+ET
 W4XlDhzKRSqflQpwiI8Q/5RHNWV6ti05burpB4Ha5dToUo66v9Kto9X8fxfgYStguPTu
 SYj0SFGvLJS5yZJpqK5gpWhOKfymREhR0EwLeQkOIEJj6CL7l2db/0uMMYvYRw7Rd1FZ
 fxdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ki29nHUo9bV00wF7yZYbcCQ/IJMV7rrsjcZq2CW7UD5YKRa3syYLjnqSAW0Fag6YqRq3+YtAngM2i@nongnu.org
X-Gm-Message-State: AOJu0YwMjoRUBFtzi6WCZ4E04LR9tdSguwhy7ALPaZ97o2bv05IyzIjR
 tPeNWKiUg61LO3uqxISDZ606i/VmV2szybmUukubKpMjP7l/eopFPqb3gYup5f1LZt22l3m0J5E
 8afptoAaQ35ocM1n6+0n9VyL4YGWSA4HUOj+tSkBerQ==
X-Gm-Gg: Acq92OHkC9Nt/SqVfW/d24cNsZS+eYcM6hkVez4REhYoSpDhXr4Y85TQyxG4ZEqkVHg
 Q0H6lBT+WAhujyyk28ZRq04FNAzlIxSzTMXHGYRjyV50jyDu3p4hnXI247a9JqE0XFSbUj24ODU
 MDvIJTJ7yN4EViKBConE38TvyHJWHAyaDxQAQm3FqVz1D6zbHIGL4Cm+pg3QC35SXxVU6S93+Ah
 f71MKx4POUoSKeMmkdKqDuaii0PSFHtpuMqJK7eSVDFaU38/v6mMM/KC5WZKAPVmbxKeMcwBCsz
 Cx3tLealDtZDjjmNQuD5CKU8bYyHMNGAhwj79cxXl5CNkxFWEXwi6dYPXCVrprFzQqU=
X-Received: by 2002:a05:690e:1556:10b0:65d:f5e7:72bc with SMTP id
 956f58d0204a3-65ec97d49acmr15293042d50.22.1779807135372; Tue, 26 May 2026
 07:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 <875x8g1pmi.fsf@draig.linaro.org>
 <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
 <1795fc9c-f82e-40f1-aab6-ec24ad02a918@linaro.org>
 <CANCZdfp=mCp89NdwVzy-tEo=FNiEu6_H79r5vFRD0-Nk=Cx54Q@mail.gmail.com>
In-Reply-To: <CANCZdfp=mCp89NdwVzy-tEo=FNiEu6_H79r5vFRD0-Nk=Cx54Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 15:52:04 +0100
X-Gm-Features: AVHnY4JPCqwLzwvQCFx8-X5hGbkdMfeug39FA6p8wpPVibJlSwQT4eoGXHtAq0I
Message-ID: <CAFEAcA9QeSjN1JV6ieavrr+r7viNo5maAtz5OJctcbWwTNQq9Q@mail.gmail.com>
Subject: Re: Question about tb_flush()
To: Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 26 May 2026 at 15:40, Warner Losh <imp@bsdimp.com> wrote:
>
> Great! I look forward to growing this directory.. But I was trying to ask a slightly
> different question: What belongs in user-internal.h? What's the current rubric
> for linux-user in that regard?

For linux-user, the user-internals.h header is there because
some places outside linux-user/ include qemu.h for various
reasons. So (commit 3b249d2661c) I pulled as much as I could that
really was only used inside linux-user/ out of linux-user/qemu.h.

So it's not so much "what belongs in user-internal.h?" and more
"what absolutely has to go in qemu.h and can't be moved
elsewhere, because the code outside linux-user needs those
definitions?".

Some stuff has snuck back into qemu.h again (e.g. the
prototype of init_main_thread() could live in user-internals.h
but was put in the wrong place) because this kind of "looks like
a good place to dump random stuff" header is hard to keep clean.
There's probably a better name than "qemu.h" for it.

thanks
-- PMM

