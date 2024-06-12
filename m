Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B804DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHP0I-0003P7-OL; Wed, 12 Jun 2024 10:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHP0G-0003Og-Tn
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHP0D-000109-O8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718202662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNOWsKOD3ZvVR7goK0xUuH5E9Qs0TocVfUGSb64pAmo=;
 b=L3YXczMvBDI39pZVten9kxEjVtaqYslnT5FT1UNnPW6X+Cb+q1UKWraxwCBik9sX6hhc2L
 3UcYuSeE4H8x7Iar9by2qD7CCtAgrapys1bIHKuV8TLw3XXn8ZI/2Md3OZUe57mZuS4wc+
 HzdmRnrzoZEZU+XZkHUvmCYwJ+Ni1OM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-2YV1NFyeO3WS1KlB-Xie-w-1; Wed, 12 Jun 2024 10:31:01 -0400
X-MC-Unique: 2YV1NFyeO3WS1KlB-Xie-w-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dfa478f473eso1359410276.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718202661; x=1718807461;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LNOWsKOD3ZvVR7goK0xUuH5E9Qs0TocVfUGSb64pAmo=;
 b=KKyxbw5QEQXkj0TLW6++LdUA7uQTWD6TJOqOlhCwj0RIXJdI8VtQkR/nY4WQtWbDHT
 hRu4WMBniZZtXt1l/EcdgXlpDabPk8VKMzZctJlkWhU9i5NQLIJsA8EtjHO1byIbhrpL
 lYnE3Zh2SfpSPDYKJso2+vDk/Dv6JDM1LET41wfXjpjOt29gf5xNJcG1B1FcIOAM93dn
 skG+7gpRj0Neob7iOPFLX+0//gkYQxwCNwYKuFYcp9u0iXQk5wbZiv+8O88MxHSZZzTG
 9iaZivM2TrL999FuJx9jpDa8RoDfUOzWlQpnZj1tAUSlJvKhP8qQyvMIIKihCm5QeHI+
 0/0w==
X-Gm-Message-State: AOJu0YwJMvWp2pUZPoKXHMIjbgKWH5zPRKfcW09wV7184gIBuUGDuGiM
 sJh1PH9QrktR6BZdcEFBAFG1FBSXOMmOnlL/+zqtNOB75sOiONCDQoda2uY5qaWE9uzSf8L+CC5
 SPKb8+lS5fsFW9ZxOcUrIhGdJ6Gi8UhUfdH0qiGJ4WSuewvXhaeig
X-Received: by 2002:a25:1c4:0:b0:dfd:b41d:4a98 with SMTP id
 3f1490d57ef6-dfe69fca31bmr1532303276.3.1718202660192; 
 Wed, 12 Jun 2024 07:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdOrmob11wocoArmN5lLdd9v5JObCeZBZcND6ORJBVTfAifYTp7b1cyjCwyZbudaqbLcObSg==
X-Received: by 2002:a25:1c4:0:b0:dfd:b41d:4a98 with SMTP id
 3f1490d57ef6-dfe69fca31bmr1532270276.3.1718202659607; 
 Wed, 12 Jun 2024 07:30:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44085391d1esm30299561cf.16.2024.06.12.07.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:30:59 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:30:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/3] memory: Constify IOMMUTLBEvent in
 memory_region_notify_iommu*()
Message-ID: <ZmmxGqNDQfb_MzeN@x1n>
References: <20240612132532.85928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612132532.85928-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 12, 2024 at 03:25:28PM +0200, Philippe Mathieu-Daudé wrote:
> Trivial patches using const IOMMUTLBEvent.
> 
> Philippe Mathieu-Daudé (3):
>   memory: Constify IOMMUTLBEvent in memory_region_notify_iommu_one()
>   memory: Constify IOMMUTLBEvent in memory_region_notify_iommu()
>   hw/i386/iommu: Constify IOMMUTLBEvent in vtd_page_walk_hook prototype

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


