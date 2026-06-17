Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAA6CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIS-0006gm-Va; Wed, 17 Jun 2026 10:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIR-0006gU-A0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIO-0007mC-TZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IePD93U28MtINigVrSaPo7PT121Fe25VbbfX7lz35bQ=;
 b=PG6urI1A+quVfl+zZVMj/1WuXpO6v8/CAnCPus1ej0aZonWjngaAi3fJoLtFZYGk6dXFZe
 HhMlxk/2BAKi+Hvr98XnhbcQDH+P4VnNU3i6PBHBTce42Ejsno+/j3In/OGBNlfWFjJq14
 uTZocCEcqSl3ExKX8gZn7EGDbKQfo8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-j_qw5s9IMFaUNenBUxUybA-1; Wed, 17 Jun 2026 10:31:07 -0400
X-MC-Unique: j_qw5s9IMFaUNenBUxUybA-1
X-Mimecast-MFC-AGG-ID: j_qw5s9IMFaUNenBUxUybA_1781706666
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460153ce644so4276719f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706666; x=1782311466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IePD93U28MtINigVrSaPo7PT121Fe25VbbfX7lz35bQ=;
 b=Pq7IXVQTt/GItO/dxl/sPceS+QIulpYvC+zmdgi2H/dB0zdp7YfiBQkafJJIG+gnTU
 ZutSBQXhyx+0eQPUsaA+pU8QZz7yGAoP88TTwIOAcWqgzh+c7RJlBhw6X6uE8h7AWLN9
 gNjPS6YA6OB3E4e0DUl6g5/tJsiOUb9mSkZpRn6PCif4qpmS+Tgfi/TPWSx7da+zMOF+
 3Imh2Rkjqhr4NPgbj78n99xIR5kL+KVdX2JbAH5zpLteiMhifCpWuuM2ns9Jnawg87KT
 yTs6C7PyrWQOra6rQJOpB+C2ao1PpvFuqIN7jE4tTtFiDUZt8lsFi9iM5xbeBMY8JV68
 YfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706666; x=1782311466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IePD93U28MtINigVrSaPo7PT121Fe25VbbfX7lz35bQ=;
 b=U4QbpMCNNg30Yy9/BNgMKZeFV1fc/pWaSkhQCRY0F+8Mkb7lJmLQvn+GC0vBu0qJon
 n44eyNmcPAUv8zme1IOeDAutsVix2U9EatZX1jJ+qnYTvOusna4TRjWMzIcZ72a6YExX
 AlNOnRZFgZKzjjJh6DmvR5oI+TSvmQzOVE13jq/MSCI9pexJbIIB4VoxyZlOwn740/7y
 QRRZaRGWsLCoRbA4T6/c0z5YzMLP7/zhlh79cn84Q5siAUAwLzDHdz30je0Suw4a8ISv
 ZJTgPZJIY0r1tpcSx+cokytYrGC0g+vRGUkronID3aUL0fDtPO5FRvxnUVHemdQ+E8J6
 glQw==
X-Gm-Message-State: AOJu0YxfS3VW5ZM4stLOiNkTgYDE6ZcxRp+wYcZKFto60+ESNJz0DpL6
 Ks2nLFwVRtl/B4NiBN1CFHb0BYBilCGYn75ATZCzXk5fgIrJKvc5rIMjhF3Jc+je7wb3b0eRgHn
 6Mh4aUoCqLZQiRO3c+MQWIMPqZq8pxe454L3Bwl2rxTF2/Xo/lJQcfQKP3cX51Vpab3DSj8aQmE
 dx4wo8yScUMpiC7xdF2kDZYlADxEst09LZRO4FeesI
X-Gm-Gg: AfdE7clcDba4jHZPQW2qRZyFF032DOaBEuzXUwp6Q/QuVJjLUAJQGo553l8j4FWQZml
 iPmAAtEFioVlhtMeSjcSJN2MYVxXyg364DkWxHvs8itweC9GPsA8umIXvrmLIlVKsQPI4lCE+0R
 35Q49kRvQKPsGWpxbgBMYHdgk0eeWyv8207MCPK/MqvLllng8nnxA0YYbOuxSrwJWrbm2DGNz9L
 YCqdTb3kP1IZebkQ9A0x9JDlS1J9Lz/oGUIrDJg5/HHkpxK+kRi83ZPOh9ahfLA9aX3ovaODE/H
 qnDTk86YLpZdK+CjYcwJ75ygMWFG7sFUpxTJm5BKG1h3iIOKQSwmar2i3gHok6d+2Pulfn7VjS5
 bDyYTj0CLityeQcR+SHS/fMjZGyO5xu7Nz/fXa/feYbuUjYqfT+ZOVwehEAg9C9eDitvZy0MbD9
 ULF2asGSJxSEbagz6M
X-Received: by 2002:adf:f5d0:0:b0:460:2477:2277 with SMTP id
 ffacd0b85a97d-462416a511bmr6110026f8f.31.1781706666331; 
 Wed, 17 Jun 2026 07:31:06 -0700 (PDT)
X-Received: by 2002:adf:f5d0:0:b0:460:2477:2277 with SMTP id
 ffacd0b85a97d-462416a511bmr6109963f8f.31.1781706665735; 
 Wed, 17 Jun 2026 07:31:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm54859002f8f.19.2026.06.17.07.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Damien Zammit <damien@zamaudio.com>,
 Manolo de Medici <manolo.demedici@gmail.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL 07/16] tpm: Add conditional to not compile ioctls on GNU/Hurd
Date: Wed, 17 Jun 2026 16:30:37 +0200
Message-ID: <20260617143046.445322-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Damien Zammit <damien@zamaudio.com>

The Hurd currently doesn't have any TPM driver, compilation fails
for missing _IOT__IOTBASE_* symbols unless these are left undefined.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/r/20260208055858.2166524-4-damien@zamaudio.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/tpm/tpm_ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index ee2dd15d35e..e4663114558 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -285,7 +285,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
 #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
 #define PTM_CAP_LOCK_STORAGE       (1 << 16)
 
-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(__GNU__)
 enum {
     PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
     PTM_INIT               = _IOWR('P', 1, ptm_init),
-- 
2.54.0


