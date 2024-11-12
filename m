Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596CAD32D92
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 11:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAogF-0004hb-1s; Tue, 12 Nov 2024 06:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAogD-0004hT-Cp
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 06:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAogB-0005YY-Ve
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 06:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731409404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9l/ayV3xt/dY3nFV9XCp4iFuHk0v74BNBamll9GQjfE=;
 b=O94LY6hHkpXiQf/9Sgn65flVlVUNOzrlkYoKmEYgGJG4VP49OcWeRnjrGKmoN9e/QY7EEk
 VBX/ZjbI4IRByhXFLtz9tIPMO+anpBTTj/H9WS8NRRcearbY4BtV6QR2udiGAsIst9Rc3A
 grU1xs5NwLP8+2KDrEufeLuHZHEWEwU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-tFWHKb0GMkOiTYXU0LnKng-1; Tue, 12 Nov 2024 06:03:18 -0500
X-MC-Unique: tFWHKb0GMkOiTYXU0LnKng-1
X-Mimecast-MFC-AGG-ID: tFWHKb0GMkOiTYXU0LnKng
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-539e294566dso3964278e87.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 03:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731409397; x=1732014197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9l/ayV3xt/dY3nFV9XCp4iFuHk0v74BNBamll9GQjfE=;
 b=CteVyB3od8ZeISjOdrderfnO9aD3e8bUlKq+CcNtXNAY4C65rAwbd9BWhI2kknc2bH
 nnk1Tpjc0f3Z4/BNLckJj3oDRPHJvMvlCvnkUDocaimHYNRbES3rH1he8dtqGf2O6nTE
 9HIzY6pbu7KAKQwfK4/1Dg/mRt2nv6nDYPI3HWs0qBFpuxT5CUC3UZxEmFFeOznU14IP
 etN20Fll4dGcEGQIOMPAyDRa0Dfb2XUb8AWEXafeRBlfwAy4+VBQGaovGvoNYtXtqXap
 nPGAUPSm1i/yyXQqngy4qZd9DhkgJTExnuPzddIVuJKhtf4mWpT3hLHIkE7GYZXpy/ry
 EwEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXFLE0u1dM7dD9M5TrvkIcHWWa8obZzIAgDDFn46fMvy7wGl3cmmewFhK/tjzcUaDlIWZRjcrpF5/P@nongnu.org
X-Gm-Message-State: AOJu0YxG8z2V5u1tI6KA0e0xbC5EPAifJZ1pNoHyshwHHVGQ6RMJaKeP
 mQQ9t10ikfC4ZYdYN7H7P2vgWcWqeI1ogN8zZbnZqhbXLZaQJcXUa8plPet8lWJyXwV6KI+cUUO
 wZ5mltlE4hWS0z/aD9miKQ/WAjf2MslT7uGRp5IF/mImOcgQ+QBlgnWmK3xtt1brtHo0N6MKQT2
 8n8QQoy2qOFSHs8llzkA5A3q6sgqo=
X-Received: by 2002:a05:6512:ac7:b0:539:f496:aa88 with SMTP id
 2adb3069b0e04-53d862c6f04mr8041216e87.53.1731409396912; 
 Tue, 12 Nov 2024 03:03:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj8MvfA2bt9xyGUdX3AVQTYzI+3F552A/NLVVKAI+vQr6BWoY415w+7hFLFeuoZEy5/eMq8s8hYiFKRDgCjZM=
X-Received: by 2002:a05:6512:ac7:b0:539:f496:aa88 with SMTP id
 2adb3069b0e04-53d862c6f04mr8041191e87.53.1731409396507; Tue, 12 Nov 2024
 03:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20241112063703.116386-2-frolov@swemel.ru>
 <CAE8KmOwDuv7AR4pEGbq=ubEkrHbkQBn7cz2hJsSYx6YgH5Ubpg@mail.gmail.com>
 <224ceb0c-7219-45de-88e2-1e51b47cfc58@swemel.ru>
In-Reply-To: <224ceb0c-7219-45de-88e2-1e51b47cfc58@swemel.ru>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 12 Nov 2024 16:33:00 +0530
Message-ID: <CAE8KmOzzBrJa6Os=_D=F=LjHG=8ByHVi2hz3g9ahtVTwYPO8Zg@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: fix non portable env varibles access
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: farosas@suse.de, lvivier@redhat.com, sdl.qemu@linuxtesting.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
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

Hi,

On Tue, 12 Nov 2024 at 14:45, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A4=D1=80=D0=BE=D0=BB=D0=BE=D0=B2 <frolov@swemel.ru> wrote:
> It looks like this is a clang optimization issue.
>
> When environ is absent (not mentioned in the source code)
> The value of envp is also 0x514000000040 (reproducible),
> but the behavior may be each time different.
> Mostly test fails with error, with or without ASAN report.
>
> Thus, it seems, that when environ variable is not used -
> it`s being optimized, the corresponding memory is being
> freed, but envp pointer still points to the freed memory.

* Oh, that's interesting. Could we maybe 'watch -l envp' in gdb(1) to
see where it gets free'd? OR if there's another way to figure it out.
(just checking)

Thank you.
---
  - Prasad


