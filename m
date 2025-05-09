Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E854C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQAo-0001LI-0a; Fri, 09 May 2025 12:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uDQAl-0001GO-P4
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:02:03 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uDQAi-00047C-4J
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:02:01 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5fc5bc05f99so4008029a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746806518; x=1747411318; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaX0uy9IjfHygrfN5w330lKGejmUbRLIU5zry6e12xE=;
 b=ZUdWxAPgH28RnVv01Gl3FmFJ36ESrKFgJQxqWLZ7Uj3Bmmfz4znrT+oKmikmwknVl6
 c6MUeY4aE49AHpXWvG0DzjX+4Gc0m42QQfw5uQwS30CaUuyy5Una/s74drjhXDNku1/T
 2MRjLVIdyHPhU0vh2EKbcJKzhjyX1fNjLdQztQyllGqbyYTWoVR4JG8rO4UE2M8x9udc
 avN1AIWcUOOpCAM/k4K+PDdSC5KUAHKAcF1h7Q/NwD7jh9FvBYVwSeBxXbnX2DsN4qpU
 UtaxlYG5G55G0Gg0Uo+YjU3LuODJWYJqkS1HAknOCX9nuk57ws+6YSr/dAQsXrgxG6WM
 26rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746806518; x=1747411318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaX0uy9IjfHygrfN5w330lKGejmUbRLIU5zry6e12xE=;
 b=fZh4+p7u6rlH/udTUywVpHp8hXsN3I6CAJDBAy3smeVwSjKy18l79kZsxC5681Gf9a
 mrKPZhDmEhrJF6kDgPSHW1Af11TfY10AVafCic5iV3CAYsn8Ux4Pihn5uygC80pVStvm
 dBveKXcCM4ROd2NbJw8Atk7ki1BuhRv9mh1Rppl4cTgK8+VUHR9qOrSkqexDgIziLiYM
 qdxh7uV/uWq5kEl3bBLKY1W2Ws+Wr4k+PMRNCEOmiZYP0khpDv7nTtnuQxwNTJBRdnHo
 VLyrR5/SkpnAK7zVWH/tAkzVafoA1Y0UaB6LpLFYh2qB/E/p1XKo+u2Ew9cyeTJmoWC5
 yvtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXagAB2nqXNdqq9U6YP7RWgDEJvlbOOaV5hb2MYI+xLtm5q9sNmHXnqGROoJ4YS9Txp+5BGzydVpqQR@nongnu.org
X-Gm-Message-State: AOJu0YxInqNcm7oddC3hWE8iCiKCzbwbtVX1vYkLtwN4kNVb3IN7Fs/P
 6sxzhSQ4Eyal+rZcAXXyENv/yD4XCNG0U+4d6BDtM4I9g8wK07TGE66dMr6s8M8WxHBHbCdJwvd
 Os6iuQnNM76Vdxu4m2A2VkUQktpxjLwkX
X-Gm-Gg: ASbGncs4Ivyaaaj/Pll8+ui49dXkxmZiN152AN92R7NtWqw2pZFCCWdttXrUNsEyxjU
 pmmyGc74ELiOWJWLjLYjf12mFoho1feF8OlIB7MXtZHQbYSdBYv18v2UThQyPBPRuo5pqdlK3IE
 J51K+U+PWX2G66NWust4wa
X-Google-Smtp-Source: AGHT+IFfxQszHP8CGHa/B6Fv4dM05WpMvqS/wi3tEOQqTlSwWwREGGYN0rweYtkb0n2oYtCQ5Nf2Q45zzRL728elI2Y=
X-Received: by 2002:a05:6402:34c6:b0:5fb:9f73:d0dd with SMTP id
 4fb4d7f45d1cf-5fca07708b2mr3471335a12.15.1746806516917; Fri, 09 May 2025
 09:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250508155439.512349-1-pbonzini@redhat.com>
 <20250509141302.GA82958@fedora>
 <CABgObfYUdYHg0ZJXCwjTvjxUK4gDXaE3-S0uvSMye4AcNn5GEA@mail.gmail.com>
In-Reply-To: <CABgObfYUdYHg0ZJXCwjTvjxUK4gDXaE3-S0uvSMye4AcNn5GEA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 9 May 2025 12:01:45 -0400
X-Gm-Features: AX0GCFvXLqfLi2R7YxXZfXsVQLx9Ck11xIBsuHipTOlNw81zwGW-TYxMvFw8uyc
Message-ID: <CAJSP0QX+DvmErwsBp3PYhzBXtDr6K93uv4afx9PoAxx+xyw8+A@mail.gmail.com>
Subject: Re: [PULL v2, part1 00/15] Rust changes for 2025-05-06
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, May 9, 2025 at 10:55=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> Il ven 9 mag 2025, 16:13 Stefan Hajnoczi <stefanha@redhat.com> ha scritto=
:
>>
>> Hi Paolo,
>> v1 is already merged. I'm not sure what the purpose of v2 is. It looks
>> like you dropped the wasm patches but the reason is unclear to me?
>
>
> Sorry about the confusion, I sent this before I found a reproducer for th=
e bug (as a kind of "bisection").
>
> You can drop this.

Good. Thanks!

Stefan

