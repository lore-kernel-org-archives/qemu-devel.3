Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87539CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 10:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUjCK-0004ze-4K; Wed, 03 Jun 2026 06:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUjCH-0004yZ-Tn
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wUjCG-0002u0-64
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780483898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFGVXWRL3LCNwY0EI/pgBixHZk5YpuLQiappyFDw0G0=;
 b=he4ZmbFG/1fyXRmbpjK4zz5pY6tNrVBZJvg8SD8E5PeZILRtxlFyv7zZ16KkdRpIb5zpb3
 kumJpIib9gDAwIgUje8z1UwEtjXfXplu1jDXQZrOUJyXLXfOoMAmukEimoGKpPQkGZ8E26
 ePEF5tyPsxSCyK2rdCnfuuXtwO2qpfc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-u-g8I4zNOtaw3tW_riAV1A-1; Wed, 03 Jun 2026 06:51:37 -0400
X-MC-Unique: u-g8I4zNOtaw3tW_riAV1A-1
X-Mimecast-MFC-AGG-ID: u-g8I4zNOtaw3tW_riAV1A_1780483896
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b5d2e394so5721445e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780483896; x=1781088696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFGVXWRL3LCNwY0EI/pgBixHZk5YpuLQiappyFDw0G0=;
 b=TbRYxUh21+W779o85eSqrTD7KvX5xxI/5Y7x0opJuYxP/zEf+8ynO3TNd2x/tsyR94
 JX4jqjQuxFYGH4rlUGNvBFIRumzsRYL1bkTF/a0lVUfaaRTG90VacRlFnWlrMSmfymWL
 lvIUIRVOelRBCr5+dgjfbySa++mhOa6CTAugNPujl8s257g2yOBaB+BNlXD+/W9TduvV
 P1dmDj1z3CZUSdACu1udHIsww9SWJ1IbaQkrCaF6UtXMTrb7weUjcQ5kaDS+QNTRCZ8K
 5bqckmnxQq7+CO3gXhk5uBwUbOvk9BBwcZW4XNoMf9DZKMIUfKjGrEM+IIW0xZTo+9hw
 7VIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780483896; x=1781088696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wFGVXWRL3LCNwY0EI/pgBixHZk5YpuLQiappyFDw0G0=;
 b=q9vY0vqPaCP6c1u9C42PzGaos4mORld2xAn2alZDVWWENiaHRkVir071vb/DzATrN/
 Gb2a0qhftF+l1LYnkGHLu0PTnp1yPViCVpcq8Y1y6VLHW0Gw5ams+sTwLbXBhgFPJFYm
 9h7bqWit/CznN+GHE62HO8R4SzVPuSFFHzCjBZR3QPL6W4m0OP/ZesmDdmObh/nQBOu1
 KArsoResiPt8Y9kpLmk72R8e8jJah3KTsYw2te9Jvyy9z/rqRgq3rOhr/ttyb1eNScip
 AsjlflE3g9XLVjP0IVn0hvWuUBFtu9qFfMlgs54/LMm66l2ihVApj82F9OuMMHBvcXt1
 3yfw==
X-Gm-Message-State: AOJu0YwpYqb38iuRfQQPlaflsSoDKjpjaTSaT5nyxjic4iLwk94SDqpL
 KVL3Ad8/7I3a+B8Ur/DLbvdZCrLXuvc+iHTE4z8ZZbMf8cDIRMpmE0jI4pcQLVerQbxmR+gw5r9
 DAsjUAXve5qRq4xHa8Ekunb96TWZZuP1tMJtCSgBU/I9NG2uXs2QpZTv5
X-Gm-Gg: Acq92OGPSe88AzolHWwFSMCKsIknMZEOr/uel4g81ffj3F7YPYz/jUNBpyEFyReE+m1
 3Frrt0Hz8E0HrB5Q0G7bV8w6SrHbX521b95tropmMgb/mrbj5mK46wmDaubyTmXQUUl1ZuD0hji
 NbkP2W/t0W8v6rqPRuFZ5Y/AJKrEhtlHcy1S7+XVSZoI/E8Nm3ZBs5tlTIRT7PbbmYrJ5cCHgjs
 AZseYIEY+pCJm2Q0oC8qqyj5dmv5/czlkuxGe9WCUdaZJXWQ4xOVFJnszpAFDxDps6TgGdEfkti
 4Eo41Y42HkZa6d3nr0NbXqNBaTUlkaLJSG6jsoNPngxhWPdVXoklYVsGPsc2EyduwuZqCGjY+L4
 MYCwBQWEciVjrkGM0
X-Received: by 2002:a05:600c:1f87:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-490b5e6463emr50778705e9.24.1780483896147; 
 Wed, 03 Jun 2026 03:51:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1f87:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-490b5e6463emr50778345e9.24.1780483895854; 
 Wed, 03 Jun 2026 03:51:35 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e76153sm138299805e9.11.2026.06.03.03.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 03:51:35 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:51:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 1/3] qtest: allow SPCR acpi table changes
Message-ID: <20260603125134.69b3a726@imammedo>
In-Reply-To: <20260529023100.42508-2-wangxiang@iscas.ac.cn>
References: <20260529023100.42508-1-wangxiang@iscas.ac.cn>
 <20260529023100.42508-2-wangxiang@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 29 May 2026 10:30:58 +0800
Xiang W <wangxiang@iscas.ac.cn> wrote:

> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20241028015744.624943-2-jeeheng.sia@starfivetech.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> (cherry picked from commit a205d0bcc89c887efcb636924b98e9f77d637369)
> Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..aae973048a 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/riscv64/virt/SPCR",


