Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CD2C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 13:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA8sC-0007xs-Ba; Thu, 23 May 2024 09:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA8sA-0007xL-Mk
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:52:46 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA8s9-00078U-47
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:52:46 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5210684cee6so8327098e87.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716472363; x=1717077163; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ynhGzRyr87pQBh0sgLhYoNHNZQ7rJJWetUh4AtMRnG4=;
 b=M/wuAOFWPS9+w/xmXRz/TTF7YajVUWHX4w3CBbJXuJdryHWlXmPEGyGjMRfVbdNDMD
 XwqPM3WC8y16dRFpV/YelSFhx8ThAuF9SQbPMGm0Ct4mhhdcX2/l9pRdmatjLH3GkKn0
 rPZTg7+JEW8za+kixI/Yp9+HYm/V/89li1NbTJEj6gY71vFQQHSZTTz4Y+L61nwKZiSV
 8NUh7MH1dJE84UJHXOMkF7dScMACMg2AigdSmbkJVt8xcvlFtC2661S9J8iBlqdRDkuw
 QZnqgK89pGTH1SD010GmmXDjJjczCSfAjQaSE+gynKUhyd1U5JaKaXJ4IjJpGeW2saF5
 v1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716472363; x=1717077163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynhGzRyr87pQBh0sgLhYoNHNZQ7rJJWetUh4AtMRnG4=;
 b=pPXiQQPfi1aMl7xuqiyp4H+aR//QXWSq4l2z4V+u0nYNk67xlGDJhF6QCAhvV0ZTce
 qjCzqAFZhAELKneG8B5gK6O5TjVSWvlroOXpg++3/A+1In3iUgEYbAVULcTWkLuSdspJ
 jgvoxLJgTA+e4Do7Fn7o90Sq6iMQyfbFmb7bVYmHYE+wOPa88nORb61Y01EC8iBoRT2T
 1M5SbciXNCVljWIpNDfvjxkk6+gCtc9fOsQIaoz7+NDU1mTqhDeZu9detqkPnOe0dydR
 ttdwelhM0YkWsTLHjKxK9eHCyodQQXASFj26UlSOr8NtGJ2cKRJkCavTEgrbAZ0vM09g
 L2Og==
X-Gm-Message-State: AOJu0YwznCkSguz8kUrmV25sdoyU0AgFBCuXz6WP5vhT6JlUG/nLg7jD
 BCTnLuNQ4004pAtCBiOnP7BqcZz2FrFAkyabuLXe1tA7E4KDWBpUJtDPdkBfufSaMUcipBj/pjr
 obvJBSUqEx+sf0voEEa5je0H/oMznHtHKrpjzAg==
X-Google-Smtp-Source: AGHT+IHnoYiTKPVu8ly3EsxAJ7tZYiyL0HnDi0BuOo2JQqRNelOs966Ek1Ik7zO7M4PTj8E7EjFKzrSUw1EM0IBZIec=
X-Received: by 2002:a05:6512:3e22:b0:516:d219:3779 with SMTP id
 2adb3069b0e04-526c0d4a203mr3760312e87.58.1716472363021; Thu, 23 May 2024
 06:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-23-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 14:52:31 +0100
Message-ID: <CAFEAcA9CFW8cgKG7atPqOdpFcBZ-91dkZi1ooAfirLgO-MPvkw@mail.gmail.com>
Subject: Re: [PATCH 22/57] target/arm: Convert FMAXP, FMINP, FMAXNMP, FMINNMP
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Mon, 6 May 2024 at 02:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are the last instructions within disas_simd_three_reg_same_fp16,
> so remove it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

