Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D43DE937E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBw4t-0001XK-Bc; Sun, 12 Apr 2026 10:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wBw4m-0001Wt-IA
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wBw4k-0001h4-Sw
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 10:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776005173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=796f5A2uD4DcK8B2QB4bUEpxDYycXa3LJBBW9HROjHo=;
 b=dXd/q0ZpjJc88FOKR76UGN7P5GWsxwz7Qg6DlFS+cE2FmgLvk3HcM7cjWyxj+li3mm8TSb
 B2RMpN59PiSHpCvI/YVByAggPvJHqCwxeaxtPVAL07A2nyf8yalBGt0gbsKAJG21ptbsLH
 AZDZm0EU72rPa8J/tlKCHtB6nb3aN3I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Xole5QJDNeud4jQeLC-7pA-1; Sun, 12 Apr 2026 10:46:11 -0400
X-MC-Unique: Xole5QJDNeud4jQeLC-7pA-1
X-Mimecast-MFC-AGG-ID: Xole5QJDNeud4jQeLC-7pA_1776005171
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2ead99f5dso8734465ad.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 07:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776005171; cv=none;
 d=google.com; s=arc-20240605;
 b=a/dRdYGcn9pL+ir7HA/vXoaiUSyKga199qlXwCaKeFvZjdokroigYHrO/w7hybYbJa
 NwyBE8dIn5PGR79fE/aP/3kLP2MnOwN7YZ9tlWHCj49avrr9p56VeljN8Se1GH8XPlrF
 1XkiYkSeNQH3SQfpUEuWcgCBBvKgh+8RwQtdGX5BweGV9DFNLmzkSl3PSZADaBx0J311
 K4x1V5dfTuznWy4VFWoLpR23h8xUeqfCZUrnGEJuWX6yBspa5l+r85TxrOqjKDnC258r
 WUbC47JJYm2CnFwA1Lfu6/uOLPviNbrGDckTwh7VkVd6XAVwkf5DfPoLxHhHWwRdEB52
 CyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=796f5A2uD4DcK8B2QB4bUEpxDYycXa3LJBBW9HROjHo=;
 fh=COFkV3Pkd2KyI3c8J3+FpatqD6O6nnLkCABoyT5EZFs=;
 b=G36AYs0WBuAEYfnEKl8BcprajGSCwTkQocigocESDBvfZmYFgkOMdGYqj1FI7CS6LY
 KdFZPDgqGrxfIA8mYEPW3TMB6BkQppyW8PTncK9veukGhRPOo5fsbllQEsCBpB57NpZz
 h5v0O42k6ow0rEJF29C8u7XU7vRLrV+kbgyjwYCnRIfPp4ReILgNo/f7ULxS4wnL3W80
 iPl6o3b+yYEsy+e8x98Fljsc18UnpzBd8YbgtwIuw8+dr2qz5s+lipvtzlXCKHNu69K2
 FSg7BjsYwHcw5Swa5ipyoPFMb2yl2/dy+HdG7iS+IHGdCCIfLdRV4XaUd8bszZLifGFw
 nXBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776005171; x=1776609971; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=796f5A2uD4DcK8B2QB4bUEpxDYycXa3LJBBW9HROjHo=;
 b=LrysBGGM5+IraLqo7gMk0Zu1ou7nKnchmIDSIfRvct64Kb0DfuAw2KF3yam7bnuQwi
 UrrerlaiA5CUfkVbkjXTyMg/lRSV/aYvPxy1cnKrd+/QOkmwZ14oihsV6GmPkm3tikoG
 2zzV8IwYBdTL6ag+fVn0yMgds5Br7vSRoR7brJNwjxmm9eJfrq2XL02SBpd4lZzpWNK0
 6KTtJUq9sVeXhNqTFmcrBgM4/3Bj2iT6pFOoo9xR+gphpmXj/8r9wLad6KjF/P+b5NHh
 i7QHd9CJD2T96vW88UFQh+bkCb06yfDRmb6R5jj7YJBU3mn1nR+bbyfDqv4XPJ9NdmFM
 aoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776005171; x=1776609971;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=796f5A2uD4DcK8B2QB4bUEpxDYycXa3LJBBW9HROjHo=;
 b=SXb4dlMKxRXhAPVF9cvU6NWI7R/XJNJ/6jYxgEk6p5DPyAl30xAO9J27vUubRb4Ag+
 13SI3KBmLUgLlX7BC9JFBk7wTHlrTFV4YPWRPouKVQ48RKDH//t8T50yQlH/IvR6JBUe
 462Nbc+AaaRdVTbVFYGGgNEoFSMFbXutO8FbRMUZBaAcM5Y7ACJszeBw3vvWjXnGKlCF
 SDodJ7AijXQjo0GkgT2KkjVYEZL4pbdlfFysVPDEcQmnnqJxkrGXjrwLmEeVwNcTdFQL
 FFZqz9jBpTutfo2GyvDX4OFWD1kz0MRGiNB+hs0Apmt2gwB8SatSI2nwVYBavNkgagXF
 QbdA==
X-Gm-Message-State: AOJu0YzJO890j9L87QKkjTsQeIwj9qpXGAxoYg7nRSqVhgXc6HqUKPGF
 3sCpMnqNcAJIY1+edvBaZM0Mqbl6BMRSOwgE0Nm0NJF0zoJqWYtKAGuPkqnedA34dVyrjdean6t
 bSs+IawvbgcMIg/oXHQJ+QCK3MpMNM1wjVfLsIObqQWNsqK5ZE051xyslM/P2ylSQ5hRVE2xOhs
 xcnVh5wNEmhyV3M+N0RQsam+wNxqusEjQ=
X-Gm-Gg: AeBDieug3RD9a/xu5Fz/Xw5CHQdvrCx3vepeT6Lk9tUvmcizZyl+GJ9KUC5ZHagqKRg
 OWd985EGgX0jot4c8Ujb3zNIXKV77OwR5Q2HmNJg2+Hn5WtJQ1Y7PJ9NbS96bo5xyfUjiikOSA/
 3nNjsS2dW8yttsCiBS6Picb5rfgXsUqsQ5RIZAvDpAhtUlqy+xhZ/6ZlLArYkFdCbrlPxgDT6wW
 Xy7I87Gy6Jqs3prn2Ev3vqi2EH/mIBvEWPx8czX9oDQYw6gHoGbB00AxHpOpfUEKpZpLw18DK4s
 gj9KxtOTR3zWOyQsFEvOklFA
X-Received: by 2002:a17:902:edcd:b0:2b0:5a4c:7263 with SMTP id
 d9443c01a7336-2b2d5999974mr72980505ad.18.1776005170787; 
 Sun, 12 Apr 2026 07:46:10 -0700 (PDT)
X-Received: by 2002:a17:902:edcd:b0:2b0:5a4c:7263 with SMTP id
 d9443c01a7336-2b2d5999974mr72980365ad.18.1776005170309; Sun, 12 Apr 2026
 07:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-12-231416f76dc3@redhat.com>
 <aebc053c-0a57-4a69-9f98-775377ec6c25@linaro.org>
In-Reply-To: <aebc053c-0a57-4a69-9f98-775377ec6c25@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 12 Apr 2026 18:45:56 +0400
X-Gm-Features: AQROBzD5KxODBKMXlnpvSOJw3lQCClPqFoRT25qwjdXwKH4x1Orwk6UXPhdKoEw
Message-ID: <CAMxuvawO7-eoN6wZ_jjXYEdP44S-5aCStFFV902OcwJQg1_8ZA@mail.gmail.com>
Subject: Re: [PATCH v2 12/67] ui/console: dispatch get_label() through QOM
 virtual method
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi

On Sun, Apr 12, 2026 at 2:41=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 10/4/26 21:18, Marc-Andr=C3=A9 Lureau wrote:
> > Replace the type-checking chain in qemu_console_get_label() (using
> > QEMU_IS_GRAPHIC_CONSOLE/QEMU_IS_TEXT_CONSOLE) with a QemuConsoleClass
> > virtual method, allowing each console subclass to provide its own
> > get_label implementation.
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/console.h  |   2 +
> >   ui/console-priv.h     |   1 -
> >   ui/console-vc-stubs.c |   6 ---
> >   ui/console-vc.c       |  12 ++++--
> >   ui/console.c          | 101 +++++++++++++++++++++++++++--------------=
---------
> >   5 files changed, 65 insertions(+), 57 deletions(-)
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 08082389f71..395a723e318 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -129,6 +129,8 @@ void console_handle_touch_event(QemuConsole *con,
> >
> >   struct QemuConsoleClass {
> >       ObjectClass parent_class;
> > +
> > +    char * (*get_label)(QemuConsole *con);
>
> Preferably 'const QemuConsole *con', otherwise:
>

good point
thanks

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> >   };
>


