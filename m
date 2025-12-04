Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A58DD1F9BC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 11:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR7Dm-0002H9-EY; Thu, 04 Dec 2025 06:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vR7Di-0002GS-Fm
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 06:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vR7Dg-0002nm-QP
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 06:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764846593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XyCCexfikUNWiqkNfYU1zCh5RHwj+ikUhsH7znFqHmY=;
 b=XzNl1P2b18RdyDCQ1W6vtY0gWF/ZfFP2JUEKQGnffzXRaVPQps2euMkhfc0UZ/tOrEzDtV
 hRSKEpTLMlX0k8kCAjgZhLf1xsELMtdPT75ZGxqGXl6fxPhTAomouY1M2DOE0DX8xj/XfE
 1ULpAExRCIOBWEZEq3anCmpP+Vz3WcM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-VtzmzUUrPmaZRV3CqwPefg-1; Thu, 04 Dec 2025 06:09:51 -0500
X-MC-Unique: VtzmzUUrPmaZRV3CqwPefg-1
X-Mimecast-MFC-AGG-ID: VtzmzUUrPmaZRV3CqwPefg_1764846591
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-be8c77ecc63so1126567a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 03:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764846591; x=1765451391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XyCCexfikUNWiqkNfYU1zCh5RHwj+ikUhsH7znFqHmY=;
 b=EYUHAPpmUww6Wu3aoHHH6vcrP1udXMz/QCyKGnLOhDKvZDloGAnHBHv3CjndfvDkf1
 ThmI6002TUyBs/TJmxwOhkqdU/gywk9s/POTAeQva3Jq9BcO1o2yhei5W6eYZcSRHzC6
 D1dsuLXVlldDnEXLVlUM5iA152AMb6Z9SMBAeYVUQI4TmgJ/B3O1iL2i6Gt/X6nwRTRH
 c2K6imhrbI6S8V+AKLIvxvzW6fDRMBUll+IZRDv4CJx/IaXUOkYqoYpTiCRj9a9tc3tb
 7nfeUd5gHHjtyECDeHCShONCGce8FhN8UZiqZVMuZ8v7TETCxMSmQE5/3fCZM6DteCKL
 2nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764846591; x=1765451391;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XyCCexfikUNWiqkNfYU1zCh5RHwj+ikUhsH7znFqHmY=;
 b=aaMT9YE1Zj9gDNuCMpSO5916mneqkBPlZuqqUt7voRIhnI89+Lx/BLmMzYP6lOQR3I
 SFfnNgHwp0eRBlLsKQYgXuI9hgpziIe2RiPPw5YYFbD+iiZqTG0miMahw96OYb1I5SU2
 6qqWH2g85/6QEutHxxS5pNxqhvohZFqPHTeN8yvMxns3eZ5SP5FoxBv84I5+jK8/65hA
 DGFdvI46W3LmVngIYpKatyEl48KuThPgLkN8P+S/s+URA0NEry8Czso19UCVZMIskPQZ
 oizOgeSVHvq9ntskNZlweO7NL19XnreRimbHetiC9l5HRyZTM9icooiqK1w+hiktPLlr
 sTRw==
X-Gm-Message-State: AOJu0Yzlvx8ojzm6cBEVy/n6A8njzsIttlnOPVYtyZ+ewze0EGULpCxh
 pbnImIBoVTQWRjeogjbNAb5D6Wf3tGiwZkxxZF5kJfce7RFiun4yJLcj/STRwnZQ0MVNbz9QbTx
 jqC/sIsjRwFOpPhxMJBRBWDvvJcXOVa8XrtZXoSUooluZtmHdrn0MyNlX
X-Gm-Gg: ASbGncsJ/8dY14zHWxqXi8B0t3me0dr9ZEh9YP5W+r8X04+nm0brXpYryK4tEBvN8Qu
 ukpW3wXd/w1kJcMffnP0nZlGhQDlB9vrBYwTDCY11Q2Dhj9FgkLLuXISfXFzy+uGMGghd1q7Jig
 xypYG/gZXeZAxZnprD5eOnMyZEyLJTN5ZSKa13QZPnQBX/qJ1IeW/0Jk485bga6N6TQJOxypaZA
 6FApTKx+h+fViouSJ4/SooXqHcp9+1QTiooDf2NHmQ+xwZj1gl8XVdhMC+IDhuQ7V9JEtjnEobu
 khegnS9MTbB4AK425yyh1vNlJdvINNQ1WMt5imPW3NRbwkLZm5FEMAK1jAkzEYnzXvVM9VqiTtL
 EaD7UVVGQS/6Nvf4SGjvJSnirrIzP67DsDAqP3KrCa4ylt/f/hA==
X-Received: by 2002:a05:6a21:3284:b0:35e:3c6c:1eed with SMTP id
 adf61e73a8af0-363f5d7336dmr7067428637.18.1764846590802; 
 Thu, 04 Dec 2025 03:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqniOWBR9ujUTYUCSa0noJOQ0Z/uKgnG+Wt491XrUqEYC6Y4H3O99netEyJr0G4i89B8NFYQ==
X-Received: by 2002:a05:6a21:3284:b0:35e:3c6c:1eed with SMTP id
 adf61e73a8af0-363f5d7336dmr7067401637.18.1764846590436; 
 Thu, 04 Dec 2025 03:09:50 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7e2adc5bf17sm1858152b3a.38.2025.12.04.03.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 03:09:49 -0800 (PST)
Message-ID: <f9cc047c-9ede-4956-b79c-0e3a05e41a43@redhat.com>
Date: Thu, 4 Dec 2025 21:09:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] acpi/ghes: Error object handling improvement
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, imammedo@redhat.com, armbru@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
References: <20251201141803.2386129-1-gshan@redhat.com>
Content-Language: en-US
In-Reply-To: <20251201141803.2386129-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Michael,

On 12/2/25 12:17 AM, Gavin Shan wrote:
> This series is pulled from the series for memory error hanlding
> improvement [1] to improve the error object handling in various
> aspects.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html
> 
> This series doesn't have any dependencies and can be merged by
> it own.
> 

Could you help to merge this series if it looks good to you? :)


Thanks,
Gavin

> Changelog
> =========
> v2:
>    * v1: https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00969.html
>    * Commit log improvement on PATCH[v1 4/5]            (Igor)
>    * Collected RBs                                      (Gavin)
> 
> Gavin Shan (5):
>    acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
>    acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
>    target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
>    acpi/ghes: Bail early on error from get_ghes_source_offsets()
>    acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
> 
>   hw/acpi/ghes-stub.c    |  6 +++---
>   hw/acpi/ghes.c         | 45 ++++++++++++++++++------------------------
>   include/hw/acpi/ghes.h |  6 +++---
>   target/arm/kvm.c       | 10 +++-------
>   4 files changed, 28 insertions(+), 39 deletions(-)
> 


