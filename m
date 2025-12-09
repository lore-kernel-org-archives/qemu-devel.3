Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7A8D3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0af-0006Iq-KH; Tue, 09 Dec 2025 11:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aP-0006Ef-1T
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT0aM-0001xL-DN
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765297748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5K4Pm58XCjytFwEd9ICCFtDazJ6XnysRJmaILchveM=;
 b=WqqDFnIcw3+/7qaHSXbOWXSjuxu0Jc5Fz5W3kkcXjVnbi9oP6UYiL/yCzI8wu6/X6yZKrC
 cBXAXaSZCwW8G1AnK98+IeCKKAa/gGF9RvZVZnc6kJuj3DUpn9nEd26qDu7uG7JzI0four
 OiVpTt2q02JAS5ESu/cIUo+iIJ3HtzA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-O06yB70uNgGe2ex13fYyFQ-1; Tue, 09 Dec 2025 11:29:07 -0500
X-MC-Unique: O06yB70uNgGe2ex13fYyFQ-1
X-Mimecast-MFC-AGG-ID: O06yB70uNgGe2ex13fYyFQ_1765297746
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8883eb7f09bso80254996d6.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765297746; x=1765902546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5K4Pm58XCjytFwEd9ICCFtDazJ6XnysRJmaILchveM=;
 b=n3weem2bv3osxfIAkTieuLvSjtMrYJSumlV9xDjinhpa94lFNutImcwCgrLFMMTHW3
 OarZXjIugmKRDU6TWmJUjW01X5e4pFqXkcJjJbZQhCfevYDQn/05F1MLETCCXZztS1D8
 E57I4h+Fda7UfI1OXAqCBeAJ+Sp2mF4oOLWXNjoj1pNWSSguln/G9uWEhQ7v3BBcwwJR
 7e7s0fGEn8t7u5kGhs291/z3i2CCZ0wUHYmo+EDp2SuaYw3PN4+sjTNyiTsmfWrZkOA/
 jqM0ydHEJ0CokxeQpYrueUWmISRHrAj5RctuFwKFh8EyeAS8SLOhZn/q6Fg11ihGKAWX
 AdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297746; x=1765902546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f5K4Pm58XCjytFwEd9ICCFtDazJ6XnysRJmaILchveM=;
 b=OkezNTslbTL7kDccbpQEs51Rx44vTr+VxGpVgAHy2JaJsBTzsfe+Y+/y/9RDSjFK57
 6Qj2Gm4Frd5C7DncYpiGcYWsFOLBju4fHrq8D0spwZyqFOro42YZs2Fp8TrLZDL2XbiE
 lEh3wBuGn3Po+KJfqgUneklwC/HnDeB5h9Prkpqy/t285Suprf1DyqSRliupIK4FlcHJ
 jdPJMJF6VqmmXrS5BpsRJdRKqiQ0GMma7LaSs11LTNpL2BQDbPMFjsIwp/hR84xxR3mc
 goMFl9hV2zjchOaO5K6xZSEnlgxuTwgwJRfidarJgnmKk5kuhQMl7EH3jxF8XodRy222
 9SqA==
X-Gm-Message-State: AOJu0Yx6J9+ajL808nbdpTfi6pcocL9SY16cGBmloYAXbPYWqvzeQZLK
 BkeKttFPo+E41oK+2ncn8Lq6VoRTspJWxuTzUEsUqGjt3DNqKDteaMxet4bkW8KyRL9I4yM1Kup
 lb0CAEXbmmc8lJy0Khvszzkh0Hj1s5wZzJzbtJda3+tNjO7FFM7P7ZSk0xig9zirf9B5vp5mdgu
 4SHz7iJ7iVRwTGgmjeS+caDLDLnp62B7aTQPQZDA==
X-Gm-Gg: AY/fxX4tkAa5cgBC7J/W8k+z3IbmyHowMDuH0wlZ/4Rz74q1UFEZbeQr4KHZj0J7Opx
 wal8MopHCLIXliDnxc1rXNSfTatg8w8NJRxPJ8YY7mgouqI9XjCBkPPpGs464jZNbJv7cY/vspX
 E1E7bNTYqUVlD9lws6lqQfs28HN55pbZIssOs27EFnQbm6BxsJWdQcSt1RGyLIxgLR3aDVMlmiV
 ZxjHLHbGX2cR8iVwrdk+rg2g9Pz58xVKeeSWvDLuJfQFcu2mE/TlEZ8KcfO2x1sgI6GxANya1du
 pf8zehWw4DZVu3a/9dSzxDKJCwAUBiheP7nhv9h7Wd1NtZ82NzZJZ9ldd8Z+3oLwzZ0KT6teZEa
 LQ1g=
X-Received: by 2002:a05:6214:ca1:b0:87c:2213:ed28 with SMTP id
 6a1803df08f44-8883db2a2e3mr197416726d6.27.1765297746063; 
 Tue, 09 Dec 2025 08:29:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdtDbp6zIJ+G6x5uKm53ln1TlxFBHJK8Df8jRMd62nhsFJnGmZFhS1qx0XY39NNdHBYsIbTg==
X-Received: by 2002:a05:6214:ca1:b0:87c:2213:ed28 with SMTP id
 6a1803df08f44-8883db2a2e3mr197415916d6.27.1765297745459; 
 Tue, 09 Dec 2025 08:29:05 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f334d8sm131110256d6.10.2025.12.09.08.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:29:04 -0800 (PST)
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
 Eric Blake <eblake@redhat.com>, David Hildenbrand <david@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH RFC 03/10] hostmem: Inherit from TYPE_OBJECT_COMPAT
Date: Tue,  9 Dec 2025 11:28:50 -0500
Message-ID: <20251209162857.857593-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

With that, now it can drop its own post_init hook.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 35734d6f4d..7d726bfb49 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -293,11 +293,6 @@ static void host_memory_backend_init(Object *obj)
     backend->prealloc_threads = machine->smp.cpus;
 }
 
-static void host_memory_backend_post_init(Object *obj)
-{
-    object_apply_compat_props(obj);
-}
-
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend)
 {
     /*
@@ -579,13 +574,12 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
 
 static const TypeInfo host_memory_backend_info = {
     .name = TYPE_MEMORY_BACKEND,
-    .parent = TYPE_OBJECT,
+    .parent = TYPE_OBJECT_COMPAT,
     .abstract = true,
     .class_size = sizeof(HostMemoryBackendClass),
     .class_init = host_memory_backend_class_init,
     .instance_size = sizeof(HostMemoryBackend),
     .instance_init = host_memory_backend_init,
-    .instance_post_init = host_memory_backend_post_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
-- 
2.50.1


