Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBD8D2F338
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 15:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfgfN-0000w5-SL; Tue, 13 Jan 2026 10:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfgew-0000jH-KF
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 10:50:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfget-0001WM-S9
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 10:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768319408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndEmw4g/ZuE1/CdlLZLbhydeH5EmsyvdNFcwRbzgOws=;
 b=N+Jb5gLMvbhCqbvvr2Gx9LRaLsTwiF9wBQ6AxMXl2NuByJNELc86gMQzYMVe39AG+IbCdE
 hY/VDhwGYuD+BXXOsVUXaRhaYb8Nvl5pIX0r7cSlyWP5ZmQ/+4+KvR6fGqsEwXQRLgmFkw
 YRPBJN1rJdl0btI2UxnCcmWj33g1MkA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-ypppYZu9Oha2q0cmOjzZiA-1; Tue, 13 Jan 2026 10:50:07 -0500
X-MC-Unique: ypppYZu9Oha2q0cmOjzZiA-1
X-Mimecast-MFC-AGG-ID: ypppYZu9Oha2q0cmOjzZiA_1768319406
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fcfe4494so6089803f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 07:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768319406; x=1768924206; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndEmw4g/ZuE1/CdlLZLbhydeH5EmsyvdNFcwRbzgOws=;
 b=jtt3tk5DWMPrmDdtsG53tx1tw9CT+sXRuP54JqpWSzSUENLbl3yqNdwoZOCHLa/+uJ
 YNWb2k5kEzoy6TcP6FRLhx5FRAtPYOdNRRHyPS/36NYZMFVQFDGC/xbSjJw2cC4dlkG7
 TeWiahg2Yg6mWp7yxnOoQOUz6pFCskpUliaXId6eI0bzsDc/hvSwqneV+/vopuwTJvbQ
 ZhhzCCKhKfcnqRv6Axs4eNMFHSLNmCRz53HbFRzw711Ii5fuVQFymEGZAUcsDwm0dSt3
 j8m2Zq/jX5BjI8kZyYDBBc633Cj4ldghIpiNCLmwaaYWErHoJxCJ9O1BwT2Q2DhdeNlo
 8wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768319406; x=1768924206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ndEmw4g/ZuE1/CdlLZLbhydeH5EmsyvdNFcwRbzgOws=;
 b=P4U7nsKcywtBUkRJPK9YtryUMypoorBrMXgJDVsB4qJbsfKsETI2DD5kat6QrynG4K
 qyqgJ4rkjdJnMGZjzT0fuE7nlr48ItHD11FJZP7m2Q7F6VEfp16phC3WHoZ342+IZfTk
 INTNX/2B4rxrre9B4Xi44+OS1NNu2gjm1CCCugtNlh0Bi+aoEtunrNCF9fAoSJw8lvJ4
 pGakfp6hYdcgXUzcZgNYD/NNAD7r6QkyLqZPoCVOnaORiX/0mhMxQoCEGfhfaR9rYi53
 qQYCOkmbfjFRZHhlxQuOWFKL5tV+59T8N0IKA639lUuWtJ7Y0iykPfVsQfa6/Qi2CM8U
 Z2Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLSjDLQBfg5JRmGP5uG46vGvRJcnziciLDGGo1CuHm+fGDGywQdY7JrD9vpBcI2fa/LU2jmn4akPc5@nongnu.org
X-Gm-Message-State: AOJu0YwpFkfCFpjA8TnTyeIfPMmv7HF+Bvj+/GWLJabhAwLrFsLrc4Jx
 x8UV5hJQ1X7w0X/AbDrrPPliyvCrq8ClkVv2aivK6BsngeZryxOE28EDJ4EVyYHhU4FeqC88jUb
 mGtzqeifW0M+lEq6zwLo6R4aFd79XyXeA4+ueKrsSNfPVTebUAWLo/K77xtuRi5TjhTr/o8kPfD
 ujr3Kr11IA+Iac7QhGD5snKW29iiMKl5Y=
X-Gm-Gg: AY/fxX5wUW3mPG9bypaD31GTxFuBjgRC0e3C8Wd7AnHoHPcCHIsWpjwmY6aZ4AShdJC
 9CYIuo6iWB9BNds11OM/llOCRepdGKmo14SwLekSb+w/QkFYoQnGo6yC4eD7+waMRw3gEduT27s
 J2tJWFI41OFL5vYZut8GX3FHIlnq/1jzO9uFNJKHIbFDUQlA6bhqNeqPHP494uQ/W1YJUXTP6Vq
 OK3lqAEXYcJZ4D5BDx2/6LpbTEUvu2bil6dM3zxv1Una6M/LfDgu9TJFCdO9jUkDzRjBg==
X-Received: by 2002:a05:6000:238a:b0:430:fced:90a with SMTP id
 ffacd0b85a97d-432c3760d4cmr26123899f8f.16.1768319406300; 
 Tue, 13 Jan 2026 07:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVB2rWEQQWR/Jq1azGMwwjAdqBLb5M0oTyq0PCUIQykyaD2RXZlIO29GCXJpBJlJp5pmxf9dw7AMKx70CS+ik=
X-Received: by 2002:a05:6000:238a:b0:430:fced:90a with SMTP id
 ffacd0b85a97d-432c3760d4cmr26123877f8f.16.1768319405938; Tue, 13 Jan 2026
 07:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-9-berrange@redhat.com>
 <878qe1c17b.fsf@pond.sub.org> <aWYXt9YckvZmFCia@redhat.com>
 <874iopacr0.fsf@pond.sub.org>
In-Reply-To: <874iopacr0.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Jan 2026 16:49:53 +0100
X-Gm-Features: AZwV_QiXchD8DiYzifTQEGMr3oFq1UaSTq4omJHE0OLd82qR1w-O_XiXPZeB8sQ
Message-ID: <CABgObfYdw9y3621wHkBT+htB8cQ=OsUMdBFJYEoJiuaDELLzUw@mail.gmail.com>
Subject: Re: [PATCH v5 08/24] util: add API to fetch the current thread name
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org, 
 Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 13, 2026 at 2:00=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
> > > Tempted to store the thread name in TLS and call it a day.
> >
> > Using the official APIs in this way ensures that the thread name is
> > visible outside QEMU. For example when debugging in GDB, which IMHO
> > is an important benefit.
>
> I didn't mean to suggest not to set the "official" thread name.
>
> This patch retrieves the "official" thread name back.  Takes a bit of
> system-specific code, including Meson magic.  We could instead hold on
> to our own copy, and just use that.

Yes, I think that's what we're going to do anyway due to my remark on
patch 7/24.

Paolo


