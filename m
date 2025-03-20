Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A16CC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvGq4-0004SO-NS; Thu, 20 Mar 2025 10:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tvGpj-0004RS-PX
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tvGph-0000bZ-1Q
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742480711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2OQykFF8cebzqvWKf+PsxH0o9zBbY+/Y9eCVgtY8Rk=;
 b=G2JyRqZqHCjarZ8rB3GbrftkW+nkPfyyWa+wf/VSZfSiJduHowG9vmyQKh9zSWI9FfKNDV
 I3wSqP3W63ec541Zinqz9Jx4Ro5blsMAjTeU+6+0S7ESoNQSvKDiyPg3uHI9jhntFLOPHu
 dUYdlCX26Do5DO2zVtOiSq6kzxXQKYw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-nnanglx1MjWEy0czUxKDaw-1; Thu, 20 Mar 2025 10:25:08 -0400
X-MC-Unique: nnanglx1MjWEy0czUxKDaw-1
X-Mimecast-MFC-AGG-ID: nnanglx1MjWEy0czUxKDaw_1742480708
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-474f079562dso31088441cf.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 07:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742480708; x=1743085508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=z2OQykFF8cebzqvWKf+PsxH0o9zBbY+/Y9eCVgtY8Rk=;
 b=bjeC4ZYtdCYqntRZF12F1wZv49kYKEFlAA9B/EfQmvwGJzZBQl8xVZDq5IEdTr4+DJ
 WiFChM3aKbxfcZJs/xhDZKGwasMJ6EsvBX3LBR0rgiNKtZ0Rjbojbw2ctp2ddtOcBOqd
 zllxNm/xIl9f0yju/fv21PuEKCEmKudfB1ZOqNwsZ/R7HAfeM6LJzm+ErmClbW1mbGk6
 RCyliF2LIlzA+pTGqGlfD10Eqxu1rNtTeJoN8JZSkrnd+J23PeuqipIqPcfiHqjs8lV6
 6bfsq+mgJTMH8ejP/D//2cj8xGfOZxCadXR7eRVvHpIue7o1i4LM1NEkx67BP5iV8QAU
 7bRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiUKgby+dbyH4xBZlvGAmO1x6FvQ1CBJEmST4nErF6683HNxnEr/hPYCFvFOSdkUj/x4AqyMDF3Qnj@nongnu.org
X-Gm-Message-State: AOJu0Yxx7C6/H73gljLrcqIFmnJZrRrQWUkuec62hkn1aepr9aeju27B
 VpNcup4n3+ZU4ocx/8gYipNCJYsnkjcH47e9TnQ7CxIZeQ2SP2DVSFbP+fePC45KXEx3fgIHFxH
 2O9hE2XCnCTAJHrEMMksQ2SgjyYEOZvXLhzI3vEqJlf8+44RWzU6BcS4iZUD+QVCfl0dgyV7Zff
 DqZBt/HLoAjktsscRe+R3EtPQfiQI=
X-Gm-Gg: ASbGnctJPgkOg3jo1j/QTvbweAb7rsS+ethB4wBG4IuyWK9wYHnL6Rgy3tTEQ/cbx7G
 AVbZqHj6GgZYLIB9sfQIzRXk2jm3FrxbbrYFm9jPaB2jTdmCje+zo/Y04d4+cfEypAuEnAiK+
X-Received: by 2002:a05:622a:4811:b0:476:8df3:640 with SMTP id
 d75a77b69052e-4770835aca9mr95696671cf.7.1742480708229; 
 Thu, 20 Mar 2025 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgBazF209Vlts8XuZplmFTdCgYI1Z4MeCy6pYSD0EjyOrHx6Qd48Izs62dCEIGuCgNfZgUuPjzDXpw0xl4dJ8=
X-Received: by 2002:a05:622a:4811:b0:476:8df3:640 with SMTP id
 d75a77b69052e-4770835aca9mr95696511cf.7.1742480708045; Thu, 20 Mar 2025
 07:25:08 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Mar 2025 07:25:07 -0700
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Mar 2025 07:25:07 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
 <20250224123120.1644186-4-dbarboza@ventanamicro.com>
 <CAKmqyKNmpRA8kphbWnA-AqTSUSGf+koSbCmuk6VgZEWde2NFBw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNmpRA8kphbWnA-AqTSUSGf+koSbCmuk6VgZEWde2NFBw@mail.gmail.com>
Date: Thu, 20 Mar 2025 07:25:07 -0700
X-Gm-Features: AQ5f1JpK3Ho0OMGev6NvaU7y-tUnDjpZ4g8bJDkBe1SNjgqbdkUwKBvtVx9fgqQ
Message-ID: <CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0qBLbLKhfv=+jb0SYAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv/kvm: add missing KVM CSRs
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, bmeng@tinylab.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 03, 2025 at 01:46:53PM +1000, Alistair Francis wrote:
> On Mon, Feb 24, 2025 at 10:32=E2=80=AFPM Daniel Henrique Barboza <dbarboz=
a@ventanamicro.com> wrote:
> > We're missing scounteren and senvcfg CSRs, both already present in the
> > KVM UAPI.
> >
> > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

This patch seems to have broken KVM acceleration for me:

  $ ./build/qemu-system-riscv64 -display none -M virt,accel=3Dkvm -cpu host
  qemu-system-riscv64: Failed to put registers after init: No such
file or directory

Reverting it makes QEMU work again.

My host is a SiFive HiFive Premier P550 board running Fedora 41. Note
that, since the upstreaming effort for this SoC has just recently
started, I'm using the 6.6-based vendor kernel.

Perhaps the KVM UAPI additions mentioned in the commit message are
more recent than that, and we need to make QEMU's use of them
conditional rather than unconditional?

--=20
Andrea Bolognani / Red Hat / Virtualization


