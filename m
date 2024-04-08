Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9A3C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiVp-0000Au-Ga; Mon, 08 Apr 2024 02:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtiVn-0000AT-Iz
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtiVm-0000aM-3D
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712557785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKS1pohYRcEk6lPiqx2F/LmfAZqxAkx8CIvsEMNfFAM=;
 b=NerDRcvA/9hvNibbPEocGbarUpp1NKYyJoXXH8yOp+W9Sw2r4NqVQi7XJqsk4DeYl2haJn
 IbeMJFSq0wpQwejt22J+gAFdM49CSyIz7m0WP7AqblraBmfxWHMyRn17HssAoJJyxCXNFG
 kRfQV3/8NQES80/V5KPawFMGLpErc5M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-zwc9gPxgOve4Rgy5xy1yPg-1; Mon, 08 Apr 2024 02:29:43 -0400
X-MC-Unique: zwc9gPxgOve4Rgy5xy1yPg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29bf071cc04so3999905a91.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557782; x=1713162582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKS1pohYRcEk6lPiqx2F/LmfAZqxAkx8CIvsEMNfFAM=;
 b=QSfBe1ipzikhTj0/88mGqZNmhDh4qkV6vv6n2i3+kAOPFa30ea/G5CX6kYXhPyBdLq
 UD1Rvb0Y35WtJzZ33SiukLMaOVh/zkJWR1k+tWbj9ng4u/K5xxdyysUT/nIcOgJg81B1
 gUXXdjUX1df9OrZHmqNloMQwdGkGyIo3SIMcvDysTN/r3jGDjuIsD/7mHsr5N7pnonD4
 p38K3AOTAZK7zTPRwC0tyXZXn4T/+oK3nPmCMWXKXLM/KB01eOvb79RRwJEjYxF+TQa0
 Nz6BARNA25ZszBVZw+N4rtJ4zAFCSeyzgKoHPkUqpYXOR73DgYwWpbziqNGsxEwzwWnQ
 dZgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpUUhJyC5X51GZ8gMexaEJjuPqDWezFUxVeXS+QAQQjAmNXhN/tCgOhMpdVQtCzot4spp2br25r57t7gd0lp9dzY0b8fM=
X-Gm-Message-State: AOJu0YwKqsE3M40nuCrlYCb+gL7ZmZ+hMF+jYb+slxeRJXuC0b7d/Lmp
 Q8T811ai7yky12xpzz6sHpAjcFwjMcVfQsbMEwRKhck7yhCsJy+P2chGAddq0vj5lkBbiLlB5PD
 QPnn154RQAyYLTK6gsBeQqvssKxeHumh0uVSb2cg1hTyPQ6YMPKoS8ycZ7DXaTVrknvDH2zipDN
 Cqpwla4dYZKPKuWh6k3i5oU5Hi7GQ=
X-Received: by 2002:a17:90b:34f:b0:2a5:3f30:f5f9 with SMTP id
 fh15-20020a17090b034f00b002a53f30f5f9mr326173pjb.25.1712557782639; 
 Sun, 07 Apr 2024 23:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj5thfx/tmj9nLM3oTUtXJmt6nq256GlQz8bXyR9BdrTcmZjszN8/e9ekWEQnCNuC/Qk02Eq44L5D+fFfAFmw=
X-Received: by 2002:a17:90b:34f:b0:2a5:3f30:f5f9 with SMTP id
 fh15-20020a17090b034f00b002a53f30f5f9mr326163pjb.25.1712557782324; Sun, 07
 Apr 2024 23:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-2-philmd@linaro.org>
In-Reply-To: <20240404194757.9343-2-philmd@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 14:29:31 +0800
Message-ID: <CACGkMEssFik8vwXkj+Y7DsD=24-b3B8Q5AjxVynKYVKtucDvVw@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 1/7] ebpf: Restrict to system emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 5, 2024 at 3:48=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> eBPF is not used in user emulation.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued for 9.1.

Thanks

> ---
>  ebpf/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ebpf/meson.build b/ebpf/meson.build
> index c5bf9295a2..bff6156f51 100644
> --- a/ebpf/meson.build
> +++ b/ebpf/meson.build
> @@ -1 +1 @@
> -common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_f=
alse: files('ebpf_rss-stub.c'))
> +system_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_f=
alse: files('ebpf_rss-stub.c'))
> --
> 2.41.0
>


