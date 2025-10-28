Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77061CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeJ-00084Q-8x; Tue, 28 Oct 2025 12:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDme6-00081a-MX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDme2-0003UT-EY
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9SKZtrOmHUmq+rD18X1HIMI/6NZVlZ/S6570rCbBKQA=;
 b=Crk841O+CUUZU1ED8GZh77SkK1OGzob/jj4mwIJ2Fa0OUZQhLFgk1aYDf6fNJukF1jklrQ
 X3tPHhVCz4UbORXoa7Jp56tNsAlraUwO/my/mrgk15E1JHYUypTIe5QZ5eXXK6PIHHbS1O
 +b5gmkks45H8pFbpjF6Pm/LNpd7z0VI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-4ofXVH8bNFOxrrKJTt_r7g-1; Tue, 28 Oct 2025 12:33:54 -0400
X-MC-Unique: 4ofXVH8bNFOxrrKJTt_r7g-1
X-Mimecast-MFC-AGG-ID: 4ofXVH8bNFOxrrKJTt_r7g_1761669233
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-475dca91610so17512285e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669233; x=1762274033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SKZtrOmHUmq+rD18X1HIMI/6NZVlZ/S6570rCbBKQA=;
 b=NYr2k0ppAiZoDB9VjJBR8+ERkcv/KnzSdMO1TFwHNQHg48d4qKGSLnTPEmmB59XnBr
 roah75D6APpU0fLy4605OFkkfRqj+DeqQW/HDDEBBVhz6ofxergASGhpAvu16obg+TIV
 i8C8MhGBz2Zotr5FlDynHaEQMQxWeUPbbA3FUwsjeDkV9f8o1CdKu6cglVyIjJYq2HGw
 8OscAIillFXJBxzgkK+ONpokfXOrqLFlwcqaEQT6HVkFpJ+svbo7m92frygtb8j03SCq
 PDC3UDXZDYTL0md06F+er1stukV0xFgIJwrxHPpH7K7rHSVZCCXJMuiJ8HZP9wpSbJL6
 561A==
X-Gm-Message-State: AOJu0Yy+7J/o4ZIFPljFkyZZUf6WJF8dGvyITkvemThBgIE/905QN2Rm
 KkPhvTblSw2oXEyXXu6gq8bTM0XbUuUoRUVStIbNTckWXqPTuOVTVMDZia3VNvD4CPQxDj+Fq+N
 H3NDkb5CYnYJB3T+0JRGeavc5bmkvZKN7VJav8L0aIdjWianb25fng0pF
X-Gm-Gg: ASbGncvnEgI2eDU9I8jp0Hzkh/S0A3xkQIrYH5wNyHlSaDzwm5vOaFG1jUbAWg5bPDI
 kR7FQrzGWssERo6XwSreVQcZbdD/RvFaXi5xh2Yrmen/+UBlqC9lDXjJdOMizeJFHv2qMXLLvWu
 HKNRBiSuthzJCNfxUIU9hpFfwCP2Dku5a/P0qpJtHBL5Qcmk4c4/vz6EVqfDzCY+21rHvUiIWGK
 YwD3X8fhQ1SS8SIKK/JZp/SHP8aVL0baErR5kL9F+ElwNh0lFDAX4QEv/GeD6xr4qwPFPm+sgHM
 FuqtJ//a006O2796P1ZDAKiFhm+Jlu0RdTYmRSTDNTi4/B6wu0RwTubskCQxayBm3WVpQMro3Vf
 FBVJCOCUyc0yf7a5LkMexlRoPXM6DMdglYQ9xYNV7PyhijAOPzCTVdFlG/A==
X-Received: by 2002:a05:600c:3f14:b0:46f:d897:516f with SMTP id
 5b1f17b1804b1-4771e24b039mr751615e9.34.1761669232937; 
 Tue, 28 Oct 2025 09:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkXhoh1BxDXlbv5TlueEMZkpM22xzWPrU6xjTbl5Bc0pa7ufOWQvlFUxOcXxDJ3H2us+jIbw==
X-Received: by 2002:a05:600c:3f14:b0:46f:d897:516f with SMTP id
 5b1f17b1804b1-4771e24b039mr751195e9.34.1761669232499; 
 Tue, 28 Oct 2025 09:33:52 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47719004d79sm22970895e9.5.2025.10.28.09.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:33:51 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 01/16] block: Note on aio_co_wake use if not yet yielding
Date: Tue, 28 Oct 2025 17:33:27 +0100
Message-ID: <20251028163343.116249-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

aio_co_wake() is generally safe to call regardless of whether the
coroutine is already yielding or not.  If it is not yet yielding, it
will be scheduled to run when it does yield.

Caveats:
- The caller must be independent of the coroutine (to ensure the
  coroutine must be yielding if both are in the same AioContext), i.e.
  must not be the same coroutine
- The coroutine must yield at some point

Make note of this so callers can reason that their use is safe.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/aio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index 99ff48420b..6ed97f0a4c 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -650,6 +650,21 @@ void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx);
  * aio_co_wake may be executed either in coroutine or non-coroutine
  * context.  The coroutine must not be entered by anyone else while
  * aio_co_wake() is active.
+ *
+ * If `co`'s AioContext differs from the current AioContext, this will call
+ * aio_co_schedule(), which makes this safe to use even when `co` has not
+ * yielded yet.  In such a case, it will be entered once it yields.
+ *
+ * In contrast, if `co`'s AioContext is equal to the current one, it is
+ * required for `co` to currently be yielding.  This is generally the case
+ * if the caller is not in `co` (i.e. invoked by `co`), because the only
+ * other way for the caller to be running then is for `co` to currently be
+ * yielding.
+ *
+ * Therefore, if there is no way for the caller to be invoked/entered by
+ * `co`, it is generally safe to call this regardless of whether `co` is
+ * known to already be yielding or not -- it only has to yield at some
+ * point.
  */
 void aio_co_wake(Coroutine *co);
 
-- 
2.51.0


