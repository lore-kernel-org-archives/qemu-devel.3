Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB42AFB3CF7
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79cd-000501-Lq; Mon, 30 Mar 2026 06:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w79cU-0004xb-4G
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w79cS-0003IW-LZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774865596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LA0ZDZS7OsMnBwWlkhq27STqYWfDwqgl+NEJ6H+mZOk=;
 b=JR/GpR116mn8q6CkedwFkWLrPNXFyjZkWygo24wboWACWcG1Y+T/2ofPdeK9NF48A5Oq7B
 Ou3CxaRb1obQ1RYYQawMHeUTufsz+9FmpsLnRqfPqGkM1l64PekK4WykYQdKxWwBwCGWeu
 ivhgLQwvUEUt/p+p+YaPXO6ilpMyS4c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-711qVxZOODWpNQlwE3eE7g-1; Mon, 30 Mar 2026 06:13:14 -0400
X-MC-Unique: 711qVxZOODWpNQlwE3eE7g-1
X-Mimecast-MFC-AGG-ID: 711qVxZOODWpNQlwE3eE7g_1774865593
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b4dcdb372so3786524f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 03:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774865593; cv=none;
 d=google.com; s=arc-20240605;
 b=Cub2KNqRQKhfiM2Kr3ApqPSeZMFT+aOkTY34Zhc8aekYI+WZzrawTZXVEHn3s7z25+
 BpyMCdpBHZL9nwch7sBtirPY9waWWhKtxJhu6z3fHmEHJTl4GRose3KO/V636ny7AGsZ
 I9ystifOjycz4DRYdb80cXy6t5ctw1O0sYy4GwSY3F2YDTmHXPH9fhV+j2MlRVr1Ek6j
 ilrbRGkTugbJLXB/3AabEzqz3VjnW1zCthZ42O+AvUF4mYnlxmqKJVT7rlPPdUDsyRUZ
 ToT5wiBM5ahzdaS1MZVOcv6tRQiH8bsQwD8c/W0T1A47fs3iUanwa875IlziYbHPoaDj
 SPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LA0ZDZS7OsMnBwWlkhq27STqYWfDwqgl+NEJ6H+mZOk=;
 fh=dWjkl4Mq/j1gKjXKVcd8FEUInjvmiQY4ai9d0PTzr1s=;
 b=Q/qJWD1763My/SInp/Bk3ecskccmDEU4TcvHd2ru2GzRqAn+SC6kJfh2OZAvC8DBPX
 6ayHuuv757Mv0qXPQzKo53dYd0Mw5z+7zIxuzJqCNvCLsaYZY6MHhVFTbS8b5WOKmKxD
 zWMwngzujr1WBOCOxvYgy3+6Jun4GSA2hyOdAAd5Gr4aNuVwsLskAy1g4BjMfQl5xI01
 5KP7rcdrclrJYGoySEveBu0l0lQeVJLj8EbgPTfdbYy3L4ASHFCPelkTUBUC0kXAVFgv
 4lFkcmAvll2/Q5jwUOKM1A0v2URcQwCzak74/LmTD5R1EHRrmmsUrrcGYoWsMUKnUE5D
 HU5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774865593; x=1775470393; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LA0ZDZS7OsMnBwWlkhq27STqYWfDwqgl+NEJ6H+mZOk=;
 b=HHFF+LF43L/Jij/EExtTrNuXktVML4oOkkjlmjWpjKg7rCHAfSvE+RHYr+frpZYUB5
 vUEPSHfjRkIHDTtA9VllI/uW2EdBTP8yZxE1WXgtwlmZ4e6gGZLXAez8xzR5dWvHnp7n
 ZnFXIqpckulC5XfTLr6gq1YYMhrNbLNcMt5nhHzk9v58tYIm0Ke948DXoZQFcG3tGxi8
 6UfD9bLPFaswVtb6BpYArz5mVcGqbzj5UmalcrVMwjmcNlPm0QGtHp37ZTH1E8JBUJr7
 roCz1eg9rDyuKGJTyiSz6d+2/LNjVRsUIl57J2nWMAiOPJlzEG0prSqMmInUqZTlEfdT
 k4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774865593; x=1775470393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LA0ZDZS7OsMnBwWlkhq27STqYWfDwqgl+NEJ6H+mZOk=;
 b=mHizOKT1dpjc2YdpHbZWv1t/jUedj/ObMtKBa6B5673wOH0K2Ked8Ogy71NzFAV14I
 O7eHhE1E15QGl3J9Hyf6j9a8j17Wkqk7lLypkb8zZetxostf5UW21tb+D4KX9bdxh04n
 wClJRJhtCOfuhPg+CsgNcdGLqJq1gh2qb/9saL4A+z4z55ItbKCY2nFypBi5qrVw0LvL
 S0y0iX+5hYXKp0IokzGO+ASPdJhfFeIOEhJv+CB5WaWAZT7fjmyneu1ojYQhsk8ynOM3
 MjRP0XGWu/sd2zIoI7ucLqkUgbyMHvaBOvFqtCL68SfmLQKZY0vzMwTRZsibM+bHMzpk
 LH8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnUSYjFSsc9aoXUZz+Ewf5sXH4xlaWkQahxJHXPDr3bb+3a9K1RY5Uj6nRjbFg7QrsbqWDdRwNUOgM@nongnu.org
X-Gm-Message-State: AOJu0Yyg/k2l9UrvauNPrRJks/bwPh5n1mROt+XH1CBnjUunjXq+sJ1v
 KLV6dzaCcNWEJwPIJ6rr45ne2qYZ388bP9gu4KE01syb8nvP9ckZtOP8nl87e0lF5ZkRk60c6TW
 OqJSNtlmm4PQ/vWWYrKNxTCbXD2v18Lu45uZ+dZzIcuBaAf1KQK33FNzeTWxDn9jr5/f6uuJo3G
 p3cEccoW+6R3KsV0vvnJ9MlXLT57C8LKQ=
X-Gm-Gg: ATEYQzzxZtwxDOsrCjhKYWJkJB99NLngxyLmNRPwaYtZ05+abiZKAXCH5PjQngb+Q2E
 HIO805QuKar65OODqfSm6uX12lEUj0XFz1HZ+micrPaiGMyU8oKhroN/kTe7Y2Xp2ewAzTDFsni
 N9/ItyMLmXHAVXVvTwimBON7GJlF1Q49ixPzQh3sZsEjqvT6FJ91HFsbQ8eRj4lpvM7qAWQNPoH
 6ZYDTIDGJTIO2fBGknqoHWz3ytjeY8Zwsk8Tcpyx4mnmiRkjIXpYlDtvNcUmJY6/UogqjpaKkqn
 0Vz+
X-Received: by 2002:a5d:584b:0:b0:43b:8f38:3b88 with SMTP id
 ffacd0b85a97d-43b9ea4acdfmr19432575f8f.25.1774865588562; 
 Mon, 30 Mar 2026 03:13:08 -0700 (PDT)
X-Received: by 2002:a5d:584b:0:b0:43b:8f38:3b88 with SMTP id
 ffacd0b85a97d-43b9ea4acdfmr19432525f8f.25.1774865588071; Mon, 30 Mar 2026
 03:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260327145012.907264-1-peter.maydell@linaro.org>
 <f31d3ba2-b843-4322-aa8e-2c5a1cd76fdf@redhat.com>
 <CAFEAcA8UQsrFo3nQRN_3F6CAKQGWCgv1AsEP7w8FD5-EWDh8rg@mail.gmail.com>
In-Reply-To: <CAFEAcA8UQsrFo3nQRN_3F6CAKQGWCgv1AsEP7w8FD5-EWDh8rg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 30 Mar 2026 12:12:55 +0200
X-Gm-Features: AQROBzBR-96Sp3AhCSf4Wx6xHqGUpD4ew0_7X9DIw0JviR6KuU3niLuWwrIGrBA
Message-ID: <CABgObfbBuV0G8t0Ueq4xzhU5c0uBgXbbo_EpPZLyHtDp9=+dHw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode
 option values
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 30, 2026 at 11:48=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> OK, great. I'm going to do a pullreq before rc2, so I'll put
> this in there. Or if you're going to take Kostiantyn's series
> and send it out for rc2 then feel free to put this patch in
> there instead of the one that fixes up this file.

I wasn't planning to send his patches until after the release, since
alone they don't do much (they're not enough to allow the MSVC build
to complete).

Paolo


