Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D91D0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrQt-0007f1-BH; Tue, 25 Nov 2025 06:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrQm-0007ac-0h
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:42:01 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrQk-0007qT-J2
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:41:59 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso3221374f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 03:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764070916; x=1764675716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWc2JGrwmNdqrXpcFkor3SJGgMnY1Re1+PW7EF1RyCA=;
 b=peV3lP06vsTMkc4pa5oaCS0N5uQog5GPLXT7bZ40tDkACZpCfUcqyCt81m/pdYSl3g
 0UyMk35rn5vGDNJHkvgfMv43WOKGGM0v1W3tAXy1FbpCwOBHwR6x50TgV476SQhvKlOl
 437AT/UAaUTDvedfH3YE4sYZxRPfElbo7PZplr7uDs82EYETv9PkVDqR0euvT93Ix+Jx
 aPOYfAju2LneeiHJN9aAFjLeeEeeTRBBZ355fs1itJuwUTWF7MDLoStugZ12Ol2QPGZN
 0zPpzSLy5JGGNVdg5p8yYBdW6cbaSoIeob2NdD4bAwW55sTeK9kxoxA9i13iBWihp1Zb
 O/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764070916; x=1764675716;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JWc2JGrwmNdqrXpcFkor3SJGgMnY1Re1+PW7EF1RyCA=;
 b=lWU7F9dNZkQS+La1+6zY5oQPhfdjOlC75y1e1NJsFmKwZ3n0F/L4+TyrZfHeKESg1z
 01oXSIiU09I+wfHl4WfY3Grnr5o5qNvx2+lz/4gvVUFyZwr21LvdUYJQDxDF6sKlyV+2
 /ld9HyLWS9XTkWvwcowhqCI+GWCJNKmOb8w0OQNN6K+7JTImATn8Kmgtoy0aFjTwca6w
 M49a6WzGs8N6X4ogf0frMkfbqrgzXIaUGDAr4XmzeRqcMZzNui2lVNuWW4eEZaVpApG7
 S/BHH941XJgqwKm33hGS1sv1t0GJasIGFwEupMHJ2IKINqfvHBM5MJeyFBk37+3N6I8+
 iB8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmapLbvVHV05UsT5dTfYzqGbPI6ifBu4GNq+0LsABYLzgGPy9pnNUbbIY/AexOOD8CQAzavmjfNzMu@nongnu.org
X-Gm-Message-State: AOJu0YxdCWR2nls8zTsLBGLFkkwHBDBBFIzzfajS5xKMq+jBDy5jMW6y
 Nj43umL4szxCLtmU/uIyLf64yx+AQ5oFXKkoBOxpyf+PaaIBKAuzos0JDfBQ9tx+F6I=
X-Gm-Gg: ASbGnctBejE2utvLWvX+LFvXshjo5abi4ov2QBkszmdS3dhXs8GSpFvsMTbUos36I4+
 Nt5zTcsWANYGZSFVlKS+/SKsNJKUSOygNFk/K1d61Lgg68LzJZ9Y9C8le6br9snN2bXhzDcapFS
 kLE2wzhHG4d14NldkbpcKNYXYg+9/cRk896w5QT403IqDOYBfo0bzGCCXzblXAyBGBZuburxA1J
 P9zKIks6QsRqvYpi9vbaD8HCZ0DHNJdTl4hQJxWbTTWRJ91vSKgyAjirha6PW+1tfo2psR+dDkQ
 LcWGhSDuPiF2b0jdq5Nb0q2+tmke0sSIwn8w48nKpykVBVJkV7zXfGZV8dFpmzDGav28G9b71qO
 eIzKF07Ic1XhJngeMIJ79AWbxeJk4gJfk5KQ7OKSkJUANYBRemjDI7amhZ8pc5Y1vE3ea/Hj5+X
 rfQ7iiO9ZrzEQ=
X-Google-Smtp-Source: AGHT+IHpAgbND1azQ7GQv7jHOsG5KZO+3wi6dWu9tlnimGGHAm4VK/A23p+zEO9VWOJo4XMrXCVVzQ==
X-Received: by 2002:a5d:64e6:0:b0:429:b9bc:e810 with SMTP id
 ffacd0b85a97d-42cc1d0cf3fmr15145338f8f.45.1764070915861; 
 Tue, 25 Nov 2025 03:41:55 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa41d2sm33911904f8f.22.2025.11.25.03.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 03:41:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46BD45F7EF;
 Tue, 25 Nov 2025 11:41:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yiwei Zhang
 <zzyiwei@gmail.com>,  Sergio Lopez Pascual <slp@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Robert Beckett <bob.beckett@collabora.com>
Subject: Re: [RFC PATCH v4 1/7] virtio-gpu: Remove superfluous
 memory_region_set_enabled()
In-Reply-To: <20251125023517.177714-2-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 25 Nov 2025 05:35:11 +0300")
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-2-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 25 Nov 2025 11:41:54 +0000
Message-ID: <87a50a8hkt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> There is no need to explicitly enable/disable memory region when it's
> added or deleted respectively. Remove superfluous set_enabled() calls
> for consistency.
>
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

