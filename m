Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2AA105A583
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dqj-0003gX-KV; Thu, 12 Mar 2026 07:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqh-0003fL-7n
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqe-00006E-0v
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zEdrSTFe6SJKpMNegkPLR80jjGdsTb0Ah5RVfG8o2F8=;
 b=HRhi+SfdrPUAgUctoinuBJefRnZUUgSJiNUr9xE9tUqnpXPDhABWJGrA5x18XzqcAxTJyw
 2C3ZiSDOReKqKq+tA6N2XSHrtt4p4TPTqbz1kvfafgXGGAH31Z99T6toV/o0jiqYWcg8JX
 Z7Nx7ud6sU+PM4NB3O4Bnnb/GL1Itt4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-RHdzOh-iPimwx2Dyy4IIiA-1; Thu, 12 Mar 2026 07:04:55 -0400
X-MC-Unique: RHdzOh-iPimwx2Dyy4IIiA-1
X-Mimecast-MFC-AGG-ID: RHdzOh-iPimwx2Dyy4IIiA_1773313494
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so870211f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313494; x=1773918294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zEdrSTFe6SJKpMNegkPLR80jjGdsTb0Ah5RVfG8o2F8=;
 b=pU/8btDSO8exsO7k6lAiv0AuURLJngQz/dfvGa/L4U2ReW9WUWfW24xOqK56HT6EV8
 q2jzrgGubTKent+cIS/EQiZSOO2pJpIe0oxUNjVonb6qBd8Waea77tk7uKwJ0CIzqE9a
 Zz2iAmDJ7JQVCVAYe0C5oGczpUlSiuxoKAB9aIWZOjyxJEqyFaZpsSVYpph2TLV2f+UA
 AbwEoJJHyg+JblHatejKgacs/KmAz60HNTWjgOw8ATS4/BRJD+Zh8jV2l1loD8zEgVX5
 UTDxgihF9oHiUHYnI9EaCbxsp2BkpSNa3I0dn80XRCeg7AwDX2421MfKThW4Yhj6dcaS
 F4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313494; x=1773918294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEdrSTFe6SJKpMNegkPLR80jjGdsTb0Ah5RVfG8o2F8=;
 b=noWJls5YNv8VsMUiEm13Md62TvhYnZX0yxgunhyKHHjAzmQrRRxiMWg4blcein1PyM
 zWWZPWD2v4fvjEnM/vqjsqiBN5+H6W2FeF/MlaSwfK4gnbw/3AqFhoH0dTq4LkwEesAb
 zWvqgM/mi9TES8ui4CtUb+7KNWjO2ANZaMz3iaXXhjheYS7qThe1YXqBMhg9qUdMsA0y
 Zagmw3odfQiOivA2x+MUEeafQL/xzw390GwC9lGTR6FZKgwkgOlpuo/hM6/59460JVzC
 GiE9t4vuL5vwKFGl6Kg3FTHmy5yCjJ4omINFjZp1FrGsZrWliv3F7JQq7ihp6WGrYx/Z
 xOBw==
X-Gm-Message-State: AOJu0YzKtOS7FnOSlqRFCJY6QTPPRZsiJVUCPKoUJa7HHy/MJGug90Fx
 ec2FpwfQhvDpIOWKvSuJODcs6IMYQMCfHjZahV3yLoUM2msnToLHJEoOppWWSqOSSYZ6UI34m3Y
 NIgq9CJD+YiJwZeB8RiSeUnuBE78kbBvmgZlKjPV2bme/+Id5aWzDXID+EtRDqrlIN2y8yk35Vw
 4WtLK0aoUpwp5jJ51NHBSdwhB+czbrGZWthm9nlHnS
X-Gm-Gg: ATEYQzxAsIBEoZPGQCAE9/Hb07pm+qxqN1ReM38i/UP/M/etrN32XZj/rkey12XHZtW
 GfOwuayTgu1IPB0WRyl4TtaSNFdum3BT4Bz8sToohqDo4e+azLu5vtP7P1YO63iXfdl1I3N55mQ
 XQVfrZzTSKAr+1KDueSOzRSmDlIIDHC0/Z4ijbTtGaeDLK7MrSnptJhNF97AG9rxWZY6tex2Tm6
 8OMNj156ntfNzV2Q9Vkz3IQnqfPS4Jglz4G651hv273LDJ4BUMu0wwX7QzA3WSSFSD82EWnjr6D
 /oDtemr2C+MuyzZH1mvPiVRX0QJzBvqjZh3RQhFbIAPBU93I8Tqrv40Y/MqZ5BUkqXgJAGM/606
 J7LVcXeN7GdZZGfHPbbhsYlWk4pCOkjQPqbNBWbQjdC+T/xFv15/ss5trho8xWcHk69W8hbjpy6
 jSLJ5YPo2c9Ecs2rGjIUUxxHAk9d8=
X-Received: by 2002:a05:6000:604:b0:439:e334:426a with SMTP id
 ffacd0b85a97d-439f8435927mr11385674f8f.46.1773313493601; 
 Thu, 12 Mar 2026 04:04:53 -0700 (PDT)
X-Received: by 2002:a05:6000:604:b0:439:e334:426a with SMTP id
 ffacd0b85a97d-439f8435927mr11385588f8f.46.1773313492937; 
 Thu, 12 Mar 2026 04:04:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2273d9sm8244021f8f.34.2026.03.12.04.04.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:04:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/14] Misc patches for QEMU 11.0 hard freeze
Date: Thu, 12 Mar 2026 12:04:32 +0100
Message-ID: <20260312110451.685161-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:

  Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to c725a896c6b92f733e0eeb236167cbd9b33efda8:

  typedefs: move QIgvm out of typedefs.h (2026-03-12 12:02:55 +0100)

----------------------------------------------------------------
* accel/kvm: fix typo in variable name
* system: fix coverity issues related to confidential guest reset
* target/i386: add compat for migrating error code
* docs fixes
* hyperv/syndbg: check length returned by cpu_physical_memory_map()
* typedefs: move QIgvm out of typedefs.h
* rust: Update Cargo.lock
* i386/cpu: cleanups for ClearwaterForest, AMX and more

----------------------------------------------------------------
Alyssa Ross (1):
      accel/kvm: fix typo in variable name

Ani Sinha (1):
      coverity: fix coverity issues related to confidential guest reset

Fiona Ebner (1):
      target/i386: add compat for migrating error code

Mohamed Mediouni (3):
      docs: remove 64-bit only mentions for accelerators
      qemu-options.hx: document Hyper-V enlightenments accelerator option
      docs: mention that WHPX supports Arm too

Paolo Bonzini (2):
      hyperv/syndbg: check length returned by cpu_physical_memory_map()
      typedefs: move QIgvm out of typedefs.h

Philippe Mathieu-Daudé (1):
      rust: Update Cargo.lock

Zhao Liu (5):
      i386/cpu: Rename AMX mirror cpuid macros with _ALIAS suffix
      i386/cpu: Rename AMX mirror feature words with -alias suffix
      i386/cpu: Remove unnecessary cache_info fields from builtin CPU model
      i386/cpu: Adjust the note for CPU models with its-no
      i386/cpu: Enable CPUID 0x1f & cache model for ClearwaterForest

 docs/about/build-platforms.rst |   4 +-
 docs/system/introduction.rst   |   6 +--
 include/qemu/typedefs.h        |   1 -
 include/system/igvm.h          |   3 +-
 target/i386/cpu.h              |  17 ++++---
 accel/kvm/kvm-all.c            |   4 +-
 hw/hyperv/syndbg.c             |  23 ++++-----
 hw/i386/pc.c                   |   1 +
 system/runstate.c              |  10 ++--
 target/i386/cpu.c              | 113 +++++++++++++++++++++++++++++++++++++----
 target/i386/machine.c          |   2 +-
 target/i386/sev.c              |   4 --
 qemu-options.hx                |   5 ++
 rust/Cargo.lock                |   3 +-
 14 files changed, 144 insertions(+), 52 deletions(-)
-- 
2.53.0


