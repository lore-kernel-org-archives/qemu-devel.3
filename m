Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C753EC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kYJ-0004su-Rd; Thu, 10 Sep 2026 15:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQy-0002Mo-GB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:47 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4kQc-0004dl-PH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789068350; x=1789673150; i=deller@gmx.de;
 bh=aeQ/ZW9NWOqgtCtNPQnKo79I1qD484PyIRQ8qxVAa1E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dC73PeBeMgPDbCvEIxlqrC0oIIkfLJVOXTL9XQE55IrSKDuhoICU+PVOFtBWVVLv
 SEebVBKhjSFr0+i0QJCDVQHbLBtiofwWeY3Z1jRazlWHXK1mes+SURMoWPgAAFrVl
 2kURGgwA575E6BMUMm/JMLqbroX7zhu68bpwWZsjytZah+p3OTE47K02neIzdDfE3
 expGEHJ9VHGvjSSK0quH7dmvbdgk00zr1hfDB2YIQA6iSJF87pdvQ1jW//ZgZkjhh
 y9rPC8h4hV0eEpXRfUkT/KNTCviIbw3+VbAdS9jUwrpv45u4h/JQ8/Af7o1+DYEeI
 VOUk60q3fQRm7frtxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1wRc5J0inf-00qlbP; Thu, 10
 Sep 2026 21:25:50 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 4/7] linux-user: Fix target_madvise() to always return
 TARGET_xxx error codes
Date: Thu, 10 Sep 2026 21:25:41 +0200
Message-ID: <20260910192545.768850-5-deller@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910192545.768850-1-deller@gmx.de>
References: <20260910192545.768850-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4FWFwK3xC8JKy4fiFp5oLpXgfp1qBg6/S3UhLuR9Jtgo6e/+L1g
 2kwx4In5vZWxgacr4krYoBg+CIY9rOFGMWVmDf3KQWGSRWdo1VtQazHZqL/C4XRRpQuqb/d
 BgISCIMQqlMuY4fczFqJXb0RziCKp1YYP3af2pxegotDxGEK1UmVMlePcKdKeo+6jWioqrd
 ZLAIB061nosGm3Zw3PBbw==
UI-OutboundReport: notjunk:1;M01:P0:xtsN3tI710Q=;o4d8yTBu5en4yM7Y5KfoTsVNSrU
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

The code currently mixes host and guest return codes. Fix it up.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4066072ff4..dd957db55a 100644
=2D-- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1329,7 +1329,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong l=
en_in, int advice)
         ret =3D 0; /* OK */
         break;
     case MADV_REMOVE:
-        ret =3D -EOPNOTSUPP;
+        ret =3D -TARGET_EOPNOTSUPP;
         break;
     case MADV_DONTDUMP:
         page_set_flags(start, start + len - 1, PAGE_DONTDUMP, 0);
@@ -1339,7 +1339,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong l=
en_in, int advice)
         break;
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
-        ret =3D -EINVAL;
+        ret =3D -TARGET_EINVAL;
         /* fall through */
     case MADV_DONTNEED:
         if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
@@ -1361,11 +1361,11 @@ abi_long target_madvise(abi_ulong start, abi_ulong=
 len_in, int advice)
     case MADV_COLLAPSE:
 #endif
     case -1:    /* BoringSSL uses -1 to check if the environment is broke=
n */
-        ret =3D -EINVAL;
+        ret =3D -TARGET_EINVAL;
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "Unhandled madvise(%d) call.\n", advice)=
;
-        ret =3D -EINVAL; /* not yet known advise */
+        ret =3D -TARGET_EINVAL; /* not yet known advise */
         break;
     }
=20
=2D-=20
2.55.0


