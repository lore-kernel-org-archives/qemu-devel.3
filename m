Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E69C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WdN-0000YK-2b; Wed, 23 Apr 2025 05:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcM-0005um-SR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcK-0008Pg-GX
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vglQePu3gYLlbuxWFnUrsIa3jiYsaXtTUjZ4wu5eNmc=;
 b=IToHASen9GiIxqokM30A2LFs9wZIV9JtzJRhGjdTpF1ilhjfmuMf+IBeSScemmSBkaQNhw
 /Z4i1t9QS8IhMTX/d2a+584cFUty1PGyJBDN1+gAOVz+k/11LaNOzB7JjQNIqgiq5aeO4r
 I0eIgmD019cfYlCNLi2bf81mt+vD4ro=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-Ce7qWpORPzGw62O1v-CcvA-1; Wed, 23 Apr 2025 05:42:06 -0400
X-MC-Unique: Ce7qWpORPzGw62O1v-CcvA-1
X-Mimecast-MFC-AGG-ID: Ce7qWpORPzGw62O1v-CcvA_1745401325
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5e5d9682f6eso5664641a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401324; x=1746006124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vglQePu3gYLlbuxWFnUrsIa3jiYsaXtTUjZ4wu5eNmc=;
 b=HtubxmSYcPgHQHyzsaQI6rDKjhh9j7lvTmRUHWKX8DxDqRV/4D1MV+Y88vkcI6WR4w
 0Uotusy9oUzn2iqd29XVwZLX0z+0AgTBAxndDXtIIHhPHvPT7MQ2WUe0P2lP4JqHxbfP
 hZUowXlR8NAKdJyA55nsh+geMNzORDqU3DdlkXlNTH33AH/J40HrMCw/utT56WrPMot5
 NGsaIzQfsH49Iz24ZU4jWsXtx1T0I69PAZm2Iw/Z0IdLnGZZuIURcDfOM9OBca15Ae+h
 CVm6zAJxbfG6rrLQ7Mv6OKD16TM5vgoAP/lJKBCLgm3zlB+XVmaYMiDpNkeZVcGrCQZu
 XMzw==
X-Gm-Message-State: AOJu0YyO3cfbRgpMYIxz25ZXV22B8Bfq6gzdnPISBErG5S4ZgMdEZSQ/
 KeLQyGztnDdzggPH/U7xvrEneERDwaPVGaegswbuS4Sse5yKSW7Mo6hStPuRRbzUSI8FW9TdOey
 t6Np5O1wQ3mANeG+rbMzV3s/iBOMsn0cmiUn+oH5jZJfMciSXKYO67u7Em0UwrZUBW0Hlc5a8a5
 agl2J3DQxuV9Wh5xgxTOO0qu9Y/Gp55jxgzlf5
X-Gm-Gg: ASbGncuZMyTjc3D+BtE5EBx29PvDy83NvArzv5WzZ2brRqXoT+i53oXKfJLXwVW7rvj
 fo3HwGDXwMLilaDG22hUH3XeHOhFM8lu9dP3QOOQVJQTMnFN69xHDgBPE7wF+kbNPFMWUOsAn/G
 bUFldPSnUp+eEOzQ+PCRk1e2wt1CDQ5jzQgKekHV47+Pl2khQohGYRToFJvt0AHzYyno5MUcfXb
 TqolFfIVZDWs9ZNI6Jd+tfTuNlIdsqjox2JVGy22b3vhg96C48w9bQQ+XzHhTqxCf1dEj3peJoi
 t+8FuEUuGxMx1gLJ
X-Received: by 2002:a05:6402:40cd:b0:5ed:3228:d005 with SMTP id
 4fb4d7f45d1cf-5f628501cadmr17013165a12.6.1745401323996; 
 Wed, 23 Apr 2025 02:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQQb5wiaHPtfP2GrbPxnV0pLKZMa52O/eoCpxtg+mPw5OSa1r7JGqES7+PdQvqP6hLXl/16A==
X-Received: by 2002:a05:6402:40cd:b0:5ed:3228:d005 with SMTP id
 4fb4d7f45d1cf-5f628501cadmr17013138a12.6.1745401323471; 
 Wed, 23 Apr 2025 02:42:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f625853af3sm7092238a12.69.2025.04.23.02.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:42:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 26/34] MAINTAINERS: add an entry for the x86 instruction
 emulator
Date: Wed, 23 Apr 2025 11:40:56 +0200
Message-ID: <20250423094105.40692-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Wei Liu <liuwe@linux.microsoft.com>

Add myself as a reviewer.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-15-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f88..67228401f06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -534,6 +534,14 @@ S: Supported
 F: target/i386/whpx/
 F: include/system/whpx.h
 
+X86 Instruction Emulator
+M: Cameron Esfahani <dirty@apple.com>
+M: Roman Bolshakov <rbolshakov@ddn.com>
+R: Phil Dennis-Jordan <phil@philjordan.eu>
+R: Wei Liu <wei.liu@kernel.org>
+S: Maintained
+F: target/i386/emulate/
+
 Guest CPU Cores (Xen)
 ---------------------
 X86 Xen CPUs
-- 
2.49.0


