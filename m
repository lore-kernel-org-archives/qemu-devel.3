Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF154CA5FA6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGEk-0003N8-G4; Mon, 28 Sep 2026 14:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBGEf-0003LR-3M
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:37:58 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBGEd-0006re-Iu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:37:56 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-673335b89a0so2955673d50.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790620673; cv=none;
 d=google.com; s=arc-20260327;
 b=W0Ety4jWdI74A0wDzFyVEBcWDzeG2sN23cYVPYHPisRuO6XfjFOe9FK3IRMHE0r8kQ
 Geuy5xE1azWyL7YznmatKTWTqQ23augGoUFF8j3bs7NwPusEX6jDgXiQgGEgMejL+Z1j
 QncW92Goh5Zye4jQRQ261kAMcGGkAaGdsL/kZ8MyJzOoU874sUq+OM8aYEJe/5UpbDB4
 knj5oXv6iCzK92BoKJjzeZtRlSkPvFmDlULHRYSbfe1baTvDuAa6UDkIZnC6s2hgQ6fS
 5VddD5I5z85woe7R1Ry4mN/XOx0UWyrFbeRL72SeU5HEM+kfPKKchEI6qiB5mX+AQL2h
 RNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=onkNmPBNAKXX25Zkjof9Iti9cjLEDLXMrBB2qsjEEmo=;
 fh=1aI44e0p5XplGskc+UeFLoNCjn/8ANQtrjF8ujCp7vc=;
 b=G4AflMMdfJ0/stqmwQjTCiH9Grgo20jLX6G7QNRF6YkqsU+vOtjzSAXWFQUiTBarGz
 e7qD9W/xc4NIovZ/7fRJUTMoc5GV3EmmoAfsvKZnU1R5c1qb7oLClTn7gKYRO4jExd6G
 ejykzpo4B8PNbNomI//nbrsBG1O7BNOm5G76d1Bj3ME/449ORFjuo7zbRI7GUmoEDHow
 8ERku6NnBAdSyy1/bKH+YX7rruh/0Kp0cc0pCJG7a7NJwZZhRSk85eqqMwsGqZmG1Jpb
 I4Z5CED30jywLKBzCeexTzjnN1xn1BhsHBe5llCybj3iTIRdv8VI+s3RCwZm1ofoP7ri
 Oy4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790620673; x=1791225473; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=onkNmPBNAKXX25Zkjof9Iti9cjLEDLXMrBB2qsjEEmo=;
 b=yiDYYU48YMLRFnUkVIpY2R3LGZmuPH1mTPErnOmxuXAa1l/iUa0dZGCOOenuF+gZij
 8Wyav4832WGmX7AM0NcZiVhmTIPC6yhGq15Xpja8X/CIDqVkbGrL8uD9SInM+2pG66tJ
 9o796mygUbA9YnHINHgNOrle6EtBEgaM0OV93nwe9zPE2Mi0YVfmbsogp+Gt6l/0/sio
 hFANv5K5MCiw/utdG1UhEsrUUwLOKkqzgIpx7OuMEJGzs0kBsD7QS5JozuNLlZIYvdfc
 I8PsemPMjmVzuNZvs/mRAztZvY7+I15uOeiqxBUwyihLvGg+YJw7BGcRvtHgAlMHjdtv
 TnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790620673; x=1791225473;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=onkNmPBNAKXX25Zkjof9Iti9cjLEDLXMrBB2qsjEEmo=;
 b=jbRLZKQOSkxSMrNPlNkqrCqpz0V0xlt5iXyEqqsUTf7IuRTdAb/hmGDAxab+HetwOO
 Z4sVwBn6CZeoTlzE/tfatY+auaKo8wedqaks9rADBlt5CmYclcpZcbY/fm1xEfJS3vW6
 nnHSLlbawzJI9WcHLyOasnFb96uAD5OQYu3UQGNzoA0r8NR75c6Lz/UTHzI4YdSjpA9u
 S4p1Z0rjjJquJhVzSb6SSjRM0jTmevCKjPfn4Vjk/LUxyzhgZDm9LdjUqqZmjSkS8oMr
 aKNxgxDikpggE/9ZJPVk60Uw6fk+OBPsoEiEN/M110pjrF6J7IyDTPaXqC1nUHm673zO
 reoA==
X-Gm-Message-State: AFq9FYKoGZFC+HkNfSVxywhCPYIDl/zfb6TAmBvkB8k01DW3ImPeubm4
 AM53FHh7Z7xEMcSZLOBYRPBMwnAL/mSVQyVSBLHxCweyPUop+zSJIWvLg1KyXonZAfPzNvQlVZi
 LABMc7x2sNYRPj1VAJTLkJNkrvx4ZW26LKm4hFCc1rw==
X-Gm-Gg: AYBFou07AXsNezNM/t/Jc2PRnetGNnstrIGsbHlFkKXXpj4iHfKK7X9pmg4XkS+HNGz
 A5deM4KWyqeplPKM2ykJ8bMhgAQ2rmfwPLsQBzvHfYq7nZcG8rqz28K8Td7PKibrAwj9/qhPisv
 qpTFGD4IzeXAy6a4EQuL++KTh4p6A34+S5FvsRewfXVWOwdujtxNZERk2cU7Cqzr72PXVDEIZ9s
 b28WolJuu2G4Mo/ibtUSwpoO9DWkJx1JRw2jNdWPoBdjIYSqOewZNAC4IL7Cms7ex7QRw8BUw5Q
 uGL4PP/EJ341A+yBVOBlce+VE3R1uJ6W2g5nhRypZ6TQ49mtVgnXuFUfFfcjyY9UbgyaiplEPB8
 FiqJLaKjumcFwM7Gos50HPdRafKJqyVqpai6zWSY=
X-Received: by 2002:a05:690e:b42:b0:673:2e60:9eee with SMTP id
 956f58d0204a3-6732e60a2c8mr5481745d50.63.1790620673381; Mon, 28 Sep 2026
 11:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-6-shentey@gmail.com>
In-Reply-To: <20260921214710.29422-6-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 19:37:40 +0100
X-Gm-Features: AclHuK-wwNgyHZ4mNCFW6UJj2vsq_B9GI77iOBHIu9g_IZ4wuIZhaRzvz3-djZ4
Message-ID: <CAFEAcA-88QGdjytopOhrLRJBqnZUsUVevqF-dVEwCNQQDsL9qw@mail.gmail.com>
Subject: Re: [PATCH 05/42] docs, tests/functional: Drop redundant CLI
 arguments in imx8m*-evk invocations
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <agraf@csgraf.de>, 
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
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

On Mon, 21 Sept 2026 at 22:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Both boards provide defaults matching real hardware. No need to ask
> users to repeat these. Also, remove these redundant arguments from the
> functional tests such that the defaults get tested.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

