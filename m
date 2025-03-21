Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63950C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdjj-0001ev-Vs; Fri, 21 Mar 2025 10:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjI-0001RZ-5z
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjG-0006V2-Ji
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742568728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TtMBE0I0CzdKHMGaIl8cmK8TvAyuKUcO1nCSx7kdsUY=;
 b=WRLC4Be37jl8f37rJjSSWJ1h6Z6UQI5IHGPqiBJM/DAQHImlMcvNYKHQ+Xjd992M7kp4vT
 VDmmmvSG6imykfs0+MdeoJ0mwbzZY4h7eku7rF2TegjlJz60izqNjnYSp9KpTR/t0taeHF
 +3jCvcLE6+ljHvJA3VSa0LQYmVyxceg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-5cNPNSpqPd6GRf2S-vj4AQ-1; Fri,
 21 Mar 2025 10:52:05 -0400
X-MC-Unique: 5cNPNSpqPd6GRf2S-vj4AQ-1
X-Mimecast-MFC-AGG-ID: 5cNPNSpqPd6GRf2S-vj4AQ_1742568724
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02596196D2D2; Fri, 21 Mar 2025 14:52:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03AE41800370; Fri, 21 Mar 2025 14:52:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C548621E66C6; Fri, 21 Mar 2025 15:51:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PULL 1/8] cryptodev: Fix error handling in
 cryptodev_lkcf_execute_task()
Date: Fri, 21 Mar 2025 15:51:51 +0100
Message-ID: <20250321145158.3896812-2-armbru@redhat.com>
In-Reply-To: <20250321145158.3896812-1-armbru@redhat.com>
References: <20250321145158.3896812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When cryptodev_lkcf_set_op_desc() fails, we report an error, but
continue anyway.  This is wrong.  We then pass a non-null @local_error
to various functions, which could easily fail error_setv()'s assertion
on failure.

Fail the function instead.

When qcrypto_akcipher_new() fails, we fail the function without
reporting the error.  This leaks the Error object.

Add the missing error reporting.  This also frees the Error object.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250312101131.1615777-1-armbru@redhat.com>
Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
---
 backends/cryptodev-lkcf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 41cf24b737..352c3e8958 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -330,6 +330,8 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
             cryptodev_lkcf_set_op_desc(&session->akcipher_opts, op_desc,
                                        sizeof(op_desc), &local_error) != 0) {
             error_report_err(local_error);
+            status = -VIRTIO_CRYPTO_ERR;
+            goto out;
         } else {
             key_id = add_key(KCTL_KEY_TYPE_PKEY, "lkcf-backend-priv-key",
                              p8info, p8info_len, KCTL_KEY_RING);
@@ -346,6 +348,7 @@ static void cryptodev_lkcf_execute_task(CryptoDevLKCFTask *task)
                                         session->key, session->keylen,
                                         &local_error);
         if (!akcipher) {
+            error_report_err(local_error);
             status = -VIRTIO_CRYPTO_ERR;
             goto out;
         }
-- 
2.48.1


