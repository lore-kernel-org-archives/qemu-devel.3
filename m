Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5F5E909DB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsOCq-0006aS-Sq; Tue, 17 Feb 2026 11:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsOCi-0006Zr-DN
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:45:40 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsOCg-0002NG-QJ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:45:40 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-649dbff9727so3953249d50.3
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 08:45:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771346736; cv=none;
 d=google.com; s=arc-20240605;
 b=WNN6xGqg45hdDjr2nibSjXn7yb+niNiinq6uKsGTqo5cRbyGsp8Vpl4zpvD2P+ZuVQ
 FyCJCkN3DQMjShDDR4Wkrr8lelFA+ObW3fyHI7eYUXL339/QqliFDnQlzETxV5A9JDIH
 vjaDtEeNmmkbUM5phY2sKRGc+X+enu4CnO6XS0W6MIDI6WadIt5+4Wciqwz+xgurgVqq
 QIJeNk3599yTZe04FwwzkMgZFtTyxKpRqyFkUPGwBIg4r5GvKmQ4fJNB2+FfHin6SjQA
 KqLaa+vmMaR8OmbQJH32seCq4lbVGfDXbkS4Q3Yowiw9OuJ3HyjeqUSXFNf4gJt6MIot
 PR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qKNKchHiz1TDPoeq+dRQ5r17C4SfuiLsUSGMTu6LiiE=;
 fh=k/wqoA8f3JORtLZptWlQSxuSbBUUnci8tzFNmYX5rtg=;
 b=L2T3G8ImvDdPy+cq23HAwz7CUrHI9/nlWBYHJn+f5SlVKNW22rpWw73S/uZzCPDLnz
 BioQx3tvMcsGFSxj9pLEEHZ7sj4EDkUtCu7qQILWF2zx/8+zVZHZZ9TDbaseRR0SLh+F
 Mz7PGktV51ObyRClP4IuRILB16novtWGo3+EipGzzlf+ItpNiv1h+5AwdJTLTeBZdNqj
 +q5ArHRaDcIpjb9B9ABwg1XE74UOodfAWepVEhdOe1Yi2paQ6g3o7kkB69EqMvjS5UcC
 Q2aMpuc9o4xIkeLk+CLt8iqiag7Mc0A5sEVFxmq3XDzuYOTFfSAKtLZZDgl/ArBVynDR
 v3fA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771346736; x=1771951536; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qKNKchHiz1TDPoeq+dRQ5r17C4SfuiLsUSGMTu6LiiE=;
 b=UoeOmlD2JVY/mW4VQRLwHJ/8BFyRdiDHIar6QWY/lj8OEZ4UwJG5lzyDJfDaWyC7PT
 Jp8lqAgvo8/6FnVEOQseOvvy9Mi8DIvaFI1cVZnG0PuCxTFIEzlpMUpD5PUzLMRcZxMv
 N+c96F7ktVyiZqPQpi71v4WzKnw66kLYlfYZqOYUSNAAcn4Zozp1ZffzLRtUme3Pgclo
 iFG+ag4ayB+KRIrPs6ClpUnWIp/ZuQyBEt4JPKJtmLpA6n4ixfpWOWv4DsV7siYChlgm
 jfLiqC7mKbyKCSSpHbfmbPfxsiWiu+w9XtWM5txC4CtXtoiXanVuKq67KUyq9C2tTz2x
 ZoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771346736; x=1771951536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKNKchHiz1TDPoeq+dRQ5r17C4SfuiLsUSGMTu6LiiE=;
 b=tlzqY2ebCWqYuyo/ZoTn7TBz64WfjjFSgDMwFM2+qKoLu0xUFMbZzc25qNyvhzgUj7
 nOC1ubKdB4yd0bsdSQmCuZR53I4R+yvYLiu3ppwZKKGvWxW9HBIFOSnDmCVeM8ign/MV
 b/o+zmNTimIWakYnjT6Goxdi2hkYLHbn07VXrUuK4MtGaSrqAhcQw0sQyeDNyFwHfAlI
 n7xn9eMBOcPktu6pa9JFCS1XVdiCUzjGAwxe3q/4IU3onQqq5RPODx2fhDcn7XDwygYI
 3ez8/BcPu+YW1RWOk8CAnAgG6Z/g/PXJdxP3WSMykr9bDD3ZShUUFTLqgjI7J92FO2pu
 Y+EQ==
X-Gm-Message-State: AOJu0YzzFEKd8c0EHT5B6f0Q66mqci/JEtVjflJGSnn/Ab1Q2AEcUzBO
 OzNL9sLgsKrgixTAxHTpmEZW3ISttdqVALdKcWgEZm2DMisGghTlNj3kfyfxgX9fJbB3Y+EpGe8
 1XM1++B07MBgl4DcmCwV402KXDdupoO1qqlWMeDdJ+Q==
X-Gm-Gg: AZuq6aJ+0qiGqTv+S7JHpeI7PjmAqB5QcAVCdtDSCGxTjyIWst8hDmaltJhIjByoJdp
 q1+0iQ2Tkwrzcmx/q8jmN9J1TNonPVFFhhmVLBKqWN28oLtlfqkG0ICk+kyoGI1tXJLhvvpQ3uC
 ygCedub7dILp/sjWhp6EfqZAcEaNi1CWJt8dPrhSsikH/L4NxmEwA0dCX+lU8OXnzYWvavAfIKg
 jx14SSM/xr/azsSpEuqgfA7HkyeVGXSZQeOQOCjpJ8GdIvdyExTWKW0rPFS6QtGV5+ossYmNPYT
 gANUwPVYpGDpbYNB8DxHIxfUxfkzL5jUXSYihH9+Q+3T06m8A81TpV7MIE1YEyU5nHl91nvggUF
 dtg==
X-Received: by 2002:a05:690e:250:b0:649:b851:4a1 with SMTP id
 956f58d0204a3-64c21b80e06mr6730048d50.86.1771346735724; Tue, 17 Feb 2026
 08:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20260216102951.150381-1-kkostiuk@redhat.com>
In-Reply-To: <20260216102951.150381-1-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Feb 2026 16:45:23 +0000
X-Gm-Features: AZwV_QjIyV-Wl-l5f-rx5iXjy-Jb-pSPfCW0KP6UPakay2UY60qxD6Eer_JGLvM
Message-ID: <CAFEAcA-HB+EwTYa65LEFCkGSVGLKvX6fs3-zuZv7EjkyXGVU4Q@mail.gmail.com>
Subject: Re: [PULL 0/5] QGA misc fixes and improvements (2026-02-16)
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
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

On Mon, 16 Feb 2026 at 10:30, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

You seem to have based this pullreq on an ancient commit from
last year -- please rebase on something more sensible and resend.

thanks
-- PMM

