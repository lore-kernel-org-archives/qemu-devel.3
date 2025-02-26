Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7452DC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJlQ-0003kK-4H; Wed, 26 Feb 2025 10:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJlK-0003ju-5c
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJlI-0004j8-9H
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740585350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8CqY4o0DPQo+Y928L9zA4t9/2HrPF7Rgytn7kgXlYc=;
 b=Bj7UdVGIgY18SvqR/Il12ecs9gqQwrDoWzwyB0QZHcCb2DT0prD+gbCvfZd2zw+egp823J
 JxrOvNrXuoNIQggsyV7QJTBbwITO5A3zkSmDKtKAVgYJCBjNCfEG6tOA/PiC2Cv1bKJkf6
 +bEE6qKpDbv0eSsvCFRGE5MAwlIUT5o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-kaIOtGkgNLKXh0WFXo37iQ-1; Wed, 26 Feb 2025 10:55:49 -0500
X-MC-Unique: kaIOtGkgNLKXh0WFXo37iQ-1
X-Mimecast-MFC-AGG-ID: kaIOtGkgNLKXh0WFXo37iQ_1740585348
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f4e3e9c5bso2853561f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585348; x=1741190148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8CqY4o0DPQo+Y928L9zA4t9/2HrPF7Rgytn7kgXlYc=;
 b=ZdZBCj8j+BQZ+iILbwJmnpkRQ9r3nDyyzFRNu6juSMrnXghIebnhe4QzULN2cGa/7S
 Wl5Mkhz/EwkN7DsMr9mp5uyPmGMFmVNmMMhxv9sOQbh8QqIq2M4i0gaPZFB7GXP1L/G5
 99DZcLqEB1rBCpPTirP7SeoMchXNWRN/lcj6pfCw1+LJgY5X/MXyHZgGwU96rty3Pojw
 HeAWWUar4g0WuSFiwc9qHM0M544cS85xc2FdmVdhGDILniruankRQgF4tYUj9lQnvsT6
 FLXDK9s4D0x6wMwypjQ2lvr8MwY02U0eA2kjMbWxkDJeQcILF/9rqtw3fqZALsPpQZmP
 iTuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8tZrBys/JfIAWstwfuD9VFRMLDx8m4fA1ijXLXjW0lAKl57XIHHGna8PYsebvFgfC03vePDfHCBO9@nongnu.org
X-Gm-Message-State: AOJu0YyEYU+WAsH9pvq2edQXhH7+3RMsBVa74nlw55eb/dQNM/TqLqJF
 ywIrfqtInNydWIe6TsF5M+/MSCMMwFVLSCtUw49XNuwU6t1MKmgV++cEOp3xGRDTcPUoNqV5jk7
 0fIUCQPbiaJpjr15mZdlqWYPcOoynYyQhWFIJKPrEJD3OSgwjytOK
X-Gm-Gg: ASbGncv7F5Xb8oZuQdkswzkYgA6wZY8IgudnEbGSj+Q0YOZbjS7LfoKztVafs8umIqV
 HtiW3auk9CSoizhXf1ahjMS5nUgQOqIFCloP7Y16bG5OBQ7/JN2OfRz4RTcZsFUt0Rof5DZ0OSG
 zxCFyosNEsZss8v6bMeyqo6fxdoJIgydCJ+19o9vQlhDfTNgPb1veDLLetMQHEBH9Ipogk0YvkB
 +ZDXGssKMEs6B0A40TA2HpG1Ox4NduFUaZz56NWtMsGRuycA/HHooNP1v1Y2ajoHuuiAyy+AEvs
 6cTBoHTAmfHbABoxY0yP9Yg+s5jZWoyil7mqCDKmehffxEihIyJP5xE6VtEtQps=
X-Received: by 2002:a05:6000:18ad:b0:38a:615b:9ec0 with SMTP id
 ffacd0b85a97d-390cc6475ddmr6949960f8f.54.1740585348083; 
 Wed, 26 Feb 2025 07:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyuJQRaFb4583I4taVqxsuF1Qw2F0ZkJcIPI2a6MwWctYzyb+OQVaF4zA3fJ8tVybL/MtDRQ==
X-Received: by 2002:a05:6000:18ad:b0:38a:615b:9ec0 with SMTP id
 ffacd0b85a97d-390cc6475ddmr6949942f8f.54.1740585347741; 
 Wed, 26 Feb 2025 07:55:47 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e1040844sm110155f8f.85.2025.02.26.07.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:55:47 -0800 (PST)
Date: Wed, 26 Feb 2025 16:55:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/14] tests/acpi: virt: allow acpi table changes for
 a new table: HEST
Message-ID: <20250226165546.3b1ded0b@imammedo.users.ipa.redhat.com>
In-Reply-To: <94ff7f7ccde4c8d74c7838c0021cbb453e91f12a.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <94ff7f7ccde4c8d74c7838c0021cbb453e91f12a.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 21 Feb 2025 15:35:19 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The DSDT table will also be affected by such change.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf4..1a4c2277bd5a 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT",
this and flowing update would also include HEST table, once you enable 'ras' in tests



