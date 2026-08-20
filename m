Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC493C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx60J-0002Za-1r; Thu, 20 Aug 2026 12:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx60G-0002I5-Jj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx60E-0005ot-EL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIAqd6a63BrQ3nMEKcWvDHjF/pUKTwSYOcy4U14TrKE=;
 b=YJ3gisBRREBS8Ys9LOuLo9rWF5TSSev4HBoAVeUoeDj2hQ/lnqSgAYpGjGQaBs6w9FEuNb
 M1fVq9EP4viwF9Fq981UhOVk1XUTqH7wg9DIamTvODqhXojVjchh312R34C3RYE38fd2M9
 cBZDWQGZdnyu50Arv4YrD0Vb2OrWEIU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-WoESTNjwPVGqltFkWEYDDA-1; Thu, 20 Aug 2026 12:52:28 -0400
X-MC-Unique: WoESTNjwPVGqltFkWEYDDA-1
X-Mimecast-MFC-AGG-ID: WoESTNjwPVGqltFkWEYDDA_1787244746
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6a18e266026so105075a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244746; x=1787849546; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cIAqd6a63BrQ3nMEKcWvDHjF/pUKTwSYOcy4U14TrKE=;
 b=aYW1oULFUK4GFMfJNI3V7qsxpsId/1gNaZkaIzJA9h0COtb0+bWdtNWVtGlSaHVaj0
 7EpTX0lF+2J/0+SDVw92FvSypKoqm6MQd+EtOVi/huROzNiPSya+8dEzzghsLEAoyIac
 vTObm9Nv6teFoOv4MYKvQQFFyb0sGI7RMvNfyuRfKE0EXR5r20tZqZvg2eDHKfbLXnMT
 vlwmkTqmu5faYL1DK4rNWsOth+3rinjavcujRGfJMLqQm1wIDIb4VARwiihu2gQHlWYM
 EFl2Hd6mpiz2I3jPaZCMbCnQkPvn3vifmrLXceTusgoiFU58v6kpBYw1g/E7wzhYHjhP
 6CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244746; x=1787849546;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cIAqd6a63BrQ3nMEKcWvDHjF/pUKTwSYOcy4U14TrKE=;
 b=BHvdnB6hM+VXXYJlapMh2bDbBc2mn3b4SnkwEBvk4tZkbEJBr+CGwYcxD3h6hj5dW6
 Moj238skJ6REasXHhnzpbIXRQD963k9Db5CPxEvfLlsPZ++VAEm1lALD/Q0gp3DXMWGd
 v4Xp/TdP3OXGw6yPM1xJyuZ4syd+o9mVZzosHbzcN40O9jFq5Qnj//eb5RBMUq+Dt6Ly
 E0nLlB1/dGkYYNKOPraoltto5X3F97VAv6uYydoLBcSfxHA8XtpKxA9IOHJYXV8X6WkC
 HeaTzMRPJBTdQd6WOizZc2YhXWmDb22YwDmcgtuitUylCDizJHjm+xPaAFxlwSnxX6+w
 ouZQ==
X-Gm-Message-State: AFuF++kUsr+oj6n1iddpnPGJ/UcPduIELcP9LcGATaBc53sXkrBj0Ejg
 lEdx4nCg+EeLDCUqh4GmKZLyP8VVqQmRDSzdGbPYMJkwfouUtHBFqTcJCAjPzQErmeZjNDNwCzi
 yc2A604WgzZx+PSN283l3gryNwP3xcf5LA39F2jZzQSZB8Vf5v0XbeAaJtDvynqw8g5yJML1aGU
 uSPHPwiNsxBjtl+s0kaI1SNfXnH2O/p9IlaeOgw4KZ
X-Gm-Gg: AR+sD11TbP7EtfKzvOuUwtJPLvNd0l5zWNBrm26iyu+ANv19kP3hgiLSndZ+FXGtVus
 4L5EKXNWTfJFOZdhsjJMjJ3gK2GdG3PmgatGpJ6jqfU9Z8YZP/KN/o/Xqn1S/EEswiTmkZwV4RC
 p9hGWC3i6Qm5qDDNqqdPUklarn7c1NT5uPjsOASzX8Yr78YEyw66UfsmYtpmgAg5a2mwFBhqn+r
 jF+nbgP6w0FIw6VdumxSo9kyEy82U9P6vK93ojcxkcbJ75ime1rAoKXOTjnDU1dvZmqu+vGtZEX
 gI/Bt4DmsuYVxYneaagCdrbX2PO0JbfS4kMVF1SZb5VnDz5WlGFZRm+UEiQNWMnCxNl3D01loTL
 xwWAA3k3DE+uGjKZKtyKieE//nNADePFgRCUEBpCz/1EeIYByfCDmWOoT39Jd2aMAqlGByULb7i
 9OFZ8=
X-Received: by 2002:a05:6402:2186:b0:6a1:2400:baea with SMTP id
 4fb4d7f45d1cf-6a42f18a70cmr112196a12.10.1787244746048; 
 Thu, 20 Aug 2026 09:52:26 -0700 (PDT)
X-Received: by 2002:a05:6402:2186:b0:6a1:2400:baea with SMTP id
 4fb4d7f45d1cf-6a42f18a70cmr112164a12.10.1787244745568; 
 Thu, 20 Aug 2026 09:52:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0d362dsm2629448a12.12.2026.08.20.09.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:52:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 51/53] rust: update Cargo dependencies
Date: Thu, 20 Aug 2026 18:49:54 +0200
Message-ID: <20260820164957.1895963-52-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


