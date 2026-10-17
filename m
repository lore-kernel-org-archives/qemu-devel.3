Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1478CCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 00:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHskZ-0001KG-9j; Fri, 16 Oct 2026 20:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xHskX-0001Jw-En
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:58:13 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xHskV-00010Y-T7
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 20:58:13 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8726acc5eadso4231797b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792198691; x=1792803491; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lWgVav86QaAJScL1nTzmg3qob2drfE0FX0VClX3o3Fs=;
 b=lj6IFtlaXq7dS16bMh60avnJv3tcZKhYPiFJ96+oNpl9S14nIfzIJ+aCBhZ8YmvVEj
 FW6vOO5LL6UPAtqrAEEWFRE0/qcHr8PKAuy3A7uhMePTbzFEHVKShy4FRL+4+tc6C4Go
 10gnCLmnC1qWFy4HQQGQ5+Aqj4aDLq4Xpl/Xt8hr2b1jVSX5/tSc/xf8ZDauK1tplyVw
 4ilSN1JOL2AzOY3rkq8VLiOXQ5xUMeck9IAaoiejRSc2dwIznsqBE6NilREn0xn2P+1U
 ScqQOSb1mqj+B3wsmrxSFWfSDsbCB/AyztN3B1aUw1r2XeTLWG4rq2lVAUS8LuXSbJo4
 T8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792198691; x=1792803491;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lWgVav86QaAJScL1nTzmg3qob2drfE0FX0VClX3o3Fs=;
 b=1cef4hfwpJL4ofeUMg8kh94miutRPtrmrGHe9UfaUJR6jl2zWijSdDDEuK8Cvk+O3J
 sUIx8MD3fd4gDMMCQpcfb+wGf0riZB3zfaTYAcFrAJAdsxN0XiN9JWp8xG2yqWWX10sY
 hMTm9LonfXFf53CEnKtjswZY8DgbcfjuPldaYkMh3PHz7R2FLI7RyxOu8Nzz/pU31rEV
 kJ2x9dMFeT8nkLz4Y/kwnRfnT6U5afZqsJQBWC+wT7BUec7YXSCUfsL8oBwZ6Z+W2rUn
 BAKSDtLfzhqHq6IMQRlqNmh9gGnFkx1iB0bQ9dkLrmM0RjgBSIvC9E7tYln/GeNnLtvW
 L9cg==
X-Gm-Message-State: AFq9FYLUfNvPImVIEiX8QYGzDbOUwo88+7PbAjnTSa52RFtoX3FaUT7Y
 oMfx+SsJyvfTCpE42jDy5him+69py7cXwYiM5+qCaa4dUz/Gd1sgbeTnrIgBPQ==
X-Gm-Gg: AYBFou2MuTvVcY0Zzcr0bSaxLfsSUgrkRiXdzs7w6pFV3OKLImjV9YzqNgRdnfiaN01
 jaXXTyWGDEGjsKNSnMfp+7MhhfzJGp6o4C8sJRW5f8G/LlO9MTOoTxP4WKSxT9iA97q5Q9GHvNy
 ecv8wi38p1PahZTRGKm4JrDKY3AgoN46+Y6NpVtMkFax2s6vrFJyVnQs+Ah6hFEgwTMP37PcGL4
 DzIUC7xJWxlAbCJpu5ggAzQQeuz0swsWoP9GZRgHFTMCPqM3sNtzQQtKIesblQCcOQDx+xHEK0g
 1watFSujMuRdINQAE/cC6kFVHipMo7xZS5f1RapkbYImfwv2iWnitCdtBIoT1LOQEeK+sb8l2vT
 vFIEO70yz7EF4NnnDThRhzVEpRN4qp3GJDU7kauwKggE5GmXozTF8DAYZo2NlrvuNcP6P/FAdsr
 9VTW+IvhjYbNy2z00qNvXo91saLNFigsxbnJDgg7PyRj+NB729ZRA1PxdtptmCEmj6KoD4m8Re0
 KPt+9/KdpsjticH2rBy8hqmQgKyokjlHsEc8I5GknBUfr9Hw18osgGkCRPyE27OTEPojnUrEWTe
 +MgKVVa4oSIZBtjjPy+Wl6kmm19i
X-Received: by 2002:a05:690c:6c0e:b0:8b0:ac83:de9d with SMTP id
 00721157ae682-8b0f21e005emr6422387b3.38.1792198690571; 
 Fri, 16 Oct 2026 17:58:10 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net.
 [108.93.236.139]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b0e58892cfsm16056687b3.10.2026.10.16.17.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:58:08 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 0/2] target/alpha: FPCR exception status fixes for
 IEEE-mode code
Date: Fri, 16 Oct 2026 20:58:01 -0400
Message-Id: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQqDMBBGryKz7pQkNJF21XuIizgmOuAfGSst4
 t2beoAu34PvfTtISBwEHsUOKWwsPE8ZzKUA6v3UBeQ2MxhlnFbaoB+W3mNcKKGsfn0JCtrG0s2
 UylAkyMslhcjvs1rVmXuWdU6f82TTP/u/t2lU2FAZonetder+7EbPw5XmEerjOL5CIDlLtgAAA
 A==
X-Change-ID: 20261012-alpha-fpcr-status-s-5b5c42702cfc
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Yu8gNK/e/yU9u8B4VBbhPjnHNmakPtGSWhBeM0FODmo=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIunZBMjPh89LL65Vkf3686OPOT3r+Hri8ld8yr7a9tf
 HeYs9xUquMjC4MYF8NMMUWWuPWKLLPadiz1OS39C2YOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MwQydIziIXJ6DBqZxcWlqUW6aQVFDnn5JYklmfl5xXr5Bal5BekFemmZaSUZGflFxalAI/TyUkt
 MXR3djAwNTCwdLcycLBxNTZydnQyd3BwdnV2djCzNTQycLR1NXC3NGbg4BWCuYRFnZNi49NGUO2
 pyFm9+S5/tuVHaoPb1nZPtlP/nRJTuPq0WlpzH8D8sMOKmlNWcvrykjO3VEXYtD277cK+/tqFze
 XoX/3bXVZwA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Two fixes for the exception status that qemu-alpha reports to code
built with gcc -mieee.  I found both running glibc's math tests under
linux-user.

Patch 1 fixes 471d493047, which was meant to record masked exceptions
in the FPCR but had no effect for insns with software completion.
Without it FE_INEXACT is never set for -mieee code.

Patch 2 makes underflow match the hardware for a result that rounds up
to the smallest normal number.  Alpha raises no underflow there and
softfloat does.

Patch 1 does not depend on patch 2.

Tested with linux-user only; system mode is untested.

glibc's math tests (make check subdirs=math), run under linux-user:

            PASS  FAIL  XFAIL
  master    1400   110      1
  series    1510     0      1

Nearly all of the failures on master are 'Exception "Inexact" not
set'.  The XFAIL is test-float32x-float64-div.  On master it fails for
missing inexact; with the series it fails only the four
div_{upward,downward}_double cases that glibc expects to fail on
Alpha.

The tcg-alpha-linux-user suite has six failures (float_convs,
float_convd, float_madds and a plugin variant of each).  They fail the
same way on master.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v2:
- Patch 2: fold the underflow check into soft_to_fpcr_exc, which now
  takes whether the delivered result is normal, instead of adding
  soft_to_fpcr_exc_tiny.
- Patch 2: check float_flag_input_denormal_used for CONFIG_USER_ONLY
  only.
- Link to v1: https://lore.kernel.org/qemu-devel/20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com

---
Matt Turner (2):
      target/alpha: Record masked exceptions in FPCR for /S insns
      target/alpha: Determine tininess from the delivered result

 target/alpha/fpu_helper.c | 70 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 21 deletions(-)
---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261012-alpha-fpcr-status-s-5b5c42702cfc

Best regards,
-- 
Matt Turner <mattst88@gmail.com>


