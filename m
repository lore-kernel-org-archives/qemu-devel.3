Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CCAC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 07:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tszfZ-0002GV-WD; Fri, 14 Mar 2025 03:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tszfY-0002Ee-Df
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:41:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tszfW-0007eE-Gb
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 03:41:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso34290735ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741938079; x=1742542879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=embZoYYT/mh9Yc30UbN8cGMPGTV3SB6lixxg624QhBA=;
 b=LsPFiZcjymIPNYkaKMPF13wOeMAxzO96VSTkwqS9Wxjx1XszIWpvesMI3x9lcbA15Y
 +22LsO8AT6yunIvVye56wiGd6rdq52KHSnqn0TMh7MZ7oKM1TL0Cp7H0hzDsqlWCd5d7
 ba3xbF3HM2PJA1lImQxEI4HWlGl38FajB/Cjs4jsqsQ/sWZRZ0Z3DjPXyP5LQGjIAcLB
 3+/Aw7L1rzSGj2xilOMZeE8/SOepILBVZav88KVdKN3HANdU3Y7jxsFzEm6Qov3/1WGm
 w149JYDv2nvIBFFrMRPmVifjWu/Zl55Sha1k5yfIBqli9rchcN07yauRCLVKla4BnSEj
 9ELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741938079; x=1742542879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=embZoYYT/mh9Yc30UbN8cGMPGTV3SB6lixxg624QhBA=;
 b=mhVVlQmsOLO+uDQveN2MGpy2qB3bHgWrAldj7xcB5S6lMIevhGoWZQVXFCPzWfjoq7
 jkpR7UoVgoVZj/Dg/o31qxpqxrOGIbsf/smV3mN2r+GmcgvXHGQJbK+EEQoJNmB4yk62
 wz2kgZWtushAJJUsWg9Mi0aO6EqeS4zg1YPl0rlRGVkQIF3IUqRGLMFZsOARGsCykRLQ
 LOc1Qaeamn/vk4HE55JhgMniRthqnb/ioboriKIOKh4ad/xPs/prbpp0XN29XhHIV1+b
 Uh+vksKH5UgnrNvM7w3FqBxa13O+xq/VQKaYeD1ENuMRg3c3QdiVAqyhLQhRDYAzQU2L
 UHAQ==
X-Gm-Message-State: AOJu0YzNJHMZb3/zlGgozlAXBrK5aw5KyXqME/v7XyQ3hGT+R5lYXvfK
 /blTzCFz0Vyi59hnEsczjXHNUuH8iZXu0cbmMxFG/duGDBr0qcwmYPrTwzSX
X-Gm-Gg: ASbGnctf+6rGNXTwECM0t3m/vSi++EmmdhJ/yO5XJ6SxJeYgwkWIBnvSjPFg6+62Lpi
 MuTyFOFKp9pEB6Ej9681E+dmeZjnQ8DcpAuUdclWLwhF2b7oRR2Ea6+6bIdyuwLqCIXy8bC2VXf
 hdtPw1C0cu/uq5tO+M3vRCj2EEe3JqGamJ0smk6BjgjU0+Ske40QZcuAEEbV19tRZ/34TfYxIJ/
 D99noKxsUkT67Tz5vqzQPD71FqqFZeEnItJHWlZFJ2IVBiECnrV+kOGm4J1Gh8koYp82HzEn6HZ
 QJRuK4qx4cqxHF3+N+RZ2tAnYn+Atvo6accmIMZ6KeZ2ouE=
X-Google-Smtp-Source: AGHT+IHXixG1VKeVAD8A4NpcuGuRDzVN0sp09t7mfP5uKf7lS+fT+knMAF4tx/k6l2o+JN2fOcVJcA==
X-Received: by 2002:a17:902:d4c6:b0:224:249f:9734 with SMTP id
 d9443c01a7336-225e0a5220emr20805285ad.4.1741938078707; 
 Fri, 14 Mar 2025 00:41:18 -0700 (PDT)
Received: from wheely.local0.net ([1.146.112.81])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c688857esm24322315ad.17.2025.03.14.00.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 00:41:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 0/2] gdb invalid memory access handling improvements
Date: Fri, 14 Mar 2025 17:41:05 +1000
Message-ID: <20250314074107.992163-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

This adds .debug=1 attribute for GDB's phys mem access mode, adds
memory transaction error handling for it so it reports cannot access
memory instead of silent success, and silences warning logs for
invalid memory access coming from the debugger.

Thanks,
Nick

Nicholas Piggin (2):
  gdbstub: Add phys_memory_rw_debug for physical memory access
  memory: suppress INVALID_MEM logs caused by debug access

 docs/devel/loads-stores.rst | 11 +++++++++++
 include/exec/cpu-common.h   |  3 +++
 gdbstub/system.c            |  7 +------
 system/memory.c             | 37 ++++++++++++++++++++++---------------
 system/physmem.c            | 16 ++++++++++++++++
 5 files changed, 53 insertions(+), 21 deletions(-)

-- 
2.47.1


