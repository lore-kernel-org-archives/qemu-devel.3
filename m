Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4E0CC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGdhC-0002nU-NU; Tue, 13 Oct 2026 10:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGdhA-0002mN-MO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:41:36 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1xGdh6-00054f-QL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 10:41:36 -0400
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0ECD43F322
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791902489;
 bh=EiqXMx+5vmVrSmhqWg8T7XpKjJdtdeomDx6RLsg6SiQ=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc;
 b=dIG3BIZlhazGGaYpPhzmbrHS1nQi33ycK5yUO3KTfutKmUNak1GvZtbtodGPRy94P
 NYIjliB3chwvQkH3AbysBffijpJ0Q6ESyup2wVSg+QCgRKoKXNgP5n0jN22pM5hnCD
 V9vBbTXZ6IQuGD9hZV8m+KsU2D0o4le7Fsu3v2AxfIrVlvsnJDA5Xk1W8l4Nlf0jUQ
 pxhGqXBO1glI87SwV4NzjGM6UCosAyU60JilhAbcPhwlDlBsuP6DC84ImoNQcxRoyA
 b3HfIZy63opDkWDM+i/xL3rS5jJ+V5Cb3xY6lRc3AIjISEoXwQpG2KT9GpjJn7k27r
 0eBji/DfORLzPQibREF9DEaWD9SXwZK/gsIafLs1UOpr0VQhAZUaahTHFv9tFTzNPL
 0jHtli2DCgsdejQpLPHbsq/28p8o6resOHju83z3kw2keVAfvnwho4FzBpfzyDymHM
 kwB52E8hoNmq/ugpUmKaA2GemP/dlfe15LtRQVaYCjc/gYvOciJePYdHqogT0B5aWg
 6uWYAwbtOcjIyREZO1/kqBut2iroZlW4Ajzn1ggdHGj4YWRh7ETajVtSoMjlU0XfxG
 nPLkWpB3V9y6GB2WfUecb/m5uBJp0vzQMD1pUnzW8UTx4GacdhSQRh8lhEaIi9vEDQ
 YTRku+X9ygwkO+eHbDRyaY6I=
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-869553205a7so32067357b3.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 07:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791902488; x=1792507288;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EiqXMx+5vmVrSmhqWg8T7XpKjJdtdeomDx6RLsg6SiQ=;
 b=H+l23E8L7R/q2eUwmdJNXOIeMLmqtEAIcqxlIExL4tfc47aYkaZF+8rYRYTlR5t74K
 1u9awn9DraQkH47ifl4y3Bqz8gDwzbVmtzSV5JhotK0j07xvkx0Rd4zAHJkD8EqNM5xX
 /0l59Sr1Ac/SoBF1JO8ZG4eaz7QgOwOibGIKR+lz8IPoPZK4IBfW98hTbu/xTUNvsz51
 hu72COHQxsEM2zNqtJaKV6Kn+TtjTzp598RAtlR9g1cAuBWvUxCzjPZAsqfLqnnACuix
 FqIncStuxS4NzflOGV50/vB4hLiSdVe3B/Ufr3CE3efbc2BeyiH7WC33E982sUqM4JOr
 jCMw==
X-Gm-Message-State: AFq9FYL33VbWYO7e5LHTyZpeSn3ZlCedamY2ROc6FaN7yzE5oltmM/xO
 X7FqX/0jn2vxQQ9i0udxefP6VE8znYr0q6ikamuVdBrYTvkLEJxtiC5o9pqcBQ8CfyOW4ch1ZD+
 tKbA7zBg30vEpQTpKpMZMWqnZQtZpbbKgBYD/5JMHD7TkP7R14rOk53LOnrP3u3EkStggBmeq
X-Gm-Gg: AYBFou11xipj6uy6ewwVGoZ0kCM9mkg7Ox1VH1jTleQ+0fivD5Lcmw1RsgpCeW9zcpx
 99Q9vudGrKqJYBg5l0wA4q5phv068SlCPJhuxJk4QQutEePn2iT27KXJ1KM1jw2xw2CDHmjlto+
 9AjEKSTA7UtxQpOgNmoqdQrqQRCwRF/tn+troGHAE0VcJpXjikCHaznAZ9wcqtRIeIr4YtDIp/7
 NyanmL4B3moF01RpoADrMrET0ph6IJ6mbmnwfYqRCKh37QuzNCjYC3q7S2+TIIbX0ds9Sq0eYc9
 JOYoWM0jG8MHvXZ2t/zNQXA4FSFVnj2DPIiJPbeSnG9/M8yrSJXOZUM25sjeNtxdzMqDOZWIEk1
 AoYUJHL1UigPj9NFD8HLKVziogqva905O2vW93DYwMOrLhw==
X-Received: by 2002:a05:690c:c505:b0:8b0:a957:80bc with SMTP id
 00721157ae682-8b0a9578579mr21247407b3.40.1791902487802; 
 Tue, 13 Oct 2026 07:41:27 -0700 (PDT)
X-Received: by 2002:a05:690c:c505:b0:8b0:a957:80bc with SMTP id
 00721157ae682-8b0a9578579mr21247207b3.40.1791902487021; 
 Tue, 13 Oct 2026 07:41:27 -0700 (PDT)
Received: from [127.0.1.1] ([97.87.60.46]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b07f253280sm45691237b3.36.2026.10.13.07.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:41:26 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 13 Oct 2026 09:38:32 -0500
Subject: [PATCH] util/coroutine: Reduce default idle pool max size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-set-default-pool-size-v1-1-7be19402af6c@canonical.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrB1IIrTiVcRFjH/qgBjJqEjFu
 zd0+S3eu0mRBUpddVPGKSppLbB1RWH26wcsUzE5417W2IYVO0+I/lh23lJaWOULbkf3DiYG36K
 h0m4ZUa7/tx+e5wcxE9YaZwAAAA==
X-Change-ID: 20261013-set-default-pool-size-8b27c0fca8e3
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 hector.cao@canonical.com, alex.ramirez@canonical.com, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=XrDMtgYiFPJqQ0sUJgCPBGtaq2fKwgfCo+3KwugEWhg=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBqzkMVgbkH9umYHSflTFlb94eNdzRVI1nuU7XhC
 RLoMTX6MheJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCas5DFQAKCRD5KICs4jod
 uWBDC/4kRI1DpVTmNVbBbb964j4Ls2YN1UijxyQSVXULtm/diAa0qTHDC5nRgmdaxt4naRlJ4NY
 GPJJrBXXl483mcMD0fU4fZjPkOKmmTW3eJxu0baVuPGFG2fwNrKOqaxmzf2Lzzqfh2uberzpFM6
 q1nmiN3g8QhJtfQhMAJAeMsXcfFW8MlCqdJoLyQIPSJUGtkMI317pgsLNd44Yzp83yLpTIXDE6O
 FgAlTdpMaIsfSE8+7SaBN2DVFqL/eyLigJj/mct7snrpksMqDv7wJSMwjtQc5juMHn/FwEkymTX
 3fYuDAAYc0ftmxA2fYFMaB3cMvbNpp37B/OG/MEY427lXfrEZWxIx/kl3G15V8cdOIfzt1kXlCv
 ExMRW4qc8nMfuH3llZO/sB/EXz/uKRb4Ay/wG5/e2HZBYD1SH5CVTU8Mtf29mXf/l0zGm3v0c5X
 6MkG0m0da1bUbAUkSCORzOUse8fvDuaKwAVkFUXh+GYFSJLvWQornDq+XmUyszCmZ4vVw=
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

If g_file_get_contents fails (AppArmor or other LSM), use a more
conservative default max size for the idle coroutine pool; this avoids
any possibility of the failure described in 86a637e48104 unless the host
kernel is configured with a low vm.max_map_count.

This change is motivated by a discussion of backport risk:
https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2168803/comments/8

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
 util/qemu-coroutine.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d17135f585a..d8853e3b227 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -391,7 +391,11 @@ static unsigned int get_global_pool_hard_max_size(void)
     }
 #endif
 
-    return UINT_MAX;
+    /*
+     * Read from /proc might fail due to LSM; use (DEFAULT_MAX_MAP_COUNT - 5000)
+     * for distributions that don't change the kernel default
+     */
+    return (60530) / 2;
 }
 
 static void __attribute__((constructor)) qemu_coroutine_init(void)

---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261013-set-default-pool-size-8b27c0fca8e3

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


