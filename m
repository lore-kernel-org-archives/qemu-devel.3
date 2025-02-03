Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C461C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyr-00086A-Kp; Sun, 02 Feb 2025 22:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyn-000814-72
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:33 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyl-0002fz-MN
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216634dd574so43914055ad.2
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552710; x=1739157510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgGWKoRbIU40nf+pgjk4xuoPstQyTD/DlLIN5LNZmQ8=;
 b=SGH+HAnshnpsmxo1zn3XBxSHOlf8mH7a7OeN1XA+Vz8LGosrPb75U3wTdfng9gqpLv
 IbvSiDiuYuiOqqH5jTdp7gNLHY+2mRIz3TLKLSnu9uz+HFPVBh/yppGHOE9qYbSVAqBJ
 XsMPJBfhyutJZXuRciOBrD0646PSTHCvR5vVSo58+KlS5huVED7HOuqRd2nD9G7uvPS4
 lviQDhTiqP7DwdZ4VD6BtUYo3M4toZW/mjbjjj/m7JnFR8PdCNsSmpZiMF9JBG1IGo8A
 1CBq78Ux0opLi6S35yQN630MOYFCLaEu8amh7VjXVzacKzq9C+v6q1i0VwwG8FGNJMJm
 /b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552710; x=1739157510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgGWKoRbIU40nf+pgjk4xuoPstQyTD/DlLIN5LNZmQ8=;
 b=OCjSfHqfX0+wENbIS0k8YeSc6seV0oRKPKCfgivEl8+ith0Oe6wQGItIY/ysTQ2V1u
 UVEly58gEQEwnJRzew+/mdzRlmi9VZ7jsrCm8c+tAn7+1zPTHqmeRsN8YpFQx7s9qk/a
 UmQHqLcSt2ee2MhWxRs8rAW5SiadUk6HqBEu/zPPejTMNyA/R3AiAHSXNA9ArUnJHOER
 j5B12J6IkOhNtR2VJpuqAbZkDtX5sXseQ4wFOKE2k5FkwXd/WwBQPW15l73hYVBrZSIq
 0BW1/991hrODxrG36ie+EpIFT7fTAhkfpB21XZkJzedWeuCMP+lK6Q117u0YmyG6RrTI
 HJsw==
X-Gm-Message-State: AOJu0YwMrSGRZ6wl1rm/pKiLC6ewSTLloZrNkMm4ITyWt/8BtMnpOlgG
 cA16bZ4GVjbrLotFD6sYIxJ7VG/n+EAANwo7SrCyZFvAB/vbfPx9xpskLSwXs9Fv5JtAA7NVUMO
 5
X-Gm-Gg: ASbGncv4wwB4zXGEpkz84w0UAdbWZCw8UKjUgNic1OUepscJTPmGVT2cpgVxVOMXWFM
 UcnyB0af0RA0InBzHFMjSJksqkvP5tLGWRVmHqQ9OyLz8W6X2/6LeziNrBW/yMNnfshfwZ7ScBC
 Y0I/TgOwRT5Cu4qwLE9BnlbJItnpaqVnWiMs4ShtakIZzJk8irumr3D4/+5kQ/KLLcRZ1kXIk/K
 Deima5x0S6uF4ewFyV9wWEfRXpBJlXD9sxmGzXhzfu0RDa/JT6lEHwCxILSaDwvLKARIIDRwcla
 OYkTO2iez1G9r7t2L5j44tc/A2dxYOv9E8SkkIut9OB1cOQ=
X-Google-Smtp-Source: AGHT+IGgv7fqmeVYHTK1dkXP9SIR9TaXOuEADw07S8izflkU455myvlhAZTlkelsJH3c4f1Lu6cSFg==
X-Received: by 2002:a17:902:f54e:b0:215:9470:7e82 with SMTP id
 d9443c01a7336-21dd7c55e3bmr323465985ad.4.1738552710409; 
 Sun, 02 Feb 2025 19:18:30 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 09/14] gitlab: Replace aarch64 with arm in cross-i686-tci
 build
Date: Sun,  2 Feb 2025 19:18:16 -0800
Message-ID: <20250203031821.741477-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Configuration of 64-bit host on 32-bit guest will shortly
be denied.  Use a 32-bit guest instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 95dfc39224..7ae0f966f1 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -61,7 +61,7 @@ cross-i686-tci:
   variables:
     IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
-    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
+    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
     # Force tests to run with reduced parallelism, to see whether this
     # reduces the flakiness of this CI job. The CI
     # environment by default shows us 8 CPUs and so we
-- 
2.43.0


