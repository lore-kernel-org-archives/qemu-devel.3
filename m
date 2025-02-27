Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1EBC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tncbd-00086Y-B5; Thu, 27 Feb 2025 07:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tncbc-00085h-1x
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:03:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tncba-0002M4-H5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740657786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5xj3BC1T+wGPDd2kj9+gKjm5LAXNQxtfhll0pXUlUM=;
 b=Lf6gvDgxTdrfiVZr+oCevCL3BBzR4AHxPsAhJPy7tlq5BJcg98TPBE1bRvX4aUmvm5Nntp
 AKv8+jmNrQuaMDPW1JBjyt6p1NP/8G1M4KadraryCjdDTxj5Ve4cziNFNPZ5+lkpClwgsK
 1OIiJhOXWL91mvdl8dyhCCRVZToVBvY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-mAHcNnxaORGxrJHFumJAJg-1; Thu, 27 Feb 2025 07:03:03 -0500
X-MC-Unique: mAHcNnxaORGxrJHFumJAJg-1
X-Mimecast-MFC-AGG-ID: mAHcNnxaORGxrJHFumJAJg_1740657783
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f34b3f9f1so548777f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 04:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740657782; x=1741262582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5xj3BC1T+wGPDd2kj9+gKjm5LAXNQxtfhll0pXUlUM=;
 b=Br1n+lmpAvg4QkcsCMEGVwYfieXt1aT4J8iWS2pOPJBCg8OLOgjSQiFPRP/5of4M9a
 hrpipLHxWGdfOUvfemItMPvUy5jYkbB9Y+VH0FEgiUCcTKB4waww7JtDGvoznVORYcKq
 MgcTIZwY2nvPYm2AikLTy8DRcnP2Nsn7HgcuY0Lj0/9j41lH9/Y2oM9CQgYqHmfmYNKo
 JnWxZi+3tgqOHqz2UsHY7GUGsKdPToR2UQ72XJXeWOPVXV+vR8Fhcl1hDwP/Oq16IIHi
 c8QfNaIO5FUuByTZTBkpl+HXKeeGzrPGpSSDdjHaK8VB0mZONFrgMczNqalqV8P1fPEo
 OcDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWloQc22wRvdZm2r5z6WZ5Ln45YuQlK/IuzVXyivEptysFUDjLxaariC6m5eRwI9Wxbra9WM+/KoIpF@nongnu.org
X-Gm-Message-State: AOJu0Yzp2fdt1Faz5TsNNnbJ1vMVK6SXQ+DBXiB4wMOSVWe7PN7Pj0/L
 56zikv0OeyGDt7yETRIZ+nLXDGiqbIjLXrnSTW6ImNm6sbD+2L+WuTS+iUe/0fwBlgTQ53TS1Ac
 rI/sKr5uI0vkHKIqH6axcmLVoJCKu8JYz1ZWjFtcTU1AlQQ+9o869
X-Gm-Gg: ASbGnctz4xeFGjjzMFvmD4R1muWt4P6vW9N/OAjZ60xOXXKm7KMp3c10cLoMqWFyY0D
 w0uDmV6Hm2hSZfVTt+5MzfRvngFwmUDKULu+DngOrXHylGLq47EwCXHZFDBtKl6eW1q5wtpJSDZ
 JhxoDZoZYfeUQQWuwS4rkabeOy1XlLjCmXQCsnXPcz19UQhN1s49mh4SIDtjvg8VHqMeSmVmYXV
 OdIgoGx90fqMr7UG+SphD2QFxQVgQRH+RmHzV5djla+ZZZrRbCc+rPmlbJY5VBvfN/f/smNGgfR
 GxopPlOwF/uiyPQUGHaz99tmklwI6Dy5UdsCqehZ6evf1aBug/gsPtOCXZ9wA7s=
X-Received: by 2002:a05:600c:5123:b0:439:8ef6:5782 with SMTP id
 5b1f17b1804b1-43ab8fd7acemr66726325e9.10.1740657782484; 
 Thu, 27 Feb 2025 04:03:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGsmcVRgCFbjb9R4XUkv4ggUO+/xJlQmWBPEfi9kCw3Hg6pcObspvfzXkTMsw8PrznpqnjCQ==
X-Received: by 2002:a05:600c:5123:b0:439:8ef6:5782 with SMTP id
 5b1f17b1804b1-43ab8fd7acemr66725875e9.10.1740657782065; 
 Thu, 27 Feb 2025 04:03:02 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485ddd1sm1827170f8f.94.2025.02.27.04.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:03:01 -0800 (PST)
Date: Thu, 27 Feb 2025 13:03:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/21] tests/qtest/bios-tables-test: extend to also
 check HEST table
Message-ID: <20250227130300.607bbc27@imammedo.users.ipa.redhat.com>
In-Reply-To: <3ebde58416b8be1140c569538192399feeccf412.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <3ebde58416b8be1140c569538192399feeccf412.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Feb 2025 12:03:32 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Currently, aarch64 can generate a HEST table when loaded with
> -machine ras=on. Add support for it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec43536..8d41601cc9e9 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2122,7 +2122,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>  
>      data.smbios_cpu_max_speed = 2900;
>      data.smbios_cpu_curr_speed = 2700;
> -    test_acpi_one("-cpu cortex-a57 "
> +    test_acpi_one("-cpu cortex-a57 -machine ras=on "
>                    "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>      free_test_data(&data);
>  }


