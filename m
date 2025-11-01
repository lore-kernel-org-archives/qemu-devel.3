Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D274CCFA00
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 13:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFByA-0005pZ-KI; Sat, 01 Nov 2025 09:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFBy9-0005pR-7R
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 09:48:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vFBy7-0008LL-2Y
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 09:48:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so24905795e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 06:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762004913; x=1762609713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vTWT/W8ejaLX/9gBPa0QXvAgbwqGxabIeP/UifNl+4=;
 b=SAEw1UZCeIGHss+lgqMxmF6cUe3Z04LdyyBX6ExRmmbXoovV60OiBtV4snoHNz0Ogf
 qyjjq6WI404Ns8plrenzzrn2LwJkCd1JUoXNPAGtpCmFiOeAAildBggjbbV+2z4sDWiF
 SB0/ECqzrwAN+hvBwZh6FFpOWD7VXCWMyqGVPPKUI6twlhOzlmO+ERx1pe3ON0xY59hZ
 3BW9X0CQzWgaESFmuLTtj2qlR/q34y/Ejxt0WOvioxOWm6X+4I6fEr8gttKqjg1ZoMSD
 lX5LSixle3sN7KkHhnVrhhXtVojDrqkuHR+geAA85ttufYvVT6rGPMi2TCQOdTvtTxyL
 2pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762004913; x=1762609713;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vTWT/W8ejaLX/9gBPa0QXvAgbwqGxabIeP/UifNl+4=;
 b=P+4kXD6Llemob7jOMMCkKYvkvmnYR/eycRw4VzW7p9fSjpVy0vjSnP+sO+0TCQR5k1
 ti5OegeHWb38Q+pRu8sWGz5r0HdrirLuuDMmER5nBOOX/K+BGboevY4m5YWcFU2klp6m
 NTXhuApLuXOx3xzukmAPRUQqy76ijuaSDu191WoFUDW3aXae0oDsWUkjcqLNkQfnBPJo
 lVh4fYW9pM0hDGDKo7S+y8dJIN/aZ2CjwEKFzh2r6aRWgBxRmkwVvXBROSxBmfD0vguQ
 PerlU11NeFbdwpUISlnwAJ12Z359eRJ02hjduvGGwcl5YKrThd6G/VeMbeEBKG9/tgvQ
 2f8g==
X-Gm-Message-State: AOJu0YxLIHSTYW3gARDIIQJJJDy4JjifIdcK5oybeg4GT9dFOcv4tD6J
 l9f89LLRM4ykoye+QxPpl30LaT5sDV8OjbPFbsJQFj3sO5bxiAfIZQTM
X-Gm-Gg: ASbGnctpeCz1jOBmpgniT0E4KDCa+ha1KUnU6kMQ/a1tv8bFpbVmB52yAYXfLVwO84x
 PlEPuUbzculLIRIM6LyYZy9/hd3KsZiyTN7yb3UPLnsthzR72qRlfRNxIIHK6etNkm+Uf6OkiBB
 3SMQBpbDyFbsX0ehOBFduwP/zPpx1UdpjpjPxeddx29CnwdDRX1HB4JUAB3IdvqKw8AC4qFkBsZ
 +FFLdi5vZunv7NLXy8lk8BAVruh9TskjydwG1id6tnT1w5BKTWxBx12W0uJIp9HagJEwxXyNwcA
 1rVhjyKrlAVJMu8MEYi2XAJ2tb7op/WMD6g2KlupC9cVbIBZZ4x4Pz0BRd1fN13AMgktB2cFCFZ
 2xeXA8gKeG1FSdRBO7CTuwZ/EFzP9jPAe3NUONx3pYpUf167JwnXyF6+OWEsVSOKAKQtOXEYHMH
 LmKxluILGqbsF91ouOlFirrOWK0qK8dIGOh/HBkWThjgePu1+vu3wPyz37idsPQBHX+9GuPGOo
X-Google-Smtp-Source: AGHT+IEMjN7+j8dj1pTfWV6BKNz9qn4I+YdFBfhXRbacre+curyQ2b3k1nS/Q/LZwrUC9zs/qAUEAg==
X-Received: by 2002:a05:600c:3f92:b0:46e:4921:9443 with SMTP id
 5b1f17b1804b1-477308ddbe0mr65703375e9.37.1762004912691; 
 Sat, 01 Nov 2025 06:48:32 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400bdbc21c775fcdd84.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:bdbc:21c7:75fc:dd84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c4ac18bsm48334735e9.5.2025.11.01.06.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 06:48:32 -0700 (PDT)
Date: Sat, 01 Nov 2025 13:48:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_qga/vss-win32/install=3A_Re?=
 =?US-ASCII?Q?move_=5Fcom=5Futil=3A=3AConvertStringToBSTR=28=29?=
In-Reply-To: <CAFEAcA-ycNEcZGF0kqLYBzq4xLSJikYZL_Q0JyKbuMuDtAJ7JA@mail.gmail.com>
References: <20251101130330.1927-1-shentey@gmail.com>
 <CAFEAcA-ycNEcZGF0kqLYBzq4xLSJikYZL_Q0JyKbuMuDtAJ7JA@mail.gmail.com>
Message-ID: <6BAB4EAC-80E2-4DA3-B344-D233C014E7EB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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



Am 1=2E November 2025 13:13:26 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Sat, 1 Nov 2025 at 13:04, Bernhard Beschow <shentey@gmail=2Ecom> wrote=
:
>>
>> Now that MSYS2 provides an implementation of the function it clashes wi=
th
>> QEMU's, resulting in a compilation error=2E Remove it since it doesn't =
seem
>> to be used anyway=2E
>
>The comment says it's used by _bstr_t, which presumably
>is in some Windows header or library that we're linking against=2E
>Our code seems to use _bstr_t a lot=2E Is this function definitely
>not required, or should we have something so we provide it only
>when MSYS2 does not?

I just grepped the code and it doesn't return any users=2E And searching t=
he git history it never did=2E Maybe some library we're linking against nee=
ds an implementation but I can't reproduce this with my recent MSYS2 instal=
lation=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

