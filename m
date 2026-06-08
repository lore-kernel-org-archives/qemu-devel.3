Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4C8CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcxh-0004fS-TV; Mon, 08 Jun 2026 12:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcxg-0004e1-Mt
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:36:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcxf-0001W0-A4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:36:28 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69165354c87so2403832a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936586; cv=none;
 d=google.com; s=arc-20240605;
 b=PHrBBtsFqzSqqiY96hQ7FhnafUwKCSaldmVxylprJmW5sKI0vtFP5CsLXWx/SvKoon
 wGY2DDUXTciQC5ftLI8LsEx8iILoKZryx49Y14lKQ+/cSl4Ur1YaHDCD1yj57BJ4913G
 CvjwuAqCqV61cr16nfT3ddXoqrjIUbtSXjHI29JQHFexs9nWWATzd3zqsn6Go3RPMxlF
 7Uw+zXSjKbHwApVb1AA7AcCWyksg6D0LdEpzVESNoPW6R2GWO2pkTB8KEWItUfgDNXc5
 MqJmiqCrptt0PRfEuPVLl75QX1DCCiKvMfJnlNbqrNFkjdC3/Bss7FuzI7Z2dmIl0vgl
 +MSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kotqG5Ye5LBCP9kExSR/ej4DX5cozJ7d5httb5bFsT0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=gMJzA/R8iAkI+n3liLYBXFeL6jUrIByM6267fIDOG9QBUdkZ7BWlCGwWLYkNpRA1Mz
 MVFy0EUv0IO9ViEPpSvSyB49w8RHRaQRcLkkG8U2vny29WzQZkveRp2oh71ShdSpKjGY
 EGfzv5Tj1RGSK7GddPnnSWBkBEvNkOeLnrXHLYFVxqbrjqkoKghQbovnNxcrx8NxVj9S
 3b80XA4BNoHu4BBH+b4dxvR4Hp2ziFZUZYMogPgqODD7L4+nph0D/Ll8q1b75wXx1wEv
 uW0boULch8PYW+oU3MFUzfpiqBNEd3fqoQ5ESiee8+psTNcpOoLCuEbUtA1iyUPlvjxf
 4wbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780936586; x=1781541386; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kotqG5Ye5LBCP9kExSR/ej4DX5cozJ7d5httb5bFsT0=;
 b=iOhZhNf1HUiaG1HHeegKff6gkkhimgeoqvcpvMjXainP6e6lIiZerejji3uGd6dzEd
 kb0T3PALMucH8JfPDa5NCN7FMfLML8j6mt4vxJNwmXTAStVXNURLYZvBWILkADvzRtS1
 yAnzNpU1N6VQbG/1W7PXR57bcLQVS6iBwc7A9/dGPjPUMOmF6LH71G0NbyeA/JfBLKKH
 xvXV/smQfisd1F+UW3TX8O/Cyvavy/AeMHeXjXTIAclHUI75GqaZxAgzEWOc7tNgbTP9
 XVeT1TV8+Z9St7Y5zh7wUYC8UsCJb4LXbJzC/uKnZlDmyK7gAs8jra4I1UVBJwUC5i/a
 UQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936586; x=1781541386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kotqG5Ye5LBCP9kExSR/ej4DX5cozJ7d5httb5bFsT0=;
 b=EwTJ0Ui1QSJtUbkwxPH0zA6AVN7U6jKqFGb+Tq43zFMHngB6Tvstv9Z0XLRpTW3uCD
 1eeLjS7NT3fABrXmAQIdGd+qXtDlijE4UHoOYvjNoZftc6FH2zxUDSraD4d83oCtxKXv
 msOksoiPTfM95jvIpqFeAE1t7m1VG1c6TdhAl9iH92dofVzwQWC9uwelcimNwj4Tbk6l
 BPLnmJc5RHYSwkQO/fHVKmslhjg6GkMCiemyo4lBVfR0b8DQKdEaAofDDBtgWhp0cfHh
 wW5DkfgypvrPMcZjBM66Tf9LfHTgOz3SSKc8fo9KHtJYyDZ0YGTsRpxxW8klxQ2nLkuo
 Ziiw==
X-Gm-Message-State: AOJu0YxTYUisQiqehOf/6IUOyoNf/7tBQunNeY35uw2E8lajNnwFKeOP
 0cTXmBeE1BbIILb+//aFaaNS50nDTf9XFrXf4/7VJjo0NzV/VSsy63nUmtzMPF+PcPWRDwjY6EW
 CKV3cF9ujAx7SAFiBnZPqKE0jve0hLLOFU0UY2mDUtw==
X-Gm-Gg: Acq92OHxqfVeH1nTkxO1n6XpIxTfCiDTaxDPJz+Z6oSdJA9ZPU4hM7EarKxUqeMx9cX
 TkMhbj9SZ7aB9ypYMs0NTPPpwpcwaZ2GDnaJsGFXX8ELwpchsha2qOcVTq4EQKldmYF8Je3Hnq7
 uwQ06nas1M6/4niEsUrL0S7vkGJ8MaBvK4zvjpFyzbb7I+ouqE2SOx9cpemtWe2ZDTd1ijE3dU3
 xSU2UCnDg2M9lQbSNiSmq5XPJ22RG1OkyTeiGWvHWRln2A2I/y8yjSBOoaPC9O7tHqZ8AT70hLj
 mhzD2F4h8i4Em5fFliup0loPcG9n1czhl4TJuzZtfDuybFTS1R5tpyZB+dExVukQxqakN0pt/Py
 Vog==
X-Received: by 2002:a17:906:df46:b0:bf7:a616:cafa with SMTP id
 a640c23a62f3a-bf7a616cc2amr126678966b.34.1780936585463; Mon, 08 Jun 2026
 09:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-7-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 17:36:11 +0100
X-Gm-Features: AVVi8CcKx1Ig_TwULcZODUCjVhLfi6_WnHdlPORQJVy7urKoxUwDaa4N1S_eFkw
Message-ID: <CAFEAcA_nhSBvR-7vkisJU2NcZkjT9xDsYGQRLi6A_NKBzCuzgA@mail.gmail.com>
Subject: Re: [PATCH v9 06/45] target/arm: Set e4m3_nan_is_snan
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 3 Jun 2026 at 04:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The unique e4m3 nan encoding is SNaN for Arm.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

