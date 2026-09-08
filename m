Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1523AC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 11:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3toN-0004Yy-HQ; Tue, 08 Sep 2026 07:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3toM-0004YR-EP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:16:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3toK-0004QN-Qu
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 07:16:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so42639785ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 04:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788866179; cv=none;
 d=google.com; s=arc-20260327;
 b=V6AQfah7MPR3vx3gB7w9zFhFINA/oeth/idQUdRx2r3b32HIrT1mCgQGIBqUE8KTus
 ge0n9gDSS2E3abS3CIJZINL/DgtpBl4v3gZvhXKm3+GmXQPHryTgz66ZKMkJ/EHncJPb
 nk6ZhCLDdzZpzYN0XPdaBUseEcVFOJiyTm24VUghqPigB7F+GLCCvqNOoOieTXGzyBdv
 yx4W4yhn/2KKay8Cpl8lRMP01+pmEs9ReyzKxjTSqL9GFtEP9DiVlJu0yPfX9EHk6OIB
 qFD5c/NUakqBvz2LIagDZkf0YT/lIhzCeUF+v5he7PpFD8waBByL2LTUNctzN+D3Kuri
 cHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=AHKWOom9LCm5JSNdMIITZWp7fg2inKAxH6FV7we5ktM=;
 fh=FMJSBAgK6PUS3xXNIP3/UV1iZlrUpsFJElH+g59Bt4g=;
 b=R5C38RMIWNCKk8M3OiRgOVnTiZACiPBo7OPl8FJgiE0EtF4Zocbxm1WHS0p5e10OA6
 p6cHlSERwtfs3qcAw9FaXF+l5XYGGPBudlsVv4i6kPIUtxTsvHEvW8S5MNGxT3ZIg/y+
 rfTqP8KVQworMUCYhADjOgJFcvVpHZo7jtghOJIxaREtZRoTqRjYtG+ih54GIwcnQ+Br
 sxbSttrxNX8A68f+qHhgD/IRtNm0/dp71Ngb5/GleQmTVKI0d2UtpjnVAvbHhfpNWRy5
 VAdbBecbsEzVCpftEpF2uaiOGXtsHVLSOdDO0YH5kBQEtswu6knvYflZQi2UzZF+Jktf
 mWVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788866179; x=1789470979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AHKWOom9LCm5JSNdMIITZWp7fg2inKAxH6FV7we5ktM=;
 b=MfqlCq4/P784qY0Iqjb9408QgbLLe7R463/BjEJjxSxqqgGpqFPj/hC3rUgTwjd4Nv
 nZDt7p+l6Gk90hFy/+RjxLmHEMgARwMd0CjUsBx/BoguOlVnXOZn0oAFoW8vcU1ozS/+
 /HHDpOyRo0DSY0iJhNor9RUc2FuBSh9pltzIBE4GD0dvh9EFRaiM5MTHkln/GrcWiOxn
 hhnnC4KAZTSHmYr6kyO5eGiwWXIIlkJGr6gpotkOa7SMARJH88MCAvy4RC45af6MeSLM
 ln7ZnfvTJ9+FVPnM1b/Wl077YuiNyvf1POmVzuglMH2sXhCwVafAEb9MdVF6lj5IfTzm
 JP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788866179; x=1789470979;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AHKWOom9LCm5JSNdMIITZWp7fg2inKAxH6FV7we5ktM=;
 b=TQpqCWd9i0BeuMqPvF2mfD9vHu/o5xJJOlGgwCGk/1rOWhhclqMp4SGxksl8N3vE+J
 vM9uMprmNB9+jv3mMt0QoCGtBgnBw2WAzDaXTLB4h/o8kNAmUAAUQqFYC791RqVU+5c+
 pmHuKQfZmlAFMis3XVvPDvBR1dBaqW43X2ckdzygSnk+KjGI7RNN37iS+iDZKj1tmoEd
 S+84JdLEvL7y6pnnx3H/xKixBzDxJ7jRwaxPvh74srmOVct89FIqDChKERW7rphQNrDo
 1c4yGRHMRTaPF773NsSsfcgmJEH9IbCSklB6Eh4LZlk89LD6+LcGnkQGKXtSfCR9VBp/
 Vadg==
X-Gm-Message-State: AFuF++nzJDiQ27QafFY14+OJBP+iuu/1SRsTCWODqLtKJkR/tAhaEnSZ
 Kany3F+vrm0ImFbF05f6fZm9yMrfzklkWhrKCxwQzEfAI+5f+GuhMrbR47y3Y6awxWf6BUSNGaT
 D47uirZHsUhgscUceFdOUDpP0GYGvZSbAhF6EILs=
X-Gm-Gg: AYBFou3P00plhrn2SxWh5XNYWFKEM0SWU9mQfnLnLpTsmwy1GNADg9Qay5bZDzah+Jm
 3y6rt1KCm3vT2PX3FNWTfJsw2JS1XHIAsSs9poLi+XAnsBiR3Dhd5/Xfqbw1IR+M6ktVLF5EYOn
 aCaUW1t/6r3MNBW5ZNkPxhTjGAQwv0Ub3lCT+tZaXVEXxIQyy79zLY4KD9rsNYpIKY/oJCLPTxm
 C/73nIa85+csBYSKgEMqmqAGv9A1cFCNRRX1DMM8cDet0hV2Z0d8XOhWMlZZdEp3qCoeMK9Oxw/
 st3/c1zaTsBk5Im6gX/huTIVaeEMemrGAlJapP+QaPfpqt3Z4UYquHv9f/V0nxpbtwrxPE3oID6
 2
X-Received: by 2002:a17:903:2288:b0:2d6:ee34:c043 with SMTP id
 d9443c01a7336-2dafb0af451mr321631045ad.11.1788866179118; Tue, 08 Sep 2026
 04:16:19 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 8 Sep 2026 15:16:07 +0400
X-Gm-Features: AcwNN1XI9MkkUffBb0-e3-odWO8hf3eevA79uWS4P2QWMCOBTuTNoPlUW5HLPuQ
Message-ID: <CAJ+F1CLTUd1HxdZQ=Ot2eMKcHTiP52f2V-=mehfOcFzN0UtXsg@mail.gmail.com>
Subject: Proposed QEMU 11.2 release schedule
To: QEMU <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x62b.google.com
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

Hi Stefan & all,

Would that be a suitable release schedule? It's a bit earlier than
last year (https://wiki.qemu.org/Planning/10.2 release date 12-23)

2026-08-12 Beginning of development phase
2026-11-09 Soft feature freeze. Only bug fixes after this point. All
feature changes must be already in a sub maintainer tree and all pull
requests from submaintainers must have been sent to the list by this
date.
2026-11-16 Hard feature freeze. Tag rc0
2026-11-23 Tag rc1
2026-11-30 Tag rc2
2026-12-07 Tag rc3
2026-12-14 Release, or tag rc4 if needed
2026-12-21 Release, if we needed an rc4

If agreed, I will update https://wiki.qemu.org/Planning/11.2

thanks

--=20
Marc-Andr=C3=A9 Lureau

