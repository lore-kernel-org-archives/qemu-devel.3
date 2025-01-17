Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0DDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 08:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYi5b-00061T-Pj; Fri, 17 Jan 2025 03:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYi5Y-000611-JI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYi5X-0006q9-5i
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 03:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737103941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8ecaFEUhpS5KvOXKLj0pjyue0jCj2uRMmTeCPYI3x4=;
 b=Iy0VmdUPncz4oYC7xs8a8G53JJ60SqGBJd9YGHEonk0+etHo75FuvjJeOOqkj580Jcf/SN
 hP2UNIA6c6bvgp0bjIJxvnqv7iG2l3ht7b+S3pMBqaoJsBsIiGARwCKPCmeafCc17wgcKS
 2tBj6x2u0+btDc6s8TCgP9tLYWlrCzg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-iJCddmXdNtqTo7yBbfXSUw-1; Fri, 17 Jan 2025 03:52:19 -0500
X-MC-Unique: iJCddmXdNtqTo7yBbfXSUw-1
X-Mimecast-MFC-AGG-ID: iJCddmXdNtqTo7yBbfXSUw
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5d9f2ec86d1so1482974a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 00:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737103937; x=1737708737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8ecaFEUhpS5KvOXKLj0pjyue0jCj2uRMmTeCPYI3x4=;
 b=qLnj+csfBtzVR65Gw9IHEeOlJJURk1dnvNfFwBekAkBeeLDDkbiKtRPFiM97IHKXII
 dVRv6gwWgEa24Bm3R7WmkH1kDG2WWngPbp8Tyt/ujYZPTV5fxch9JdwaqQILk10xLa00
 YBjsk0bVoxOsHhIaqoX7nOtE0kPPGFYFKE7s8OjowePuhp2WpWyetPMZGCqQ80/CMb8j
 sl1T2iRwXC3oENXaS1BQB3kH/XzGiKi/Rlw8RE9RLsrmMgJoWsxt+NP59c9Q9kFQOgPX
 MH7BpXU9uf4iKu2aIx2uQHK/TJPBspoGCHPWETrhSLVkcFP7NWB31ItdSZ0U61h9/TLp
 Vaow==
X-Gm-Message-State: AOJu0Ywh0MBrNzr8wvXIKubX4uxnOc6rY02Jee74Yo3IYItr70DMLFDV
 UCUfUcV8yNoyOU+g4waIfjA1TmDRphG5FEBInfTrweHvjxMOyCdH3/ktK5k0jzh0dFOhknjW/I8
 27ciN8j8wTlmLdNjPXayi1I3QVWApjGhG9kjYU7a6Omcb/vg7iM/SIARLM1UH23UYqQ29+PTXVt
 u4j2epEWEmxvQJzeZqc6VZH/iJXVEHW++6AV7uzXY=
X-Gm-Gg: ASbGnctpuFVmdHVGqKHfdpP+c2DQk9hU7W0XA8Y2e2zUKTzr5ZM74jTm8qFLQmDfs1M
 v2mJfXkhdtr3LIosfFYFmsYc3Obd6Py6hNGPtCeKHxZmOw4J/bxTbeGz2EldiUjxj0y++CD389p
 gmLj1Dsztd8Q9qqrpr6nx23alvQC6dwgGYb+b5y3WcwUwI4X5dEHFUDJ6ODIQsSHJctTNqtwILu
 aF/JdeY6oBuE5yU7QDc2jRE77HHo0wyTL2BiY8sS6HB+0wbEMt7MRG+lpxi5hndyZQUQnYL6Q==
X-Received: by 2002:a05:6402:13ca:b0:5d2:7396:b0ed with SMTP id
 4fb4d7f45d1cf-5db7d2f5d30mr3890101a12.14.1737103937105; 
 Fri, 17 Jan 2025 00:52:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8Tfx/NApHl72ii04e8bZvX/In367+sOLu3LSeHqdPU1RLrxs/jTKU9nARo1HvmxsyrM3d0A==
X-Received: by 2002:a05:6402:13ca:b0:5d2:7396:b0ed with SMTP id
 4fb4d7f45d1cf-5db7d2f5d30mr3890038a12.14.1737103936639; 
 Fri, 17 Jan 2025 00:52:16 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f87d86sm134010666b.146.2025.01.17.00.52.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 00:52:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/38] rust: add --check-cfg test to rustc arguments
Date: Fri, 17 Jan 2025 09:52:12 +0100
Message-ID: <20250117085212.1044392-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117085212.1044392-1-pbonzini@redhat.com>
References: <20250117085212.1044392-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

rustc will check that every reachable #[cfg] matches a list of
the expected config names and values.  Recent versions of rustc are
also complaining about #[cfg(test)], even if it is basically a standard
part of the language.  So, always allow it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/rust/rustc_args.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 5525b3886fa..2633157df2a 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -215,6 +215,8 @@ def main() -> None:
 
     if rustc_version >= (1, 80):
         if args.lints:
+            print("--check-cfg")
+            print("cfg(test)")
             for cfg in sorted(cargo_toml.check_cfg):
                 print("--check-cfg")
                 print(cfg)
-- 
2.47.1


