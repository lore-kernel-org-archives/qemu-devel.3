Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487AE10F3DCD
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DYq-0007wm-4t; Mon, 30 Mar 2026 10:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7DYm-0007wW-TL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7DYh-0001tj-Ap
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774880738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdK3HynadsBA2keRk1DND70GlZFExXYcKdTnh2I3pho=;
 b=RJthTyuD9/H+TSz0XibiR6+cvz2qTMi6g4uWhUPp0gKlRzYEBC+IUYhPS8Sib7mxiWMx+f
 TRLGMvkKmqYxVWy86vRhJknqDOADUq03xoJD+p1P5MlHwePYpy7ZkhukrHwytQGq+7t04g
 iOL8L8xvBtwSTFh86KKXSt5UE+V/qgE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-pV6w0XeMMjKmdZ0LA5Ti3A-1; Mon, 30 Mar 2026 10:25:36 -0400
X-MC-Unique: pV6w0XeMMjKmdZ0LA5Ti3A-1
X-Mimecast-MFC-AGG-ID: pV6w0XeMMjKmdZ0LA5Ti3A_1774880735
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43cf7e96d4cso1552047f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774880735; cv=none;
 d=google.com; s=arc-20240605;
 b=N1GHfT6zDPv0AED8HZOnLiZMns3ZVOL+mmqYvv5gdSjSqQA5SaSF9YL6hoUr1nAScH
 ZfWZ8GbLQlXAebzOEAFkQgTPSx5D0yuwnfi90zJGyyhRBT/LhIsOQyuNNGjt6V4d9ygd
 38dJJfWg2lV9Fszt8cdEDeswVDzDQVFx2WDpwcWLPqRJrnujOS87drI8EwxHwbnBBGvT
 N13CW/SSMzTIrf7Bkg7ZN5IwglMFG5R415c9sOhJm25SBnnGSccWtK2t2Mo/U54BT8zD
 8Qz/+tH2NLmjFNkGMA2+d+Xzjh03pNxdM2jMsWLNZpwOCwjbW8blN8SDTjXzH9Hifkel
 Mpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QdK3HynadsBA2keRk1DND70GlZFExXYcKdTnh2I3pho=;
 fh=7fENPsy+q8W7RHxg5jYLWdiLRRpMy2NgIbjW7btpTYM=;
 b=jLFw1FZ4lU2W20oOhIqPhq7vP2w/ZiygI+J8l8mE6o7CFaSM8CGtEEu+qtBpPzPC41
 Ab0dham3rLFwMfTwH55FCseaTQz9Dy3JcsC8bZu7ISYLz1+sSorOu1nFjfEOACnjWlsa
 4ssDSRZLSXT7wezob4+P2AdgHlO1FCa9VUrCVtObKPO34t/fLJdUO9lFDcS9qasmceV4
 g6dnTw24t/0eQ2xWqKYn5DFkeR5B5zxQ8Kc+l4cpXtNiRaHAFkEvEpAk+qs1Kc9gojqI
 XXVId8IQyEQKYphGYPGcJdlY8D4baZQ1cTCakQV07/LI4pUFnid4eXlXAUyFkWmwIntM
 p2cg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774880735; x=1775485535; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdK3HynadsBA2keRk1DND70GlZFExXYcKdTnh2I3pho=;
 b=j8qExBl2uyfXFx31Xx4Bqu/B6u30dYXe1ARDZfy2C6gDIfcDc4G49WSvSVUtlJ0sMv
 gVAMcQQCVO8FtFUJ9YXxYf2JiaGkA9X8qkcbHoKs3qlHTy9U9zz24RRRh636qXIrxIS5
 +p4fAWogvNjeOJxGvA72Wt1LtlrCK38t73zsmOgTNk/G9vFxdwbTua0LjYKmjsS5CDs5
 t51mzLLdBqJI9Krm/Ko4NMPmi2pCwNLsOmA4FlhWrcQs81DGvFncKBSSCUScxClTx1HK
 QhajbVSGM/3E1YWDs01dbTufvo36I5Gao8N7fc6PEgZo4CGWV4Itacr9tachTd5pmpL0
 XrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774880735; x=1775485535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QdK3HynadsBA2keRk1DND70GlZFExXYcKdTnh2I3pho=;
 b=lTFWSKKJmvyM5rHEyPGmzG3nnEm70CnxaQPSGqOG7VRLjMLyLRHm/xwAlqKV1iWttW
 dyt7oqW1kVG6rFsuqciCAj/BUXUF6r6UAbuPr+62bXXIfbOzzm3RfkKP4A33fOL2FnAx
 vLIMIkenuFJjeWPuVG2MBN3Jlj3hXqD17SOr32FI4MEdZ+5mgFuux5BAhVQ0dQCaWbuC
 DwMboNzv1anKcC0Cb8JHx0YrSylNtmWW4Ed0cTCqwTiaWND2ZlZeY1HM9v6RRDE+e9KF
 cfLd9siEcnzq2ib/C0Im9fKWq3Qw2r4Nx/VoBtiJQip2g1pX+tnOREqNvypDPVOI77mV
 5nKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPzR7hhqYi4KaIk/4vlmioZnHIz6i9fYWXJKDf7Ozz7JyLp4rOssuDHi/vf8Jw2JchpgfinJzY5R5I@nongnu.org
X-Gm-Message-State: AOJu0Ywqh6+yO+Ca+ydUaWoqRlrG13vypPwIhuy9il+3G9Cffi7Q/zXH
 7/h4K58bKFYpyTqmFrhfmq2ImvSWCeLCJG80nn90eC4PADBBiJOtpHueHh+0KEQSx/2IhVMiDOs
 CwtUZ84EqRJdVQnvw/99xaDdSk8xv3B8VQU/1LQo2Rxb8LKS6GRZrxuvZTRYlUXFmEqGxCAgf6G
 oDfUxHtcrRYwHBehXguWuJfNc18KFp/+8=
X-Gm-Gg: ATEYQzyoKCL5e2WOeBeazpbM5cRIAPY7emE6S8PwUZX2BCsSuEIx3tzl71oqmXrbxxt
 Yp7YZw5trLbvDt6xcORwQHLnCnl/C8xL+/o3PJKQIfqUXf4z5TUuASBkEPQuYUBsryItY546QP9
 m4iEvhRoowxdHkfvAhN0qsbQeosyf/dhvnp1pB8psXKZ9ASn0jRG5oJN7+bLGjqcDZM5Fc1i4+b
 bZcNGAyP6MPFP/32DawkD/J+ANn9OEPNejqwdQ6KJQRAQWnJwnUrk2PI6CJ0imGv/ubL/+9RY/e
 6inp
X-Received: by 2002:a05:6000:1889:b0:43b:4273:a6d1 with SMTP id
 ffacd0b85a97d-43b9e987aecmr22280572f8f.7.1774880735421; 
 Mon, 30 Mar 2026 07:25:35 -0700 (PDT)
X-Received: by 2002:a05:6000:1889:b0:43b:4273:a6d1 with SMTP id
 ffacd0b85a97d-43b9e987aecmr22280519f8f.7.1774880734940; Mon, 30 Mar 2026
 07:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260330131406.87080-1-Stepan.Popov@kaspersky.com>
 <CAMxuvawBPPBfBhLy-9H43fPT64M6iJV+LZiE0CmqP6BfJkAFQA@mail.gmail.com>
 <acp8VmIN1cwNAxE-@redhat.com>
 <CAFEAcA8Rt6VwDksVHjEAWKsYc15JGjry=kozHsx8PrwW6sEH2A@mail.gmail.com>
In-Reply-To: <CAFEAcA8Rt6VwDksVHjEAWKsYc15JGjry=kozHsx8PrwW6sEH2A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Mar 2026 16:25:21 +0200
X-Gm-Features: AQROBzBuO0Ocu94n-NAAg8H-8gVyVP_8iGvId-_gcvXXgNJfScJlPG_N2-QYx7w
Message-ID: <CABgObfbXGy0rMAFWoVwnE5+yBnZb14qcOsiBLtX=heL6MMQG3g@mail.gmail.com>
Subject: Re: [PATCH] meson: add missing semicolon in pthread_condattr_setclock
 test
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stepan Popov <Stepan.Popov@kaspersky.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 30, 2026 at 4:20=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> > IOW, that commit has been dead code since it was first added years ago,
> > we've never used the monotonic clock
>
> Yes. So are we confident enough in that never-tested feature to want to
> enable it at this point in the release cycle, or should we hold off on
> this bugfix until 11.1 ?

In practice the difference between the two is almost always
unnoticeable. Because it affects pthread_cond_timedwait, the only
difference would mean making a timeout slighly shorter or longer...
and just once. It's just unaesthetic to use CLOCK_REALTIME instad of
CLOCK_MONOTONIC.

Paolo


