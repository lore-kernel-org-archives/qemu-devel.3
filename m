Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD14C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjgY-0000sY-2l; Mon, 10 Jun 2024 14:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGjgW-0000nm-Gj
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:24:00 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGjgU-0006HB-N4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:24:00 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52bc1acb9f0so272742e87.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718043836; x=1718648636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lhD8SNX4mHL3omulyjAcCiMBXUceKEOKSRtwr2WCRs=;
 b=NabVEPjDhd16BG2F+evLiSiHmLBSo3W/ad+rk0jrel+xtt9NW3ivuslcbZrNNxtpp2
 8h4EjOl1kmNSb66GXq5VQTuhUsVhw9ARjwJ5cuLRZN2oFamILfyIEJqUHwBA3vxFic1a
 TsRn3XDuzVF13n0d/pNWQBbhtwq9F1Ax+sDRp3U1EH2ao+F+oR7PWxuxM6XnDL4Gl6HB
 fZyBTPdIXs1dk3Bsr9XJopzdLHCwgyVv/XuoorKOiVAaCU0kKnS9B6fqEUiEaOXEDNsl
 jf/j996sBrR4eiD5PzI3zYyk1b00TSVWWxWdyHw0+QWdWcKt4r59vwVauJABVflG854e
 hCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718043836; x=1718648636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lhD8SNX4mHL3omulyjAcCiMBXUceKEOKSRtwr2WCRs=;
 b=TkDbFYVXR6VT31rfDl0qxjyEiHFU0cUK8Jv72h56z5IqDYgDwbtiSYjqjiRqpOxK82
 2xABvhvUcavInqUOCyQcB2nEdMOvhseop4FY9WWYo51tpa5axU6V/Hwka0dDoQoVb4cR
 NcPYUhZrGxnBJozBiozYrA9EndpEbWhyvY6HYcbTxFNjPobiFN1bXRJAVI4EsLAhKRF8
 PHce6yjtbj20107lRNspHjEAN3qQe3uvHJ8i6XiG8JjW2gTGlLsFJ3WtPBlzThjLuNwr
 LJHl77Qmj1cRWHnTRD6QvIPSnWl9X/0Dt2tyLCQPo2hMpie2N8V5fJ6rFeh5Vk/Euugo
 T2XA==
X-Gm-Message-State: AOJu0YwV5Bg+4VBynJriP1cTj6c6mSfsXQSB+ntdlmP0gPDtnMVHGoqf
 atkeD68NU34dCbwtUkzN8wj8xyNPboWPll1vE9qcqBEd2qcWvMOUBKIt1wr6FQMpCOkoD8UFtZN
 73Kc=
X-Google-Smtp-Source: AGHT+IHmlaFpFdYWBT6jRh+DNxm11tZDrrW04oy/HlK0TpVt/p1gaz8KcgSrpaY3JS4b51ZgWD+l8w==
X-Received: by 2002:ac2:5f64:0:b0:52c:8ea2:9a82 with SMTP id
 2adb3069b0e04-52c8ea29cf8mr1035558e87.35.1718043836078; 
 Mon, 10 Jun 2024 11:23:56 -0700 (PDT)
Received: from localhost.localdomain (adsl-33.37.6.162.tellas.gr.
 [37.6.162.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42161147811sm135487395e9.18.2024.06.10.11.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 11:23:55 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH v1 6/6] DO NOT MERGE: update rustdoc gitlab pages gen
Date: Mon, 10 Jun 2024 21:22:41 +0300
Message-ID: <de81929e0e9d470deac2c6b449b7a5183325e7ee.1718040303.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 1cd6519506..da882813b8 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -744,11 +744,20 @@ build-tools-and-docs-debian:
 pages:
   image: rust:latest
   script:
-    - cd ./rust/pl011/
+    - rustup component add rustfmt
+    - DEBIAN_FRONTEND=noninteractive apt-get update -y
+    - DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv meson libgcrypt20-dev zlib1g-dev autoconf automake libtool bison flex git libglib2.0-dev libfdt-dev libpixman-1-dev ninja-build make libclang-14-dev
+    - cargo install bindgen-cli
+    - mkdir ./build/
+    - cd ./build/
+    - ../configure --enable-system --disable-kvm --target-list=aarch64-softmmu --enable-with-rust
+    - ninja "generated.rs"
+    - cp ./generated.rs ../rust/pl011/src/generated.rs.inc
+    - cd ../rust/pl011/
     - cargo tree --depth 1 -e normal --prefix none | cut -d' ' -f1  | xargs
       printf -- '-p %s\n'  | xargs cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
     - cd ./../..
-    - mv ./rust/pl011/target/doc ./public
+    - mv ./rust/pl011/target/x86_64-unknown-linux-gnu/doc ./public
   artifacts:
     when: on_success
     paths:
-- 
γαῖα πυρί μιχθήτω


