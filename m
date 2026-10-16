Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0758FCCA490
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlGf-00084q-QO; Fri, 16 Oct 2026 12:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xHlGV-00082S-Qz
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:58:45 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xHlGT-0005ju-No
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:58:43 -0400
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B0AB93F28F
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792169918;
 bh=kJmMc1isr6JqKVmGnKacr5dqB9sK1nWZcd15GvDcKN8=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
 In-Reply-To:To:Cc;
 b=RBHHoCLyGPPKon0PPgF5y9e7WShel0BSA2+oGZOrDvxSk8MFME92lOVNksW6VCpYK
 s1DPmdJtQOzBByOlkjYYtnhvO0Ckzf6JvBeVFgfdKgDayzp/u2ylDXj9e5btU4TBJG
 GlJPDeNjlVOpdnQko+3VKhYQj0cpiHTjBeMVVyrBeI4weTbyDl+lOb4cojM0GV2J29
 y/be+cYg3mXE7DkaeKA30VJ/qCrOLe2lqy6Ql0kGPQ5HzRXkBPBaiYV5mpQqWu0EXE
 RQJufmDR8PfHi3mZGzHQArBQIynE/WT/UNyri9dtqNxT7xub1FQUE+nF16wePNcXdd
 i+IW7q6GvmxzqOeyL9q6IJba7AwaELE+VVO1M4bz7gAikAAAsQ6Uk33kFjK/RhDhWp
 NMmNuq3YLztI3grX8Q7tjhb/mi9XwWTbzBgk3kI1Q+OURpwa5j4gfaNNBo/o79136n
 8HUJkH1usnAVd2INOXzQdX+b79dh5EMTTdOlb3FJQsNZDxBPV7g7at8ez/gIWK1gdZ
 mrKYQ3G4nY+4Dffd8fbnvwQEnjAdrce3VgAHiSsGqGy3nmOs2DEMbeBqxHHa5zTRxp
 mL1GxTxJKVc3cSTGLL5t9FqZDMTnDnvoG6Yg9RpeBLQWCllUyYAQ25zmJqT7uqYyk9
 bSfY2R8VuTLsMxQg/jEPLcs0=
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-879b1d03d5fso1512637b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792169917; x=1792774717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kJmMc1isr6JqKVmGnKacr5dqB9sK1nWZcd15GvDcKN8=;
 b=OLsoIiyxSZwLfkhhWSxR+Oe6KTdOGbSFH1RfLKcsvDIKEXgRRj1BK+oWiGys3Xy9mt
 p/JBwElpAZhilfj4Y3Bna9LddbbLm/6q/a0fHK1IBSriKa1C4ULt7UWa13vJ6jVsIZpC
 3YnHMCMyTsJ/KZZK97WYeVjmWFhwFihXWGMDLf0vR5ioEUvAzsZd+Gryncu3KnQqkpTP
 kySw1Mb95SATGurqYTm7rOKxVgnqgdDeJws/U5tSERV6RYya77eLJACKiMZx/i2KoKeq
 uVhl+PSX8cOf5Ujwwa6rfxtFHrshplzlXs5xPFQs1Mj9nkfe6L3DAPRYGe07fbpEsTk8
 XuKA==
X-Gm-Message-State: AFq9FYIg/BMgtmz9EWIekRm/vxgRC0jHki9eTb05FXYgauGowhRAZFxZ
 scX3il57Z/1mEd/GTwdLRGV7yABdPrEsUtDD2jk7rENZjxEGvOU2E/Sk6sqvpvuJkMTAHVDCmue
 /7jPwNSzb6HrMkAGoyobFnqb2Qjn2wYghQXwrVMISmDgnSRxYuyMk7zNoZNZDMnIj4E0wHffn
X-Gm-Gg: AYBFou3y4/OqXkZseZsXucI/TpXXVDzKvbh54PBsruXZgxKjkgbhqCrCoCyQIWfI3Fh
 W+HIslMfFhLxxkOe04C0S/sOReHxxmtsZ1cUQ9LL9umax62TeG22En8XjpxXzJIj0u4pP1NBC+j
 k/gV1ProrIKYPeJVD4obQ8ER0xOoD9B/3ZjBLibOBmm517IDnw7RT7njCMCeXqxVplO3B3Iy4bK
 8yXV+WfNb/xlluIoUEhZuFb486hUqwhlWEuePk0o9ImohHvpeCLEv9yubPZ+1K2nScLFP5eerrB
 7pwcWVmyUhmGiMe9g0OpIJSTC6RzDx3FE4PvjMWThs64DvqRhocztqch61fk3coeZqKhL1zIGM7
 0FKAcWsC+hQCNERiLCUmoJcfbOWu70wOgCQcYCf3bmuVVYYw9mxcrqQ==
X-Received: by 2002:a05:690c:7107:b0:8b0:e10d:1971 with SMTP id
 00721157ae682-8b0f205669bmr2407547b3.6.1792169917608; 
 Fri, 16 Oct 2026 09:58:37 -0700 (PDT)
X-Received: by 2002:a05:690c:7107:b0:8b0:e10d:1971 with SMTP id
 00721157ae682-8b0f205669bmr2407467b3.6.1792169917127; 
 Fri, 16 Oct 2026 09:58:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:6c45:3000:1420:26da:25ea:7a28:6e4d])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b0e58ad1b4sm12193167b3.18.2026.10.16.09.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:58:36 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Fri, 16 Oct 2026 11:57:51 -0500
Subject: [PATCH v5 1/2] util/coroutine: trim sysctl's max_map_count newline
 before parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-set-default-pool-size-v5-1-719e9e4d3f9c@canonical.com>
References: <20261016-set-default-pool-size-v5-0-719e9e4d3f9c@canonical.com>
In-Reply-To: <20261016-set-default-pool-size-v5-0-719e9e4d3f9c@canonical.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hector Cao <hector.cao@canonical.com>, 
 =?utf-8?q?Alex_Ram=C3=ADrez?= <alex.ramirez@canonical.com>, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=b86ZQcF9Hg5f4iMTF56xzgWjaMTuxnTtIpZIS+Pz1NM=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBq0le5itqR6q4DESuN2V8n218GC5ntnhKGe1o1G
 0v39rOfBdSJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCatJXuQAKCRD5KICs4jod
 uZROC/9Q1m3zjdknM2Mpk7+aMciG6xy8IgODifZAi4UmBaNC0hzzTw3Lm40WGbUyiXZaXrsTUYu
 1u1518n99dnHdUxlVOuJxbI698q1vr6ZkO8MwdvyzN6yhza9mB47vY7EyQDoeb8fhiuN0c/Ep/S
 2nKZ4aUAWeq4L40bCXqXCkORDDTrwyztToLXP5b/Tzvs3FQ7+yF9la7kY75QSYX4f0gRT8AoSuL
 HWUiPNxSLchSUVsFk4o4wZh4qcaAsGKfAWHSQxyvPv7wGHE6h5rtfzDn73XP+avpf5jiqH5NuVS
 gfildsykd+MTN5jMD8piPCH5kUjlkY6KKhM+NCFBjWcVFeUJ/raGkTv1AtjEq8WKBqCjmdIYstK
 g9HmEFI2gMofzLyuTIgOdDp8TxdR4exjepV58mN4pcV93iy37yJfkcdw+ZDzpdGtgTKuKLPwgTZ
 3Bl/jwIBrnM6Dea+scZy3yWF0Vw8LHHMNiHaN6N9zIbr9VBWaKNheCUGQbwB9By1o1VA4=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Hector Cao <hector.cao@canonical.com>

Strip trailing whitespace from max_map_count before passing it to
qemu_strtoi(), allowing the strict full-string parse to succeed.
Otherwise, qemu_strtoi() fails to parse the string and returns -22,
making the global cache pool cap size set to UINT_MAX.

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Hector Cao <hector.cao@canonical.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 util/qemu-coroutine.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d17135f585a..5af61995437 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -374,8 +374,12 @@ static unsigned int get_global_pool_hard_max_size(void)
      * VMAs.
      */
     if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
-                            NULL) &&
-        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
+                            NULL)) {
+        /* contents has trailing newline, remove it before conversion */
+        g_strchomp(contents);
+        if (qemu_strtoi(contents, NULL, 10, &max_map_count) != 0) {
+            return UINT_MAX;
+        }
         /*
          * This is an upper bound that avoids exceeding max_map_count. Leave a
          * fixed amount for non-coroutine users like library dependencies,

-- 
2.53.0


