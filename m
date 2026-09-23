Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5A1C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qne-0006cq-8c; Wed, 23 Sep 2026 13:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnc-0006YL-AE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qna-0003g9-Bk
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x04effKXyQ4ebjjibl9H+Od7m3EbM7FteB+YGaxhnHc=;
 b=YbPny2k8utnp7A2N49fCDmptv8q3bA2Bo5vcSgzk3/hpfhIEz2UbMWNMr9Vgnrxr9Pv/eb
 LE5bcwGuOl0YSJXvF+U6Us1PZkVFwvfVqoDs+AHODK20xPvLEwceAcSzmjxWIi5o569ngb
 ejWSOC5l9SzVBpFyG+Itvi7gRJcBCkg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-a0QrzOrOPSqs13sT-rGy0g-1; Wed, 23 Sep 2026 13:30:24 -0400
X-MC-Unique: a0QrzOrOPSqs13sT-rGy0g-1
X-Mimecast-MFC-AGG-ID: a0QrzOrOPSqs13sT-rGy0g_1790184623
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cf9df1eadso10102215e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184623; x=1790789423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x04effKXyQ4ebjjibl9H+Od7m3EbM7FteB+YGaxhnHc=;
 b=YfchnaT6JAFUeC82AtxqvCX64P880Yap3DX4TM7fH7J6t3DEVF610r+BswdPS8cELC
 LKDMgYJWktwsxDhMlV5x61noFnqWhnSocD3sHm731c91vM4AuhZkB/vor96HnByXBESx
 eFDdQ/AJqPoh/H1g0nEEAmMilGDyGDeS7yc+uXlOFRmvBDr2kJ8BKRLTKWvkokYIN9ja
 bnORcufXoEMH0zpMZy9pnFH3brrmxgQKicrC31+pbiwWm+0IIVJj+m4ETzynl98YnJJG
 EM9DoP+3wKw//LNIgw6TgwCoLZmGt9zyxLxjTGlNYLnoNi3FSesXOYvvTw94CKZrXlsj
 ux+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184623; x=1790789423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x04effKXyQ4ebjjibl9H+Od7m3EbM7FteB+YGaxhnHc=;
 b=az4vWvtelZqDyn1FXUaYCM3DX2dkJ6X6fWlmwQiOzoL95d9H4v6LWX89R+fNidt+AS
 EmzxAfNGMRRx70ffyMKBXlf6G/qBUvFoPFG8lyzUO0QSIXjzkfVWU/oVFFfG4Q4ICPBZ
 x0//1Fr4q5JEx1cF2nT75t7CNSPopnvYEyqSc+bvgWiRGE96E+LWrqwLnZxV3VF/7E+2
 iiUNEVcvFuKsGcm3tnAPf2oIdilR5kW9kcIVx6b/MVSBykEYUNa3VzFJzywy3QbDQ5bH
 EKb2GvmAvhxuPwhCGnM+pqx7I1WcJPQBVymK5TVmg2u+d2oR9l/oU99tyE7Djo4CmgA2
 +n0Q==
X-Gm-Message-State: AFuF++k9HUnmHnSQL2/ThONmTaESSThLXbkiMvquUKCt8iL4zjqsdgNy
 syqbNH5cs9JkVVytVuk0jDzqtG/FJ0n+T4n3jv7yLDTSB9OkG4isSaRcxsYRNTutj6mVEN801aa
 gBPpYIseJREGY3Obm6+uX5slwRF02LkYoD71CBgIX27LJiZZ7ZN+ILamY2KNmkcyMU1hKoEDD2L
 tdq3qvEnNnZqMGHRmg/lD7xpXV6DgyUStjLDWdM55R
X-Gm-Gg: AYBFou0bzDKgIjIm5PI5DMrsif0RD4Oig55h7Ftzmjez/ag8/NqcKkJdR8Jtw160AOL
 ZAqHGmyVBApbnPcKRGQHKDG3k9qSOjg6iE6qiB9wMVASrzyiZvNHZzymJwpHEwDTUh0c6niCeuH
 LIZBaB1NZ9FQOBKghieIKpzJvVhPm2XQUvcnM9uQH2MsZjMAU9FO66HRfy6m23Jh3LOvh8Cf5YJ
 cQx+ySy7qz6hc+kmzlpHSxFJHvVTSx1xVCOx86S6etdGzrAx+jd2+nQj9IBrD+luEkP9+pAVAxh
 5kOVa5cg6m1BVscnAqX4S8QRXFARc+TXR+pCZ9tQ4EqT2Xft85uQfIb3DKQJH1BvqTUPfwJtBro
 j8x0Ck8MGhLQZrPV1yRZuHEUeCJiv8MH6uNousbKGtFxtyT6B7kYzmkq+J5p560HfE9sLLQjMDC
 iEctDz
X-Received: by 2002:a05:600c:1c16:b0:49e:7cfc:a9b7 with SMTP id
 5b1f17b1804b1-49fdf12b3ccmr59795855e9.18.1790184622918; 
 Wed, 23 Sep 2026 10:30:22 -0700 (PDT)
X-Received: by 2002:a05:600c:1c16:b0:49e:7cfc:a9b7 with SMTP id
 5b1f17b1804b1-49fdf12b3ccmr59795245e9.18.1790184622444; 
 Wed, 23 Sep 2026 10:30:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c4b51bsm58097205e9.4.2026.09.23.10.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH v2 00/17] target/i386/tcg: implement APX
Date: Wed, 23 Sep 2026 19:30:04 +0200
Message-ID: <20260923173021.317809-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series implements APX support; the main reason to do this is actually
to have some initial infrastructure for EVEX, without requiring all the
complexity of AVX512 but introducing the required changes in the
emulator.  It also forces some changes that (hopefully) make
QEMU's decoder align a bit more with what Intel processors actually do.

This series was tested with Zhao Liu's https://github.com/trueptolemy/apx-test.
The failures were analyzed by AI but the fixes had to be redone anyway.
Other than for a couple typos, the LLM tended to fix the symptom rather
than be general, which is exactly the opposite of what I wanted.  For
example, for the MUL/IMUL/DIV/IDIV assertion failure it wanted to modify
the decoding tables instead of weakening

  assert(e->s0 == e->s1);

to this:

  assert(e->op1 == X86_TYPE_None || e->s0 == e->s1);

Changing the decoding tables probably is a more common failure mode, indeed,
but not the right approach in the context of this series.  Other than that,
the AGENTS.md from the AI policy discussion worked fine and the LLM was very
keen on helping me not stray from the righteous path.

The issues detected by apx-test and fixed here are as follows:

- MUL/IMUL/DIV/IDIV caused an assertion failure

- INC/DEC did not allow 0x66 as a prefix

- CMOV/CFCMOV's implicit zero-upper behavior was missing

- IMUL's use of sextT0 conflicted with the zero-upper modifier (see also
  patches 1-3)

- MOVBE's register-to-register implementation was missing (see also
  patch 4)

- REX2 incorrectly allowed a 0x0F byte following the prefix (patch 8)

On top of this, the fix between APX and MPX was not correctly resolved,
which is now fixed, and PUSH2/POP2 use a single MO_128 access.

I also included a couple recommendations from Chang Seok Bae.  Thanks!

Paolo


Paolo Bonzini (17):
  target/i386/tcg: generalize zero- and sign-extension
  target/i386/tcg: use standard operand order for BSF and BSR
  target/i386/tcg: use zextT1 for CMPXCHG
  target/i386/tcg: unify MOVBE and BSWAP generators
  target/i386/tcg: add APX support to XSAVE/XRSTOR
  target/i386/tcg: add definition for REX2 prefix
  target/i386/tcg: mark XSAVE* as not allowing REX2
  target/i386/tcg: treat 0x0F as a prefix
  target/i386/tcg: decode REX2 prefix
  target/i386/tcg: implement JMPABS instruction
  target/i386/tcg: extend VEX.vvvv parsing for APX
  target/i386/tcg: decode EVEX prefix
  target/i386/tcg: add decode functionality for APX
  target/i386/tcg: implement CCMP/CTEST
  target/i386/tcg: decode APX instructions
  target/i386: extract computation of no-autoenable features
  target/i386/tcg: mark APX as supported

 configs/targets/x86_64-bsd-user.mak      |   2 +-
 configs/targets/x86_64-linux-user.mak    |   2 +-
 target/i386/cpu.h                        |   8 +
 target/i386/helper.h                     |   1 +
 target/i386/tcg/decode-new.h             |  32 +-
 target/i386/tcg/tcg-cpu.h                |  18 +-
 target/i386/tcg/cc_helper_template.h.inc |  11 +
 target/i386/cpu.c                        |  45 +-
 target/i386/helper.c                     |  11 +
 target/i386/tcg/cc_helper.c              |  14 +
 target/i386/tcg/excp_helper.c            |   5 +
 target/i386/tcg/fpu_helper.c             |  59 +-
 target/i386/tcg/tcg-cpu.c                |   5 +-
 target/i386/tcg/translate.c              | 112 ++-
 target/i386/tcg/decode-new.c.inc         | 823 +++++++++++++++++++----
 target/i386/tcg/emit.c.inc               | 255 ++++++-
 16 files changed, 1210 insertions(+), 193 deletions(-)

-- 
2.55.0


