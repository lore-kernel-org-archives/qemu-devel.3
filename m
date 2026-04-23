Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E8CF99369
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrJa-0000XK-8f; Thu, 23 Apr 2026 06:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJU-0000Vt-5P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJN-0005GC-D3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gNOlGNkc0oVqjCSjVaizDdB5R+huR5c36ZwGXbOoZ9Q=;
 b=MVe6Bq7UxJQATywgkpOEubb0wuRf+IR/JkU84nQlbpGJwBCHRIa+qmWir5aopvYzTiCHg4
 j4m9TBL0/7t3n2LFw8p9QfaIcuFjJowQsYj+fPYwp9A6ox8G/UT+gD7ZfswkdozF81d3ZB
 2wYDSWqomvzwGahW/zKy0F9cxYId6go=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-BViUVxmEMHOKCh5BUaaHOg-1; Thu, 23 Apr 2026 06:29:26 -0400
X-MC-Unique: BViUVxmEMHOKCh5BUaaHOg-1
X-Mimecast-MFC-AGG-ID: BViUVxmEMHOKCh5BUaaHOg_1776940166
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488bd1ee9e7so53845435e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940165; x=1777544965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gNOlGNkc0oVqjCSjVaizDdB5R+huR5c36ZwGXbOoZ9Q=;
 b=UAucEuuQCzlEvABIqS0MRuvC3gjf4vPRMVhY4zH511Z5Tk/CMPVRNd85T1aQRItPfk
 SzjlCwdLWwTJvN8X5zNZmkSQZAT4oH1wBL5sxQcLqWfikyxIbhBsa5x86uLLdrv7FIT6
 futRachkedtVSLUjrrQsmUz4apew92te0qY6VmgPIMkWaFJwpkg5QGkP2UnQuqkBUNoe
 lFdmBz6JEQmdPZwSv1U8LCSkDZfiIS6U6AKPpQzARH+NyfQEsx64sd3bmVVFezdGkVTC
 iuWyb1kBdpPHVh/zoWyQi3+JS3WLddfobXKljtQowBpi3PdF0u0uZVttDghEr9x0z5bq
 1CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940165; x=1777544965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gNOlGNkc0oVqjCSjVaizDdB5R+huR5c36ZwGXbOoZ9Q=;
 b=S62GgS8Xgqe9Q0nDR4AkaYgH2E6TkJQqiIPXvxukfYo+yZaB9rRefmdSYCiryCpZHc
 JBKZ0USXpDy8cT0LP/tkucesXXiQaUc3IdFyr+j8LPxQY/OOAhhJmon2JXLV8pwbIcGT
 I859sl1/2Uybt0KDHCsAnIio3u24E5jIFevCz9miSZ+O4eCSUIFbYwT0Fu5K/Zzd9VKX
 sqAhHtRjm7p55DmSvTji5lQsZZ49D3ClSsgsF2OwyVrMr4qQb/iBv5d9LDzHqXaSPdn1
 pY+bNjIzQkZqTyHOvmG3TPfDA/NH6ig4CtvyCU7olLqzO5RjyHyZWA5/FRiIRfoj596F
 C9Kg==
X-Gm-Message-State: AOJu0YwGU2fxkonHLYBqJe9UT1UEL+0/Jmpqypbuc/tsmJGGrxQbL/0j
 xb1PIVzPk9KRWZMUdGsSmTQDhXxeDltbAbJGRaUpXZ9VSdcwgLckujBlzy8can8rTvGwGEDDae0
 zLwIxbGkqAUedjiOA1Mc16Onqo3wJqQnXliUnEYRIDQZQd50bnHsmzjclXXuXTU4rFIQ9JJJCi5
 pDgs3+54rUWej25WkZBd7TBGTC+W/0e/1d/aqTcLsd
X-Gm-Gg: AeBDievYjOx63U8olWBd75TigsK2AiSzXdQH0Ol2dyz8ZPVY6RswnOssXvNM35T5G6B
 fZxc7gXtE2N3rBGVSZ+ysnwUB9nDaxAIYoCaMl2dzAhgl6hucg7vOQNNyvW3x8BxX7DK3zymHyO
 WAZk1essJp+vdnRPo69ugvpBub2OcdSt3A59DckSHVUb3xTXR8d8O1DJgGRGrrGzjGahl2YtXg3
 fTLPXb2DPQcsmoHIxstD3hoJioCJ4xs83cLLhQbfjxj1LAt3bUKv6tXGycTvhxyB0dC+7BVFJWt
 oGrw1eS0CY/kxxs0wzpe5nHk1D+X15QP5bLcYWM4wNBDfpQ+Z+aqp5G4tIV8zmWekhd0mC+QjX4
 KTeRyrn/gQ2xMOutdqaN2GG8abdeLvnQJWPAx8QWvw5t/l7X++2NxFQUTrawAjnzWs79HpTqR3x
 7sAo7CrZ+Ml/BFSqWr+yq/YOnfTcnbAH+LhIA=
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id
 5b1f17b1804b1-488fb7880camr379494965e9.23.1776940164718; 
 Thu, 23 Apr 2026 03:29:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id
 5b1f17b1804b1-488fb7880camr379494405e9.23.1776940164143; 
 Thu, 23 Apr 2026 03:29:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb77b001sm241973455e9.3.2026.04.23.03.29.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] Build, memory, i386 patches for 2026-04-23
Date: Thu, 23 Apr 2026 12:28:57 +0200
Message-ID: <20260423102922.443639-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit bb230769b4d01de714bed686161ad39a8f4f3fd1:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-04-22 14:30:04 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 9d46d35abd79b7efd135ff384a4a0d86abf423f1:

  target/i386: emulate: include name of unhandled instruction (2026-04-23 12:27:27 +0200)

----------------------------------------------------------------
* accel/mshv: ioeventfd fixes
* memory: avoid memmove in flatview_simplify()
* first batch of clang-cl support patches for qemu-ga
* target/i386: fix emulator issue
* target/i386: fix strList leak
* target/i386: emulate: include name of unhandled instruction
* target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
* thread-win32: replace CRITICAL_SECTION with SRWLOCK
* target/i386: fix missing PF_INSTR in SIGSEGV context
* util: actually use in pthread_condattr_setclock
* vapic: restore IRQ polling for non-kernel irqchip backends

----------------------------------------------------------------
Aastha Rawat (2):
      accel/mshv: fix ioeventfd deassignment to forward correct datamatch value
      accel/mshv: return correct errno value from ioeventfd failure

Bin Guo (1):
      memory: Optimize flatview_simplify() to eliminate redundant memmove calls

Kostiantyn Kostiuk (13):
      meson: Use stddef.h instead of unistd.h
      qom: Use g_ascii_strcasecmp instead of strcasecmp
      block: Use glib2 instead of strcasecmp/strncasecmp
      io: Use glib2 instead of strcasecmp/strncasecmp
      target/sparc: Use glib2 instead of strcasecmp/strncasecmp
      target/riscv: Use glib2 instead of strcasecmp/strncasecmp
      target/ppc: Use glib2 instead of strcasecmp/strncasecmp
      target/xtensa: Use glib2 instead of strcasecmp/strncasecmp
      hw/ppc: Use glib2 instead of strcasecmp/strncasecmp
      osdep: Remove unused strings.h
      util: Remove unused dirent.h
      util: Remove unused sys/param.h
      meson: Don't require nm for non-modular builds

Magnus Kulke (1):
      target/i386/mshv: Fix segment regression in MMIO emu

Marc-André Lureau (1):
      target/i386: fix strList leak in x86_cpu_get_unavailable_features

Mohamed Mediouni (1):
      target/i386: emulate: include name of unhandled instruction

Paolo Bonzini (3):
      storage-daemon: use same link arguments as other tools
      target/i386/tcg: fix decoding of MOVBE and CRC32 in 16-bit mode
      thread-win32: replace CRITICAL_SECTION with SRWLOCK

Simon Scherer (1):
      target/i386: fix missing PF_INSTR in SIGSEGV context

Stepan Popov (1):
      meson: add missing semicolon in pthread_condattr_setclock test

rickgcn (1):
      hw: i386: vapic: restore IRQ polling for non-kernel irqchip backends

 meson.build                        | 37 ++++++++++++++++++++-----------------
 include/qemu/osdep.h               |  1 -
 accel/mshv/mshv-all.c              | 23 +++++++++++++++++++----
 block/curl.c                       |  4 ++--
 hw/i386/vapic.c                    |  3 +--
 hw/ppc/spapr_caps.c                |  2 +-
 io/channel-websock.c               |  4 ++--
 qom/object.c                       |  4 ++--
 system/memory.c                    | 27 ++++++++++++++-------------
 target/i386/cpu.c                  |  1 +
 target/i386/emulate/x86_emu.c      |  4 ++--
 target/i386/mshv/mshv-cpu.c        | 37 +++++++++++++++++++++++++++++++------
 target/i386/tcg/user/excp_helper.c |  7 ++++---
 target/ppc/kvm.c                   |  2 +-
 target/riscv/monitor.c             |  4 ++--
 target/sparc/cpu.c                 |  8 ++++----
 target/xtensa/xtensa-isa.c         |  4 ++--
 util/path.c                        |  2 --
 util/qemu-thread-win32.c           | 16 ++++++----------
 target/i386/tcg/decode-new.c.inc   | 16 ++++++++++------
 storage-daemon/meson.build         | 16 ++++++++--------
 21 files changed, 132 insertions(+), 90 deletions(-)
-- 
2.53.0


