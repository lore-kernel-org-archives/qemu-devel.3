Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A49D58E4B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 04:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwumy-0000zE-EB; Sun, 01 Mar 2026 23:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumv-0000yM-Qz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:45 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vwumu-0006od-CO
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 23:21:45 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so1673011eaf.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 20:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772425303; x=1773030103;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJ87aMAuU1IdOrHaMXAEWRDul/pv4w0lPFyNWTXJchs=;
 b=Qy3uO2NJmHMJNuhB0CKAg21sc9q4ho385itslsCC588UdDS/a0DSwStpP1rx/t5Zk3
 90H+4ARdLdJGmjfK1qvhClTJdZZgWnxrStwUoiV47/1WbOq2DNL61NiQ3KtdbASAIkMK
 9OXzAnf6LXS/b/mngsZyUW0hqLAqlzD0DnnTpk016C25NyfZDdiSg/JbgMcFy3rEqkFE
 2SBmpdhNsyXpuoPOUOe3D431CXeoZN6+4tYHb8d/WtSni/PjWLRBr6cwGZPAfac/eSso
 9Kd9pXrZYx5j60ZJ2KErGaxKQqV2kYeO3wmRpvPab8JZx3M9fuWJNqjhn5qgZlsQrafk
 GepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772425303; x=1773030103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iJ87aMAuU1IdOrHaMXAEWRDul/pv4w0lPFyNWTXJchs=;
 b=X4v6/R1l9e48nXLgjDn/MQBbSxUC1hBtGG8bUFHrQYhYNucbK+b0HfkJr9tAoOzr9U
 E49iDJSeuN1YW2K1UlfZL8D9YUgEuA5ZXqbjRxOd+0TpKQCCDR9rIrGViqTm8+gXGn3T
 ocTn1vUuNp4P2N6C8rEiljA9DQJ7fmwdAr2uHAsX4JU47ek64BKryAqY/BXfIFzLOYoB
 eBNUu5xNy9e/5UWWmR7KzPSEGRJb+mTOiSVUi8W6qRr6EEH30ZZ32a9tskk6w5UoGM8r
 za9rT9BfboG6qDwvJF1xCchWqtbSSB1bi5A8zPEz8U8TlGvL6hwoJgiebRuYdZ04Jk82
 xhIQ==
X-Gm-Message-State: AOJu0YyaExK7cE6KWj/D26uqKnd+Jt99uBr1IwDdbb/J3d9e9rlBwlAN
 rAjucAHlNYJyquRfE032Tdqtn5zYH4qT97ngZaJ0jrINRu1vv4sFCnnWO7fmV3QGrbSGGf3+9qu
 YpRtKcJo=
X-Gm-Gg: ATEYQzz1yI7wQqVGmPPnMrNq/6k0gWZvmfO4nMreCQH+NxanA8jowqNnkOXDgzVLaBb
 liI8G3WjPdqUNxHEHtk723nVVT4q2Spv9MG1IQxWGS/+YtUda5W9aostvLmM0MvcvV/OVfxpFmy
 6DYk//usnYbE0RaYo9nID4mgWfodPnCJbz217vtSbKFDvJcgakR3acAG/FzdMAjxhiTSaXyI7SZ
 lzXc13Mot/CEsfWCdNED/1vzwE303FE3HGAqYyD7356tw7dKNZiSRo55bEW1TCOl/BeSHbRdehg
 qEH1P8QfLYLvIiJCrTi3KcvBUjU6jyTZ4Ay0LKcO1r38r7nU50q59RwQOah3I5qQi0eEQjr7lgE
 y+jvRdcafWEt7Y3VWI4b21EiC18sT8I9iQWFL14TiatjrErSowNiItSDv1liFmkJI7t8rqiyVjV
 EOMpszhARNzPK+MFx654QI
X-Received: by 2002:a05:6820:1885:b0:663:40d:48a3 with SMTP id
 006d021491bc7-679fadb6ec3mr6386719eaf.8.1772425302968; 
 Sun, 01 Mar 2026 20:21:42 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm2236778fac.19.2026.03.01.20.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 20:21:42 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/27] bsd-user: Add function declarations for bsd-misc.c
 conversions
Date: Sun,  1 Mar 2026 21:20:55 -0700
Message-ID: <20260302042115.83410-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302042115.83410-1-imp@bsdimp.com>
References: <20260302042115.83410-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2b.google.com
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

Add function declarations for BSD System V IPC and UUID conversion
routines that will be implemented in bsd-misc.c.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu-bsd.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 56affcd31d..b98d1d76b2 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -54,4 +54,19 @@ abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
 abi_long host_to_target_shmid_ds(abi_ulong target_addr,
         struct shmid_ds *host_sd);
 
+/* bsd-misc.c */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
+abi_long target_to_host_semarray(int semid, unsigned short **host_array,
+        abi_ulong target_addr);
+abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
+        unsigned short **host_array);
+abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
+        abi_ulong target_addr);
+abi_long host_to_target_semid_ds(abi_ulong target_addr,
+        struct semid_ds *host_sd);
+abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
+        abi_ulong target_addr);
+abi_long host_to_target_msqid_ds(abi_ulong target_addr,
+        struct msqid_ds *host_md);
+
 #endif /* QEMU_BSD_H */
-- 
2.52.0


