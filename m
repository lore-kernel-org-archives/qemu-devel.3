Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A113EE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPa0-0000yX-AI; Wed, 11 Dec 2024 11:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZx-0000dC-JA
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZv-0000al-T4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qS4FLutt/4Sk0zExJZjpAJYdJnqb7SMdrl1fvxcvDM=;
 b=Dalm2dAyqoPE2vuKU6XKzA9jDccXBROf2ZvX1vvFs6az9fF2TjuOW8hswwVpkfYYe9Mq8B
 GlKjpARx//eE7TKssHLyC7Pbdxvt+xRcA/RJybQsuNWvMG0fDJ8cxFd5E4bQJZ177D+y70
 0cU0ow2e7WxG86geWPePiu/uOXpBp9k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-iwXdbfABMma-r-59NgVI3g-1; Wed, 11 Dec 2024 11:28:44 -0500
X-MC-Unique: iwXdbfABMma-r-59NgVI3g-1
X-Mimecast-MFC-AGG-ID: iwXdbfABMma-r-59NgVI3g
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38634103b0dso2810435f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934523; x=1734539323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qS4FLutt/4Sk0zExJZjpAJYdJnqb7SMdrl1fvxcvDM=;
 b=WMm6Lo0PYmXxq/uJaFBtDWxqsGO3obOJb4B4MGrkY/JaLngtHRyFM20Ovj89rOpKQv
 E4p2KfQR1Tvg2v4EYmyxG8byX3FJsmyOyivfXzwp8MsvVyhHVrNTMKICOZEO2IhcUq5o
 5pwZl9Zgn22kralLANdHC6speyjdxIb8vpw6t8SDfmgdjrjirz3j6JSsB853Zv0x5E6G
 /SG2vm6eCVl/Yf4NEuCoiNEoaldjA3Hpv3znbD0Ah4M5i9jKSTAFMSIQ9rGHJfIL9gl2
 ucHu3983EYmqf5Vx9/VAIlfuuzjUbpHO/MdefkTv6qu/8EbsmcqM3LAvhnmaC53N/hiK
 b+Dg==
X-Gm-Message-State: AOJu0Yy+bsyF6H9+Q/u4SlPD1vbBmZkD0pwk0JoIWvaOp31eKajIKmfZ
 IuHpoyxrFw3mgrKQ1N+NCG60Opt75/lKp6SiulSMPVpqKnH6O+r1ynZF8XeN6Ynwpb14nFa7ddz
 Mpf2NS6Ns3TZUl0+uHMwJGRoomXc8VKGCq5Ne311kYPmUVLR+8Tpf8Jx7Q/mlEtHNkl267ogLd/
 nJViRWoidpLg5XokICSIF+lKZ6mukxfqwVaGia
X-Gm-Gg: ASbGnctDjBkbtqYE8a3b3MKVEQLAisbnAu52mc+JkcZ4T0pkAkzzzMcdO0Whmi5zIx7
 5qSGI9PmIObmk7KkP1ymx42BZj9JHb2dkH0adbh4x6lhh86Y8KzXBQNL/fAplk7svCgj44EMjD7
 tk6WE2rgCDZ5sBecIVZQmiouI5bokyHJZjD/YzlcT9G6JbD38QDoNeipXjwnTclW22yrSzHIW6/
 IYazPhQHHkTaejkOHkQDqAdwpOyft2+bPyfBroEluUISew8HaEyUiBA
X-Received: by 2002:a05:6000:1fad:b0:382:4b2a:4683 with SMTP id
 ffacd0b85a97d-3878768842fmr240687f8f.2.1733934522757; 
 Wed, 11 Dec 2024 08:28:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKkrbbkNT4OV2i5Il92UD68pQBbGj/9xVKbgcwTXTooiAB5o8AxUnKC6/SaH7JaqjDw2D37A==
X-Received: by 2002:a05:6000:1fad:b0:382:4b2a:4683 with SMTP id
 ffacd0b85a97d-3878768842fmr240667f8f.2.1733934522309; 
 Wed, 11 Dec 2024 08:28:42 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824c50b7sm1608536f8f.57.2024.12.11.08.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 34/49] qom/object: Remove type_register()
Date: Wed, 11 Dec 2024 17:27:04 +0100
Message-ID: <20241211162720.320070-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

At present, type_register() and type_register_static() are identical,
although their documentation expects the *_static variant to accept
the Typeinfo with the strings that have the static lifetime.

However, the code implementation doesn't have any check or guarantee for
static lifetime. In fact, this is unnecessary because type_new()
duplicates all strings, thereby taking ownership of them.

Therefore, type_register() and type_register_static() are redundant, so
one of them should be removed.

Since the changes required to remove type_register() were smaller,
type_register() was replaced with type_register_static() throughout the
code base.  Drop its definition, and delete the requirement about string
lifetime from the documentation.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-17-zhao1.liu@intel.com
---
 include/qom/object.h | 14 --------------
 qom/object.c         |  7 +------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 43c135984a6..a201c9712a1 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -880,24 +880,10 @@ const char *object_get_typename(const Object *obj);
  * type_register_static:
  * @info: The #TypeInfo of the new type.
  *
- * @info and all of the strings it points to should exist for the life time
- * that the type is registered.
- *
  * Returns: the new #Type.
  */
 Type type_register_static(const TypeInfo *info);
 
-/**
- * type_register:
- * @info: The #TypeInfo of the new type
- *
- * Unlike type_register_static(), this call does not require @info or its
- * string members to continue to exist after the call returns.
- *
- * Returns: the new #Type.
- */
-Type type_register(const TypeInfo *info);
-
 /**
  * type_register_static_array:
  * @infos: The array of the new type #TypeInfo structures.
diff --git a/qom/object.c b/qom/object.c
index 9edc06d391f..c7660f9a097 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -175,17 +175,12 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
     return ti;
 }
 
-TypeImpl *type_register(const TypeInfo *info)
+TypeImpl *type_register_static(const TypeInfo *info)
 {
     assert(info->parent);
     return type_register_internal(info);
 }
 
-TypeImpl *type_register_static(const TypeInfo *info)
-{
-    return type_register(info);
-}
-
 void type_register_static_array(const TypeInfo *infos, int nr_infos)
 {
     int i;
-- 
2.47.1


