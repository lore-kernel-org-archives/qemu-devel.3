Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1617AFD0079
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 22:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwp4X-0008D2-QV; Sun, 01 Mar 2026 17:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aerosound161@gmail.com>)
 id 1vwp4U-0008Cj-J9
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 17:15:30 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aerosound161@gmail.com>)
 id 1vwp4T-0000UJ-5q
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 17:15:30 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3599126be32so13954a91.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 14:15:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772403327; cv=none;
 d=google.com; s=arc-20240605;
 b=lOS3p6/H3AeuQTfBsxGuMgZ9xeXqHZPzddtjRq2a1RNKOb0Tkjb20srDf5woEPR4eI
 LUr33yLFV9MfdN1A+dWhB+ZufljfFn3xIYhhC4tBDfnVi51vszTrODkNiGtWhUe3yq5X
 jQrJxvjo/OYYEA3RQwZlK/SDDmSNeKuue0Q/ykHQy1ZoARh81QGvtje9XfwcHGAWd2ex
 98mjzGa5yyJso73FP1iVTyuRfFfhxOzGAgKGtHSAK4DXLmt8s2EaMPOmGvWNQ1P7JDk6
 Su9UQxW1JeCI4A+6MK7h7aa+oxLMqrKD+tn+vsUT0DYUhLneivmyFcfO4VA/FQtN2/xS
 iQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=to/Av4gBAmIgXPC+azIkRYIYgJZQA7InzNwOpdO6oYM=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=f3M2FQwqkWkdvXve+9CZW5I82C6GaLMbd4kmP9gw5W7AodP3+1GIUJxWR3urtOZQYW
 Df1yt/FXmtXTRk13yoyL0ZG3zbEF/fABFC/R31XW5vTBowIw2m+aVopngsIBtTAZugLF
 5TUwFMH1cgxbMQb4tsIjVPrVwfKr6Dzo32BQUuaNl8A7Yqu3hY8Z2Owfj7u94tGv3XYu
 9LxZF4gCRCFYBf/gHT5dgWtKordUUBwr1ZXemS9a22+boWUclK7o8BeVbDPwWE+UM0TL
 2zTv9+0DTSyQHtaW3FhrM8r6KceLBHNbrCZyyi6+ETJ7jiNHbn2EydAhoxsuEy7SVvm5
 b2Og==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772403327; x=1773008127; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=to/Av4gBAmIgXPC+azIkRYIYgJZQA7InzNwOpdO6oYM=;
 b=ic7AHsMZsKBxrPdJ9WY496toznGbEpNsQ6qT1X12BUy0aAipsBLlvGy3PqzFfnQMdA
 UmGMn2ObB3c7BK+rc5cEAPR8eS/o9el03uml9gC6pDU3UQlKeiswce4zKTTi2TytSZ44
 UUQu9d/PDUEN0V9xRYmCny3ufx3UQbqPdsWU7+Ae63quuQMf3LYJmuT59GnKzk2V+tHV
 ahOnk2jUCAWWaH+etEgvehf3y1ZvegDIWqYREHJzTiH02zLmyfRuCB8+XmMfOqzGji0r
 qeBYxFetFmRIElVUJfNwgWpKxezi08usJuV/rtqG3pUnYGFmqwslU/+gbxMfchjqb3HY
 yZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772403327; x=1773008127;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=to/Av4gBAmIgXPC+azIkRYIYgJZQA7InzNwOpdO6oYM=;
 b=ZabnNIovGU6G9de0zjKW244HdO9OLfyPng9g9IZrwqj/Hddo2ugUPbrPQ90iWLz5EB
 hP5oo/jaCXKAg7V2kp2QLW/PWp4PjuBhAFLcjKustsmCUaXERRNWPF9flIKqegPuJTJ+
 ig6dou805KweH3d5SLIX7XtDAxXPKPKDveZwVduMtWCcetmcrLgGPKbpZGsugBWO5SNa
 TZTUJ83dt/95IpzR3Z2tJqU6s+elWJmA4hv5nl8QL17HK6eY8hJ7R1xbW86QzrzjXd7A
 gHNeOTvxZatufCD1CMqiLgdDNzlqgvQug77YiWhDQRNlJ5dhBPXmUhIHP9I92na8GJrz
 5jdA==
X-Gm-Message-State: AOJu0YynY+f6H86gZGJOCzaey2RY5jaSLUIpWB305TPQgtdexIUZQvY4
 ULTR4e4TtlYrvaNxkQaNJNhGdM54Lg11Ba/ds4OxO+07dB6a7JrC5tCXZZ7a5lM8dufT1+WtdBv
 aMvZTATJ+q1sZc3PmxIl5BgvHjNzB5raPWxJYsWJ1FQ==
X-Gm-Gg: ATEYQzxx0XMOjcto3FUcFlh8SSxQzeCokg3msI/Qk+8RJ2qV9Op8HOLbiBjcw7NVjM9
 aHEmlkN7CHhrHSVtBXpekcZyFcgACe55yoMCGBmkdQ1IMaGP0kP50JhlRJBfgWgUrPymWerWTfE
 3CZiChLWCEWXo3+O6iomUzr66dnOw/caLRwkr+Hhe42K1EECpJ5WBzEhSerYQYcXuGxEOhpuMP6
 +n5abkYK/sCvov8uUP9/fscU5ZKC0DhhMjkTo8mvpHCQzZttwbL8jFnvBf/Q5nov/hsEpASCUCy
 1z4OxajHe8ntyXjiuXRbijUwY2CzWJyYF7XitVfi0Q==
X-Received: by 2002:a17:90b:4d8d:b0:359:3426:c60a with SMTP id
 98e67ed59e1d1-35965c3afa6mr9541884a91.4.1772403327077; Sun, 01 Mar 2026
 14:15:27 -0800 (PST)
MIME-Version: 1.0
From: Ammar Yasser <aerosound161@gmail.com>
Date: Mon, 2 Mar 2026 00:15:15 +0200
X-Gm-Features: AaiRm51lMc7DMz5c_yEUvQmkYK6Aw9CnOsS5rhjRpsFOwLCVlkhGsc2EFrrjga0
Message-ID: <CAHxyR9KTC0QzbSYQTAqpBxnyEWJG9+xMGENHps4vfJEPR16Dww@mail.gmail.com>
Subject: GSoC virtio-rtc project
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b59126064bfdceb7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=aerosound161@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000b59126064bfdceb7
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm Ammar, a software engineer working with Linux kernel and virtualization.
I'm interested in contributing to QEMU for GSoC 2026, particularly the
virtio-rtc vhost-user device project.

I've been reading the virtio-rtc device spec, the kernel driver code, and
QEMU's virtual clock implementations. And i'd like to ask:

- Are there recommended starter issues or small tasks?
- Who would be the best maintainer to coordinate with?

Thanks,
Ammar

--000000000000b59126064bfdceb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I&#39;m Ammar, a software engineer working with=
 Linux kernel and virtualization.<br>I&#39;m interested in contributing to =
QEMU for GSoC 2026, particularly the virtio-rtc vhost-user device project.<=
br><br>I&#39;ve been reading the virtio-rtc device spec, the kernel driver =
code, and QEMU&#39;s=C2=A0virtual clock implementations. And i&#39;d like t=
o ask:<br><br>- Are there recommended starter issues or small tasks?<br>- W=
ho would be the best maintainer to coordinate with?<br><br>Thanks,<br>Ammar=
</div>

--000000000000b59126064bfdceb7--

