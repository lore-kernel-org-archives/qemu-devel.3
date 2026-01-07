Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2E1CFD647
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVFK-0007wM-Lk; Wed, 07 Jan 2026 10:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEp-0007n2-Q7
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEn-0007Ol-Cv
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767798856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+b6NAkRwc1jIzqS3KyEOjNsfNtfzRZdJR3QGZ1FAac=;
 b=cX0AIviPZjIye3Gp12UcLlGxJRae93+49Dx/pfdFI/7+Hgko3fA4j8i5r8qqSsBfYx7b6k
 pcBwSG7luTo8Hb3a6OTSRu9PMy6sm9WPEHoB0UlYiG9Jb13+upoj+uJtYgjolG/8QU6sW/
 zG7TgnZs70Son1B/Pm0RDmd5yluWOVE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-msVfdpDgPqKKN6777D8cUw-1; Wed, 07 Jan 2026 10:14:15 -0500
X-MC-Unique: msVfdpDgPqKKN6777D8cUw-1
X-Mimecast-MFC-AGG-ID: msVfdpDgPqKKN6777D8cUw_1767798854
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fcf10287so1622079f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 07:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767798854; x=1768403654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y+b6NAkRwc1jIzqS3KyEOjNsfNtfzRZdJR3QGZ1FAac=;
 b=a5PjIHDceP7qkFHPLbnVCmiKpF6N6cvyC9k5HFzvnxxlw8lJvUO01s7VBfCzI7B55y
 DkEnPZhYdjNxUOA4NqlJsrDJed4H26JSdIDT/CS+8nwoqhxKxrU9Y8ihjUwIDyYjudLf
 SNhzTpO89TcoWQDoSeJdi7VSYsoJu7F9FnLE+gD4KlcdDZ4nO/9WEWACcDllCei+mPhw
 PZY7k6IkAjzlZSyJkq4KDRBuJ7d3AKZ5xuS35GWZ0T4VjEmeEn4xS6etfM4mnFbFhj8A
 oy7eg3dNoR5WTIZB1FsMwF8C5U9H5QcILvUY+6xlcddx4AmhiBbkY9aWMvH5GQwSLymV
 c8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767798854; x=1768403654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y+b6NAkRwc1jIzqS3KyEOjNsfNtfzRZdJR3QGZ1FAac=;
 b=W5h/W38aOWzSOfz3i4ItOta/I6eSM6TDngWkv86ZIB2Kc+CxdxdPe+4gDTEqGgab3e
 xtlOuHXs6iRC710VVAjaXku5lV9Yv6tm++Bp6mLDdE1CNB3Dfc4ECCks/G5NDo3y7fF2
 ncPwY7OMq8/1ZOxt0b7pbXH4tr63VYj11kwxReFxV2B07RFfe9ZajJiSCVtKYiyp9nOb
 wAqMfSG4VVGcSnRv9b4ExXD7NxGhH15cIInTC6YgDevR25bTba1RxGqT6y9AJ/YlGGkD
 MBfqxdrIMLoNPMk2153oaLKohNsj/PfqMXHNkTY4pZPB198fdP0F9LERJJ9kEytslPU+
 4b6A==
X-Gm-Message-State: AOJu0YyOste84Xo0DaKaSbKdGfr/Ti6W0bbphX40ntYhyxdF0/MJ3N7S
 YC5cDYZfdz6lBgj4k4jc8MXUqcQxRIhtEGZQ13Ddf8ldYRrQ3/eqUgLGAch0VKZhBUeJEFC+7mP
 WLCA/DFRxfcI2FnW01jYHNPL3k1dmpoGWdp344d5Z5t6dSzwqQH3et+m3PFe8DS0ynf7g6p8YlW
 +Cdm7z8JQciU0d6dih4dL6mXiiXzkGcr8YthIxdITP
X-Gm-Gg: AY/fxX4ZCC8vDYY4zzWB0mQ6YrZIH17c/r//nvtYVrjAUiCn+szLtsKxleNjcq1PCYk
 3yQAZMadeXNAWNdKcTw5wFw5koqUccbZrrkrrFjKaa/h+kMHFihWn89ARLa8yJy68ZNMOX00/0n
 phHMdavI3KEL+rd/kaie5E6UoIFFJoJinb5QBw1WwL2TBvGJul6w3OTkG/vypqfWOo+pMPBjRLi
 d3IdWw+8DhuRqBOgx+WjIbcO/1p+veLyDlMM7sKVxTV7/pepa/ks3Cp7scZG7mzxRT6iiDL1HiN
 AW2A3y78la84z3WzvXOXuko6tnfKz9AmhkSPBR4UDxdV243WmYi5/obiGk4OHz+A3qMKh1ZBaf0
 BYvN6S8Qq29LsnXCaQscpXHC5lYBlWCZrZcqHPYEL5ww/gPHH25xcVZudNQOH0xo8BCmOVCVB1V
 IuUj1UtcQcbZmK8w==
X-Received: by 2002:a05:6000:1865:b0:432:857d:e42c with SMTP id
 ffacd0b85a97d-432c37c87famr3349081f8f.34.1767798853789; 
 Wed, 07 Jan 2026 07:14:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCjI8Gk0XNVxZKgswRiO/IDOGImv9C2X1KUlOFYTPsFxGLKRxlDH5LKsr6XWWfEOU+sTiUNQ==
X-Received: by 2002:a05:6000:1865:b0:432:857d:e42c with SMTP id
 ffacd0b85a97d-432c37c87famr3349035f8f.34.1767798853323; 
 Wed, 07 Jan 2026 07:14:13 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm10763196f8f.42.2026.01.07.07.14.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:14:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/i386/tcg: remove register case from
 decode_modrm_address
Date: Wed,  7 Jan 2026 16:14:00 +0100
Message-ID: <20260107151400.273916-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107151400.273916-1-pbonzini@redhat.com>
References: <20260107151400.273916-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Unlike the older code in translate.c, mod=11b *is* filtered out earlier
by decode_modrm.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 243df7e3735..7b595607fa7 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2024,12 +2024,6 @@ static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
     rm = modrm & 7;
     base = rm | REX_B(s);
 
-    if (mod == 3) {
-        /* Normally filtered out earlier, but including this path
-           simplifies multi-byte nop, as well as bndcl, bndcu, bndcn.  */
-        goto done;
-    }
-
     switch (s->aflag) {
     case MO_64:
     case MO_32:
@@ -2127,7 +2121,6 @@ static AddressParts decode_modrm_address(CPUX86State *env, DisasContext *s,
         g_assert_not_reached();
     }
 
- done:
     return (AddressParts){ def_seg, base, index, scale, disp };
 }
 
-- 
2.52.0


