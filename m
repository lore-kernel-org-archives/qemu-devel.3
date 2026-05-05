Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B82FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKBcH-0007JJ-C3; Tue, 05 May 2026 04:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wKBcC-0007Iu-7J
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:58:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wKBc9-00032h-VZ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:58:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so25159735e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 01:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777971518; cv=none;
 d=google.com; s=arc-20240605;
 b=itBnGD7sQ4X4kVr5PKMdJYkV6Lc9XJbAE9V/u5LInnngSjvMikjPdLYUxkI0zOJGRg
 3ahq0Q/W8HxxeSj1vpXbG8A5vz+v4W5gIP5ooRnJGJ1WXHp4zapLv6+NjkMpstc8mpbt
 0kGa2fpK/kgjLUdOlI5AUmPYDa0Q1qDNG4lv1hWeWE4/CfQ2nwSq76aYuI6SfAqQUOAs
 Iuh4arlHwFUvW9j57m1BJ1iBeQdT8VX4Q3rZ9GiqbdmRY58xKHUSFj+666L/inrL0Z1n
 an4zdPZ1rrmeE6GBL7DaxaswfupWnxjf0XclJRL+AKzhFG/ixAdcamYlYCywObaB8YNQ
 ebEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jq95NupVIByeCTcE5wjvMS1EFuwRN99SjWngpCZhhzw=;
 fh=5aYLWYK4O6X28NDotTDHomZI6MsE38WVNKSlp1CaHOc=;
 b=aVGi3XKxWqwi5u8ZpcxSOrrobbuem0hMIWWIuSPrme+0GJ85BftdB2c02K/HEFgk6y
 Z/kw0+i4bsQElHYl8tbINNIYiOXL5pIvjxdYtNmV5H8skkvHApnb45bQ57dWlQEmmjpl
 8n5SG8dLxhUhXrsEegGgH97Qnybrj4Ln+X5J+lCT1Sq+IMNflPK2HrC5yQhD0OsT7oao
 TtsqCeA4TyKjPVR1K4kr2fyaGeW4JqVDHfO9oiDFaTLf1leMTLmuAeL9lTJWDRN1UGOC
 AjKVJqkly5+aAnk6yW/KpVvS6XkU2xparCFYcQHiqyPmOLNcEbELQtfcIZgb7gpsPoK/
 X4Gw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777971518; x=1778576318; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jq95NupVIByeCTcE5wjvMS1EFuwRN99SjWngpCZhhzw=;
 b=SngJENth0ONzQxW1hn3jxtTQjhg9gIxH2d7NdqZelx0unzsRJv1Dikw38qBlnBZ8fn
 57BDpHgIeHfFW2qWmbMgE+Uk7UvCTM07ilVyJaKgo+VVfGEMOoeTSJGoh4LHKMzTZlZK
 AXAe8+C9doJvU3WjrbkwiKJwSlseHIrdpF080wEKHeKNWU8Rm6LplqMhLxakxxb3E0dL
 Vo+I42VHDgbjHlPMV61NU6aytyWQEvsq9Xi9JVcPuqkn33QRLltFsVmh1UmppLwkBxYT
 LceLK6GAyqLJCWVfJSi6DH40UZzse5ctaaOJZGHQ9wb+/RIllv0KNn7v/DKdJvU25YSY
 T7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777971518; x=1778576318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jq95NupVIByeCTcE5wjvMS1EFuwRN99SjWngpCZhhzw=;
 b=KGeAzITpiR29jqTXsFTke9nHNYLZJSx7Kd/7qwnVqSsuRlVvG2WYGY0kMkAsNrQFET
 nvGImmBzg1PtrZVmzESUYeNo3DIFtoafcp2Q3WzAnuAVj0snIVZL/pGxjnU6CM9LCDqK
 tZeUxcf+mudsY5gJAuocpc6V6V946QyQnhUE42L5ww7yyCV+6OuNJfVeDad5CfqXWGvU
 LJVlhijKHd8dXToIAzCXhdPsgsRCAl/Iem35vaifiB5RJH75eDSA0iVE3WrHdSuMUqQ9
 zf0vd7xJKMMkR8CfATwxEO55+s0+H4DetgaiiASqoq7JCmNytpn61TV1FM84E7iPnvHt
 doZQ==
X-Gm-Message-State: AOJu0Yxroo5CxXg6BD2AmLvtdqGdcvbwedFcGVJbsrd6pL1BqYtIQEVS
 wtf+1TUQkZLJ/GwaYzjnH6IyzRMk2Dkb/DQMo0RiLdSO09AEtZdPoNcKOWfQEVC3VVqUHUrnPDU
 h9+EvvnLHQoCzop4uynoXodPSRrogA0PmPfxMd7V9Zw==
X-Gm-Gg: AeBDieu7uBfFA89uaSI+oGZrCFLJT61p3tsV5ZXbZJOxAwCX8KxemXNZ3F4b+8WPWgt
 cT7LYwJfberUIB+FeD8h0rHliaVcrUQ73ajp8/I7geLe0ERCdfQiwnZGu5yyLbye/IXDSaUypjr
 u4ulR++k6BEve6vBW+Mb7DCqKwcUMT03mifZSnZK+1IARVn+XnkeqDUrn90nps/8LSdVBrzNA7j
 wACUlDsw7quiHbKFotxLieOo9YOFTh3CG+5hV6pUsAlGtL9y4f7q065cdezyVJM1wCyzV7Rnsp4
 KwQvPByTa8EkRAfXrm9T6090fW4wj+NpIkIEwJqOaDNQqfU6ALCWX6p5vU7P
X-Received: by 2002:a05:600c:3496:b0:488:c40b:c8a4 with SMTP id
 5b1f17b1804b1-48d186dc879mr33038935e9.1.1777971517967; Tue, 05 May 2026
 01:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <87tssm5jq2.fsf@pond.sub.org>
In-Reply-To: <87tssm5jq2.fsf@pond.sub.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 5 May 2026 11:58:11 +0300
X-Gm-Features: AVHnY4L1dWEj5KjmX367VOEYy8Q1GAcs4mhkieKUVrO3W17MJgcdjcU6kD3cdE4
Message-ID: <CAAjaMXYN25NdzOKd7Sw9YGSi+aaT3rQA_3fVTc7MtoM5hteEnA@mail.gmail.com>
Subject: Re: Can we make QMP commands in Rust always be coroutine safe?
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Tue, May 5, 2026 at 11:45=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> QMP commands that perform potentially blocking I/O can profit from
> running in a coroutine.  Ideally, we'd run all commands in coroutine
> context: most of them don't care, a few profit.  However, some existing
> commands may need fixing to run safely there.  Since we don't know which
> ones do, running in couroutine context is opt-in.  From
> docs/devel/qapi-code-gen.rst section "Commands":
>
>     Member 'coroutine' tells the QMP dispatcher whether the command handl=
er
>     is safe to be run in a coroutine.  It defaults to false.  If it is tr=
ue,
>     the command handler is called from coroutine context and may yield wh=
ile
>     waiting for an external event (such as I/O completion) in order to av=
oid
>     blocking the guest and other background operations.
>
>     Coroutine safety can be hard to prove, similar to thread safety.  Com=
mon
>     pitfalls are:
>
>     - The BQL isn't held across ``qemu_coroutine_yield()``, so
>       operations that used to assume that they execute atomically may hav=
e
>       to be more careful to protect against changes in the global state.
>
>     - Nested event loops (``AIO_WAIT_WHILE()`` etc.) are problematic in
>       coroutine context and can easily lead to deadlocks.  They should be
>       replaced by yielding and reentering the coroutine when the conditio=
n
>       becomes false.
>
>     Since the command handler may assume coroutine context, any callers
>     other than the QMP dispatcher must also call it in coroutine context.
>     In particular, HMP commands calling such a QMP command handler must b=
e
>     marked ``.coroutine =3D true`` in hmp-commands.hx.
>
>     It is an error to specify both ``'coroutine': true`` and ``'allow-oob=
': true``
>     for a command.  We don't currently have a use case for both together =
and
>     without a use case, it's not entirely clear what the semantics should
>     be.
>
> Can we make commands written in Rust always coroutine safe?

For async Rust, yes. Any type that doesn't implement the `Send` trait
cannot be held across an .await (i.e. yield). This'd make it
impossible to hold the BQL and yield, it would just not compile. You'd
need a simple executor (i.e. runtime) to run async code, possibly as
part of QEMU's existing event loop.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

