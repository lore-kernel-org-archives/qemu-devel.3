Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66966CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSsgi-0005pV-J8; Fri, 29 May 2026 04:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wSsgf-0005o8-Sr
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:35:26 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wSsge-0007Gc-B8
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:35:25 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-137335bc3caso5118880c88.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780043722; cv=none;
 d=google.com; s=arc-20240605;
 b=FbZfbBySymfnUUALqDmDzjjIasYWcKDyjX+luHBJ5Xp8mVbkpRvpIrIsuqoVijznse
 96KOx35ft87T6R0lSZkYdfSL2V0NCmPJz5x4GxVLKdstj89neohR0Y0R4WBppaM+wiBt
 teoZrFQt/2oGi8uUqDPSXd6DHJrJ4dGUTCksgMlHAzGaHU3JyKM4uGrswcJF9dU6UYpb
 mReOWpAKjaxWuh9RkGefV246+KY4KAzviVpuhr9FR0P/IU46bj8miHkmgoKRO5elZrGJ
 5LQVFoNfx2WSUuIaR3A2KuATUDP8mDodOGZbX9M5hgmNyIARCkCQdBSVFHQ/2TWuQ9Ag
 zh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=dDnqVnnvFiKus73KBNJZNWyX/dXgRcdK4kwDYVSy+1c=;
 fh=Sh5V2wZoPmZcQTeMKGPa6OgJ9YbA/Nm7TTNJwX99Vxo=;
 b=GvGM6VSRHch4bOxx5RN/UibYgZCAug6kftDpGTadPg8LfT7bNNPJY+GeBwV2d1x8Jr
 0JCiDfLbBwg8LP7g+0Zso5t04C/IamSXVxLvFd0EChO/FIQ9jViZxCASox+uQOjMfBCh
 RQnYhLqcMwbhVzsPEqSMXtwTzCDVxJHCQYIIGPWMcd9uYKkfOLFzwhpbVoVEsKgx7aTC
 4D4um+luLGIJrABMh12ga6tV4D4o4URTrMbViBjed7s3RmQ4apzTF9Fc3hi22LIA1qpi
 L4Rwu9BdWOuX5Yf2owX52UmY5UXo5CzGJQk0AMSJb1t38Ila2ZVzjB78aWX7duExxVn0
 gCOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780043722; x=1780648522; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dDnqVnnvFiKus73KBNJZNWyX/dXgRcdK4kwDYVSy+1c=;
 b=La8xaGFed1aCtFo2VpQ/rSxOR7ImtS14jAebcJwnvAqOSE6weSZBoKbSzzQbKqix9e
 xDn1nsVC580SoJv0E9tgpxLlhv4lxZHvjxFGhqKyXFzTPgE1mj9huZnIV0EH8omUqWLC
 aqABxdLqhyRb4tPcCCAgXVhJgLWuc1yjWV3BVr/Zg+YT7S6ZSrYnBzRKjv4S2sevs298
 oA76jjctqIwhcRMh2F95DCTc5xCO43aYWdjwZPJXC7XdIIs90V+eqEXCxtqGNn4ul5Ym
 tt8jC8S4Uc01t6I5LhHis6XWr1ZanWa4DQc+iUUit44pZa8iHM0TiR1pn8MDZbqXWbcq
 EB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780043722; x=1780648522;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDnqVnnvFiKus73KBNJZNWyX/dXgRcdK4kwDYVSy+1c=;
 b=LtRdVvq/HoWSO6sJsVahrofsLyIe2AOa15PzmIG8YRdb8ajRF8VRM68Y5AqdamjyHt
 lJ1rlHkEtdLuyPVxoTcbxJrZeJozqXolOew9XooDrevZnA+HQc/SURJW7H8rnqnq54ZR
 8LGUJjj1yayPu6N8WXdUeuIaG6CEGdGdFwe6WXujxMTiPFp62iM239Jv0b5QhGSScXYr
 Mtj8hh2peMG6PVzGCmpf54dVe3J5ov5fjzlklMQr8fi4A6SAWQwA/NAQmRqzYlhTqxYW
 7b9A9z2lh9rcqxEeOQ3UZAGUZQ2lu3AB5S/4pGXW2r73fLidsttLI1oTwmcQAT/mmYPp
 ZA9w==
X-Gm-Message-State: AOJu0YxV4cA4qX+Xk4v7rMzOr1ue8FsIVo132TQXj6ZClsELhWodZayZ
 IGnvqdgiGr5v7V576ISpcRQBwTuK7ZFoO71nmNxCO5jATtaOcTczOTp4tI3jJj9EZzkEgJVzLxn
 DsJV1j02Wmz4kr+1Ep6zRsFjLZeLN0Bg=
X-Gm-Gg: Acq92OEdc9F0Y0Nmk4oxpwnNDY13bSuD6KF1VfYNb4nBUnEZtE06VW4gnERFcuqByK+
 2SMBosAYTuleU3R+x0BBt5b3IL2AiIoSBsi3KHf+nElgcV16l7Nh09MVThqpzhaRtdtW5juNbUo
 dLBh9FAzEMd6PzhKD0sa7f0uPykyNkjcRYRZR27FDMQwyxTxWJiJ4tZOrHPf8O/PEpAlvt6MBjL
 ix1E5JZ39pzCLAFgMMlHzFOjeqVTxM7wOiit15/tJHi5O8DZKMIl+QocETb9QVeVuLZTO11GhxY
 YqTngqvl3ig5ZeL8JQ==
X-Received: by 2002:a05:7022:4585:b0:136:b370:64c5 with SMTP id
 a92af1059eb24-137af1116ddmr763672c88.30.1780043722239; Fri, 29 May 2026
 01:35:22 -0700 (PDT)
MIME-Version: 1.0
From: Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Date: Fri, 29 May 2026 09:35:11 +0100
X-Gm-Features: AVHnY4J3a_NxxqLGJOs1OIRVg6pqcIVUV2nNuiFs0CUdO7z9A2HB0hZedUkjrd4
Message-ID: <CALk1091JwDs9SGCydB2Q-4BunCbo=VEa429bmRjmQw4SwZrULg@mail.gmail.com>
Subject: [QUESTION] - SCSI tape boot
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bfb1130652f0b9a0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=emmanuelugwu121@gmail.com; helo=mail-dl1-x122a.google.com
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

--000000000000bfb1130652f0b9a0
Content-Type: text/plain; charset="UTF-8"

Hi Helge,

I have implemented the INQUIRY and TEST_UNIT_READY in scsi-tape.c and am
working on READ, REWIND and other SCSI commands next.

I have 2 questions as I already tried booting the MPE/iX:

1. Is there a need to modify the current implementation of the parisc arch
to support booting a tape device, cause I am trying to boot the file in
QEMU but it seems hppa/seabios only supports disk and cd-rom boot I think.

2. What is the minimal set of SCSI commands MPE/iX needs before it can be
booted in QEMU?


Emmanuel

--000000000000bfb1130652f0b9a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div dir=3D"auto"><div>Hi Helge,=C2=A0</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">I have implemented the IN=
QUIRY and TEST_UNIT_READY in scsi-tape.c and am working on READ, REWIND and=
 other SCSI commands next.</div><div dir=3D"auto"><br></div><div><span></sp=
an><span>I have 2 questions as I already tried booting the MPE/iX:</span></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">1. Is there a need to mod=
ify the current implementation of the parisc arch to support booting a tape=
 device, cause I am trying to boot the file in QEMU but it seems hppa/seabi=
os only supports disk and cd-rom boot I think.=C2=A0</div><div dir=3D"auto"=
><br></div><div>2. What is the minimal=C2=A0set of SCSI commands MPE/iX nee=
ds before it can be booted in QEMU?</div></div>
<br><br><div data-smartmail=3D"gmail_signature">Emmanuel</div></div>
</div>

--000000000000bfb1130652f0b9a0--

