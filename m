Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28211C369D1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 16:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u95DK-0000zh-5i; Sun, 27 Apr 2025 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u95DI-0000z2-8A
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 12:50:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1u95DB-0005pH-AY
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 12:50:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so38202125e9.1
 for <qemu-devel@nongnu.org>; Sun, 27 Apr 2025 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745772634; x=1746377434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lYHxWvOlghFSADlJY7dsqqkXQbCxF+CrIV5UmKFdgTk=;
 b=kF3XqYKIVhqtZpxC1LWQoK7//TsRaF1qhuOVty62tfa5zZGXZ/xvwMrlTKOn82lXBv
 xx7MiYiXdZuYGUo942uUww3zzEhxMvERWUUGOEmGODGCNy8wlq0jl51Wy/TwbD/MXuav
 7LWls1XBpQMVeISK/cuMY1LhkY2+OgtwXYLrT1kCIDQ3CUi6RzCS8Bfa/HbHMyt65NaU
 HD7QG2cVmCwe8yWlQnKHFuOyeXsQbv9JJsyd3EJ6x3ar4AMGJhddfmE63VDFTHJ3YjGz
 hKBOal8w2+FNOHGwznZ6aLTJiz9v+hdoZwj8n3R5ccPcnLEseHZpEHyJnIKYuwIYjGOD
 HdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745772634; x=1746377434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYHxWvOlghFSADlJY7dsqqkXQbCxF+CrIV5UmKFdgTk=;
 b=EtA0SeqDJTxV65qAKWMnrZ9GscG3wM0f/+tgJ8T02Wzbpjs8jvhv0M4rJIaeFZky1t
 WyYKBAVnav6uECZ1rTCk1+voVwkxgDjmhFXSIOtMkJCMpC6pHPw8Zi/5mCAebnvD0A4w
 2Cwkgzz3+b/bCbAttKlSHtTo24OhbynDa5MaqjWIxvnqWl3uJ+eSTcdjGB2ZyS/OOSRl
 p4nQEPQBb0tyxH4yi+eOe6rcX83Y9mczp/7i1sUJ16F5ycdnhrtQyaVcoLlmIqSxEtej
 V8RS4GYtRNkiKzyVwOk9iD0J6Tl8wufFo37T0MNvGG4TV7Q+e3l8MG5pIuvlh8u2iKg/
 wtJg==
X-Gm-Message-State: AOJu0Yz9KpE7wO4/ik4RGe8PRreMLH/owCDuKJZ7ADEJWAQlOyIg/5O/
 JELTvOvXNz7jRdFUFDh4yVqJwRzci381j6sxvAtSSINFeqBHccSF58hIkg==
X-Gm-Gg: ASbGncuc02sA/CiFOa9Kh8Ej2k/Dk2HUbhV8MA8nIomRrWn8TDEpHgiU0lBv2xdNVhs
 cNn3Gv8+wWeCGJBuy846msWJ3vCW6jUY4qotjsVw5gawU7dfSYJFNLYnpRbZQf2ga39i1gvRTkM
 KNUZbLRRTX83iuEw6EFapfhnI6Z4aeWbOErJ3oqYAaC0b60c9OJ2uTZMYeP7+/11eqqo2D574oZ
 HOAbK/yxLWT5M94WXmciyNKs9uDD/eAVIZVcukxUQYZo5SFy5jjsSZwtuVC2XJKvYnEcOYp0+kS
 vbOxcTYsd7nUnmiuq42q2a7uq0w3uhKWYTo2PsEHUFT9/EkuN0iIpFvOgvHU5saf8ubNy3Rhlpb
 Tcv9M2hjQUFfIgBOGSFF7TmY9hIg1
X-Google-Smtp-Source: AGHT+IHOKbclK3XSCYZIZjm0gxY6h3lKbp0qznWjlyfBYxrrRP7F0XZY5ab20FcfTZPCjlRbkmww2w==
X-Received: by 2002:a05:6000:430a:b0:39c:1257:cd41 with SMTP id
 ffacd0b85a97d-3a074fbc45emr6566409f8f.59.1745772633826; 
 Sun, 27 Apr 2025 09:50:33 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cd7fsm8783139f8f.1.2025.04.27.09.50.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Apr 2025 09:50:33 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Richard Jones" <rjones@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Eric Blake" <eblake@redhat.com>, Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v3 0/2] io: Increase unix stream socket buffer size
Date: Sun, 27 Apr 2025 19:50:27 +0300
Message-Id: <20250427165029.9072-1-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x32c.google.com
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

On both macOS and Linux, the default send buffer size too small causing poor
performance when reading and writing to qemu-nbd. A simple way to experience
this is to compare TCP and unix sockets, showing that TCP socket is much
faster. Programs like nbdcopy partly mitigate this by using multiple NBD
connections.

On macOS the default send buffer size is 8192 bytes. Increasing the send buffer
size to 2 MiB shows up to *12.6 times higher throughput* and lower cpu usage.

On Linux the default and maximum buffer size is 212992 bytes. Increasing the
send buffer size to 2 MiB shows up to *2.7 times higher throughput* and lower
cpu usage. On older machine we see very little improvement, up to 1.03 times
higher throughput.

We likely have the same issue on other platforms. It should be easy to enable
this change for more platform by defining UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE.

Changes since v2:
- Test with different receive buffer size (Daniel)
- Test with larger send buffer size (2m, 4m)
- Set only send buffer size - setting receive buffer size has no effect
- Increase send buffer size to 2m (based on new tests)
- Enable the change also for Linux
- Change only unix stream socket - datagram socket need different configuration
- Modify the code to make it easy to support unix datagram socket

v2 was here:
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg03167.html

Nir Soffer (2):
  io: Increase unix socket buffers size on macOS
  io: Increase unix socket buffers on Linux

 io/channel-socket.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.39.5 (Apple Git-154)


