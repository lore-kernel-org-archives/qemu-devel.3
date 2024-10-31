Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168CFD767F5
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLj-0007hG-FH; Thu, 31 Oct 2024 13:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLh-0007YZ-BJ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLf-0007FS-Vg
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DX6VzlduT4scaePbyxo91UmVO28eeh5cZacUuHGwBY=;
 b=JXDHWJSG+hZNRehvPH3W7EA7rVwUEtUlhuEd7CMe3gIqS1gSUJ7Rvvk4xqR+NqHiYlod+R
 eLl5gTOvYuDivfOvStUwXYvWwXR6vNJBzGIylb94kAK+Xou/0/zZXpWMxbkNN0yclukAKA
 RYbe+v9Q0J8Dj5/RRoUCkz17nIcfnUM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-n-6m4vbJPqiuAyykof8ZBg-1; Thu, 31 Oct 2024 13:52:42 -0400
X-MC-Unique: n-6m4vbJPqiuAyykof8ZBg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d67f4bf98so521686f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397159; x=1731001959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/DX6VzlduT4scaePbyxo91UmVO28eeh5cZacUuHGwBY=;
 b=EK9qGaabrmXSafaukjMhqR2TADGYrAuI33c5FwyG/T5Py0BBEJqK8aN8Cji5JIOeVG
 h4lEpiIUGNLusAXWVdKE1guhPysR0PjckTFP75ciDzmULyzVsulY135KZ0ujCoZNaIWS
 1Mazd4MV4NvJGtDmfdN5qsTceUBHOLngM/B5AAnL20l9LbNovyxWj7gFCx5tsSWmAslg
 Jx46GmTOadiGSAXBjaC1AUO2pwfwuezwrxxpVOaPA/XuVINv3hC2Onws8w/wmPCL+vrE
 7dzkgxWcsaEimHhuQ0uy3FLHEcJH8khtIHvXuZ8qxJr8N7CHy31UXJXnp1BUSPrKzEL9
 8+jg==
X-Gm-Message-State: AOJu0YzYerIxxMDQs5P5JeTtb9x0gFv8CkJoUtJZm2r/BYYY3wGTeeWt
 sggdwj+mhLb7iqt/zbRC0RXbj86IrnVu+B5Duv4rCqz56Qen+GVbh2QANfao5rWRdHjDcDo5dcK
 Qf7febqlxhpO6sRAo0o/m07udypSk/FHWYHtQ7FhbCJzmCVrSNOp8zW+F2rYbd2ScOpF0IFdrsR
 6jO1MvKrTtAw+i391arBIhtJVUEU1UMUWNLg72Y1M=
X-Received: by 2002:a5d:5cce:0:b0:37d:446a:9e60 with SMTP id
 ffacd0b85a97d-38060ffe8cbmr14406879f8f.0.1730397159473; 
 Thu, 31 Oct 2024 10:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6a9Xnk/9SdBVWW7VYxASdLXCJIiY/CHuBtpBO6JP6q1VJatf9FVsT+zVs0Fe7lbCD1a8zXg==
X-Received: by 2002:a5d:5cce:0:b0:37d:446a:9e60 with SMTP id
 ffacd0b85a97d-38060ffe8cbmr14406855f8f.0.1730397159004; 
 Thu, 31 Oct 2024 10:52:39 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c1188569sm2752436f8f.113.2024.10.31.10.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/49] qom: remove unused function
Date: Thu, 31 Oct 2024 18:51:35 +0100
Message-ID: <20241031175214.214455-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The function has been unused since commit 4fa28f23906 ("ppc/pnv:
Instantiate cores separately", 2019-12-17).  The idea was that
you could use it to build an array of objects via pointer
arithmetic, but no one is doing it anymore.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 8 --------
 qom/object.c         | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 2af9854675c..43c135984a6 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2032,14 +2032,6 @@ int object_child_foreach_recursive(Object *obj,
  */
 Object *container_get(Object *root, const char *path);
 
-/**
- * object_type_get_instance_size:
- * @typename: Name of the Type whose instance_size is required
- *
- * Returns the instance_size of the given @typename.
- */
-size_t object_type_get_instance_size(const char *typename);
-
 /**
  * object_property_help:
  * @name: the name of the property
diff --git a/qom/object.c b/qom/object.c
index 11424cf4711..8b269414488 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -262,14 +262,6 @@ static size_t type_object_get_align(TypeImpl *ti)
     return 0;
 }
 
-size_t object_type_get_instance_size(const char *typename)
-{
-    TypeImpl *type = type_get_by_name(typename);
-
-    g_assert(type != NULL);
-    return type_object_get_size(type);
-}
-
 static bool type_is_ancestor(TypeImpl *type, TypeImpl *target_type)
 {
     assert(target_type);
-- 
2.47.0


