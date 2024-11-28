Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BEDD70DED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 20:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkv8-0001Fd-T9; Thu, 28 Nov 2024 15:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkv7-0001Cv-2f
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:15:25 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGkv5-0001ll-Cg
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 15:15:24 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ea8b039ddcso871240a91.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 12:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732824921; x=1733429721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J64KCprhNBy6RA3jYobVf//TxYpHgQixgdih1H4HzWw=;
 b=qtko9NSrABkfHUPzA33O4PhO3tb5G3P9LeP2umNpk/G8d752do4j3h0ouJW2IN7kb2
 3xbK1YfSm8tdU5HcuyiL2SgOX5VuPkeBUD+zjWRakbRDVQ08geMzrKO3WdlEzvGFOpzG
 PXN6NnrBcOYm+hePokcjO6A531FMwe/3Rp1qNdQ+m1z9p2NfWCl2uApTjpab+Zi8kupL
 JS+25UBpBpZSQ5QN0rCPah6RkpEx6TaTarbWio6xEcQV+fZNIO88g7JvaBrxCnCiRY2k
 Ik0U7pJku45kfozk/EuSU2EF2gvpNmRq/MC9Xgcx55Y1/YOKqBr5Z6+TLbnS9H44XKcq
 LFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732824921; x=1733429721;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J64KCprhNBy6RA3jYobVf//TxYpHgQixgdih1H4HzWw=;
 b=ebnf0+g2VAibRuS6G+8tN6i9RqZQETpqQd6syyE77XveEk2GrZKcKxEmW7ESlhdZem
 UsTOCCPFhw7bVJahol7O2eic00pK2dN8iNv+4pQq/WEIeZh1zMSBxIDP2Iq8qq7yTost
 cPkw84EaicGnW4REV2b62WrQ9biDH263F/luFAfmGBNdR4AL3xwlqTr5XwLTfRq2rm0l
 vmBYx/dVxxy2eBUlEeg7wLGnIIp1Hb+IpkUe3XppS2bWLEzeMyHpj2CGydw0T+olzzm8
 rdWtRl+eNdqYcD9Mh3A+C92cUNOpjZi5JgExYWrxS/NejWecUmbJPxrUDYuFGLMtUJhA
 wVPw==
X-Gm-Message-State: AOJu0Yxww+xDap+sRzsZZ6k8yscoS50eW4Kv41FX8cfeW03L7AXvX1Kd
 INveG6T70/0fk6axvbjMz58kyXtDBlrGEned8G03VfLYStqrOciMGu9z705L0cXMQb9FZhQjGWL
 zmFU=
X-Gm-Gg: ASbGncuIJ+6yTswF2sg2n4iHbhOQIaZce7Cs1rjZd9XVMsm38mBgBQ4eWBpfd3itodc
 zBY6vBc2mmgARmqCBT/9vX89SAEi5Cr8ZNaF3cjMLNbcJpzB5Pi8zbK5DEFW6Z/KWLJIR9fvxs5
 ubYDhl+JyD9UTeSNTcQTMwld4+2dAwAP5j4gvk013WTjnMOgvbf++ukUMukspzSh0vW461T2AQZ
 KTgZ2G2AweJS+83FJkLv7UZ7244ErWf10XXw8X7hIZcH9MlSOWzlzhb2PU/udJEuzvwPGCyNoFV
 9kzplbRk9S4PbA==
X-Google-Smtp-Source: AGHT+IF+JEiNCIQFYFMnbD7q9jK/gdfGek/lWOi1UidEkpPOz27MyiLvQtM//cWCHRlRyd1pvZDVdw==
X-Received: by 2002:a17:90b:3c87:b0:2ea:3aeb:ecca with SMTP id
 98e67ed59e1d1-2ee097c2965mr9600509a91.31.1732824921225; 
 Thu, 28 Nov 2024 12:15:21 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fb10049sm3912861a91.43.2024.11.28.12.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 12:15:20 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 0/3] Enable clang build on Windows
Date: Thu, 28 Nov 2024 12:15:07 -0800
Message-Id: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

For now, it was only possible to build plugins using GCC on Windows. However,
windows-aarch64 only supports Clang.
This biggest roadblock was to get rid of gcc_struct attribute, which is not
supported by Clang. After investigation, we proved it was safe to drop it.

Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
hosts.

v1 contained warning fixes and various bits that have been upstreamed already.
The only bits left in this series are the gcc_struct removal, and fixing the
plugins build with clang.

This series is for 10.0, as we decided to not include the gcc_struct removal is
9.2 release.

v1: https://patchew.org/QEMU/20241031040426.772604-1-pierrick.bouvier@linaro.org/

v2:
- drop attribute gcc_struct instead of using -mno-ms-bitfields option
- add a section about bitfields in documentation

v3:
- explain why gcc_struct attribute matters in packed structs in commit message
- reword the bitfields documentation with suggestions given

Pierrick Bouvier (3):
  win32: remove usage of attribute gcc_struct
  docs/devel/style: add a section about bitfield, and disallow them for
    packed structures
  plugins: enable linking with clang/lld

 docs/devel/style.rst                      | 20 +++++++++++++++++++
 meson.build                               |  6 +++---
 include/qemu/compiler.h                   |  7 +------
 scripts/cocci-macro-file.h                |  6 +-----
 subprojects/libvhost-user/libvhost-user.h |  6 +-----
 contrib/plugins/meson.build               |  2 +-
 plugins/meson.build                       | 24 +++++++++++++++++++----
 tests/tcg/plugins/meson.build             |  3 +--
 8 files changed, 48 insertions(+), 26 deletions(-)

-- 
2.39.5


