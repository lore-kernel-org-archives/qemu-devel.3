Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CAC1091903
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Hi7-0005FJ-8N; Thu, 19 Mar 2026 14:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Hi5-0005Eu-RW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:03:05 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Hi1-0007oL-T3
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:03:04 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso1303947d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773943380; cv=none;
 d=google.com; s=arc-20240605;
 b=RVopJPsk6EKS9ireoB9jaLy45RGbkSzh8nVIs9OzBUrGkkXBYh95iBYroFpbhZtGMC
 KPPAjvz4UI9iy6DX5mVSWmhlf4ge7Y2MJUcIPF5tG0ULmXeMRlzS9p3EvxcCO7hvy53R
 LR4VxUASHL0s5Q9b4qzpKteQWE23vsKfsbvEOcoOa5htE8xex3A9eWGvL5/PPCYlw+g8
 CfnddcNgol76YKO7cvf8CGkSv1NeM+HWc0NVxDk4XM3gyurH1LRALvjy9qBapgiy2ORt
 YDXQJteaWOZjSYIYohbSREfO0BGUxt5btYXmrv8K9tb7WY9mMHRmOzxPK3eftx8TDmZH
 1TWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5vN6LThXqAik1x2kFTxo37hFcyrwMiOw96Avw7nS7Bc=;
 fh=K72bYlHqvvWYEaJetWJrCHpy4doq0nZwJXIHUGtEaaE=;
 b=aK93QVHKe50iFpZrtdtWfcQmRjEjjofQ3J32Aglukd0M1Te+uhDlg4i5hDd2R7J/ZL
 1YGuhfGRr/b1tSR0vLkfPQwv6s/QsRgGF3pXaFTJCcQAkGfXVVCzShP6eUI9ch43kdnE
 VSeaYewhsBl7uJtod9PwY9EbRzicJD/cv+N+RkPY4eT+1jw5W3Twz1kb2etNUMeKDYUC
 pnJcsp88tjuF9anFqDBugtXU2qQgkYNfcYzAlJQGl3EwqlXk7fY/pfvFl/ACQyxsAqRu
 uQXN7JCvQO+mOymG9/wWERU9ZYuCsDsnizOJCxRpmVB3rL45RxqBNtvLLC+Nw7nFK4gN
 eShw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773943380; x=1774548180; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5vN6LThXqAik1x2kFTxo37hFcyrwMiOw96Avw7nS7Bc=;
 b=DZ07VwtlZnCq3Np4pYOESPlNt0lJ7nWArv0lDpaCkVIyt6m3uSQK7x5MfxO4ShA8D6
 qDWLgOlFKBHzY/0546eg1JW3h4uuPjEp7zt63lVnibfdSycyCtAm1HxrWcadhdGj0lBV
 j7WR9cVns3caQ9naf+kJXiej65pO3iXlWI+DUt+rTN++UZ/sqkkezSPzI5G+wRkHKzGr
 JExDHRiujFra5j8DOfmczKhks90UCaTChtlBVZDdZJdRHd5J3sBSYO8/YrdUnyc2+UMa
 ROS/E/t01eEkR6WhZV6REMro/U9oH6UFzuso0JRg9k51pWt5xQF+8M6mLaIArH4v0tuf
 d6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773943380; x=1774548180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vN6LThXqAik1x2kFTxo37hFcyrwMiOw96Avw7nS7Bc=;
 b=EnHZzCbzitNRPCuNEUyErm87uM+jPM0JkTk7zDucd65qv/bm785QO+E7aISNDTVG0f
 IGFjRpOifUIZfMdsW97BHWNNdMrv7+mTwzyksSyBTa9K3nPx/YP/yeVZzA23qhkMnac2
 IaD2ze30unE1PeLmJAnrRhOE4tZS65ToM60RIRt+v3pROXhOiwbxlT8qkEd3lyls63aT
 SYUNNcZunh4EhuI03iNOwlJB/3sefCoALFUtt1khv2/EjjQMr1hMo7vhd53ySsDDx1Ru
 rwjxn/0RLqIvuasNWTcuWyx20CLBwdxoq4bYU7kwQ2uWCKLsKh5hzmF43NhvSOrQGuDy
 zcaQ==
X-Gm-Message-State: AOJu0YyzqmLg6JEuRmGW4hOU0G8zBqDtPOASdUsDTIgkQfJfQ6Uy62X0
 MlWV7imV5UMJvZxuyxvL7xfQoe2Qz7TG7s1av7YRK9ZhDCMlRSxzBBTGXZXjipd3dodZPWJB2M9
 U+f5Fi9i3lloLm2mUREqH3hfNk1ohmZjxrWqxOiO0tQ==
X-Gm-Gg: ATEYQzz/GQULJJOfB8V3vV/+20WB7lkIk4LraRvhBP1Rt0jzb00n7yLaCtOEtprztim
 fz9lkSLM9xujArRFf821CZZJo82/NJ1IsAx3rmVjXxWBhuIc1fUTjPucqI4MNjYCbQks9aU2YSi
 Tztetl5+tqRXpXpygEuVJFWzv8rGmyE6LrMXsVQ/po6dpSLtrOdAcYPqUM+md5FDq2pfM6Xjixg
 0DPejrJANbQQfwjx2VQ9VHGR7fAL4tT4yM+pxmS9edelqRKVPltg3H4Cp3nEwqIUXq0EuPOEfqV
 88dvHqPwl+AEOAzi1mGmxC/J4z/Q09rgH3ru3bw9xVCr2q+/rAYZy9WUtnw/m5x3spc=
X-Received: by 2002:a05:690e:134e:b0:649:603f:7026 with SMTP id
 956f58d0204a3-64eaa6b857emr481051d50.15.1773943379876; Thu, 19 Mar 2026
 11:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260318141415.8538-1-vikingtc4@gmail.com>
 <20260318141415.8538-5-vikingtc4@gmail.com>
In-Reply-To: <20260318141415.8538-5-vikingtc4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 18:02:48 +0000
X-Gm-Features: AaiRm5008z2GZ3CXUQFGI-RdyjT2o55QknahsM_RdTyI6T2gnKl2RP-9Dar7xdc
Message-ID: <CAFEAcA_MYs7x5xAJNWHznbjM0cd3TNew8dj5Y7uFgURttiYh+w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] hw/pci/msix: fix error handling for msix_init
 callers
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "open list:megasas" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 18 Mar 2026 at 14:16, Trieu Huynh <vikingtc4@gmail.com> wrote:
>
> Check return value of msix_init() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - Use errp parameter to handle failure instead of NULL.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

