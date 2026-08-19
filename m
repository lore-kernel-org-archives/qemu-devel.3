Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4F7C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwcVA-0007tU-5A; Wed, 19 Aug 2026 05:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV5-0007nC-Kk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwcV3-0001wh-Jp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 05:22:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso6539405e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787131340; x=1787736140; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zEBSWmDHcpbyAT5+oxLyqv+4C5kL0TnHpRS3uvgoVbI=;
 b=XgWwhs70SAN8p+NmpeqpROpBSGqqskGycG0x1WYA9zkIdljZL0IaEJt5tCF9IfLgSe
 af5RAnRgsJB01+yznDf0hJirmLiGXZOcvtrB01VBS2XjqZFP3bOaNhW1YRDKaql4qQ/6
 cNvKp69mtARml8AwmrHk0KWgxl+f8G40h66gg229vWoWSnvvwfRaV6D0Qn9YQNDfn+4I
 XMG8IIu/RDBWwdRVazJN4TyDSGVq4wyE7yKZ9RyFqEY6pEJGdLOxOBk1vfsGGPXmQe3w
 ft3uHQv5DrRVkdNe25SzCCRJp4v1Q1quI07PxzUqXlngRLdch6sFRPXJtDMBAcMoAxtu
 yS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787131340; x=1787736140;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zEBSWmDHcpbyAT5+oxLyqv+4C5kL0TnHpRS3uvgoVbI=;
 b=CPwbM7udHQRe2MAsqXFV9RHH6Cnk9voXgWFFi8/CZ/r2S80e+sNvdSuH1MgTnmjS8B
 E6vPqZ34Trd56urrDNseS923tUQdsbSuSE7Am8m4xFOEL2XmmN2LNKLgkaewKad2HZ+w
 LQEmLf8C0SAlW0Npi9sDbAo6o2UdfdlHIu0GHKUQyw2i7HXyUZ99Br2+85U67ReGmjn0
 MlkV5H3id0O5SKgYMexUAEGp/H8bleth8GZa5cqBMW14QC3kk/kCHCj1fTXqZ23rZF15
 JcRJg73uKeABzLAyfTPpab69rocrsOo5iI8i68nyRmhr3gQpRRrA4TtivrGKW/WdnvGR
 sLkA==
X-Gm-Message-State: AOJu0Yyb8IvTe4ZVXF5TwfT82hSR2T4YmiC+GqD6jr/B+o9M2oig8+tN
 J/0opoEXGTIoLOFzZ2EWdaq1meSiO02xllCGxN44Jg39uj3RUR23w8c9maD59PGvtJ0=
X-Gm-Gg: AR+sD13BooZ56vMpMDsGq1/DFtPSxTKRRc1mQ0mMOxM7AOJwaBDMSrQIo7I2Aa2xHn1
 /AcKvNrweNJxev/L3U5ETA1vRFORXFGdfMaI92Bpuqrj1SRJLfkZ4iVgfVxHphYux+5YzMyvkWb
 s7srvx7n9+xGOicGlNUamy3AfWzY0PJns/qKrRrxEYYduJiJISCXW3f9wRFgBIMK75Y2Y8rtlA9
 P8TFA96rg98jBPpxtf61yxCLorMUskkvemaF82zGIVl98A4A3XWgzz1n9iwN/pUC1bhMzCe7bIT
 nTD5AncWEuIc3fF2V4zT3i80renZlZGTNLUXp2KXAqdd6nRt/17G3Ewd2lGfmjbx/BZ1xupFwcT
 Uhl8yd4qRRP6wsejOQq4jCcylvfZ1HeqSGyyQJPJpr4GrTNxqRxRQ5vc9P3Xedljwc+p8mFLKmw
 z3AAUPmAgJKYlygBuhwr7+h1+k60vXPCmhumiIFpemTYLIRec0qp98TAyj1ueS
X-Received: by 2002:a05:600c:190c:b0:499:5282:f8d1 with SMTP id
 5b1f17b1804b1-499aa1ac47cmr54101095e9.12.1787131340217; 
 Wed, 19 Aug 2026 02:22:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450e61sm4408686f8f.13.2026.08.19.02.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:22:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 663D25F898;
 Wed, 19 Aug 2026 10:22:14 +0100 (BST)
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 19 Aug 2026 10:22:03 +0100
Subject: [PATCH 3/6] gitlab: add arm-softmmu tests to the macOS build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260819-fixes-for-11-2-v1-3-b7981c2cc371@linaro.org>
References: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
In-Reply-To: <20260819-fixes-for-11-2-v1-0-b7981c2cc371@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, devel@lists.libvirt.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596;
 i=alex.bennee@linaro.org; h=from:subject:message-id;
 bh=B9ZSx+meoWvdNqJq36oJBwbjPxCumeybg4Iya8CkY5Q=;
 b=owEBbQGS/pANAwAKAfvQ2wlanipEAcsmYgBqhXXGWquFVetm/TQPeCRaIqpMdvkNgXP2Pe5Gv
 MiUAU1Rn2OJATMEAAEKAB0WIQRmha6Z51FnvK/I3zX70NsJWp4qRAUCaoV1xgAKCRD70NsJWp4q
 RNgJB/wIygNvGYLCcR6OOBZpVYQYPNJ9YUZ2FoQlAWuEHigXvwnQZXykBG9s0tTMvtOdfp3ecz6
 H226V/XnMRF43ZAzsQMI80N5HOhF3ZBu/9j/ztxr31FSReMszHh3rj9Jb4xkj2bFEBpmZJMvF6T
 eY+c7ZIEMLKvlutTKUYzTDYjEY71AZ3/mwixyyARMS6c5+KgrUR3cvYd+d9beyeF0duFUO11dZN
 hK2vKKtuVWz3N4WvR8RJTTfdoPurDwxpZ4K1USsIVt330YxOMOz5f7bLKXVQsH7/u3bdTsBXmz1
 Ml5NEOMS+g6T7s9CIa6cHrH+Jayjq6DxjdE1muhorCJu6Kbu
X-Developer-Key: i=alex.bennee@linaro.org; a=openpgp;
 fpr=6685AE99E75167BCAFC8DF35FBD0DB095A9E2A44
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now we have fixed the compiler issues lets have at it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260723200904.224413-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/macos.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index bdb3eae18f0..40b9b637b3b 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -22,7 +22,7 @@
     - export PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
     - brew update
     - brew install $PKGS
-    - brew install aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
+    - brew install arm-none-eabi-gcc aarch64-elf-gcc i686-elf-gcc x86_64-elf-gcc
     - if test -n "$PYPI_PKGS" ; then PYLIB=$($PYTHON -c 'import sysconfig; print(sysconfig.get_path("stdlib"))'); rm -f $PYLIB/EXTERNALLY-MANAGED; $PIP3 install --break-system-packages $PYPI_PKGS ; fi
   script:
     - mkdir build
@@ -40,8 +40,9 @@ aarch64-macos-15-build:
     PATH_EXTRA: /opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
-        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
+        --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,x86_64-softmmu
         --cross-prefix-aarch64=aarch64-elf-
+        --cross-prefix-arm=arm-none-eabi-
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins

-- 
2.47.3


