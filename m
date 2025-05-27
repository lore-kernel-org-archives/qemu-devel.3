Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1785C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtZs-0002vG-Ip; Tue, 27 May 2025 08:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtZm-0002tB-EH
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtZa-0001dF-9o
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748349501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxoM0yT0VlCIDnWX2gHU09f9MEXNnWsHeLWqfkJVxZM=;
 b=gOQRPtmQtOkd0OdXF/fMBylVKUs26F5wdsjIdGqpJ7glUhM1i5cDa3yJUfQOQlIuSd+Asf
 cjyUB4a6PR0/zavqMOyUza+uuT2QWtWPffvTXFLJJuaoWD1/QvTzdTpkQV64esSgvaki9n
 GFsXg/4+bEwcojRHehiFp25GP34Nr6Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-W1ol5YIkPj6TWnDsAm2D_w-1; Tue, 27 May 2025 08:38:19 -0400
X-MC-Unique: W1ol5YIkPj6TWnDsAm2D_w-1
X-Mimecast-MFC-AGG-ID: W1ol5YIkPj6TWnDsAm2D_w_1748349499
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso19650935e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 05:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748349498; x=1748954298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PxoM0yT0VlCIDnWX2gHU09f9MEXNnWsHeLWqfkJVxZM=;
 b=sfJKEx/37Tdw3Y3TjHwEzawe2ec7t6xTNKGg2CNQTH7m9aVLIuYjEfDUvBdFp2hiQ4
 K44BjnlQV17O5T7RzaipuE4AMCLUCgshhiMUW9AxN9i96/w4Ig1prfVEBQ2AlxfgKHiR
 dCH21DJ5NDK6SBiLY3aVez1gr2EVgOaDRg4NWgUdFWrwaZ8jqRVVPoaK7llMH5z4I6zI
 I5qyp7IaYBKv09TWkq17DKYL6Ml0ianQAMjQnPGJ+OYVvt/+fCBqiIFwle/DMnJiGQPZ
 Tgsfpo2zlFUzTAGBbGIWkGx6oe11xMgVjpTSvfMBut1NIIu9W71co74lrNvj1M+H3Srs
 eTtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtIxCRPOY4+07areo6EDlRWdss+Pa2C1WP1MURy/aDybSObYDBS1mHQYYOejW2xS1JZuVDw893wTLn@nongnu.org
X-Gm-Message-State: AOJu0YxM1RhtQ0GPk+uLxrB0TmWTYc3HwTsju63LO2yc6T6+s4hWnCuO
 oRg/VdTsxopWNqut0lcIx6gfsUrKYslpax73OQCBiNuGrMQ4Ec0SbHeOIhao2JPGxi1KW/4IjxX
 lYKYoxGXI1Sn6IH+KTJ6BpWm20iDgd1SznBgPe+vDbMPLiURpp+p0Fdjo
X-Gm-Gg: ASbGnctD093j8IjGvW+Z+8XEW2Q2UQhds8NgdwU2B/A2tp9VrfNwgGDkWY5jxsFDMVf
 GQK/9cSqcS2/UF/Mx2Q7624OAJ7kermzAaPeQsHcP68Od/cF0UgqoZlXVW6fGRiZ1sF37wCe4C1
 Q+67yIaqWYekVV5msC7jog0wFtzMA3J8PKuQ3COTh1oUaXcQvbpE7xUg32Bp71MA/6qw5tYi67m
 OWHtdAhDOZqB5cCWoC4Jnf7vceAUeq9lAMCCFsKdCmYownIwj5d0ehy5euuZ1+Mo0h9sUKQekwM
 x0YyWE2H6WZxVXwyDoXLkDo0AXnPtL1G
X-Received: by 2002:a05:600c:828c:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-44c91dd1676mr137771085e9.16.1748349498668; 
 Tue, 27 May 2025 05:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8s9eDWvxbXoBihxQODTaIxLcFn78cp0gMrPQqqepcjYCAGNv/rTaHa/NEraZYYwBQWqarIw==
X-Received: by 2002:a05:600c:828c:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-44c91dd1676mr137770735e9.16.1748349498288; 
 Tue, 27 May 2025 05:38:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4e660f779sm63407f8f.41.2025.05.27.05.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:38:17 -0700 (PDT)
Date: Tue, 27 May 2025 14:38:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 08/25] tests/qtest/bios-tables-test: Prepare for
 changes in the DSDT table
Message-ID: <20250527143816.39c0dfab@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-9-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-9-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 27 May 2025 09:40:10 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> This commit adds DSDT blobs to the whilelist in the prospect to
> allow changes in the GPEX _OSC method.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..abe00ad4ee 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,6 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT",
> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> +"tests/data/acpi/aarch64/virt/DSDT.topology",


