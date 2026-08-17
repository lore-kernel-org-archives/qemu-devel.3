Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7B4C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxfH-0003TV-H2; Mon, 17 Aug 2026 09:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxfA-0003Su-3u
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxf8-00021B-Aw
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZJZ1vTfQ4X4n6DhMPbSXuibBX09Z/gvdSMaXWwEFG0=;
 b=MoEZ5I//YWJ32U4FpEr5t9X0++9nYgJJyCA+CIiUyqAp0CD42sfjp+S/k/GWmZhP05LKjp
 sKStzizmj8A6i4Xcad657eUtItPad6Y+OJFFrYATkukbfCGpEA0zPu45oRk7qk6jl8mjuU
 FEFhTF5Tlvg3vqj9ruoeB0CXzLNIfVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-hjHBETarMf-QymInkTqT8w-1; Mon, 17 Aug 2026 09:45:54 -0400
X-MC-Unique: hjHBETarMf-QymInkTqT8w-1
X-Mimecast-MFC-AGG-ID: hjHBETarMf-QymInkTqT8w_1786974353
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954a93c565so18044175e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974353; x=1787579153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZJZ1vTfQ4X4n6DhMPbSXuibBX09Z/gvdSMaXWwEFG0=;
 b=I2rYnUUIHXabtQcofDvjyhebDfeVrA1YF8xOt2faoXkVfvksF2j2UAduahU+n+e2y/
 oJEUy1AdYPhFsNPbKOWqA4SF/+5NVo7cjzTH+ij7vJtKTuVUoWpQdth0Biw7rXXY2AeI
 IKqYSPvdkGL5XjlZZ4O5rYqIETcKfjuW2B3qH1BE9nwSHav4oMnmrd1SfvwDmOH00Qda
 l9rbVXYYH8ObkJs4YNZg7lBbk7JEO9vfnftd3yu1Y5lZk5jBJjd7jNqFSADvYueWLaFR
 Y0QCOavu7NHUWNeRHkXT1nqeVxRNBWrmcA0cW8iMoB8vsFOjcQI1Aa1g9b79+E6zTkDQ
 /8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974353; x=1787579153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eZJZ1vTfQ4X4n6DhMPbSXuibBX09Z/gvdSMaXWwEFG0=;
 b=Y1smxNklYW3xAe8SGbbt575wrBHfzB7aaYbq+Y/sxEXZEZjzt/Su7C4NP+ripGogNa
 Ieu+1K+tFulu+vZEvutPIZ/hMCtLr16ZxxG7YNCXUMyEvk/2dLdAhFY1SggHCJsFpWRm
 eDCYFeLVYuyC4FgdBHW4KOzxHw1XHJMYQfV1Zg5leUIGjlBNSeBnG6SUd6pzPsIWiPvw
 4C+RNj5np5znxqAnFpaqcq122JtW+ZXGUgBk2v7SVzbo6bM6ptH69fFT5ZIaU94bXayb
 Toj4kObWLWa2wJtyKarE/o4eVYSxKHHMoLefQ5PrQapejyMdPTCrcTskQYnn3S0ZIl9H
 xuxg==
X-Gm-Message-State: AOJu0YxWkKj4NsVRbFrTm5maKu+V2UoU43O7hsSJB9z4nxCeBZU8D+kW
 QUR974HgGgTdJpy4tWv91f16YzzaZVpxQBU1TT7MAkJyLmCLA5WMp+4Ft49tZyCHUQq/aSsax6c
 oEz/K1jPUfu0Ma1Q9d6kOolaXIVW/a1RDeT0v2qNcPfnjw9NSENIGJW8zE/9kabTfsG3zKVC4Wq
 DSw2e9n8qQd74vF26Hc5HevQYfrYHW4FmzTtIXr4O/
X-Gm-Gg: AR+sD11RzRkwTDPdOE95nQP1zzVGihFBEyIihfgavhfnzuwlUSweBdglzXVRuUrjN9Q
 wumU+2oLefzICcHrcwUCIGx/SC4DZuDsOKR3+s0XmjnIuxhztHaP94hp+tAyYQlAy3ZbTJxPj1h
 V0gjPhbjoOiRwDuqW06cBwRD22Ssnytpsp0NO1QUyYgOmr4+dxfsMRkTKXh1ktPvdrK1MLE0OvS
 8L8Y+00f/o6KwZvqsegZ3rEPFBxVNQlLh8DnOb2kbMNTTT9xeepZyAmAT1BiqxglsWyN+qpprxm
 uq0/vhmV5lDxUbrAwePgbOEfiQiKt3ZqhefvVkU2ikkVG83WWYOuZgwQJ1ZUTigkPAkPJuQdBYE
 7/cgL3ZE54rkqnA5WmRq2e8hMeoY+HvzwKZ50Qiy50OnqxKWpLz0dFZZCwl/T6FUfd6JDeKBCcs
 lFhGU=
X-Received: by 2002:a05:600c:4fca:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-49987961c23mr381396525e9.10.1786974353267; 
 Mon, 17 Aug 2026 06:45:53 -0700 (PDT)
X-Received: by 2002:a05:600c:4fca:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-49987961c23mr381395355e9.10.1786974352704; 
 Mon, 17 Aug 2026 06:45:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d11f073sm49117855e9.15.2026.08.17.06.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:45:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 5/9] meson: use compiler_target() to get rustc target
Date: Mon, 17 Aug 2026 15:45:33 +0200
Message-ID: <20260817134538.924615-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817134538.924615-1-pbonzini@redhat.com>
References: <20260817134538.924615-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


