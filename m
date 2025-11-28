Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0F6CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 14:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOzAJ-0001j6-2K; Fri, 28 Nov 2025 09:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vOzAE-0001hr-0D
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 09:09:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vOzAC-0005oU-8f
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 09:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWCrlI12+QyOotsFI94k48jEzmB+M45Tx6a8dI25gek=;
 b=UCMsLOa3USV8hm1eJ2QalgxZNNRb0OL1mocjGlLgh/BvPAAHpd0Cb+sxekRp3ngkEtZqra
 fHKhcebPxRXpZDbWwy27mheNvGK0i0C0T1de4WObIDxn24f5FHljcmN76INEtxy4XLLY8Z
 ozCV7ksJZDJuH/CHYfkN1uCILV38Kuk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-yT24m_9ROoSjnGsxfze5zQ-1; Fri, 28 Nov 2025 09:09:30 -0500
X-MC-Unique: yT24m_9ROoSjnGsxfze5zQ-1
X-Mimecast-MFC-AGG-ID: yT24m_9ROoSjnGsxfze5zQ_1764338969
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso16842525e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764338969; x=1764943769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CWCrlI12+QyOotsFI94k48jEzmB+M45Tx6a8dI25gek=;
 b=NtLkIVN86i4JAhIphHkRKvc7bWKBHZnIWf2aSqrwThNt7FUjp7K052BQxOu5kpPgru
 7c1YStjuND2o18ybXg0pSD4KDNnwRQhlXoWOP6pTOx+88E3UMvkSFmA4ueVSsPyqMRgS
 B/+ongW2jWB6uMIfwLoTKcHibWbMdr4vvufhqh4I0IsMKRbUvIGYRywHrR81leNsmrtF
 ZNM0NGigf8gEN0X1hWn09fJABHeHTnvBN1mT0BxdaCdwrnGaSSCawD3bAFpmUKypLAtl
 x1fn36Ic7P4yhlu91B6Wml1b0HV+hM8gWHVlxVPuTUiB5pwz4VgicHjtUov0rgIfT5Oc
 m83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764338969; x=1764943769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CWCrlI12+QyOotsFI94k48jEzmB+M45Tx6a8dI25gek=;
 b=BzxfiqSloVt+Zi4Y1CngWrRvbKElmwwgpNtR1zrAuY55nT3Qj2C+pfaER6fMY8dZYH
 qE1d0s4bA0J3apLadvpz/d/QMME9QGOlzN0EUC3bxL4e4b2BwUDkKr7FX1f9L87TOHMl
 OYeqtct8dDXKd53V4ZthU9DpY7+YNxBoeavLre9pknewPKNVur2M1hudA5+Etx+LOMHo
 vdKtnbzk8elIKT8E6WeSV1KKBM+eWjuOzwTPPBOy+xlp6IsamU4LRDoJuQySFwihIP8P
 05dFwr5XtGJ0mKaG8XjOKanqBkLy2rcOtEMTdwHUQtZ2y6XTmxTa8MVGKmzjXWIr1kJe
 NW2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBOjPe6XPPeLOC0ckwT8rVmSPisEMxMXnwIOCxmDO7B+HgUXWrOV/b6sD8ssTEN0QoK568St0cLZgl@nongnu.org
X-Gm-Message-State: AOJu0YyrJOQICKvanWPgsgFNtcgwf4Q9rMQfKWUf/xLClpLRbSU/Kek1
 lLQ6f31a5PMUnhoiUntT5cFXUUF4r1e5Wpt+fe+6qmCTFYChMyjA32pmHrvuUdr9ha6jNuAoIrR
 ZF85gZhO1hXWJHiIXa/3Z3xQeQFY+ybG88vtC9mf0vfTe7jk0bjP/JOii
X-Gm-Gg: ASbGnctVHqLgdEJFtImpeKTNtmpHo0aJYCpJHCD7cHHYOoEskedbVlirVjP56YQjrq/
 s/r3qPlrJC5fcLO8Ff+QnNCvkr06PTayGIj+zVFD/ATUD0u9EuM+KmE5JubyDoOebfmxEZmtvM/
 tWtdgFWEViY/K5gvkPTdvG6334yGY3YaUEPZpOzgubKEz2fovuH+efpztHcAf5PutTsRy0X4kPb
 YOkRHdyURI/Alz0rI+ZR7nH8lZbxPBFKhbaIgWI9dlPAcgCMrfQWW47gijNjBaCmG/cUW3oNdna
 ab6ZOiuqZWUOHA9HaiOGHZKr0LgnBuPsFf2O1nRt1/sXNSdbNjcg3A/IRnGDOPvNft7gEw==
X-Received: by 2002:a05:600c:1d1d:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-477c01ff5bbmr314751125e9.30.1764338968697; 
 Fri, 28 Nov 2025 06:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzFVYqWSDIRM6IhIK+EMRrkzaegpyoT7Qvae+FLp+SkR6WlVdh79WTeUJ9GnHUQVLwHpfJdQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-477c01ff5bbmr314750565e9.30.1764338968305; 
 Fri, 28 Nov 2025 06:09:28 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47911143bb6sm101649805e9.3.2025.11.28.06.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 06:09:27 -0800 (PST)
Date: Fri, 28 Nov 2025 15:09:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/5] acpi/ghes: Error object handling improvement
Message-ID: <20251128150926.78bebacb@imammedo>
In-Reply-To: <20251127004435.2098335-1-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 27 Nov 2025 10:44:30 +1000
Gavin Shan <gshan@redhat.com> wrote:

> This series is curved from that for memory error handling improvement
                 ^^^ confusing
based on above I'm not sure if it depends on [1] and shoul be applied on top
or it can be merged on its own

> [1] based on the received comments, to improve the error object handling
> in various aspects.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-arm/2025-11/msg00534.html
> 
> Gavin Shan (5):
>   acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
>   acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
>   target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
>   acpi/ghes: Bail early on error from get_ghes_source_offsets()
>   acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()
> 
>  hw/acpi/ghes-stub.c    |  6 +++---
>  hw/acpi/ghes.c         | 45 ++++++++++++++++++------------------------
>  include/hw/acpi/ghes.h |  6 +++---
>  target/arm/kvm.c       | 10 +++-------
>  4 files changed, 28 insertions(+), 39 deletions(-)
> 


