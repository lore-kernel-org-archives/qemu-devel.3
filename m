Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF604C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5wf-00026n-G7; Thu, 06 Mar 2025 02:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq5wP-00024n-Tz; Thu, 06 Mar 2025 02:46:53 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq5wL-0004fp-NI; Thu, 06 Mar 2025 02:46:48 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-51eb18130f9so160035e0c.3; 
 Wed, 05 Mar 2025 23:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741247203; x=1741852003; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXGOOJJbWyvt8cnGs3i5ZreeA4IzkRt7Ae6iKhVa9+M=;
 b=ltSlNIr9VQGSL5P4L9OFk9w162NtzGAGejH5l8/I/O9HtKfUdtavuxTvy99VwY1oof
 jmxe13OjhPYzNJJwDkwWmOSuzq3m/UVCcphHeY42pEudFokELyuokVYPinQd+YZjNdb0
 VLQs9yUy5WwfLqKjny2cq771R6EwFO/VVmm0ebdQnsOmHeeO8CY+7Nn6d6OJBuf2thXt
 GfP+Y0LliSs5VO6XLa6u9xrXyZGhwGmgrgYk84y/asFUvtTHhmbExUMlW8IcQ4q2C0fO
 vOU4+JgCJkAvv194QY5hSE9dGB9KN6FWkh0L8tXkKE5V2Wupq1DeJkd4FLWzQ3l685sj
 IFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741247203; x=1741852003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXGOOJJbWyvt8cnGs3i5ZreeA4IzkRt7Ae6iKhVa9+M=;
 b=ZLei/ieJ08sAt7ewzFKYftfY8o6JxdCdmdMIqgU8X/RKQZ8u+KjgamjnGqTzS1wzZ+
 NywW3xN3jpCBfIznJtHD4DME294A2ukdQaDndkrZ0hgJUCe+RzcXaiLz42Zof2CIn4/D
 Or2qDsmlVhVvz2Tnj9D7LPKRJk7OY9gIEbhLOEt6qKN48a5u7irf4g/yZJlgBQgDwz8R
 9Xw5QM3W0QdkvfK5RVs/NnHnA7DTx5YxauIYdi9kqn8iIYoYmxr4l+X7KTus28XBUmbE
 EoMj4xaU1HShRM+9zTnE0ap0o5GrNaeTWcoJhw4mq/TBBr9JKwxJZnogA8iVwunFTRjq
 bWJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0cCK/IYca/eGkXFShRB3t1IOzwyUGfyu/k0j2Acjz8xAa0ZTShWqDa1S6rPA1+zOoGHaT1n7wMIU0@nongnu.org,
 AJvYcCUpefnODQ4UTyaUGYNiizxlFAO4ySfNoEqgLK5Hmv1UxLrTsEXQ04cV+JNrUMuKAAvoHD06HzSHtN+5id4=@nongnu.org,
 AJvYcCVx4jfuu5jePd8SOICNZp7y43BeBn3XVBc0FiDdiw68zeUXbrpIpIEKlx2hWI6jErUy7AouSQorPfHMvg==@nongnu.org
X-Gm-Message-State: AOJu0Yz8VFeNfecomdxxRyGXKTWI8rc1h0ERq4qVl0yrgSiSGcuDqfqX
 3beQsQw+s8mA8YjDymCkv6Q/YNRsXQlpZYGcPHH8BpIafo4iubU+elqNVdIcNgakGg3UqOdOGy6
 bDkrn/dOinqt1laUQ5vxTjeCzy/fXK3S1BBE=
X-Gm-Gg: ASbGncsFXhlXiux9g7LyQzaNdGOWPTAIaUGvCwAIJA1mh32frHM61mCovsSUv6i/enb
 yN9M3gtkrI2Q3K99ML/DFa2KjJM+8KAjMJsyL3K9zXSkBFkSf4HyzwqadUzw+w10fuyeEYYO5ag
 sqZz98PTGEgNwAIOdHOePVZ2MirrWd7dUMjRHLgfLEaQiIbiA9kYuEnw9p
X-Google-Smtp-Source: AGHT+IEISZT2o0tRNDOyyzqaUny2ft6kMI94I+TY8DyjBP5DtBqeKf5A+4fc5pTVlprQpDKWqPey4hdWLuF2aDoyKHg=
X-Received: by 2002:a05:6102:15a4:b0:4c1:b339:e4f with SMTP id
 ada2fe7eead31-4c2e2744b1emr4103617137.4.1741247203488; Wed, 05 Mar 2025
 23:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20250114212150.228241-1-r@drigo.nl>
 <558cbfb7-fdd4-40b1-84ee-27c1c6aba4b2@tls.msk.ru>
 <f741f6da-46b6-499d-9432-11277b9dded6@tls.msk.ru>
In-Reply-To: <f741f6da-46b6-499d-9432-11277b9dded6@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 17:46:16 +1000
X-Gm-Features: AQ5f1JrX87dnDy7IErkskVOSCMz4J9keaE0vusBsVp-XpsYQL9KlZ1q37-qu6fs
Message-ID: <CAKmqyKMph0Yjo0U4SOWMzN3N84zCzxxTPZJRU+GqVU9_zk45JA@mail.gmail.com>
Subject: Re: [PATCH] goldfish_rtc: Fix tick_offset migration
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Rodrigo Dias Correa <r@drigo.nl>, anup.patel@wdc.com,
 Alistair.Francis@wdc.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Thu, Mar 6, 2025 at 4:44=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 06.03.2025 09:35, Michael Tokarev wrote:
>
> >> Migrate the tick_offset directly, adding it as a version-dependent fie=
ld
> >> to VMState. Keep the old behavior when migrating from previous version=
s.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2033
> >
> > Is this a qemu-stable material?
>
> It is probably not, since this change adds a new field (and version) to t=
he
> migration stream.

That's fine

Alistair

>
> Thanks,
>
> /mjt
>

