Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E738E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZy-0000g6-Hr; Wed, 11 Dec 2024 11:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZt-00008C-OR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZs-0000aD-0w
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjLaRBaRdCVTJi2oAEc5ZtcK2yHd81SHmdhSzBRFY5Q=;
 b=DVCFTJTnOX1Abhm2PWgbBr05gTFz/uMOM2O0CeWl3pwdeJv3E51EbPSJ5v5orY1wvyPGbn
 CFgVLmKq1qoPqGjsRk2o7FAr+NBGTF5+CUuyobjT98XaREk2iU82dU9gEcu7T/cAIX4Jv0
 Frd0GYbOE2+8hWhEc5j1bWOHfsVKN00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-3KZKh7iFPrKTxIm0yoHxtg-1; Wed, 11 Dec 2024 11:28:42 -0500
X-MC-Unique: 3KZKh7iFPrKTxIm0yoHxtg-1
X-Mimecast-MFC-AGG-ID: 3KZKh7iFPrKTxIm0yoHxtg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-434f3a758dbso36614155e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934520; x=1734539320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjLaRBaRdCVTJi2oAEc5ZtcK2yHd81SHmdhSzBRFY5Q=;
 b=hEmxNaP9ouJJOAZ8rLf8xuOlFDLnDp0T7XqmyDUY0MzbPdbeN6Q6Um4Ag/uFCMhx9V
 XmcjCDA8z55LNk9kP1xop4C/hozoFf/Eshw/l5Gpzg/2RaqmJKruUvbJGSNB130pd2sf
 1pvQRJ3lYXlKaTWL8XA3n2HiKWlzzQk8mgRPjT+moYISbyY1dDqMMz0x/TXjbNnPX7hG
 hzE7/qHro+wGw8t6hthf8+C7YpHCODAY1Rk7GOWbWBS2ZinX8U8O2BxWbb4GRW2LO2ui
 nolKo0jPd2dxMvcT1mIsECEq8+jYIhUzlZVGG62sL3L/W2mzQpdnsRdrc+8KXrYnz1K9
 krEg==
X-Gm-Message-State: AOJu0YwSuXD2W6Ko0c1rmMulov9xW+tRCFrjOAyMtwuws7ezXda+49Ma
 qj/H7gAKzisaW9zyt6SN/zbMqKAZg99TphL50dJY/KIxfrnzwjLyz6HeE4IlW1zZwuMRrHu7US/
 U9Q1DxQxaUWWop9UcSpFw8p9m1D5O3ROi/wKWd0cgc8ESfijS3uShAKgm4HeYV+9XMJKMZMp6Ne
 OeJ/kvwEC9elfGsFzt8pi8s36cc5ulk8NNllLp
X-Gm-Gg: ASbGncvNer0Ey8XIgYpkHKUivB2za5KFNKWtXCsLigdZ82wYk9yPeNmfdNP7ELHOZAQ
 Bs16yf9rmuEGyBpqC+tpvkyCkgKXXyKamqXaYkX+GpFhQtpT2m1F8alfD4fXwHat8HgzZe4pr8d
 Nr0F3lYyCuuLh0vxCt4HOjetAB83hdt5XD5O+n0tmKIqj1i8v3K1KnDaqOpywFkJoz3nfFT4O36
 RFNo/Tg7cctGbO88ewwMYtjIQvyVNyheMA8hD51+0j0JjyEtV57RUH+
X-Received: by 2002:a05:600c:384a:b0:434:f817:4492 with SMTP id
 5b1f17b1804b1-4361c43dc27mr37638685e9.31.1733934520201; 
 Wed, 11 Dec 2024 08:28:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFclGICY3jk2+EXDpcD3fL4VZvN4bOkX1OHjpfFL6jJSIObw2BqSBdDBVX4OV0spzoi+Tfv1A==
X-Received: by 2002:a05:600c:384a:b0:434:f817:4492 with SMTP id
 5b1f17b1804b1-4361c43dc27mr37638395e9.31.1733934519786; 
 Wed, 11 Dec 2024 08:28:39 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251c151sm1622494f8f.90.2024.12.11.08.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 33/49] script/codeconverter/qom_type_info: Deprecate
 MakeTypeRegisterStatic and MakeTypeRegisterNotStatic
Date: Wed, 11 Dec 2024 17:27:03 +0100
Message-ID: <20241211162720.320070-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Deprecate MakeTypeRegisterStatic and MakeTypeRegisterNotStatic because
type_register() will be deprecated, then only type_register_static()
is used.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-16-zhao1.liu@intel.com
---
 .../codeconverter/qom_type_info.py            | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/scripts/codeconverter/codeconverter/qom_type_info.py b/scripts/codeconverter/codeconverter/qom_type_info.py
index 255cb59923d..f92c3a4730e 100644
--- a/scripts/codeconverter/codeconverter/qom_type_info.py
+++ b/scripts/codeconverter/codeconverter/qom_type_info.py
@@ -901,26 +901,6 @@ class TypeRegisterCall(FileMatch):
     regexp = S(r'^[ \t]*', NAMED('func_name', 'type_register'),
                r'\s*\(&\s*', NAMED('name', RE_IDENTIFIER), r'\s*\);[ \t]*\n')
 
-class MakeTypeRegisterStatic(TypeRegisterCall):
-    """Make type_register() call static if variable is static const"""
-    def gen_patches(self):
-        var = self.file.find_match(TypeInfoVar, self.name)
-        if var is None:
-            self.warn("can't find TypeInfo var declaration for %s", self.name)
-            return
-        if var.is_static() and var.is_const():
-            yield self.group_match('func_name').make_patch('type_register_static')
-
-class MakeTypeRegisterNotStatic(TypeRegisterStaticCall):
-    """Make type_register() call static if variable is static const"""
-    def gen_patches(self):
-        var = self.file.find_match(TypeInfoVar, self.name)
-        if var is None:
-            self.warn("can't find TypeInfo var declaration for %s", self.name)
-            return
-        if not var.is_static() or not var.is_const():
-            yield self.group_match('func_name').make_patch('type_register')
-
 class TypeInfoMacro(FileMatch):
     """TYPE_INFO macro usage"""
     regexp = S(r'^[ \t]*TYPE_INFO\s*\(\s*', NAMED('name', RE_IDENTIFIER), r'\s*\)[ \t]*;?[ \t]*\n')
-- 
2.47.1


