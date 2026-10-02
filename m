Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FB4CA5FE3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZMc-00029z-Oo; Fri, 02 Oct 2026 05:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZMX-00029R-5Y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xCZMU-0005NJ-G8
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sdA5VWeQalxE1pUEtjHxl6J/PiyyjM4wgMtWUK0qgNw=;
 b=HdpB3gjyPliATZ8sARAverlt66++SogM23Ryyoa/xsDbNt91trriUdrflz9mXxB5IhIbbH
 r7JpHJ1mt/c9psXZRN95Qc1B/ZERLvKvYp7ZhBnFeEnn/JbFxvz5T7uYVuRY8HyiacqaAa
 29JS/2iIRsDH5CTTQ0I5VLhGqMYldUE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-JwQw0YILOmmZeWfvC31JaQ-1; Fri, 02 Oct 2026 05:15:23 -0400
X-MC-Unique: JwQw0YILOmmZeWfvC31JaQ-1
X-Mimecast-MFC-AGG-ID: JwQw0YILOmmZeWfvC31JaQ_1790932522
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48885f0ffe7so4182326f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790932522; x=1791537322; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sdA5VWeQalxE1pUEtjHxl6J/PiyyjM4wgMtWUK0qgNw=;
 b=Vy4ff925owoj3aNiLOZBm5b+E45CeNOPXJdpDyzVrujnrfT2CsKR0TrTi++cofzc18
 fpCTjw68Kx//8dtRLeoeAaKM9Q9Nc7z0s3DB3dwCSXAgdQlisT8SKjiolppqORS8NY/O
 s05tDI0XYF/koE/Zi0kCT2Y/lYFKFIRQtEO6CpAQmDe1pkxy4VqX47i5PPO1nL1xAJf8
 bfVP+010OoIEw4BdjclolmrgY9j+DI+1zK/rswxIEqwQTr8PhH2qP42uYV2WXF0scXlH
 YJ/rq7rASbjNVUGwslZ7grM/Rh7JuAAkizDGme2G0Mvjwa7csjm13BJ377jyYe6BoPV7
 Q25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932522; x=1791537322;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sdA5VWeQalxE1pUEtjHxl6J/PiyyjM4wgMtWUK0qgNw=;
 b=FQ6uVXSqmvPof3Drq+FKnI3QVZX78UwF7Oh3ljqZlfREMh5lWNDThQhls4xLAXndf5
 Q5abcYgvX3trmA9lGH+5wgsoqoKouJea8je+nY6cAiG3vuh6bg5PXxROi+AyNOET+weR
 QhqD6ueynNOSKu570dxCWs+Nj9tYiWsIbwn/RtpS0Ma1lUrCHGEx82TAmMtbCDzWcNDJ
 jo89M36apwgj2jNRwEqkaUMyfSei7SXxJRyPFHro+9YwN3KKE/uPBH0JfAwq6W/AB2L7
 Hmv5SXb/MmjBsja3peWwgL9422+CPjSPlAVWoHqGJM2dRYBy17mP8nEE6auJVGvx8I9+
 T0yQ==
X-Gm-Message-State: AFq9FYJlufaTlkJUVwqvb6fWS7g7e0zBIg0Nl37OCOo6i36RltKXEKPa
 gJ9RvtnNrk19ZC7ZWNlm9DpLUmuGDG8s8LD6ErwL99/eQxvorwIHvvZ83FYMg9gn/ZdOEn+xBy1
 BHtC0p8tf+zL+fuW5u3VyfBb/7fgUK5PZYtp4iR6OmZkT5vGqWKBfI+kikuoQa0JpafeJMG0WRr
 WbfZremAhxdEF3DeLxMCZumylWlTynfTJsucqowmUS
X-Gm-Gg: AYBFou0tUl07Hkf3F6F5thwfgGpaT2DLswUYUupkpTA5Zc0Td3Sb5t7kLHC9ROcKQLp
 Dw86MJv/VXy210PjVr9rJp5Qc/DIF3aPvJHIydEb0oLEZv2nNmJ+asfqTnCeYC3sgYUB4awZLLv
 euv4OtoBabARvsxlNYIHzVN59qFYXR2dfPn+Y61I854t0JzY1FnBQngtAIVPdi7uzunwKNvcEgq
 p1jVHeZ+hR+D3bPTqvBbk9GIRPltYlNKvhiyLD7u+1Eg0j3K4uvJDd8Ld1ju82+CPJKZ+mwbpJJ
 JCD5I7gp1kIT2vvaud6VvtWp4990xLCSvg3YvLeWry+X5I6SZ3bxkwj80qf4EETtuqF4Mjmrz0A
 VP6xYqvZwRY1DH/z5q4MKR7aUFiEtg2lWtloONm4ot13ln5cvgOi5C98T6vqvhGZKUM9XLix24G
 iQBTL8
X-Received: by 2002:a5d:5e92:0:b0:486:f4ae:72a2 with SMTP id
 ffacd0b85a97d-48b126bdd48mr3950790f8f.1.1790932521836; 
 Fri, 02 Oct 2026 02:15:21 -0700 (PDT)
X-Received: by 2002:a5d:5e92:0:b0:486:f4ae:72a2 with SMTP id
 ffacd0b85a97d-48b126bdd48mr3950717f8f.1.1790932521239; 
 Fri, 02 Oct 2026 02:15:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253dc9sm4082086f8f.3.2026.10.02.02.15.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:15:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/32] target/i386 and misc changes for 2026-09-28
Date: Fri,  2 Oct 2026 11:15:15 +0200
Message-ID: <20261002091518.1139575-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 9c88811b81a935a172c5c873b2ada2d9b38a5f74:

  Merge tag 'pull-target-arm-20260929' of https://gitlab.com/pm215/qemu into staging (2026-09-30 06:25:37 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 7b596a6918055eee8e17a78c84127b934ae4531e:

  agents: Add a skill for finding your way around QEMU (2026-10-02 11:11:37 +0200)

v1->v2: move validate_vex() before all operand decoding (patches 6-8)

----------------------------------------------------------------
* target/i386/tcg: fix EFLAGS reads in TCG plugin callbacks
* target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL
* target/i386/tcg: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP
* target/i386/tcg: implement APX
* target/i386: Migrate error code only with an exception
* agents: Add a skill for finding your way around QEMU
* tdx: fix buffer overflow in tdx_parse_panic_message
* accel/kvm: fixes

----------------------------------------------------------------
Artemii Mashanov (1):
      target/i386: fix EFLAGS reads in TCG plugin callbacks

Jakub Lipový (1):
      target/i386/tcg: raise #GP(0) on null SS load with RPL != CPL

Maxim Levitsky (3):
      system: fix buffer overflow in tdx_parse_panic_message
      accel/kvm: protect kvm_resample_fd_list with a mutex
      accel/kvm: coalesced mmio: check lenght of the MMIO write entry

Paolo Bonzini (25):
      target/i386/tcg: compute C of CC_OP_ADOX without going through helper
      target/i386/tcg: extract validate_cr0_exceptions()
      target/i386/tcg: move validate_vex() before all operand decoding
      target/i386/tcg: clarify return value of decode_insn
      target/i386/tcg: ignore VEX.L for unary scalar instructions
      target/i386/tcg: JO/JNO can use flags directly if it is in CC_SRC
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
      target/i386/tcg: optimize CCMP
      target/i386: extract computation of no-autoenable features
      target/i386/tcg: mark APX as supported
      agents: Add a skill for finding your way around QEMU

Simon Scherer (1):
      target/i386: Don't clear C1 for FCOMI/FCOMIP/FUCOMI/FUCOMIP

Yanfei Xu (1):
      target/i386: Migrate error code only with an exception

 configs/targets/x86_64-bsd-user.mak      |   2 +-
 configs/targets/x86_64-linux-user.mak    |   2 +-
 target/i386/cpu.h                        |  10 +-
 target/i386/helper.h                     |   1 +
 target/i386/tcg/decode-new.h             |  38 +-
 target/i386/tcg/tcg-cpu.h                |  18 +-
 target/i386/tcg/cc_helper_template.h.inc |  11 +
 accel/kvm/kvm-all.c                      |  26 +-
 hw/i386/pc.c                             |   1 -
 system/runstate.c                        |  36 +-
 target/i386/cpu.c                        |  46 +-
 target/i386/gdbstub.c                    |   3 +
 target/i386/helper.c                     |  11 +
 target/i386/machine.c                    |   2 +-
 target/i386/tcg/cc_helper.c              |  14 +
 target/i386/tcg/excp_helper.c            |   5 +
 target/i386/tcg/fpu_helper.c             |  63 ++-
 target/i386/tcg/seg_helper.c             |   4 +-
 target/i386/tcg/tcg-cpu.c                |   7 +-
 target/i386/tcg/translate.c              | 120 ++++-
 target/i386/tcg/decode-new.c.inc         | 898 +++++++++++++++++++++++++------
 target/i386/tcg/emit.c.inc               | 303 ++++++++++-
 .agents/skills/qemu-codebase/SKILL.md    |  59 ++
 .claude/skills                           |   1 +
 .gemini/skills                           |   1 +
 25 files changed, 1418 insertions(+), 264 deletions(-)
 create mode 100644 .agents/skills/qemu-codebase/SKILL.md
 create mode 120000 .claude/skills
 create mode 120000 .gemini/skills
-- 
2.55.0


