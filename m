Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A54C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxPw-0005ne-9j; Tue, 12 Mar 2024 04:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPt-0005mI-7O
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPp-0001AW-Ci
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:19 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso3095375f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231794; x=1710836594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyCNdGxEUzn56uZqvjtKqW1lxcPgF0npDxgJEUvvre8=;
 b=lesFdg4HTUSflfoAzyWIKAOpzPkDoogKt6NUsFGz/EQjOpVxrG6XxgfCDPR4H/Lm3T
 7xO+/UjqxJ/79LtMN8or/470jknfzLB0KlpoJ0O9Ny1zd7nWd56p+rJ7jG6aHWE88Kdb
 V4uHpXRjyyKHcY+1FEviUnbUKFPbxDznjfBaT/n3hQ14I9AvHmgWHXL6rg4L5kViiaqn
 QN4Saxe+Jb2/cNqBwtp/LzmKEtfNBYX8zpR/OTiGLh5EwpPQayI+9hkaPEdQw+c5uJzM
 kHlxasfAnpBqJaPIDD8Gv2VV+6OPOneiyqu9uTQ974IUlJkDEw79GxoT5rjKxhYXbr21
 gqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231794; x=1710836594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyCNdGxEUzn56uZqvjtKqW1lxcPgF0npDxgJEUvvre8=;
 b=gPB0KS+5S0hemXnfp7NYDrv9bLJatP2aUFfipEscoCjE4UofBVBO9uEjXvFtXOE/5M
 Im3r7XvjrKaXszfdF/dEI1otq44IZKBDl9YdVnBlkloDb/Q7a7h/LGf8JEtZv8kBKDjc
 h8rFm6ht7Yu5qU3fksDn4hRi1RYEire0kxkk4ElA+kwLr2kZSj/ojY69adv0OzpU+9bD
 fwk3ALaCqZQe2/UA/FnMuD1Y/0ZQj4VRLvEyKQHyD3rHMISb8tsildqi2gCG5a58SsSN
 k3hDZyONniiHmQc/qRhm7ETn9f54XVPOWMKXlLLyEBw4qxe4UXLfgY597OGKrHPbn81V
 MPHw==
X-Gm-Message-State: AOJu0YxcfBUbtlpUMVoSi/l69pQqLVNRemcjIEkEn2XSY22T88pEjhp1
 DlR7VyFFY+CWmZpvsvHAnpCfkb4T9qpD8royvkhVJvdFGq31RKjKm7SOoyUzW2zfod93kMfR47m
 U
X-Google-Smtp-Source: AGHT+IEt61EFIIXe78sgAnGpd4Hm/swxGXcKdWRvf9p4g6dYVBmS6WsyIxUMLJUudHeQgJv2okIlCg==
X-Received: by 2002:adf:a15a:0:b0:33e:9ce8:407a with SMTP id
 r26-20020adfa15a000000b0033e9ce8407amr3030528wrr.13.1710231794245; 
 Tue, 12 Mar 2024 01:23:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 c13-20020adfe74d000000b0033cf4e47496sm8443384wrn.51.2024.03.12.01.23.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/13] hw/core/qdev-properties-system: Fix missing ERRP_GUARD()
 for error_prepend()
Date: Tue, 12 Mar 2024 09:22:30 +0100
Message-ID: <20240312082239.69696-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

As the comment in qapi/error, passing @errp to error_prepend() requires
ERRP_GUARD():

* = Why, when and how to use ERRP_GUARD() =
*
* Without ERRP_GUARD(), use of the @errp parameter is restricted:
...
* - It should not be passed to error_prepend(), error_vprepend() or
*   error_append_hint(), because that doesn't work with &error_fatal.
* ERRP_GUARD() lifts these restrictions.
*
* To use ERRP_GUARD(), add it right at the beginning of the function.
* @errp can then be used without worrying about the argument being
* NULL or &error_fatal.

ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
can't see this additional information, because exit() happens in
error_setg earlier than information is added [1].

The set_chr() passes @errp to error_prepend() without ERRP_GUARD().

As a PropertyInfo.set method, there are too many possible callers to
check the impact of this defect; it may or may not be harmless. Thus it
is necessary to protect @errp with ERRP_GUARD().

To avoid the issue like [1] said, add missing ERRP_GUARD() at the
beginning of this function.

[1]: Issue description in the commit message of commit ae7c80a7bd73
     ("error: New macro ERRP_GUARD()").

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com
Cc: Eduardo Habkost <eduardo@habkost.net>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240311033822.3142585-16-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev-properties-system.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index b45e90edb2..00c968f4f5 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -242,6 +242,7 @@ static void get_chr(Object *obj, Visitor *v, const char *name, void *opaque,
 static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
+    ERRP_GUARD();
     Property *prop = opaque;
     CharBackend *be = object_field_prop_ptr(obj, prop);
     Chardev *s;
-- 
2.41.0


