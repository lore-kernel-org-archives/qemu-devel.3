Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B41EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAw-0002M7-Og; Wed, 04 Feb 2026 14:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAs-00028y-7z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAq-00088d-LV
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ej1dx9mzEv6uFTt+nidTdAWYhIzVe6HhR8BEsb/fzCQ=;
 b=KWiTDJYSE2woVhiWD/fTQc4JmWJxQClODgE1OpEhHu8AU+UueFeVjaa6KfcLeQe1EUMbB7
 W8qfdTP0IuLBw1QAx4YU/t5rji3bytgHn/bNydJresMgAHqEpO1DHOILRK1f7UBHlC0XGp
 UmytxxRzmSYqESFcLUkntozIMeZpCbQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-NbZizNR4OYGALe_uz2zFbg-1; Wed, 04 Feb 2026 14:04:22 -0500
X-MC-Unique: NbZizNR4OYGALe_uz2zFbg-1
X-Mimecast-MFC-AGG-ID: NbZizNR4OYGALe_uz2zFbg_1770231862
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435db9425ebso158623f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231861; x=1770836661; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ej1dx9mzEv6uFTt+nidTdAWYhIzVe6HhR8BEsb/fzCQ=;
 b=Yby09ilfQH31v/m5n+DbB7yxSMk9ShmzCYL0PObrL/OlVQ2RU+ZDMe/66T/Uy09IA2
 HvguspiLeHIjLxPRuZH22WiVwN3fGDw/fNBldptvyoV0Z6xPzR89IgWgwB1SNdEiOD6S
 CdEKe0LF4WgxR9nySM4mfFyBrE6Dti9dUrtBtaeMsHNzus2Soebj5Ls4Zm6akoP/PbDf
 JUsnQ8W8dWcdRxLDl8bHGMuAMmC4bbb9qqCSLnqKAMhlInbx4xsLHQE81fkkYgeupMpr
 c2BoI5uj0MWW6JAH5Nwa1zozpE9FZ4bZkacDOvaLthORIV9noR6f88R8xeD4B7ljUojv
 JStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231861; x=1770836661;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ej1dx9mzEv6uFTt+nidTdAWYhIzVe6HhR8BEsb/fzCQ=;
 b=XSJ6Jg+aF5CSHqibsuiu/ZN+X35N1sM5fuePqV0a8ZG53wk4rsj7lxEsHYXf/5i+bT
 oDCZ/w/NTaN0/d2vUYrgKsTlr1Eb9AicTF9kcG6YefJI6hg5vvEbir/6bvAhZ358Oold
 0/8SOeRaT6oPpecczKJ5u/nN+xSeNbEWwlFYZB0FFwMiVxeLlpcu1arc3xZEThfktot3
 fh3X/lXVmMTdOZ0JMq+b66fDBa4j7QG+WeBZaOq6xBSi+LUIRFS6Qmrci/HqSgt6AmfR
 zdU3mTSCWvWY5cRgGndYdVbn5xhfmqasfv8p1+9uozMH5SQTOyFayuyz4YqYhlzMr451
 3YrQ==
X-Gm-Message-State: AOJu0YxbOnsaoAnyo6+Bv+2qZwejXyCOLoxkTdkFtVROMXV1dye6hBZT
 FTM8ePwII/6nOinPO22h389i6e0c7qYMWeB67yYZfhO1LT0j75UCYJZj/0DtU5jiRuZ10rcDmla
 niqd2Jl7MEmVTo0fVkt/28YUmo7aYcA8hs+AEV4nVM6JZ+L4fSNQDQo5YAGUqBfF+nDYa8IAdvQ
 iqBQPBrvASHxOM2WE6tYjpMu4yhF2/4o+uDQ==
X-Gm-Gg: AZuq6aLd5XcZ0PjAPLFejfg5Ud+ZJgtbl+xHi6FdBqUJcNkCrRn1ighBrz+dwyJltiR
 xgWDNQ7x1EUa+ZIXEKjnziYVJTtkCWSPAmMPCwkheqjW+fpMvPFZOSC+9vT5CK8C/aEeAyEeTbl
 IJP5x8aviBIIAhaQGRxbWbuxxr6qk8xgIUQM9cXHRCPnGXfJcniUFCplYokrOWcykcqasYFffrZ
 l1g9HtrQ0Wkx0tvyz978Pxg7tW7zqP0EzcmRPPM+hF8cQMqcMd+fGIhhKMOcBXdisbmIKb7yJRV
 4fVWMfXQsDyDt5QeIN9dsbYA5KSvcsXgkGPjJWLYvuwCVvnQCx7MdpYQiz+T3TSyLwBCvmYCdQc
 Uz9mC9NpgW+sHGsCYxQXbO6V5s9bB5kadxw==
X-Received: by 2002:a05:6000:2281:b0:430:fd0f:28fe with SMTP id
 ffacd0b85a97d-43618050e5emr6402932f8f.31.1770231861213; 
 Wed, 04 Feb 2026 11:04:21 -0800 (PST)
X-Received: by 2002:a05:6000:2281:b0:430:fd0f:28fe with SMTP id
 ffacd0b85a97d-43618050e5emr6402867f8f.31.1770231860643; 
 Wed, 04 Feb 2026 11:04:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e387b9sm8913503f8f.12.2026.02.04.11.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:20 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 zhenwei pi <pizhenwei@tensorfer.com>,
 =?utf-8?B?7J207J6s7JiB?= <nakamurajames123@gmail.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: [PULL 39/51] cryptodev-builtin: Limit the maximum size
Message-ID: <48978afc01e7c419e03c4dd608d0c4ece3832d02.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: zhenwei pi <pizhenwei@tensorfer.com>

This backend driver is used for demonstration purposes only, unlimited
size leads QEMU OOM.

Fixes: CVE-2025-14876
Fixes: 1653a5f3fc7 ("cryptodev: introduce a new cryptodev backend")
Reported-by: 이재영 <nakamurajames123@gmail.com>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251221024321.143196-3-zhenwei.pi@linux.dev>
---
 backends/cryptodev-builtin.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 0414c01e06..55a3fbd27b 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -53,6 +53,8 @@ typedef struct CryptoDevBackendBuiltinSession {
 
 #define CRYPTODEV_BUITLIN_MAX_AUTH_KEY_LEN    512
 #define CRYPTODEV_BUITLIN_MAX_CIPHER_KEY_LEN  64
+/* demonstration purposes only, use a limited size to avoid QEMU OOM */
+#define CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE  (1024 * 1024)
 
 struct CryptoDevBackendBuiltin {
     CryptoDevBackend parent_obj;
@@ -98,12 +100,7 @@ static void cryptodev_builtin_init(
                          1u << QCRYPTODEV_BACKEND_SERVICE_TYPE_MAC;
     backend->conf.cipher_algo_l = 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC;
     backend->conf.hash_algo = 1u << VIRTIO_CRYPTO_HASH_SHA1;
-    /*
-     * Set the Maximum length of crypto request.
-     * Why this value? Just avoid to overflow when
-     * memory allocation for each crypto request.
-     */
-    backend->conf.max_size = LONG_MAX - sizeof(CryptoDevBackendOpInfo);
+    backend->conf.max_size = CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE;
     backend->conf.max_cipher_key_len = CRYPTODEV_BUITLIN_MAX_CIPHER_KEY_LEN;
     backend->conf.max_auth_key_len = CRYPTODEV_BUITLIN_MAX_AUTH_KEY_LEN;
     cryptodev_builtin_init_akcipher(backend);
-- 
MST


