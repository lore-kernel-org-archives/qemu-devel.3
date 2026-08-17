Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76325C5DF7E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxgl-0004Pn-PW; Mon, 17 Aug 2026 09:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxfG-0003Tp-93
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxfE-00022t-GT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+OTC0ftwFJ9HNITLsopCas1KJp8rOV8DJe4NKhlpn0=;
 b=GCCczurLmwExewGDj9pezsJ56FWKMNIq27dpKKtN9cfglVwBKfyC5uQDg95152mZooC0O8
 SG1qY8su5fvGcr+u88THcFJwl+7ThTdVFKnCxZG5MfyRZvoS2lBwPkmGDg0wCAEJ0p/WnC
 SDzu3iAUY/N7nEq6Rqaa9c9GIqa2CoE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-KimEmbIKMEm6urqGlVbkkw-1; Mon, 17 Aug 2026 09:46:06 -0400
X-MC-Unique: KimEmbIKMEm6urqGlVbkkw-1
X-Mimecast-MFC-AGG-ID: KimEmbIKMEm6urqGlVbkkw_1786974365
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-482a5e9400eso444730f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974365; x=1787579165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I+OTC0ftwFJ9HNITLsopCas1KJp8rOV8DJe4NKhlpn0=;
 b=PWTEP1DwNcs++tRdCmloQyroXKFZdxSjaQ8lkh+8VxE2ViP7yvyC23FkE4mFMNMoPt
 5W0R/uFixjkXqR+4luLZXy64zrdZLip8/vQo7cnxgU8KXs7OjRK7hoJYsD/GVD7XyH6g
 lA0QcOt3JvrTKpgVEVwNbWOo0tTZj6couOw/sEzirvblU3cS5zhB7eb0swDf92aD4nMR
 IwWCSyqmLQYG5LAU+9AWqlMXgI3izSHTghpHGndNxJk1GNbmfPrF6WZJVDv2LslWeflB
 24Reqj8QNf+jUvOkLfp/2rruKxCAIh0ADnPbyaPqNb4aZzwKNCriJ2BFFu8c3nYiJK48
 x7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974365; x=1787579165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I+OTC0ftwFJ9HNITLsopCas1KJp8rOV8DJe4NKhlpn0=;
 b=ACeA4zPqvOo7RxGTKq5SuQdQ5QwhImck20c7YdAW13KrtqPndCs7pUctCvCDBgm5WE
 8EJmFD5QsKK3tsrYa3Ju095dtlNyWsFHVhgpeiDf0oSPp5i5nTYnGH/3VWVqO34Mtje1
 psj2IVe5GFDLiW2VJ5zmjMxUjQTj/rPOCuN0zFQwxcNeRYVmPvAg978HOyO6bTUSrZmw
 GeoKRcpwZ2cv5umd1Lbivm4Hhc95fvCCvMLKiZCpmDh9ypMVCTiPCSKOAtr0S4+NJ2sO
 v0xlgbuaCPMUIRwndAPUhkBd5LY6FrkOCfCsfxFp2WbPIiNcaaQnTgwKyZNylxN6mxTk
 i43A==
X-Gm-Message-State: AOJu0YyrRWg5Ar5ICExg0FRPNE0Zj63oTu0zG62W4Yk/ZiquLkBtbtKj
 qP/0MxwZFGzlgKhuHQB/Nm3y0m+cLdzXHlwY7Mfq+SA0ZWGyoFwB1kPRGuYSvCeZctV6rKD+kTj
 sG5HYJRgeJ9K+aW9qBpzFnokkGM+JPNZh19cLuKvjlt3i5FBxvL5IPHrXMdJxiKLuX5CzgpOusQ
 ZthNYACZhfGXe83ONi/b/Fh6M1GNHQV+s8fa59MNR0
X-Gm-Gg: AR+sD124Hj/WJ5SgvnVQutQNr94sDLKcUdH99sUfD7/lsXVTOFngjWyzIPYM07zrJw2
 Oh1Ow+bLvf+F0MDp4/+koKizSuFF0RnPldill25T8RKoImGKMm+DhZa9p+GcMpxeAUxtfSZgGgb
 WBGxNIU6Oe5yxY1fH90zdfyfmjuuKO0DW4DLsEgA3T+qe9nTRAa0XCaKcFP3drpI1nqhbMgwFQk
 NSU6WgyrM5+knGagkT7kTbtmcp6KfINnl+hsWvlXlKagvSfsRakHyYACwOulccYVnkADbZjW6h1
 tAiHageV8slY7fV5OrNdfT6nzBOmWc17REEiGufxRdxdH3ZZUAqB+ddIz2oV99W3opgHp5MGCmy
 nZpCbA5ZSg31L18im8lXUck+7uBya8a8UXIpFjMwWvPqocDThccir3mcUFPkzDe9X6hiAs41BDn
 Gz7jg=
X-Received: by 2002:a05:6000:480c:b0:47f:9283:1fbe with SMTP id
 ffacd0b85a97d-482a8fde687mr759359f8f.0.1786974365052; 
 Mon, 17 Aug 2026 06:46:05 -0700 (PDT)
X-Received: by 2002:a05:6000:480c:b0:47f:9283:1fbe with SMTP id
 ffacd0b85a97d-482a8fde687mr759238f8f.0.1786974364572; 
 Mon, 17 Aug 2026 06:46:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3158asm4218880f8f.7.2026.08.17.06.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:46:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 9/9] rust: update Cargo dependencies
Date: Mon, 17 Aug 2026 15:45:37 +0200
Message-ID: <20260817134538.924615-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817134538.924615-1-pbonzini@redhat.com>
References: <20260817134538.924615-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Update dependencies that are not used by meson, only by Cargo.
Several packages have now reached v1 and therefore updates may
be less intrusive in the future.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Cargo.lock | 85 +++++++++++++++++++++++-------------------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/Cargo.lock b/Cargo.lock
index c94c2386d94..66f684098d3 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -136,9 +136,9 @@ dependencies = [
 
 [[package]]
 name = "hashbrown"
-version = "0.16.0"
+version = "0.17.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "5419bdc4f6a9207fbeba6d11b604d481addf78ecd10c11ad51e76c2f6482748d"
+checksum = "ed5909b6e89a2db4456e54cd5f673791d7eca6732202bbf2a9cc504fe2f9b84a"
 
 [[package]]
 name = "heck"
@@ -189,9 +189,9 @@ dependencies = [
 
 [[package]]
 name = "indexmap"
-version = "2.11.4"
+version = "2.14.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "4b0f83760fb341a774ed326568e19f5a863af4a952def8c39f9ab92fd95b88e5"
+checksum = "d466e9454f08e4a911e14806c24e16fba1b4c121d1ea474396f396069cf949d9"
 dependencies = [
  "equivalent",
  "hashbrown",
@@ -212,12 +212,6 @@ version = "0.2.162"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
 
-[[package]]
-name = "memchr"
-version = "2.7.6"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "f52b00d39961fc5b2736ea853c9cc86238e165017a493d1d5c8eac6bdc4cc273"
-
 [[package]]
 name = "migration"
 version = "0.1.0"
@@ -342,29 +336,20 @@ dependencies = [
  "proc-macro2",
 ]
 
-[[package]]
-name = "serde"
-version = "1.0.226"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd"
-dependencies = [
- "serde_core",
-]
-
 [[package]]
 name = "serde_core"
-version = "1.0.226"
+version = "1.0.228"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "ba2ba63999edb9dac981fb34b3e5c0d111a69b0924e253ed29d83f7c99e966a4"
+checksum = "41d385c7d4ca58e59fc732af25c3983b67ac852c1a25000afe1175de458b67ad"
 dependencies = [
  "serde_derive",
 ]
 
 [[package]]
 name = "serde_derive"
-version = "1.0.226"
+version = "1.0.228"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "8db53ae22f34573731bafa1db20f04027b2d25e02d8205921b569171699cdb33"
+checksum = "d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
 dependencies = [
  "proc-macro2",
  "quote",
@@ -373,18 +358,18 @@ dependencies = [
 
 [[package]]
 name = "serde_spanned"
-version = "0.6.9"
+version = "1.1.1"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "bf41e0cfaf7226dca15e8197172c295a782857fcb97fad1808a166870dee75a3"
+checksum = "6662b5879511e06e8999a8a235d848113e942c9124f211511b16466ee2995f26"
 dependencies = [
- "serde",
+ "serde_core",
 ]
 
 [[package]]
 name = "smallvec"
-version = "1.15.1"
+version = "1.15.2"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "67b1b7a3b5fe4f1376887184045fcf45c69e92af734b7aaddc05fb777b6fbd03"
+checksum = "8ed6a63f02c8539c91a8685a86f4099661ba3da017932f6ebbea6de3f0fa7c90"
 
 [[package]]
 name = "syn"
@@ -413,9 +398,9 @@ dependencies = [
 
 [[package]]
 name = "system-deps"
-version = "7.0.5"
+version = "7.0.8"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "e4be53aa0cba896d2dc615bd42bbc130acdcffa239e0a2d965ea5b3b2a86ffdb"
+checksum = "396a35feb67335377e0251fcbc1092fc85c484bd4e3a7a54319399da127796e7"
 dependencies = [
  "cfg-expr",
  "heck",
@@ -458,38 +443,43 @@ dependencies = [
 
 [[package]]
 name = "toml"
-version = "0.8.23"
+version = "1.1.3+spec-1.1.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "dc1beb996b9d83529a9e75c17a1686767d148d70663143c7854d8b4a09ced362"
+checksum = "53c96ecdfa941c8fc4fcaed14f99ada8ebed502eef533015095a07e3301d4c3c"
 dependencies = [
- "serde",
+ "indexmap",
+ "serde_core",
  "serde_spanned",
  "toml_datetime",
- "toml_edit",
+ "toml_parser",
+ "toml_writer",
+ "winnow",
 ]
 
 [[package]]
 name = "toml_datetime"
-version = "0.6.11"
+version = "1.1.1+spec-1.1.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "22cddaf88f4fbc13c51aebbf5f8eceb5c7c5a9da2ac40a13519eb5b0a0e8f11c"
+checksum = "3165f65f62e28e0115a00b2ebdd37eb6f3b641855f9d636d3cd4103767159ad7"
 dependencies = [
- "serde",
+ "serde_core",
 ]
 
 [[package]]
-name = "toml_edit"
-version = "0.22.27"
+name = "toml_parser"
+version = "1.1.2+spec-1.1.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "41fe8c660ae4257887cf66394862d21dbca4a6ddd26f04a3560410406a2f819a"
+checksum = "a2abe9b86193656635d2411dc43050282ca48aa31c2451210f4202550afb7526"
 dependencies = [
- "indexmap",
- "serde",
- "serde_spanned",
- "toml_datetime",
  "winnow",
 ]
 
+[[package]]
+name = "toml_writer"
+version = "1.1.2+spec-1.1.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "7d56353a2a665ad0f41a421187180aab746c8c325620617ad883a99a1cbe66d2"
+
 [[package]]
 name = "trace"
 version = "0.1.0"
@@ -537,9 +527,6 @@ checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
 
 [[package]]
 name = "winnow"
-version = "0.7.13"
+version = "1.0.4"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "21a0236b59786fed61e2a80582dd500fe61f18b5dca67a4a067d0bc9039339cf"
-dependencies = [
- "memchr",
-]
+checksum = "23b97319f7b8343df12cc98938e5c3eb436064524c8d2b4e30a1d3a36eecdf81"
-- 
2.55.0


