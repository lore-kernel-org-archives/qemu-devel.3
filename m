Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890E4C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAGBI-0002z5-Q2; Wed, 30 Apr 2025 18:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGAs-0002Zh-2b; Wed, 30 Apr 2025 18:45:09 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAGAn-00036M-Ia; Wed, 30 Apr 2025 18:45:03 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso66523566b.2; 
 Wed, 30 Apr 2025 15:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746053095; x=1746657895; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tk2FYkcbjKhZkaXcrUcRpZBO4gSLNUW6gGqhuPngwSI=;
 b=IGfvNeyoWgbZHn5kj6hgeQX3BGL6gNYtRq9ZQplSfR0MrGTXjKk9uSDH5yrx/+LyHD
 B6DvvYh3ynzh6nNvRNyxkUcaNmh/a979WeOKssZ5kusDm65M5GipDGhp+4aQe2+7ItG+
 xF6ZXWOBvBAJYtrWwVY4/h+bi3HV1ltOlGr2guhFym1zN0YiYaoNZfowwEu3M3T9xyAa
 6Pt7mmaLvYX/q3ZaiPKhuekPA9U2HlwKGJctaGJCbMRO91a8cSZkpag8ugBPvUvfqcbZ
 dk/Wbz6e9fcmPKoCx6VIkj4BRL1mQJhwRyooUpTiwTJYnzEWA/cEBwXuha+fjH5QTsPy
 ePmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746053095; x=1746657895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tk2FYkcbjKhZkaXcrUcRpZBO4gSLNUW6gGqhuPngwSI=;
 b=nwqJ6N/gaJ1fx8yeUyPfiDP6EbwTS94rSrpA7Oz1RhiQruI1KSnJ+We21dvnw1nGj+
 pGzIFoyo+E3kMTKK0REZnTfmQIzgFvG5scEWXtPLL1no9tUGw5i61r0rNnFa8pl7xfTB
 I1vgUHnj3q3yX5yXouvvOxZUT50KdmJLTB1mvN64nTQpxSAKT+aWXp3tXe95CF+1x3eZ
 EHlL/ICK5nREwZtF+CQdNKB+5oLlwtVunf2W+8Q+SOKY1VSrGHPVvtf8udSrdHsh/t4x
 OOF6qpDjfslUjhhge5TSKhTTcIDKaQ/jpwdBbarbn6bREMvjXY+5wbUTzufnUvQrvsIa
 K2lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUTQO/kbAIQlRBeFP9Z78Gi/IY2qpnhbr+8VckCJBowLuQMGUEbpBzYv/xt/bD/aFIHtcjH5akrBa4@nongnu.org
X-Gm-Message-State: AOJu0YyFNCasUrx3iH3eYbqbOmDEhIwSG7E4MEG9EUK5BslI7mkPt+F5
 BkSpdKhT563V8xVhK/kM/AYsQ/IUMqvqnGS2CvDN8dcvxXh/ZoumI1Q37XCWAsWK8g+YNdwFWpq
 i98iGD/CSXlVTyAtwEPuo80jXhTY=
X-Gm-Gg: ASbGnctQ62vseRNFqRzK/4Bhrd65KqzOy2qo8So3eDq0uP+rDhCel/dV/6LMS/q0DIj
 7VXmSRocItV0B5V47FB+KQhODBCbbch4yTdwewC0vI/Fj4SuoNsuonW+o3edZGO+quqlezDRnhp
 YJ/LFE0MkBxDvI7D6/Zm4ExhmuEpteKspEA6/YbXphhKzivQEoUkEf
X-Google-Smtp-Source: AGHT+IGRvxDAJAdFIG888Vb6S33MXGpBfTACDRs/XPRmd3CP4WtKrmgk3ludhRgeXHtDoddgPSTY3nZgEwYiviR9/kQ=
X-Received: by 2002:a17:907:9494:b0:acb:4cd7:2963 with SMTP id
 a640c23a62f3a-acef42adea1mr103805166b.33.1746053094537; Wed, 30 Apr 2025
 15:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-8-richard.henderson@linaro.org>
 <5b298186-50c8-4473-8eaf-d0bc6f6793ce@linaro.org>
In-Reply-To: <5b298186-50c8-4473-8eaf-d0bc6f6793ce@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 08:44:20 +1000
X-Gm-Features: ATxdqUFkktLHd-pq3jmusM_fOWWttg_d8TakmmDwIi353_2XjbOioWpt7P9E01s
Message-ID: <CAKmqyKPxSrLkRCjiwcKHHPBapLyk50R5DLtRFSmfVRxYq0ec_Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/riscv: Fix write_misa vs aligned next_pc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Apr 30, 2025 at 12:34=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/25/25 08:23, Richard Henderson wrote:
> > -    if ((val & RVC) && (GETPC() & ~3) !=3D 0) {
> > +    /* Suppress 'C' if next instruction is not aligned. */
> > +    if ((val & RVC) && (get_next_pc(env, ra) & ~3) !=3D 0) {
>
> Bah.  I preserved a second bug here: not "& ~3" but "& 3".

Good catch

I squashed this fix into the patch

Alistair

>
>
> r~
>

