Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C41E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLO-0002aB-OG; Wed, 18 Dec 2024 08:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKt-0001gK-0K
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:36 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKm-0005ir-EV
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:34 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eba347aa6fso3483101b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529407; x=1735134207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+XQR0giWaYJSQ3hwaZ65nOMJP3BUJ/58MIcg1IC9xY=;
 b=B/1pA3WmqsXM9daOkjFBtIat+CNsfvJ3kHamieKoz8ylCR10RC1RqgV9OvQgpYJr0s
 +TOCuAmcR3UmNYN4d/hEHXT+Ua5gwmFf/1Rz98UP0Ta+tsJKcmlA7gfmxuZP9bDP67Ry
 djRtEwzG8kVX29XUIe/PwkxjNi+EULbLGDQzsGJjvvON5hvVFom3N1vrugoCWrR3PL5K
 1MgxOh9uVjJvCPfyPChFVa9t6mpTIT3yLBCMQH5jZOxaS/bbJZGB5Upxa8b9guf9UIR2
 V/kO03Fn4dtLtqCS5Xr4Bg9ThJHmDSm9rI262b+k4IjTxnRVl/PQItK1EJaoFJt+7jZM
 KRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529407; x=1735134207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+XQR0giWaYJSQ3hwaZ65nOMJP3BUJ/58MIcg1IC9xY=;
 b=Yw4oENVPA2+hnPQ2akVxcwatklX0YL8ygoYNST3xlMmIj8fkTc1LhmTe1/NJLquruh
 +GeEfIQfVi/l1vKSTito9snlMpux6soxUmwjH5zRgFwMcqjeSd8H7jGy7gg7AmoRdBT+
 uFTeEGhdNCsPwH4ESGxO9TkRChRboXHd7M7H+LdcgyXKWUvlsymSPx+ojLceaEyVDsOt
 6E5P0E6qIP5s75EiX3/eyYORsP2flzrlvm5fuGv9PuAjlAbDBg3tyCXxtDjayZQ/Oyzw
 Fca4a3ThODuLnlSb2O5uA1cgD62i1bhSrHTJXr8pUL04Uf7HaEnnzyQ2QTc0+/xis1o4
 8RZw==
X-Gm-Message-State: AOJu0YxMPZ5+lTSjixZk26SKs+pZeX9zS0a/ps2hb8xAb9mRjSdGADnR
 5NS5ExOmiwh+Ju6PM8purD/3KdRx8z0TByTheGWU1lx+YsOGax5eKeWsKIBnofZFMJXqgFI2e/y
 EhkdC69KY
X-Gm-Gg: ASbGnctOouQXVwHXe1ehEioDyRvl2Tap7TRMT+OBu9rOo2uDvTInWTDEFDX0ZCNAcbi
 Lie1LZdiqwVcErcucwFhi59KFD0lG4IhCKA4/0onQpJZMRaW4MaV3vXSCLoBKmAHuLOrK+yAD1X
 6lvoMESUEwRW6g4oLH671G5gv+3juI3MRTcivglHMYiTqG+KwvFOHED2kn4/2GjuVL+vth8GHrR
 CdFIIJazV2z2EeoF1ei+yBHHE+n+XR7/pYPTixUaASRx96796QzG4sns0FP19YJ
X-Google-Smtp-Source: AGHT+IEgd5Vkii3xLVWXgEX02vJ/rkpXpt9mDR2B9Dufp35XOJIaJPt2HICss/RBUI8sTvRnmOCPJg==
X-Received: by 2002:a05:6808:2394:b0:3eb:66a1:9da3 with SMTP id
 5614622812f47-3eccbf5a8a1mr1473415b6e.18.1734529407384; 
 Wed, 18 Dec 2024 05:43:27 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 21/24] include/hw/qdev-properties: Shrink struct Property
Date: Wed, 18 Dec 2024 07:42:48 -0600
Message-ID: <20241218134251.4724-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Before, via pahole:

arm32, a 32-bit host which aligns uint64_t:

struct Property {
        const char  *              name;                 /*     0     4 */
        const PropertyInfo  *      info;                 /*     4     4 */
        ptrdiff_t                  offset;               /*     8     4 */
        uint8_t                    bitnr;                /*    12     1 */
        /* XXX 3 bytes hole, try to pack */
        uint64_t                   bitmask;              /*    16     8 */
        _Bool                      set_default;          /*    24     1 */
        /* XXX 7 bytes hole, try to pack */
        union {
                int64_t            i;                    /*    32     8 */
                uint64_t           u;                    /*    32     8 */
        } defval;                                        /*    32     8 */
        int                        arrayoffset;          /*    40     4 */
        const PropertyInfo  *      arrayinfo;            /*    44     4 */
        int                        arrayfieldsize;       /*    48     4 */
        const char  *              link_type;            /*    52     4 */
        /* size: 56, cachelines: 1, members: 11 */
        /* sum members: 46, holes: 2, sum holes: 10 */
};

arm64, an arbitrary 64-bit host:

struct Property {
        const char  *              name;                 /*     0     8 */
        const PropertyInfo  *      info;                 /*     8     8 */
        ptrdiff_t                  offset;               /*    16     8 */
        uint8_t                    bitnr;                /*    24     1 */
        /* XXX 7 bytes hole, try to pack */
        uint64_t                   bitmask;              /*    32     8 */
        _Bool                      set_default;          /*    40     1 */
        /* XXX 7 bytes hole, try to pack */
        union {
                int64_t            i;                    /*    48     8 */
                uint64_t           u;                    /*    48     8 */
        } defval;                                        /*    48     8 */
        int                        arrayoffset;          /*    56     4 */
        /* XXX 4 bytes hole, try to pack */
        const PropertyInfo  *      arrayinfo;            /*    64     8 */
        int                        arrayfieldsize;       /*    72     4 */
        /* XXX 4 bytes hole, try to pack */
        const char  *              link_type;            /*    80     8 */
        /* size: 88, cachelines: 2, members: 11 */
        /* sum members: 66, holes: 4, sum holes: 22 */
};

Afterward there are no holes in either structure.
For arm32, size 48, padding 2, saved 8 bytes.
For arm64, size 72, padding 6, saved 16 bytes.

Saves 20k from qemu-system-aarch64 on a 64-bit host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-properties.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index ef3fd7b4ae..3680cd239f 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -16,17 +16,17 @@ struct Property {
     const char   *name;
     const PropertyInfo *info;
     ptrdiff_t    offset;
-    uint8_t      bitnr;
+    const char   *link_type;
     uint64_t     bitmask;
-    bool         set_default;
     union {
         int64_t i;
         uint64_t u;
     } defval;
-    int          arrayoffset;
     const PropertyInfo *arrayinfo;
+    int          arrayoffset;
     int          arrayfieldsize;
-    const char   *link_type;
+    uint8_t      bitnr;
+    bool         set_default;
 };
 
 struct PropertyInfo {
-- 
2.43.0


