Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D2FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgl-0007jv-87; Thu, 09 Jul 2026 04:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgj-0007jB-GM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgh-0008A0-9M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so11221215e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584048; x=1784188848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jU1a90ZfBRp5/0sdNCZ+p4SXKU0IB+parub6rmY9ydw=;
 b=Y3CsVR+HmLkpYaFa3v4ao4JmZsxJBANdCJazcYEeETPfsrGUCslFOeoCbMHbylLuFF
 N79687bd74Ze68G2aE5e67GkXpomEPRYIEtmSbDpsomvIzx9kZzMgwL4ITzvAj4cKVLl
 HhJrn7eB1XZEFXltgn80Z3MfPd30rNE6rcS8zWxKb4GcGxOebLzx4DJ05BafLFOxt9bY
 aUSGVqq12EJWFVaTfbrHjqBb0NKuBdx+tSyDv4XsrjgHrxrkVoAGsE6/XOXHDv77lkFM
 sKY770C7lADti8/W06nYeuC/prE46Jm52ARo+8mmYj+OaPKdyN0MMaJ+t33Y0OaF5D6y
 Maog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584048; x=1784188848;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jU1a90ZfBRp5/0sdNCZ+p4SXKU0IB+parub6rmY9ydw=;
 b=HsdViwdStZ8CaBe5OYu1Pps2m63378AXbowUM4R5klOuzFRnfe3X1FoDqYAXzol/Qo
 1EUhh7yRg1rJLlSECqjkiWnZshz+JBV+h0/ZWgnxnvB/Zh0NK45UcUYLPJFZUwFD/FAp
 qBQ4Jz7gUzE34nr2XlftImAJjVIL9YUqHtdeWvigk7nwkXpV5yNL8n5n73VEufqCahB/
 c/VUER6Cmzj+Lvw7lh86q3gzPCIJovbsAM//0IXzeqwe9ZON09rvV9ZqcltCmuyfP+tR
 n4IJn1RrrfChjgJTGTOhXzostE5qQmyyNjxeSIRHsJeZdoGiOo64su2equY6H37CYDpn
 ilDA==
X-Gm-Message-State: AOJu0Yz2jNNCdOgARlWwLP0InFod83rXg05cszYCFCo/f24Qg0UFW7lP
 GagNNQ5T9+eyc0L6BzhTyL+o470R/taQYlAxWjoEOh6UPiUhFfIZjENOwskk0DirUcA=
X-Gm-Gg: AfdE7cnmdmg3wP+/KLBq5ACxbI8NNpuxY6UEO47ajN0kuynBL3EZOo57GRHf4VJ/oGY
 CUsp6LcYWia9wJcD/oC73MAAabJ4ZmdiuME8/nEJ69IZ/HDM5P7see90lLDvLRpK2D0jn2nWITF
 RJ4tIY4cVObkF1Aej2i5+KPIKrTrKavbl8IV35hS/kS1/pxDZSQdyA2k1F/1h9LcUrg1AQ0YIUW
 P1jItJdENOKxVHKu+OOADUZliXR4c+N7X+zhOnE/xKKqusdVjdYQhZM93R/3poplxw4qvz2WJTC
 8UuZECYFvQMy21pClZE+PjGhrxlpl46R+SdLzet0SAG0xCDACj+po+v78zVgQAAXddz0dAkZGGf
 DDHJFHWEVxJkcAqAZGqYrNqKFglYDEMmoXZOjdTFqDuLuRUWn9K4evH2e1IdgjAbKT7lSfYTzJV
 SDASzLN4j9rzhCw8rM5e1f4rE=
X-Received: by 2002:a05:600d:8443:10b0:492:1e36:1fe9 with SMTP id
 5b1f17b1804b1-493e68e0d0cmr43207145e9.37.1783584047851; 
 Thu, 09 Jul 2026 01:00:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df6d9sm50271705e9.7.2026.07.09.01.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B5427600F1;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 eopXD <yueh.ting.chen@gmail.com>
Subject: [PATCH 6/9] contrib/gitdm: add group map for SiFive
Date: Thu,  9 Jul 2026 09:00:36 +0100
Message-ID: <20260709080040.4157324-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Some SiFive contributors use there personal emails. Add a group map
for those developers. Please confirm.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: eopXD <yueh.ting.chen@gmail.com>
---
 contrib/gitdm/group-map-sifive | 5 +++++
 gitdm.config                   | 1 +
 2 files changed, 6 insertions(+)
 create mode 100644 contrib/gitdm/group-map-sifive

diff --git a/contrib/gitdm/group-map-sifive b/contrib/gitdm/group-map-sifive
new file mode 100644
index 00000000000..6ba761eb225
--- /dev/null
+++ b/contrib/gitdm/group-map-sifive
@@ -0,0 +1,5 @@
+#
+# SiFive contributors using non-corporate email
+#
+
+yueh.ting.chen@gmail.com
diff --git a/gitdm.config b/gitdm.config
index 8764bf2f9ff..8206c0af8a9 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -42,6 +42,7 @@ GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-microsoft Microsoft
 GroupMap contrib/gitdm/group-map-netflix Netflix
 GroupMap contrib/gitdm/group-map-redhat Red Hat
+GroupMap contrib/gitdm/group-map-sifive SiFive
 GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
 
 # Also group together our prolific individual contributors
-- 
2.47.3


