Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668D2CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB0B-00056l-Uy; Mon, 28 Sep 2026 09:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB09-00056V-Jx
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB07-0004KE-N9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wui3GeLye7hnSwrLIkRRuQh8U6izdl0koLXO035hPWc=;
 b=M9+o+PZ5biWoza35vDrB3ejh0PvBfQoFlJqogpqxKRzbPigbwWMt/RwQE+4kxiai1rztQB
 M1RKjh4GiInbiFWHIzkMxPANGIqrJfjaGtGp7Hq8a77/sTeOxZYUpf9GHe0QmR591Antup
 yH/BrP2Mu04LhJdh8M5bcqV2PHim6fA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-kyb0mmCHO0aqshyNRLw3TQ-1; Mon, 28 Sep 2026 09:02:32 -0400
X-MC-Unique: kyb0mmCHO0aqshyNRLw3TQ-1
X-Mimecast-MFC-AGG-ID: kyb0mmCHO0aqshyNRLw3TQ_1790600551
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c294442d71dso345062866b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600551; x=1791205351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wui3GeLye7hnSwrLIkRRuQh8U6izdl0koLXO035hPWc=;
 b=XlLg6NvdUl8QZwtpt+ymxEQJfBbcd+NeqZe3RQ1eF9rCBV51T2XRBLfsDN4kKKULDk
 KK2KnrPeEnzR7yBPQjUDkvCjkClO8ibkfcICSzGr2JSa9AI488BBuRIki9rjI0G2wg+x
 Opkn/56PMdN2hDgashOejmDZOPIQgeV4n7TIxeogaxYkkXxHSQdw1iQTFKWyfx7p71Rp
 UHAKjAZP02z+L1asCCfjqIsSlvkd0B+spIsjfyjv9LdLTXX7qReRLpSWqRX274LTnDcG
 0jevOABSJioQbjXmX9iNDkulZ2XSkCjkZrYZcfJ6kmi5IcUsNNEH3DfQAyT3TdzLd9Cw
 LC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600551; x=1791205351;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wui3GeLye7hnSwrLIkRRuQh8U6izdl0koLXO035hPWc=;
 b=LpFXgPmW3t42azBwvIeF20ViAZTNHrd3B5MgDKMXyG1b14kT+eOnggEuU1p/X5F61p
 wxd1M6jnV4Dxm5a98dnwmD6RLNMNsRu6ZeeVfem3xbT/d1DfuMrqweo38hT8qMVFYehX
 hDZyGi7zLg2hEYedhMfj+nzkZRt/42Hlh+qtLelkFxkKwADwTi+b5yzvWtWb7bu2wgFM
 0qj3IANR1EXwtZKobgElf9UxVRgMThjhXO7g1ZtybJgA04wTpNYmZ8fyXNmWIPRmeOlk
 eBQMDh9MTncE7FKkIEIe3ozgmURSD9z59PPWCfkb8fRflIiWXlSubccK/xdCfNHOsvpv
 ksVg==
X-Gm-Message-State: AFuF++lrod8PWBZRhKkpDUbO4F56N0Zf+Ez0A4H8Rybrtl8YbZ7cyzlg
 fYkig5V6Mj5/6eD1YfhOB4OmRL47Nqc3mQEiBiF31CvsMRTElE2YSbAxlOjLjZGORg7uxT7khXd
 mgkIDD4wxJJ1tcWRv/cFMDfpoHY504elk2zY3tlKK50YYnT8HnSzRO/QeukQm5/Nh//9wL4KTFN
 /ABVhs7RyU/8vJmzUZFcnoG3uYWbEdhuVLEXcVsY1R
X-Gm-Gg: AYBFou3XseWBzNoJc0zITqQURPMddhsFBSGe1X1WvDsGI94sxrIIGI/XlZSdVNPe5GS
 8a2/8BgaDBDDd800fHNFUi6LtPYx7tx1/BZsPQT52g20f83hcyA7zpeis45pb1f31mrp+ckXZLb
 QtRb+q5oqvOJfeiv56sbY8vwr0Y/BDBXCeIAW05JYyMyIzkPD1W2L07xBQUbHZ/ZYBTS9VlmCan
 flZxB8tZmRn93GfoqyvDH559cJoUrGYXqZT0yxZ6x9zv4AUSzWGS1PTzgQLuw5jklImoPhpjyLb
 fJpWbd6mCexSpoa2IMKPO1LzNv42iXGdzX9nePlNVsgwI8aW23tssxv6fiQU5QpAWkUM/5FBxb+
 IFW8i6MAOSAKZGshu+kyU3vfBpL7ump24uBBOTCJI4ndQmAbUea2mmfufI4Q4smEptZ0lXgSJUi
 co1gmk
X-Received: by 2002:a17:906:9f8b:b0:c29:5151:16b8 with SMTP id
 a640c23a62f3a-c2ae979ef2cmr756618666b.2.1790600550998; 
 Mon, 28 Sep 2026 06:02:30 -0700 (PDT)
X-Received: by 2002:a17:906:9f8b:b0:c29:5151:16b8 with SMTP id
 a640c23a62f3a-c2ae979ef2cmr756615166b.2.1790600550353; 
 Mon, 28 Sep 2026 06:02:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dc57c8dbbsm242550866b.12.2026.09.28.06.02.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:02:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] target/i386 and misc changes for 2026-09-28
Date: Mon, 28 Sep 2026 15:01:58 +0200
Message-ID: <20260928130228.877003-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

The following changes since commit 28e7aad52202c7e6210e0e05d4f60360aaf8d027:

  Merge tag 'pull-target-arm-20260915' of https://gitlab.com/pm215/qemu into staging (2026-09-15 09:50:49 -1000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2e1e0d15d03605c4233f1de227d69dd57f5bb53c:

  agents: Add a skill for finding your way around QEMU (2026-09-28 14:17:07 +0200)

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

Paolo Bonzini (23):
      target/i386/tcg: compute C of CC_OP_ADOX without going through helper
      target/i386/tcg: ignore VEX.L for unary scalar instructions
      target/i386/tcg: fix REPScalar with memory operand
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
 target/i386/tcg/decode-new.c.inc         | 840 ++++++++++++++++++++++++++-----
 target/i386/tcg/emit.c.inc               | 303 +++++++++--
 .agents/skills/qemu-codebase/SKILL.md    |  59 +++
 .claude/skills                           |   1 +
 .gemini/skills                           |   1 +
 25 files changed, 1381 insertions(+), 243 deletions(-)
 create mode 100644 .agents/skills/qemu-codebase/SKILL.md
 create mode 120000 .claude/skills
 create mode 120000 .gemini/skills
-- 
2.55.0


