Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6ACC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 11:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiX36-0003vL-LH; Thu, 13 Feb 2025 06:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiX32-0003uL-D9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:06:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiX30-0007Lo-RK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739444781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1eZkYUBFWEylhK7h3h1cAdHlAvv4y8qvqeiH+U1ebA=;
 b=AiVntsqbrCC+28XXzpi+CRAs19mR3sEJwbmvmSDBEujN8CvQVx4jaThn+2HZl9j4HcDncQ
 ETIn6MFwZcEFSJcE1jLKmUqCpjjeuu/SF06UVuyMzOw0qaOufojexMi8StQi7PltKAQ65Y
 JJm2qInC3uS69Vtzz6og+U8Z6/RoQA8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-GXjXwC6OPxq1pf7XQPEJJw-1; Thu, 13 Feb 2025 06:06:20 -0500
X-MC-Unique: GXjXwC6OPxq1pf7XQPEJJw-1
X-Mimecast-MFC-AGG-ID: GXjXwC6OPxq1pf7XQPEJJw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f20b530dfso738084f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 03:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739444779; x=1740049579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1eZkYUBFWEylhK7h3h1cAdHlAvv4y8qvqeiH+U1ebA=;
 b=GMWCxh+aTFnJfKLT0XL29PzlnZQJWUMG5/DdBuLVNqsAwp6mYluKKEFCpgZTOVEEfQ
 WiDEG8G4fIfQZI381/ceZHPCIBBkqB715xQq1c0ssotInoqMUH90gBnw3tpRRJ5szznl
 KBkG86izQ0XosUYeLNrO3/S71Lk5a7qyVB2XOBFic7sK1958ZNJP5WPL8WFiX0jboyym
 iWsmzgiL+7i3WnLFd+0O6Mk5Wm+IwaSLcrBc9V4eu9IrA1+y+WQ3Q06jhx2xDXoiYhcY
 r8w+iuDAuIY5AyV6D914LbGBiJgDCbNEG4BzWrjUcClvqt5tdN5F+HvelQAvDdI7WGqt
 cduQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOyFiamDTUkCeMMBKMqX2e1hdMsOVF/LWk10l2ofxqY6evpp8tIgjQ5f+6G2JoUBG0FyfUCdpHZz7T@nongnu.org
X-Gm-Message-State: AOJu0YzdXCV9Y5CqT/Hser8K9RbMxkBNcrMMhqgJSjn0ciPMzGKkCBo9
 mHQoOaqSbGwlCW0ioQ8RxhMKzEXFcBVLOCAZLVECzey9EhUEfD6/0AcEGsGT6/ktd5XKHllwXdA
 9z6d8XxlMXc9UD4svyQ8EjbMXWa/wuocBk+yRPNyy/CiNAm8DPedcq2fa9NnvRYt7FzTWuzK/3N
 kwSeZgLFlbvfiZGweSx6e4P0CTZgU=
X-Gm-Gg: ASbGncvWz7uxDFCdwR/0V8UNbZCnuLU7RhfFb+jVCvH1K5ppKJ8S4fDMW1v/V/ClniJ
 9lSp7TN1RGyInpNQofk5zFDGHo/KYUj1pynRrnxwc3MxaaLSassXg4KujgHwY/ac=
X-Received: by 2002:a05:6000:2a5:b0:385:fa3d:1988 with SMTP id
 ffacd0b85a97d-38dea259847mr6293844f8f.8.1739444778686; 
 Thu, 13 Feb 2025 03:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYr43NmskIRpGzWJaeWz7wCmCCe8Hu7UIN86ZICwpEwYS9yXLnh/Py7ZwtNJJ53O7wZPmtj94BWcWaFN8kEt0=
X-Received: by 2002:a05:6000:2a5:b0:385:fa3d:1988 with SMTP id
 ffacd0b85a97d-38dea259847mr6293805f8f.8.1739444778289; Thu, 13 Feb 2025
 03:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-4-kwolf@redhat.com>
 <b7b2ab97-acd3-4008-abd6-3da874541113@redhat.com>
 <Z6yecuOmtQKYUwLj@redhat.com>
 <CABgObfb-MXHYY4eM5LUbiRdOqWFG_CEcM-Xkv+v_dNWMwThKHA@mail.gmail.com>
 <Z6y6nUo68dIkryOu@redhat.com>
 <a8e79f73-15d0-486c-99da-ad871a57e4ef@redhat.com>
 <Z6z8EuH2Dw0SQfME@redhat.com>
In-Reply-To: <Z6z8EuH2Dw0SQfME@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Feb 2025 12:06:06 +0100
X-Gm-Features: AWEUYZkO6A78NSkQaCcDeD_mY9pMQFl9ODNt25Jn-yWMGTa7lXw7FpDnE-tJr_M
Message-ID: <CABgObfadubwF0u50dR60g3aYDaZZsbxsSfm2PaY-je2GV7Fm2g@mail.gmail.com>
Subject: Re: [PATCH 03/11] rust: Add some block layer bindings
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, manos.pitsidianakis@linaro.org, 
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Feb 12, 2025 at 8:52=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
> I assume that sooner or later we'll have a reason to include it anyway,
> so that might honestly be the best option.

Sounds good.

> Do you want to post it as a proper patch? It seems to depend on your
> errno patch, but that shouldn't be a problem because we still want that
> one, too.

Yes, I wrote it as an addendum, as a kind of "let's see later what's
best"; that's also why the patch I posted uses "mod libc" for the
errno values.  (The attachment gives away the date, too :)).  I'll
clean up everything and add errno::into_neg_errno(); it should take
both an unsigned Ok value or Ok(()), and will return i32 or i64.

Paolo


