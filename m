Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621D6CCF9EE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 01:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEHrH-0000pV-Cc; Wed, 29 Oct 2025 21:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEHrB-0000oy-Tu
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 21:53:42 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEHr5-0003xx-06
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 21:53:40 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b6cf1a95274so295800a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761789206; x=1762394006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9PYdtPq/gQiBvKY9grH57UZdyPF18YiYW2MY/8WcRk=;
 b=Zp64ef5fm/ronky1v+butGFrAkMSO9XaZwC8Fmx5hIS5fyf0FLwwFwyy3jGU/B1ZkS
 cSNGZwMEWWT0g2MxgRDfkDdemJW8SCia8Cmsn1aAupI+HgkXFiexsFf5MjzzGs3gWdvA
 p30/+ExcIBvlfE+AoZQ752HvKEu5IlN0dA+2wVsPobAwG/FifIU7w2QgF0KhodeZqYO0
 Ohk8eyEopZlgb36mrFwkqBiqXzSCnhlh+pOQvq+4fu1Jl8pKp5uFeAJ9giuYlCvBk3q+
 AMLrxAnZU1E2Q0bWk5Gpaw/ddNFjFv3BFgqrlLu42IVrHkd5f+yg4xoetJobOWzkVMaH
 i8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761789206; x=1762394006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9PYdtPq/gQiBvKY9grH57UZdyPF18YiYW2MY/8WcRk=;
 b=c+urt72fde5X7ur6+wcDgLsoIAd0uFb9MGF8GRKcUrviHGIrn2qUj5xUVyGl5THC7J
 EKBOGPlqlxBcjyZUKBD2dAllBFCIoJS2AsVzVyNosUXuHL6tVwgyrAY2zxt6WI6Hd+4/
 hhKFyv2QOd/WmLBnP9zDSl4lXh5UkymueEFUM+3ABWhKV2xqgx58vFPcB6M+ekDyqRvq
 G9fa/NgwPAM4la+47cvUeQVGMi9tz2iIKVMV9s3YH+kPxGZis6DhtrLiAC7oZHAxIrcK
 WHj9SxKQVl9bSj15dFZ4qCOiaI1Yk6XVPPotwrz3vwhSZJzHO62h5VLXWARCHVlA7PRi
 XaZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPcTvncP5m+LQiwxQCniP1GgREBqbmi7wnVoIVv8WiP24+K5UoQIUDnZRThSUj4LJ3XHc0CLPjvExx@nongnu.org
X-Gm-Message-State: AOJu0Yyu2i8Eu3fDK6IDX/42mIXpao81TQA6uYTON95J+78XSvC3Z/C/
 7BbGD4u3dhrW1FW447WwNSzlq4s0QJhf1LeP0F7OnXeLxn9qq6PeUM1QVG+vAQ==
X-Gm-Gg: ASbGnctgzf0yy8dsMeOCAEMf5H2KlxMA/fe2jER952XvC6AKLwc0SZmMemhO7qp4BNV
 BpHWKG5PqX61TJhVSVa1KJ3+6gnkgMwSZEVuglAGvKNIHtvava3CYolkqUZ1qCiQIdaMYe1gg3l
 A8IFpN6YTE2ZqsLS3ms1Khbh2DU3ShjtZJ954qlApm9ia8+0GZxqhlWXJfSXIXUqLmQ+auER6LA
 yriGQrLWElQLsHrX5HmkjX5baT/vCJ7+CnXyqLl7lQQ/3W3gjtaP0ahVkoX/CIyCRGztpxz3MxV
 alBkijm7ASbncBVIxVryAO+6Epb3c1B6vEgLKqkQEAVlmDrjoMIAI2FswmkZ+t0035e70diHpIb
 wbMN95/rIFDCFWWNA3wN/K+lJer1GLeAmoKZ0M4VXSV8I02opx3OBbX/KKUxYt703xhsSqPcfQP
 05gkv+F2SYha2jkjxPa6zy18PyE5MdgeC8MAvHGFD3p8yyppxAWOZ0E6c3KuFHwVfD/JoVlGXYE
 mHxRfjRuuywEtQJAGk=
X-Google-Smtp-Source: AGHT+IEpTeUOpQeADD/10RPy/N8D+gu6n+Wr0DvfXGSyDeb+VYX/r9Oc7M65SX/c3KFfnNVQAzyDMg==
X-Received: by 2002:a17:902:d501:b0:294:cc1d:e2b5 with SMTP id
 d9443c01a7336-294ed92718bmr14300115ad.0.1761789206441; 
 Wed, 29 Oct 2025 18:53:26 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3405089b069sm586981a91.0.2025.10.29.18.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 18:53:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: philmd@linaro.org, alistair.francis@wdc.com, vishalc@linux.ibm.com,
 qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 2/3] hw/core/loader: Free the image file descriptor on error
Date: Thu, 30 Oct 2025 11:53:05 +1000
Message-ID: <20251030015306.2279148-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030015306.2279148-1-alistair.francis@wdc.com>
References: <20251030015306.2279148-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

Coverity: CID 1642764
Fixes: f62226f7dc4 ("hw/core/loader: improve error handling in image loading functions")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 73564a2a46..1598dca03c 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -86,6 +86,7 @@ int64_t get_image_size(const char *filename, Error **errp)
 
     if (size < 0) {
         error_setg_errno(errp, errno, "lseek failure: %s", filename);
+        close(fd);
         return -1;
     }
 
-- 
2.51.0


