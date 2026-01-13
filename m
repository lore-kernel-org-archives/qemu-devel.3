Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F79D0C855
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcLN-000339-Jc; Tue, 13 Jan 2026 06:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLG-00031B-Fi
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLE-0008PR-Oz
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yfyp/4so/EYWYIkAsTxT35IwsgpRSzH4PPVP0v3OJMw=;
 b=eSH4oigKOBCDhADT/V8rbU5jnAhJBtqNgGxOFBnE40GcvNTcex1V0egLmdQnDWugrWW8f8
 /9dw4aC1y9Di7wpcuHb7Hnj9YukXTS7yRJpLvAtKapme3goXHo5a2HDpAQxLMCewCUDY9J
 K6net//Jp5+RcjKsYc2lGU2+hYMkRS8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-lbOdeBQ5NcupXaltqjgInw-1; Tue, 13 Jan 2026 06:13:38 -0500
X-MC-Unique: lbOdeBQ5NcupXaltqjgInw-1
X-Mimecast-MFC-AGG-ID: lbOdeBQ5NcupXaltqjgInw_1768302817
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fdc1fff8so4381175f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302816; x=1768907616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yfyp/4so/EYWYIkAsTxT35IwsgpRSzH4PPVP0v3OJMw=;
 b=bpue7vpzQNKGl6s7LSfB+vDprJSySb0cLjpkoYhhPxbeoHHlX+eg8ijWpah61C3TDJ
 xrNG6cZAPUam2wOuL3ySpJLOnzBlqeyxOmSVHkjb3AnpIW4Kkk2lOz7hckkZ8nL2lUc8
 jH01Xgd2/whQBNT7SZUEB7naOYsYWyEE6peftpr/2Q65VmTI4xw+jA5q086xZSn3scP0
 XVlf3/9F/9S8udhW12CEsoOt5kszkQLOBiI+1VrmaOHb1A+J7tTr2PiWft+R7zSgJzU1
 GgycXI6HSF8skhzH4IUO2K/GS6HTTJMzEVz9s/NLXZnk0SkWwqXY3Mm6ON3QHpAzGclm
 emDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302816; x=1768907616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yfyp/4so/EYWYIkAsTxT35IwsgpRSzH4PPVP0v3OJMw=;
 b=Gb58xTD7HIuWZ5Tpmchu4Ig57WVz236r0p2Lmp9EmMdBcGQ/OD0OPhxQ5dVm9wp7zP
 rwTarmIHAkfFyFd0rE5eQoD44TZDJQ8vJKrR4YMzhceBHEFeVWQUYoBDwPvBSqCUtxLj
 P16SCZh4KXxRqmKKlM/JPRTsRAsO0ObetHXYvaOYkT2adsFLXk5adeq3vctgY2Y5F3jK
 dNOQrElTASpkOQlMQ/PF8ECrrEMStn9tAwdM1RlEAVhq0VVXloGC4Ve8q/QQC5Ex20fQ
 V79MVUSCPcz19RnLFNxXQL17VyyLJTCjCwQM4kP24RQ4AydmV51qX6jJ/yteSLk5WKcb
 NKwQ==
X-Gm-Message-State: AOJu0YxOaa90DOpy01Dg1tHuvnLnxAdmqQB6IPHOzsXMJkVMSUvOUOcR
 rG0OB3afMjc9Gj0rCANFDF08hJKSE5AvcXd2VcIE0Y2mLw3GZpq9v1r4Tzv5E2itauw9oXSmjXp
 Cjqv70x8M5ScBBWHMtCrVX7A4ZCkw/xbAYYeuqLlXuWWxTwq+WlcniBt7cN8IoyqBoTiT2/qvLf
 GZJidxu/K2Yq5tOPr/MdoFH8xiMLHyRoPP5Dl58Wml
X-Gm-Gg: AY/fxX7rRQe6mSbsWr6RGJsDdI8kg3HBjk8zsdr7YOm1JHQevK9QVhVtWAPpgrSYv1U
 W4wcxcT/8CzSPhpvdc273nAPAMtMNJhzzFEnF1FggL0ox0Nf/dlSaxbFBhgb64CYcWx8ijYg4ye
 BgDmqQyNalVSaOHFIr7K0pi1fGSNiSi7xqZCTR1GqrNgyJnfioyCP65uZyanIoRYXjYQlvJWdkX
 nl/DzUCyxZI4nFwxpGx27WFmZ0Q3G2UxtV8LJD/ND0KDxBvMK4BCKlRkTIU5KyrD2m+rWjGbcyg
 5WRIGhzU2XFjc+QbPIZ63Vy3heEKscaGSIZA1yvE5YO1bLNEW0UQKcgTKGkvEal8uIIF7wd1tsk
 m3v3m8/xWLI1xi4taSsUdq7T51xlrctYGTxcZuoHi0PFAP4tBDky0nCLPC0MTBEyqWzI6tcAQZ6
 8vEQCyUKIo+tdFJg==
X-Received: by 2002:a05:6000:188e:b0:430:f2ee:b220 with SMTP id
 ffacd0b85a97d-432c3632beemr28248063f8f.19.1768302815854; 
 Tue, 13 Jan 2026 03:13:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcEowwgUHxmADHgsj639MGWI8RVsxkZDW2UoLlmOfCxfFwai/xSHycWBdN9emweyporCxoWA==
X-Received: by 2002:a05:6000:188e:b0:430:f2ee:b220 with SMTP id
 ffacd0b85a97d-432c3632beemr28248016f8f.19.1768302815233; 
 Tue, 13 Jan 2026 03:13:35 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5fe67csm43571977f8f.40.2026.01.13.03.13.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:13:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Mostly x86 fixes for 2025-01-13
Date: Tue, 13 Jan 2026 12:13:26 +0100
Message-ID: <20260113111333.1138160-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The following changes since commit cf3e71d8fc8ba681266759bb6cb2e45a45983e3e:

  Merge tag 'single-binary-20260112' of https://github.com/philmd/qemu into staging (2026-01-13 11:51:18 +1100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a24f045228271391b5c5064ebf049e1f50b6d712:

  rust: Update Cargo.lock (2026-01-13 10:54:28 +0100)

----------------------------------------------------------------
* target/i386/tcg fixes
* hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()

----------------------------------------------------------------
Paolo Bonzini (5):
      target/i386/tcg: do not leave non-arithmetic flags in CC_SRC after PUSHF
      target/i386/tcg: remove dead code
      target/i386/tcg: do not mark all SSE instructions as unaligned
      target/i386/tcg: mask addresses for VSIB
      target/i386/tcg: allow VEX in 16-bit protected mode

Vulnerability Report (1):
      hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()

Zhao Liu (1):
      rust: Update Cargo.lock

 target/i386/ops_sse.h                | 16 ++++++++--------
 target/i386/tcg/decode-new.h         |  2 ++
 target/i386/tcg/ops_sse_header.h.inc |  8 ++++----
 hw/i386/kvm/xen_evtchn.c             |  2 +-
 target/i386/tcg/cc_helper.c          |  4 +++-
 target/i386/tcg/translate.c          |  3 ---
 target/i386/tcg/decode-new.c.inc     | 21 ++++++++++-----------
 target/i386/tcg/emit.c.inc           | 20 ++++++++++----------
 rust/Cargo.lock                      |  5 +++--
 9 files changed, 41 insertions(+), 40 deletions(-)
-- 
2.52.0


