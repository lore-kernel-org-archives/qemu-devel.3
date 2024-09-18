Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB9ACCD1A3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqtqY-0003i9-AM; Wed, 18 Sep 2024 08:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sqtqT-0003VG-TM
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:31:46 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sqtqR-00006a-11
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:31:45 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5356aa9a0afso8284908e87.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 05:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726662701; x=1727267501; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cynRD5XT/jkB4E8sJCxTzWk/7qkTL71fEZuUjaiVnuk=;
 b=OArrc8ojuVOkzHSPLejuDiEpeMWEUKW7wTWkXG0n4gvwmoQ2KVBw3NZtwu1ru8YAN0
 6d/jVo84fOFxOyE2qgTMqgi30sYHEEyrPU+km+C2FZu5kLeGg83BuqfopTThrmUuk2Lm
 LxB/TvgCinsRF2f5pjef41HYNK3fSqkqUBhxp+Yvj0EhIaejPNPI4GHpmndXe47t/KJj
 5aqJKU2R7Wg8O1UuB0iAE/almlJroUOZBqB90y/yYB7B9fGLcyEh2Bwq7+GNRLwbF9Qa
 knQl+VRkHh4iyAbrxSSk4MQkZmyspwyMOQBO5hsr3mM2UAkcYiW/5cSC/xmT0M7wdBH/
 CFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726662701; x=1727267501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cynRD5XT/jkB4E8sJCxTzWk/7qkTL71fEZuUjaiVnuk=;
 b=pRofpxYfgKNgUwbffybpWMI2sTCbSaUkFkdpuBkt6lBP7mW0FzTGrIWdHm3W5JoDCQ
 pIWpC62VScO/GopJXNFYhyadovaYLM6bjrUh/kNFMA2YNbGrAp9q72RfTcgRGDP+OwZn
 99fOpR4jq2qAZbjEWR/PkUKZU5LQX6DxfQq6hg401iVX0VYw3xrh1HrY0CIgSw1OA6iE
 l8g8YvzYmb12RuPVvoBRk6gdQqc1LIi/nxTPOQmgd9cgOACMtUXSBBi+QyqMw0Ac/7J4
 REpabPnu9vsbXYQIyABIBGyN3wXXjlVUybY3CxIl8WftiWn3uAkeZoez/Y9dExWG7bUE
 lRKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzzlK6tkAXqzTbCXvfqmLM4/C9n0/Xy4/s3TM8Z11K14qQ8ZxJ1ycG1N8YX5RrwUBVZezfBT1a/apH@nongnu.org
X-Gm-Message-State: AOJu0YxULRmHPkp86rUVkYWNDlc7rKn4RClzK/gI7oCd0uRF+S0q0x+/
 /xlXG1OiDUzrMivAFppx/lNEamzL6Nas+Djeefb79BhxVkxs8ELHyWPLYBJ1N/ujPYxtEnwFrrr
 ZfMA96PFB0IEcr5YpO+aUnKFyrCo=
X-Google-Smtp-Source: AGHT+IGh8CqW87UH36UHWr17CChHo3THAdxZZdms7RF3enO9rj4r5tRSWINVUVaEHKbg6Y7mrgjzeOyFzsehFS6On/g=
X-Received: by 2002:a05:6512:2803:b0:536:2356:5dce with SMTP id
 2adb3069b0e04-5367ff329e6mr13000423e87.58.1726662700545; Wed, 18 Sep 2024
 05:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240913163636.253949-1-r.peniaev@gmail.com>
 <20240913163636.253949-2-r.peniaev@gmail.com>
 <CAMxuvawD8QrsjJ9xiE9KDa=BTj8urRcCcN5YasiE3m-R7xEcuQ@mail.gmail.com>
 <CACZ9PQU2X0T+FX6QV+6O8MhBLuJkLut41rtjb5Lp5z+3Sjm6Ww@mail.gmail.com>
 <CAJ+F1CL1fg=hWYiprQ8BubpPSAgS1JMj6dY9Av-rKitw9ZhWzg@mail.gmail.com>
In-Reply-To: <CAJ+F1CL1fg=hWYiprQ8BubpPSAgS1JMj6dY9Av-rKitw9ZhWzg@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Wed, 18 Sep 2024 14:31:29 +0200
Message-ID: <CACZ9PQX4SOBe9cXgP45HBqo8uXKcnwPsKcZT-nVa_b9i7pQrog@mail.gmail.com>
Subject: Re: [PATCH 1/2] chardev: implement backend chardev multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x136.google.com
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

Hi,

Thanks for the review, I will try to come up with the next version of
this series.

On Wed, Sep 18, 2024 at 12:52=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
[cut]
>
>
> Indeed, this double commas stuff is weird, I don't know that "trick". Is =
it used elsewhere and documented? I don't see a test in test-qemu-opts.c ei=
ther.

In few places, for example here:
https://www.qemu.org/docs/master/system/qemu-manpage.html#options
(look for "double")

The second quote acts as an escape symbol to avoid splitting of the
command line.
Then in the modified mux I used a single comma as a separator for an array =
of
backends.

>
> There is another ongoing discussion about json support for -chardev: "-ch=
ardev with a JSON argument".

Thanks, found.

--
Roman

