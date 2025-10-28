Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B306CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDodZ-00055e-CV; Tue, 28 Oct 2025 14:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDodW-00051S-Gt
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDodJ-0005mc-AM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761676876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbdFtFheFozDA/Dq4cgI2dg6cbI5rnjMpYsY6r4xZ7A=;
 b=CghR5X4n13DpNHcZDs0K+/06VL9xkMl03dAlCT3zO+SoYSHU4ITQuefPzCwBBPIepfSCWT
 EXIjWMFpBKKD5h3PZtloOEiISM23ukzblC5+IyNUqi86XdEUVIYWm6ykdukAfOnuiaseyY
 bE100P0odCgWIrGaZwNqDljinD2TH5g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-G82rhYQ7PyeTwT-KlS7vAg-1; Tue, 28 Oct 2025 14:41:14 -0400
X-MC-Unique: G82rhYQ7PyeTwT-KlS7vAg-1
X-Mimecast-MFC-AGG-ID: G82rhYQ7PyeTwT-KlS7vAg_1761676874
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-89090e340bfso1266738685a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676874; x=1762281674;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LbdFtFheFozDA/Dq4cgI2dg6cbI5rnjMpYsY6r4xZ7A=;
 b=Mv4jK0PPoxytImELKb15Mk/abFf/p5J6KHkkZVUT9MBTLIAmKXi+23QjfV33ztEVyq
 GiEU8/Lnl6OURXgcu4Zboid7VHab/cK72Huva45OGBpAbH3HHGFBbk88mDYugEQbUOXz
 d6Ua6BkgqiwduDHfB+FZ9dl1ku6CCfp5g3u3NtU5HAIPto/nv++HbB9BhkKzkeZB37Wp
 ELd51y7KD1ZD2hnFN2eGm9/1J5WIybqX6pREB7yn7r5PAQznZ9xb5Dnh4dXZy/RuKHMM
 7sv6TlWv4mOwx+dzFsMt2BrP9YDzM2Iqw9B9gFgccnBEXjZH7GaV9DBTEY+d5aCxqJ8e
 GUsQ==
X-Gm-Message-State: AOJu0YyVQx8O47PnDZbIn3YYNKmq+QIIvdFiREYlPh6ohCAhORrMTqNt
 mj3vLQmNfqr2k42Mnw90KjPBw3ZI2dBsF3pgzBe4icF4sx4GPaECNjPG6IyhtFApdAEysAFDK8Z
 GEvAopdM4zIfV0TNDqEychfAfhPI2eSsdKfsJYjiGl5V2tqERYcyDSBU+
X-Gm-Gg: ASbGncvyYIG3ImjzikWCKcJNKIBAoFDRa7oR/dKwdUBDM5rvG1YpVq5G5bePSSPIy+o
 q3imH87juHTxL/y4fJsdC03rInw51ykM4xevWUpV79NnQi8kouOtAPrRp8NokTarAL8xT2829El
 1Y25ZHU1crCQ+7iGL54btGRZBT3Q5rq/hfSwdNnEttd/rWYOi9cn+0UgkawMmwhhpTgMRmqvQFi
 2/2dx3P5jDOmRV1RQxIi8AO2AXZiPXLt2vRK6TgbaWMRPeNXeQ3igQfkQtZlyHIMSz7NV0X3kkD
 WwkZggoGTEWphu2LKOgP7thiNuPy0n7IumrcRWRB3M0TzNxPvpA9t5C75WPvb/9odfw=
X-Received: by 2002:a05:620a:4512:b0:89a:2f2d:f951 with SMTP id
 af79cd13be357-8a8e6954ac0mr49383985a.64.1761676873667; 
 Tue, 28 Oct 2025 11:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExlGj2eHAfl7Q0UihMJQXKFKYGcAui8Hur/E8eN5n88UQ5+B369cHASvyD7Eab3tZKhyEqag==
X-Received: by 2002:a05:620a:4512:b0:89a:2f2d:f951 with SMTP id
 af79cd13be357-8a8e6954ac0mr49378585a.64.1761676873101; 
 Tue, 28 Oct 2025 11:41:13 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f24ecbc11sm891450685a.24.2025.10.28.11.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 11:41:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:41:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 10/25] system/memory: Have memory_region_size() take a
 const argument
Message-ID: <aQEORt9fVYQm14O1@x1.local>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028181300.41475-11-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Oct 28, 2025 at 07:12:44PM +0100, Philippe Mathieu-Daudé wrote:
> Since the @mr argument is not modified, it can be const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


