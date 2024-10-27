Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103D0D10C15
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 09:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4zva-000361-Gh; Sun, 27 Oct 2024 05:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4zvX-00035r-Pz
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 05:51:16 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4zvW-0007rU-4n
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 05:51:15 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a0c40849cso544029666b.3
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730022671; x=1730627471; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yJvUkCOiC287YxkoFbbtWODq3vAJ4vNAAkLXFsOIOZ0=;
 b=nXHu67DkSQvH0bel1qDt36UP0Mym/2yQuGcb9yB6PMYRy86i/AIQ04drL+Qmiy34oi
 wy/Ov+KOp9+UymO7ZFmId9T2BQSk8HW/uQo8TdTnZmGhb4JkouCOY3eleOWeFyGWILgC
 MYPf0kqxmdYGVPuANxOgC2BEiq5ynsP/3iQsm76io4477eXmv9zQ2/hilkmaTnfXsfs1
 Dc1xqSoATcybClPsZKnI/i+NaBl3Y4LWAEk4wOe1jRoEPZG0zQFrArLgf68Dr0ez30f+
 TQv6rt08+A6Y4jr00wLy87Jfq/+lw1iZUmSJVsKcdGKODDIwL5/qTsNAsOcL3t1/n5yO
 wIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730022671; x=1730627471;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJvUkCOiC287YxkoFbbtWODq3vAJ4vNAAkLXFsOIOZ0=;
 b=gro5D64arDZwH6Cm+4taLLwrE0YsaD3qUH/rEgkPMXhN2k5rgtse31Xj7kr79pO3WI
 QgkmfVGoUY3eWf+4CmQNZPTt3gpwF9xiwEoRLCWNJMRtXBNKQl5m4DSmu/rFVBvvsCD8
 PPyQzOdnpBRlNaBroRl4UtBcsMnZabX984Ys/FuaBbRMOij4ZShg9UsR3oYjzePsNy62
 c28SK7CA9K1yN2fQzPfKH87GrH8bpYsGTg1YKGLP3fL2gVBVO0nGa5k0tpA6TODtIS0e
 5riDajSy39eoGCIbqEp9d/9mtk99aoISlpijtqxJjDwSPkGeXNOvUfI/Wf8gZ2P5QjiC
 yLYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDdrvPxrPOBsIkCiQYHCOr75HBW/GTLAVTrlUyiwm64OlQ7KWnAP6u8mHcdSUhsfBtZ/BrVf2kKJTd@nongnu.org
X-Gm-Message-State: AOJu0YzE1+kgM+B5uyxAM5bC6WGCfMxwx0nzGctvJvnnPnOkpoRejNH9
 hHTEU91YboiG3TnrNzWmc1UVDIchN6zgIWscw5LJtbHcD13/9nyglPLHVpnolKU=
X-Google-Smtp-Source: AGHT+IEBvid+SztKvoK8/13AdN+fCVIEN4TJqWu301QxPUBw3hwe3uHRo+g7oNdyCnFCswuY/eAROg==
X-Received: by 2002:a17:907:7fa5:b0:a99:fb10:1285 with SMTP id
 a640c23a62f3a-a9de5ce252dmr392830866b.20.1730022670839; 
 Sun, 27 Oct 2024 02:51:10 -0700 (PDT)
Received: from meli-email.org (adsl-161.109.242.225.tellas.gr.
 [109.242.225.161]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b3a0881d4sm261488866b.216.2024.10.27.02.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 02:51:10 -0700 (PDT)
Date: Sun, 27 Oct 2024 11:49:56 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org
Subject: Re: [PATCH] rust: do not always select X_PL011_RUST
User-Agent: meli 0.8.7
References: <20241025094248.152556-1-pbonzini@redhat.com>
In-Reply-To: <20241025094248.152556-1-pbonzini@redhat.com>
Message-ID: <m0e19.8g754qmy2u4@linaro.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

On Fri, 25 Oct 2024 12:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Right now the Rust pl011 device is included in all QEMU system
>emulator binaries if --enable-rust is passed.  This is not needed
>since the board logic in hw/arm/Kconfig will pick it.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> rust/hw/char/Kconfig | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/rust/hw/char/Kconfig b/rust/hw/char/Kconfig
>index a1732a9e97f..5fe800c4806 100644
>--- a/rust/hw/char/Kconfig
>+++ b/rust/hw/char/Kconfig
>@@ -1,3 +1,2 @@
> config X_PL011_RUST
>     bool
>-    default y if HAVE_RUST
>-- 
>2.47.0
>


(Do I need someone else reviewing this before picking this up in my 
tree?)

Acked-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

