Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F90FCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfp-0005tq-Py; Fri, 06 Mar 2026 10:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfN-0004na-GI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:45 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfG-0002n0-Nv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:33 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ae222d978so8965236d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772809229; cv=none;
 d=google.com; s=arc-20240605;
 b=dnxF9d7M5SGYbjQ312UBIbFRAphRZVnq77+5fgBfy9rHhNmK4VMbu3IAOq10jRGZlj
 HyI/4lEEJ++vX0itGJHnz9Q37w1G1QeLLNcvN70NujbyedfB4PR5kpt9XCCkM5F/wvAi
 jKxmenqFPBp0T3+jm8b5CZEaqeOiqp+fEiIMMzycL5uCCAvNAtOx4izxt4oEh6ID4M3w
 kCLxpSqP/tWSpLQcSuOYDTQYyg+2xthisJQZ4qRuXEizBfEHmnREls/fVBpCJiq9pEme
 ei5eUsoJFSkI6whzA99hELQ1+PDeMqWpEGovHbYkQSjP02YCpcxjd/NdtNI8p+/cKvdk
 9w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=omPR7uI02WgQEWZfPFsGxpLQr3uKDGU/PPOW2eHyoC8=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=eogaXplmpDwK3ksF9gUNmKAy5NdMMWJ6FBt5OWyTcbK/eL+/a0L20j1DMB3GfMlVIT
 B1XKAuc5XkjJzCotkcyIjWlqqPWsDF8ku20GCBna9LE3+9grCRDEPhVFgQDPd8uJQwuI
 lN4sj5eY9FmoyZTMMnHcDIjDVzSqj2aBfbTx9/nr6RkJtuwusyYGGREJ5X9Ss1dngPIE
 4vP2YS8RlfY7yphQ8Dh6j52/T43Nyqks+6NQ8Pe1Q1h2p3yAj7a5szvE3A45+nGtuFf8
 YQR7VCsQg9XzVoK6XahEiDEgfoxqWXs8f3jLtqqI5VSsLnUpDz8rLOdKuxXZsq3ysV+B
 WkRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809229; x=1773414029; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=omPR7uI02WgQEWZfPFsGxpLQr3uKDGU/PPOW2eHyoC8=;
 b=eEoWingV514PhSM57lEskNO8RTJGNsI2yA7TPnhl1MnJ9qJXo5UT/Hp08AAxdHPz4D
 8XWmnflUpiC8qddCWmVu/Sw2n0K4XYonVqjK3TwXF1IUj4SxnhBG0Q79aQwY6UjMR9Ze
 CBS7nsWbeatCRxOg2RT8TsLK3zjpzMGEWicQXJ9xxuTWbduUtlJe20/+HV2euvQlquwE
 QUhmocCKl6KPh3Wf9YdWwsbbEDTWqq4ehhNs3G38CqxCxPd8gK9bHRNDrSX/ngU4ow4B
 M0cRSmTX40C8Hu69xHSDhCSCjCvjq/Zk3T05JRsKKzaIhvV7NuVeGyRtQpyVvX/Mbhlg
 lANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809229; x=1773414029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omPR7uI02WgQEWZfPFsGxpLQr3uKDGU/PPOW2eHyoC8=;
 b=qPYJ2Ca1+Ha23f+vVLNd6m1XUK384dWRuhP+3o5veLXfC2y9KEHjEBlFmTNZkUDJHM
 LalR9BqMcqgkPNt4TaitppUAwevsDTG0OA6LN9WamVYvpnaFsxATvSRHnRZI5pM9gNUh
 g2ltMEAvfKcLyxzbk0uLZoAgNHKRHRGxQrhJzJvnLAeP5LlDhztfyDn/shmco2gTYgxB
 T63Y+2yx5ENIj4L33AiKfgWjfGWNHeWbVmoFXk7OLHuqEIkbGFtNsGsiq3mnycQXLTdc
 eqek7LFIcJmvQe+U5+Kf/aHIItnJ6syPunzYdwaUzZaqoqQ0FkhuOTlVK4tmH9UAU/cC
 gA/w==
X-Gm-Message-State: AOJu0YwMVG58pfM/1DLm2Mq89GuRGrocly/mf71Oto4PfbLRSAoVY8OY
 a+ymz0YYHW+MDM634JWVfdDttd30KGtAgbPK23Z/aL5f5KoWI5zTysFgtrvcX+GBKiDCTyZDYuH
 99613iTS4aZWhWLPn4ur2O1E67nfXT6WvfZFN9A074Q==
X-Gm-Gg: ATEYQzzTkBTduAafsF0RCXiUXRrf/DkYqm0dvHYAK8ydK7zYfU4d5I7Q6WQfg86RY9C
 JZ0DBZ6Bw1lurJPbaCRYK7G0k7Mo11i/Y6xkzrNbIQnhowgM6h4xAG/XrT4TJq9wX2UZ/UTZeIg
 kvSmxF4J+oO0w4MvCtAKgCcbUlVVrhvOlIPZEKWaaUeIUGvg2lymq1dHlqTFkiby8nAX8pTCUdD
 X8/yBtoV13Z5oLXARfd9umvgUZw9LAY4ph9iw5GX6pWJ55ltja+8LQaPmjYFS8vtwexa5fmOXSS
 K0kt+AZ7NQnFS1mt1jeVakWH+qWBR3lb6G1qqnynYUenS0MICCQRKZ8visK4s4ZR5/A=
X-Received: by 2002:a53:ee59:0:b0:63c:f5a6:f2ef with SMTP id
 956f58d0204a3-64d14350b43mr1716150d50.65.1772809228410; Fri, 06 Mar 2026
 07:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 15:00:17 +0000
X-Gm-Features: AaiRm50FXi7nvUIFCA8L7LcQNmOsMY1KgIg5upNEXL1OUavb9TAmYZ1JcOLVXNU
Message-ID: <CAFEAcA_aD3LACyP0-7A+1s7Zt6p6iY_Mfz3QWW7Xp=chnFaiag@mail.gmail.com>
Subject: Re: [PULL 00/12] Plugins update 2025-03-05
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 5 Mar 2026 at 20:52, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 314ff2e07ddc6163554077d68aed5d76a50b8e3d:
>
>   Merge tag 'pull-request-2026-03-05' of https://gitlab.com/thuth/qemu into staging (2026-03-05 16:58:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260305
>
> for you to fetch changes up to aca77dfd90c8a17a2b3526c5cc871cc410357a5f:
>
>   tests/tcg/plugins/patch: Free read_data in patch_hwaddr() (2026-03-05 10:54:09 -0800)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH v7 0/8] Enable PC diversion via the plugin API (Florian Hofhammer <florian.hofhammer@epfl.ch>)
>   Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch
> - [PATCH trivial] plugins: add missing callbacks to version history (Florian Hofhammer <florian.hofhammer@epfl.ch>)
>   Link: https://lore.kernel.org/qemu-devel/c4ecefb4-8769-403f-8420-8bce42e43e13@epfl.ch
> - [PATCH 0/3] tests/tcg/plugins: Fix sanitizer issues (Peter Maydell <peter.maydell@linaro.org>)
>   Link: https://lore.kernel.org/qemu-devel/20260305161531.1774895-1-peter.maydell@linaro.org
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

