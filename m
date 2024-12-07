Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E85E7717D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 21:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tK2do-0000Ju-M6; Sat, 07 Dec 2024 16:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tK2dm-0000Jc-N1
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 16:47:06 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tK2dk-0004cc-Oq
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 16:47:06 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71d4032b3e9so2214608a34.1
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2024 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733608023; x=1734212823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LcEsBkOR0IXFp+TmHIgG4yNI7CI4TTQsI2n7XV4yepw=;
 b=G3oDklOzKWqZ22xKGxs4rnPkZnP6e+crCxOMHO33ZCkUWWTqs5dFyYJYs3uqRQXckt
 OrlM/nLy8XEcBwvh3k0a8KHoXAF6mwPS9toI76Yk0OUMt84N4uUF+M3tCnGNeHHomCHV
 SgWPNbCByvbzgzcy6aNcvz+q1DpBFGRTy7TdHbuHlMrdgxRtwj+eLZFtf769CNg6RO/a
 caPj433rLynsvxy3f5wwsFDy3LcwkdRG6oLO/8DeH+Wal9Iwr6dj+N4kBLX+1frHk8eC
 lAVNEIFBlJSg4ZUProslHF+uHmDC968acsr9dcp2yI5CeMeY9WDYISYau35+m5ZJzf6y
 td5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733608023; x=1734212823;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LcEsBkOR0IXFp+TmHIgG4yNI7CI4TTQsI2n7XV4yepw=;
 b=toetXMVAXcPl9rhRdx77dWgcR0ZRr2o8wC6p2iIKHFqtOo6qtgZwh7pI+Eb9lec7as
 FtMoUEX59RW10errJewYMM7tR86Xuzq5HMZp9cuIsxrf2QL3p3fR2jFMdWRYOpoHNRO8
 Cqmm8WJFTt4KuduW2eibNXhWsqaTwnKlJfnn+ehGZQy0BF4fVvAjyByVM5P49veVrrYc
 himHIufuSDeOy8osKVIxHoY5CKZ5pKdvuH3AXe49u/XHHMLAM/auuvHJqpjVRhnuum3g
 NHiQ79ymtXGDrdCeuOP8pyzCYpeE1xe8DQxojuqDNERJQonEPRlqAl5sImC/s3ftxZ7M
 KpGw==
X-Gm-Message-State: AOJu0YxwlZuXVqfd8hPb+4bbBNXpxJvolcMWDt8tfVxbUUzOdAKOpULW
 K7OFjEZEDzq+dRAK/zBTazvopg+gmx5WdlTPx5hEWLcd7SwJWF7UnhuLWYNLxUi/Zo6Bwtc9J0K
 ToXnHh87q
X-Gm-Gg: ASbGncte3vZSKpIqhKQa153LOHsaKUfksL6KtjdOAxoUBOC00KFPsFpSbxswyy7EpT6
 1ol+U5VNN9Ml3bAtBUOA2vfxjbsUDI+TiedV5TX4qNjaYoEXKdq+C2IzcvC5Pwbf3ffU9HXeoLK
 WkX1oAEzt53RyLluadgGNP4Zke2FLE6eiZJcx2Otrg+8YM9LVwZHEjFzGEFFXiLEZTF3eQ85X/T
 tdRpwoDMOcVKRGXdV8uRI1bHD+qGTa9Fqk9KK+t+LwCSfnLuKF+yVrOjZ4r+IOff/C21iKok5rO
 qrjRl7/OaJxhlKUu5oEIA2Yo8AuLXgJalWFk
X-Google-Smtp-Source: AGHT+IE/xxtJ/2+NG+6M2w+dCtx/4x4sNP/FV3j96IxUzTVs5LHHcpXMF5bS73M+53EqdOdzUckTpw==
X-Received: by 2002:a05:6870:971f:b0:29d:c9f6:efdc with SMTP id
 586e51a60fabf-29f71ec8744mr4092700fac.17.1733608023297; 
 Sat, 07 Dec 2024 13:47:03 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29fbee2df31sm10110fac.13.2024.12.07.13.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 13:47:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 wannacu <wannacu2049@gmail.com>
Subject: [PATCH] tcg: Reset free_temps before tcg_optimize
Date: Sat,  7 Dec 2024 15:47:00 -0600
Message-ID: <20241207214700.211066-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

When allocating new temps during tcg_optmize, do not re-use
any EBB temps that were used within the TB.  We do not have
any idea what span of the TB in which the temp was live.

Cc: qemu-stable@nongnu.org
Fixes: fb04ab7ddd8 ("tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2711
Reported-by: wannacu <wannacu2049@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Unless there's some other reason to spin an -rc4, this can wait
to be the first patch for 10.0.1.

r~

---
 tcg/tcg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0babae1b88..eece825e2e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -6120,6 +6120,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     }
 #endif
 
+    /* Do not reuse any EBB that may be allocated within the TB. */
+    memset(s->free_temps, 0, sizeof(s->free_temps));
+
     tcg_optimize(s);
 
     reachable_code_pass(s);
-- 
2.43.0


