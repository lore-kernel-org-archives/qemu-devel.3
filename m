Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB40D2F7E7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 12:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRUfc-0000Hm-Su; Fri, 05 Dec 2025 07:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRUfb-0000HU-4s
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 07:12:19 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vRUfZ-0007Hm-F3
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 07:12:18 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b728a43e410so121462066b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 04:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764936735; x=1765541535; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2XRnlhiwavIpLGtlzN2ORGNW0HReMgjKp4yD5l5HSg=;
 b=wsBR5R33LlAyyQcmupskfyBEXaxIxigN4P4YhwUwk8ifJT/v3ui9Vf8g5zMK9ievqx
 NeqPincUTBWAjFX0SVdD98QFKBincgxxn2q0AqvAmddTpXkJaIKgwvy7D5qGVHz+9hTA
 8k4JDmO5EZO72d4NRGyqoACEhsGhwwUcnnE5u7FlwtfyeKjokGWvg0rB6DdxZIcnxml2
 fulsNC71yYcmUKkPS0k9uJe5s5rjB1nyMskEiwCOKNq9PdhyNWns3xExCtgzgHpcBfCn
 25ICkx7sjWYqYVBqj+SlIv9qeaOnPbjMq6TUUh1Wqpy2mSR2D/FG+qvsM76Bmq85BcBl
 aOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764936735; x=1765541535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c2XRnlhiwavIpLGtlzN2ORGNW0HReMgjKp4yD5l5HSg=;
 b=JGt8ne3F+P1GUTUG7y3AFONc0r7CAjtb/4tPcVkoG6vShZlSCn/QA4/52NdyrwDOMs
 tPjkOqXXRyy8FlIlyaOLhX/fiAjl55EQMAtsnf3V57UVfF16tfma8bY7C2OmY1xcNvch
 BqjozPDC9gSrogo9GZkOr7vF2e+y9OwKdp8x+oH37roFh05YdsRgD8PaHUdTf7Ue6tAn
 J03llwSwXPIjIVV61zUetHZ23ZHxICcqENczGQHFUuV5yGRgK2XUJonF8YYIFdTvQ4mi
 2F93zIVg8jytYCs96ORH95y2GVFUSZPVwTI3yL4OHSWYsSeO2cv8n0g4XGYjOKzzFzav
 +ucg==
X-Gm-Message-State: AOJu0YwxOBZ+aNwzdJzKYxdvE7RlhA7FW/2K8SyPSg7mB6PG/1QoYv1Q
 tHm8eHzqnnnjIKzyJSniiDCyivoMe+fIOdCuiSCFct0usZ8OqH7akQ5rxe7gSenVOgJjutG7OWo
 vXNLA5eqpfoGkiyBauewPSXY6l1pgRhvWwAtVj8B6ABCduqRh56A8
X-Gm-Gg: ASbGnctnMcCx2IbAMWdL87ewU81C5IMJ9kQBFq9T7WQz/pc8MveGFD7yONPSH8zq+Jj
 3gUNrewZaVtEWO+7CqazSdGUmQHq0f/NgqbYrpklN7YCDyEGaUFTp1JbklbKKfByROhi3tuFadT
 aD4Lr1Z50gvP5FdKYPMfeQv2wZ0fC44+dpXXRDIDyfxcUxSjt0Y4rcyQSNdmyK9xbr0sZAsiNbK
 T7DKceOSICNpNoudUw5l7vsu+YZgcMmWoxav/5+9hQsDmgkjtXnsKHokSwAzyVlcV/C5Yn64r96
 asMv68ytxdZJa3Iebm5WyjE=
X-Google-Smtp-Source: AGHT+IGZg6hZAJFmKkiBrMg9iKwk8vbKcv1GpEfZ2cP90WAivem1ALl2jqXD5zB7+ob3cp+10huywVUgsl8I0eOMGy4=
X-Received: by 2002:a17:906:6a0e:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b79dc7c2abcmr1079599466b.56.1764936735242; Fri, 05 Dec 2025
 04:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20251204162129.262745-1-dbassey@redhat.com>
In-Reply-To: <20251204162129.262745-1-dbassey@redhat.com>
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 5 Dec 2025 12:12:03 +0000
X-Gm-Features: AWmQ_bmKvH-NPsKJ7ilYgt13z_MrL2BKsCLQsqUl5vtPqmb_o9I3wK2f8QxEITo
Message-ID: <CAJfKr9U1VTE5ANiGp7QJO2wF0GJ7NPkqoPUa8R02DFT-rCX2Vg@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: Dorinda Bassey <dbassey@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com, 
 aesteve@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62a.google.com
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

On Thu, 4 Dec 2025 at 16:22, Dorinda Bassey <dbassey@redhat.com> wrote:
>
> In `virtio_add_resource` function, the UUID used as a key for
> `g_hash_table_insert` was temporary, which could lead to
> invalid lookups when accessed later. This patch ensures that
> the UUID remains valid by duplicating it into a newly allocated
> memory space. The value is then inserted into the hash table
> with this persistent UUID key to ensure that the key stored in
> the hash table remains valid as long as the hash table entry
> exists.
>
> Fixes: faefdba847 ("hw/display: introduce virtio-dmabuf")
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Albert Esteve <aesteve@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> v3: removed blank line between trailers
>
>  hw/display/virtio-dmabuf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

