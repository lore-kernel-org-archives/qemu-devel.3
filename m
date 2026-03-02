Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA43D58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwhl-00016D-Kn; Mon, 02 Mar 2026 01:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwhg-0000wq-OP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwhf-0005zl-9k
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772432666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTNYv1zmHmAZevCUXf+SqfteTVZEB4glXbr8EXI4rQs=;
 b=AmakcdlaK6FfDYUiJ2z0zf9OuFCXk3iIaFK7T0n6REwrkPKRvM663ovvdGLzthdk7F7YBM
 uqmWs7g1D6Y+06MhFhNggW+iV7FBu23I97BNRWZ2G6yCuduUv7OvQdrHr6U75pfYYpJOrP
 LAo9SGslJMffrchI3IDz6NWRfqjGFho=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-Tw1tiwP9OmaN1PK96jqhEw-1; Mon, 02 Mar 2026 01:24:24 -0500
X-MC-Unique: Tw1tiwP9OmaN1PK96jqhEw-1
X-Mimecast-MFC-AGG-ID: Tw1tiwP9OmaN1PK96jqhEw_1772432663
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso52295895e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 22:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772432663; x=1773037463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTNYv1zmHmAZevCUXf+SqfteTVZEB4glXbr8EXI4rQs=;
 b=cAhv+ehtDmsc4AKP/tt3A18MIPbDoz8040qOIG75Av27lSBsuCLp7+vE4WdoKgaruU
 aowSmpb84Y9jxWWCn9ZvZMrvbtf+/zGYkFe0GdMZ4FHchpLBtLw/+6dw9jOZkwCvvuzt
 NFUz2rPHKZHsrLi0cdevY1BhbhaCF8nP2Dal4zkqcWCqKAm7+crVIJ7h6MOlfybbnzbi
 pxPj8zwL/5ufQGZQhbgX8QMwviJwRDClLrLoiziTJEXleKL4Xu5EzSL5YW3aFUgPzsTl
 G0j7TcHhdTpmel10ZSwTGubOGMozlhqaRvzYWPxuuuIbJiCN/lIjbLAaWOekm51oYeX+
 fbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772432663; x=1773037463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iTNYv1zmHmAZevCUXf+SqfteTVZEB4glXbr8EXI4rQs=;
 b=kWXAdtXxsLeS+GEnuFkpNWpMpgl9TNXX7YbbXuketUGoNPOGKUy7ZQjnIFz1bnpgjS
 1vKo0buyfcdgzfn2ThaeLsiptXe7KLXSHrdI+cCKrDBpet7GnGbl9CIHWeScklkkLiGX
 Y3MO8HklM8kNvrW7puzFFU6bkrht3ShmRV9MUApdB/jnl7W1F+8dWoCkFVZ/hrtUPp8s
 WMG6oDvo0AsGAa6wC2ZMg/dQBH5zmpJqbNCwJFXpEUHAT2XEUD0YYZNKx3sXsp1aCIQA
 TL6aqQ/vZT0Y7RGmPGQSgGkXx3uxphvvo6nYmcqF5/HQig5GVlFvU3W8SDmMCyf4P+VU
 jfrA==
X-Gm-Message-State: AOJu0YyvgEp0nxIoR2ueqPl/jLdsPpa/CfF00aFxfkDZ2YqGS9ww9X4M
 SYhlrZ73TFs5QDqpD19aD5m7Yz5UWykIpcNXx5FSZ0uKT3fmMTv9SCveeIVr3EUsI9bfMFvtMbB
 B7TcnKPbhO9sjfzcLSaiQzrJVFP3UO3vxDia+7LRtN/yz9FyPo8m3344f
X-Gm-Gg: ATEYQzyro5Uw3wHK+n0wlpefk7ArLRznDZDXiOkiPL52hDwLugKNE2cWel6VRT7z3Wy
 JWcHVIw/4yfvQ5Qa/ZPlNjppy2RjPMF3gIKliEisTpk+fE30rbI8cUwz0hZSKUvUkt1Pr5tlDne
 iqqWIurLlM/opwaBwZlbduUkjvIS8dT6SBa3gzc5ikb+lpFzNmmOafDywRE7EV0+moj/K+GL7CR
 DsngLiAWH+s4HIRfNF4V+gomyc/UqCwNTg5BPI5IR1wV3oOu9gnrQalvVTl128AZXiqBT9hCRoj
 6+ocDup1eBS2h9v+g/LsaiF6Am77M6DvrJhHXMv5dg8b/24J9Gtab8IFbC5wx6Db4xC023W8zE9
 zc5ea7Q==
X-Received: by 2002:a05:600c:8b01:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-483c9beb38emr210074705e9.35.1772432663220; 
 Sun, 01 Mar 2026 22:24:23 -0800 (PST)
X-Received: by 2002:a05:600c:8b01:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-483c9beb38emr210074355e9.35.1772432662809; 
 Sun, 01 Mar 2026 22:24:22 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcb4f8bsm298805155e9.4.2026.03.01.22.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 22:24:22 -0800 (PST)
Date: Mon, 2 Mar 2026 07:24:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 04/11] hw/acpi: Always link QOM interfaces with
 system binaries
Message-ID: <20260302072421.7bb71507@imammedo>
In-Reply-To: <20260225035739.42848-5-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
 <20260225035739.42848-5-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

On Wed, 25 Feb 2026 04:57:32 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Now that acpi_interface.c only contains QOM interfaces,
> unconditionally link it with system binaries, regardless
> of whether CONFIG_ACPI is set or not. It is now easier to
> deselect hardware models depending on ACPI.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/meson.build | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 66c978aae83..e1e848327b9 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -1,6 +1,5 @@
>  acpi_ss =3D ss.source_set()
>  acpi_ss.add(files(
> -  'acpi_interface.c',
>    'aml-build.c',
>    'bios-linker-loader.c',
>    'core.c',
> @@ -36,4 +35,4 @@ system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false:=
 files('pci-bridge-stub.c
>  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
>  system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.=
c'))
> -system_ss.add(files('acpi-qmp-cmds.c'))
> +system_ss.add(files('acpi-qmp-cmds.c', 'acpi_interface.c'))


