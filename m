Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1303D25931
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXy-0000ph-4A; Tue, 27 Jan 2026 04:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXq-0000i2-Hu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXp-0008VI-1s
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmJHKE5I0YRv95DN3YUVgWqrtxbewl3V2/cW1lBk0+U=;
 b=eqB+Cev38o83kW136afzq2gxjQjNRugjYdx0DjQnZKD6SRnQezz19ATNfHz1YjzTcqriU/
 gSt7awTSeIb1SRWoknlg/MRHn25WDdQC/oFVxutwBxRP7Js/KVQTwuVGfE53whdSCnQuFJ
 kMMeQQ1PM2M266gob4WRrSY8MMQZ44Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-GsaY4VVlOsu4_5itx33LPQ-1; Tue, 27 Jan 2026 04:39:30 -0500
X-MC-Unique: GsaY4VVlOsu4_5itx33LPQ-1
X-Mimecast-MFC-AGG-ID: GsaY4VVlOsu4_5itx33LPQ_1769506769
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47edc79ff28so34167585e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506769; x=1770111569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmJHKE5I0YRv95DN3YUVgWqrtxbewl3V2/cW1lBk0+U=;
 b=fz7IjngYOynoMY6o5X6iyn0R2XD5uTnzyZC+tT/i7+ftF0197/trd2AYcf8ce3wtlY
 +wunysTR6by4a6wxPQQJxNntCNgWZScYV88jD3unKP1f+eYxnCuNNzwlkW3ec3/AsvjM
 dABvG8QI/Lp+Fk3CkxxD8fZO4gUCP7hQTS2+F7OJe13PyoMijZBufZwFAzGPbxiI4S79
 21M8/d8w2xdRiLhWLH0GCspkqirQ2N6lwb7dNUF/gignMzG+TQrgAzyBiQ/amysBVWNR
 D+Zka2A+spKt2dRzYbzPg+I5nH1F08TldP/1YgxMBx/9Vx8kfmDuGy4gc8DRN9TCccpj
 75Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506769; x=1770111569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UmJHKE5I0YRv95DN3YUVgWqrtxbewl3V2/cW1lBk0+U=;
 b=EIJeyicgWjuKU5mjZdLxGvYMe3r1JlPWkam6nuMVlRYgbdBbf5LLsJVsvFlG4fyiq4
 U0bt+IaJScwphORkEaBZk/GLvvp+nnRhcvvQieb2k5RrqPZRhXUNgAoV4R/TNjWJvLvg
 OwPzqgiZPY2AsMDAjnOpE9b1W07eM6JZe3SF+XMgtz+KJFya1zkELnPl1YJTrDl2ca4a
 JY9Zlc4ORz1s47mYDpWTC5gF9PTo1h6xFzoWclK2hOQYZeP/jVXdH0Z8oWU7VdX6Ioqc
 k4HNQq2cFBggUoeZoWBs0pyS8g3cn8hnC/pqUgi4Bv62c2jMjGPfEiuIngrGrncGfLhN
 txjQ==
X-Gm-Message-State: AOJu0YzfUt1RFElup0s2yWQ2p1jWkIR5scTnc7YVgP6pUAdT4/CHt8NN
 WoPcbYosq/P3Kjwtr2/STp44eGqwTKLUyiqqjJuovpknCaHPF73ojdwEMbK0MhTFJXJ1WNctPrm
 tReKBidm/kJR9xzhYhTSFQyyni5ybx8KJCujAg/Se5vuJ7m+OGtLEzZ7rZX60YoFJ0RofZGMKDX
 2SXRHahDOMl/f0FwiqZBdhbgngV7ayJ6eZK1epvwWg
X-Gm-Gg: AZuq6aLk8aWmWc5E7DmH35rRp/ehl5kKy0k8AtbvaJDa55+EF91WHht6+a4LSmOhBzb
 hik83GOEPqrxhgSO85MlCYp9cMYwiKDPqlgNpRH1mHualBshq4y3YuJXRODDL6Cau8eILR3pilm
 Wxwzl9mnCp9+XG2KmIjl5wClnZibqXHfIZHA0Kril8o2WLtYT/84ISCBl2SsxSrkaY9s086ny6B
 Lq6r1wThdbrjBLkyCSf2R3cuCjV2tTVuuAykX5E0lQIEDgglUzTA8RemGxT6qsEmP3mlOijJq+9
 18iON9XSw4lRh4btrkACld/NhGD00N1kzp5i+ZBooQ/xiWamkLeqmWRWB6qGnLKmEhHe3yNlfsL
 iLGnsm54Mb9RHutTYlnHoeUMgwvniKk4p7sZLYrHoGghanfzfdnPSTtj/Htbf6BqGXA70kI+els
 O6OkHUU0tZUkDSWg==
X-Received: by 2002:a05:600c:1992:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-48069c487a1mr13709595e9.19.1769506768829; 
 Tue, 27 Jan 2026 01:39:28 -0800 (PST)
X-Received: by 2002:a05:600c:1992:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-48069c487a1mr13709335e9.19.1769506768360; 
 Tue, 27 Jan 2026 01:39:28 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066beeaf9sm52796025e9.6.2026.01.27.01.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/13] target/i386/tcg: remove dead constants
Date: Tue, 27 Jan 2026 10:39:02 +0100
Message-ID: <20260127093906.353741-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

NB_OP_SIZES has been dead since the conversion to TCG, REG_L_OFFSET
since 2015, the others somewhere in the middle.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 460848e4223..20aa94347b0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -374,30 +374,6 @@ static void gen_update_cc_op(DisasContext *s)
     }
 }
 
-#ifdef TARGET_X86_64
-
-#define NB_OP_SIZES 4
-
-#else /* !TARGET_X86_64 */
-
-#define NB_OP_SIZES 3
-
-#endif /* !TARGET_X86_64 */
-
-#if HOST_BIG_ENDIAN
-#define REG_B_OFFSET (sizeof(target_ulong) - 1)
-#define REG_H_OFFSET (sizeof(target_ulong) - 2)
-#define REG_W_OFFSET (sizeof(target_ulong) - 2)
-#define REG_L_OFFSET (sizeof(target_ulong) - 4)
-#define REG_LH_OFFSET (sizeof(target_ulong) - 8)
-#else
-#define REG_B_OFFSET 0
-#define REG_H_OFFSET 1
-#define REG_W_OFFSET 0
-#define REG_L_OFFSET 0
-#define REG_LH_OFFSET 4
-#endif
-
 /* In instruction encodings for byte register accesses the
  * register number usually indicates "low 8 bits of register N";
  * however there are some special cases where N 4..7 indicates
-- 
2.52.0


