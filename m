Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D746CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 19:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4xF-0006z9-Ve; Mon, 17 Nov 2025 14:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4xE-0006yr-8V
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 14:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4xA-0006AB-Uv
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 14:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763407915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+uHybKEF7GisfwMjMZz2nIxt1SIQy6VFkcNR9erehI=;
 b=M6jnQqpmzMRuWFXLahL2kjCAA8B27N+69oW4s60yKcpst01FD8Wq551RHwKacH2CkX1YP/
 02bKsxMQGR3oKHRbjUADCy+I7lT3aiWhLuhPQo8qyIgr9CaXuFnDVRz8rx2sFNBkDOWFcs
 8GJV5E81aVPEhRULJ6EyZqCyUs201uE=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-PoIieBoSMZONoWilUcZ_RA-1; Mon, 17 Nov 2025 14:31:53 -0500
X-MC-Unique: PoIieBoSMZONoWilUcZ_RA-1
X-Mimecast-MFC-AGG-ID: PoIieBoSMZONoWilUcZ_RA_1763407913
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-63e324b2fd0so6394844d50.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 11:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763407913; x=1764012713; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+uHybKEF7GisfwMjMZz2nIxt1SIQy6VFkcNR9erehI=;
 b=iOP/DZCKdRfSR/8+Lll2Wz/n79esPTxMnzkyFf+5bTGen85xALm8P0FNRdLTiAVBW0
 VvIKmf6pZcqR2QQg9+8FOi6/J2fYC+TS4H1iZGp/bFg159I+ojCpHVkNt8ptQ6D1ln6Y
 nwfP6L2pM+DyTasKl1u/YUNzXYB/IBuhh0oxgcA1qRQ/bvKs0sD6L3qlkIUSOMywneEZ
 v1OCi5Bc3BObSptVh3QOX7R3YFukyJRiEnthBwFdVhswuo+RzNkqPRQerV0kzfTBbT11
 OXZ8dYYDXKCajjozsnvfYDjVZlkFyUEBOqfo08RShxja7Q9Gj6vndkhf4QtAW7illUCJ
 gEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763407913; x=1764012713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i+uHybKEF7GisfwMjMZz2nIxt1SIQy6VFkcNR9erehI=;
 b=L5GbPprbsMJvLXLeRWeiUvavDWdpM9MNdVxzSw1WX7gTBNGz2buqrWNlKdgi+TgDHk
 H07t8YPx9XE62yZj0Lga4FQuH8JYsN37e4CjUvzRTyt/ECTlYAdpacPjB86o4Htej0XK
 PsNxaReUqeqIYFBB86JDFXx8GzR1E/Hhuf6AnRoSmzbkFHAx6snFjFrsqxZtxIMljNf0
 ID7lFBZADlaL50pJ0DzKpAEy4OhuGgukYSpXJNmOigVoRdz8qNYJ+dsCKHmLHwa0+Fz4
 GOpNCplS4h0E37SE+Z0mz1l5BNNaGeTBQ4XFgebq30oIeuLKJ2j7fIpKJytvvRxZOcE9
 zP6A==
X-Gm-Message-State: AOJu0YxvVhbNpN6sEXNFlaHV+rfc7egA74u9NG9yqEVQcFffWOWWOX3d
 wRXBUtqHIkb10p1J5UDCYz38pDh9ZoGMMt7eWEMdq4v2WbqBntMmdndKaCIDLZScUaB6XJ4ZKCY
 52G1D35+/0wnMwBkY6iyQeifMM5kZcVNgV9S4zHaX2TFvanxALorgAvgl9IebLTLTEipebM2Jqk
 arfqXovosc5bFbaABuZROh8pz9nLkVgKU=
X-Gm-Gg: ASbGncsFWluOdnQmAgwyV1DUzXlGLseuhxWDxjWY9WzxkDDRW3P0bBfsFSCt3G+rM5U
 8+6l/plZvdIx1V9whLVPZDTfT5inQ6NHf1X6o4impxNj7k+G6Y5O/D8JPNS+4PgND+fLP6yfFxA
 7Qf9p2bwuI44Mz2y2HYKGhVL2tUr9HN3f/YFxdpyjMaFt2jp9N/yMItlQcFGldtwmQqiv5U5DdJ
 WrwL+0VfHQbw8plfjtAgtasIA==
X-Received: by 2002:a05:690e:d58:b0:63f:abe1:f9ee with SMTP id
 956f58d0204a3-641e74d6e3bmr11576637d50.17.1763407912966; 
 Mon, 17 Nov 2025 11:31:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX9WGKoZd+DbkKSQgRCLIJ4I+ZqRQCCoddp/9yH8FIG2D2O+SLb+NnoBqYTPLAOlN7rJliNKxcZMkImg3yhHo=
X-Received: by 2002:a05:690e:d58:b0:63f:abe1:f9ee with SMTP id
 956f58d0204a3-641e74d6e3bmr11576618d50.17.1763407912630; Mon, 17 Nov 2025
 11:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20251117163107.372393-1-pbonzini@redhat.com>
In-Reply-To: <20251117163107.372393-1-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Nov 2025 14:31:41 -0500
X-Gm-Features: AWmQ_bkCm69dbjjsuvDvpPYnswp-Ud3QlqpIsZIN-56zkjEQmpLzLbmuyw8yHM8
Message-ID: <CAFn=p-adidGU+u=cGvPvgt+TA_3FJ+FLMPJMN1CodUmDO6vNjQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mtest2make: clean up and make dependencies more
 precise
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Nov 17, 2025 at 11:31=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> You probably have never thought much about scripts/mtest2make.py, and in
> fact it has seen only a hendful of commits in the last few years.
> The idea is pretty simple: gather the list of testsuites and their
> dependencies, and turn a "make check-*" invocation into calling "ninja"
> first and "meson test" second.  On top of that, it magically turns
> SPEED=3Dthorough into invoking up to three suites named XYZ, XYZ-slow
> and XYZ-thorough.
>
> But even this incospicuous script can harbor a bug, or rather an "I
> didn't really think too much about it" situation.  Dependencies are added
> to suite XYZ independent of the speed that is used in the meson.build
> file: add a dependency to a func-thorough test and "make check-func"
> will build it at any requested speed.
>
> Fixing this is a one line change, but it is easiest with a small cleanup
> on the front, which is patch 1.  This (at least to me) makes the generate=
d
> Makefile.mtest file a little bit easier to read, which is also nice
> to have.
>
> Paolo
>

Gorgeous, thank you so much, Paolo!

I folded this series into my patchset just to make sure my tests
passed, but we can debate about which patches to take, when, and in
what order, I'm not precious about it.

https://patchew.org/QEMU/20251117185131.953681-1-jsnow@redhat.com/

>
> Paolo Bonzini (3):
>   mtest2make: cleanup mtest-suites variables
>   mtest2make: add dependencies to the "speed-qualified" suite
>   mtest2make: do not repeat the same speed over and over
>
>  Makefile              |  4 +++-
>  scripts/mtest2make.py | 43 ++++++++++++++++++-------------------------
>  2 files changed, 21 insertions(+), 26 deletions(-)
>
> --
> 2.51.1
>


