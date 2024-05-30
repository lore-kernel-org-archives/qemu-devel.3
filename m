Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEE5C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 10:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcyr-0007LY-2T; Thu, 30 May 2024 06:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCcyo-0007LI-0n
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:25:54 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCcym-0000Bg-3g
 for qemu-devel@nongnu.org; Thu, 30 May 2024 06:25:53 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a98so464861a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717064750; x=1717669550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kf8UksB7LMwHhAz/qinaPP1Tx0GU5PV9yAGZoWBeMhg=;
 b=hV3PwpumJOm2nv936sChgu1dJ8hZTBJz6GTFzzK9AcOIB6VNHOKBNlXCxhKGXGBTM7
 fxF7BEMgrVKl4z0SEoq/+jJGulw3oBPNYnn67q7hD7cVgPNu6PgfB2QRB9E3xM4hJgJ4
 BDE8lnT3qdYzQJysfT5XauPKRSscLm6SDsplj/6I9VvkyYCZAfbp5hQs5bs1bR04AJhn
 vbgrVTCro8dJUv91AQ6qIlLtq0Sp36BIjABPX8ANGhvhc51924gYJEdRmzDi/fut9bQQ
 WoSXQB26MrKfI5GQ7rxMs1+vU/9MS8BmQIdOP8x/d0cy/56SmvQq35mB/XsYWQyUawT9
 GonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717064750; x=1717669550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kf8UksB7LMwHhAz/qinaPP1Tx0GU5PV9yAGZoWBeMhg=;
 b=cJdYE8RAg6gpJUzXVEyEaVUa/4YuY5bI5FJKdG3uW3AJTGeGtDj6f+jOPB+fv04hU9
 2cgBmfhtiUxnYB1ijzN4ko/6dEAN+ulccNPsjtOyyw4b4uAdY/aFW/59NFconwCv24mQ
 2tBtV6HaiQeWmCRxMi+Z/yCR6AcsdEPIJpVjPi5KaRvaGimVY9OH7zfajUeN65QcGdRj
 XgMYysR2KHngOhdlbIklU2L2q52RftVDvTnrTwWzBTuNRhJBU2w+DgDnteWzZcfabDTA
 BK8DqQnJ6n2yucrXtGS20aDzZNWOjZpNiO570siPPiGJaXD2m/owUWX4GOKCdjk2V8/h
 0fvQ==
X-Gm-Message-State: AOJu0Ywvqz74dH4XFRDlIJ1kzT/A91W4sTisTQfHsJjJbuVU+GGqwWS9
 W3skSSf5lPzk0za15dTIwriCEXDS61nhP40ff9Rx/AG3IxU60QeIv02UgDpPDTW9T7hlwduX100
 oupmljayP5FsNF6qJPpaiQ3ERUMSlAAt3u6zafw==
X-Google-Smtp-Source: AGHT+IEgxXHBnPbeVidp+CTz27IH71U9tHDUCvY9N1Up4+cJ0Q8jDmzZwe4BF75puQ0PqSuwfXSBklIQv0gnMDIbZuo=
X-Received: by 2002:a50:9fa1:0:b0:579:c1c3:c155 with SMTP id
 4fb4d7f45d1cf-57a178e9cd1mr1040160a12.31.1717064750211; Thu, 30 May 2024
 03:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240524113256.8102-1-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240524113256.8102-1-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 11:25:39 +0100
Message-ID: <CAFEAcA88Tb9sKR3eMDdh4SRvoU7pF0=jmzP2CFNXO2QuS96Zbw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix GICv2 handling of pending interrupts
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Luc Michel <luc@lmichel.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 24 May 2024 at 12:33, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> v2:
>
> * Fix handling of SPIs.
>
> * Remove pending state if not in new target list.
>
> Sebastian Huber (2):
>   hw/intc/arm_gic: Fix set pending of PPIs
>   hw/intc/arm_gic: Fix writes to GICD_ITARGETSRn



Applied to target-arm.next, thanks.

-- PMM

