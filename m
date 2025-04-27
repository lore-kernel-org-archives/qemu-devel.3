Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8602CC369D1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 23:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Axs-0006Ql-8t; Sun, 27 Apr 2025 18:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1u9Axq-0006Pj-Po; Sun, 27 Apr 2025 18:59:10 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1u9Axo-0007A7-DH; Sun, 27 Apr 2025 18:59:10 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so2042921f8f.3; 
 Sun, 27 Apr 2025 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745794745; x=1746399545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rGYuD4DxYkUVs+1Dcpzny1FKUufmmLwpsZn1qYLXkDM=;
 b=PC0Rrr4lihCZqgIvuLKXjRvIGT0CbHzQSvh9eV8ipV6EYvzJXxVwvhdv+A623Zvu8/
 9cVA5eDo0K9kBUufT18WPhfy/amW81wWhVz2xSEdwOdk/RigjfK6xR6cOseZ8i9VyaON
 gKL1aH8ytGL8TKQd9oJBS8XWtOoo894JWAFJ3qEU1QhbSWNfLCpM6HjXDkN+SZmS7P5T
 9fVd/D8rEQ3fNpQyA30cMKd+AlcFvW2FXbeKiWG2VtzSJiy0vVCI/TiiAr6G06KSW/yM
 +klL0cpD7aNxeFPaiou5mWnlmrpjGg9EN8o7tzHYJLOlaqpdPwLPM9qnWHwpcoyTsMi9
 YJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745794745; x=1746399545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGYuD4DxYkUVs+1Dcpzny1FKUufmmLwpsZn1qYLXkDM=;
 b=fqEoH5/NitfkA8p+U+WM9NiMrP2oZmocrezfz+PdcFZEwxMD8dxO3GHkSUbZVpf5pq
 cWWzcMsRk/jDtandbJOfeRPu4HDQ7R3Vo3uwR2Y7TngXYUBRDTBNo7qnagNnmON5oYFK
 CldwsxIzTaOGwcCxp5jyVYrzy2lCmZ7gBr8xpewj2ua17iiSezN1d0oEkJO+OW61RZFV
 sCtcDGbjsIHDcoYPNMrO8njMkRIR/PMYdFeraTXZUPMb4yX5AAMdvS8J3G/w6SCD+5to
 rdFmIsIA1qWeex0hxdXpXDw50mf93E8JY2LPFPddCfxo00zeffin8h1Mk6sZeayXD9sc
 9/AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWT/MSxeNIbmfyxQGXzg0XMz7mya/BaiuY9vyYOtMiLF+d7NuSd5y2e5L/I3OpFqc7CBy8JrwA89Fn@nongnu.org
X-Gm-Message-State: AOJu0Yz5ASePKCuF3jeQxijBs+bJzobMFhXtaREbq+IeOKCR/dSJZwjy
 zPRPHVOsW21mQpLRjCsZu+T0b4B/BQYTYB8hvp9usSFb4lnqfUF7Cnt736i7
X-Gm-Gg: ASbGncuuo7rNtAVRpyutaYF7X4I9n1cgs36/tzmzMPMn6F/I+wXh74En+S1ZAWZSsYK
 Xy37m2ZcClzxVGLBVCGUyVk8v4c2+5yTS+D2wt8IZUklOS9fejBGemjIKl0r0X9kqk7iZ60qnuv
 IsQLfX0I9tzT+/eU/GZuRrU4I4+zZxqkKIXD7q2iRNXb1ukJigCwomj838PHJ/edyPaA6EYM833
 4D0zslXxj1g3hvFQAjGgAqVfewn1ZC+Q1Hejk6YAEiXSidHcutWoiis85JTOHmw8fyxVROaA6iK
 9Z6TSmZqw1DEYoDLADu5LE2n0BhPXf9TLnRw+Sa3vwx6H5VjCFehQtba5yeCrOJwNkNWb9iA9lE
 PY5uXj/xEQEHl+/Eo8ihRreg2QgCAoA5N6RaD+bA=
X-Google-Smtp-Source: AGHT+IGnH0+3Ira0Y7+A/EC+XN7kUGurKPrs/rwX0aYDXk2Y5hZkxx8jLkr1CdEEsHr34I4/z9q/MA==
X-Received: by 2002:a5d:5885:0:b0:397:3900:ef80 with SMTP id
 ffacd0b85a97d-3a07aa66795mr3653654f8f.22.1745794744949; 
 Sun, 27 Apr 2025 15:59:04 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5da4dsm9499765f8f.99.2025.04.27.15.59.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Apr 2025 15:59:03 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH 0/2] block/null: Add read-pattern
Date: Mon, 28 Apr 2025 01:58:58 +0300
Message-Id: <20250427225900.24316-1-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The null driver is very usefull for testing and benchmarking, but it can not
emulate an image full of zeroes or an image full of non-zero bytes. Such images
are needed for testing computing a blkhash via qemu-nbd or qemu-storage-daemon.

This change adds `read-pattern` option allowing emulution of image full of
zeroes and image for of non-zero bytes.

I used this for testing
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html

Nir Soffer (2):
  block/null: Report DATA if not reading zeroes
  block/null: Add read-pattern option

 block/null.c         | 21 ++++++++++++++++++---
 qapi/block-core.json |  9 ++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)


