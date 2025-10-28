Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D81CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbA-000682-36; Tue, 28 Oct 2025 13:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnb7-00064M-9Z
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnb3-0004Rp-La
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qr/uEpcK466AGGfZ9FV3WnUVpqfKNyqxTrRn7SFpgZQ=;
 b=VUHY+W0Y0pKzWFoNlYrNjOMyitWe5sxJN/WOx2GJK+BG7Kz7BlP35qJtn6BTTu5U5xDkeH
 Un2h4Tv8VAUDQXKwoOOkS3XtkofgEoPmR27x0htLVhTyyzA0a4Tmd0dYF9fcCQv1JYPkV9
 vjFKORsquhqWVPxmGT65BaIU1g6kEp0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-01yRhUpsMXq1O-aDWbH_dA-1; Tue, 28 Oct 2025 13:34:57 -0400
X-MC-Unique: 01yRhUpsMXq1O-aDWbH_dA-1
X-Mimecast-MFC-AGG-ID: 01yRhUpsMXq1O-aDWbH_dA_1761672896
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4770e0910e4so21463585e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672895; x=1762277695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qr/uEpcK466AGGfZ9FV3WnUVpqfKNyqxTrRn7SFpgZQ=;
 b=qVYrAL/QJ1lM3ZQ9/1Ig8g4MjbuFG85hcUZixZpb8pUZVhZvVMBLajqbSm4Ugnxorz
 agSraVET0VQVnLiqGGUhXQxuSTITb3XvtfOzq/t6Akj93Vup5My6a5NwEdhJcFRwlQs0
 p+J3IQqVmjKapNmKULedkVauL00Oxd6xzQ/dIS2iFag1VVhJzEhAjjKQRiRfsxFeThe1
 TVEk85tFeKEDR6BxB8w6Pe9XS33U9clRRzAQY1MJlAYcd02nO/66f7x+06/DMsah0e9D
 aUUt0nnoqHAacAp6nwrNse0RGXZ6MSvnDzUT42MjvZLALljfwIU7Ok4NlsDza88yo7DM
 L46A==
X-Gm-Message-State: AOJu0YyZhG2Ee/zrrJyHXVAdoWvWDhlH4kFzHg3qcyTNg0mvS6K7GunO
 sBkpbx9034tYlF+i5l/eneaLyZyJOkIKhC0lp58oiPfT4mYsCwV0gzzhilgPmWgnvOczfsRqH49
 WDnWC5O1YjB7KoZlUTf3Ui2sI97Mv6KF/kAs1G1J9+NnmsKRq+FoGifjcV0Wn4kheL8LzUyl/MS
 B9l6G+JBbf1EfpKstUPDjGFNnelfnpRk/htzi8uafQ
X-Gm-Gg: ASbGnct80vmNikL/mnwD1q2wHSBw5GIBMOBKdHg7Zi8qK6nOZqVMqZjZ2yZ+dCeVHvk
 G1MnVnK/9DI00V6XitubHJDirNsJV/8eF4LqZan3U8damVAoSaFfQLqNeiWChpD9T8Pg4fioCc/
 e2vL/lV+lni8uV3IIGTEoJGOxOTVMf2ZRl7PMyQRdOA2rcL2yTXub3CWwFJuWmnjU6X899NFepr
 o/m5q32hC06BqoKj8Gc8Hw8/Bnj4Cq8DDJOL12tdB4LiP+LhoEahdPKg6fOYnJbyU1+OFaoVkZS
 8KA6H1+DuzVRnMwwly87gdJTmk6g6qLTMQSQGo9vk2LqA7oktDtsH/xAOTuNfjSRA9qDAYRJCC3
 7WG11oZicSbwgIydlOt1dPpV+F5Mw6QNLNwa7QQTG6PwzzmNe4vJ3B0sW7aQjuOuWmCJjbKe1uA
 xqcKc=
X-Received: by 2002:a05:600c:34c4:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-4771e17ead6mr2531795e9.16.1761672895121; 
 Tue, 28 Oct 2025 10:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfw1dwTj0hmCE9hBgfMlpFmtS+eNd8iAUVZKJQ21M7A7aFSGLajfT+3e2Irc4RADEbmJm4fg==
X-Received: by 2002:a05:600c:34c4:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-4771e17ead6mr2531615e9.16.1761672894690; 
 Tue, 28 Oct 2025 10:34:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e3a88fdsm2549725e9.10.2025.10.28.10.34.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] accel/mshv: initialize thread name
Date: Tue, 28 Oct 2025 18:34:20 +0100
Message-ID: <20251028173430.2180057-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The initialization was dropped when the code was copied from existing
accelerators.  Coverity knows (CID 1641400).  Fix it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/mshv-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 45174f7c4eb..80428d130d5 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -596,6 +596,9 @@ static void mshv_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/MSHV",
+             cpu->cpu_index);
+
     cpu->thread = g_malloc0(sizeof(QemuThread));
     cpu->halt_cond = g_malloc0(sizeof(QemuCond));
 
-- 
2.51.1


