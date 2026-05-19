Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67CBCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLzk-0006ll-88; Tue, 19 May 2026 11:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPLzh-0006lB-8z
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:04:29 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPLzf-0003Lo-BU
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:04:28 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-651c5d525f6so3736184d50.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779203065; cv=none;
 d=google.com; s=arc-20240605;
 b=UwEx4OHi17cOcAfHz0E0v4aULtUhJ7suZtOA5sJ8P93tUrqcXzU+CYqznUhicaZFk4
 jmk67TdpNehZ8m8IpPYCXe01fbIIXgR2/pPHNZKWB+lPaLrtxRa82YzQnMpDGUvRPUoX
 lHmhAPDysBCp0oP5sVgfeK3ZgJ8XzJDOKR1dVFnaJPSk0pjmkn6+wCfG2CNISgB76OsM
 5MhFErIXB7HY1xvZ7owuVu5pe8Dkpl2mJ7OZHMoAXtfo7fZmbKtrazcOxyFBlnBqMNt8
 XBuPkSjqZ7CBnik4Qz3QY0/xyYsHVZQ3AbVfr8oaA4nDu1bSMT+1QyahwiKacjzNOnbk
 KpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S8Wto/x9NtWUK1ufa2ZlwBeiB9k6lIJaCu4Zldi4IxI=;
 fh=1STpx17p3U6+AkDNWWx9nPVxaD1qCZZFaiU9KtZT/KM=;
 b=fjTRoCtfCJgOv1UDrHB2rYDcOB7Lf0Frr1G9/Rx82QMmq/HfboG4T3DxBwesmewMKf
 4h/T8DjzAiwa5l+G88/75WMJ+6eozSO1GcfHROnlqupeYQghXvgZ5fi080uN1c/1ZxZ2
 fumXhniC4Rmzuofnx/ByyOQO7mfMZlHL1OqJe5cua6mfpwyAIioZCO+a0jNPp4waXKjk
 lAWfrWkEg3D9t0gBGuPAtVqkUZiSDvCXY1ljV+9PdgRwYBiTPIKYoj/AJQHXdOM0CAVc
 d8wpSiEPCaRjlFwq87EooWp+HKK235GMQ0K6TRShlAZCckqHToVByRmcJdQzAwasLlYq
 8mOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779203065; x=1779807865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8Wto/x9NtWUK1ufa2ZlwBeiB9k6lIJaCu4Zldi4IxI=;
 b=d1V4cPolNAI0R8dV6MiJ42snRXx2m8GrXl+6oB52TuIFr2/RFyPN6mWieDwHAcuYXz
 clfRkMSE0AKvBw2YSxaI2M7TdD3HOvczhMPdKSahecZAF9KfV6z18vewztPb1ADOEoY0
 AIq5Tnnm+znl4WOWzNvZgg481v9vHEdoHxPxNzV7PO4xElwst4K8UlTE5X2v3Joc6L3Q
 OgpX9u/RcoMGLMZKf24kp7BkytdsA2jio61vW8uJcZijXYSoxzZg0wBioDd+pPhTBLu+
 0erHhy8JbZQpht4FC/kBvPnLlgVCZMNpbOqC2nL1HI6rbcCphUH9KiYXdezhsgLsRUd7
 2EMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779203065; x=1779807865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S8Wto/x9NtWUK1ufa2ZlwBeiB9k6lIJaCu4Zldi4IxI=;
 b=OvW1UuLE8iTd9hHmROIOe+KeVuKuAbU1Z4GXRVUL6CwOYml1W7JK4JICkCBjA8M/y/
 CbFMQVvGba1KDWJCcEcOCZlHDWD4QVNFs9zA65vqoQ3qGwxm/3Bh3Ub3tHGK9yTJIRNQ
 XOK9RdVL74IdoAR8Wgcqym16N9a5Zq2ofFEHkyY4R+IGcSsTssYqO5wVyDpm5SYA1H3E
 pypX9QbIcqTiNWzch3cxNTTe/iTBhVuPrhvpLqUySqgyons/9zmwYy/Jan8zlu2sZvQJ
 Xtw/oEbk5RafaIaUuXcHVTTmmx0vBTf1lFncPLa1nUlU9ulzxIBAon/BHp/3Z3yMbDQT
 MLGA==
X-Gm-Message-State: AOJu0YxBKAe4MeFfK3xXtoLu1IaNhgRzBucpqWTITiz2h57nysvLzg1W
 Iqt+thJKjAUo6aKVucPMVJYFGsyQlIPG94SNPtjbtyo8I4jdzbiPW5P+cybyQxNGKhmsDy1xcUa
 2VxRMxtf5RT0mm2GWez+Z8/eiG2FiM5xA3lO/UArpVg==
X-Gm-Gg: Acq92OFZdE1DP3j+COSI0CvpFbKPaYsD8JhobRLDJFf7YQgWYnLhJj5hFHR7MDg2S86
 0BWxgmvX1fC6Iwe2H0sHuk0l8Ega7FjZu7iayjZt3+U83wIIL9PxYio8Ru/CHsIIEQAss9jWhph
 S8tG4B3r2wwGd+TFD5YJyFPQDuE5MM+ED3KSdEvKGhC34+akM9tEin/ILGAkMF9/AiwUKeoMnDv
 IufHJz7RmG68lPJQ4APA4uNcC6ENk/9XjxMbhCCztrDwdmNTBUiyjgcPAtQg/bSzuZujvz43uLV
 2FQDDhcaNss+hyOqM7HwNSqzwsmf78KL39ZNNgiE5wyWZXEByn87ypZn97m6o+Tif0k=
X-Received: by 2002:a53:acce:0:20b0:658:9bfb:602d with SMTP id
 956f58d0204a3-65e22807a30mr16091401d50.38.1779203065027; Tue, 19 May 2026
 08:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260519145859.91999-1-philmd@linaro.org>
In-Reply-To: <20260519145859.91999-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 16:04:13 +0100
X-Gm-Features: AVHnY4INzwGHoBWP_gTDIq2_M2J7bRTtw6dmskHmUoQOzKxYvpbfsuvyFDDi9IE
Message-ID: <CAFEAcA_tePD2XH+YsR4mepYL8K+cLBmgPKiK23pa+vEVwBhobQ@mail.gmail.com>
Subject: Re: [RFC PATCH] buildsys: Stop checking for ESA/390 host
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 19 May 2026 at 15:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We still build QEMU tools on 32-bit hosts (see commit
> cf634dfcd8f), however no OS supported by QEMU still runs
> on ESA/390 (Linux dropped support in release 4.1 in 2015).
>
> Remove the configure check, directly checking for the 64-bit
> z/Architecture.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>


> diff --git a/tests/tcg/multiarch/nop_func.h b/tests/tcg/multiarch/nop_fun=
c.h
> index f714d210000..26d3a76eb62 100644
> --- a/tests/tcg/multiarch/nop_func.h
> +++ b/tests/tcg/multiarch/nop_func.h
> @@ -15,7 +15,7 @@ static const char nop_func[] =3D {
>      0x1e, 0xff, 0x2f, 0xe1,     /* bx lr */
>  #elif defined(__riscv)
>      0x67, 0x80, 0x00, 0x00,     /* ret */
> -#elif defined(__s390__)
> +#elif defined(__s390x__)
>      0x07, 0xfe,                 /* br %r14 */
>  #elif defined(__i386__) || defined(__x86_64__)
>      0xc3,                       /* ret */

This one is guest code, not host code. We might be able to change it too,
but that would be separate from "we don't support s390 as a host".

-- PMM

