Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE362F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5wa-0004FW-LR; Tue, 24 Feb 2026 22:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wY-00048P-Pd
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5wX-0008G3-5R
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxPupLKXKRysmyGd91VNxhdP4T2DZ/YUYcNzsqzSqOs=;
 b=amyKjSGRm/JFN5X3LOlmIADij0YzG2TwAD1Anmm0b2YHAORAm4SK+GEWnkSJbtWqboesaV
 fcImNd/XE+YFvPv8rBKhkh49omx0QJMniMFtVoPXTwdEOdq+hoUvKI5fMfKaji5y9jHTlu
 3nK8rYBggTiR6IhtpKM63vPye0KLEyM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-3RljwQBuN9-EwX3llBnsEg-1; Tue, 24 Feb 2026 22:52:05 -0500
X-MC-Unique: 3RljwQBuN9-EwX3llBnsEg-1
X-Mimecast-MFC-AGG-ID: 3RljwQBuN9-EwX3llBnsEg_1771991524
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a77040ede0so71136085ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991524; x=1772596324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxPupLKXKRysmyGd91VNxhdP4T2DZ/YUYcNzsqzSqOs=;
 b=FdFq3yDnD27qFnX8eH3WiPGrhMzKxQh0aEBSkIO0DHDJRVVpZvBmkvIqd+26gpZsvj
 ftgNDioo8iAJTzJpPc0oMRGvR/DUCX/ujSP6PBfJvTRg4lgK+kXs7/gb4xJD9Ted486N
 6Dq495fQ0AiyES/scdFE+8wqfqJYuRtD0QsaOXTsv+8EMKPZNYBATgWcMlQn4If2TvrF
 xArr3ekFbuOnZxCCvt8LWYM1Ak+6s+Vf6lm/HG1a3At9c0Q/pTQUeJT6KcZfg3mEtCfU
 uVGVoN0Y1xt9n0ADAB4YaCFdpshmsqB49msYo7kwMSzfLuPsbSYlU6QRhrXGbt9aH0CE
 0Wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991524; x=1772596324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jxPupLKXKRysmyGd91VNxhdP4T2DZ/YUYcNzsqzSqOs=;
 b=q8aqcaOUqTEhf0Adp6sIRegU60uIjGpLDpW5i6EBqTpNJGHSn+3KbLfnEXakyNumI3
 7sn6IuCSe6VSxuR0tPEqwzb/aWHSabU2QTJLuN7hngkfHLAruNNLKe+3Z+9mmrDXCFVY
 bLqlNy0kUUYFRcj6YDVn+V+Iz0tgoXG8vJYENWRXuUPjOyO7GBH05DLBP3qPYrEjf3zh
 wTxWZx+xxB7WpdJDUqrc63LCXV2LpB/SSTYo3/RyhpfE9zj1OVulty7A5OjxShl52oor
 aWQ05mUjyqjCxX8LMz5LrKrdT0tZb3PD21bnI93sStSbPz/dcAKK6TyRgeg+z5HI3uCn
 PV/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTtTs/K9tVLD/5IUqY0YC6nzECR8QrT7J7r/W57wnWGzHENUkvoO2Bb/zz0ECGl50alw/6qXHRovGi@nongnu.org
X-Gm-Message-State: AOJu0Yw++NDAsgvRLxHuogy8MunAQgvZtPnc6WfQlvU2fYDWBZz4uTl7
 3i6pTyhHmUV6M62UxockbKIgoMXbkv1hUC/KuzGce8ehZRJYmtgfmlJeWeIGhQBwGWq/FXOhTeD
 0TM2RYxT77Zc++bmpXpuyUDcO7hqSRnt3ZeKE0Jy7Gt+ioZP4ZMwl+c37
X-Gm-Gg: ATEYQzxEosEOVfg9dp7epDim4zIKhZPMzaMzZoD0E9Lwn7+oj8fLY8vzH65EYMiegh7
 GHOWFfIfymSMVecmJZ2JTbe/BoyteZ9BVfmyd+fl5rB8UqMYrfzUDvdELAKR4SOihfsgsydsN3Q
 lRpymYG+orQK9V+4wfI/sztrxJfL+EBRLFif4UQ447o1KXPiWEQieMkKxUqtxcP/qnqOhNyR/Lg
 s3MvPQWR9fBFw100ZyXCOzqUVkBoI9lcNdjGtJrnflANLDMvM/CHwIFNzx5z8AsEUcFX+Yh0TuP
 ybwapp1bz01qva2xPWnrD0aFRQe0SpafX/kwc3Q0Ns+Fg4Dm8PDT7v+7Jb0zqRXzFridll+tcjC
 fTvh/Nxbb5BmyYSz2yb/B6nXoB+CHBPX6/mkDJemrz79YcfUJIsfhO64=
X-Received: by 2002:a05:6a21:681:b0:393:c4d:be49 with SMTP id
 adf61e73a8af0-39545e1b364mr11114167637.2.1771991524541; 
 Tue, 24 Feb 2026 19:52:04 -0800 (PST)
X-Received: by 2002:a05:6a21:681:b0:393:c4d:be49 with SMTP id
 adf61e73a8af0-39545e1b364mr11114136637.2.1771991524092; 
 Tue, 24 Feb 2026 19:52:04 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:52:03 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org
Subject: [PATCH v6 34/35] qom: add 'confidential-guest-reset' property for x86
 confidential vms
Date: Wed, 25 Feb 2026 09:19:39 +0530
Message-ID: <20260225035000.385950-35-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Through the new 'confidential-guest-reset' property, control plane should be
able to detect if the hypervisor supports x86 confidential guest resets. Older
hypervisors that do not support resets will not have this property populated.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 qapi/qom.json | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 6f5c9de0f0..c653248f85 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1009,13 +1009,19 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# Features:
+#
+# @confidential-guest-reset: If present, the hypervisor supports
+#     confidential guest resets (since 11.0).
+#
 # Since: 9.1
 ##
 { 'struct': 'SevCommonProperties',
   'data': { '*sev-device': 'str',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-            '*kernel-hashes': 'bool' } }
+            '*kernel-hashes': 'bool' },
+  'features': ['confidential-guest-reset']}
 
 ##
 # @SevGuestProperties:
@@ -1136,6 +1142,11 @@
 #     it, the guest will not be able to get a TD quote for
 #     attestation.
 #
+# Features:
+#
+# @confidential-guest-reset: If present, the hypervisor supports
+#     confidential guest resets (since 11.0).
+#
 # Since: 10.1
 ##
 { 'struct': 'TdxGuestProperties',
@@ -1144,7 +1155,8 @@
             '*mrconfigid': 'str',
             '*mrowner': 'str',
             '*mrownerconfig': 'str',
-            '*quote-generation-socket': 'SocketAddress' } }
+            '*quote-generation-socket': 'SocketAddress' },
+   'features': ['confidential-guest-reset']}
 
 ##
 # @ThreadContextProperties:
-- 
2.42.0


