Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAE1C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubb8h-00021J-Np; Tue, 15 Jul 2025 04:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubb8G-0001vt-Fb
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:35:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubb8D-00017z-H4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:35:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so24872825e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752568519; x=1753173319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qMLBmZnHLQx19KNGnxNAqNbMef4GME8ngvewhQo1d+E=;
 b=pEEa2MFlfBBrKT/RsYtn5iXWEDsVYR4Cc8o3zq+f5B0N9ZRXAUhPIeduzuKGiXU324
 UwA6P+LzDezOZTJWAMB55z8IAoMLt3BlZeHmJ+IZAkUfGBGwuftIgmZGLpn+ajVKKj0k
 /f83yrgiCJouzpDwrTSRhEM4KDQDcgzcWMX+62hZecOAb/A0rHob2BcpjCjmfdO/yvg8
 Dm8p1YftXYmAaQQfSHh+bhShLdnz1a74gJxFrLdq0D7xI0X9g0QmKDmIdXfNTG9G7Q+q
 YJZBcuVev38hKc1fKz5RWcwKSSKbBsM3z3Q9j86DbxvBeL571jnPe1ySlR5GfhYUQHmm
 r84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752568519; x=1753173319;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMLBmZnHLQx19KNGnxNAqNbMef4GME8ngvewhQo1d+E=;
 b=fS/OpA0C1c+IsF9Hpn5okgA/W1/rtN4ig77DmKoSPqJ0NxuXyaD+KWrdk0kkIwAU1t
 fZTlef2S9Hm9ywIqvlsYXX5r1jSQ6uVqU2hb0c9XaBH2O5pnVfcvxU88cEYIWKBzYqS0
 QYB0brHWv7U1HTKHo3GHAy4cUSxSQI7xRD16Lcc+lOt3wqxkvm2PesJY3xk/0ebOpvuF
 0H3o9UGpK6erHx6yLxYfU1yEDJ9jS9IEnv8AsonHG4bcedsaMhonP1IlmjwacJzIT0dK
 rcZHQfwmlAqerXivdMUCCxzII9s3p7T46efslCiUeaELgbZaY6CrHCQPkoNkdRmemTpd
 zgXw==
X-Gm-Message-State: AOJu0YzhBT+3DklLJZ/ZtJc2pDkDxsmVDUl1nNFhPi87MznJivekJ/6w
 vmATyFTnvyNnHx8BPUeEV1svw5V5clVflC3GEtQHZoGhfZpuAZzm9Zdoa+jMiVqdF3kVpugCRYE
 I0iC2
X-Gm-Gg: ASbGncvrt/IZN6zVhM/4wYe4uAr6br4ASFJteSVMlKn7BLglEQCsp85uNxJmj+CXSVX
 7In9l0nM4ZjBpVb2RKb2Uh0WNGPDkJd2G96iTJlW5CdJSfC3U3T5LeYfSLLu5WnuMLh/Ha4Yy3U
 P8Avw67Byu63VS/uG5hwqV9lPhzdLLfz9h1SUspatoFKq5nRslpM0ss+Nj8bn+j1Ot296QW+krg
 yF/bdK+W1J+qGMNLZ++YDN4Y1PlU4SSNAy2UHbZv18Kixecr5l19KeAiBgpTI5gCEVdvo/bLgJR
 cjc6k2kFX6u6pc4Z/67n7tjzxF+R5afKQip4fY9p7KisLmpGBs0km5pRCaDdTVu43jbXvIzFflq
 qlq5B58tyRn+w2C74CgI6Z1eUKKmooeiMfSrtwzHDitLDD/hAh5FNim8Oxw1GqpLmlEXF1nUmqk
 7GHg==
X-Google-Smtp-Source: AGHT+IGWcSGuAlb8r8j6KoIh+WCJlUfclAwdo2kiWG9JijOfBa75VKJVOYDdgTMkSSpik+svFZK2vg==
X-Received: by 2002:a05:600c:4709:b0:456:191b:9e8d with SMTP id
 5b1f17b1804b1-456191b9f9emr65245315e9.11.1752568519313; 
 Tue, 15 Jul 2025 01:35:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032fcbsm195968565e9.6.2025.07.15.01.35.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 01:35:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/2] system/win32: Remove unused Error argument in
 qemu_socket_[un]select()
Date: Tue, 15 Jul 2025 10:35:15 +0200
Message-ID: <20250715083517.47556-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We should use Error** more, but in this case it is always NULL so
we never really care. Remove the argument...

Philippe Mathieu-Daudé (2):
  system/os-win32: Remove unused Error** argument in
    qemu_socket_unselect
  system/os-win32: Remove unused Error** argument in qemu_socket_select

 include/system/os-win32.h |  4 ++--
 io/channel-socket.c       |  4 ++--
 util/aio-win32.c          |  2 +-
 util/oslib-win32.c        | 17 +++++++----------
 4 files changed, 12 insertions(+), 15 deletions(-)

-- 
2.49.0


