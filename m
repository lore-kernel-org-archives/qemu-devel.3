Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A47C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 10:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkhTS-0000Pw-Rq; Wed, 19 Feb 2025 05:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkhTP-0000Pk-0V
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:38:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkhTN-0002mY-6d
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739961511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MrcWK78FTlUhDvIDiXJ7tczaxY13U6NnZhzx4kbsy1A=;
 b=MdRY4pdZRAXFVxzUiy7D5dLjH7OQ0hFBkBafDoaCyRuX87hay9jWEbzN4UFvV1fqXqwqDR
 1KrjWXG3w1aKTLEXki2c+b+Udaxl4KTAjKKM2JyI3LXXvCbw2fPsiDvrlrcTHiB4oFyuuW
 a385YtI/qQSucN/rgdXvFzmLPR14SZs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-qxYGpaSDMwCifN7YZJ837Q-1; Wed, 19 Feb 2025 05:38:29 -0500
X-MC-Unique: qxYGpaSDMwCifN7YZJ837Q-1
X-Mimecast-MFC-AGG-ID: qxYGpaSDMwCifN7YZJ837Q_1739961508
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f2ef5f0dbso2481458f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 02:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739961508; x=1740566308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrcWK78FTlUhDvIDiXJ7tczaxY13U6NnZhzx4kbsy1A=;
 b=uEYY05+0423WBcDBpHg0nanHvBV7mr8wH6vx/xh0q4ryPrIZW7M8+sPvbRzf4iwVdq
 WPDK4L3PTbtKnpxBwo8wefl8fKYnJtTJWzKfrgsTc5lKQTx2G/K6ZtO9XuOOBYK0YnQ9
 AsncOuCkMcZWogxIro0/ccIkcK9gaqfY1v6g9CARHLWhEX1//Ekv4M0TDyAsMXykFE8+
 v+GF47Jzz9g96jqaT6LT+udbfRGgMiVW/BG+B8Vfj2U8ZJiNoDC71YqKv5eFCqKLzuZB
 vWRT16kOBTAf8JZev72/OIGqEHOa9buQtWwG2dHv+sC7XKdYXANkthtGmFk42SEVP+CV
 bDgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUN8VQq6S+hmlZJ2o9PJTJym+DALkT9Xw19GI4gXQRhvfPfe6X9bgje9CSLQaTIFAzbhkL0jpnhbIa@nongnu.org
X-Gm-Message-State: AOJu0YzwytPFwJ/r6ZwIOAZ9JKWCL11FSF8LmxbhgHgBXUhYtxSwfkxE
 Un8NI9BCnoOGwpPReDSgWuHt4SGW7CEtRZERRuOjSBfYTljzFU2Mw9Am5Jct3Ytu5YhX9Pz66EG
 XeVDeAmod6EDFT/M13q2WOO4DgeOxpbsQEaVPCteYKnDbXTbQ9f6co5Xato8EFUM4OI4dupuWy6
 WdQqEFU0IlWGL6lkBHvIS2ciWG460=
X-Gm-Gg: ASbGncuaL+m38yNlltpulPgS+0q3O09xjPfogwmZXFs2qF7wPCnOvB8X+NmwPE8oYIa
 6lng4QvrgzOYO/h9dVFJIlsh0PvKR/ts4FmewApJmxlkBwEtYqXKW6G7idAfUNO8C
X-Received: by 2002:a05:6000:402a:b0:38d:e48b:1766 with SMTP id
 ffacd0b85a97d-38f33f118c8mr14890863f8f.6.1739961508122; 
 Wed, 19 Feb 2025 02:38:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmXqNyO4nYSbe47MgBKSEfyZx4/oIhcCEQcCOJKFvIl19M5e+qqB1knIk050IBtal63qMTkXoeQK0yphTs1IU=
X-Received: by 2002:a05:6000:402a:b0:38d:e48b:1766 with SMTP id
 ffacd0b85a97d-38f33f118c8mr14890842f8f.6.1739961507844; Wed, 19 Feb 2025
 02:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20250212112958.38023-1-philmd@linaro.org>
 <c33817a1-74d4-47b0-93d3-000cfd6200be@redhat.com>
 <CAAibmn2Ohd_-k5LGqo5m1xzLrrs2UYxCT6U_XEKsJYScfCpx6g@mail.gmail.com>
 <CABgObfaq2m42tBUAmskSXm-fR6zKDtApAsR4rYYqg8dnMq+Bog@mail.gmail.com>
 <CAAibmn3MvZtng=4vAGx6yNfMkM+u_HRbT0CAA6WhdbTtLDE5xQ@mail.gmail.com>
In-Reply-To: <CAAibmn3MvZtng=4vAGx6yNfMkM+u_HRbT0CAA6WhdbTtLDE5xQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Feb 2025 11:38:14 +0100
X-Gm-Features: AWEUYZlT81xW43eFQJ1dhUOiuYOp70PVUEuDuguYdr2vf4M1i54fhPRLZCf86-g
Message-ID: <CABgObfZzLs+yByD=736PFw8ZtH-OcJkxZiScaTWktdrY1+5e5g@mail.gmail.com>
Subject: Re: [PATCH] meson: Display summary of Darwin libraries detected
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Feb 19, 2025 at 11:36=E2=80=AFAM Phil Dennis-Jordan <phil@philjorda=
n.eu> wrote:
>> ... which boards should enable MAC_PVG_MMIO? Is it only VIRT, or somethi=
ng
>> else?
>
> I doubt anyone will be able to use it productively with virt, but I am re=
gularly surprised by people's creativity.

Ah okay, so for now it's effectively dead code.

> The intended target machine is vmapple, which is the only known way
> to run aarch64 macOS guests. [...]
> I'll try to rebase that series and re-post it in the next few days

Thanks, I'll keep an eye on that.

Paolo


