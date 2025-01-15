Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1353EC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY27G-0003Sw-HJ; Wed, 15 Jan 2025 07:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY27E-0003Ma-4j
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:03:20 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY27B-00089d-PP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:03:19 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso8313803a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 04:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736942596; x=1737547396;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4APj6hNJNlyxYts//LeId/m4OuOA5aaRMi53kfEXwNE=;
 b=3XIKvO6+080sOfIsj7KsRerThvthr2jMujJXhycQ2P110ECzV7Z2CGnz+D7TBO9e2w
 2Om2s7L2pDygp4i9xIwS2mA82lgFe3c5TylkUbXEryQ2Co8hMkZQlYaCmfKwCvf+YuUr
 oia8b94SSeRLklegDCu1DjIX53fCGaq2zvJ4IBqzp3WrtIXK/BoOFz86QDKbZreNi9PF
 ODE+Ywz16cx0biQAnljHb2Fvejqn97A73sE/22T6UbjswUTElGrcMFoXBOHA7SpGT2Rg
 1vGQZjqKhS/O2q8o++ATJgQb6T8Cl6DCkK8WfUovH/UcifvrbZYbkxwRYQgw80M+xD9Z
 Iu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736942596; x=1737547396;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4APj6hNJNlyxYts//LeId/m4OuOA5aaRMi53kfEXwNE=;
 b=dwPaNWf2ddC5sKocC684pAM/RpR5gAL9YZSoK5cCwrXfcH+OMlcIrQRTov+v9+G9Jg
 2WXQRu6ZUsXRxO1muJhSLkJx71HTaQ98qsv+NMVzHg65CsTXM5PTsOuUG2s5eJJfWJfE
 QYemChufRuESERJJmljej+Jjs/L48ii5Ei+8Ka76GaxJWcqMmcQCWVacLpIFAZDBMouJ
 tLKXVJGxYJ4vbJPW5WdMSjpPk50v5Y+xUklZibmBXT2/xtMwtRpQ5ie0uiH/vTjtihSX
 QcTPEoi1invAXjDDQ1KqGlp9KhxGlQOOURR393i/4RvBVZMVhIeVVBjE68KVlsAzAbeM
 8pWQ==
X-Gm-Message-State: AOJu0YzqCF6d7H2mkEAm7cBP9iy7oMjRYpX8fxCcwVqfpgelFDCjtnCC
 SvezLfvmV98isUkO5aM86SZQzP6WqYNbNNW2QwYbVlmaVkYv9dhxNGaI1XlMcRpr06MA86bUtDB
 12wM=
X-Gm-Gg: ASbGncsGXnWfKZUYfRCTP+TN639NezISzUWEgpjknCwxc0ufvZD3eqb7lpyQLXvot2S
 5r/+Ftkv+Ij1lwdxGtMi9KlkTNlhA5LZbXyeg61fdrY/ndkQV3oYqeh2gPtMnpkdm2xj3fGmxtE
 /vTEehtpT2pXsbHwggWXn93Iu4ZdfWfXJ5G46weJcvhCEyfu/xPD9oCgy4vZ3NfX/dc4Q4f4Xbs
 Z1S+K/6sreCHI+Tnq54MvwUuzYqePHLiEdXf7j2Cmex82TGFixKlHaHghbW
X-Google-Smtp-Source: AGHT+IF3nucq17ZGThZ8D+ts82b9sgeKRF/wqf52UvUFRtogtIVoXBi++uNFl1EHyZbrtktJA7BC0Q==
X-Received: by 2002:a17:90b:1f8b:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-2f548db860fmr49084853a91.0.1736942595574; 
 Wed, 15 Jan 2025 04:03:15 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f10f4f3sm80646245ad.31.2025.01.15.04.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:03:15 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()
Date: Wed, 15 Jan 2025 21:03:06 +0900
Message-Id: <20250115-glib-v4-0-a827b2676259@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPqjh2cC/2XMTQ6CMBCG4auQrq2Z6bQIrryHcUFphSYKpjUNh
 HB3C8HEn+U3meedWLDe2cCO2cS8jS64vktD7jJWt1XXWO5M2kyAIBRY8ubmNAeSFUmtQZmCpde
 Ht1c3rJnzJe3WhWfvx7Uacbn+BCJy4KhBghFFrks8mWrs3LCv+ztbClG8lQIEuSmxKAFIV7LqU
 Ig/RR8K1aYoKW0IFZGUeVl8qXmeX65QbegFAQAA
To: Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

g_spawn_sync() gives an informative message if it fails to execute
the script instead of reporting exiting status 1.

g_spawn_check_wait_status() also gives an message easier to understand
than the raw value returned by waitpid().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Changed to use g_spawn_async_with_pipes_and_fds() when available.
  (Daniel P. Berrangé)
- Link to v3: https://lore.kernel.org/r/20250115-glib-v3-0-bd3153344698@daynix.com

Changes in v3:
- Added GLIB_CHECK_VERSION(2, 70, 0) for patch "glib-compat: Define
  g_spawn_check_wait_status()". (Daniel P. Berrangé)
- Link to v2: https://lore.kernel.org/r/20250104-glib-v2-0-12013f3e5782@daynix.com

Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/r/20231219-glib-v1-0-1b040d286b91@daynix.com

---
Akihiko Odaki (2):
      glib-compat: Define g_spawn_check_wait_status()
      tap: Use g_spawn_sync() and g_spawn_check_wait_status()

 include/glib-compat.h |  11 +++
 net/tap.c             | 220 +++++++++++++++++++++++++++-----------------------
 2 files changed, 128 insertions(+), 103 deletions(-)
---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20231219-glib-034a34bb05d8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


