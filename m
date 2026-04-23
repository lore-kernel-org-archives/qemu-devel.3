Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC748F9936D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrLN-0001zm-Lq; Thu, 23 Apr 2026 06:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKp-000169-Oh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKl-00068Z-In
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZgCBxZaWUy47pwY1lJ5j+kzE+lzpZxqs4AG0JiavTI=;
 b=RVn02mFh1rAtcS83Ocol1hLF4nai8QlJapCsJMp3++PYbDcESBUMn8nz1ec/OrEEH+OALs
 E2FEFi7HN6kkOh37JS5z//fUKOYNLOQEMq25Q86yudYlOHbE8/q6vuoVNFTRNXJGRgb4DQ
 VrS4fgf4fGkrHWo73bQspdkXWunRXIo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-lBSUd1U1PReKG5DLf7p1gw-1; Thu, 23 Apr 2026 06:30:57 -0400
X-MC-Unique: lBSUd1U1PReKG5DLf7p1gw-1
X-Mimecast-MFC-AGG-ID: lBSUd1U1PReKG5DLf7p1gw_1776940256
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488d2cd2674so50152585e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940255; x=1777545055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZgCBxZaWUy47pwY1lJ5j+kzE+lzpZxqs4AG0JiavTI=;
 b=bp1S49Ni2skfU3I9C9zQvHliDhe3eoILdY6W6aMUeY7tUVyggCNxe3frocrJTvWhC/
 2hxPV9/KTMhDlFfsEp5uwDBWVebseZepmeogRo59bhyI2tagJaLJNdsjPByap8ZN/CSo
 ZY6nQQ/KrmKtGjQatzzQqjQDwB/rBEfbQzupElWX3Ue88q4i9HVgG65YzLS2YdqkDoKT
 MEg8ViYspggjB1R9RVlErFwI1syZVSIXp/XqBC7jST27CaMaFbWlkxUrARCLNnFSzvxg
 6nuj9S8oLxNL/PkdateaMVnMLdbGb/oEOKRw7rrrZNWJ6KlP/Q5lNty65KCppiab2Mg6
 ebiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940255; x=1777545055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ZgCBxZaWUy47pwY1lJ5j+kzE+lzpZxqs4AG0JiavTI=;
 b=gPNyLDZAh3xgrwWbX3BOewaocwyiftEW7d58txB48KTqPyhIGpuJtXHLO6J/JJsw0c
 UmyDFTq6hMcIfKXkx8ARwCcfYD0mdWvy0j3/WM/PVMtY+EkNQANKGf/uMx0FqyrN9ZoU
 lmGsoy58FSE/SrrezKMP5TZS0ZfiIWCXJz+IHmm3TfD7assUMmtVrXGdsD2RncZbIw7U
 IW5rhX+5apKqzgxD+E0U4iXVWO3MgF+Cl25XrSnWeD2+QIKd5G11fumfcT2LhLwj/E64
 N/mV8WF8Y/iiwPdHT5PZwC/W3mQTq5+eXHu+F7CVQ6phFzjAsa1n2nDKr/JCRi7z40H3
 1Muw==
X-Gm-Message-State: AOJu0YwG9w1ZGDLSmrFmixg/sAsO/gj5bFekM0XqQqBybElwG/9SmFrt
 O42/kSzliyow0bH3hWhsFLFHezksb8MZEvCtKzJxFqza+xGw+ImdS301yA+PLjaXsttvUGJLeIy
 hBk5o69iQQQdqcjH3besgCnihKMB4uhSC9BgLEzLxCdvvc83DTtM6OD9AV3SBMls9INfnkMPFWu
 zJ06U7DGiKTGMn6XpCaWUMv/hozD85TFVT2/nG2V4Y
X-Gm-Gg: AeBDievVYGrd6YRVA+d0PTjSZHOsGB8xMvN5mfTgUaBTQsZKKCjLKkDJM5h1+KWQA7g
 exwlS02WQKjOSTKwAAdIc7oGqwB9ucjpcIv8zV0TRxg/nSkzh0MnzwItkQNEU2/23US+a9wJgEj
 qZRE640Ef5FR4G8yMt2+WAxCphp/0/5WgUgD5owEd5Ukryeyyu44A8SjB/E1tPAol0Bp2iJ/Ukg
 28wjyIMt9jJ5zKXaHTB1Nai8nJZk0yG9WeLJe/IXX4PAQCYPo1dBqSuCyDikCVHORDu7FKk+30i
 CYoqQROw0pW1DuTXeB3pV2iRsZXtDqseiXvAv7YPqG6vVd/UTJFtCpFCY4bf7dEnlshBq65VtTN
 uSuSDlycSW2iHIbL8ponqioMRf4EKVSA94f7S1Ar1XBEN2TY47d0jRPOMtMTk3qKvabwZXkFjT3
 arYOEZT49IOwrQ+KCQ5PUBIKmDZjY5Zpc2FHM=
X-Received: by 2002:a05:600d:8408:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-488fb74c61fmr293882325e9.13.1776940255335; 
 Thu, 23 Apr 2026 03:30:55 -0700 (PDT)
X-Received: by 2002:a05:600d:8408:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-488fb74c61fmr293881945e9.13.1776940254767; 
 Thu, 23 Apr 2026 03:30:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5d27d6casm21943005e9.27.2026.04.23.03.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stepan Popov <Stepan.Popov@kaspersky.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 23/25] meson: add missing semicolon in
 pthread_condattr_setclock test
Date: Thu, 23 Apr 2026 12:29:20 +0200
Message-ID: <20260423102922.443639-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Stepan Popov <Stepan.Popov@kaspersky.com>

The test code was missing a semicolon after the pthread_condattr_t
variable declaration.

Signed-off-by: Stepan Popov <Stepan.Popov@kaspersky.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Fixes: 657ac98b58c ("thread-posix: use monotonic clock for QemuCond and QemuSemaphore", 2022-02-22)
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20260330131406.87080-1-Stepan.Popov@kaspersky.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index a962b181e64..096303f021c 100644
--- a/meson.build
+++ b/meson.build
@@ -2890,7 +2890,7 @@ config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix +
 
   int main(void)
   {
-    pthread_condattr_t attr
+    pthread_condattr_t attr;
     pthread_condattr_init(&attr);
     pthread_condattr_setclock(&attr, CLOCK_MONOTONIC);
     return 0;
-- 
2.53.0


