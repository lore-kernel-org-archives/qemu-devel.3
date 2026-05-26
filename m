Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D2CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRszq-00058A-20; Tue, 26 May 2026 10:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRszo-00057g-PT
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRszn-0007iS-E5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779806582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSDrgHAd9XRZv4DMp95sqpRqu+ak63fCmIaaG1KmWS8=;
 b=inEc4BUAce5Ss29+TrXtoBI4cVflvT1Du9W8R6VewzrGVFVT2H4b8QSn1HT35MdDOGcTv4
 rk047PeEyfaEan/OE48FIwUKN5R5xOkdyrtftMtg6mbGcnwIsFmZIiQWNEhFMEoGaUYa9w
 pv+xnKBcxbBoC6a17beQ+v7jfWotEpc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-gRfMl5eaPNufGWoreswXEQ-1; Tue, 26 May 2026 10:43:00 -0400
X-MC-Unique: gRfMl5eaPNufGWoreswXEQ-1
X-Mimecast-MFC-AGG-ID: gRfMl5eaPNufGWoreswXEQ_1779806579
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e2f74da10so10346311f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779806578; x=1780411378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cSDrgHAd9XRZv4DMp95sqpRqu+ak63fCmIaaG1KmWS8=;
 b=kK4wthY4UrWQNh6DpP/Mluo5PbGG3qoHkbo8RRwkZMnSkzNg2Wm2dXFtbCSTG5eVzq
 jUd7rbtJ0p+UDgNpck+qBjKB9g+Ay2mN6hiknwXF4QYSqzEn9dl7BQyfsl+HGPQLXABF
 hvvya0es2HwXT9f6KKbK0oexhydLWloEk0udoVzM5GWgDrWq1PNxTtXn04DRkJiro5H6
 RbqBATUVH79viYvirZdbHaZ1Iv5aWyJUNjuEXB4cARAsb4Td2KdCLBrQxuEACNIqBjZG
 9WSzebosBjyrRje1EDVhMgs3z7hcA/hGLd/rn0KnX+rWvqBhcQ2VnsQhqUI2NvD4v+eS
 t/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806578; x=1780411378;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cSDrgHAd9XRZv4DMp95sqpRqu+ak63fCmIaaG1KmWS8=;
 b=kzdBvWle+eKdtD0yWWsKot2aFVC/j6ap22c58liMUuxYI/ilZYr4qrMFhpmghU+8f+
 IWhhsW0CLOU0wX512dY8O23CkHg/bXlKPittUgJqJUXUTO85FhdMdlDLu0r159tUd8AJ
 rBKT14EXmT0oguBHFJVS4nrS1lOY8vKjIGdpMcjLESD7GEGulOyvcs7Byp8q72Qxsou4
 a+nFXprxSYD1lfPRDuc1npaLV0fMNkbFCpsVvTFAodRjXBWU5o13xfRQIs8L9Bt6yVQR
 Xj7dS7MAZ8HNIwFGO1JdBijDDqgi16RhcAaZDL2lcYMePEUZMl1zclTZGl9K7R8AHEcU
 ZP5A==
X-Gm-Message-State: AOJu0YxOw4stM1sC9q2Z130w7s1yA2qYTq114Xh2CXkXMzcbA5Z9pQUx
 5TzqZJgTSXMmzJJRfYxsNE7rAhGHhBRz70/RQo6pZD0i+4iUBa1/RrEbeMcSjoXAhaYaN20OouA
 9wobxhh3p6yxra+LXa6/0/tVkiLKEfNYLHuUPskXUhojoO1DguEq1hdGomWjZd4M7F5LnIGhv4x
 7vZS8hKHuOGLDCTDgL3vfWjtysg8BerI4k2f0ehg==
X-Gm-Gg: Acq92OFSRvqy3jTX4o0FIsvnDPGhDElXNeEcpPQ6ToF6n1BEFWqPycy/olx1VR5gjl7
 zc9ChjBy8tVablx0+ZI97ZTWHj6VTMalb5H9caifHWpXnsndQ8E7oDRT77YP5zEdd85zSRmVKi1
 A9ixJymO1GUFiORA21wtbpexNSjN/r+Z8UcuIDUXbdSZ/4w3AJXoEoFOP4NmxUEaiGn/mvvzF9p
 5GRpzCyDjCCcVakyhdm2o5rEnKKvwBP2516UxxjED851UWrmb3LtE6iTf4zwlsa0GyeSNJmtxQL
 g2kkEAgMRNki5Zqg2hd3eIf3SrpFsvNelI86Dpe0YyKdDlWq8SEubTRcHZA4drbk6g202sAgIDV
 OhEzxh9Dc6UuSQCdf6JEzQpEZBScfCPlIXVwU2dlZe0HPzW//gJpZUMJSuiF9UlFHj8HSQl5a+i
 I=
X-Received: by 2002:a05:6000:4310:b0:45e:a19f:22e0 with SMTP id
 ffacd0b85a97d-45eb367ebf9mr32594525f8f.10.1779806578640; 
 Tue, 26 May 2026 07:42:58 -0700 (PDT)
X-Received: by 2002:a05:6000:4310:b0:45e:a19f:22e0 with SMTP id
 ffacd0b85a97d-45eb367ebf9mr32594447f8f.10.1779806578044; 
 Tue, 26 May 2026 07:42:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6ccd211sm45575931f8f.10.2026.05.26.07.42.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:42:57 -0700 (PDT)
Message-ID: <edf8995c-3f14-4a18-acdd-d4662c2590e2@redhat.com>
Date: Tue, 26 May 2026 16:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/21] tests: acpi: arm/virt: whitelist GTDT table
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-16-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-16-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
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



On 3/3/26 10:25 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..3e9be28cc4 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/GTDT",


