Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4E2CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0eNA-0005N2-KI; Mon, 22 Sep 2025 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0eN0-0005EC-V4
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:06:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0eMv-0002l3-OL
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:06:10 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so2259274f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758539162; x=1759143962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ni49pBxOvVxZV4p3YWfhMCFcFc4r4FBZsxveRNIYI0M=;
 b=SYALrUVmJOU36PcK+s1T92kSzOBwxrj8zmb0G+kURwLWwCqz269nGYYbdJT990R1pd
 9Lp40KBOW8p1iTs5xkJRLA535c4RkmcYgHRiYIt/iUaeIYjI7A38YADNs9ZKZpoFRfJN
 4vJ9GkEUsFfZHfJp9bGxWXVO1GLzHFBVM+KvY+J/3c6bwJKYbzAbPUzKZVBmhM+cfIcb
 Ot3IfblN4uhRmgHZMKlDlJyNP1swnPd/YA41goJZkJ8ibiSN8a9JOWKOaHt7TW2DhvQ+
 CRHNsRFZXYJZonbApD4K++/NXPWyWxpWuMW+FNSzBINuPgn3rIU2ERfvJ9+MjnM190us
 SASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758539162; x=1759143962;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ni49pBxOvVxZV4p3YWfhMCFcFc4r4FBZsxveRNIYI0M=;
 b=JBqXVXomkyV7OjKYJ6/0DDwvj1xaEYkX+YZocPIbsDxDEpCicym2ktSrKtRJ/+KPV0
 TyRQcK02CTMGh7nRpHQFyUUQNY5OGd9iELueUrZP6WxaId/256VEbUS/22j9Vw6RfRLp
 mY4MtGH5vlfvzAPqZoGNx/4IwAYwIe4DW+L2oKiyW2WgEAat0DILJJ5D1lylKWhUYs14
 p/4h4xhBuWd0zpfl6GK0gDw0+j2Db2AK7F2YjdJRRDHIj0E7yKvj8gDc5hJb+x9B41xW
 oVldAW09nLIUUbc38AJUBF1WnvAjaE+2GORknoREL4Anea+aozVnlTL/eefGTnQidb6m
 A99w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoPc6K2089c/C7z2bHogPmmBR6ol/A3gfphrKHmNUVXl5idbOhzoC76qvoeqNhEYqcHj4XQrAFI7cl@nongnu.org
X-Gm-Message-State: AOJu0Yw9hkvJaNSB4NKnUu7NvyEaZWRAniRNa6Qg5UIjvEuSI6cryw0S
 kPztHu9Y4IF6FPRHyk7H/8ZgRU6pSkepLmAACgZHVNIhb7n/7LmkNrCceECVi9kcYus=
X-Gm-Gg: ASbGncuH27s933rMDlu8MRHXHhJBunPzPYJ5AyXFSzGadjdfzvQroh0c8WWFYKaoo2M
 xnutuHf0eRXZRrBHKnJuFMbK/CtW29Bi9v1z8x0I2/umIp24NsWwkpEN4F3TD5WDNo3kD+YBCn9
 Cusrp/fGIfQb3IwZjnH46FH+aKt8yxXAAFDIdd4RxEB4QvrdBdxzrKcTaGPOL8BizMY1FxNVu+R
 iHTWn9OfnaTA6gc9JdEScOAkbV+u7hkA26k9kmOd+rSAJfvbd8pljUlVCQHiw9xK27gGkyJDvkq
 vM/O6CkiylJMKCPbFJrItYmi7XIKYZzJtFhEDujEUfjn9GvAIpz9uILrDjIoAfdLejj2GiZyzdh
 0P6SH2ESIebSpDyTRmwGxxM4=
X-Google-Smtp-Source: AGHT+IG8tZOr3GhadUV+mnKQ84Dkkyq+FokhZzqORZGt+n30cVoXBNrSIxrZ8DDzN9Sac/E5FOHZyQ==
X-Received: by 2002:a05:6000:26d0:b0:401:e7a8:5ca2 with SMTP id
 ffacd0b85a97d-401e7a8613fmr1286289f8f.33.1758539162176; 
 Mon, 22 Sep 2025 04:06:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7478sm19355151f8f.38.2025.09.22.04.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 04:06:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94CB75F7C4;
 Mon, 22 Sep 2025 12:06:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Alessandro Ratti
 <alessandro@0x65c.net>,  alessandro.ratti@gmail.com,  philmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] virtio: Add function name to error messages
In-Reply-To: <aNEpVhkZ2r5e2Z9X@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 22 Sep 2025 11:47:50 +0100")
References: <87a52wqa03.fsf@draig.linaro.org>
 <20250915162643.44716-1-alessandro@0x65c.net>
 <20250915162643.44716-2-alessandro@0x65c.net>
 <87h5wulqm2.fsf@pond.sub.org> <aNEpVhkZ2r5e2Z9X@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 12:06:00 +0100
Message-ID: <87wm5qoig7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 22, 2025 at 12:37:57PM +0200, Markus Armbruster wrote:
>> Alessandro Ratti <alessandro@0x65c.net> writes:
>>=20
>> > Replace virtio_error() with a macro that automatically prepends the
>> > calling function name to error messages. This provides better context
>> > for debugging virtio issues by showing exactly which function
>> > encountered the error.
>> >
>> > Before: "Invalid queue size: 1024"
>> > After:  "virtio_queue_set_num: Invalid queue size: 1024"
>> >
>> > The implementation uses a macro to insert __func__ at compile time,
>> > avoiding any runtime overhead while providing more specific error
>> > context than a generic "virtio:" prefix.
>>=20
>> A need for function names and such in error messages suggests the error
>> messages are crap.
>
> I pretty much agree. If we take that view forwards, then I think our
> coding guidelines should explicitly state something like
>
>  "Function names must never be included in error messages.
>
>   The messages need to be sufficiently descriptive in their
>   text, such that including function names is redundant"

Ahh I missed the fact this ends up as an error_report. I think having
function names in debug output is fine.

It does however miss important information like which VirtIO device is
actually failing, despite having vdev passed down to the function.

>
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
>
> This is interesting as it shows a link to a previously proposed patch:
>
>   https://patchwork.kernel.org/project/qemu-devel/patch/20220414112902.41=
390-1-codeguy.moteen@gmail.com/
>
> this old patch just expanded the error messages to include 'Virtio '
> in their text. I'm not going to claim this made new error messages
> hugely user friendly, but I think that old patch approach was at
> least conceptually better & preferrable to the function name
> addition.
>
>> > Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
>> >
>> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

