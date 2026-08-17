Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC95C5DF74
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxcb-0000al-Ph; Mon, 17 Aug 2026 09:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxca-0000Zz-L7
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxcZ-00017A-8J
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dd1LkKVHpMKNBAxyLy3xafKxm8lY7EohcdDnjmPahA=;
 b=Y+KMHjxJzzsQT3RYhRIEf7wPa5xIzvS75H5cxAfCPF0717VwI/AxP7NybFfwAj2Vliw2CF
 S6/FGkED9gluOP+XvodHTRc6eduyPDwfttNV6eJwJoMMeIr0vTx6EeuYw8dk2msW/oOYO/
 ZLOUw3uSgZbs79bWffTMFkZ9HhfDhlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-6oG6yvNWN8CkIXBqD1ou2A-1; Mon, 17 Aug 2026 09:43:20 -0400
X-MC-Unique: 6oG6yvNWN8CkIXBqD1ou2A-1
X-Mimecast-MFC-AGG-ID: 6oG6yvNWN8CkIXBqD1ou2A_1786974199
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49545071724so33144275e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974199; x=1787578999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+dd1LkKVHpMKNBAxyLy3xafKxm8lY7EohcdDnjmPahA=;
 b=CFtCREThRLMDCgB7cmN9M+EtStkKQKkR+GVtuTOvkr4APS7+o1m82wFa1WgCmbkGTD
 T/yl6V3DjnorknGBqUsHErqDQhc1XJhf03Uidmz6qM74K8+IJtQjZSVYx38KN+9SQ1Uk
 ooLCS9V3NhSdJWTNH0/61wt6hEtTmfuixTyuBjdZYju+kvXX0qrw+H+wZ4AjRQBh95BQ
 XqaASRCnLVZ+Vde7ut49pbghjltOAPcBygvk6eQoYHfjpHGwwQFjz4mpi2PBUUNCJ0oc
 MKM7ZqREK2kwYZnpTFWqz+x6Jw9+9Azf1ED1Re6K5sj6fzETQ+IUf37pdMxKGCt9Ay0F
 ewyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974199; x=1787578999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+dd1LkKVHpMKNBAxyLy3xafKxm8lY7EohcdDnjmPahA=;
 b=E2hgUnkXcoffwvyVuLgMa8n+JmKLIL2dKtJzhhiQgcCuV2txY3OF+uDDOi4sjUx+kq
 mqbpYVhJO/7NbwQtL2UTGMvkGSBe7fjUYrLaI9tTPh5DSLqimSVBRdasl3QI2x850/fP
 cn5Jl5fhjyZ98XX/UJeX+eMt6GoSFWw1IoUCT7n8OXLwft5cp0uv2lRCUYsmo2YrB/VZ
 aTcdbvFSOkMEh6Moo5bmsKkp5639t6KNadtyptmHGzXQXvxvIMy5k2dXlwqmK3zVG/S5
 4NDNOm4H21YD16gpOWUowUUmCkNKRpLlBkPpu/DrdYGXjEbVzFed3qM+ainyGYP2L+9h
 8S6w==
X-Gm-Message-State: AOJu0Ywuxz3zD+rNL0XiTELOMC5YUyalfvAdoTOaCRGy9ei/CetBEtGM
 6c7eDvWid9bzOK7U+DzBmGefGZfFGnYRm9Fk4QnBAIJzZu0wZ3vVZWFfIPwM45HcEZqzVoBe55O
 H3VUZjvFcX6cD5DWZ6ui35lOx+VB+ARMwlcFBtTmzkNZ+n5RbwgDoeW5X8sakau1cmnHSIz6vP3
 QR2DnSU5m0PLne5T9GEfzCEfqWGFUAUFbkXGUwSJeL
X-Gm-Gg: AR+sD12shD+mJO3jTQLvgGXsGw0PNhhWx93AFAHt5RwJcVp7z49bwnyWK1wzzSsySCA
 /XfraEyKJXFDSK4zjpxMudg2AY2RgjyLS0D2dEjmfIZ92WrNCeWpjInyv3yyzIbDi7H9PnvQ+EV
 lkAQQ+joRzIBwEA6Pxu5yX0pOABAHDRF4nnRfUd9VosSzPJZG8p/Q1YtGqtI8aoA8NKsi4ADetd
 1RDQhJSKgPr2h4rCiaIzO+B/ySVREIa/wCnwfhAsTfZOBOfcfz1lm1jqvCjpJtHRjojY9QJhkgq
 O5L2C79ZMIjSqinJEaGfe9J7RH/cmiua3UCIWJ7D6TIwpq3VPoDF+bXh/yjACiitHU6JNEg5uNc
 gtKLpONXKddjQ5XzUVK3qvtN09UF4yXTeeWACPtikC+uPSOqP75U43ThjGrvNpbCUFkWir1hCgp
 bQx1c=
X-Received: by 2002:a05:600c:1914:b0:499:726b:7375 with SMTP id
 5b1f17b1804b1-4998796a1e1mr389534485e9.14.1786974199520; 
 Mon, 17 Aug 2026 06:43:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1914:b0:499:726b:7375 with SMTP id
 5b1f17b1804b1-4998796a1e1mr389533675e9.14.1786974199128; 
 Mon, 17 Aug 2026 06:43:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d086c6dsm40828505e9.7.2026.08.17.06.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:43:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	alex.bennee@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH 1/3] meson: make linker warnings non-fatal on Linux
Date: Mon, 17 Aug 2026 15:43:11 +0200
Message-ID: <20260817134313.922754-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817134313.922754-1-pbonzini@redhat.com>
References: <20260817134313.922754-1-pbonzini@redhat.com>
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

These cause a werror=true build to fail with Meson 1.12.0, as it now
makes linker warnings fatal as well.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index 49a5baf5b52..40e3f4ec44c 100644
--- a/meson.build
+++ b/meson.build
@@ -602,6 +602,11 @@ if host_os == 'windows'
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-seh', '-Wl,--nxcompat')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--dynamicbase', '-Wl,--high-entropy-va')
 endif
+if host_os == 'linux' and get_option('werror') and get_option('prefer_static')
+  # On glibc systems, glib causes warnings about getpwuid, getpwuid_r
+  # and getpwnam_r not being supported with static linking
+  qemu_ldflags += cc.get_supported_link_arguments('-Wl,--no-fatal-warnings')
+endif
 
 if get_option('fuzzing')
   # Specify a filter to only instrument code that is directly related to
-- 
2.55.0


