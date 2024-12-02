Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0AAD78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7Wg-0006lr-L4; Mon, 02 Dec 2024 09:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7U3-0003Cr-AE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:33:08 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI7U0-0004Tz-AA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:33:05 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d0bf77af4dso3372011a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733149979; x=1733754779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PqJJr9y8Dl0BPwYB9bun4zqq4pTFEC9sPqFDoiAozPQ=;
 b=awgMwydzzPlkQgRia0rql6tnYfQRXpNJUhxs6EYCMCnJ/urIDIOjHGCqAWM2cjZFY0
 ABRBEVoZPbDCfwBNbpttjLcOTMZAq9BBIeC9KReUEtwK8+bzXeY4cwstTL5YcgRCNT9i
 3HMO7yeq5zq5whmnfzsSGgzK6QIgXfSOaiLqSSYFNfwIAXDpkJbNKSEPRzJxT5Xww3GF
 KxltA5pm3R59JC7KdMLGSnQf3ehyZIWoYTNgzEvPH/kWcXpvCvNGuFUelIXr/w7hZQXZ
 Ys1HkINte2dJ9PYTXZYw3u5mYuH5Fo+z8VWLpmi5FjRhFcJpAQyHL6GwuAIXa8y4XaIO
 c25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733149979; x=1733754779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PqJJr9y8Dl0BPwYB9bun4zqq4pTFEC9sPqFDoiAozPQ=;
 b=Q08cbSCP8SgqeMSVSL3fgwdBYtulr9QvuDo7w0g10ZtAL/iBfHqnF0QEwthGvuYxjQ
 /SvOeF9d+7CYNsmFa/CQEbOakvW84YfjZx8gBqeihAVZzjcU2ll82Sz7gm4uwsV0eGy/
 oki7/v3clIUDQd9RGo9sv7cOBd57rpAjA2m0UV02+eO+lJQmPpXTIOv58e9S5G948Cx7
 h8s3LnRWgUoe8BFfBEzq6rlTMYtefAGZ20RSErHZx/eNMg84Oe6vxHu4WW8V+lzyz1Dh
 d+Lm0cLbRdszaTSk69J6XxaOSfwm9LACZagedH6hD8CgOV9rPykJJc+pxkBcIGtxfOZX
 kpOg==
X-Gm-Message-State: AOJu0YyCTc42hiVKJw+CHX6yoRnwHD7zIrMw3MwrqO54I7F+CjDYG9gi
 ekSun8zyZAVV+0tnYggEbSsIwip/5zmtauyC7MjPc8wH11a+nlGCRJ69MGLbZiTG4PfaGbhlCYW
 MCHe0ehC3i7UDTZi9DzazfBiSzGlLuZWSVs8AMQ==
X-Gm-Gg: ASbGnctULEbG0cX9y4eoeZOPplOXsJVXRFtf8s8nRd9CEzXwVgR9qwlwXQx+6CQVYTr
 M/bdVOL6ydjCETy79mk8dCv9nqjC8rP5P
X-Google-Smtp-Source: AGHT+IFb5yngGizHx6zB3tJS5gBTd4t9Ez0WcGpK/2oHMSqE6ame/3b3N9Dx19nIe5aVxoJjhGZxhJcLjVZQIr46BZg=
X-Received: by 2002:a05:6402:5252:b0:5d0:c755:4d85 with SMTP id
 4fb4d7f45d1cf-5d0c7554ff6mr13363582a12.0.1733149978941; Mon, 02 Dec 2024
 06:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20241102125724.532843-1-shentey@gmail.com>
 <20241102125724.532843-3-shentey@gmail.com>
In-Reply-To: <20241102125724.532843-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 14:32:47 +0000
Message-ID: <CAFEAcA9-R7sQ_0per6PEOjw-She10XkXNKdYZb4sMm2ALn_sDA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] hw/net/lan9118_phy: Reuse in imx_fec and
 consolidate implementations
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 2 Nov 2024 at 12:57, Bernhard Beschow <shentey@gmail.com> wrote:
>
> imx_fec models the same PHY as lan9118_phy. The code is almost the same with
> imx_fec having more logging and tracing. Merge these improvements into
> lan9118_phy and reuse in imx_fec to fix the code duplication.
>
> Some migration state how resides in the new device model which breaks migration
> compatibility for the following machines:
> * imx25-pdk
> * sabrelite
> * mcimx7d-sabre
> * mcimx6ul-evk
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

