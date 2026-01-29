Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C97D46BED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGt2-0008R2-Qj; Wed, 28 Jan 2026 20:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsw-0008PK-Rv
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:50 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsv-00037H-BK
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:50 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8230c33f477so229552b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650308; x=1770255108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jiteZZFsxsucsTi2GA57zdKipHQ9ataVKeACzlSeVWI=;
 b=zT1c8DyMPz9YMgsNLqzZuwYfcR4sMFxYhSZjGHahpwYxIZr4Wtz6b1/XorqvYpClNY
 EWvRHtG4m93nG3pPOmKOX68f5quyHDw567k5Q57lyV1w1bj2Od4oxqgCdqB6JEC2FGOB
 f8u5nuqZ2c2e/h4MPs7AALn80SSt6qDJpi4zUU/pgY6NfNyoPfyWyAmaVTSXZXothSCn
 xHHqTRr/CbO9XLDggW54GAIB/pBACUDc5+aVEua02s+br1JZwpbBAvdBEyJsQX066UX6
 cY2DLhb0uS9L2wAuYnVgzHqqmeRe3sYXOwHJy8IPkI+NRH9Z7htsA/knWQTvrZXK10Y+
 I5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650308; x=1770255108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jiteZZFsxsucsTi2GA57zdKipHQ9ataVKeACzlSeVWI=;
 b=hdHvT8hQ94QO47A9M8yseEbJ7HC6NLBbueNbuwjGJsodN2CRywPVbj1G9fLsXx/ykK
 i96empbrp3fydNLwASMq7NKI17sWuUOWeSH+cbl/HXy4XerAXjwlxUkYdOTfqkACIJv/
 Pv3Ge+wf8c6LGoEHLuwI3qO65ppMQfGhWSu5B3qNWdQFKNs6zJKxp4SQQFK1bThGAJMd
 SbizZ2KYrA31Q3mfWG0mapIYNmoTJ7j7qkGnhdRvUABywdkFBvFY6hYlFspW0E1gZwQw
 8++GxrWoMx9X7LvBUVN3HRxrrgev60hiUMyOaoH83iV7DXmOifE+bJIDuWnVwi+BMtp1
 bL5A==
X-Gm-Message-State: AOJu0YwfbZuM0WUwDaUSA8RbuCQT11atsxHuYhGIqEAQmP4TfFOL682v
 TyjDJ9QIcDKN9TtcP+n0drpFQcJGbtuGV1sWATAR+/hsGwoirc6BzQ31pnmQ5JFvCqBqVZ4X/OZ
 6vs6X
X-Gm-Gg: AZuq6aK48gekj3cTJFgn6tXXJcnZnVMBQs7t8vXfEf+Euin35bJk0GIjZ2+rKAFyW+6
 uXB6R/b55HdqVq6JKifpKeDs/U0LgADmwfekN0iKUa1CROepBy1jod1uRHUSGIKmpUaLUXHLLuS
 +wKqieJAtjTXR1zN3eK5wb3Kh7FdpMjBJziaNuP72C9eautzArlVjNQePOhyV3KPDdZFvSEvjek
 UOBtRQh5GjQ5S4QztIj6X6QKCIg53bTkrz44tEG7Ar0ZmrX1DxSylbN2jz0sDrq0f1ZvxDIb5Qf
 I4W9Aj5mkBaKw0UtrwU1OdKR353yqFvfr5eb0IdFThJDqD0rxTGA/B5mAXVwqUoGVtCnT/Z4Nv1
 9XR/+zB9nrhgP1XFdWJ0brvbXt+HvVnB2kasFZZqI2q+nf/rT4Ai+vGnIf1FqRi0bvz9T/szYMz
 QwZMgAihOVO6tW+Fx6NSUSTYMnwbTnS+a8hYoTz2x0tQ6cPKaLGpTd9ihn9m2dR3Wp7BcKQ4KZl
 8I=
X-Received: by 2002:a05:6a21:648d:b0:38d:efca:1be3 with SMTP id
 adf61e73a8af0-38ec640a0f0mr6961764637.37.1769650307651; 
 Wed, 28 Jan 2026 17:31:47 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:47 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/20] contrib/plugins/hotblocks: Fix off by one error in
 iteration of sorted blocks
Date: Wed, 28 Jan 2026 17:31:16 -0800
Message-ID: <20260129013134.3956938-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

From: Alex Bradbury <asb@igalia.com>

The logic to iterate over the hottest blocks will never reach the last
item in the list, as it checks `it->next != NULL` before entering the
loop. It's hard to trigger this off-by-one error with the default
limit=20, but it is a bug and is problematic if that default is changed
to something larger.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index d3dd23ed9fa..cf4d6b8c363 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -82,10 +82,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
     if (sorted_counts) {
-        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
-        for (i = 0; i < limit && it->next; i++, it = it->next) {
+        for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
                 report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
-- 
2.47.3


