Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC920C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 09:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKEUx-0002G2-Ml; Thu, 20 Jun 2024 05:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEUv-0002FO-8m
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKEUs-0005Ri-UT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718877265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=x9Yf0M+o6C/2mh3mr8OK3u/T08e/UXINZa/I62u2Tqc=;
 b=Q6GWUSEyb/oiuJUHBQTXSgI2RsouHytQ/0fF2VIeIx3diG/n8/hmj7lCnCN6oezVi/A+6w
 nvCsLfwo162m8nVQvqPfBhzH5aoVtvlyRuDWs9fsx7FPAPhZkG+sMqCpr/8CfktSXj1p1o
 mPMfAIckh/5NBkOuZL/bS0U+2UyfOp4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-W3tOMPz2PteKB4w_Wz5ToA-1; Thu, 20 Jun 2024 05:54:24 -0400
X-MC-Unique: W3tOMPz2PteKB4w_Wz5ToA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57d0524060dso307547a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718877262; x=1719482062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x9Yf0M+o6C/2mh3mr8OK3u/T08e/UXINZa/I62u2Tqc=;
 b=CNTEl3WxHcTBGHPsjUpqkCGZzS9onJ2jDLivkBQOYXyj/HW3QkUVNZ3BwDWPKaE0e1
 UC0NlLE9wE+mSMupYhkfAlbMtDTnOxJvRO6c3HSvylpKr+duTAtN3a8WrJBE9zEWuUPP
 2mKJtPr5acIaDJyYoQ5vxJ+K1PYRqhY5I+FDRJ7AEVJlL0wvznmvqyGbWVtcynb9NlB0
 fftn41FVBftZfsdGVUyT+oqZi7p3HvxaXF6qm6cfADBwoJ1n4uJ/iWPJOUtBVPDtZrov
 UKJwbKiUIoAurhP7SWF4QMUUJcKbbtv9wsi5D/loleT/g5DwkgSPbae/G5z+kdHmvmto
 OsBw==
X-Gm-Message-State: AOJu0YxTV9BWVAdYqHdiHOToXShJ/CQpD2b/AOwP6hdKZ5U7i7AJjh5s
 c0KHeNs8ROSDs0bETUN06Y2GE0sUsurPbKIzdU62/j8nELROyJ43aVSNCJKEShURtltpmJJeFQb
 VxdGtKz3L9Ozagf4jD7GQUmWGp0K3Rh0lbv3JMqx4LVHhjadnJmiTNUQcwaifGJ/nNS/TVzSVR5
 /kfG/tMP2bb0ZoQo5Ej5BTq0msjhgk03GsVMK9
X-Received: by 2002:a50:d74f:0:b0:57c:677a:a941 with SMTP id
 4fb4d7f45d1cf-57d07ebf13bmr2755145a12.40.1718877262216; 
 Thu, 20 Jun 2024 02:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHyELjGvrAUwFlIuDmLsOBV+LHrA4a6QEO6h343gaUaP/ss3SX8GdK8+q3NwIUisXOV4lemA==
X-Received: by 2002:a50:d74f:0:b0:57c:677a:a941 with SMTP id
 4fb4d7f45d1cf-57d07ebf13bmr2755134a12.40.1718877261741; 
 Thu, 20 Jun 2024 02:54:21 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d17d9471fsm1172903a12.52.2024.06.20.02.54.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:54:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] target/i386: make decoding entirely table based
Date: Thu, 20 Jun 2024 11:54:09 +0200
Message-ID: <20240620095419.386958-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The trailing part of the previous series I sent; with fixes for
BT/BTS/BTR/BTC, plus moving code generation of CMPXCHG8B/CMPXCHG16B to
the new decoder.  This way all LOCKable instructions are converted, and
the patch "target/i386: do not check PREFIX_LOCK in old-style decoder"
is correct.

Sneak in a couple cleanups for CC_OP_POPCNT.  They don't really make
the generated code any more efficient, but they simplify a bit the
logic for the BT/BTS/BTR/BTC flags.

Supersedes: <20240608084113.2770363-1-pbonzini@redhat.com>


Paolo Bonzini (10):
  target/i386: use cpu_cc_dst for CC_OP_POPCNT
  target/i386: give CC_OP_POPCNT low bits corresponding to MO_TL
  target/i386: convert bit test instructions to new decoder
  target/i386: try not to force EFLAGS computation for CC_OP_ADOX/ADCX
  target/i386: decode address before going back to translate.c
  target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder
  target/i386: do not check PREFIX_LOCK in old-style decoder
  target/i386: list instructions still in translate.c
  target/i386: assert that cc_op* and pc_save are preserved
  target/i386: remove gen_ext_tl

 target/i386/cpu.h                |  13 +-
 target/i386/tcg/decode-new.h     |  19 +-
 target/i386/tcg/cc_helper.c      |   2 +-
 target/i386/tcg/translate.c      | 492 ++++++-------------------------
 target/i386/tcg/decode-new.c.inc | 136 ++++++---
 target/i386/tcg/emit.c.inc       | 249 +++++++++++++++-
 6 files changed, 467 insertions(+), 444 deletions(-)

-- 
2.45.2


