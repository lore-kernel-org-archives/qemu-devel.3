Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2677C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcq-00078A-Jb; Wed, 23 Apr 2025 05:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcK-0005pB-CH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcI-0008P1-I0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeLjFralCRqvF3RDhEB7JJDGeYLNNIolLYPhUDMNm1U=;
 b=acmNFlhRiIHX46o213BakHtYdSUsT756NejW61/wnfWP52xgihbxmkqwpebcymKvpDFFd2
 odSA0y7I6zBgzZ5Q7qztYqbfYwExB3kYA6hFHtqrU5puvFNKhc1M3+f10tRK4z4+KG0sXr
 IGv58o1OZwGeN4V7fRqt5flOCQfXbg4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-kIZeN829OUKMbCqr8bWsKA-1; Wed, 23 Apr 2025 05:41:59 -0400
X-MC-Unique: kIZeN829OUKMbCqr8bWsKA-1
X-Mimecast-MFC-AGG-ID: kIZeN829OUKMbCqr8bWsKA_1745401317
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac293748694so458206666b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401316; x=1746006116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeLjFralCRqvF3RDhEB7JJDGeYLNNIolLYPhUDMNm1U=;
 b=C7IZqEsQ9w2T65vq/RQXW4jfBxCER/XGYVgDkoJMfSWS6H95a3PlD7whtZtRZkPpve
 rernMDdflvtNobYlZmpjbQF/GxjC95raDYHaaefGpaJKPZGSBC7W/tSN7U6G7OjhOR8F
 tm7x5B6gQOa0YcGqUKuGZ/z5pBH3Y3Nc6n9iHer4Mf1W5cytMegtL+QLg7FlEWJ31NB5
 BjslipCy4+OCM9kY3umkd+nfGNAI9tG+X8eUjzX1Gt3DnXSapvmhLYP43TxIHsx8hLHN
 EOpxOb+JUbpBJGBJaeP414d0aj/TXHedt+FH7b43c2LrHpbI/wbSofI7hueShZghOP4c
 /d0w==
X-Gm-Message-State: AOJu0Yw4x2K0yFfqz3xEQF8AcV/L2ilVB6nJb9bncsgqUazZ8Rwn6Jps
 mtKcREp2+WOx+jfeeBqpO0kABJkTEYCEiv3a/v3H/00dHg88zSSqW1ugh4vJLgVXuExqq0IwAKE
 qUB/kV45yy8cgjOhSQePHAqJxyb25J0hR0nZDx0qoahiMQQ4WA1EtUQF4gUO/HMO7Z03TZur9ki
 /2IIK2UhMeGGR6hAnHjHVL7bmQYC2xkSx30m7V
X-Gm-Gg: ASbGncsrYQj1twRCwLHAu6dH0rRDa8NhNUstNn1oZkymLLm+p0YOqqkd41ZUd8W/Kqk
 0ldF+UfUnSB++SUSL/Yh+1YssXUNaXpgA1sVg3NXlzjGo5JNoHIm51HKaLTCxg+kWziUUCicCc1
 z3Sh8O5/B98hFjH7+mQwgFt+Bhy08UrLseaY+LbaSQplXaDmr1WkN7llVl2rKaiyUz1ZJb12YI6
 lXmRXofbU36peu9vd03i+gVGq3xfaB/0A/EMdEeO3AatvSMvEEl1uBjhBY7Iy+FtABK6nM8g6Ae
 dIhRSkZAtRrYhEw/
X-Received: by 2002:a17:906:6a1e:b0:aca:c924:c14 with SMTP id
 a640c23a62f3a-acb74b34dbemr1628868866b.17.1745401316284; 
 Wed, 23 Apr 2025 02:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFVV5nMiYUnI3kjfAF7H6+OhvyIhIAO4OAALMFZmrBQ/oEdymLT+aUTVOIMG5gC9WYvz3/0A==
X-Received: by 2002:a17:906:6a1e:b0:aca:c924:c14 with SMTP id
 a640c23a62f3a-acb74b34dbemr1628866866b.17.1745401315846; 
 Wed, 23 Apr 2025 02:41:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acbb83ca49asm300705266b.84.2025.04.23.02.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 23/34] target/i386: add a directory for x86 instruction emulator
Date: Wed, 23 Apr 2025 11:40:53 +0200
Message-ID: <20250423094105.40692-24-pbonzini@redhat.com>
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

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-12-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/meson.build | 0
 target/i386/meson.build         | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 target/i386/emulate/meson.build

diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/target/i386/meson.build b/target/i386/meson.build
index 2e9c472f49d..c1aacea6135 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -31,6 +31,7 @@ subdir('whpx')
 subdir('nvmm')
 subdir('hvf')
 subdir('tcg')
+subdir('emulate')
 
 target_arch += {'i386': i386_ss}
 target_system_arch += {'i386': i386_system_ss}
-- 
2.49.0


