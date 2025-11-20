Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C25ECF649D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMA-00036I-Ak; Wed, 19 Nov 2025 19:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsM7-00035l-W0
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsM5-0007Oq-RR
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g1aUSPF4hSEWmlldFq2pkESHOdGm2OkvnZpN0bm5Xtk=;
 b=A/xlmdy4My/alX1q0ioAVxedBMB5CVUNK28MPIf3cNajYWx3uA16LyIZQ0peS+6PEMDySb
 HasStSxQbuYGnn1e7X6vIHx7OUkFjMhwtfWJPmFgIJ0N/VWF5KnnmVsw+Lim6XckZ17sP/
 WbBKt7XhqX6xtays0s+uh9dOjNyyrtU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551--egro0zSPjWsgbKjsjknNw-1; Wed, 19 Nov 2025 19:16:53 -0500
X-MC-Unique: -egro0zSPjWsgbKjsjknNw-1
X-Mimecast-MFC-AGG-ID: -egro0zSPjWsgbKjsjknNw_1763597812
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b366a76ffso100701f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597812; x=1764202612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=g1aUSPF4hSEWmlldFq2pkESHOdGm2OkvnZpN0bm5Xtk=;
 b=DmEr1+kktBUh9ruCQu5DCj+XcWek/+X2tCzA5cpMbrDKLQ9SeqWbBwzIubz02gjG0G
 /1UVf2UpnA6Lqi4ABAvvyyrrd3vm6mRH9foArhGrnazxGjv9809ySjI5963ALnYC1jYe
 o37v6aQf81XNhOfcT6QO5Uhk8UB0+6pifqN9S2gbqo+cd5FGp8dp2P0TIJzItIL4Z4lo
 zNdzGYJYAXiqN8K8j+3p0bSoCZrwFDmuS0VnyiexLS1RnlCsi1OVSI8XnQbYKzGPpl0Z
 yKUhM0gpH6KjIMEKupLVqOlBsaLrofM3IhYPgKGeDIG4DPPCbrgSZxHqn0G1CWAMliad
 cyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597812; x=1764202612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g1aUSPF4hSEWmlldFq2pkESHOdGm2OkvnZpN0bm5Xtk=;
 b=IOJLNmGHLgc49P0mo1ZfL7zixsnJKUz7xLXv/Askd5j6/Lo0KJicHwgyHyMBbq+plc
 KnfQW+C00qoJOzDtjItwWDCEgcnq5CPphf9ZyVVGkGQM7oAHDUt7b4YY0WIgcdPwBEG+
 F7vBcWeb17VRLVdgNkgUsqHnbJhGXd/YSKQhcAKz3JmXqgirFTq6pf8RYkluih7Oo+x1
 U8+g3AGzunQjLzLMrpGOFCSQtYIMd8nlvHwVob7VCAmNzG/GEEEQI1WVvbhPt6RlvUo8
 zjuy8sdsXfrc9F/EVIFAKYtv/kcnBQy6lLUWQwwsMQKYZBloYYl6mYvfcmWQIVsrtytv
 o7hQ==
X-Gm-Message-State: AOJu0Yzc5vzIxWX538X236yFNIkzGsPTcGELOUEjrGHp4Nn43r/3FFj0
 G5eedMqr1/L+b9UOTW9NZmEmgWLg8DLvIir9eX086wyM679ffB4ex1b8ETPU6MMXnz8BesWfkQp
 1Typs8j9cDeC6y1m6MMprucxtZdkKKJDFO1avmTse6Ej1TX4ibjEBYeBU3sKfJF/T7cR1EWz6B2
 oj5r6hdWZL8Y7bikL2mBK1109+0ckjNNaU+BhTr6A8
X-Gm-Gg: ASbGncvzGg0wPymmS5EdniwO92u+z8P4HgPt1NOLGX7ywcFg3uIbJdCVXE33Bmr3H/a
 f6VUf94SwOPcPjBeHDeLvq5FZ49tZqjChPqO3mJR3X0okkgGoUROOZdk/YIBptEs7AJ9tZ9SnE6
 nIoIGKBR0SUbEcfLFBSy4QA9Ig0YIo4Wowcqz0q/Cm/Nc2m8Rf9tfVKqVeORS9Ob4smZVyYt434
 xurHAMfl3vGrEvbks6+920BT5SKZw8olE3wR/N/KJiJOPpYdd3aggO3ruhxX3nz+M62dS07js0R
 vmRg7lkALFktTK76kKFk+zfEvpoT//qHcm+GB+gqrbMNYb2HfEYGuEL71dPVg9MICBoae0PzLTA
 IZZgLagZnWtQUrenoUsFol1YbU8j/GlaNfZHr6LRhtDSQiu0NbQQfSckhigfynW+DaWdjm5Yzos
 Ar5PKvr2pM1wkASgk=
X-Received: by 2002:a05:6000:4312:b0:42b:3592:1b92 with SMTP id
 ffacd0b85a97d-42cb9a67bcamr581848f8f.47.1763597811755; 
 Wed, 19 Nov 2025 16:16:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfOypjBhHoWvuzhLXShzqCprc94aASQCMOtUd2/gsSPF5AW6CbeRb8Sn+at+hrSwWCm63V7Q==
X-Received: by 2002:a05:6000:4312:b0:42b:3592:1b92 with SMTP id
 ffacd0b85a97d-42cb9a67bcamr581829f8f.47.1763597811286; 
 Wed, 19 Nov 2025 16:16:51 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa7affsm1910827f8f.23.2025.11.19.16.16.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:16:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] x86, mtest2make changes for QEMU 10.2
Date: Thu, 20 Nov 2025 01:16:39 +0100
Message-ID: <20251120001649.1085913-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit e88510fcdc13380bd4895a17d6f8a0b3a3325b85:

  Merge tag 'pull-target-arm-20251114' of https://gitlab.com/pm215/qemu into staging (2025-11-14 17:59:05 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 58f88d0bf7c4c0676b54f97ba91eecccbca968c9:

  replay: add tracing events (2025-11-19 09:24:01 +0100)

----------------------------------------------------------------
* i386 fixes
* mtest2make cleanups to enable per-speed dependencies
* record/replay tracepoints

----------------------------------------------------------------
Nguyen Dinh Phi (1):
      target/i386: emulate: Make sure fetch_instruction exist before calling it

Paolo Bonzini (8):
      ioapic: fix typo in irqfd check
      target/i386/tcg: validate segment registers
      target/i386: svm: fix sign extension of exit code
      target/i386: fix stack size when delivering real mode interrupts
      mtest2make: cleanup mtest-suites variables
      mtest2make: add dependencies to the "speed-qualified" suite
      mtest2make: do not repeat the same speed over and over
      replay: add tracing events

Peter Maydell (1):
      target/i386: Mark VPERMILPS as not valid with prefix 0

 Makefile                            |  4 ++-
 meson.build                         |  1 +
 replay/trace.h                      |  1 +
 target/i386/tcg/helper-tcg.h        |  2 +-
 hw/intc/ioapic.c                    |  4 +--
 replay/replay-internal.c            | 70 ++++++++++++++++++++++++++++---------
 target/i386/emulate/x86_decode.c    |  6 +++-
 target/i386/tcg/seg_helper.c        |  4 +--
 target/i386/tcg/system/svm_helper.c |  6 ++--
 target/i386/tcg/decode-new.c.inc    |  9 +++--
 replay/trace-events                 | 12 +++++++
 scripts/mtest2make.py               | 46 ++++++++++++------------
 12 files changed, 112 insertions(+), 53 deletions(-)
 create mode 100644 replay/trace.h
 create mode 100644 replay/trace-events
-- 
2.51.1


