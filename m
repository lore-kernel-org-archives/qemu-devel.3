Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395A8D0C600
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 11:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4IMv-0002IV-RL; Fri, 25 Oct 2024 07:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t4IMl-0002He-7L
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1t4IMi-0008I1-Dz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729855221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHnEz/f3YQfou2LqvuZk2Z4s45GI7GWtMls5LlbQas0=;
 b=f8VPJBfhUCUT0R57QfftoWNTV6WwDoz4Nqxz/X1egU2OJ/uBOg1LUge9fKRWBPiT1acnGL
 a6fADi20xm4+hita0HiJjXcUNBhJP1VGMPjMNObGg3j/J5zFkrbGzCULxIabB9YbsBneFI
 vnwnab9kOmZtO6trzGfW+tffKP6zQZY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-H4y0c9szM4So_1nh3gtWLA-1; Fri, 25 Oct 2024 07:20:20 -0400
X-MC-Unique: H4y0c9szM4So_1nh3gtWLA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6e9bbe92d44so23133687b3.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 04:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729855220; x=1730460020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHnEz/f3YQfou2LqvuZk2Z4s45GI7GWtMls5LlbQas0=;
 b=ClHKDxxvngrYsWeAbUdCEMR8Y9lM92E6s9xalP/y8rHxMHVbCf8bSoqPB2M/EMb449
 IVHv0XZDXExSpB4C/KKasxdxnpXW/EpuSZk3mzCD75HA2JYUCGUq+Hw/BtIyJ3gT7atb
 Ta4zUJ4KpOdssY1vM/EGzS10fRv8r1DycHARRCV9exUJdoQXR+kOf7SwMy9uu5kSItK9
 gYZNlnHYCenF9lZYVyDXNpg5YX5rcGJThhj/4CtMyl48K752p+Sap4lJn2ktoEge8QD2
 PP0W63dshpJW6WfIbImjnKaeb2fU24Px+z0ub+gqqTS+lJDBL9j7OmIOLzPE7yohBacO
 8xqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEH92wmpJzcK2yG3qknIxuvbi2UuFqre4GI6oLUSNGZpimzPWjgmH5GNr97nohWk79LMei+WK4+vGi@nongnu.org
X-Gm-Message-State: AOJu0Yw+iJSyrHJusWAWuaTU0FBWXAU8M5BZjesKKwH1b3gUpsxtr3bU
 wA+H2NTkAGtXoynznBkDMrRnuf+BDNfmR9VBDtt2LL6e/T3AdJhAqnwhi/V9yzIPXQ83fMKj6mg
 aYyPjWbhxOhc8DgVOddX/E0mZD9dRvfY8r9295iX6FHc0jgyDEfQHeKbSzIXzajXysurmTChiLL
 RbC1aYQV63ha5QK1NiUstL8lhIPss=
X-Received: by 2002:a05:6902:2511:b0:e29:2a45:1e83 with SMTP id
 3f1490d57ef6-e2e3a6657b5mr8640929276.31.1729855219952; 
 Fri, 25 Oct 2024 04:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHagD4B0aVEmnChXDMqJvFTUpyFpy30Yl90eWStuZ3jRGkOLyNtEmXY7YiWzSudG9RbMXn0WNQg2FrK5fB0oaw=
X-Received: by 2002:a05:6902:2511:b0:e29:2a45:1e83 with SMTP id
 3f1490d57ef6-e2e3a6657b5mr8640844276.31.1729855218637; Fri, 25 Oct 2024
 04:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241025073525.976136-1-d-tatianin@yandex-team.ru>
In-Reply-To: <20241025073525.976136-1-d-tatianin@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Oct 2024 15:20:07 +0400
Message-ID: <CAMxuvaz9XOhJ4cW9Fc3YRDq4pG3jn7D9b=WH5i5iEeFN0uxa1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] finalize 'reconnect' deprecation
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: devel@lists.libvirt.org, Jason Wang <jasowang@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 25, 2024 at 11:36=E2=80=AFAM Daniil Tatianin
<d-tatianin@yandex-team.ru> wrote:
>
> We've deprecated the 'reconnect' property in c8e2b6b4d7e, but all the
> tests, as well as the stream netdev were still left using it. This
> series finalizes the deprecation and replaces all local usage and docs
> metions of 'reconnect' with 'reconnect-ms'.
>
> Daniil Tatianin (2):
>   net/stream: deprecate 'reconnect' in favor of 'reconnect-ms'
>   chardev: finalize 'reconnect' deprecation

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
>  docs/COLO-FT.txt              |  4 +--
>  docs/about/deprecated.rst     | 10 ++++++++
>  docs/system/ppc/powernv.rst   |  2 +-
>  net/stream.c                  | 34 +++++++++++++++++---------
>  qapi/net.json                 | 13 +++++++++-
>  qemu-options.hx               | 46 +++++++++++++++++------------------
>  tests/qtest/ipmi-bt-test.c    |  2 +-
>  tests/qtest/netdev-socket.c   |  2 +-
>  tests/qtest/vhost-user-test.c |  2 +-
>  tests/unit/test-char.c        |  8 +++---
>  10 files changed, 77 insertions(+), 46 deletions(-)
>
> --
> 2.34.1
>


