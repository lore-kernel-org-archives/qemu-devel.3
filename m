Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB42EECD98A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo38F-0004WO-2g; Thu, 05 Feb 2026 12:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo38A-0004RL-H0
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vo386-0001Pm-Pq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:27:02 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40423dbe98bso656763fac.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770312410; x=1770917210;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nRjMFvmo23DcHeazEl5RHnnjP+Nu2bmoIkcthLEgSoU=;
 b=JIalNg6lPHXNMlcuxBOWgPZ3/LafiKQY3T/3ddpiDsy0T3rDi6xpkR6dPJ6s+38R8y
 uVy4fplP1nFP77nMGPtScIOHdQucFuyESNqTRTReg/anqH5IWKeFxRGxo0VNaXMnVBs6
 YCwQ8iOgcmk6FRZVzczD4HpySgMPgBZ/PZx4uoMGvi/e8ngOa8hrF/nLw686kqyeZhlx
 +ErS8RwnTGY+iWyQKkaWL5pLdVZ20Kwpv6WaEVRLaIMJQswbmN47Hg2ITghNOxPFyb2G
 /8whR6UmQ5mhBMl1n/wf4AvkU8ueB/BrmKmUNSNJR1szWcXSvjmv99h0+ZJlTeKMx93L
 bkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770312410; x=1770917210;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nRjMFvmo23DcHeazEl5RHnnjP+Nu2bmoIkcthLEgSoU=;
 b=wjngG98cVk1bUjPZXrbr2HFJIcN6tlIOCathYEyTt03Yl73q1sFcQ88v7eq/7N66BU
 53nXSPdmczmogfd1V7MyD4C+BJHsgJcuS5clghY80Y4G5SigNTP0QqOIQTPssuWO0CGY
 7AtWKE21s1Cimm/RN3EtLkGLRBqaRpg5h5by9ZUVz3YCpJ2nROAEGZVY3f+WVPDjDCqK
 eCLzJQYjxAkQx5Hgh1D24rDDeNkQ6uIxuOVgR3j7xUl6B5VRnK9hy1sV/V/lYyB99OUK
 npQk91SivU4yCttRyYflk33iexIJsAhT1WTHBb9diw13KG0reMXeOgeQ0qmfW83/KKwG
 N2Iw==
X-Gm-Message-State: AOJu0YywQ1ZvFgVBAQHDAWNy/oHitPcxgrATUvW8P5oHXxR0/6n0oZ7X
 JZmx6gsK3ZhwaaCJmpuHEer2IF1fTSVTH4tHe93/pWi7IU+dFlM/DHHcw/yMLuTl490=
X-Gm-Gg: AZuq6aLZP2l/bnaK/PgklKNAonFxLwM/9zlRewYpmKKqCZ/Onx0q++M+MC1CseviZz8
 ZNRNs7Uyq95I2dYUkh/GrBbozQI4gGt2pPzq5BQIjf+TXbzlN0TfnqiOx0wlcoXKwrg+T3RZXj1
 6QFbIpe4x+DQwRbVSOEvwcqYjrD4vFe0lHEeBJQfgaVtO5pdWVP19qW31mcm6+aPOl0V7Lr/gjY
 Cxu5viGzr+UDJCef3ZgeBXBShi1a7wCxu1mOxMbiAFHdrrs1KlBkFtgWOdP/YqAUIZRZ7+ZP7Lv
 nm9PZ5JUo3QKO/Tt0TLgLxkLw9ck0n+/ppi9qVFTaeO5NwpSnAU2/A7hQjks7ZEZYTcY14GXEbB
 58MAJhDzKkr1f60No+RL3/7tNDknFXIeole1bVMAVX4jNTUX6zFG/2eRytgOekSaxLkpQVM7VEU
 1A+VpxF+vk
X-Received: by 2002:a05:6870:fba1:b0:408:9f19:db8f with SMTP id
 586e51a60fabf-40a96c647femr17524fac.1.1770312410473; 
 Thu, 05 Feb 2026 09:26:50 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a5417f142sm4166291fac.5.2026.02.05.09.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:26:49 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 05 Feb 2026 10:26:43 -0700
Subject: [PATCH 10/24] bsd-user: Add host_to_target_semid_ds for semctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-bsd-user-claude-v1-10-8d8ff0035372@bsdimp.com>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
In-Reply-To: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=WnUMIMP73sKl8rP3ra69MFt9fRKFmebiQEzTzexuxLM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBphNLaIh/HKahvfMrGjumXPK4Lsdc/a9vqxSBBi
 aHCHS+SoRGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYTS2gAKCRBsHNEofbAR
 AAUdD/9NhQ3OSmbSQQ56TsU/gwz6A1ApM6f5QsYaoCx3aYNR1W0D3Gaoz3SWaqKOR+WcEVtbRN8
 WGY7N6n/9/g3U3IkoN/gMkkdXS2ZEQ9Ntl/LPPRgR0SYfkP3NQJfgHfYMRgOmTnCsLObhMhGmop
 NWiiTAhKEHkgf6jjsIu4nm6vCir+PacmWOoN9OFf5Z1Cka6bpvISRsU93fICnBkKqDzzfh7H354
 GftcSfjT73YTPnxwCZ/tlfEpxgwNm6khSr0+opiT+GJkJoqxLZUZawKTdbyFFKWBJHo7u0uFHwT
 g6HJ1GwNptRJMpnXjf29RMnVbSnW3pRFxNtIUesExgGwDihTOh9yNDJuuFTM9EXRZg/4bh7+IGK
 3OXvlj04AhBA6BU6bRHz6alOmbRBM/m/r2VmK3ampIcJbEA6jW4kCvrjI+mu2+Sn/eKycGqb0dr
 VtJCpg1qObGh6Y9te35VNeKUbVY5fo/+GM+C8JrSBMfXMA3vJHIbUFIaFdTjXtZm5o0FVSxpB4V
 hAvEescI+o1/ir2nSlmYP7q6AfvfFfN9HtW+jt/t+H0ByW7/KdAo8mLbGpZKy/R6eSIY4kX9MKs
 H6aFFI2HpoJK/djJFvx5KQ3vDsu7oO0BkXmHAh4XQlZmu7T3BoMfWQAi4J0neJnnCpPsCj/47t0
 CxKW8MDSvn2EG9Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2c;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add host_to_target_semid_ds() to convert host struct semid_ds to target
format for semctl(2) IPC_STAT operations.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
index 581eb50355..f35f682aa4 100644
--- a/bsd-user/bsd-misc.c
+++ b/bsd-user/bsd-misc.c
@@ -134,3 +134,23 @@ abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
     unlock_user_struct(target_sd, target_addr, 0);
     return 0;
 }
+
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd)
+{
+    struct target_semid_ds *target_sd;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    host_to_target_ipc_perm__locked(&target_sd->sem_perm,
+                                    &host_sd->sem_perm);
+    /* sem_base is not used by kernel for IPC_STAT/IPC_SET */
+    /* target_sd->sem_base = h2g((void *)host_sd->sem_base); */
+    target_sd->sem_nsems = tswap16(host_sd->sem_nsems);
+    target_sd->sem_otime = tswapal(host_sd->sem_otime);
+    target_sd->sem_ctime = tswapal(host_sd->sem_ctime);
+    unlock_user_struct(target_sd, target_addr, 1);
+
+    return 0;
+}

-- 
2.52.0


