Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D19C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx60A-0001WH-QU; Thu, 20 Aug 2026 12:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zx-0001MR-GV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zw-0005mz-4W
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNM9WY3GDs9NFIUbF6VOCyMHiscyOHLyp4b12lS9z/8=;
 b=NKepYMs+R/vLm4tOf3/A69W2oFvzxvfP4CcwX69cvYpOOR5Hqnh7b6cAEja58wZiWmi75Y
 gkgt4Nz6x82dYmEynW4+uWQGTOGPWPU1/FBJugtsnlTcdpKJ7npJ4W+nMfrLzngdu+J4Zu
 mas+42+s5fOfAvmriRNFyVnYBn5Tc18=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-mh51oqVlORigBfNEmMp-dw-1; Thu, 20 Aug 2026 12:52:10 -0400
X-MC-Unique: mh51oqVlORigBfNEmMp-dw-1
X-Mimecast-MFC-AGG-ID: mh51oqVlORigBfNEmMp-dw_1787244729
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49808ea1b64so12545675e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244729; x=1787849529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FNM9WY3GDs9NFIUbF6VOCyMHiscyOHLyp4b12lS9z/8=;
 b=OoSH08sLZhExaxao6bg1FY7ku1vpBSLhgkk9aSsFQ/ifrii3uTIB/Xt3wzeFn74Yhx
 AUHi8RQ9r/dcGlAGDJaVo/q1U0s/gsfY0I/WhxMHisKJL5A7ql22SNR2xUVyHRE+e454
 9JvxcRNbcq8p4vfFcZwHocuxXHFV1OKvefODjI6+73yabN+rAyjwGLxvQ8FmNsbBoya2
 WP7I5Ht+TmYs31jBeNyHNke9JzzQHVXZxxg4t8vswOYSxZBSFAk1mFNcULZB4U4jXcwY
 f0rfqJkQcmOXdAW63D88vBDqLczESwAyV9kIkjz/Jqt24NPADH5WeiSyvD5Y4j6+bUp+
 Z70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244729; x=1787849529;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FNM9WY3GDs9NFIUbF6VOCyMHiscyOHLyp4b12lS9z/8=;
 b=ehVuKq5WQeRvr2nRC7oE8j6ZfqSKrxzaiGUvdmzZErqMt7Cd81tFJbWXgXXaNC70+9
 Id3X3/woCix0yj/b08DT/a/tNl8tydQWtqYFP/290OS9n5rN6lsmo+atBDuFhPGjCZqh
 5Gy8uzzjpsCm0gx4yHzijjW439HWbZ+dS0fLbX57Ou9wn1/ZkAOVj2gq8xN405TJT5Bo
 6XoMZLyBT3wGUxRpPfXauvbGYKDQZYpLqIyCtfFNlCMPXmr3Tg2MpzGTP6Ljf+5sPQgC
 POU0y4VBa1ShQtJAksfZOcjIFxReA2CZmXtHhGWkVYNLVlLLfgfniam8rGFi7Z6+xGqg
 lYzg==
X-Gm-Message-State: AOJu0YzAOYeE20vJ7D6fgSA6JBqxB4LDr0Ls8319hWuBln74WKvjwr2F
 NjMV1kRSO3ciHBAw+C/QWcILDocp7opjLCHkhsHiENon9/nSZXBY0noniNzd6YyBeI1XTKuaQ/f
 otZyaVsLdKsgmzapxHjso0QeViKKI4UdFGGcc+aSrhoEBV7QcMGL8UjCEtTApfMA8e1tVXWozPZ
 n1ThS2i0KmLZNNUiN1AYbmNaS5v9kUkF/6D3nqRQs7
X-Gm-Gg: AR+sD12jq8CbGGG+OOFoIDp3UIkUgOgijzXGkyRfTYM+/X9HTlJuLfCWWTT7A1m4/4g
 uErxOK9kmjU8SS2wgNoxy7l0UABeeiGEU+3hRiw4r6KhqpK4jstD+BVpQFyI1XA354o5Wfb1hj8
 3fIa6PmS54K5AQPg0nzipjuMGPRrBF5V6b9VNAqFhNjroEnjEXpjob6chj1R6VJvm2m/DiL1fm6
 PvUGndKzPOluU/Empm8Cip2Xh5xUrMowEkyx0uNOctn+lt1gLXIeVn7JIogtwaH/cQA6mz1BKfa
 I1YJ4HiZrg5sG63cvjnneMeWlsVlrbRWESmHCXK0WyydvZz1TxZK4u2xbUihOLrX51bRvcKmHqM
 /JeSeFljiXLbqxpjxAQ/GBvpOFyvdgSw43oFCKpwY1tFAiX3kUxc3oxUQbNtoMvdzFM4gfDKvZJ
 P92AU=
X-Received: by 2002:a05:600c:674a:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b06cbaf2mr130356515e9.7.1787244728768; 
 Thu, 20 Aug 2026 09:52:08 -0700 (PDT)
X-Received: by 2002:a05:600c:674a:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b06cbaf2mr130355195e9.7.1787244728137; 
 Thu, 20 Aug 2026 09:52:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11f832sm148671175e9.7.2026.08.20.09.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:52:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 47/53] meson: use compiler_target() to get rustc target
Date: Thu, 20 Aug 2026 18:49:50 +0200
Message-ID: <20260820164957.1895963-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The new method in Meson 1.11.x removes the need to pass the triple
via config-host.mak.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 3 ---
 meson.build | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/configure b/configure
index 7f637c018c3..56158cd95f7 100755
--- a/configure
+++ b/configure
@@ -1740,9 +1740,6 @@ if test "$container_command" != ""; then
     echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
-if test "$rust" != disabled; then
-  echo "RUST_TARGET_TRIPLE=$rust_target_triple" >> $config_host_mak
-fi
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 2139dfc7ce8..2593eb97624 100644
--- a/meson.build
+++ b/meson.build
@@ -4747,7 +4747,7 @@ else
 endif
 summary_info += {'Rust support':      have_rust}
 if have_rust
-  summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
+  summary_info += {'Rust target':     rust.compiler_target(native: false)}
   summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
   summary_info += {'rustc version':   rustc.version()}
   summary_info += {'rustdoc':         rustdoc}
-- 
2.55.0


