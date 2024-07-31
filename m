Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E29C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBSR-0001tb-Lv; Wed, 31 Jul 2024 11:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBSP-0001pX-Sm
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:41:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZBSO-00056L-5J
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:41:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso35613425e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722440498; x=1723045298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tvyF3V3uQUbGd3B6Z3FkENPYix78t4C9rsaGkwNz5AI=;
 b=cYJWIwDX6EvO219xFm9GuHCZxOFf+RgLVLAlbOiR1VRC4rson3er+wYBvsrc/BMnxf
 UmwocYXJy4bI4hhxUsduFG4uQChAusNQcg4cJijcXl/9nhVOqzSvpS0MKvjbbKM/xsmz
 SgqT+8wFZzy+RsDmEjNEfuf+2rNNqhWWV01gDZ/cds7rj2ZVpB99oRWbvNZUmP5zanqZ
 xoAKYdzyzlpeTul/EqyLxDczntV7II8/JxvU7D7z+P8Md8ankb34euNRRJTawUXemYQS
 6iTk43CoQi65h9R3hjliRaC8gxrQqd3ObDN8zTIf4pY5cgypbb7dracCUBzy9CNVdmYc
 J0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722440498; x=1723045298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tvyF3V3uQUbGd3B6Z3FkENPYix78t4C9rsaGkwNz5AI=;
 b=P3wroOE8GCUTKQookrt0VWg1UUnWYLE3tfPGagcVvbrPn/jqAU+7kstHJBdse1Fpuw
 0S8fZMcPakuIkwiVvMMBo8meMSXhxiHJ6XGrEnd8Ge9Fv6wrG8eHdYPZ2wEfDxnfi7GZ
 I3jw6YR3ZYSub3IkONTQclkbjR8oTBYNoZDRS4pytjspAz25X/Cz8mWnbVkl5tgzLzx7
 EVP/Bi3OoQmOXRv0ihh/CqT9j1DwnMfmLX4755NI2aNIqMz3CTLz/BplzplGXSh1cEoK
 l+XZnfDZ9DLhiUkppTaiaTd3BMAlx8Cemzqvj+mY6lrQXtZvRx8yBpsnH0vO+M+zwink
 23ng==
X-Gm-Message-State: AOJu0YwwM+VP+Oha0kvDiHyzAynbAa5oJRp1gNmvjSGh9cHpEDiJ4XvY
 zxCuD0Ai7QB0L6yAfOjgnhaWZhtq82E1rfS2Bfh2iCaZlqC/+47zGemoZ0WRB/1QBH8/J1bn9E/
 F
X-Google-Smtp-Source: AGHT+IGObXYc8r5RTAJyJzi6p58ATcDdp8kzBJtXZMrQnGrFBfeWKeFzyf5CnuvkOqcyMB76t9kjBA==
X-Received: by 2002:a05:600c:3111:b0:426:5dca:50a with SMTP id
 5b1f17b1804b1-42815afeee1mr95925975e9.21.1722440497479; 
 Wed, 31 Jul 2024 08:41:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bba283fsm25201295e9.46.2024.07.31.08.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 08:41:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/3] virtio-gpu-gl: Improve OpenGL and related display error
 messages
Date: Wed, 31 Jul 2024 16:41:33 +0100
Message-Id: <20240731154136.3494621-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

If you try to use the virtio-gpu-gl device, the error messages
we produce are not very specific, which can leave users confused
about what they need to do (see the issue
https://gitlab.com/qemu-project/qemu/-/issues/2443 for an example).

This patchset tries to improve those errors:

(1) Trying to use virtio-gpu-gl without enabling GL on the
display backend:

$ qemu-system-aarch64 -M virt -device virtio-gpu-gl

Currently we say
  qemu-system-aarch64: -device virtio-gpu-gl: opengl is not available
With these patches we will say
  qemu-system-aarch64: -device virtio-gpu-gl: The display backend does not have OpenGL support enabled
  It can be enabled with '-display BACKEND,gl=on' where BACKEND is the name of the display backend to use.

(2) Trying to enable GL on a backend that doesn't support it:
$ qemu-system-aarch64 -M virt -device virtio-gpu-gl -display curses,gl=on

Currently we say
  qemu-system-aarch64: OpenGL is not supported by the display
With these patches we will say
  qemu-system-aarch64: OpenGL is not supported by display backend 'curses'

(3) Trying to enable GL when the QEMU binary wasn't built with it:

Currently we say
  qemu-system-aarch64: OpenGL support is disabled
With these patches we will say
  qemu-system-aarch64: OpenGL support was disabled when QEMU was compiled

(4) -display help doesn't mention that display types can have suboptions

Currently -display help just prints the list of backends. With these
patches we will also say
  Some display backends support suboptions, which can be set with
     -display backend,option=value,option=value...
  For a short list of the suboptions for each display, see the top-level -help output; more detail is in the documentation.
               
(The ideal for that last would be to be like -device and let you
say "-display gtk,help", but that doesn't work.)


Peter Maydell (3):
  hw/display/virtio-gpu: Improve "opengl is not available" error message
  system/vl.c: Expand OpenGL related errors
  ui/console: Note in '-display help' that some backends support
    suboptions

 hw/display/virtio-gpu-gl.c | 8 +++++++-
 system/vl.c                | 5 +++--
 ui/console.c               | 5 +++++
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.34.1


