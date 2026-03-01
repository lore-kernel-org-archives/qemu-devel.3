Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6956FD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0g-0000Oz-Cd; Sun, 01 Mar 2026 09:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0Y-0000LT-2m
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi0W-0005km-6V
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWKTRldb4iRFxkSurqgq7P1n5f8uWxNSHnZjn42Afes=;
 b=iNZ/yMD6pkOgtT2c/bEzewQqqt/8V9oPYVuOGEMJnI4wNYPXNfAqPVoMQMNNl15WSTQOYp
 df/sJ6ilFVEKP+iiNO8cHg7410b2ywB63UOXSPtB/bUsgeZ5Ym2cpD/dWcbIWBY5tkbxdy
 j9CLKihi+Ki732CN1p1K6L82SQ9gKI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-IqvVg_8UPymrnNX4e0jqzw-1; Sun, 01 Mar 2026 09:42:54 -0500
X-MC-Unique: IqvVg_8UPymrnNX4e0jqzw-1
X-Mimecast-MFC-AGG-ID: IqvVg_8UPymrnNX4e0jqzw_1772376173
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso28846215e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376172; x=1772980972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sWKTRldb4iRFxkSurqgq7P1n5f8uWxNSHnZjn42Afes=;
 b=lju3CdaTNyj9g/pHsyLbdOBSQ0UPQ08az7dzte0vfIUwsJGBD/WCc3D7JVwhT8Uwpn
 ujNn/mIH0IhwHhq5WMyDpH4zkbJUZGaaYqr+5KO4HGrf4e58H1RTwlPIB3jU0ADgbLmI
 pXNGZzozG826MEWxqt/CDdYBZMsxgbn+aThlpOPBJuySX5o2PH9WsN9joDUSZufNuknq
 v+nTU3CquHM7P7by6z5q6/nIpen7pI7KxgWIYdNH09EVYDTMpEV81A9KnxQ7q7CQfhdh
 nn0yMQyVgaslyyTlgOumr/FtXJcsnGdXdfYz2gdHTcOMSdNGNOigNXAygcwP9H1y65lE
 VT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376172; x=1772980972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sWKTRldb4iRFxkSurqgq7P1n5f8uWxNSHnZjn42Afes=;
 b=KuiTWC6WarefdEbBZbGJqdPbmzO+9j5gwRLVx7BRLo31aRPI0DTWN+JgBFp37A7Nv4
 97ezxoEmguANatDp+2RVdWDTfieCIj8MZ6FUC+9/5g03hoHZfrgdjv8Blf6wbsu7tKIR
 rF+opLKvZ61KNPMUXsSQJ7ZFWPPl+tPszxAEPYUjLZvxpyM0T/vyYgCNKZhYzOY5WFve
 TU5/ec0L4EnSlHDLZTqH1dKWi2O6kIPnDztHjZa/b2EqUqcgAXZzAMDCxyhfVm7Dklc9
 YEco/Ftc2e575tXvu4BkF8WukFO2DXTvWqU4y92JOkne3CYeQ+MWLi0ZC4/u14hnOq0n
 Ziig==
X-Gm-Message-State: AOJu0YyflB7h6FJ3DSrgnFUslpqihGCbap+iiW6JDk40cNkjGqEw5Knz
 THQh34MjUZdgwBX5HUKvUAradz0R0SCzUoCmbg3ImMFStlQcH4aqw63G4u9d4PTzmUajErbbqtV
 +YK62vXbdOnzBueNZ8ND96iB/5ZwluRURdD6NBqCyHGK/1v5XPYWiJF0H7PZF8ywukJ2XcbUuhl
 kMqMFkTrXaQaSH/9xi+t6xtpExSR9behDwl7v4SDjA
X-Gm-Gg: ATEYQzzks87zGc7hmIb6T1v/a8jHGpPDclvm6qbp/YTe5hsihiOqSdQcanhXjWMwAov
 377hybDNNXlU2s8lSr1vJt35MD+DpOskdM4B9qFDhP6efHasV8K1T1Gb2AHiaN05LLnxv88mpj7
 sisW/qhRBrxm+tsB/O87pzoGW2MtjSQiL9Dj/KACtNnBmz1d65/YVWUyjZjzHTqA6WpsdNv43EW
 TTVxjzhwNZfb80rFxdjmPILg5dkGmZSNytKnGYOUJYca+Pqmt2oh5evTfZ+5YMnsvFokWSEkCjT
 L60NFOW/9+qEsO/jUSI6YjMHxjUXhC6uo3SyoOUfxiV68biE6qR+HbtKF5pB674e3zhsp1NxBq+
 LEmbh+pam3fIe4cPpUHhZxiAA2uzBYN4lDpqkZuuXsk5L7mRNhFWRMUWRkOdKupVhoZapHHmy+z
 J1+BetCfgnqJ81u2/H3sKJBPxDsuA=
X-Received: by 2002:a05:600c:3e16:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-483c9ba38damr170119975e9.7.1772376172520; 
 Sun, 01 Mar 2026 06:42:52 -0800 (PST)
X-Received: by 2002:a05:600c:3e16:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-483c9ba38damr170119435e9.7.1772376171883; 
 Sun, 01 Mar 2026 06:42:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd765604sm301684265e9.15.2026.03.01.06.42.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/18] target/i386/tcg: undo IMUL memory load optimization
Date: Sun,  1 Mar 2026 15:42:15 +0100
Message-ID: <20260301144218.458140-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

The IMUL 0F AF encoding was using T0 for the (possible) memory operand
so as to use a load with sign extension.  However, this trick will be
incompatible with APX's new data destination extension which will use
"B,v" for the destination.  If no VEX/EVEX prefix is present, the "B"
operand type defaults to op1, hence op1 has to be "G,v" for correct
decoding of the non-APX instruction.

This is only needed because EVEX map 4's 0xA0-0xAF slots reuse the
decode tables for pre-APX instructions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 5e559d6ecb5..18b1b6845c1 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1504,11 +1504,7 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xac] = X86_OP_ENTRY4(SHRD,   E,v, 2op,v, G,v),
     [0xad] = X86_OP_ENTRY3(SHRD,   E,v, 2op,v, G,v),
     [0xae] = X86_OP_GROUP0(group15),
-    /*
-     * It's slightly more efficient to put Ev operand in T0 and allow gen_IMUL3
-     * to assume sextT0.  Multiplication is commutative anyway.
-     */
-    [0xaf] = X86_OP_ENTRY3(IMUL3,  G,v, E,v, 2op,v, sextT0),
+    [0xaf] = X86_OP_ENTRY2(IMUL3,  G,v, E,v, sextT0),
 
     [0xb8] = X86_OP_GROUP0(0FB8),
     /* decoded as modrm, which is visible as a difference between page fault and #UD */
-- 
2.52.0


