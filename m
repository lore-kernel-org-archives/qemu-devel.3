Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0767C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 09:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAR0c-0002vV-DT; Fri, 24 May 2024 05:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAR0b-0002vL-B9
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAR0Z-00051w-Ho
 for qemu-devel@nongnu.org; Fri, 24 May 2024 05:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716542078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5pNBUCymcYqonbx0ozBz4zsH8R1qMBH7fBdiLBYpOY=;
 b=Hg7ZRmMRu96934WmMeOk3uQWTSbcoqummlWYear0AaSd62HtNiRoRimoW1jlx5rptL0xRJ
 ZgGDeWphVpOXblMt10z666G5Dq/CVv76WRhbE8FILhZrt7l4ry0t/F2VUs75WtdIUXQITv
 cGbLcMndCm0850ocYZlyDOauAa55Mj4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-7C4dgogYNIKy9m95R_mO5w-1; Fri, 24 May 2024 05:14:36 -0400
X-MC-Unique: 7C4dgogYNIKy9m95R_mO5w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-354c964f74aso31256f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 02:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716542075; x=1717146875;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5pNBUCymcYqonbx0ozBz4zsH8R1qMBH7fBdiLBYpOY=;
 b=F7aLTJUzbXabuq6wiKXtK0J8YCbPrOrxBqh9fhfBuNI+yuawLpMMvApKT4eIPccJ43
 lTDyy8YhERW24H1OY977YbywCdOgisyOmcYLyfbOVsWSjcg6iq74sdnVX7LNwo9Wjgmj
 47r/thW8reBoHqBucSP5I5JA0MunZVqKzEH7KpYpWmxA2PiFWgkv/R5kmC5HOWPtumTf
 bN4UE2YjwNBfro4KMdDQs5ZjJPcDzEYlEYdNRaA3F1r7bTwNSTJXqi0ZElPP3OFYfw1t
 jBSXfvnr1nMQG/1h6heseV1ORSxiJtmSdrIoyipBHtmBT4TDHXfWVfum+dGr6+9fpfJS
 0Akw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTz0UZD1n21o0urUFF+duxwb7LC2eV6Ic/uAcMLhyxg/zIY/Dj44gcXhEyj/tsCDVyBQiwG9YIYOeCDK+cZPVrf73zUzI=
X-Gm-Message-State: AOJu0Yx/RY2xvEtKkNw5lBmR6KrTAgLE8R69G7UD/7YLfcltJLeEvHES
 DImDWtd5zS3r86g92iI8wxDusbugXf7aJLUQDIt1pe4J7yynB1q/ZxPIcMOcDATRJTOpWUdtR1x
 fD6EFJjpNzEj1ONluXyEKk9HFxWGpMlmbZK/dpMKd6b7eGQlZ9fGOxlo8PuqK7MPFNrDKtw9DGZ
 YF9z37fAxAJqi7mrN2hpjhRJNh7dY=
X-Received: by 2002:a05:6000:4597:b0:354:e775:19fd with SMTP id
 ffacd0b85a97d-355221819d2mr1013957f8f.26.1716542075409; 
 Fri, 24 May 2024 02:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHDFdi8V8PJGi6k9hFtFHu4RumOSLpAk4Y/ZrK9BQh4GRt0wGoVF6YECYC3Ao8eJ/19IGgl+tJ8T3AhAwlrOg=
X-Received: by 2002:a05:6000:4597:b0:354:e775:19fd with SMTP id
 ffacd0b85a97d-355221819d2mr1013931f8f.26.1716542074962; Fri, 24 May 2024
 02:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240524-objects-v1-0-07cbbe96166b@daynix.com>
In-Reply-To: <20240524-objects-v1-0-07cbbe96166b@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 May 2024 11:14:22 +0200
Message-ID: <CABgObfYom_pjPqAG9tkod_3G+k=sivAV06e5SK9s7spss9wUgQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] meson: Pass objects to declare_dependency()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 24, 2024 at 10:00=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> Based-on: <20240524-xkb-v4-0-2de564e5c859@daynix.com>
> ("[PATCH v4 0/4] Fix sanitizer errors with clang 18.1.1")
>
> This is changes suggested by Paolo Bonzini at:
> https://lore.kernel.org/all/CABgObfYoEFZsW-H4WJ7xW0B85OqFi932d3-DmNAb6zTo=
hFn=3DOg@mail.gmail.com/
>
> Unfortunately it broke builds on my system. Below are the errors I
> observed:
>
> ld.lld: error: undefined symbol: pam_start
> >>> referenced by pamacct.c:40 (/home/me/q/var/qemu/build/../authz/pamacc=
t.c:40)
> >>>               qemu-img.lto.o:(qauthz_pam_is_allowed.cfi)

Thanks Akihiko for putting together the RFC! This is simply because
dependencies need to be added to the declare_dependency(). I'll post
the full series once I finish testing it.

Paolo


