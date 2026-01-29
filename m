Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B802CD46C16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtH-00009y-JS; Wed, 28 Jan 2026 20:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt8-0008Ts-Jl
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:04 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt6-00039s-H6
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:32:01 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-352e2156450so175011a91.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650319; x=1770255119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAwgkxcCnnqe9jCM08ttRZ7hAqumVGJ7T0ER05F6LwQ=;
 b=Yd63b6TkFa+O8QeHWep6rXGF9DieeM4YQlT9gjARp0gbZHJ9eQj7M38AAnMgItbXZ7
 uTKGbPbSlxTcPOLE2t98dUI2HtuC9vCbRrmQpRLvgIc8NATDPSp6Cs3JymWUIVw1kfuw
 +LqZtk61AsNlEs5K5TLMu0m7KPKtvr8QjwTVHXaSXmnOhZjY8Ro5uUBd2k4smxrsV0SD
 8wiEH++Gn+l/I+7LXJRNEcbgGZUp9xP9oNLjEG3gC1f0JzGvKhHFsrEGXQhEdJ8He9uo
 +4x03hazSCRfOmPxH2aFCdws5DwPYTBQyiP91p0ZSleZ5LCgGb29KOPOQVcjHkddLXhs
 WV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650319; x=1770255119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BAwgkxcCnnqe9jCM08ttRZ7hAqumVGJ7T0ER05F6LwQ=;
 b=qB2ODX4UO53mkisnB9Z8pxq1njB04c/ZW6qFrU91AroUIA2+jT6bO1xbvUczauK9Zi
 T98YPAopSw73aQKi4MnddK55ZP4UwCZoMoX80NrJWwyqy5IrPwZQigrlW4+qnL1vnVqX
 PrHHp7SWWvgEsCQ8A6e/3i3NSP1ZKeaRE4ktzQ+bRuPLexEc9HhxSg5haB7/dgo+tkYZ
 OikY8FuxocD37PNrs58n+8s8TlzYUpch8JKNSkbr0y2S4v24IaSiJXS368YYrSqH7zzI
 YjRtyt5LeolHyXuZYb31O2eyWYP59UBxZYm3Ge3NvVEoSPbgrQWOIt6AYeo9YLORTypg
 O07g==
X-Gm-Message-State: AOJu0Yy2m926Nx+4VbqmKR8N6fJ+6zGG8KnuTStlT8X+kovRCcrD9o+v
 BrIK9lIyIxabYq7ftYP/ERrMHLO3aGxD6fy4i2EvF+DXjtfY+IjHLJh9TTGN4xwRCxG0lGSpIQW
 5JHZ4
X-Gm-Gg: AZuq6aI/hMn1yswbiDz8eaIbhiab0voS4S4APoE1FVuspVJUZnjh2DIjwQf+/vBn3ei
 GMBB52Uk938pkBEbtmfL0pgnxzx7KeRSxz0QQ+Q/0F5weHG6Y8ay0sesWouQ83Ua4ZPk2XfecyX
 XXjq+Wj6vH+24Go1+AYFOhEs3sSq0ocaSxEf+n0umenvi6VR3VswAdNqmiCL49F40/kxW7pOlIS
 UGweUxoaeHv3lFTxTlnGEyVjsfz0JnN07uRJNpK1GANaQwDwLoUnpb6IAgKIhw5MRh3/5COpcZ1
 x3W+rJYtMFCGuh/fKgFpWWzb/k1JxRDGKiKRbqi8i4rlxacrvY4kt2pCsnCjYDXj3+J3OWPpWGc
 6uuWQzyZOVx13laxoARRK28ovPGqfESsijLEnsKoO3jURxitw8EUB5V+fK01COwDDFuLy7QqfSD
 oagPSezk8xlYIWMCG01BT1W/Uff+ubNS3dRFmAfAGSuPO5U4P/5HMfWGTOie0X+6cH
X-Received: by 2002:a17:90a:c88c:b0:340:9cf1:54d0 with SMTP id
 98e67ed59e1d1-353fecca19emr6433708a91.1.1769650319045; 
 Wed, 28 Jan 2026 17:31:59 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:58 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 17/20] qga/vss-win32: fix clang warning with C++20
Date: Wed, 28 Jan 2026 17:31:31 -0800
Message-ID: <20260129013134.3956938-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

C++20 deprecated such constructs.

../qga/vss-win32/requester.cpp:380:32: error: bitwise operation between different enumeration types ('_VSS_SNAPSHOT_CONTEXT' and '_VSS_VOLUME_SNAPSHOT_ATTRIBUTES') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
  380 |     ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |

This is a false positive, since VSS_CTX_APP_ROLLBACK is not a value
defined in _VSS_VOLUME_SNAPSHOT_ATTRIBUTES enum.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qga/vss-win32/requester.cpp | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 5615955b6f3..74489fcd0ae 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -377,8 +377,10 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
      * To prevent the final commit (which requires to write to snapshots),
      * ATTR_NO_AUTORECOVERY and ATTR_TRANSPORTABLE are specified here.
      */
-    ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |
-        VSS_VOLSNAP_ATTR_NO_AUTORECOVERY | VSS_VOLSNAP_ATTR_TXF_RECOVERY;
+    ctx = VSS_CTX_APP_ROLLBACK;
+    ctx |= VSS_VOLSNAP_ATTR_TRANSPORTABLE |
+           VSS_VOLSNAP_ATTR_NO_AUTORECOVERY |
+           VSS_VOLSNAP_ATTR_TXF_RECOVERY;
     hr = vss_ctx.pVssbc->SetContext(ctx);
     if (hr == (HRESULT)VSS_E_UNSUPPORTED_CONTEXT) {
         /* Non-server version of Windows doesn't support ATTR_TRANSPORTABLE */
-- 
2.47.3


