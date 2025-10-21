Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0107DCCD1B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBHIp-0008DI-Gj; Tue, 21 Oct 2025 14:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHIm-0008Ch-GZ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBHIk-0004OO-Hx
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761072101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNORQyf4LYhiSCJxxMC/zAQkaMIFfQ2/DE+ncYUKrT8=;
 b=aiVFWsMcVd6XJOZVMdsHCYXQ0pqJOXxpcBijhi1qYF11QFuU6xAnkCzc8FiRQyEjVmqhHn
 Hg9qinpl3KF7kskr/lLUbbFWiadi1LGFnLw2iv5ZEDA/eKR/Mmuy9diX2fOHclS8fml2h/
 m5ARE1T9VIQf7TJVugvO76N6v7Fw7Rk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-DfOPY8AfNQ2LBPRxBc25WQ-1; Tue, 21 Oct 2025 14:41:40 -0400
X-MC-Unique: DfOPY8AfNQ2LBPRxBc25WQ-1
X-Mimecast-MFC-AGG-ID: DfOPY8AfNQ2LBPRxBc25WQ_1761072099
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-87c171369aaso6167396d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761072099; x=1761676899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNORQyf4LYhiSCJxxMC/zAQkaMIFfQ2/DE+ncYUKrT8=;
 b=UsDMzMbns152UQEzZMW88E9e9zjx8kGpZeZRMpeRhtf3mj81SdstQksi/p1LhilsH+
 pTMXE+UGBPY1umaCKmoueFhkarV55UnxveVxDgu+mYSOdzZ/P03pNZ/op2CAnLBOLm46
 tiODOVIVJvtJLpxzC0gHS2/PelYcbaNxahTL2ukIQThCI4Eq749xH3yhazEDTPoLuMCr
 c4LHHZnbxCDePDpysFTXZpVdaIJ49thIXB5Vb8qTa+pCVjdTcGJprD9w1f9roblv///8
 EtWuiEOlP6KvEMuXd/wDy9ekC1oBLAx/70anJoYGHjrwPSIiNBdzTqAdcCJ1BTu/BCqW
 Easg==
X-Gm-Message-State: AOJu0Yzb8QHgOw0GPiOEW1i4l1L89z51J3Cg6W/DHWw0c0kSKANNxn2m
 eWPBElJs8sODfQpbs+O2FkV64C9e0SJKEdGq8pXFIN92KAhC2ageeSYJwSPxQkZNnKnEIzey9vZ
 uLwMj6nbvykFtqQ40Q1XG1S16FRBfoxQ3Qy6+dOgXy6dVVl/pxJz2wRRsE1eSNVIzQodjmj+ATJ
 3kAD4VzzE4XYTZOoFcnkVGn3cx9zgzDhSeH/TE4g==
X-Gm-Gg: ASbGncsMuXwUdQzb45UUZmfXOqzQ+yN2eplixY8GEjcdNxj6jvnwPYik+GfIQbybXia
 V+i5EGMv/6N/YyJWgskQgTmq7v081A3N1cJy2wPp+txCCUD33SghjURT1wOQNgzUa/WsV5fTn8J
 zpcjLYQzxrlfWx0AWKVvyQ5ldA+cqgMfIAPm0hRN6UcPABFYNDhZ3F/pQ3adbZYG7izOIMwISVH
 btWWs2hZ8na9hI7R11GjQbkFn3c1VielPP/704iSiazC4WKqfGkL5t9nNqlt/+eTSVwieUzgox8
 JwDddROjYFIW1js9SOLVhgg0dBndtav6A9sx4+JRIRpmj79UzgLVtyN8zZOo86Dk
X-Received: by 2002:a05:6214:2407:b0:78d:592d:fd03 with SMTP id
 6a1803df08f44-87df675872bmr9851726d6.25.1761072099158; 
 Tue, 21 Oct 2025 11:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1jlSQGhbCpN019pcFjlzyYnG33XD7O/NAOHoH8SxMaOcjyh+CpLT6F+Dcowa1H4FGZS0ezQ==
X-Received: by 2002:a05:6214:2407:b0:78d:592d:fd03 with SMTP id
 6a1803df08f44-87df675872bmr9851306d6.25.1761072098594; 
 Tue, 21 Oct 2025 11:41:38 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87cf51fd3easm74244966d6.10.2025.10.21.11.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:41:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Arun Menon <armenon@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 2/3] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
Date: Tue, 21 Oct 2025 14:41:31 -0400
Message-ID: <20251021184132.2635958-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021184132.2635958-1-peterx@redhat.com>
References: <20251021184132.2635958-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Per reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA_mUQ2NeoguR5efrhw7XYGofnriWEA=+Dg+Ocvyam1wAw@mail.gmail.com

mfd leak is a false positive, try to use a coverity annotation (which I
didn't find manual myself, but still give it a shot).

Fix the other one by dumping an error message if setenv() failed.

Resolves: Coverity CID 1641391
Resolves: Coverity CID 1641392
Fixes: efc6587313 ("migration: cpr-exec save and load")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpr-exec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index d57714bc5d..3cf44634a9 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -43,13 +43,16 @@ static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
 void cpr_exec_persist_state(QEMUFile *f)
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
+    /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
     int mfd = dup(fioc->fd);
     char val[16];
 
     /* Remember mfd in environment for post-exec load */
     qemu_clear_cloexec(mfd);
     snprintf(val, sizeof(val), "%d", mfd);
-    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
+    if (!g_setenv(CPR_EXEC_STATE_NAME, val, 1)) {
+        error_report("Setting env %s = %s failed", CPR_EXEC_STATE_NAME, val);
+    }
 }
 
 static int cpr_exec_find_state(void)
-- 
2.50.1


