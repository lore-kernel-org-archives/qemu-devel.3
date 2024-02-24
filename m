Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1296C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdt9Q-0007Fr-8w; Sat, 24 Feb 2024 09:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rdt9N-0007El-Tx
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:37:13 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rdt9L-0000Qw-2t
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:37:13 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so269073a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708785306; x=1709390106;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PN+CWBhaN2gB9YFYU8FfAdp8Amirq1IuOnaz6hT1Bio=;
 b=awkuu9pYRmbHwjw3H5mzazk5Y7e0D0bS8oIbtOV8LXCf0roW+iJPSiDt153IpLXSFl
 PNQWsBWMg0Qyt9NqzxHrpfX0PCTbu8W2pJsAY1GGJ14TYEPFaZW43o6WBOF3dggowO6v
 0OtjVWOLFUcXARM+j9Qv/nMw+lAcMaA2CpnIg3kjhqTxaXKHS3pvcoETy1EFAxfTnb8M
 ivkXDFvYBh9RxQtCbwm153gc7vzt//VWfmVZdg5dE7oxsuQKupgkrADBZQartWidWKiU
 XFHWXHhcJg1In/HOLmT5kCqUaWdf/Ar8OSgdnjYbbBfbnoQWjfGz8bMvU710bYZaxdC4
 hB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708785306; x=1709390106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PN+CWBhaN2gB9YFYU8FfAdp8Amirq1IuOnaz6hT1Bio=;
 b=jgbDShnDyxDx+ER64PukqoMgrwhQTmi37bQgKtBGo5SPYGoNmYVXB4Da0fjtysbuto
 M6/9zQty299F1bT6ASNj053sus8gt9bu64Qt5nWJ/PMVUBWXjYnz228h4y4V3QOQykB4
 qLFnwZehM9MGefkjgXh1A9O1doqSJ4k5DgwXa1mIs3zwk1SRKsWhgK00NHF+B0cOgJ9D
 cHQlyybta7fjKRydc3GY2sC6K/obZIbM+bWKlcCiWpyVE/V8ad7rQkWT+GRrH1w/v4Z9
 St/JsjSK5FyW9NzOg//NLxqYmj5pEA+RT+2671uPF8J3eEtg9bIq0XxElYTtsYpl/2DE
 NDVQ==
X-Gm-Message-State: AOJu0YyJeNQOnt+WRZTAIIaPHvLs2p64Trlep1fJ9MBmqiIvVfgMKUmG
 QtyGFVSGS9TAzfO82bHMXUwTynk8mC4FN9E5MJthHrPFNcU1HQVBZXiw1+SMccoWucMyshaIu+v
 Vd78HLg==
X-Google-Smtp-Source: AGHT+IH4bwwWWDc8iqdAyt0SYMxXcRzr144MjBkS0ujn5Kzjoja+sJ7MeBIMlnKOuh9imruBm/pb+g==
X-Received: by 2002:a17:90b:c15:b0:29a:6903:e6d4 with SMTP id
 bp21-20020a17090b0c1500b0029a6903e6d4mr1944711pjb.39.1708785305722; 
 Sat, 24 Feb 2024 06:35:05 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a632356000000b005dc49afed53sm1181887pgm.55.2024.02.24.06.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 06:35:05 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 yong.huang@smartx.com
Subject: [PATCH RFC 0/3] Support GM/T 0018-2012 cryptographic standard
Date: Sat, 24 Feb 2024 22:34:55 +0800
Message-Id: <cover.1708527979.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patchset introduce GM/T 0018-2012 as a crypto backend driver,
which is applied for block encryption. Currently, we support SM4
cipher algorithm only.

GM/T 0018-2012 is a cryptographic standard issued by the State
Cryptography Administration of China. Visit https://hbba.sacinfo.org.cn
search GM/T 0018-2012 for brief introduction.

The objective of the standard is to develop a uniform application
interface standard for the service-based cryptography device under
the public key cryptographic infrastructure application framework,
and to call the cryptography device through this interface to
provide basic cryptographic services for the uppler layer. For
more information about contents of the standard, download the
specificaiton from:
"https://github.com/guanzhi/GM-Standards/blob/master/GMT密码行标/
GMT 00018-2012 密码设备应用接口规范.pdf"

There are two benefits to doing this, at least.
 * Performance - using a cryptography device for block encryption
                 offers an opportunity to enhance the input/output
                 performance once the hardware is certified
 * Secrecy - hardware manufacturers may fortify cryptography
             equipment with security features, so increasing the
             secrecy of block encryption.

The precise way that vendors implement the standard APIs for data
encryption using the cryptographic device is uncoupled from the
GM/T 0018-2012 specification. Thus, if developers enable this
functionality with the following conditions met, we could accomplish
the general implementation:

1. rename the header file provided by vendor to gmt-0018-2012.h
   and copy it to the /usr/include directory.
2. rename the dynamic library provided by vendor to
   gmt_0018_2012.so and copy it to the /usr/lib64 or any directory
   that linker could find before compiling QEMU.
3. enable crypto_gmt option when compiling QEMU and make the feature
   availiable.

By offering a development package for GM/T 0018-2012, the above
provisions could be standardized; unfortunately, the hardware
manufacturer has not completed this task. So developers who don't
work with the vendor to obtain the cryptography device and related
library may not be able to test this functionality because the
standard implementation depends on the cryptography device supplied
by the hardware vendor. We are hesitant to contribute to this series
as a result.

After all, we uploaded this series with the intention of receiving
feedback, as the title suggests. We would welcome any suggestions
and feedback regarding this feature. 

Hyman Huang (3):
  crypto: Introduce GM/T 0018-2012 cryptographic driver
  meson.build: Support GM/T 0018-2012 cryptographic standard
  crypto: Allow GM/T 0018-2012 to support SM4 cipher algorithm

 MAINTAINERS                   |   3 +-
 crypto/block-luks.c           |   4 +-
 crypto/cipher-gmt.c           | 263 ++++++++++++++++++++++++++++++++++
 crypto/cipher.c               |   6 +-
 crypto/cipherpriv.h           |   6 +
 crypto/meson.build            |   3 +
 meson.build                   |  30 ++++
 meson_options.txt             |   2 +
 scripts/meson-buildoptions.sh |   3 +
 9 files changed, 315 insertions(+), 5 deletions(-)
 create mode 100644 crypto/cipher-gmt.c

-- 
2.39.3


