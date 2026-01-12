Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56455C9EC63
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFMb-0001TF-Fl; Mon, 12 Jan 2026 05:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFMZ-0001SG-Jx
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:41:31 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFMY-0003EE-79
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:41:31 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso49608205e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768214489; x=1768819289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SKw6ziNXPHJrlxuqIsJKhOni8JqfJhUXRsndNwL8Pw0=;
 b=DhBHUWvaz0hy5BqborAbcM9g/8dq+N5AJ+quUx0430+0k8FcibxNXrevRJtTK/vO6N
 5/n+Z/At1KlS3Pwk5QGqPJfX9o+ZccnzDf+hTGCwwuaUnaViXo/ljuIQsBIuC3hTCwcm
 NLvo9Y37Qxc+qcFdAyzIdGzCrdLcPU/m/EI+dRnuMx+9Kv/VKrEmRhnFuCoPmUMyf88p
 OwBjNDawNsaiSrgLmXWKCn9KMkWmVancaQ31Tks4y8+34ch4K3FNHljWbfGdSawV8Irl
 b3ZIERnEGli4m3qn+yTbtfrRzJO1mfidlZYm+Jya0RCIoJpC/Fn1K5JVD7lAWbI8ehhI
 HlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768214489; x=1768819289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SKw6ziNXPHJrlxuqIsJKhOni8JqfJhUXRsndNwL8Pw0=;
 b=tcST10OWgaWJ6HP8oINuUTUwpZyhS7WBrlPyPljvhDqGZGgiwuUqIRT82jYNCDwS/f
 09NdRUdXE995rBBJ/BtFcTj1+JpcIxssXeXz8O1Ap2iyjGq1BuVY8dI+Vi5n4UI1KtH8
 sIs5zEahMbsvpuXnlNLGbpf60wPodFA6yOEnAXCxwotv/CWLozGmaWWCMQYJW+rPfg88
 o1inuztsVjUsCGBa8vSioo/IztexAHoOiHBBmXT9fS39t4BC9njhmzk4fc9x8cvIteqK
 MnkywT7cic+oYuQAO/68+hg3eMzuFsyn6Nd5umQXaqW2LFBb85mHiSF5Cd6Rn/Vd1Uig
 kWJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ0a90pSxobb48oeUZx83EYxdfuLE8q35uNdg130wInPij82hvJdn2fwwly68H6REfXAXMOAlJY/5M@nongnu.org
X-Gm-Message-State: AOJu0YzRkWc9yJPZQWsgIUr0BnWh/kQxEBPvpocHgKwG5/mkp+gjy3Lh
 L47do2Jcr5HAj8Evsx+RVzLmsdPlm7Haw2HOtdbbgGGQMn8/LpZSymeeS9IFjHpmfmA=
X-Gm-Gg: AY/fxX7D8ah4p87AXdTQHgG80PLQ3iPXOtLcAPkHoqIl33zTUMsqNeDkyr7v6yJOLNv
 isTCxF8+aqcF0MpCfxwxbb0ihQdRKaa91Bf5XT73U7Lt2OoIU7e1nSjc6NfCPjRWQl0kfDVJNlv
 9v6VXPRSSQmTZj0wuFck9GBs7G44jxTqFHmrNqLRtlJ6kJ/d0JfuWGfzgtmco3oODy5Uau9tVY5
 yfhwjn4n5ONgdyggjc9V7oujSAFH9O20SHieswHxiMaBSzKssYnpGFaa3yksHEulZY3d0eelcMO
 WBX/x+wubkVForY4hoABOTlffuviMMflpXZ0qLXyKDmHh915/8twhxX/FWB+GaDTNzaanB8GDza
 PG0WH+JweittDn/h1gcV2cojhWG2wX02y/8W1CCkcXGrUAeAcX/GQsJWZQLzTGskTZK16zZzftN
 V5FkuGRZE+rqN4NWK1Fgeai7wv/S0bkjjwka89q37HQ0yYZl4NWTdLVA==
X-Google-Smtp-Source: AGHT+IENHqNtumL4F2d5ux4DA0FUbwV1xjj8N5MxrZmBRna+oR/Q1fx91H53t/NDu/WP1YbzBFGo6A==
X-Received: by 2002:a05:600c:630f:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-47d84b3b4d7mr190809705e9.30.1768214488756; 
 Mon, 12 Jan 2026 02:41:28 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee870sm38207355f8f.36.2026.01.12.02.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:41:28 -0800 (PST)
Message-ID: <777843d2-f840-4093-8928-c1f700631bde@linaro.org>
Date: Mon, 12 Jan 2026 11:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
Content-Language: en-US
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251126020208.2449414-1-honghuan@amd.com>
 <20251126020208.2449414-3-honghuan@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126020208.2449414-3-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 26/11/25 03:02, Honglei Huang wrote:
> Unify error checking style for virtio_gpu_create_mapping_iov() across the
> codebase to improve consistency and readability.
> 
> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
> on error. The original code used inconsistent patterns for checking errors:
> - Some used 'if (ret != 0)' in virtio-gpu-virgl.c and virtio-gpu.c
> - Some used 'CHECK(!ret, cmd)' in virtio-gpu-rutabaga.c
> 
> For if-statement checks, change to 'if (ret < 0)' which is the preferred
> QEMU coding convention for functions that return 0 on success and negative
> on error. This makes the return value convention immediately clear to code
> readers.
> 
> For CHECK macro usage in virtio-gpu-rutabaga.c, keep the original
> 'CHECK(!ret, cmd)' pattern as it is more concise and consistent with other
> error checks in the same file.
> 
> Updated locations:
> - hw/display/virtio-gpu-virgl.c: virgl_resource_attach_backing()
> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 4 ++--
>   hw/display/virtio-gpu.c       | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


