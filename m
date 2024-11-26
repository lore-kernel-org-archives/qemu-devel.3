Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196CED6555A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG2wf-0001VF-Hm; Tue, 26 Nov 2024 16:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG2wd-0001Um-Uf
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:03 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG2wb-0001aU-Vx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:18:03 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7252b5d7b1dso143290b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 13:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732655880; x=1733260680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+MKlsc9XcOWYZdd66SFqnK/oWgGYy892pfPxX1s7X5Q=;
 b=BvMyNR86fYtpolW1ILqOgB4PmZAPEFPvfAFUldx/AO5eczJPsZmN6u/yY6SlCKGIdE
 eZDqTSlXGOkqkOQrwObypjyj6GJhEvBkNEqRyHdvOYRdb6e8PGN/BfrDALfDww0LhFGo
 oFAYd5fld9vOPrAL/tVA9kHkSVqi5ZbN8PLdw04VS2jt3ofxYYjohzViKDcJ0dM7JKnW
 iXQeExmbt1XESXNyQQYbn6c2ayKUwZAD9od3dYQcOO2HSIN2tNdEMB1XRlz4W8ZaAEx1
 M3pfe3MUzwiC1Uk2XOBiuasvFiho5iymvhG9/na+at4ytdoq3VJCDoY46owH4yj35hR7
 GoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732655880; x=1733260680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+MKlsc9XcOWYZdd66SFqnK/oWgGYy892pfPxX1s7X5Q=;
 b=hCv0g1ceeD290ZawAWfLOGX1nOZC2cb722qAxKQRPMqXmnOEwANJasdTYcz68GAR36
 Ncw9IkshevVoAIHllvTnL8JIuhfjB3BNFdiz4xUu6zsUuZkbEUW1s6ZnY17ewNwroM+q
 CQrpsmuqBBwMaAMfRGQ5I33STo8KwbiLx2tq+22i36cofHO7OqZlBRLCJU+Bq4+92g0Z
 nETsfHpQl3sxyso5QXyo2skppO4BHJoo1+YRJVDqP6lg2EZmkFlyL/93RCjmfvxsDxwg
 Vul2l6tdFIcxRU0jxcMcvPFlydyTQ/Ecglg/qKlel4t7GfRqGbHthlMoFvDCQIMlLeWl
 Uyeg==
X-Gm-Message-State: AOJu0YyHNWF6Q0/syT6YdbEXbIklTbwLOFf/6AmX0CaRI/+LxgS58xde
 71j6omQVzPU5OkAMj1orlq6ZItlTJg0hsRxBShSk0vFWazenyrOwQ90NL6dw5efbWzeS6laBw6k
 59i4=
X-Gm-Gg: ASbGnctoKP7KCCs1ykQsWQTW4Jdlm3pVNYe44di1TEvfIL+UzvA4uBlTOZQuyyApICa
 w2pCyPt4eSspFQ5ffITsW+4TTU/lOM13dUzzly28IKIDyCrOyXx4UgOvkIaQdylbzliFP2tFnT8
 YZXgDy0S9R6ZNxLzTuq0l5PFEZ0nJ1rtqxHYF1k4fUEbS6a7lbOMFMFXOoCUZn97Rq6ryfo78yg
 YIVQS+wZl0Qrn1mdyxAIXap7A/plIvvu9NJ2mrPBnJkwVz4LXrb/svvmdqP6nocYbei/K0q/2Ll
 GeUsP40MTzRrgQ==
X-Google-Smtp-Source: AGHT+IH4vtP1QlrNQXqjfcxSyRL3EPGrSsrefbUzDpjcf9tbpBB/CGh/99KelKUqJ/1E/6pPMnZ1kg==
X-Received: by 2002:aa7:8a13:0:b0:724:e3e4:a9c7 with SMTP id
 d2e1a72fcca58-7251ccbb9e9mr5909898b3a.2.1732655880155; 
 Tue, 26 Nov 2024 13:18:00 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724fd95ed01sm5811766b3a.8.2024.11.26.13.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 13:17:59 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 0/3] Enable clang build on Windows
Date: Tue, 26 Nov 2024 13:17:33 -0800
Message-Id: <20241126211736.122285-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Pierrick Bouvier (3):
  win32: remove usage of attribute gcc_struct
  docs/devel/style: add a section about bitfield, and disallow them for
    packed structures
  plugins: enable linking with clang/lld

 docs/devel/style.rst                      | 10 ++++++++++
 meson.build                               |  6 +++---
 include/qemu/compiler.h                   |  7 +------
 scripts/cocci-macro-file.h                |  6 +-----
 subprojects/libvhost-user/libvhost-user.h |  6 +-----
 contrib/plugins/meson.build               |  2 +-
 plugins/meson.build                       | 24 +++++++++++++++++++----
 tests/tcg/plugins/meson.build             |  3 +--
 8 files changed, 38 insertions(+), 26 deletions(-)

-- 
2.39.5


