Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD6AC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 17:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ8cf-00012C-Nw; Fri, 13 Jun 2025 13:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1uQ8ce-00011v-0a
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 13:55:24 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1uQ8cc-0007Hz-Eo
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 13:55:23 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-747fc77ba9eso2285920b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749837320; x=1750442120; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H8fXE2/zwL8aPV5VLtSXl2W7CS5yiMlRD9fnsreFYV4=;
 b=brTmpqR0Z3qTtt+BYPXPKhSmhPBfThyTeUwxieFpcxUCO1192/SraCmbXvQmJIeOox
 wAbf6MKXkddsIi2l4hveUa/uKYWUtr41XZOsrXmpzSge53ANX7rLwamMhedMY1kaDONV
 c5h59udHIxn+/CyW90MXfyG/PRr5Q+gMQprzPZqEBiNf9o1GYSTBpabux82S02AwPc3t
 uxmFtpXUTmLHzeOlmRxkacTnT0ANKTfzdkiKqVeqYl9+WV7PiMuApuZ1MmnmyQuyzJuy
 J8ZJtcn8HYXN8QkiNmhIIGeAbQh1SWIdyHdU76XncIFHODfp1iD77NhHWyT/g+5svh9d
 KvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749837320; x=1750442120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8fXE2/zwL8aPV5VLtSXl2W7CS5yiMlRD9fnsreFYV4=;
 b=TOXbkSt7TbI8Ld1gaw2PFPg4HI8/uocNKKZRsLFVZvH1bPx//UaPdFGF0LUBl8UAhB
 M4J6Pz3QjvSfcZCSqz02e2bB/f4vkNKSz0S55K6PJtYAVRg5M+3qUpPFwfL0jiZYYQIZ
 kRgek/OTkW3Imz4BfIngGoLdpJAKziKDqgd/6m4nnpuCZ6/hhZs4Ey1/HoyhAk0PCJtE
 ag+mqA5VqG6hhKPzCGlmv4zLi5ta6V0wi+K32AsTTXe3deRtSfd43NYaAfpi70gtYdV3
 snlN2uJP7WO1oF1JUnpB8elNBEIVPy6xtIYg2J9Z4sHwVdLIOTgWz7ke/4XSqzCkVttE
 G2tQ==
X-Gm-Message-State: AOJu0YzIzeiXdghom/4cFA3bfn3JcoomHKnLzHfkwQ366O5UjGcm1z3a
 T/vfEK9dzXkOLZuoqKHunu76B4q0X8n+FYVVS+GmtXNVqxZTILS/e0DFbctUgAGN4v8F2OtVh/N
 TPnlA5+BSEFp+0suX3auNXx4QzH3WrL0=
X-Gm-Gg: ASbGnctFNydk02xjlJFC8yX/2LZ67ZRhqxh/MYuyIszP5PNsReQS5e3v3DKpQoAQiR6
 jy3PTF8qqIYb12d+rZQxj/A2Ri659FXGn/rExjNDzlG5q3h/AG92t+FFgMbtRBHIuPfHxPt4qKQ
 7WI+FB+zET3k2/c1T59ORkAVZWDRyta8ctwF6/mY8I/8uI4KgTRTGC
X-Google-Smtp-Source: AGHT+IF1Ly7rLmSyR5RSn8NIYzhJx5QefRpCqUVqzYJy4VVzF4AXORP4Xd4J0aMCFPM2soHVWKWQsuQnBlc6D8KW8/I=
X-Received: by 2002:aa7:9385:0:b0:748:3a1a:ba86 with SMTP id
 d2e1a72fcca58-7489cf97d1dmr288051b3a.11.1749837320306; Fri, 13 Jun 2025
 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.11@sean.taipei>
In-Reply-To: <20250613.qemu.patch.11@sean.taipei>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 13 Jun 2025 10:55:08 -0700
X-Gm-Features: AX0GCFvgHE_JBvwYzJyovAWjo0hILeHi1Kg9OUUWCFxlDnokU9qSuc6EEI0MD5o
Message-ID: <CAMo8BfJrexsXDygHGvLrPM0kxpjRN2g5+CkqRPMQWu+TWbRK5g@mail.gmail.com>
Subject: Re: [PATCH 11/12] target/xtensa: replace FSF postal address with
 licenses URL
To: Sean Wei <me@sean.taipei>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Jun 13, 2025 at 9:54=E2=80=AFAM Sean Wei <me@sean.taipei> wrote:
>
> Some of the GPLv2 boiler-plate still contained the
> obsolete "51 Franklin Street" postal address.
>
> Replace it with the canonical GNU licenses URL recommended by the FSF:
> https://www.gnu.org/licenses/
>
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>  target/xtensa/core-dc232b/gdb-config.c.inc     | 5 ++---
>  target/xtensa/core-dc232b/xtensa-modules.c.inc | 5 ++---
>  target/xtensa/core-fsf/xtensa-modules.c.inc    | 5 ++---
>  3 files changed, 6 insertions(+), 9 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

