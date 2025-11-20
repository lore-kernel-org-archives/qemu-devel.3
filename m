Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7727CF6499
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMP-0003BJ-8r; Wed, 19 Nov 2025 19:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMN-0003AZ-L7
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMM-0007Ro-7a
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1NK+wIpV+Q2uLt75RKB2mtL15WC7Pac5R8gwVj0dKEA=;
 b=EFIfDTSFg9xm5rt7r2DeJ+kXAxHBwLLNZHfSVMdUzU1zFu/YAURNSe4Cb4pwEtRBwmXoG+
 xib7ftiEsE89cjB3aDqBlXQnDu/1YKKDYowGwZy/DiT0N5y+c7Q63S8GNGE3tZOzmpcstr
 3+UvVATJFLvr/AyRG90MsHrs9iJtGWo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-StYW3iqFPVKEd5Ws7uneoA-1; Wed, 19 Nov 2025 19:17:12 -0500
X-MC-Unique: StYW3iqFPVKEd5Ws7uneoA-1
X-Mimecast-MFC-AGG-ID: StYW3iqFPVKEd5Ws7uneoA_1763597831
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c5da68e5so127775f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597831; x=1764202631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NK+wIpV+Q2uLt75RKB2mtL15WC7Pac5R8gwVj0dKEA=;
 b=I7uQ5OkY8igmg7kXv8w+grkW+2XrmP5ogKWnYrLPw33aATmAadI6OGNAjgKEwNC8iK
 BhipSZ8yMSTZieaj3QLKPakx2KiSZpfJYgh0PZm6AUFtquLlP6kcHOJP4xAWiQV5GmMq
 DXVFHXYW/Z9OCBiQLEOQAa3kheiTX9pJezg2i73CvvA5fcJ1ziEmfbccixINXmpgPC3I
 iCkawF+MRrL+6er7jZgpDZjNJH/p0yN++uPv2OWine2Vrj98R/nzpTQ/UmUXItOwcRoI
 OAsEhqZF4F4vKVNnuzWVCL0OjbO46C/5AQxaEG5E2eZr+JYCrv9VUcnKCWcLvnzDn3Iq
 Qlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597831; x=1764202631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1NK+wIpV+Q2uLt75RKB2mtL15WC7Pac5R8gwVj0dKEA=;
 b=isffgXBIWAQytr9kkjThv4uTY+OF0HtpPrYeiXAThsN0CgTkIsVyYQ4+cXVjcjimQb
 hQEgKTenmBUeoOn1M+q/Yk2TNP2kUnKvy12hIdgLiAV8EjBWv3qLEZlwcJCWu7298eyb
 BihZjnV8BgKgBgZC/znr6cG/lUjTWWsZ+4qKAKeUFuJ/9lnlmQ6lIuNtX6iIzflBGrsJ
 UT4Dsav3Z18iVFvNRkYgk1Rwz9zX91nqNO1DY+WN3b19/YHkFJvVFlWHo5tdgM0skrzR
 4I2zUxe2tf0sUwBNjyC/f0lr+JcvStOw05NYLCyS7MhNlKtj6gYCZDdtKKlxQS7jERT0
 +xfQ==
X-Gm-Message-State: AOJu0YwA0mBANrFvBB6U/ubQjuM4s6lHNNyVcn/ms0wSKY6oN/YfLlWu
 /1Qglvvd0q3HK/WlERgpKzHCM8b6UFdzSqZcK3lpqEQaN7ofpDIOvI4R2SDU4yt/i6R3rkkLnf2
 TV/+gNtIddiRjmCkNJO5Hyfn5nK2ntvRH0IAGPJ5TXZvnon4wgCyIVsj4VCj0ZEYBpbjKOFP0Ni
 otedXu+FBnEctI5iAgi4CZ3vfZhf+IbE7iYNdY/Q15
X-Gm-Gg: ASbGncvAEV3A09HiluMvfbFX36MDDlzQftnzrkj4f+K88uqMR+QPCp5nlciqrz/36b+
 h3ooLvtIBOWuMXtw3K2ZVQLtflsc3mf9pXHpq8oH1CgGCrwP1ddgkg0r+xHzc6R3LrVLYXLNuNx
 6zyq9DIrjO3iQTiY19qTDtRtctRPogd6cDeTmbPvKgiCVe4gvcQI0zkeRqGGL+BA+0GqdG/EXHb
 t9m0DIIIv3Hxa8QumEz7kb1b2hQ6M7IOgqlYTfiu4Uz1sQghu/8Grfq00tnm1bKMdXb20oug8rB
 +w5wkFfM3z/oNW3HG3ZhoynXtUzEGmMbgkNbzYBcCnQxBNCPWIp1eBr3tWgGd0wPZRqnFhFNzFO
 qJZdNOPhxEtp+4uZOkDKgyFyW+sLdLJj9XmHBK/qA9fyq6DEQPNrbgn9SELZ3Pw9jeOCVmTZzbv
 mJ1hCHOaaIAapvVEE=
X-Received: by 2002:a05:6000:401e:b0:425:6fb5:2add with SMTP id
 ffacd0b85a97d-42cba7b3fb8mr406273f8f.19.1763597830655; 
 Wed, 19 Nov 2025 16:17:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELPpkpOUTkzLgRq/wJ325bdxTrRVpcXzz0M08oUI7v1aIwnE3H9Xk3L0nohQJ9XoYh507rkA==
X-Received: by 2002:a05:6000:401e:b0:425:6fb5:2add with SMTP id
 ffacd0b85a97d-42cba7b3fb8mr406240f8f.19.1763597830136; 
 Wed, 19 Nov 2025 16:17:10 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f49a7bsm2035124f8f.19.2025.11.19.16.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:17:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/10] mtest2make: add dependencies to the "speed-qualified"
 suite
Date: Thu, 20 Nov 2025 01:16:47 +0100
Message-ID: <20251120001649.1085913-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Thorough tests may have more dependencies than faster ones.
Dependencies are now looked up based on the suites being
executed, not on the suites passed as goals to the makefile.
Therefore, it is possible to limit dependencies to the
speeds that need them.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index d7c514243a5..38512046d97 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -58,13 +58,13 @@ def process_tests(test, targets, suites):
             s = s.split(':')[1]
             if s == 'slow' or s == 'thorough':
                 continue
+        suites[s].deps.update(deps)
         if s.endswith('-slow'):
             s = s[:-5]
             suites[s].speeds.append('slow')
         if s.endswith('-thorough'):
             s = s[:-9]
             suites[s].speeds.append('thorough')
-        suites[s].deps.update(deps)
 
 def emit_prolog(suites, prefix):
     all_targets = ' '.join((f'{prefix}-{k}' for k in suites.keys()))
-- 
2.51.1


