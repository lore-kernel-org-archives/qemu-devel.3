Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11895C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LlC-0007hP-7l; Thu, 17 Apr 2025 05:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u5Ll3-0007bt-MO
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:42:11 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u5Ll1-0007vw-JF
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:42:09 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-306b602d2ffso504485a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1744882925; x=1745487725;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EO+uz78KiEZJw3cP4hGgEWcaRnu0zoe6WVhmPeoxza8=;
 b=AcWMKno8FpU90aKDq4ZeCx0FHi9R4tg1RGnZeDGVvg5XPQv2aJtZLSde0S/e/GT+v0
 swtDBdhjVrRMj51IKZ9+/nK64vyesRd9DqG7ZduK9XC1/4vMMJXL2HuV3bVZ0Kd6Haix
 dTnGRw4WO41okkLmNSxDgBrX02fVPrt8exUwhBZxpzIXHWaCxDl4oNn8i2tgNRZDVE53
 njhz27F2BAMYrKnoY9nhG01lxinaGRuBP4/YOl+1UnnSLAn/ZPsu4nAkKSjYfnRqnLRo
 PiMGGueObrZICyWRKmg178FW/Gmf+C4vDQnNsw3+WCuYEikfgFmj84z6dp+povJcDr9c
 UqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882925; x=1745487725;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EO+uz78KiEZJw3cP4hGgEWcaRnu0zoe6WVhmPeoxza8=;
 b=L7gb5yPMG3DliIlCE4RJnC9i2YnsZ/0MWJtw+HMMLw1y/k16PtPJd9K2Q5aCatSlq/
 Qqhv8rg26zzOAZZMyfk7l986bQgvxSe0IMp0K3Y7LSd5BVeh/ZAjuxjR58XmwReJRyy8
 u2K0mDmZ+p0TK54Ld7Mfqs2+ki4eX3or3AJfn/VXE9XQxkaI4a31d/A2Bn9sNLtGwTZw
 OvlrDW1ltf53zbcgeIBahjJYyIpn1EflgjfT2n3JsHwTaE2zOPuh5axLRowz4iH2XHf6
 wPtx/Ipey0QK8AEpaoR6I2CI9bDG9lt6lQhIgjLP97uqcTm/hBJsilox5OTC0dqHWF0Z
 RWqg==
X-Gm-Message-State: AOJu0Ywm+sOE4VTeDpVX2y7sG6YcXq1728UANxpcyB4aZcGlAlk27wF2
 YXX/sHzu4G4wYeDyDby7jgMYORhM+2KXRhI561i5HPV2rNDye8KnUswV/90YA0Wo7TkdPgoLjHh
 PNnI=
X-Gm-Gg: ASbGncsP6evyushkWWmYQMF3RbYR7hRnvOAe+paxGZzm4GYRJwo9SlXa/9xcApnioUl
 laav6tD79AvsD4dhEL3NGovvVUvkcxaugfIezOTor9PYQivjqMG4cBhIe7yKXpO+HtBs4rU+hCJ
 D0YSkK+Hs547OaBVTEUgjSPVKogXqJjQYBz0214j6J7tHB4ngNG7eMAxSB+HoNwxhYcHEgBWiSp
 st6KhQhMeXY1bZLvFORBUnmYxP6AOObOgiSYLcVTjJXDLT7kwk9MBSylHrcHBJYnKtKxE+gvU/c
 7jQMpqPuX93VEIj6I3+fiids3bLrT6UKWe+6QuvHw08NYpk=
X-Google-Smtp-Source: AGHT+IHbRh/7UtrSI7sgVfu7ErgSMFpiGKJfFGlJUsW13yyKlHL+ABKqloRnFx07NnwRAs5zlWCVKA==
X-Received: by 2002:a17:90b:5690:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-30863d1f031mr7352700a91.4.1744882924855; 
 Thu, 17 Apr 2025 02:42:04 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-308611d60f1sm3196093a91.8.2025.04.17.02.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:42:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] ui/vnc: Do not copy z_stream
Date: Thu, 17 Apr 2025 18:41:59 +0900
Message-Id: <20250417-zlib-v1-0-34fad73b843b@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjMAGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0Nz3aqczCTd5FRjA2OTNIukZONkJaDSgqLUtMwKsDHRsbW1AOEBllx
 WAAAA
X-Change-ID: 20250417-zlib-ce3034f8bc3c
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

vnc_worker_thread_loop() copies z_stream stored in its local VncState to
the persistent VncState, and the copied one is freed with deflateEnd()
later. However, deflateEnd() refuses to operate with a copied z_stream
and returns Z_STREAM_ERROR, leaking the allocated memory.

Avoid copying the zlib state to fix the memory leak.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      ui/vnc: Introduce the VncWorker type
      ui/vnc: Do not copy z_stream

 ui/vnc.h              |  14 ++-
 ui/vnc-enc-tight.c    | 341 ++++++++++++++++++++++++++------------------------
 ui/vnc-enc-zlib.c     |  34 ++---
 ui/vnc-enc-zrle.c     |  69 +++++-----
 ui/vnc-jobs.c         |   9 +-
 ui/vnc.c              |  56 ++++-----
 ui/vnc-enc-zrle.c.inc |   2 +-
 7 files changed, 258 insertions(+), 267 deletions(-)
---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250417-zlib-ce3034f8bc3c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


