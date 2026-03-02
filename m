Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5923CD58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwiq-0001kv-GM; Mon, 02 Mar 2026 01:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwil-0001h7-MM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vwwij-0006TS-QK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772432732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0GywuLA6ScD5FZeZAfaHmfzg8JBIP7Ca9VVH6YZ/WU=;
 b=alviAoS6RqiVaxiZJ6t5/eZtqesWN/NatNy9+m1XlVYCRBXKhBkNgcBSW2JXJuUex9+zn/
 oCr4t3ry8P0KkOmbhPuMh2LAlc1I4nMoOrkUg9VuZZ9Ocdu7w3T78UYSUL21lHrK91uE3A
 o4pv81uwW1VqiYSWHa3nSbV5uzFz2xg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-Bp5MIGhqO26D3Fe8qoIyUw-1; Mon, 02 Mar 2026 01:25:31 -0500
X-MC-Unique: Bp5MIGhqO26D3Fe8qoIyUw-1
X-Mimecast-MFC-AGG-ID: Bp5MIGhqO26D3Fe8qoIyUw_1772432730
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4398eac51b3so3420856f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 22:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772432730; x=1773037530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0GywuLA6ScD5FZeZAfaHmfzg8JBIP7Ca9VVH6YZ/WU=;
 b=mtdh2j0cuiB1NuNDO4OezbT7H1X0052G7rWtQ2S+4FjxWQZmU2dre8sRuupf1IMUtb
 Gtl9F5PszZfxRk2+zO1Zw5AUJO76NNdLYOc4CZcEz731Ecnb3Fh1mu1py8XmhxT4zA5l
 1Zk1258BHqeGF71eTpuf6Fji/X3MXbMwZ156El8Xebl+bzpnPtlKzgntzfRe+StUqU96
 JVI/CRRxCN99ewXW/6QyKw4cfJhC+FUW2VMbKIn3oe4agCFViH82pxgkymsI2TjQKqGs
 2H2nlZN0QFrSUEOXEqHHf6X9ixL5CEptUfwKF+ehZFd39XvTkwP90Ett+X3aFt5+cZRR
 svSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772432730; x=1773037530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0GywuLA6ScD5FZeZAfaHmfzg8JBIP7Ca9VVH6YZ/WU=;
 b=u/KQ0SwrsxwDoss7a89fG8gNPKHI+WUT8Pmfpqcwt6te4mx23mDrxWiAXBhxfxN4GI
 9DZP1DTnq+jCbgQ5TD4UaW4J8ExQ0y+FPWuoRMJ2wyAiv6MedUc2W8z2p2Kf3QhSpQSr
 P5XSsAraL335TV07uz26Sd85bCLoewqvAdv/of3JiAVFcpdxp4UQKGo3OlCfdxv45TJP
 cyYmHpMIvXvZRm473FmQeyfA3hwzYo7ywcacdfqaetflKJwMKq6BldkWniAgKPS7rJ0r
 ryLvBkasTfOSc4pIq1ZhDTUv8TMCSgoQYRs2NhJqqpJw9QcLaFb3vnCzyh5erujNRSHB
 PWXQ==
X-Gm-Message-State: AOJu0YzZmhiXJ2/jgEiS0l9PcTzsdZNsQRNTKNyGm9cVhMC5BlvyGjEg
 0b20lHFgd0wk4jkLTTBZx11/z0M9zTM+Mg2dUSw/SfndJitjpU/2b+5o+BXylTOs5f5u0GRVa/t
 ohteZn7jsl746RusDpnJhQO9e3T5DTzOGXv6McTXiC9fHrUGmXNQ6SJ6H
X-Gm-Gg: ATEYQzyab1a3oojlBgak++jmDqaGI6AZ/YcsHd0BSF4KZKwXWAIRJqnb1vkzcrhS6up
 wURPpyAMQ6qYt1U8YizDDnZlSoDfzts672iYo0o3O/7jVUwqYiKuM8rUWSPnCpug2h8Auf+/ahJ
 eWs0DzIlohFJOWzs3DDZ3Uxeda8H22Im/dQ6JJPWdmaco6ec0kqZCj2NmmGxYQszCbutjHHnHxK
 kxfgTrp+Z7I61DGkvMVfptxKpb4IkFM5cDALGtrCkEJS4PsKzdbI19nrbQj6gVp5iloOlNjGkAJ
 aPwVi9uoxOuepKQtze/idRwxAvjVcGWcV86/dQFirZokjKOxTiN3jeJyhrDu2rfDFYi5K/aBWr4
 bNJR8jQ==
X-Received: by 2002:a5d:5f52:0:b0:439:5fe4:421a with SMTP id
 ffacd0b85a97d-439972048a4mr27446112f8f.30.1772432730167; 
 Sun, 01 Mar 2026 22:25:30 -0800 (PST)
X-Received: by 2002:a5d:5f52:0:b0:439:5fe4:421a with SMTP id
 ffacd0b85a97d-439972048a4mr27446087f8f.30.1772432729718; 
 Sun, 01 Mar 2026 22:25:29 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ba2a58dasm2526320f8f.27.2026.03.01.22.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 22:25:29 -0800 (PST)
Date: Mon, 2 Mar 2026 07:25:28 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2 05/11] hw/nvram: Build fw_cfg-acpi.c once
Message-ID: <20260302072528.0d30b5d8@imammedo>
In-Reply-To: <20260225035739.42848-6-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
 <20260225035739.42848-6-philmd@linaro.org>
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

On Wed, 25 Feb 2026 04:57:33 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/nvram/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
> index b66f23605b7..26343359875 100644
> --- a/hw/nvram/meson.build
> +++ b/hw/nvram/meson.build
> @@ -18,8 +18,8 @@ system_ss.add(when: 'CONFIG_XLNX_EFUSE_ZYNQMP', if_true=
: files(
>  system_ss.add(when: 'CONFIG_XLNX_BBRAM', if_true: files('xlnx-bbram.c'))
> =20
>  specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
> -specific_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
> +system_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
> =20
>  system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
>    'aspeed_otp.c',
> -  ))
> \ No newline at end of file
> +  ))


