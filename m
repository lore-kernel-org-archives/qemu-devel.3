Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5695FCA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGX6-0000iD-M5; Thu, 18 Sep 2025 11:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGX0-0000YC-R0
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGWw-0003DM-UH
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LB9SXkQgOnyONEMwUfFwYKtNNWRhU5cy/RayQLcVHSg=;
 b=V39PiIcMc+Q29f0D0l7Jbr8cHSJ2KViv4h6nvlpJrT4ZIihfR0txYWsOIB6tgJiKR5k494
 yq+JqwLfWJ3XgQduw+ahjtdOULt18eV/QfQ7EAOWmJhwXBLl/1Dba+cj1KYB4UTX9a/7dr
 PmuvG0Yw5FxEREPBrXDf6QsaaQmWL2U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-iRbIvrEwP9CJjQrFwgQueg-1; Thu, 18 Sep 2025 11:26:40 -0400
X-MC-Unique: iRbIvrEwP9CJjQrFwgQueg-1
X-Mimecast-MFC-AGG-ID: iRbIvrEwP9CJjQrFwgQueg_1758209199
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b5508cb189cso694244a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209199; x=1758813999;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LB9SXkQgOnyONEMwUfFwYKtNNWRhU5cy/RayQLcVHSg=;
 b=TdIFkwHShGSf0XJ2KFm6wMO5T3peRmyBZWFJHShwqotcxPmMEAHrEJH4jfN4I6Fw0+
 EBwI4DiBBw2FSJUpCLbhCocUpjuG8oJAC9+mfTC/yz9gcGYOCOvr7SXOKRs+NERTAD44
 SSFoL+jBDc1snRNtX/gC8Am+hjHEgpcZM6qM3AAqXHXKLlJsSls4/42rQw/6bGHr1nIN
 CrjjINr0lg0AA4nxJknqJL99n460m3tFty0asFGaLLCk37M8Y4dL+xLX8w67xO2eWin/
 zMV+SSfq94UbyKCHBtL7bfAjlJteQtFq9gS9hPtqY9MXnBZnM33dCcfD/sueE5p593w5
 +fqw==
X-Gm-Message-State: AOJu0YxmhHrBM9lOusAQ3Jd4FHtjm+QB8YsGkZYeHBUFBee/WaPRskAC
 FDgP1HNLrApOltWaOFtvvDXRl4iw8iVkVzb4SNoJz0+iIyqgc4fudb2I9LuI9pzjgC1A18uprJn
 Xpk3aNaF66jw5nk11WDzQ7LhkuPgI78LWnVpUeNyR/ckPRdDaIUE4/KbG
X-Gm-Gg: ASbGncvAWvEZ72WPTt49qarBxo7PaEOoZOQPIgfT00h5feq45J9z9HHjMjTwWdEVCOa
 103BEbp0IavpYGZAsx5BFuHtKrAECOvgrQrCYu7Mi9PifiH9oDaIkDMhmDHwmrAP6EnBRahT53l
 N7jGEQvxubycDciRatyLs+oRfRf6Uqqc1cQhiwazXskhh3MdL3qGfKBquGjSOInufLLLSWvz94x
 umqkh0lmbz9HemeUKfvLBLSL+8PxaDZUM1l17Tfm6kMhov3q8upMCdYEo2UZMfIryXUZdBw0UXf
 pCTC5UIQuHYu8FYo3LdgESZ14QVYJOBNJqh8Nw5fBwRcvFm6xFDZRw==
X-Received: by 2002:a05:6a20:7288:b0:263:1475:6653 with SMTP id
 adf61e73a8af0-27a9f543fd7mr8828013637.16.1758209199313; 
 Thu, 18 Sep 2025 08:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF15rKsO3NKh6/kOvjW96QpfmCWC5f6jUy2I7Pxr4RjWTKQBL5oAUue+v2LE6C3kpdBsK5l2A==
X-Received: by 2002:a05:6a20:7288:b0:263:1475:6653 with SMTP id
 adf61e73a8af0-27a9f543fd7mr8827952637.16.1758209198844; 
 Thu, 18 Sep 2025 08:26:38 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:26:38 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:37 +0530
Subject: [PATCH v14 20/27] migration: Return -1 on memory allocation
 failure in ram.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-propagate_tpm_error-v14-20-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=armenon@redhat.com;
 h=from:subject:message-id; bh=LbrL/8rC1j/1roMz22wMr5Cto4+KiN2vW7a+UxDKaz0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5R8XGQIqgu/+LFp3+tv11hVc8yx3L7wufXCN+AnxV
 utZd5R/dJSyMIhxMciKKbI0fA2QbQoojIi0fXkdZg4rE8gQBi5OAZiIxCqG/9kNiz5OK3hYYjBF
 ZOe3uW0y4UdCN3KvtnHzjXrG82v7oycM/+O+Ze40Yp+78JvCz5B5dydn7Kq+dXen82rPC9Evvwd
 dqWMCAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The function colo_init_ram_cache() currently returns -errno if
qemu_anon_ram_alloc() fails. However, the subsequent cleanup loop that
calls qemu_anon_ram_free() could potentially alter the value of errno.
This would cause the function to return a value that does not accurately
represent the original allocation failure.

This commit changes the return value to -1 on memory allocation failure.
This ensures that the return value is consistent and is not affected by
any errno changes that may occur during the free process.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6a0dcc04f436524a37672c41c38f201f06773374..163265a57f26fb1dc88d9797629d58c278e9afb7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3575,6 +3575,8 @@ static void colo_init_ram_state(void)
  * colo cache: this is for secondary VM, we cache the whole
  * memory of the secondary VM, it is need to hold the global lock
  * to call this helper.
+ *
+ * Returns zero to indicate success or -1 on error.
  */
 int colo_init_ram_cache(void)
 {
@@ -3594,7 +3596,7 @@ int colo_init_ram_cache(void)
                         block->colo_cache = NULL;
                     }
                 }
-                return -errno;
+                return -1;
             }
             if (!machine_dump_guest_core(current_machine)) {
                 qemu_madvise(block->colo_cache, block->used_length,

-- 
2.51.0


