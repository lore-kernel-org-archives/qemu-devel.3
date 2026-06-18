Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625BFCD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDpq-00063c-GF; Thu, 18 Jun 2026 10:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1waDpo-00062m-6c
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:35:12 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1waDpm-0007iA-Pj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:35:11 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39657d28132so8544181fa.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781793309; cv=none;
 d=google.com; s=arc-20240605;
 b=AOdadiPA/tVINazFBOgXo2bx9Dk91Zn0eh2c8yRwZJSVvdLqCzhbbm9aeGl9Io3N5R
 oQYBCdYa/CP/LUW5BNv9C3o+MomCt5fD3IcZzlDR11Nkd6xZiPgagxOGwMnY7uDbNreV
 mo6xKlVyvM9+1tsSBwLKv7JHfzyB/Uu+s9eHAadMG9w9sX7sbSQz/CJ+mdo/QfdvHlaN
 cdyX45ScYep6rx332nv9+PVinOsk4Qkjb+Y8kWyn8v0wfEa73HG1vd9Db4uu5f95vrU2
 Xw+DtRIVVaxAsDRF0+M+a3fErgXURk33jme24Tlh2yzKVegIMwgfHtfgsAQ35/9un3hg
 9vMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mAuEBjIDjb7vvHZ3goEqgaRQp/ir0YjcG2/d/JFE0SM=;
 fh=FYMDsCi4WI5C6l3LWXk24pPcjP+qnWts/BEPKwb3sEc=;
 b=bwxlmL+Oz4m+R7MKXgSbvt9ZpV3Haq9wT4dgF6/whPeBbBfu1UGBnp8hstDS1Nx1k3
 rC5HfhI2XyHxkDvjD6/0qdlYNUMVjAvLAII1H34FriYhZ323sR4d5JgIHMgrwD9eRB9G
 em3QMLizAR/UqphzT8+1kYazFP5T1BP+fbFc8tpTNbNWqJygUu+x254XkBqJ2MdLsRdx
 jfhysOvUVks3Y1Oq3QZO82fLJLlWROMxuJGT4A02wXBWZlz9EeGaJinM7gcZP/zrHkCA
 xGfuFoI4hgo3ocgQCyvO1Q4ex+LH/SF4sxfosrV2svISmkwpt++Gv/OnqI0aiZmzKWC8
 Ghcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781793309; x=1782398109; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mAuEBjIDjb7vvHZ3goEqgaRQp/ir0YjcG2/d/JFE0SM=;
 b=SD9a2j3MDfyGKRQEfjvzUFWLwqoHSvYJvdFzFLyKxppDwn8sPgH7gR4Htnatfk1mU3
 N3N4NPQE88RqdIHnBLBXByZC/yAo1mDjIgNNCJEty2gsORYqLjr+JDNTN+DEJGR6ortC
 ff+rrnCJHvY8+h4kfkt/0Rd9FhpeSEfPk67TV6GijsqBx8tJ0YgbfH6S3ImQWOmBx7Oq
 SgkItQPLkS3n+aG5DGmB7QOfrJ45lTGJWFtzxLSfwpkkGbS7lL0up5WxtiW2HvlRHyQj
 8sFs+Makh3OuA7nyCyLvruTIATzJrNzr0KsQQFN13ZJ8TICXCY68GGzgdnp1ETf1goaW
 wsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781793309; x=1782398109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAuEBjIDjb7vvHZ3goEqgaRQp/ir0YjcG2/d/JFE0SM=;
 b=kJWR682BZGF70qFV3OoN/TT64ru57p6OT2m3FeB4SDX0oFhQh+5iGmvdM7EGQUXHCf
 tqLoLjzZ7+ug8XUiEE4vwxP44ASXN5CgXqixCQcD1znDiaF8yNI33b2HOCjN6UC/Atv0
 q74muVTkP1oNZc6R27XbI4/ym8ShRkpmvXmWGN0h1/mqGfmvc0wYN6ZXpOpix0EVws8Y
 ftShK/iqdMOzBoOsYFbsMC9Cg2gx6/JQwYI99r3HV/uJdDg0KAZfH33wOP3jcBQ6J6AX
 b3KuhXrUNiXT/8MJOUySgmcbTyuhzkc6U5zKOsPoVy1oiWR8jG1TMfiyItp6l/VA5iIm
 6IaA==
X-Gm-Message-State: AOJu0YwXNTb78XSFmWWEA7XL9ei10FwcWqXtkKoQxDUdM2cHu+xpmwxm
 ttuGeJBOtPjz4/Vbc3jBiIS9YtWGTxcg4VFCCfNoxnSD2trjV+dnlviVw8x/SKymqCWhr5jf9di
 LZYNvxfUHcRsMGwdAG79xAglwY+KsHL6HOw==
X-Gm-Gg: AfdE7clnUCyFIwVuUrp14vOoLxUm53wEXYV8KpRF/m2KsW91Ov7Lve8x4GTyX83kfo6
 rWpq4GdMKclYmtFsHXdVZfnE+GCnpFYwm9bkxkcLzRcVpY3flh7pqRXw27Rk5J4rwLhXQ8UcDb/
 T7VXjoGReOhpJ0vumNVnNnO38m7q+dQADxc3WOzN2e8E4vKOv7PRdhP1aLz5QbCH6Z0EUNsrxwX
 q879JWUAsEiFefNwmrpL3iEyUN0KzOxbKoN4y8tOYvFJjxUzObvgJZthqXNBW2nsrVGuK2MJw1+
 L02kxSljERl0Ta7j1XJyDjt2ePhkaqs=
X-Received: by 2002:a05:651c:2125:b0:399:87c9:45a9 with SMTP id
 38308e7fff4ca-39987c94843mr2745671fa.19.1781793308677; Thu, 18 Jun 2026
 07:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260618133354.3369437-1-mattst88@gmail.com>
 <20260618133354.3369437-2-mattst88@gmail.com>
In-Reply-To: <20260618133354.3369437-2-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 18 Jun 2026 10:34:55 -0400
X-Gm-Features: AVVi8Cc42N6Y2ON9AiUCrmvHqS9i0QaPW8230nyGmtfoMnHc9INZIVzJE0rIG5Y
Message-ID: <CAEdQ38EfNbC=p4D27PZGrbJDd3nAV6=hwKMUxfHZ3huu1PRXOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] linux-user/xtensa: save/restore FP registers across
 signal delivery
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Sorry, ignore this resent (and already landed) patch.

