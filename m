Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D918D49236
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4hQ-0001wg-Pw; Fri, 12 Dec 2025 10:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hN-0001sI-0Y
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hK-0005fc-Va
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJX2Vfp3U0oN7mc0xwcEAGTGJFdhzh3zAsgh+2IEEL4=;
 b=QFCQqJa8Znh2NHfUZkquyjbHlvlldxXRPpLQui1IMRDR5hF2TULF83Rq1ZQbymrl7GZm+B
 uABNyPAazQbFwsbnJ3cjmv0i6SH2Ocamyt82Wk4lzSxxujgFEJBhVFzFvDzVKjRofA6khP
 w/AnWuxQsGKehVKCZ77mVMH1d4ViXH8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-IocfHG-gM1y7Uk7XdbaWJQ-1; Fri, 12 Dec 2025 10:04:44 -0500
X-MC-Unique: IocfHG-gM1y7Uk7XdbaWJQ-1
X-Mimecast-MFC-AGG-ID: IocfHG-gM1y7Uk7XdbaWJQ_1765551884
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-29f1f69eec6so9643215ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551884; x=1766156684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJX2Vfp3U0oN7mc0xwcEAGTGJFdhzh3zAsgh+2IEEL4=;
 b=h1QiRzFts2Jtlou8pF0P1aaa3fP6NHvQ04fJse17Nxali9EQZw8zHO9PRj7Iu61KYB
 K65r9M4SFGH37JJUXiZRfc80V3naE1Rbdbkoo8AyGIvr2rHGDo3tO+glDeXJ6mr7qV1Q
 5cnl80/VC8ZxzA/FjtBOKb/UgYk4vromm+qtSk3zksfewLFy7niFfiECVDwYHurf4mXY
 pkVj6eCSj5xtMlZW+W+6w2MJgw5WNPVNNT/M0NkuXuB3uKJgaxtLN8OGgS7I3Uza2Dyx
 mR/smXFY+wrodpsRwvFxkrayi6iwU1nkYHip4J4R8tpRhJJgoRAeCN8KuS+t2MBtQ74h
 BYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551884; x=1766156684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oJX2Vfp3U0oN7mc0xwcEAGTGJFdhzh3zAsgh+2IEEL4=;
 b=kLojrNdpMjrhhE0Oz5Oj/9pcjCvmb/y6KTJMVcp25Fr6HnfLkf5NZADHYIZKTWLSkE
 MOZSEzmuj4TV2oJ0QttqLIbsQ0LkG+uoXmxSJiN0JTSsmfBlkHWvSTJbLVeIa0ZZzqB/
 3tYf52NXj0XNpU2+7BVMZhrFaWuCeIH1me3IA+KcQhu4N3sA2x9FlIohlm6RTgIlg7cs
 cV/c6okdWKIr9itoWSKrwmSy3Xcl5A3H4IHeQ0gPQqoME915RSQ8oJraD34iiRLocyPI
 DzwgcxjRZKZT72xWNK2lEGLiIONLoY9JxRCupbyXeKXscLuz072ZmCuCkIaH/3QxsmDx
 +kwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoKdy+XZNOkDzssczqE5uwI4alTiOU4OJoylZmsR36NLn2796zS9G0gQtH8+zWtG4pTPjm9ydkq0l6@nongnu.org
X-Gm-Message-State: AOJu0Yz1ydjRkqdwz0+O5FtedV2cGPSwpy3bBDXjjUw3wsEMJ1ydw5Nb
 mHe2ckYpw+WJpG+KeSSM6cNxAmXjTEbZZOJivtj1fYy4PjKIHSOC8osMOOJPBv8ACiQAZPqSyG/
 6libUqzYK6VE/8kE8bc6sKOtlPXwK8m18WG/V3BKbMBqt6FT2nAZWPDNz
X-Gm-Gg: AY/fxX4IC8Tpt4payV6NWtK+Ki2XzIyTTSqYGO10GQtWObv+yf2ixGr6ZE58hGbw4qB
 t2iv6uihzHRPEfgRvkvosHRjFaD54mZQ7mvs/7l67eE10zIxV5sJgF2Lv4ch5MPD4mKU9bpu2l8
 9hc4qeQsyM0H33mO6f4bA6BUZDEHhcMsXffvd69Up/82/LsYLZuGXaeMgez5uUdLR40kLVlmEf4
 OKdqFVe2y3gp2Esk5C5F37tc/anGk7FiFV/HvLrb7dhh5rzSVoye3ENpA+v8u3+rJ7wg3bSfrwU
 03pWrBfSXl3CXSsUoEDE3TfpvZ/z3Q0PL7oboqL2P/nsZxAU1wQIfpEPEbht0GcqlTS6cVZJM/Q
 7NTM5kZDvQjdQDIUyXQ0av7ZB0bM4yUNU8jKod9lnXgo=
X-Received: by 2002:a17:902:e943:b0:297:f09a:51db with SMTP id
 d9443c01a7336-29f23e18ba9mr25217305ad.15.1765551883464; 
 Fri, 12 Dec 2025 07:04:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHr+3Yeke6CZ/UMZxEuq21IFxmSWHsTNUIAGUDU9/pwfuXux37Cj9LYKCOd+ZD6dBE5chS9Q==
X-Received: by 2002:a17:902:e943:b0:297:f09a:51db with SMTP id
 d9443c01a7336-29f23e18ba9mr25216895ad.15.1765551882964; 
 Fri, 12 Dec 2025 07:04:42 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:04:42 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 05/28] accel/kvm: mark guest state as unprotected after vm
 file descriptor change
Date: Fri, 12 Dec 2025 20:33:33 +0530
Message-ID: <20251212150359.548787-6-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

When the KVM VM file descriptor has changed and a new one created, the guest
state is no longer in protected state. Mark it as such.
The guest state becomes protected again when TDX and SEV-ES and SEV-SNP mark
it as such.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c9564bf681..abdf91c0de 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2640,6 +2640,9 @@ static int kvm_reset_vmfd(MachineState *ms)
 
     s->vmfd = ret;
 
+    /* guest state is now unprotected again */
+    kvm_state->guest_state_protected = false;
+
     kvm_setup_dirty_ring(s);
 
     /* rebind memory to new vm fd */
-- 
2.42.0


