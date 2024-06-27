Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5046DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpL5-0001ND-2j; Thu, 27 Jun 2024 09:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpL4-0001Mx-6n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:02 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpL2-0006Tq-Jx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:01 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c7bf925764so6363939a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495539; x=1720100339;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6PV0Jwd3ow6/n1FaesIzFULRk/ni0qv5jyS/+wLDXMU=;
 b=QcqaHWYjlNZDngp0PqSn+pMq3x0BilHZQthv2tTqvbr9+YCyvO0Truu3HBqc/7fPG5
 udps2PfuB9SJ/OrsaYqirQApm79m/dQguD6E8XTKC8aL9IT/lQUJHGzvvaSeRrDiMd4R
 NektLqDoP/2J8pTbMWtCsfj3q1whoXT1SVNPqfBF/imkpTYr+ZTuz6GHbpkVe3Bkcamo
 RyE4CPjHFoDI1roXhquShMJrW0hYlpxSPi8+5IFigPDFBxjF/WrsJJZJ32T0y73JU7Qk
 FVYgvPABJBvZeKf6NClZw+G3pTEqQ3rpZfNme9CvSALwIeSp7mKlNA3FOp8x7E3eoq+3
 Xbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495539; x=1720100339;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PV0Jwd3ow6/n1FaesIzFULRk/ni0qv5jyS/+wLDXMU=;
 b=SqtWNKWPWfU5wjWnCAbgLZKr0OKa044QR7cKSdnPusb4KvS+RPfGUTOAFu9pJBzhvk
 oyy05TVVtkiQMKX1hLNd/LOFZzF9xyUleuQN+Sp0W2YQP28oA3k9De6wqCDcAqbjD401
 E81NjXNBXX4oYznEz14PLjYiY2YEJkWOWLqyH0n5jGnJPunwl4boyPSsIRj0kcmoSEp9
 t1OQK/vyz3nQtAzVJ2VpDKk9XY49j2eh0uhlBFHZjrbrVyCMLr3NspbNHGUjXSLu4+fq
 kW3OomzclMvw4ukpORmw4LMo5nMEkftFnW/5+5DEW2QWBRy5qqnl1hZWfbeQEMG/Ggma
 swXQ==
X-Gm-Message-State: AOJu0YwMsdrzL5Eb0jbfsQ8YXmKE/6c8GkCf5Cg7gXNmE66XG5jLCB1A
 4CBUOsj33BD9c9sIFnUpU11LBK9n9Q1cvxnvTqpJTVbBycRZRl7f6eIzU1jcVT4=
X-Google-Smtp-Source: AGHT+IFhbuBpEabR6Yyi6TNRReI6E/qCCZTqe1ej20jTUBAg55/M7mIawYiSZUH0E8xhDFfhuRfkqg==
X-Received: by 2002:a17:90a:917:b0:2c7:c914:69 with SMTP id
 98e67ed59e1d1-2c86141cc09mr12260587a91.43.1719495539229; 
 Thu, 27 Jun 2024 06:38:59 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8d7e63936sm3609235a91.19.2024.06.27.06.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:38:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:51 +0900
Subject: [PATCH v2 08/15] migration: Free removed SaveStateEntry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-8-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
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

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index c621f2359ba3..10b261823b7c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -874,6 +874,8 @@ int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
 
     if (se) {
         savevm_state_handler_remove(se);
+        g_free(se->compat);
+        g_free(se);
     }
     return vmstate_register(obj, instance_id, vmsd, opaque);
 }

-- 
2.45.2


