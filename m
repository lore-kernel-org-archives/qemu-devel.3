Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6E9C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCsu-0004Q5-I6; Fri, 11 Jul 2025 08:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCsm-0004OO-HX
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:29:42 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCsi-0004f8-M2
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:29:39 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70f147b5a52so15435877b3.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752236973; x=1752841773; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pu2rmRk0Olg5YPTNdz5DW+mcZTwlyaKbAfAMIV/bNaU=;
 b=VuaidlsQomUfOfBaG2R4KhytmKNXJTpIlAGMssh7TR9sPek3JJ/3VUJ/TxcmdNYfZd
 LECwd32gcVmxbLfS6n36KLmYclR6Iw0xLGjzySkHTSGxqBQJ5NfA73nRAUVi/bzCbO6z
 AXLDzSUB71buUgKjL7i63LWM+uXCtpXXQWuOd8/6vOf0ogXsbFJ9gNxnGmO15cVtENGu
 1x3vX+a8qr3WK6Zi2meMkXTpysLvAktQaO4DmzYbDivEioL5KeUOZ8fHs1h3C10T9McB
 duOmKQUpb6Ba8GBvugsewhbsScpvi68iwt+AfUyPoojbAHf6yaTDcej8J5G5YE1OYZTp
 F2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752236973; x=1752841773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pu2rmRk0Olg5YPTNdz5DW+mcZTwlyaKbAfAMIV/bNaU=;
 b=aOUfeIvuPw0l0jXu6WKwrhNm193Hw6+ntGAWc+sUm2pjSm33M3gED5Ciao6Uq3xbmP
 XLx+YYTmgWPK8GUmvx33G+1/CQjZOiJ1kiEg9C4k6QeTnNfVOGvJXhTYIA7OCwnpxWpQ
 mR6pbeduZXEg/hSCzqwZU3JuJNf5ZlVKjjxjEj8hUTKHRRFTbCseqfDOXB5gFo1d8Jzh
 CWaVfE4jpD5f0q7O62kt2qhTjnPncy78lJMsHSKOEVsKYu+nMVkBLpsmhjCS4MdKAE76
 mErXBT0tFeRTKm7uzuZdxt7888uC3h9UuVGsvYxIJvhuGPH5H1/sU4M8Ykq6UJOjZ3ft
 2L7g==
X-Gm-Message-State: AOJu0YxpUftYa/Mb08PsIy2EHKm74IllggQ4SyUvi+fgBRLBgu8IMH3+
 EgF1zMB6x+1qfQyZzuynTD3NJl00DSyB3y3tDcWg0cdbmRH0SObf/2AepLsu3+MfVHo7gBhcXrP
 kRMmwPbvHWIJZqyAhLXrvq2PBsWfxqVc/zxwacfqyWg==
X-Gm-Gg: ASbGncvt8UezdPswrnJ0FAGOJkD5LrQlG4ngWojIp21hysHQ1Vat1PIzvx0QDbTchPB
 NaqBEZhBsg+ZuwNie6PjTlCoTzVJlG5bfs6JtsgJdqDMG69aAO2LaRY7kCl79NGFMVUk5Khcgdd
 TH7HyyfjaptkYcLK/VlqN4dkkLQSmaw/cmOsfqhSaJ7drq9ANDQgsgQHT0Gla89x6SqX0B9Zj5C
 bxWtW/+cRUV7BlNsoU=
X-Google-Smtp-Source: AGHT+IG2JbxVB6p4br7UQpomjMopPjH3pk0HinwXKuQOXMwoXZI9h9z4pdJ2R7M5rhsJOiQ6HPzdMoCDyoqNcVFj6mY=
X-Received: by 2002:a05:690c:fd0:b0:70e:731f:d4c7 with SMTP id
 00721157ae682-717d5b81533mr51180427b3.8.1752236973511; Fri, 11 Jul 2025
 05:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250711110626.624534-1-jcksn@duck.com>
 <20250711110626.624534-2-jcksn@duck.com>
In-Reply-To: <20250711110626.624534-2-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jul 2025 13:29:22 +0100
X-Gm-Features: Ac12FXycUjD9WBzp9Rx-nPWpBDphkypd-14NuNCFEX3fMF-6SQnvE4K8GWUKu58
Message-ID: <CAFEAcA8Z4OVDXUO+ZNe4sv2u=_vtuK_yv4vX44LjsiZKpjz4dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs/system: arm: Add max78000 board description
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Fri, 11 Jul 2025 at 12:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This adds the target guide for the max78000FTHR
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---

Checkpatch wants an SPDX line for this new file -- can
you confirm that I can mark it as GPL-2.0-or-later like
the C files, please?

thanks
-- PMM

