Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE668D3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0bn-00081Z-44; Tue, 09 Dec 2025 11:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aW-0006I7-RK
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aV-00023A-9g
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJvrixXAQ7k8N9GTxkVJ0KMkCFWfL/ghfDmftEF0pz4=;
 b=PaNmpJr4+a+7GJU6QjAOa0RzNgDbQkvwhd2PU9SOebSYdVZdRG84/SdO/6dIwI48k5coAR
 vqJSuNzLpccpUtwN3EB/fFHzZ4GjgzsHIszo1/GISz7BIQz7cKD8L8k2IRBRY1rgHbJ7cs
 ngYMNndACzMVbjghzl/CqVk0IIOnyFA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-jV0lkk8BNDu5-bwpsVmmjQ-1; Tue, 09 Dec 2025 11:29:11 -0500
X-MC-Unique: jV0lkk8BNDu5-bwpsVmmjQ-1
X-Mimecast-MFC-AGG-ID: jV0lkk8BNDu5-bwpsVmmjQ_1765297750
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8823a371984so78088066d6.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297750; x=1765902550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJvrixXAQ7k8N9GTxkVJ0KMkCFWfL/ghfDmftEF0pz4=;
 b=crQif6qyOoPxpli3cKI5cZ7jOmM7ijFWV4OkjQ+2EEOOqGzPTYGKdeJZ3VR1jUcKVP
 3EH9KOGsU7yd00Pn230qiwWpKZmnvPUusokZMTmNcfuKmEBIeNU3vJAOQU3Ev2p+VBwK
 KFshrnbUwX87//ddzbicbYkOQOozHxE9hYfKTnYzuRAVIS3aaqmY6KOEU8cDZO84vfEg
 Wv5v20cIKWplIpjmrmiohH2IBVN1WlrzeqQ6D5ErBOLjo+euGUaN3MxVz8PlOH95tm3S
 VxJ/wvg1y+5sx3h/AMvXJ28zwLaV/9zMrT5BN5kgYJs6xR0rR4+iA7bpx64BwRM4olF8
 Q5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297750; x=1765902550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iJvrixXAQ7k8N9GTxkVJ0KMkCFWfL/ghfDmftEF0pz4=;
 b=igmTGT3/uDmNXhDx+rHloOWIuHPP339P15KfxWCfpRzYNiloP4KwpcPpev7RS4eJCk
 cQuyqWKcElZGC3wgaYGNxSK1nfkYAO5aez/syhCj50ISSKSKcCqNGY1UDYMmplqP8ApN
 2mdAe4NXStA+ElkGxbEAbULa6Pq7IOTjytOfR6mEPEved1lXbUW8pZ85C/uYHTTzxll6
 NE5w5xARY4UVx2kbIyPLUsBRUNHaCowHI0rPzVkaTSV8vU9DakIF/e0JdIX1qY5Wjim9
 kP6Aqfc3ac9LWpybDmeOj/3FP2h1npbqLFHgDWx4W15ThqiHXZ1aC/Xci3cHrdyzQjmF
 hQHQ==
X-Gm-Message-State: AOJu0YwpuWRPyI5/floRagaCmuDyAX84+RLQNcFAUlQb09qcn4S8F2yu
 E0qESkEXNsXSBiuPeAhlrE3qf4TDwWntPah2JUcvbRFH3kl3JVIXhQehrHbS8ZbXA9yytenZ/SS
 eHI7JiztKX7YndQeKdCikraos5wJxQbVhcgSldSnbNwpiU64zSM3lyzDnqFX4Vc12OOgq4Vuy/R
 /RRInyiLcfHDPvP3Ybh13P9Aawqitlc6bjwNH92Q==
X-Gm-Gg: AY/fxX4RtgKNxECkZEI275eJrBEj0kpoLTEqASyFNf+YoVY0Jm0JLF1+pFGyG7TpT9z
 Md+pmxKsodrnkpoBjxyq9cC6RbQAKfql/Y2jCoNCpMqZflNrQNbRhAQmrx1oh7C7X74FpeIovHP
 x4xjg5D9EwXtDlOfmYTm89fIpJlxJviI7bJOaRZrMLCVQYUaxgWwXFB4QApU7Px559dWnj8PdgT
 zodsdRQjPSqCnkr5HgOxY+ugeUN8N+ErFonmnlGXgxz9KNr05AG8lYjMHiTixGFeXI18HRhzDNC
 UifnmkYRAXPG0Gd6KMTbZ6m0B9HKYMNpb130MyC7xTXNYxdBfXgOeHqlWYQru94lzoFIW8Zjaje
 Xpu0=
X-Received: by 2002:a05:6214:8001:b0:888:57bd:8c82 with SMTP id
 6a1803df08f44-88857bd9014mr52635456d6.0.1765297749996; 
 Tue, 09 Dec 2025 08:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPbrLZBfZqSj3/2YP9h5bRvVljZZphNzgEsApv6a7P3ufgyeBlh67xcOJYbl8eX/VR7A24Ug==
X-Received: by 2002:a05:6214:8001:b0:888:57bd:8c82 with SMTP id
 6a1803df08f44-88857bd9014mr52634636d6.0.1765297749359; 
 Tue, 09 Dec 2025 08:29:09 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:08 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH RFC 05/10] confidential guest support: Inherit from
 TYPE_OBJECT_COMPAT
Date: Tue,  9 Dec 2025 11:28:52 -0500
Message-ID: <20251209162857.857593-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Currently, only SEV uses it, but it shouldn't hurt either to make the root
class (CONFIDENTIAL_GUEST_SUPPORT) to inherit from TYPE_OBJECT_COMPAT, so
that it'll apply compat properties when object is initialized.  With it,
drop the explicit call.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/confidential-guest-support.c | 2 +-
 target/i386/sev.c                     | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 156dd15e66..855788fac0 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -19,7 +19,7 @@
 OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             confidential_guest_support,
                             CONFIDENTIAL_GUEST_SUPPORT,
-                            OBJECT)
+                            OBJECT_COMPAT)
 
 static bool check_support(ConfidentialGuestPlatformType platform,
                          uint16_t platform_version, uint8_t highest_vtl,
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fd2dada013..084264bc88 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2865,7 +2865,6 @@ sev_guest_instance_init(Object *obj)
                                    OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
                                    OBJ_PROP_FLAG_READWRITE);
-    object_apply_compat_props(obj);
 
     sev_guest->legacy_vm_type = ON_OFF_AUTO_AUTO;
 }
-- 
2.50.1


