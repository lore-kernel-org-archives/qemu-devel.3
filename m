Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0049C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHV-0004fF-36; Tue, 25 Aug 2026 08:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHT-0004ev-1K
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHQ-0000EI-R7
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xGOU2p2diZBbmDJDUiLNU5iQX49Thg7WKZ/eTaUSebU=;
 b=OmAisCCx1jFv1dCF/bDHN1VueeXiLqURydOP//Q0FOH/EIC6Or0N2s9QN57c8sSBbNLZbs
 L/kUC/HXWYr5A/A5yDig4Jn7CjWTxaVnkrGYaaRZmz2NH05mfi76An6Xx1jif5QKhGCtSM
 rmcnmaMdyDtjM91u/cdVU6Qp8Vg7ptw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-lbc9BdnrMxe1QFwN8__sgg-1; Tue, 25 Aug 2026 08:29:25 -0400
X-MC-Unique: lbc9BdnrMxe1QFwN8__sgg-1
X-Mimecast-MFC-AGG-ID: lbc9BdnrMxe1QFwN8__sgg_1787660964
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c21946c03e5so82091566b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660964; x=1788265764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xGOU2p2diZBbmDJDUiLNU5iQX49Thg7WKZ/eTaUSebU=;
 b=LtclD8DSQx73wADqnMFc85KjnfHRVoeqmg2I7Jz7HRTx7Ha06buA4TjbTDPIGvfPFO
 Sb8740xsi+A5ZrtX8WKbejD6RdRjzt2pvhLIrNqW888goLN6mAZxDAt9aaEOQDVOL9Mt
 2gA8wD3GkeTQ5fIdll6sS9GsYIhLs9fJFBJ+M9IGO2TnR9jYYehehKlP/X8mbA3y882f
 Dwwol8A/afAKxkkFU+z0kFpVjU+iYYmoiz97fHwiDxh3cANcB67rK3RADCcEdCLJ++IY
 Di+yKj+qZHf2s/cHTjhLSeSUbXQZbIwOfCcRy73azzpArl23Sd7A//bLGM0T/xyhFF66
 pAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660964; x=1788265764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xGOU2p2diZBbmDJDUiLNU5iQX49Thg7WKZ/eTaUSebU=;
 b=hvTHe66YWoR08EoF7zjCjqbKelH6gML9S+v33jASE4wkT/hA5/UmOJBzs5Ru3E57dK
 VwqvF4j4vzrjEVyDprh0GvthVlJCJIqBeYRHKGIxLbOEl/Qg3uLJYT8LqlqvSyBlcBXe
 tv0rgAiIgRe4GjnuxXhZuzpJVhvh+KyyW4Ofk4bAVKTk0FrK2QcQG3ubzwYu3wnP0BwD
 j3VR9pWrTJ71Vhoa61Hn1CvdC8a3dz9gu4Lv76iRnpa1IW5Yb4nyJNVIMlQwKZwfMydD
 htYu4uXgKydV6WXJVhF9QdiL2dvZpkLeX5Q8eI4Fxw3CzD4nVYHDE5tn/UGXyMewrdLr
 iW8A==
X-Gm-Message-State: AFuF++kaEX+yv7ZzR4oKbQGF0H0BN9aOW32Sx/ALnasuV4ZOUU0KAe36
 jxHvpA4OMJxPsEH6+EIOP6DC2q6+j7zy6Nx91rKfvcODqyXup5Ox1pVTj7hsB0DYtjKlpWRBmZC
 jTsxZfNGbl/iNKstQzsT90pLUEvpeVYSr3WbiUWw/9Je02ULqEcopCNrwLvcaxrpbiGUpMnkcY7
 OPsZRCF7wXUJ1RZklh4vK8SuOuofcpcHL3C+DF+msg
X-Gm-Gg: AR+sD12r2mPs2FTAkexzzbd3B7kS86EkQDF8Khe8jEO4cCJJXdzfyNarGqaD61hnYVV
 lRB4Ppz9Q31QAcb1+yzkvVqmre8v8MPW9ycgt5LsEY/jrPOBLTpnIWqwQxRL++qEh9J3fTkPpxl
 CdFQGzeTovQqvPTzT6n8CWc4VjsfOinSsNkYq2SUWn8clZQfTRs62RwkHPb3fXiVGxEYpuG+/ig
 xmsFpPlpghY19a1fY+05pirAteMLny7F/fSnGWPPK8wGELRLbVgPkqNtrvf6U64//29h7ZEhqot
 lg35TfyQKHAyC07LL05/5oMsJf9QN6zVC2d7TjRE/YPymuPpjjjxEsr0gpw39GlnhhAaksl+SbP
 EMl41PLxsJOOeS7uoay4c6EQSKduInDrECZk8r63/HdyHS9wp0m52rgA+0Catx4XDhf70O/mUeT
 DUYSQ=
X-Received: by 2002:a17:906:9fd0:b0:c20:7166:cc16 with SMTP id
 a640c23a62f3a-c24e2f96398mr690437466b.15.1787660963943; 
 Tue, 25 Aug 2026 05:29:23 -0700 (PDT)
X-Received: by 2002:a17:906:9fd0:b0:c20:7166:cc16 with SMTP id
 a640c23a62f3a-c24e2f96398mr690428766b.15.1787660963399; 
 Tue, 25 Aug 2026 05:29:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b4f1sm1801885266b.3.2026.08.25.05.29.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/20] target/i386/tcg: implement APX
Date: Tue, 25 Aug 2026 14:29:01 +0200
Message-ID: <20260825122921.431739-1-pbonzini@redhat.com>
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

In fact, most of the new code is for EVEX decoding.  The extensions to
existing instruction can be implemented almost entirely by tweaking the
decode tables: the new data destination feature comes almost for free
thanks to the existing support for BMI instructions.  Variants such as no
flags update and zero-upper are quite easy as well.  The new instructions
(CCMP/CTEST, CFCMOV, PUSH2/POP2) are trivial except for CCMP/CTEST,
which try to be reasonably efficient.  A lot of the recent changes to
AF/CF/OF computation make the changes to helpers very small, while
efficient implementation of JL/JLE/JB/JBE takes a bit of effort.

The main design decision was whether to treat VEX and EVEX maps as an
extension of the regular maps, or just bite the bullet, copy them over
to a new array and define them from scratch.  Here I went the copying
route due to some annoying differences in accepted prefixes and due to
opcodes that were moved to a different spot.  But in some cases APX's
three-operand variants end up being visible in the regular table,
due to shared code in decode_group*.

Don't expect any performance gains.  APX binaries do produce about 1%
fewer TCG ops, but they map to about 1% *more* assembly instructions,
at least for x86-on-x86: that's because while the optimizer could
already produce roughly the same ops as NDD or NF instructions, the new
PUSH2/POP2 instructions include a stack alignment check that isn't there
in non-APX code.  I don't think it's worth wasting a precious HF_ bit
for it, at least not for the next few years.

Other than the first three patches, and other than not reusing decode_root,
this is mostly the same as the RFC[1] since I didn't have much more
time to work on it.  System mode emulation was tested very little,
basically nothing more than a simple initrd that runs a few instructions
and does xsave/xrstor.

Paolo

[1] https://lore.kernel.org/qemu-devel/20260301144218.458140-1-pbonzini@redhat.com/


Paolo Bonzini (20):
  target/i386/tcg: do not reuse cc_srcT
  target/i386/tcg: inline gen_ext_tl
  target/i386/tcg: simplify return value of gen_prepare_cc
  target/i386/tcg: move check bits out of validate_vex
  target/i386/tcg: add APX support to XSAVE/XRSTOR
  target/i386/tcg: treat VEX as disabling high-byte registers
  target/i386/tcg: add definition for REX2 prefix
  target/i386/tcg: mark XSAVE* as not allowing REX2
  target/i386/tcg: decode REX2 prefix
  target/i386/tcg: implement JMPABS instruction
  target/i386/tcg: fetch modrm early
  target/i386/tcg: move VEX validation early
  target/i386/tcg: extend VEX.vvvv parsing for APX
  target/i386/tcg: decode EVEX prefix
  target/i386/tcg: add ZU writeback
  target/i386/tcg: add decode functionality for APX
  target/i386/tcg: implement CCMP/CTEST
  target/i386/tcg: decode APX instructions
  target/i386/tcg: mark APX as supported
  target/i386/tcg: optimize CCMP

 configs/targets/x86_64-bsd-user.mak      |   2 +-
 configs/targets/x86_64-linux-user.mak    |   2 +-
 target/i386/cpu.h                        |   8 +
 target/i386/helper.h                     |   1 +
 target/i386/tcg/decode-new.h             |  20 +
 target/i386/tcg/tcg-cpu.h                |  16 +-
 target/i386/tcg/cc_helper_template.h.inc |  11 +
 target/i386/cpu.c                        |  15 +-
 target/i386/helper.c                     |  11 +
 target/i386/tcg/cc_helper.c              |  10 +
 target/i386/tcg/excp_helper.c            |   5 +
 target/i386/tcg/fpu_helper.c             |  59 +-
 target/i386/tcg/tcg-cpu.c                |   5 +-
 target/i386/tcg/translate.c              | 203 +++--
 target/i386/tcg/decode-new.c.inc         | 896 +++++++++++++++++++----
 target/i386/tcg/emit.c.inc               | 256 ++++++-
 16 files changed, 1274 insertions(+), 246 deletions(-)

-- 
2.55.0


