Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1082D132CF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xzf-0003NG-Cq; Mon, 04 Nov 2024 09:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t7xza-0003Mq-Oh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:23:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t7xzY-00012n-Rd
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730730219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2D9pXrURl9yEMfqJUnixHLlEbDT7tAItm7yIwWntHkU=;
 b=SEc4VxTRHEb3CvEFrQIAPnFSQxq+DcJOWQ2yTZkhyGI0ljnZze0z4va8SdX7w1Ko1GYdiV
 apZfE7VV1Vw8g0+bxQDwL/YEbGwWMj6aeyYZLa/ypMA+TFcDf7H9pEhHKTVhmufxjO6nce
 zeCiSw0FvAZHsxqcWPzOTOaov+QIphY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-0w-ggGVINgyw39_pGwP63g-1; Mon, 04 Nov 2024 09:23:38 -0500
X-MC-Unique: 0w-ggGVINgyw39_pGwP63g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d462b64e3so2092239f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730730217; x=1731335017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2D9pXrURl9yEMfqJUnixHLlEbDT7tAItm7yIwWntHkU=;
 b=PFon2bZaaZyAutiJL5Dm5R0Gxfuu9Dhj+vB/wy36GvkRJW80GuXzuP+mexIOZ4wyCC
 9XS5HQQon7ha9SUGy6BahIl9dCxLpoOELFQxhvI4ipU/piatUdEeEuVUedtbY9Rt4RzH
 4C2fSS/RoYkpAg6UqSpPqD5z+0yQagfjUuxQw02tk+MNYSP8RS1RTE4rNhjSmCrzTxLT
 ogaZ19Y5Hv6LBici4kOoh6JFhBts+539GnaSFjnaoYuwwvxJkJUqFKOX0Sb0W9JizY5V
 P1By0pji+GxlkvsY9quO1dl7CawN6r4/Qu41RSeYGX1KNNizbvZHTMh2i5+tMaNxSZF+
 QrPw==
X-Gm-Message-State: AOJu0Yw47xiA/sRozkNp25t8XfF2F8Vms+JeKRP3/XKgt/QHtujpA7IQ
 EOgyety5erZ0dt9h+Vk+0l6JA9uaE7ZNr7/L7AMZ1FvoN91mdK6Eh3WNa+f1rLvk6VLE4/Ndz8s
 +pbIPCvV0xTPvE5VujuvYQt165Vj8TEvbNwvMdTUq0ldzWt+t9djd
X-Received: by 2002:a5d:6c63:0:b0:37d:3973:cb8d with SMTP id
 ffacd0b85a97d-381c7a5e9d5mr9630206f8f.24.1730730217518; 
 Mon, 04 Nov 2024 06:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz5il9xRb0ELaEziJwcwmF9e7ug3cAmze1DFpFct86gdvBP0UO8cOErSCR1PAiHweGJZWysQ==
X-Received: by 2002:a5d:6c63:0:b0:37d:3973:cb8d with SMTP id
 ffacd0b85a97d-381c7a5e9d5mr9630191f8f.24.1730730217141; 
 Mon, 04 Nov 2024 06:23:37 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf4b0sm154480245e9.14.2024.11.04.06.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 06:23:36 -0800 (PST)
Date: Mon, 4 Nov 2024 15:23:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Sunil V L <sunilvl@ventanamicro.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH] acpi/disassemle-aml.sh: fix up after dir reorg
Message-ID: <20241104152335.7dff1569@imammedo.users.ipa.redhat.com>
In-Reply-To: <ce456091058734b7f765617ac5dfeebcb366d4a9.1730729695.git.mst@redhat.com>
References: <ce456091058734b7f765617ac5dfeebcb366d4a9.1730729695.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Mon, 4 Nov 2024 09:14:57 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Fixes: 7c08eefcaf ("tests/data/acpi: Move x86 ACPI tables under x86/${machine} path")
> Fixes: 7434f90467 ("tests/data/acpi/virt: Move ARM64 ACPI tables under aarch64/${machine} path")
> Cc: "Sunil V L" <sunilvl@ventanamicro.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/disassemle-aml.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
> index 253b7620a0..89561d233d 100755
> --- a/tests/data/acpi/disassemle-aml.sh
> +++ b/tests/data/acpi/disassemle-aml.sh
> @@ -14,7 +14,7 @@ while getopts "o:" arg; do
>    esac
>  done
>  
> -for machine in tests/data/acpi/*
> +for machine in tests/data/acpi/*/*
>  do
>      if [[ ! -d "$machine" ]];
>      then


