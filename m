Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAB8C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2024 14:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8hRv-0001dJ-WF; Sun, 19 May 2024 10:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1s8hRt-0001cy-7u
 for qemu-devel@nongnu.org; Sun, 19 May 2024 10:23:41 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>) id 1s8hRr-0007jh-Vo
 for qemu-devel@nongnu.org; Sun, 19 May 2024 10:23:41 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7f6e510b2ecso666097241.2
 for <qemu-devel@nongnu.org>; Sun, 19 May 2024 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716128618; x=1716733418; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fY8cmBvtFyjLLj12uL2aGhEdyrf+K6lLVq/zLBfTdOk=;
 b=S2FO7ilj9XsLzgB3YPlhOkqJfkAJrq45uIXgkeqXqnJghJ1qAoYjx0DQRwRzeWpnXv
 YDTcJR/yjNrQIw3VBLDOnAfeCj1KrKpXh3Ug1Ez9xoK+9nxIL3YKhbTFR0Rk3bbT4icW
 eAlbNASb7DAH5RZHq2OoDOSq1D6E4YQCZ0ZpXxjjbXxgFn3UgyAFVR11LFRJzKWiz2Aa
 SFTNAbq5n52INUZ1iSctkagPSdcSWf49Kklxb0TCrIsS6i0k47Cw0jiEGEAhgKq/+ouN
 e3WMHzT6hHcVSHL7nAdDeD3eqViK57FELywE0sLXIxI2rf3oNHU6VGVZZgeLdJldyHOX
 8oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716128618; x=1716733418;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fY8cmBvtFyjLLj12uL2aGhEdyrf+K6lLVq/zLBfTdOk=;
 b=Wgfp8+KKGXuXLxcWvMynAVHD5Bi1PW7Qq6odIhw3iBvpEmcDWhBAzajmj2kWZyODp8
 5gJtRJeVw/4xakiZmApRGgTodMYHOACifumu10BHRQ6lP3nlF8PUcXPK4CWSDSmsO0nu
 b1uYm/E+xHIt/503ac7V9ZegzTlohfI6cTOlQfsjCqK+pIe9xdhAXvQGH8AP2uV0hWUe
 r8Et2SyNy68Mss4Rk6tJmAPJMUuDiFAfQy/9UIw6eB84R8WJMr8G4TS93DcBcF1Lz5Gn
 PD9C8aLkfnvXcreWfpb2gilUOtg2NREBgTWgoJuvPyf3LO5lsCwJUsa7i+HpERR/P9a3
 8XAQ==
X-Gm-Message-State: AOJu0YzLHpL6KTqIff3eX+OkvRnvPKwYOfNLtbVqQ9FvfKSNRTUjSdec
 xp/rGNH6dSIck4WIAkraWuRaooZrOebUuwK1nq0NjoljdREIZUkzupRwxccYL2Sa0I5xm5yDW9i
 rYpKpegn1fJL47ZsRj0L/JiglqDhUFO2SLK4=
X-Google-Smtp-Source: AGHT+IG0bMlxGAn2aP0bVwGtEF1zSd5f6+wOZkhnTnpjybZmLoLLbC7bCrBx0EYYZWq+uHhjLr/W3owvQkf00Ggs9FQ=
X-Received: by 2002:a05:6122:2507:b0:4d4:42c6:b08d with SMTP id
 71dfb90a1353d-4df8829d346mr22739896e0c.5.1716128618380; Sun, 19 May 2024
 07:23:38 -0700 (PDT)
MIME-Version: 1.0
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sun, 19 May 2024 17:23:01 +0300
Message-ID: <CAK4993hFKoQh14k1L4cMrHrDzBn23D59aM-PQJ3pu6uH4qfsGw@mail.gmail.com>
Subject: A question regarding TARGET_ALIGNED_ONLY flag
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b0078e0618cf546f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=mrolnik@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000b0078e0618cf546f
Content-Type: text/plain; charset="UTF-8"

Hi all,

Previously there was *TARGET_ALIGNED_ONLY* option that caused all memory
accessed to be aligned, now it seems to be removed.
Is there a way to achieve memory access alignment with QEMU v9.0.0 when I
am building a custom target?


-- 
Best Regards,
Michael Rolnik

--000000000000b0078e0618cf546f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>Previously there was=C2=A0<b>TA=
RGET_ALIGNED_ONLY</b> option that caused all memory accessed to be aligned,=
 now it seems to be removed.</div><div><div>Is there a way to achieve memor=
y access alignment=C2=A0with QEMU v9.0.0 when I am building a custom target=
?</div><div><br></div><div><br></div><span class=3D"gmail_signature_prefix"=
>-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D=
"gmail_signature">Best Regards,<br>Michael Rolnik</div></div></div>

--000000000000b0078e0618cf546f--

