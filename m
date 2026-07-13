Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65414C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjDit-0002Ct-1P; Mon, 13 Jul 2026 06:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDij-0002Bd-Lx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:17:05 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjDih-0007eA-Tf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:17:05 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-668000f86d5so3184d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783937823; cv=none;
 d=google.com; s=arc-20260327;
 b=f6tRuvhRjtCwD2IF8d9OPvEWZGGFm3OnOsLV5TUY7q8SD+Kv2iosKW32yXbnIEuRPB
 1ND2QMcdaIj08/niTYQeQ7v/gWu/dfZ8GQkOmby/6IOie81zB5M3u5g7MOxC3RjIi+88
 hXTi25IXXI5U6kztJnkopD34bgutyg24JxFIPuY1F61dtneKnTtS/kCdK1cFw6URlP+h
 ZH0uCYxPWyVwBZzWW3zvgpiXVb8TOCGF6mfNaBTMrNXudhe2LUW0LMJo7oGQnShghCe+
 DVZTflMMI0AtdYvSiT8hfk74bN25OSgJQC/6VpKPU+rM2k0ZMsMg3HQmbtv4MrDpROUc
 e8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/nbOlOJ8IGlEjqeujQrvz7Y18z1id+1QTtzIe7MkwAU=;
 fh=Qa2OkYOPFog+x1G5mA4V31494fitPWoGQxwY2RYXA+M=;
 b=fjQvyB5UMWGI2jhT8MuNYk8lSzyAWIpUqXa7yiDtvjqDduoWekOj6pwlhnLZCK0vi2
 DtGA59OseTyE/YRUJhOYCA5Mfdv+G2OqZURexupl2xGUMVUuULyNBncvr49mKweQqbxS
 P8wRJoZqUOuowFV7LUuWGhjvv762xrMs5NIujyxAXN8182VMJNAkT9g7m9NWjjTTDo0H
 uFFbRZzqyUCSdyEknUcfrRXi9+O2EQ2/isml3Fuo82p+LVb5fzLIsvvb1FtNpG4k+kvv
 vRteaGdFMm3u61KplEvdeZ7Q9NhZ/Oxtry8MnWGI7NtP0o7eGh2akXORyfmbFMt5j6Gg
 1U0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783937823; x=1784542623; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/nbOlOJ8IGlEjqeujQrvz7Y18z1id+1QTtzIe7MkwAU=;
 b=U91QYyN/MGpmymRgqRhOXTO9eX9jAIhOcH336/uDx1600+C3HbeFGg1vZ9d/8vkddC
 /k4AcecLwTYEp2Aqw4oiSPmsqwi4S8eJnEly6VUDFyNycbp+SdwEUCgVxUCw72rqKS4R
 JMX5OhXOU8/1xoMmUQztWjc1ltwlBq4gI3AJzcn366E2obnL5SCPSKnmI2OaJFFltPkQ
 aouFSuSuMvN+o5ZWzpT7v24Bc4XA4r20/fAw4SbCYrw8zWYHpcSZDIxPlYDZYg9e9BZj
 CbOb8LRyltsj8prFZJusfW+tdaIKYlBlXsN4r5HhFx/ih7cEnqhSU9Umd8D9IlZhKNqf
 0aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783937823; x=1784542623;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/nbOlOJ8IGlEjqeujQrvz7Y18z1id+1QTtzIe7MkwAU=;
 b=KNcpzsk8UxpO2oTPZ7pyOlxO/0SBkXNx0HNgvFMWdMAll2ShIodo+8bv2ihgLa2Yw5
 rEoL/LLTaJVNfAhPlKxMGSpIhsEz5hhBFjIGKQyde3Z27Mz754lDtqy5bKSTIluSDVZa
 l+rI42aq7I1a1rXRVAtRJfbp9RYlHAb33NZXtiPuF7UMziIdTCXs/7Hdrpya0JV4Lvo1
 EoQ1KihjGiiplBbqbcW+uTWbcz2dSm7ZafoVcTWTGIFmh1V1WULPVhRCVJtuBm7jJY2x
 SRGxJ/HXZskx7dvMm2xL7M0ZOpG77iKs49jAvuRctJ6kWkHepXKI+g1P6zckkShJciXw
 sLwQ==
X-Gm-Message-State: AOJu0Yzko6O7kTx/4EucAWHKhriipcORfZqCUETOCYDp+xiO0DbSTN1k
 e8vA7EHarJ8JFKrgO4tXaEM/FJleEDzeYOBduf3lOpgCXRM9q4VS4FSqbyLp9hsIEBGrTj9OTAi
 scVjAEm6lXOJmDp/WQksdBPh9bkGTeGOcA0JOUSCjuQ==
X-Gm-Gg: AfdE7cm0Xm5Y4WAfbTs3g1c3qNik47AtdHgvApXOJKK8fAa0CNFZHnb1s6acC03jTtM
 9mMysgjwP7iDp3A6azLk4/+E5idpy+Hvk2zx6/hCiZbTRwBJXk8zq+A0W2ei5TTypr/cagNTxbJ
 UmaA5/hLbt+aws1AtF7VzBg0yf7zKwk6mDhfFVLl4EZfNZEgfNfEzjebbJTOCXysppdCWTCdY12
 Gl7ax0JrqcHtX0hYx8T1Fps9Pw9FIzAcapGY3OfgBBdQmczJkZ5vxlqraS6blsvAWAMmyUDw9Nu
 PIwqMbj1TgimZoNcTq9hQcGHI0WdjjWRLOmIF7qiLHaf5nIkNOd2c0rc
X-Received: by 2002:a05:690e:1514:b0:664:f064:f668 with SMTP id
 956f58d0204a3-667d7aec6e7mr4749443d50.20.1783937822756; Mon, 13 Jul 2026
 03:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260713100508.123623-1-thuth@redhat.com>
 <20260713100508.123623-3-thuth@redhat.com>
In-Reply-To: <20260713100508.123623-3-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 11:16:51 +0100
X-Gm-Features: AVVi8CfNLqzHzF41g8i5mpL1jzQOEecWrd9jN076uUF8LUHD55cJ9_5DcWXzAMU
Message-ID: <CAFEAcA-n-9YVVRr2G3wP0a7sp6arZS4Vmqt35TJY40iGM=DCSQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/usb/hcd-xhci: Remove the FIXME macro
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 13 Jul 2026 at 11:05, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The FIXME macro is only used in one case, which should hopefully
> never trigger: The containing function handles all the USB_RET_*
> values except for USB_RET_ADD_TO_QUEUE and USB_RET_REMOVE_FROM_QUEUE,
> which are both internal return values for when an async packet needs
> to be queued or dequeued, and which shouldn't still be the status by
> the time we get to this function. Thus let's simplify this spot
> and use a g_assert_not_reached() instead.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Not sure if some compilers/analyzers would complain about the
DPRINTF followed by g_assert_not_reached().

thanks
-- PMM

