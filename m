Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DED5F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5w8-0002bd-TM; Tue, 24 Feb 2026 22:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5w6-0002MB-EX
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5w4-0008Ca-VT
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p5ZbFdSM+FDKoKqpM0RbDlLtsFLRzSauSxJ1myhHy4=;
 b=Ihc+b6W3duc/lf2TDLS76OiNcj8ge1w4aQZs7BAUuNoOsHp4navLNLmZ2i0j+zzK/eTrjx
 YUJHMilplIey+zJOB2i7ruqHDY+GEphfuWgMZesdTL4MtXgFkbd13IH+4Cn56VftFQuM1W
 RSApxsvuuFfDkEkGdlIe6H1hFvjjuDk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-GEmvOOuoNua3Dv8cSJSPzw-1; Tue, 24 Feb 2026 22:51:37 -0500
X-MC-Unique: GEmvOOuoNua3Dv8cSJSPzw-1
X-Mimecast-MFC-AGG-ID: GEmvOOuoNua3Dv8cSJSPzw_1771991497
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354c0234c1fso5708467a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991497; x=1772596297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1p5ZbFdSM+FDKoKqpM0RbDlLtsFLRzSauSxJ1myhHy4=;
 b=l0wz9qw1uzfM+/e4QPEREeCWz6oCLkcNInDK64DOVJObnOjE0L/cMVoToqkR8EMdmR
 bEqqBy4lF1fKQ65CNk1bUWy4r6+glDwysxI92bGWre8S/GOox/P6wWJJYXhPos1Cb0cj
 Kefc9cZZIbrPOu9OvJue+GTQMAKSEwQr48lrBxWSBuDBHwtTllKfLZIm8YrWqZbPhttC
 vZtE6+/CGXzKcn5GwkXQabKIWdE9b0cjtWvFC6KlwZpsl12wN8aryAQM/AsGXYPYDZP5
 0mAqfe638YP4LrafFfkKtWxl/lQ641foobcyjMi0fxn0gI11ZLQg4G+12A5lZbnIvbkC
 x2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991497; x=1772596297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1p5ZbFdSM+FDKoKqpM0RbDlLtsFLRzSauSxJ1myhHy4=;
 b=w7/sph3xOcpybxWVCVWp5y/YbXI6pALm5OfvoAsDSeKqw0CsTB1bBohnjzZ3mZKKnR
 SQb8BDSpG7QDbywKhWZhYtjQej+bYWlE3Io6/eLXIWrkvVPw/EeEtGDGIBJkTbY9UL7s
 Bs0B3KgCEiHgJLMm+u6vwiiFRwtmhRr6rZ6H3fItXzD8xVnAJTimg7Y9tzQvlIaf3G+g
 q8brusDoxsgQj7n4M7LtX4tBZzQhNUBIwi9Ep+Yp707wtbDyww6/LrJANH4DaWBRPHbZ
 Gk0ZeP4wLstlL9K+Qt9Y/BPobNHDYnOxdXNaU06xUywDOcL/8wS5QegNkWAGKxdcXOW6
 +Jvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuj9t+XdI1/1bTQ/Yhat+iI3ddqIZiryu8+QumHdp3D8u+40cT0D1KMf7hG1vjCNf9vhci4Adow4XH@nongnu.org
X-Gm-Message-State: AOJu0YxPz5vk0qgzxaweZUWGwLTQAibqUjOkwsw+XvIyCN82/i0NXE1l
 s4ZpZmbaq7qeilpBWllTnQLNrn3LozfLDfpYy3th8U7PFobSdr5EAfwo4vFLrrndgwHHp1R188L
 oNssc+p7RnwePyCfJw9e5FsWEAOHZJv6wK9N3UWyTdzjole7KD1vs0yUS
X-Gm-Gg: ATEYQzwv38LwtNqypGrayRIm/OXhwlhw3u15y28dSOBZOcIzESLS4d+ibBH5A2l8Zd+
 5thSsbPAKApt1a2gpYBIoVj0JrlF8kHOSGqwKSyWucwdH7KgDKtHyI40NeAWGi2Cyj3SkXhCUoe
 k0Q9OV+OfFORzYF4CtOaJRt1qyW8jWLQuldn7w8Uk9lUZZ1seLintciN5rHSPzC+xGTQlxHPvou
 NbLxnwbKqbCPyCehJWY37Cg/VZiSaUOaNyCEAgHl0+CSdbGNLxKg+ZkLMef36Ez/SCJEeMgFMLL
 sMG934a1Eo3behSMk+B62Pkluz+5phqLI6k3E9+4I8xb4AWTnqQaznEOYraANFp/wGXq/ErUb6d
 vlv9Goemr93Hbpw8YxPVVUKacGfnRwLQpJ52+6z7wI2yiz65VBsXWPrI=
X-Received: by 2002:a17:90b:51cd:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-3590f045d72mr867113a91.4.1771991496852; 
 Tue, 24 Feb 2026 19:51:36 -0800 (PST)
X-Received: by 2002:a17:90b:51cd:b0:341:8491:472a with SMTP id
 98e67ed59e1d1-3590f045d72mr867090a91.4.1771991496448; 
 Tue, 24 Feb 2026 19:51:36 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:36 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 26/35] kvm/hyperv: add synic feature to CPU only if its not
 enabled
Date: Wed, 25 Feb 2026 09:19:31 +0530
Message-ID: <20260225035000.385950-27-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We need to make sure that synic CPU feature is not already enabled. If it is,
trying to enable it again will result in the following assertion:

Unexpected error in object_property_try_add() at ../qom/object.c:1268:
qemu-system-x86_64: attempt to add duplicate property 'synic' to object (type 'host-x86_64-cpu')

So enable synic only if its not enabled already.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5c8ec77212..ff5dc5b02a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1761,7 +1761,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        if (!cpu->hyperv_synic_kvm_only) {
+        if (!cpu->hyperv_synic_kvm_only && !hyperv_is_synic_enabled()) {
             ret = hyperv_x86_synic_add(cpu);
             if (ret < 0) {
                 error_report("failed to create HyperV SynIC: %s",
-- 
2.42.0


