Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9189EE7716E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 03:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJlef-000121-2l; Fri, 06 Dec 2024 22:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tJled-00011q-FQ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 22:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tJleb-0007bM-AD
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 22:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733542726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFp/fFnnxbfvLePj4dYZIgYWo9EKhOrPAamJCrcM1WQ=;
 b=SXE5Z/yRk5cXccWAD6p7zhp8oKpsH0uImJxSbXCU/023wgGAMQSCz4S+1oc1nfruAXwxEb
 Ixns04Y+QCkzCFEEiqhD92PBF8VArR6/QUvdn9xdQAbGro5+Z6NifKnT9cV6NnfaozU1ps
 kMtqHkHHHqoA3fk2LsbS45szLYQ8KVo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-TlgJjNdaPnyj2MmnE7RdIA-1; Fri, 06 Dec 2024 22:38:44 -0500
X-MC-Unique: TlgJjNdaPnyj2MmnE7RdIA-1
X-Mimecast-MFC-AGG-ID: TlgJjNdaPnyj2MmnE7RdIA
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3cb2e6c42so1238147a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 19:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733542723; x=1734147523;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFp/fFnnxbfvLePj4dYZIgYWo9EKhOrPAamJCrcM1WQ=;
 b=uZ2+vAHsr1IKQ+kL9nwrshUR5pQkwnZBoCcRPJpS70GkpWy+VvjryrNNhZJoSt0bx7
 9d21+sz50hnQ+WUv1CzfcCapLY9WxvNzETW5NiqWyL282hwWToTxNshg3Pq2tvOtoQWf
 IwiQTqyCh38BlL9kK4t0DeF5WIyYZnZZYI9JO1VIyeHyymCSRYE89hNvq+U+GbI0/nEm
 q524nXViZ+g77Uvvc4R34QBKG7Gly5pEp7Kdw0tAaaQPI3ehMHlHZj8UsVkgalSp2RzR
 Zan3pdLBbsIzj0M0iePQKNP1DFtFsYS3CHkPIlohoKct8SFZahSGCUbsB6glC4y4GIog
 2Uug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5b3DIip8vbgQAJEyQDZZNyxCVUrr+al+eImm6uqLCk8QFEIGd7g4Xo+zVZp/XV4quS6Q8mzj7KQgR@nongnu.org
X-Gm-Message-State: AOJu0Yws83C02Cpqvg8pMdYip+Erf5czVglJYi8z5qgNxc+gh49bEoq1
 YQt0WjHrrpsMQu4+kaeu7uqY+RJ9VSW0rNT+7DnQeYk5yhLcxk1XD1gI0nKmzFuI9USsHUmzGsK
 BqYM8vJ/eyzObQ0lUzf8KoPTceBya9y8cm1qFgu8vw11AAZGO64oZYmoGaRzOm48r7gjKyaOUdE
 L6pf02Ux4VVWNFAB4YnQX0BeMfJuA=
X-Gm-Gg: ASbGncuB2qAaiE8GBQFoY1rlvb5YIjFh4xmZ9f9gb55B9YXswZ30XTwA7H7oCdp6KE5
 Z3LlCx/vmNN8ZiXMFjOw0/4lH7y/PtiQ=
X-Received: by 2002:a05:6402:254b:b0:5d0:e73c:b7f6 with SMTP id
 4fb4d7f45d1cf-5d3be721b71mr5354693a12.31.1733542723373; 
 Fri, 06 Dec 2024 19:38:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtVbuEbxdGC7AbxegIn7KPLfh2Jki7IR9rZfsiL1LWLv415Cz4Y6lZHtQHRtVhxHQy8DAfeqJQUR1tmYKuJyk=
X-Received: by 2002:a05:6402:254b:b0:5d0:e73c:b7f6 with SMTP id
 4fb4d7f45d1cf-5d3be721b71mr5354684a12.31.1733542723058; Fri, 06 Dec 2024
 19:38:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
 <6f427a02c2c20512d5da178b47c64d553851a60e.1733504943.git.mchehab+huawei@kernel.org>
In-Reply-To: <6f427a02c2c20512d5da178b47c64d553851a60e.1733504943.git.mchehab+huawei@kernel.org>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 7 Dec 2024 09:08:31 +0530
Message-ID: <CAK3XEhNNZyRDgjm5Hjes-Xnj4CxtO2eQcs7AyTNOOFcKa3LusA@mail.gmail.com>
Subject: Re: [PATCH 27/31] DEBUG
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Shiju Jose <shiju.jose@huawei.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, 
 Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_ALL_CAPS=0.5 autolearn=ham autolearn_force=no
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

On Fri, Dec 6, 2024 at 10:51=E2=80=AFPM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index abca351b18de..1fe4c536611a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -534,9 +534,11 @@ void ghes_record_cper_errors(const void *cper, size_=
t len,
>      ags =3D &acpi_ged_state->ghes_state;
>
>      if (!ags->hest_lookup) {
> +        fprintf(stderr,"Using old GHES lookup\n");

I don't like this. If you must please have them under #ifdef DEBUG or
somesuch. See ich9.c

>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
>      } else {
> +        fprintf(stderr,"Using new HEST lookup\n");
>          get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le=
),
>                                  &cper_addr, &read_ack_register_addr, err=
p);
>      }
> --
> 2.47.1
>


