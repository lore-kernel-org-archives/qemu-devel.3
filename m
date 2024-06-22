Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F819C2BB85
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu2p-0008M9-Vh; Sat, 22 Jun 2024 02:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2n-0008L3-TF
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2m-0006NW-D9
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INLXKQAnxyLlbt49tJcziQ4qLBnfUf83esez+1sBRI0=;
 b=BCakeXIB+tk4/AK6zrksoYIzUxK/YnM45SK/xRX5UNNWAUOtBdW62EkKihqimaHnF0PYmv
 P90yY8J8d1I+3mhNHJPIQRoJTZekjdIRmG5sClPs2NluL+CjK1XWjlJokIT9ehmkK/ZPnm
 Ngl0QcFuHO/KEv4uRSMjekZh0SwFdE4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-AICYOFVCOVqM91qjriU-qw-1; Sat, 22 Jun 2024 02:16:05 -0400
X-MC-Unique: AICYOFVCOVqM91qjriU-qw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d3d594107so290192a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036963; x=1719641763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INLXKQAnxyLlbt49tJcziQ4qLBnfUf83esez+1sBRI0=;
 b=sera8gBAHJK8F3zE9wfYqjkeRddDb0SG3lPnh+Sjzod0dfSZYYfkkpRZk0Owz0aSrp
 6P7rJczf1ARl9rV9DTWdc/3ka/CYaxAcUWiV011z2bRXcxOBbm/5jj4JXD/q78xWPKSZ
 LTdo+1Y4nuJYjyJz7QBNIS9vpKzhsSTUSSMohZAo1r/y6QBOKNat1edy1ClljMG9M2Vz
 GpDJ2PEXYkrVnWmi25uQoTB+u7BZQP6WiVord3Qr3pkhJS6BkO9KlFLcDUJBBMGSJv6I
 xqXIgG+2fdG23GcglK0Cj8hZJ+CpSgEnER2K7VJSj3a4zxDogb8n86z6kCm585yTyCy2
 nZ8A==
X-Gm-Message-State: AOJu0YzhunF8yuGy65VRTbB/3PUH2EauiSr6lwea6+BfRl/u9cgOVoDY
 kwS+cWHclmnOtcK59dxAdtX8f9oT67eRT6rzG7EqdWU1yQrcmnwj+pwQPTSmT2PJy29tqowl1XK
 wSODyMOQYTahKkFU3/6dTIHjQUmLNaZXfAmOHEHEGGCwGL3FJn8qZ01ZldhXTgAps5T6QQgKZJh
 KfuJqDOSNsmUr6lZ+HvnzMPl0+bhIXS14FIQR4
X-Received: by 2002:a05:6402:3414:b0:57c:a7dc:b0de with SMTP id
 4fb4d7f45d1cf-57d07ee7906mr6298000a12.39.1719036963138; 
 Fri, 21 Jun 2024 23:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2G9v2ZubQK1ejU9FzinfQaoHLrZcGHxLd1CquQiKPYAfYT3Eg7IeWX8gx84fL5r2osgjo9A==
X-Received: by 2002:a05:6402:3414:b0:57c:a7dc:b0de with SMTP id
 4fb4d7f45d1cf-57d07ee7906mr6297984a12.39.1719036962576; 
 Fri, 21 Jun 2024 23:16:02 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d509sm1924241a12.43.2024.06.21.23.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/23] configure: detect --cpu=mipsisa64r6
Date: Sat, 22 Jun 2024 08:15:35 +0200
Message-ID: <20240622061558.530543-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Treat it as a MIPS64 machine.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 5ad1674ca5f..8b6a2f16ceb 100755
--- a/configure
+++ b/configure
@@ -450,7 +450,7 @@ case "$cpu" in
     linux_arch=loongarch
     ;;
 
-  mips64*)
+  mips64*|mipsisa64*)
     cpu=mips64
     host_arch=mips
     linux_arch=mips
-- 
2.45.2


