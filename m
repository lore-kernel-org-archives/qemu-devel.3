Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFACFB44CA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBib-0007Rx-Ms; Fri, 24 Apr 2026 04:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGBiX-0007Qr-L9
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:16:53 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGBiV-0005Mg-NN
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 04:16:53 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-652f220595fso7886335d50.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 01:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018610; cv=none;
 d=google.com; s=arc-20240605;
 b=IJPLDgSdkjjGkekdFk5wcR1AX54wsS0HSP4KEFyWcluwNnFmbL24vWXgla9T7peZCD
 BCEYJzylcntf7WxufDpTonuQGEl37GObag68w1xzyyg7hsHRYuRsgk0cJQ8UsJQ7BXZH
 XntYamnhIVUoknDlOv4DCSZT4g5sS3XWwTeRxHeX4sFSxETHrcgjld6kqcSH+eK4RNhh
 OfE82GKjUdSGMSnJ0I8T0P7QvujryjYw/vVC/8ikOfyojfYO9VHB/Yrs7JCuQDeKxcjy
 hoI5VBHkzxuX1hjNfA4adHKqpX4Ue+KnkHbMlNx7F3zs6idcmJETrp89cdq6jKZmoAYg
 PdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BZDj/uNwXjz9ciY7gP9yfKn6ZQSybqJFnCXISl5FlHs=;
 fh=6JkhZD/WRwXWsOKk60JUW3qYTMLjdT6SQGLJoYd5I+k=;
 b=lCxX53WdjBOEhAUPkwjxW4lEpjKjBUi+sBndQ9aXJrxbniZhflZMyusOyxfn8dzhR/
 aDu95B3GCdD04ptgD78o8/BWeAJzTn++uJh4QZh4AZ0geRvTRMn1Hj+5mxV1r3pOqCVO
 v8JELJ8/vcD1yFn7yiiM+wTcDd/QnA0t8uQ7SS5EXJKyRbb3ctHyb/NCag+KKhiugIar
 hmIyFhrCUrmzs4VN8+e8L9wN8Fr7wd9RoVQQ533Pytxyj+aL4bislgSuwanLzQkIZkzQ
 nR4t7xjZqgHW4UPqO0XG/vV41eJJOg35/s8uf6udM+2kibh4I+GRuYXOon9yzzW2DmDw
 +rMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777018610; x=1777623410; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BZDj/uNwXjz9ciY7gP9yfKn6ZQSybqJFnCXISl5FlHs=;
 b=pjFuc1hfy6FTOoJUQIWFU54z4fWqN6XxIPfL7H/0gONiw9z5PWLTxnL+GiBwXOxIAl
 ziRxAC32POUM1bjigwIcBBD/t3SE2B+FpAS5YZR/Z3r+h9+E8vMDjt1DJXNILjxUCyQW
 4m8qHNtZ3Iq+5m6MOgBR7hFxdAqgpyRLzwEIo0KXkh33vUgybBkd9nYhAg0qwkAqO71u
 m1VEWLy4dNrLWYxn50c6vnmC6R9MB4lKyv8JtpMivmU+8kytktCisOb+qLU2CyRoNsDf
 9jGEugQYy7nXu8iTrdb4ul8FTr2+0bxPltqh0liPVc0BgEY/O0yf+0H6VA80kycD+uLG
 rrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777018610; x=1777623410;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZDj/uNwXjz9ciY7gP9yfKn6ZQSybqJFnCXISl5FlHs=;
 b=A8+svaoUEjL3o5QEQTT+CaGqoaGKhnbV/K7yckalye6iRFtCMsrMxG0j0ZQvmb/yLk
 t6+3yN7hoDBM+d4rzBqnlFH+a+HOkIoiOhPngF5ZtXz9Z8wIMDlaLS6SEdR0ZVk/NbNG
 uXTHMQK2Mo6zgpwLjy0ZoNOFr9+T27RWjaN9EhPoZidTKc79qSPAuw+JV6EpR7dOUahK
 9L5T051SuWbQ9ERFpe2oHvE3NqPVgh3viuhemlXiyCm1p19qjgLF+6UmcFD/2fpdZDAO
 oKAb6LOeQX1MmzS581s8MtnKuvofj0xsg7F0kX62JTO8k9dhdHle9BgF7N6JjFCoAb7+
 8wWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cphYzKPLSdG9Z5j7ouEjf/NNhOfdDThMobqQu5pNL0f961VgoAXFWte9XpZdp/JxbGGxn5WW4WMfb@nongnu.org
X-Gm-Message-State: AOJu0YzZ6fcTiGWtXieNbJsNIp4bmHDsbvAUeQROPB0ukRbO/ZnLhn5d
 SHISJ0j+u/IHSBqSjy8oUrTexlP+95yM6sHTdwfmLYJC/WkI3M+qbYc6f0ndgc0SxAp3LYOM39X
 PTfgjdc+mFh0B5Zsx9spXKVxDD/LUBG1rYuKFsLe4Sg==
X-Gm-Gg: AeBDievauEAPkSKqUSsVJeyD62Ya3xdzH1QUdoWh/MTar/uGz2xYo8vJZg8jIe93wJd
 n/O8Sdd6df4rVVDzByRdjMUpWCaQdxbIpHzqKdvWg32Aj8hz1XF2YhzonUig1zG1DtZ1utdktyg
 GK9aLP1KVrFrgzs+NX5ST3gAvi5dchmdJfuDpbLVfWvt+GNVNq0TwN+oyy1/Ats92e/uenh0gBF
 KqwvlgfwHVvIfRr88pSm8PzzU7ptnL3Q/vJLkuCxYn8klpi4HQlvoGswUXb/h6AGfgTK9qUnmWA
 bScG4vThLME4UaAsHz3A87eMTaqcCrmnbY5O9PufM/POAFauvNNNwNzF9gs8Z85ePcsVkf3vDR+
 EuA==
X-Received: by 2002:a05:690e:124a:b0:651:ccc1:b4f1 with SMTP id
 956f58d0204a3-653107b883emr28442133d50.2.1777018610100; Fri, 24 Apr 2026
 01:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260212104432.4168886-1-kchiu@axiado.com>
 <CAFEAcA_u5B2RdVEaGycCQ6gCx1pQuT8rvGVGZpoKLTK+2s72+w@mail.gmail.com>
 <69691e3b-1605-4a5a-8ad5-0eec56ce3eed@axiado.com>
 <CAJy5ezpcvp0Qy-P9gE46oDtsxZxNO=xMV1k-GC3WF4yY3gARGw@mail.gmail.com>
 <CAFEAcA8mC4TkicLy9bcS8NYMDNcSUjsataGGmkMpViw4wBvmCA@mail.gmail.com>
 <CAJy5ezqTAMr=A3uAfmuWLepK66AdLRu4Q8AmFMh4+4q2HtDrkA@mail.gmail.com>
 <CAJy5ezogVjNxHLFVBp9wd332kwyR8peBHMEjoALg6pYfVk1q8g@mail.gmail.com>
 <cba7059c-9472-45f1-8fb2-06b26036f958@axiado.com>
In-Reply-To: <cba7059c-9472-45f1-8fb2-06b26036f958@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 09:16:38 +0100
X-Gm-Features: AQROBzBnnWSysx7Yz3VKl75g8CsUNz-TtcznwmdN73oG75bQJunedOsTrWy4fzo
Message-ID: <CAFEAcA_jAyW5a2uyF7r=FBsw1dx3CCoVkU3hkxqQzAgxThYJEQ@mail.gmail.com>
Subject: Re: [PATCH v1] hw/char/cadence_uart: Add BXRS register
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 24 Apr 2026 at 04:08, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> Hi
>
> Do I need to take further action on this patch?

It sounds from what Edgar says that there are multiple
versions of this hardware device, which suggests that
we ought to have the device have a "version" property
or something similar so we can select the right
behaviour for zynq and zynqmp.

Checking whether there's anything else missing in the
new version of the device might also be a good idea.

-- PMM

