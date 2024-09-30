Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54A6CE835D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 17:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svJsq-00074u-0K; Mon, 30 Sep 2024 13:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1svJsl-0006t0-Kh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 13:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1svJsh-0001Cl-D5
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 13:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727716091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XoRTZpdJx0N12M7VOOreMYE4Nl0UPkLH+sK6s3QQ2Sg=;
 b=GagzCSTp05/MXP8EWHFzIA58tckDgoslkSlsNE/ab2rCy41NkDvikjTjq4rwoBiiOSGCFz
 xOAY8WWPiqflKS/lfo/b1d/VutW9tXZqnFs2vuwZnSMxPdmKajuKR9fxwY/vFBXnafmJIZ
 AUuL/3TWjLvKqvIW5R/Qh5z1LHn23T4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-KXDTQ1_2NJ6AxuGs8tsdUg-1; Mon, 30 Sep 2024 13:08:09 -0400
X-MC-Unique: KXDTQ1_2NJ6AxuGs8tsdUg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cdd84aa87so1264021f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 10:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727716087; x=1728320887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XoRTZpdJx0N12M7VOOreMYE4Nl0UPkLH+sK6s3QQ2Sg=;
 b=QjcgwktXcEPpOBxNmJFEHMgPT8hg7MiWssRCSxL+h2F/BxBB/IxVXsfKSseQB4VAi3
 Tc5QZ28FaYD7v9D7pzr5lHttsR+sd6/hyla7AXiWCvi1bniT+JR+a0OogVlANXL9d3tn
 LSUN6/NgX7OQ+ATQ05y0ogv629EaiZn6B+sBj5o/s9JwR58beX0+RvZtbEPeNIIAyAJ+
 dZMlB9XPz2WzIetFv3gpoy5erGhsEntZ/Lk8IOzNug0TqRNdfXeJMl67nQwEb9LrGDAS
 AKtqEZ6fUn+ulaP8Ppkoyf6sF/RP9/GGv2CcW8A450y/uvBWKARdS/nJFzao7r1qpZdc
 /cag==
X-Gm-Message-State: AOJu0YzPi4e5ZVxESUUq660S4UEWFUGgsTJfLcZFTi5HVMxFk6zNvdmV
 QgJ08GYk0KlvuBICCzCiRGsiDQmpg6iIHcqA0DTrNs7H83vTWhNjUZNPiw7KUzQbW/ZccFwYFXD
 oKPLIpKkt4wF2//xHNSFbm5bcwPjO2mNuQCHl6GklYyz0AJwGwLiTvWGM2yV0NHCSzpOQgi983w
 qica2s0TGgpETXOZdtS2lHgwBrJ42gRA6Q
X-Received: by 2002:a05:6000:c9:b0:37c:cbd8:66cf with SMTP id
 ffacd0b85a97d-37cd5aed753mr7392967f8f.48.1727716087028; 
 Mon, 30 Sep 2024 10:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE39En/efBAL7fy5pRXCgAhDxGywgGr0oMrQsJSRq3mmqZBaAnK3tR7W0JFwAMjCuj/kJ1YOA==
X-Received: by 2002:a05:6000:c9:b0:37c:cbd8:66cf with SMTP id
 ffacd0b85a97d-37cd5aed753mr7392949f8f.48.1727716086589; 
 Mon, 30 Sep 2024 10:08:06 -0700 (PDT)
Received: from top.fritz.box (p4fdf9fd8.dip0.t-ipconnect.de. [79.223.159.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36251sm156842415e9.37.2024.09.30.10.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 10:08:06 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v8 0/2] linux-user: add openat2 support in linux-user
Date: Mon, 30 Sep 2024 19:07:17 +0200
Message-ID: <cover.1727715697.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvogt@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is v8 of the openat2 support in linux-user. Thanks for the
feedback from Laurent on v7, really appreciated.

This version addresses the feedback for v7. It's mostly details, see
the changelog below.


Looking forward to your feedback/ideas!

Thanks,
 Michael


v7 -> v8
- use "tswap64(how.flags)" in do_openat2()
- drop printing "size=" from strace.c

v6 -> v7
- use abi_ulong in guest_size
- use TARGET_ABI_FMT_lu to format guest size in qemu_log_mask()
- drop #ifdef for TARGET_NR_openat2
- fix LTP test by checking for RESOLVE_NO_{MAGIC,SYM}LINKS in
  maybe_do_fake_open()
- add support for openat2 in strace.c
- add copy_struct_from_user definition to qemu.h
- add open_how_v0 to syscall_defs.h

v5 -> v6
- do not use get_errno(fd) in do_guest_openat()
- do not put declarations in the middle of the code
- do not return early in do_openat2() when we get a faked file

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

Michael Vogt (2):
  linux-user: add openat2 support in linux-user
  linux-user: add strace support for openat2

 linux-user/qemu.h         |  9 ++++
 linux-user/strace.c       | 40 ++++++++++++++++
 linux-user/strace.list    |  3 ++
 linux-user/syscall.c      | 99 ++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h | 18 +++++++
 meson.build               |  1 +
 6 files changed, 168 insertions(+), 2 deletions(-)

-- 
2.45.2


