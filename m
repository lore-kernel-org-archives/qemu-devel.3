Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B81061B28
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 02:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Oan-0004Vc-4t; Mon, 30 Mar 2026 22:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7Oaj-0004Uo-7h
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 22:12:29 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hayatake396@gmail.com>)
 id 1w7Oag-0005oS-Ob
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 22:12:28 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so836870166b.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 19:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774923145; cv=none;
 d=google.com; s=arc-20240605;
 b=LOq2YQPyYJYMMJyCZKuZwgucOX4HlM8TWNWi1thLLo9YmGWR5yLa5lUIVKcZ0NdbOQ
 0SiqL3T7aYk3NlZYdPyqUW/v8+6kL2oOUCjDxZrgLXdWZmFjsUfO/uUiUn2eDswHpI5f
 T2i+yHde2C+jt8Q7fZ6tREoYi4JvTChjO9iIp1hSOGqy2VTVRupmgd9I0tmmYcOtzqji
 FqJgJY4lF8QXDbggnliEbgWfoNzxxjxQ/1iT5tYo1KHmeDJH9JQNvrwLaa4wawmazPKR
 ENyps9KmD3KOt0kmozwYFxPkw7yPCXZqDygDy0kJSU0bedb7dLYQUdDxzEGoBZ6GuQWQ
 y38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5eOKoizzmGjJ5/RPHppmqIdgM605nCbKZrotSQFsIB8=;
 fh=l34yKrB0yromHHDUji8ziQOfQo4HrJ0cM0LWNUDHuFA=;
 b=JB4Tw3r5UGI/xAQTeLBNKQ2RJjDqPcXnnSx75k7j2rEthMTqDDaIX8rIQe/xT7jf/z
 bsiZfKMNlQR0KwFwvkYBDPPhwI+p80YE0pMpHDKeGNuPIm2AJ4ekzOKtFv6Mxynq94y4
 jQuK90FNeclwZQHNIChOtoJRSOeNt+euG0XQf++HXRwH0OgBUOphvO8wtq0BMAMlAohO
 8x+xIY0HulzeMBn72Bx3P8az1xKjnvji9aOIeZh9wqKw1CLpoDbUF4BS8dHtgwgxQzvy
 0P6tqwf0kJzY93tEojrfuBeEoaksaKK6ru8/d4Fc00nCuvKqWS7Iyi6S39/qzNTIcemp
 pRkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774923145; x=1775527945; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5eOKoizzmGjJ5/RPHppmqIdgM605nCbKZrotSQFsIB8=;
 b=N36UMQxoGath/HS1lre4qocx5qxO+/vcRSXXjMZW0+9f67a3CCUSyoCRQZ5FqeKMlg
 yVclu2mJZGHaRCkquoYoH/XUx4GHnmIbdwZNOmzJraCuPNzfpHk16L7Abb3iZX3XW93d
 zFJB4dt6J7tmDjnq68tolqGbOtzI1m4Py1RpXWPYbX/yE/VkaNeVFVLIqbMvPMBrY3hU
 QfLW/+Texr6Yn7pKiGjptSj3JrL8KTwma4sGqFRhwbWer2t0jVl6Z3J4GWTAbr0tKrKi
 eV8VjBCS9n2Y7U0jKy9rFyV+PXudQwlRkb3LJg6ihiq5vVXf7d8GAZD46HZ2/qRgJwVF
 wbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774923145; x=1775527945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eOKoizzmGjJ5/RPHppmqIdgM605nCbKZrotSQFsIB8=;
 b=aE5OSzpSFUGdbsbCLI+cYo1bYdWDoQ8ZT5Qj0awqpYqwFfj7Zh+5ObDKUGYYfp9AMq
 szFjo4F2tbckTg+8/x/W2QSZOyY/jhH+YV+Fl+24IrmyHvc2uBQnoPgRPdjBqUgjQuxD
 UPozJ6pwoqOWfxapcLSIZaeVmzFKRJKcqWRneHGtJEBJcV74fbYT7kspdVIZl5pDqmeW
 8b8frVOsfeHViBlcZED8ZVmH1wAAXOhZPzSWYh2gTpjiGqLjtd3uJLSqPLfUYGAEOdAo
 PjoaWAKQyohEsWScYw4NjeFSdHS4x8hSNc9KwP713Wx47o5w8Og6mm4KQyWnaSm6+V6d
 P8Wg==
X-Gm-Message-State: AOJu0YwfApGNAlhQVGWCqSpardeOAUztn6kqyLZaW2qN9egrWiIsztL1
 /+hrdMfoXM5LTqOIPfSg7/TkgC9kJ04a5bExWXNPibJSMIJzj15whRSp65O/D+sll0q4789QF4w
 3CnkcmMDf+WDpZarLd9tXIjdO90HowGI=
X-Gm-Gg: ATEYQzwimxQeon79vVQK5UhuL2KmVs5W1ZFQ5w8ou98+UBv3VILx/0RvnFDTVZfRbxu
 ZVtlozlYQIFbirqtEqtYURYfv5um+KiOjbgFjlH1AaqG1HyQkBbDQuD9oTqxS/dprZV39yijGNi
 xHfxmjEoeMzjlMJRgSoc4kQY48zQ7HHxgIWBmcuNAgWBmSfDj9O8aRq4IJPxw2T+ajSoFrMGKU7
 oetlb/OtY3XQQbB5u+Gx8aYRc34ituSTfZ88+mQcQGKV1lWOZTix/EK+8xmV0+FiLhE6157CePG
 JmqUeMhImyP5unXaieTgEQ4v403JgFLLaFkPrIk=
X-Received: by 2002:a17:907:3ccb:b0:b98:86ab:f14e with SMTP id
 a640c23a62f3a-b9b502b03d7mr920547166b.13.1774923144875; Mon, 30 Mar 2026
 19:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260330-fast-snapshot-refactor-v1-0-22143e70c467@gmail.com>
 <acraAru2XIjMIpXW@x1.local>
In-Reply-To: <acraAru2XIjMIpXW@x1.local>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Tue, 31 Mar 2026 11:12:13 +0900
X-Gm-Features: AQROBzBjfF0IgZ9EcUbRnSNIvwS2wxudvKGhP_lB6edlsJk1w1HJ24EKUjFuM9E
Message-ID: <CADFiAc+sTWgxeHhfQmFK3nz0VKMGuAj-utzcNzqTgA1T4R-r2w@mail.gmail.com>
Subject: Re: [PATCH 0/3] migration/postcopy: Preparatory refactoring for fast
 snapshot load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=hayatake396@gmail.com; helo=mail-ej1-x629.google.com
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

Hi Peter,

> Thanks for your interest and enthusiasm to the QEMU community. Said that,
> please hold off a bit on sending patches that enable fast snapshot load for
> now, even for preparations.
>
> The problem is, this topic, as announced, is to be developed by a GSoC
> student only later. We want to make sure this topic will be done during the
> GSoC period by the selected candidate, and we will also need to evalute the
> progress no matter who is doing it.
>
> I'm not sure if it's fair if any of the applicants start sending patches.
> I also don't hope to see multiple versions of impl floating around. IMHO
> it's slightly against how collaboration works upstream when we know there
> can be work collisions and we should avoid it from happening.

I understand. I was eager to demonstrate my enthusiasm for the
project, which led me to send these patches prematurely. I'll hold
off on any patches related to fast snapshot load, including
preparatory refactoring, until the GSoC period begins. I'll focus
on unrelated contributions in the meantime.

> Feel free to send whatever patches that do not have direct involvement with
> this specific topic.

Thank you, will do.

> When postcopy code is changed, I think it needs to be tested.
>
> Could you explain what do you mean by "userfaultfd, which was not available
> in my test environment"? Are you using Linux?

I apologize for the lack of rigor. I am on Linux. The postcopy tests
were skipped because I ran them as an unprivileged user
(vm.unprivileged_userfaultfd defaults to 0). I should have rerun
them with sudo. I've since confirmed the postcopy tests pass that way.

Thanks,
Takeru

