Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7758ECD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6jl-0003VH-Lp; Thu, 04 Jun 2026 07:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wV6jj-0003V2-0k
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wV6jh-0003vV-91
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780574382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9rm0LOUSxraVAtKPnCt6n7+5DoSw3bfavEUHdNFHS0=;
 b=CZOHIOgZydiUeiJwGjWfLn6UQ3ODio+vk80Bt/sKoOJrTqRcUajczAqxeDwvBYiQutaGd8
 TtJW9zWpqDLnCMyauoUpsbi94ZkoCIrHTTXhO0//FzwV5EAeoqZyZZzkmF9u0o/u4lh2PF
 wPZ4H9R3XAUpytejnDAIeX6a3KpkxM4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-D2GaX5z-PuuHJgewc_XyLg-1; Thu, 04 Jun 2026 07:59:41 -0400
X-MC-Unique: D2GaX5z-PuuHJgewc_XyLg-1
X-Mimecast-MFC-AGG-ID: D2GaX5z-PuuHJgewc_XyLg_1780574380
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36b982ec338so734187a91.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 04:59:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780574380; cv=none;
 d=google.com; s=arc-20240605;
 b=B/fLTRDeWZKXD0koGeldNnOTkLwG4EJWADAzAWvuhX6XEudpBNUaBlLXjXIRlrc9bZ
 5Z4xORCDBZjMeg/AeYhbQFJMGpNpqW3FTTJ3rD1EFDn9/lt55+5vzBY1JCP1lHhfokZE
 yJebv2LCsZEZ/c3QesIjO5OZJbTnPevNiZZtFGFvEHdjyrv0Eqkeqe0dK+PZAsYJPnP1
 oHYmNX8/vQwwYLFPBaQ+oo6b5Ne1iLdrO2KLSpKOg68e4fmTJF06zz8Ru0b6H0R+XE1a
 An0g11x44X6weWtAb2jlWjLNIpbr3ar2mp2gfhOHz+89NW+l7BJNH04iklMj3IJsYbVx
 m+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b9rm0LOUSxraVAtKPnCt6n7+5DoSw3bfavEUHdNFHS0=;
 fh=LGkauBv9Ell6hdu5+098LLst94BGnQUpUBZNECG3uSI=;
 b=beEdOOWPxu1X57fGIp35vzQIAlOji/S+MxUNBHMgT/TnzI5XyE5ISpZPZUZ8fbHaHN
 N2+jur/hQvnJ7uzS1yyLeEHGZtKuARqVuEXZM8e7SVImq48wIYzw2dHBsnOhlKv6TcL9
 ISc/v9JoAhdnjCHxI6hjHL9zDSxIcfKQFaOTuvwIb0EVOdchenNDLnUi/bpdp1/TyX+l
 RhmmsGxJHi5G+iuclykpfeaj7mXG1E1VdFdHb/XT3uBNbNre5FHQycbGsBhhI/9XMi7D
 PsGFADCx1PzOy/i6q7VU1Knm6p61fw54g93Ldg09HzWAvzHEhTXh91EV02e/gCAgu/up
 G/6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780574380; x=1781179180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9rm0LOUSxraVAtKPnCt6n7+5DoSw3bfavEUHdNFHS0=;
 b=dTbe149ZEaJYdvM+yGRrVT1jXSLVp16gJ8kLBlEKxHDujrfhyFClAHaTJhsi1ZxuO1
 9u7WXF25HYa+MhnZa9ElOLPt52WVOrmYDGL0l/QlijxhOKvydaqFNczMf96eLGT9c1sz
 S7lKfepfLBJzkrb+BnK65/HLd2QVWtaS3WZ4ku59e/oqRzjj6yfBubLiUn4ezKSMBkIQ
 Ed5YN6rh/UPQTZG25uzg4MZ8BeZ9Qq57ajnePmLE6atMjYdr61skqMNgjJiKtFuTWxkj
 XBQQdwW1VQrT8a5R44nr3ei5q5aMONx6lwt3saW0L7gHGuW3pTZKJcwKqd6+v3j2yXbu
 yleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780574380; x=1781179180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b9rm0LOUSxraVAtKPnCt6n7+5DoSw3bfavEUHdNFHS0=;
 b=BrCNh/545IZ/VL9gsPu8hxDJZcIPd3yoNxp8sJsbdgofsg6hgEZvC1L2kgiz7zy33Q
 DhIwZhqkAeMtyFaSU/edim/f0GgxtXENuxsf5c3H3Psl+5U8yG3sO+sxLVF4DvbWH0BD
 T4Hmxq2S/1Wzh3kTfeWpRgbYvcT8FMfA7v4LtdcNYAgmPi+NTNzARGDpFyNk6hsA1A3q
 3x+7xPMWegbX7wsQxx6ejqKNhxiKu42movQBJoPje0Kn38SeroDgp+FQcLz/TPGlnM5x
 1AByOpijpNLtnVeP2A45DnFbZ4azB44B+DENk5M1A27aFnxkgOhraPKRhWFEfSf6TNGj
 g7aQ==
X-Gm-Message-State: AOJu0Yya7hixnkBSJSH7N4xGjq8d7qJCOXIY57F1wwngBA/VIS30lcJr
 iFFSfv0wP8QClRuBZdG4A9Dk/M//xhtndGiFziNGR6jGjY0BOZnHDeZpJ+Bnlz+jCrJunV1TtD7
 10TGyH+Dtymg78UFpny2Jp8ZilTjUGpmcBW/W9QU3YUdjKIvKNzQumWcdA+TdCGuBs9opq7EyFW
 4u9pR5ieChxcW+RY4V/hQp0RngAGzmfNI=
X-Gm-Gg: Acq92OEtRwUk/l9gS4Jg4ft7BixpVIOO36mzFudCSOf6uXIC4JwZu/gfnuOW6uYHF0f
 cL2t+UyPM//Ec9QYF1BZQv6ypCOE/SELcyZlDBSZywwESfZt/glQ9yY/+dGOxlJMEZzA0aZhSyQ
 Kf/zUBePxFZUs3XAr1n4ZhpCHKDbVJ1EClpM6EgQKDGmtTDP5sC2eGOsp3qA/ptom2Xp+5TpJCT
 2gqnNhY7yU1APkt0okbDEAgbHcj3AtSk55Yt3SPZqgN0mOuQKdDJQuNYC4df/YxuktW6jykeQRI
 Tgs9Qj5qkoZ63sTasP+ZRbuT/9ZbUPlN3Q==
X-Received: by 2002:a17:90b:48c5:b0:36a:f382:9f72 with SMTP id
 98e67ed59e1d1-36e3237e162mr8118900a91.13.1780574379917; 
 Thu, 04 Jun 2026 04:59:39 -0700 (PDT)
X-Received: by 2002:a17:90b:48c5:b0:36a:f382:9f72 with SMTP id
 98e67ed59e1d1-36e3237e162mr8118871a91.13.1780574379394; Thu, 04 Jun 2026
 04:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-12-bdf61e57c1e1@redhat.com>
 <33d4e111-51b3-40ec-b681-bb95e6bf0c2f@kernel.org>
In-Reply-To: <33d4e111-51b3-40ec-b681-bb95e6bf0c2f@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Jun 2026 15:59:26 +0400
X-Gm-Features: AVHnY4JlSGZ1MaOhnS9eCYduPA_7HfAMSShwqeQ-P4IJxjtxzvKR_sBT0ebMlDw
Message-ID: <CAMxuvazXz7BknuQWPFKnwcLEHTfuj5eyBVpLE+CbHyCO+Gcfjw@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] monitor: add 'info ramblock-attributes' command
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi David

On Tue, Jun 2, 2026 at 5:54=E2=80=AFPM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 5/4/26 14:30, Marc-Andr=C3=A9 Lureau wrote:
> > Add a new 'info ramblock-attributes' HMP command and the corresponding
> > 'x-query-ramblock-attributes' QMP command to display the shared/private
> > memory attributes for ram blocks.
>
> Can we abstract the "ramblock" stuff somehow, and refer to it as
> (hypervisor-specific) memory attributs somehow?
>

I am not sure we can abstract this meaningfully; it would likely make
things more confusing, imho.

The x- prefix command and documentation indicate this is internal
debugging, subject to change.

We can just drop this command if it's not useful or generic enough.


