Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45F4CF3966
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 19:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srN9V-0003nq-PN; Thu, 19 Sep 2024 15:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1srN9T-0003fV-Uw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:49:19 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1srN9R-000799-Ce
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:49:18 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so704735f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726775355; x=1727380155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D+GzcDDwi4tLotXzbMVqqpDe6pv0+ia9tg7EjGmc0y8=;
 b=aD7I4B+lTmNqcegMZbTSxlHoWWCIDHp7AAPBuBG/JFRLCH/FoM83BRnuxzC0kfd3Og
 q2GOO2MPobC7cCaJyNcfqQQzANlMV03U/UuSlKGiuTEP5EW8kCJGBJKzoHA6+FLFHh01
 ttJS4mvCn0Xtj7rfwZvWZa53QlW390bw4QmI3TOHwM1lS1ZGjoCVWaYqOWIU8Jft/acZ
 YLw2M4i9DBNZVyT1OMSxo5Nl9ma+woDz2e1W3GSLR9tGrhWeFOsKZ9+5wk8SO1NQP1tC
 OpLgjECOv9/6pYZvZ3ygTzyUrTurOKymN+I8TFa3615xCk4pPtwNk4pGAaNuBI7ER2uv
 OH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726775355; x=1727380155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D+GzcDDwi4tLotXzbMVqqpDe6pv0+ia9tg7EjGmc0y8=;
 b=jKh1gW/WD0jcLRqRt9V3U/QkRFaSiJLPgTb4IoOFSsBBLObvfVTUztUbLyCZLC8LR6
 Nx1B749asPTBbGTt47NR0xc3pfwR5t5/R6f5yLjO2JzS8w8mK/Tfo7effuMxNKi4atpu
 op/82Pc8EOGJ8sr1NKvWr2qhHxxlo5z1bZQ61Sh60AsMOl4kLaaT4h1XTJOL/ZyXJpBD
 8hBh+taQ928lGGk1mmJjC3txaKUlmpsgvLXm/mmjnRK5xdD7CCG2A5935hgZInH6CTHU
 q98JQjwCOS74OMSr5VuuXiG0XIUu2s/E5gIMtRnLz7DmOSdscJU126WA16DTH9NTLX1w
 C1aA==
X-Gm-Message-State: AOJu0YyaCmXI8K3mVLVKdm1Iw3S8BPBSZ9oH9Xo8xablwvkLjVpNzKQH
 eWMqWVfxtu1HGDJgytc4/PR9qJi2VrsRppndtr8najqdRCCA+k6z3/uJ9cNL
X-Google-Smtp-Source: AGHT+IFdqn2ChjugkIyC/3fYzQv2c//tX41qpQG2s1/3EZ1yTjhAwXe8D7ej44a6dyoD9DlUJiPBtA==
X-Received: by 2002:a5d:6743:0:b0:374:b6f3:728d with SMTP id
 ffacd0b85a97d-37a42353ee7mr230417f8f.46.1726775354683; 
 Thu, 19 Sep 2024 12:49:14 -0700 (PDT)
Received: from top.fritz.box (p4fd6b76f.dip0.t-ipconnect.de. [79.214.183.111])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7804476sm16030356f8f.90.2024.09.19.12.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 12:49:14 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v5 0/1] linux-user: add openat2 support in linux-user
Date: Thu, 19 Sep 2024 21:46:44 +0200
Message-ID: <cover.1726774207.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=michael.vogt@gmail.com; helo=mail-wr1-x42a.google.com
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

Hi,

This is v5 of the openat2 support in linux-user. Thanks for the
excellent feedback from Laurent Vivier on v4.

This version is very close to v4 and only tweaks/simplifies based
on the code review comments from Laurent, see the below changes
for details.

Thanks again,
 Michael

v4 -> v5
- drop "*use_returned_fd" from maybe_do_fake_open() and use return value
  -2 to signal to the caller to continue
- keep "pathname" in parameter to do_guest_openat() for a cleaner diff
- fix two missing get_errno(fd)

v3 -> v4:
- fix typos in the commit message

v2 -> v3:
- fix coding style (braches)
- improve argument args/naming in do_openat2()
- merge do_openat2/do_guest_openat2
- do size checks first in do_openat2
- add "copy_struct_from_user" and use in "do_openat2()"
- drop using openat2.h and create "struct open_how_v0"
- log if open_how guest struct is bigger than our supported struct

v1 -> v2:
- do not include <sys/syscall.h>
- drop do_guest_openat2 from qemu.h and make static
- drop "safe" from do_guest_openat2
- ensure maybe_do_fake_open() is correct about when the result should
  be used or not
- Extract do_openat2() helper from do_syscall1()
- Call user_unlock* if a lock call fails
- Fix silly incorrect use of "target_open_how" when "open_how" is required
- Fix coding style comments
- Fix validation of arg4 in openat2
- Fix missing zero initialization of open_how
- Define target_open_how with abi_* types
- Warn about unimplemented size if "size" of openat2 is bigger than
  target_open_how

Michael Vogt (1):
  linux-user: add openat2 support in linux-user

 linux-user/syscall.c      | 107 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |   7 +++
 2 files changed, 112 insertions(+), 2 deletions(-)

-- 
2.45.2


