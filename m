Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C5AFEDA0D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Zrm-0001Bb-TK; Tue, 17 Mar 2026 15:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2Zrh-00018B-O5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:14:07 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2Zre-0006QO-QU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 15:14:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8296dabef74so5758371b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 12:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773774841; x=1774379641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRe1jb+qF67KndVjETTSD3oHNehMbNtN1b2O1KyRmEQ=;
 b=s7OQX6jJHoP9HRi+FQudlAEvi5bv8LcLxDh1uiUa4xiTRuIdyUhgLtiYMZzW/Jyire
 VnYctlGm4MLHCq3OU6TvtwgqsJqqCHJC2PTVL3Z1ts5xa2pFWtZNULMVf1P6dR8nEQnc
 uLCMxc5HOSaZWxkuyrM6RNp5zDBWZM18ad046Xd4ybi5AGJewNp65gjpqP+jlS6bEkZs
 WZ7VbfgsEHKLxoaVJngccTExNZHKO/grtH0Oc3yR6vKN5dpu6OzGFVymC9HBJCvgASb6
 tO6/Ldp4obL9sZgH2CBjDLBVBi0xTPSfnVdmVej4fW+Y7oVX95Hggc4N2zaGohWv+ygf
 pXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773774841; x=1774379641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRe1jb+qF67KndVjETTSD3oHNehMbNtN1b2O1KyRmEQ=;
 b=jdMsmesBX5CzFcBTCw7GFuX0CXbn/6XhMTeHyGx2O23vKrTC1tfavnxL9DjQWAsCJr
 947VugCUOemTa1OfnGqMcFgSzRkmtWWnDqc0CQ79IpGiT3SuMLNjwD1pih+C8CIdeGdq
 imZLSgzpCUrtwF13QBhLidFLZs3zGTaeE4SWIKho+0mEKFpDXrOodk6BRUNokmvl2Brp
 eMY9o9Lj8Jz7qt9bPBHFih29t3bHWSrxdazhwwPOYUNAM2GTcFbnSMZvWev+4l2QRJwe
 qypY5JFzgMW1gIGUyPIDwHOKy2ek6qol6klgFlpKLlo95enGEGFMhdKfX6uy2JVw3XU1
 71qg==
X-Gm-Message-State: AOJu0YzUj0BPhjsFzx5hD7Cx+YmGcPvQm/qxdYea+kMQ4ElIul697Cwd
 WuNywvwzc3UpZVg0rih7Udk1MYdD80F7hNBrkdiTang3lN1BCnIyHDLgZ0a8KauYwDjGZH6SlaO
 FUmJlpO0=
X-Gm-Gg: ATEYQzzpN9ML9i5t/JBDHdHd5j7UB+dvds7LKqyQtO3p7Hb0X/lR2rPIzYfvlUPlMUT
 So0nLS+JFPVMJULlpOYxirhdKCWrfeoZ8UOh18YOMaqJKxqiDxVFlau+qHleRrIkoFMYMVGs64O
 Vnjj6EOoU8mUZY+0rgzBM50RfPctjxPe9jjOe+VK0W9gD6fy948S4DYZqWQMoOroyOmlm0dMANQ
 LiNXoIUqdEg4tqDvwUkJ823DxLmV1i+FNoos3dOGjBxI73IhtuSOKFov7Bdsq7QfbeJAZRM9fSl
 T8rD9husQUHJOWlCbdWK1f4rUrAG/lZLESkO0P3NYEbXEIkPf1PqAcSs/hEXK0pTeD+1NNTxslS
 1j6wWwQnVnYQjAaEfoa7k/+yW3K3qs/i8zP+ID3jt1oDArKOpPgzGHsy1NKNLoB8lVEPacMxaDA
 nPJNW/UN/XdLjf78jV9CKcnwF+hnRnbrc+q6CfQGV7CqLeQxZ5lf4B0sF+2oxUdgspp6ph2Brhc
 1pTuUkYa7Y3+cc=
X-Received: by 2002:a05:6a00:1903:b0:829:af4a:5eb5 with SMTP id
 d2e1a72fcca58-82a6ac7a455mr484227b3a.3.1773774841379; 
 Tue, 17 Mar 2026 12:14:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6b56de44sm217490b3a.19.2026.03.17.12.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:14:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/1] plugins/api-system: Handle migrate_add_blocker() failure
Date: Tue, 17 Mar 2026 12:13:56 -0700
Message-ID: <20260317191356.844712-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317191356.844712-1-pierrick.bouvier@linaro.org>
References: <20260317191356.844712-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Trieu Huynh <vikingtc4@gmail.com>

migrate_add_blocker() can fail (e.g. if migration is already in
progress), in which case it returns a negative value and populates
its errp argument with the reason.

The previous code ignored the return value. Pass &error_fatal so
that on failure QEMU exits cleanly with an informative error message
rather than continuing in an inconsistent state.

Resolves: CID 1645470
Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260317134733.126584-1-vikingtc4@gmail.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/api-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api-system.c b/plugins/api-system.c
index 9a70b9caa6c..fbf905cd63e 100644
--- a/plugins/api-system.c
+++ b/plugins/api-system.c
@@ -108,7 +108,7 @@ const void *qemu_plugin_request_time_control(void)
         has_control = true;
         error_setg(&migration_blocker,
                    "TCG plugin time control does not support migration");
-        migrate_add_blocker(&migration_blocker, NULL);
+        migrate_add_blocker(&migration_blocker, &error_fatal);
         return &has_control;
     }
     return NULL;
-- 
2.47.3


