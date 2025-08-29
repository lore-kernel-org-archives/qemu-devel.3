Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34248CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNeD-0003oc-TI; Sat, 30 Aug 2025 11:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5NH-0006Nj-SN
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5NF-0005Cx-Kh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756498020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LB9SXkQgOnyONEMwUfFwYKtNNWRhU5cy/RayQLcVHSg=;
 b=XVASe4h79U+BQIllt//0HclBLXSDSoQSmElx9ukZwcbLRXCjjoNgU64m4oyEw9AU2GIQNA
 dXT3Wn4hdAMvGx1tJQlM2GYaKEQ4tuWc+0Qb55sKMXHSelSNbmasKgsZGUI2AIgK1AFdwl
 crZvx2bVRseLOef6rPEb915DWxe273s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-hw_w2nsQNVu81lpLsicrTg-1; Fri, 29 Aug 2025 16:06:59 -0400
X-MC-Unique: hw_w2nsQNVu81lpLsicrTg-1
X-Mimecast-MFC-AGG-ID: hw_w2nsQNVu81lpLsicrTg_1756498018
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3280d0d4d11so202756a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756498018; x=1757102818;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LB9SXkQgOnyONEMwUfFwYKtNNWRhU5cy/RayQLcVHSg=;
 b=Y6wdORTlBAPdTqag94952qRKi2XUJV12WMa/Hh21cdmMLKVpD44cm2oUhBCWjiosZO
 k8pcYUhF+trLyYw4ZUj0yV6370LCLYjXO3+b8TWSJTCEfynnpWcHsbKrLBm693gyqkxB
 b3Ee7ETxPqrHmDANM+JwqFoc+DU/y6Q1Oy7hgqlcV+7m63KLTqZtxS94OGpfLyM87qOH
 iV98XAHf6+EZH6wq5n9mb7RwTpzUQfdB1Dp6LAQ6ksa9TPQt0u/DQSB73BOwPnrmmdrz
 2dP7hreXvcBvZKG5HSAhQ/8HEhE9F+nTjgSiKqWGPF1pxMOy2beWjYRBSId6yO6X2kHT
 Tk3g==
X-Gm-Message-State: AOJu0Ywue04IbDJqKwdWL/b2UhtVp6cgRVokpRXGsq92PEP11f5RdvvB
 jh2muYqk0XoQ8vqLQnHzMdhJk8qCOEKXnHHvHH1gCsaHyF+7Oppq7ZNUwDRxPRYzGw925RbX0L9
 LpiQp/qN0o3AUTjaAKxm5AmemVKAJW/LmcvGuZPabT9qQpaoBEJOyNHLp
X-Gm-Gg: ASbGncvGUstHmAo3OO8Fbm4WOAKOD1siMBUl27uZEGg2SYUnzl/CbMJftvPqIfWMvwz
 sktArU6TFdrCkTAKbYGiLYJw8DK2aRgXNJKx1qTVtC7hhg2gaXWDTFEgEcr4mm6hR9viJvh9qyq
 6HudYm5hLF0H2UNY3WHC/MKzuJffIp/oZ+FIR3t0Zth1ew4T+35tbqLWKyWhPsB7VdKEikXvFWN
 m8A0p0QjIROBEUsm3pY6/4BmLk4RvmLfX1ZkoPj/GarvkHncJn9ZIjkRSO5zaiIXYylwIRZKLlA
 GiU6AeGmJML/fXRsR1/bnM26Wr0r5J02V52nQF94ONgSDgD47SvEcg==
X-Received: by 2002:a17:90b:3ec3:b0:327:9b36:87cf with SMTP id
 98e67ed59e1d1-3279b36897amr11823652a91.30.1756498018312; 
 Fri, 29 Aug 2025 13:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzMPgOWkW3Z/4cS8GAbpm9n7G+CRS0xMZOkYARj7xvIwczkHhobX9mgYoAfwIenaYfThB81w==
X-Received: by 2002:a17:90b:3ec3:b0:327:9b36:87cf with SMTP id
 98e67ed59e1d1-3279b36897amr11823606a91.30.1756498017874; 
 Fri, 29 Aug 2025 13:06:57 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:06:57 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:32:00 +0530
Subject: [PATCH v13 20/27] migration: Return -1 on memory allocation
 failure in ram.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-propagate_tpm_error-v13-20-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
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
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdr8jL2r0mK/qrVDmvbC9yLNL/Kc7f3X+b+HDQobhe
 WXa/lc7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATOShNcN/v8883qyLDXu2fly7
 76prgU3L0pl+rKd92cpPB2denJk7mZGhU3x6wwTVXzfMX51/dt25ozXgnUGPVp5Qu0XU1NW+67L
 4AQ==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


