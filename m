Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8500310F92E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cOT-00025Q-Nt; Tue, 31 Mar 2026 12:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cOR-00024i-Re
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:56:43 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cOQ-0001zZ-79
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:56:43 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ef161129bso7441041d50.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 09:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976201; cv=none;
 d=google.com; s=arc-20240605;
 b=Y3wLd/cFLtJ9RqrrCdm29w6l07ksDkj7W0h6QwzxtE0iK63L7jtV9w+fAyrRtwpdIV
 ayRi2YcY2KPVVcD2NhCjXio02RjyU0ewXIBdXpqpTBdfRFDzLSAIYNI65oS4RsJrz7dt
 RIjCc5BKZY+/JWv/38G0Myff9x4Ogn241aTeorHNinr/AuENpKJ/6QwFPBUqav/qX8K0
 WHnRY3GN+O/efZg3pk/EbVtJeXALXgewnqm67+yWjzCbMWTWLD9ZDZDdAV5sBtfROVak
 XLXRv+38jUmbdxF91MHipzTxt7xdORdk7DEp6tWc2QY9ZzCc8tP6o1PliozpCHiVn7tK
 uVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oITUMmQDFbOJMQwRzSxeqvH8qPQc1MNb7UJZnNsLbO8=;
 fh=iBfsoTySO2eRjNWfaA1crknDKmTExEhtnVkpakrX9Bo=;
 b=WhgmMrTk/0I8Bt1LYKL0bbtRmC4ztUtSomDzxj8xS3tNSICPVJlaLMON8gnPrzFTSa
 zkyk7GiZUYcd37PHViR0nHV+3I8yfAWT73g/6tDbsIxN2smpcKfzxYIYDNa84FhiRG+Q
 ZFIK6xekslbcWKEQ+IYS8S9/+kele2zqPjmTJ/Hidre2yvEnW/M9Eue3NDfbv29YcP3R
 L6fTUChJWuuDELyabluPLQ0lFWeUlTUxTGXxGv7Y3GZk/op6ZtJuHE1lPzh7ZD4tptkm
 INPHHG1WEpKqCQ+jfBtZq855PUanbXUoaIdBAWtl+q8YiNKG8muwzdwajtg2xllBDyh+
 M0WQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774976201; x=1775581001; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oITUMmQDFbOJMQwRzSxeqvH8qPQc1MNb7UJZnNsLbO8=;
 b=pyhjPnrFD4QMqosQw7IU9fnPksulhLkbLOwLHsltRDliR4Y88sDHjU5ZVdq3cM03HC
 9liauCZ9nC6PDe4KBNIOfmc2xXUAC53OcSeBh6YZwawn4qHHpZl07wFnrXtCv5icmWL5
 U9EUNnOvMlpr0Cui8hNp6/AeaKnkfuWXL9A2WpTbRcw5wS2AJAGHwEv4hWiElZbX+sG/
 nJmmjL8I9Wy9qaicoPvga9YGegbfgvn5rlmpjkDcoVJSnqvtcuAnugvHTEWVjiDMSNOB
 Uc37ZWnVxz48qfNERh9gO+ej3hd1ZsPnFy29nFoYoIQiEK4jdVJJ8BOAFeoVkUvNZb9y
 klRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976201; x=1775581001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oITUMmQDFbOJMQwRzSxeqvH8qPQc1MNb7UJZnNsLbO8=;
 b=eJEpW91E/3MXLyyttjM3Ir6WCPs0VdOBaaqpt+KSC5Z0aXUoZClS2D7PaYtKRMw/CX
 Vyht6NXdXYLRRYmR/s9+jtUgp1/tgGGsPtM2Hdv1St6lQ+AkWad6hNL9A7qOZt1mi+YT
 Jv3LMwHLiRtpF814CY8SHf7gcNRhW4O9xqiMW2Y7h+DQwTBCeCsCpOcwQrVaf8xZGHVe
 R0DKaVMUcb7D7xoiW/M7jX7Yj9unuuY+sUwcFs7yRPvBeXtXZB+efhFe5EL5tJrzOTrt
 YfRSXS/5e4y4idNzThmeKlBayr017JsDX8Hk4hJyoFcM1bxaocv2kbPCbL6nEdpj8K+9
 jkNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPl29yRThdRgMzhVsGxw9EUPGaoAinyd6mZ4vwG+vPGfIWARIz02DZz6Aooksem2lRXufRWb6BtXEy@nongnu.org
X-Gm-Message-State: AOJu0YzuatuKmMqzlUx+7fEZk04M3ZtoABsPXvpQiwUSCWa6PDWZOWka
 KZSXm0Zqtf6xV6SFOHt4qpQtrIJoTlV95FJjwmI7Yb8b0RFLx+XZGE/ZC7hqqzaEavH3kyXcdVz
 lKKN5bsO/vV3TyKXQu1qb09+LSFdzHgDnaCzM4dU0lg==
X-Gm-Gg: ATEYQzytheLs7AOIa6IkarNgP2JnE2JGl88MaIFnyqLHmJr3ZEBqVmd/3lFhKTI3xMh
 O4Na0f+6GMS+OBa8h/Oam911s3AbkH6SLFELe/+BAnSw2l1dDu2kqVvgv7PLybvxr8jwEpKU5Ux
 Yv6pNNQAw3LULu9+8iHFCNK8LEYac8xuZ2MH5TVh45XEvOMlOH20CJdmvbu5ANLHaIhj8On5N2S
 5UliTuWdoA/AAJX+mBPYtq1/Dz7LG/FIYXj15vuEeygssE3sfBj2aUMOksNGyP9uScTVi6N3VXe
 slTjJcv+kUtkioZ4l7/Uk/DkIa1XnGqysNhKRThpUbgdV4odfL96OoLI5wS4m/TJwAM=
X-Received: by 2002:a05:690e:25cb:b0:64e:e47b:2476 with SMTP id
 956f58d0204a3-64ff73b6529mr13225847d50.43.1774976201003; Tue, 31 Mar 2026
 09:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260325-fix-name-to-handle-at-v1-1-49fb922e6fd3@craftyguy.net>
 <046420c8-63e4-4113-b33e-7b8c070af5da@gmx.de>
In-Reply-To: <046420c8-63e4-4113-b33e-7b8c070af5da@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 17:56:29 +0100
X-Gm-Features: AQROBzDiFJ292RWgKB8BFLVndq6QrZrcjJK021uDMgTlsA4aFz1Slz6pPeRbBRI
Message-ID: <CAFEAcA_FfuS2gMKj-6W2Cv8PV9gt7MJ0AFyFoG9mm6q1i_FVVg@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix name_to_handle_at when
 AT_HANDLE_MNT_ID_UNIQUE flag is set
To: Helge Deller <deller@gmx.de>
Cc: Clayton Craft <craftyguy@postmarketos.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 26 Mar 2026 at 14:49, Helge Deller <deller@gmx.de> wrote:
>
> On 3/26/26 06:59, Clayton Craft wrote:
> > Linux 6.12 added AT_HANDLE_MNT_ID_UNIQUE, which indicates that mount_id
> > is 64-bits. If name_to_handle_at is called with this flag set then qemu
> > passes a 4 byte int to the kernel, which then tries to store 8 bytes in
> > a 4 byte variable, causing a SIGSEGV[1][2].
> >
> > This stores mount_id in a 64-bit var if the flag is set.
> >
> > 1. https://gitlab.postmarketos.org/postmarketOS/pmaports/-/work_items/4431
> > 2. https://github.com/systemd/systemd/issues/41279
> >
> > Signed-off-by: Clayton Craft <craftyguy@postmarketos.org>
>
> Reviewed-by: Helge Deller <deller@gmx.de>

I'm putting together a pullreq with a few recent linux-user patches so
we can get them fixed in rc2; I've included this one.

thanks
-- PMM

