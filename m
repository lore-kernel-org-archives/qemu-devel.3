Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD28AE92716
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 20:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZb01-0005Xj-8h; Sat, 27 Dec 2025 15:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vZazz-0005Vx-Q1
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 15:34:51 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vZazy-0001fX-9s
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 15:34:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so5254192f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766867688; x=1767472488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEgcf0g7xz2yQfStCXX1lAHfx7yyQr6RaMcd+9FvbvU=;
 b=b07KRotY75fZHwTK/NGwHS4EUAqG7jFpkldP2Ic3KuB4Y/pynasYJvYn7z0KAa6t3t
 SUH7X7gr7C7tPlzZcXIRDu8PILPt8Zh3VC5kP7iqLbXK2xegOtDmdNb6/RAvQL2OOax1
 8NW7cGYcqB2ygKfDHxYEKIKGmtTwPY7URSY6UTR7JNPuoMKklIDKiQFi6UjvAtSvPvw1
 7ZI+D+WJ73Nlcsz79leUjmSw5TRPpRZiBNEDs3RflJ2ztS2A+6AthSVn6PXwpWHJFFos
 rtIclsdRc4Gtx/uKBWt7KeU9kTSJrIP0A5kpcS1nYeRf7840rjDiuY5rCIQFk75Rd0XQ
 5EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766867688; x=1767472488;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WEgcf0g7xz2yQfStCXX1lAHfx7yyQr6RaMcd+9FvbvU=;
 b=Y1rvtzKtvLApbVZp9LIwqfOn2IlqHfq00rqI6cKBdiEl6Dbs93DjpiEyMMGxfP7vze
 bKrFSNkLsRi3eiqVlbm7TxJgNrVNuS0rgdb9NUTfePgXl0XkzesAsVQ4OCLxspTdYAV/
 lljWcCxSNSrogA9sxgbieH2OzXoIJ0vRROWQdNpLdzVklzJax+5oxbV1Bw8WVkIFEA4v
 vAHIibI9OeYvYQrtBbngyLTy65w91ya+ROMGLktXjEAzuYRpDXf91114U/EGgy460GOQ
 hDLDxhHrGF5kq8m1ICfw8owISJdZIv1xf7WQKMagA8K1HZLd4maGz2eqluYSxlblzYjf
 3qjg==
X-Gm-Message-State: AOJu0YxjxkPZruv8NbQ4V7VOaaInp42AJt/HKIozgHEh2IyQfSvKk6EN
 LeuOL1uJ9hzK6ARJ3P+Wx44pS0SAqOFK+CL4vD9Px/XYhUi6iToLYUmk4pSKDXmCHDD5YtSzhrZ
 F0M4X
X-Gm-Gg: AY/fxX5AgRCEBAEBGT5QtmP/9OHQw4rsFW909UgYmgHIRUFdM3xNEMk0O3ZqIVE+SMX
 4jOQdwL5JUd8x8ut7ST4au94EtaWkI88V/AVi0Gw8T1tNEFP2M/PA9Z9QG3VOmSq/Ae4y6XBdec
 NANgPjyV/ZnpKN67mFWznu1F/G/gW42GzCSFljKhyUO5qQ8FHBJ1xxbBcRoJDKR5b4Wycezyt58
 EhUGM0hyDpO/2v0mmibzi4/NtrEWqrbzX8/Lf5TiVdaXl/tLXdLAKBighCIsn74gpgZHa/1Z383
 flFHtwdgHII9TzzcAoQ1/kS6etqUijfiV4oXkbQ4obXJTzmwKftk3MENnSsN9ZiiJXmNCLVdLey
 LY4PobzS5k/nDK5cZZISPKRInuytF7fzp9RyQswYs0hanr8Z2R8KirZffR8p7Xs9GZHOM+ID95J
 Zm/Y54Vq3ZHgI=
X-Google-Smtp-Source: AGHT+IEfbXGubQIYf96eQlshCLxMNO3ckoRhhdKrc6HUdIR3VOcv3xx/jxJjSWkEEf0VcDKvQXjvzw==
X-Received: by 2002:a05:6000:1842:b0:430:f1d3:fa2 with SMTP id
 ffacd0b85a97d-4324e4c713dmr30179703f8f.7.1766867687580; 
 Sat, 27 Dec 2025 12:34:47 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2253csm53510319f8f.14.2025.12.27.12.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 12:34:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E780A5F874;
 Sat, 27 Dec 2025 20:34:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] plugins: bump plugin API version
In-Reply-To: <20251227094240.6652-1-neither@nut.email> (Julian Ganz's message
 of "Sat, 27 Dec 2025 10:42:38 +0100")
References: <20251227094240.6652-1-neither@nut.email>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Sat, 27 Dec 2025 20:34:45 +0000
Message-ID: <87secvr7dm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Julian Ganz <neither@nut.email> writes:

> We introduced a new function `qemu_plugin_register_vcpu_discon_cb` as
> well as some types since v5.
>
> Signed-off-by: Julian Ganz <neither@nut.email>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org

>
> --
>
> I should probably have included this in my patch series introducing the
> register function in question instead of noticing that the API version
> was not bumped with 10.2.0 after the fact.
> ---
>  include/qemu/qemu-plugin.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 60de4fdd3f..b445c26389 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -72,11 +72,14 @@ typedef uint64_t qemu_plugin_id_t;
>   * - added qemu_plugin_write_memory_hwaddr
>   * - added qemu_plugin_write_register
>   * - added qemu_plugin_translate_vaddr
> + *
> + * version 6:
> + * - qemu_plugin_register_vcpu_discon_cb
>   */
>=20=20
>  extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>=20=20
> -#define QEMU_PLUGIN_VERSION 5
> +#define QEMU_PLUGIN_VERSION 6
>=20=20
>  /**
>   * struct qemu_info_t - system information for plugins

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

