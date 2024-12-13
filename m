Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B1BE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 10:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM3AG-0000qL-3b; Fri, 13 Dec 2024 05:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM3AE-0000px-Tv
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 05:44:54 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM3A9-0001lU-U8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 05:44:54 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ef7640e484so17030827b3.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 02:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734086688; x=1734691488; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ueJ0fIqiixYGIqO3mn18XkqiNn2ZKzF5mkB7L5BdiZM=;
 b=Oc9sT/w5DfxYKbBRpl7MtDpVv6b4d4kgHMxfqNw4zjRWs22O/mU3W843I4CmOlQs9r
 Bua8fBhuxLXRTZ3BNieasriSMrbRI8qIWsFJweXajikBKKo/fjhvcD/AZVi0FuokBAgu
 0WmGqy2DZqM5rVY16TMmehU63o7Cg+YMoFrgtnE0OObM00oHXl7bD4cV8pbW4Myttl4x
 jqk4LQaQrsoB3rmwZWVOYjv6+fIpbxxfZvByaHL7+oKdi87wxuAYINplviPlj0JBRvJ2
 hIdKQMWbmNPvipJzSa+8EqMGkB6hbXWwPRKEdyDAuXMo+gwp+G4AJWf5ZLX7HeNzEKZt
 HdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734086688; x=1734691488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ueJ0fIqiixYGIqO3mn18XkqiNn2ZKzF5mkB7L5BdiZM=;
 b=Ajccu2FW4XTGoxTHezhaSjwkkFLABTnszNOrZ74iTWAIBeqY2IArOCzThlAn8HAAkF
 TDk/xpcokMfIraqN9d7sAN6hQWHz81EtnMFHpWJ11sAeX1bcHaHjn2IgA7qAWiDkh/Ss
 mG96JXf5xoAn3p/Sc/Ow55g8C2IX/bfXUc0o6pf8h3dQloTMtSzSoIVRRfHH4KINVkld
 6yDgXVBQ2Fb2kzlEB4rU8+jYLsj/3yiYmPdErQ4t9L0WUZfcTT1+FV2KvVaEKmWUq3xT
 s5s7/32G6iRNnq54Zw+EPVe9URnOTr9cjj1yYJgzuyYiyuh6zOaoI0Syo0p5NDcCwt+I
 2wrA==
X-Gm-Message-State: AOJu0YwVhAZjBJJ8Tu3ISQQjOEkiy/eVHTGoSYdQsLgkswQaaC8kAtuZ
 h86rbf1f+XEolQUdHrNSnRVuVSdT5mheFfo6DabuUNbccsR06Sm5Dwypbz5T0NJuedOGxH1jiu6
 x97dL4l9rl1ww2+C+sNtiiWqGRIAKnJPF1EZcog==
X-Gm-Gg: ASbGnctmLgp3CAb1NFVEV7r3iqapdWZ8VLQkvwnUJbE9qKcbCwvnkjLQc/zI981sJbz
 4iwbo941Em86ForDvXHsQUblk9RUK3k4lJ5oRMX4=
X-Google-Smtp-Source: AGHT+IGCzlEmLMrsV8wMkd/S5/rwn5Vxc5mDfkjXwbBh2MqUuKdRGm2yBIODrR/zEjYhBbovg2H9MSmSxCyeL5LOk04=
X-Received: by 2002:a05:690c:4a03:b0:6ef:366e:a6a3 with SMTP id
 00721157ae682-6f279ad2b9bmr19541467b3.9.1734086688327; Fri, 13 Dec 2024
 02:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
 <20241213012055.GA395412@fedora>
In-Reply-To: <20241213012055.GA395412@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2024 10:44:36 +0000
Message-ID: <CAFEAcA81kmsa2DEU9CXXHQnBTUpqeaOV_N9qGxaLaV_wVKtOHQ@mail.gmail.com>
Subject: Re: [PULL 00/72] target-arm queue
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 13 Dec 2024 at 01:25, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Applied, thanks.

This doesn't seem to have been applied -- did you forget
to push to upstream master?

thanks
-- PMM

