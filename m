Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D2AC79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3bia-0006pK-Ey; Mon, 07 Sep 2026 11:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3biY-0006ou-IE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3biW-0000u3-7S
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788796627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=44LJSGbizEpHP9Q30K0BBKNpjLqbODu1E9+RgeLgeks=;
 b=aPTuj6Z+iRBNi9jt1KetQ4hQswOF2ns2W2y/xvYnOTRSfy7vLE8Pk8lVY0xKZsAYmazIPr
 Pi2jTbmJWetTw8/cO0hrf7ObR97N3DVL96cEPnQrT8cuyLtATaGvEoK2amPyMsDkollcvn
 b/1eceGgUOhWAaGths/s4Iz8v3OuVwY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-CQcoNtcyNSyhKBI56AtNkQ-1; Mon, 07 Sep 2026 11:57:05 -0400
X-MC-Unique: CQcoNtcyNSyhKBI56AtNkQ-1
X-Mimecast-MFC-AGG-ID: CQcoNtcyNSyhKBI56AtNkQ_1788796624
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf9df1eadso28115365e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788796624; x=1789401424; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=44LJSGbizEpHP9Q30K0BBKNpjLqbODu1E9+RgeLgeks=;
 b=RuXxhSYF8A+z1LVFC3hmSgQgdLH1/BnQqEQKKy5AvzHltM0x++/NmvfkXwSEKQ25xU
 7uSeoLzz16rnGrJ3HhNEAaT87+4h4f3R+6sMemThBa4PGmGd4BPeYCJ6xRcC50wljMtE
 4Ay2mG6qd1vh8lmlje4bmJm0KE2AzX3fjYTtE7uhNBjNFSsSzjnVlFq5+JyVWK7pPIyA
 MrW29imn4hBydfbwUUY7Qh1wHNYvikMq3TivTBkr4kh0dJ3QIOLMgL4O4vg2DSoEtosH
 g3Lw+S0Vzd8kc09qOs4foXDzGu9XVadE5TegxPQ37bLWnVQ0oZf/2Qyxl4j4NU6ugmIs
 Uu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796624; x=1789401424;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=44LJSGbizEpHP9Q30K0BBKNpjLqbODu1E9+RgeLgeks=;
 b=EAPXOpyIJxbp+8h7FQaOCgAHP/mwo0/SryPpishgYhg8+z1UkhX2gm3lE9MpKdsi0Q
 B0n4q25AoCc01xL0pLI74G3uKrr+4PuoF+EzOtFyK2QJotAASpG3VPZZqxxYzcNraoZO
 hNgCbnzrEx6b/IptzTWxHsoUlyRqBL0LdTwRKHAsRUDZOPLTk7CDy3J0R4/wgUWUOSJC
 khB5zOxsivMSePpFkKtITVBPWfsgjdj1rhbdCrwn7UvPPEtuHKWNI9x2cBwcPbtPOvHN
 XslNcHw9NdX3xhmV4/MPpq8mg782NUDR9l0TtufnL6SAkq6mC+ucBXcDmCcu+5sPjo5+
 KnaA==
X-Gm-Message-State: AFuF++nLjYz0aeLar9Q2iBfaLXZQUU9j6tQy+1/ZF8y/URnc8GsLhaoC
 UisnqhN0QDN2DdtIgfLOh6uSNSVnJuciNcMZTq2viCnWymG6V+D3+Dztd/GODUTMsTiVwctspMe
 a+QRqd1tis49k4G/cVX7SOaF4XiQQr19RlmtXtEjXau33sHZKqkEcZTSH5A4jrszbWY8PzhLazB
 NZXSCjevheNDhMNfW/A7RglujCpElnzOFMaraKa2emMOc=
X-Gm-Gg: AYBFou0hVRdgoVdkUvtOLA3KoKz+ydknpxbMhghv0LcxQt2j6PBWpAB0hjRNhTHnJtm
 2+3pWXTSYgTWvhGNZPIGK1/wrdRiHNqWftWlrB3/2rsmnBzeAH1iNkaNvkgWyXDzOMGwzXViFH+
 vP0grXjcUNKuG6AGWbDoR2crOI0okevS6QjT8cmFdiqaiMgKwfahIHP74ttlepBzw0UdiwGrLax
 HkV6dHl9ZEPVEzURH6/0YpW9KRlYGwWcQW1Jh7rEOog5K8gG1XrHxebPb0wZwkhlsjYdsXbDe79
 0OXtHDcRijN1tt5fcs4OIIy24EFdxDGuA9WmUJeCspL4RSCcEffsP+vrQJMIXEWoMgUH4psK+2y
 wtPCJTcnvZfBtmY9zUibLR99ZDYfJCMRKniK7rhK0uM9dCL2w2IYF0R5XccR/kTnSOY4J
X-Received: by 2002:a05:600c:8b88:b0:49c:db20:da13 with SMTP id
 5b1f17b1804b1-49cf822a707mr251495345e9.5.1788796624481; 
 Mon, 07 Sep 2026 08:57:04 -0700 (PDT)
X-Received: by 2002:a05:600c:8b88:b0:49c:db20:da13 with SMTP id
 5b1f17b1804b1-49cf822a707mr251494955e9.5.1788796623947; 
 Mon, 07 Sep 2026 08:57:03 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:57:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 0/5] igvm/sev: apply the IGVM guest policy before launch
Date: Mon, 07 Sep 2026 17:56:56 +0200
Message-Id: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQqDMBREryJ/3ZQYMZiueo8ikiZf86EaSSRUJ
 HdvapddvmHmzQERA2GEW3VAwESR/FJAXCowTi8TMrKFQXAhedfUbKT3QFOah9W/yOyMP5Ww2Ap
 rpYayWgOWyml89IUdxc2H/TxI9Tf9uRT/d6WacYaq0dKMnWm1uQe0Tm9X42foc84fJ7pYQ68AA
 AA=
X-Change-ID: 20260831-fix_igvm_policy-0b92de52dd6a
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
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

The guest policy from an IGVM file never actually made it to the platform
before launch. The callback that was supposed to forward it ran after
LAUNCH_START, so it did nothing and the guest was launched with the
default policy instead of the one requested by the file.

The policy is part of the attestation report, so this quietly breaks
attestation: the resulting measurement does not match what the IGVM file
was built for.

Patches 1 to 4 are cleanups needed to get there: dropping an overloaded
callback, moving the SNP ID block handling, giving the policy properties
proper accessors, and adding a way to read back the platform's current
guest policy. Patch 5 is the actual fix.

One thing worth calling out: if a policy is also passed on the command
line and it differs from the IGVM one, the command-line value takes
precedence and we print a warning instead of silently picking one over
the other.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Rework the callback split. Now we don't have an unimplemented callback [Stefano, Gerd]
- Reject a command-line/IGVM policy that doesn't fit in the 32-bit
  SEV/SEV-ES policy field instead of truncating it [Stefano]
- On a mismatch between the command-line and IGVM policy, print a warning and
  keep the command-line value instead of returning an error. [Daniel,
  Gerd, Stefano]
- Picked up RoB
- Rebased to latest upstream
- Link to v1: https://lore.kernel.org/qemu-devel/20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com

---
Luigi Leonardi (5):
      sev: split set_guest_policy into set_guest_policy and set_id_block
      igvm: move set_id_block call into the SNP ID block directive handler
      i386/sev: convert the guest policy properties to custom accessors
      i386/sev: add a get_guest_policy callback
      igvm/sev: forward the IGVM guest policy to the platform before launch

 backends/confidential-guest-support.c       |  24 +++-
 backends/igvm.c                             |  91 ++++++------
 include/system/confidential-guest-support.h |  36 +++--
 include/system/igvm-internal.h              |   3 -
 target/i386/sev.c                           | 215 ++++++++++++++++++----------
 5 files changed, 230 insertions(+), 139 deletions(-)
---
base-commit: cacd3462963a0a4f5bab4263ce79c2aa4b32692d
change-id: 20260831-fix_igvm_policy-0b92de52dd6a

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


