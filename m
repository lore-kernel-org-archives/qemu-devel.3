Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873F2EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo2E-0006S5-1M; Tue, 10 Feb 2026 08:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vpo28-0006PR-Jm
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vpo26-0003Xc-FH
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770731041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drPkXzhsh8xgpEYIPQ22HxbIezsVjM3abd8PrTSeKW4=;
 b=JH1Vl7Q6/np7UDREXYcTzJc1Pdi5RCwzKNU9ZYeRwqFS8cA+euMlYf4g/XM5qBA65DQhu0
 X8bhsqLMN16yxQkqDQcTElKgj7sPyFIrh92629PKzN2CPoO27PM0j97FoIQynCeeNlRvJK
 UhEVOZyhM4kLlAL85U5P38CpgmWKh5w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-FcELjlLFOTOhoIiMw0hsCw-1; Tue, 10 Feb 2026 08:43:58 -0500
X-MC-Unique: FcELjlLFOTOhoIiMw0hsCw-1
X-Mimecast-MFC-AGG-ID: FcELjlLFOTOhoIiMw0hsCw_1770731037
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4801c1056c7so5266325e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770731037; x=1771335837; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=drPkXzhsh8xgpEYIPQ22HxbIezsVjM3abd8PrTSeKW4=;
 b=P0HnQmShQRrLAjC1FFbn0SnLs93MtByHsPtR8foLTO7uu0GLVhJW0glnJx1HYkBbcz
 iDIfYSNelxpalHczd+WlPfSr1Ry6qVBtvxpFKLiuu0xhC+qFTnBGvaVYJ+Fw4wmhlz55
 UiDmR7x1pmB9Ac8+FKGXPJ10PZf76DJ5tfDChWTScvWkujUFZcYmUAPbqmTWt0qbWoHv
 FYfMZU+PP3ZjcQN2bKeTdjeJXZXaOlgtxNy8ENgc/quMDBsDwrmAu4ceHfnWqui6TheX
 PHTRMVWeC2sV03liXJ4q4uSDGvszIg5SsDDm6Ew4VblA+OtcoQUJ6mL1r5jXCViA5Kbb
 QxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731037; x=1771335837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drPkXzhsh8xgpEYIPQ22HxbIezsVjM3abd8PrTSeKW4=;
 b=Oha0jQKqmn/QFTP8b3/tq9+c9yvthElJEFog6hybapad/HCurjCjkEYZZV8MjO+F16
 9WL+xBe+skDmcg6bTmugeoHkvvhpOAlXAoh7/ucHz39vAIsVhTXLYHF+cLDwKFwAlvr4
 kVFIUi2YYRCGqSbRQulabRD38MiV17A9TgBCY8VuEbOa5LDRey1GlzoEJJbqszI9ln6o
 tctaM2Tc2euecadRpPHTvWRQ/5nKVJIPV8JtbwMIfc/8YRQCl+wGs+EwJMhJtxz8KtL+
 Q6CYveTQyaLV2HdMz6CLawoF3EqaE74DheThiCPPreuSFmyE8O7LTN/3NmrGOUC4D4Is
 BHOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHug/XR6S75X63S653CeVghdnYYETIWSQwod/q2y2fb49NjtpaxAgiOmzDuGUOvYq3YCqPhVpUyVKd@nongnu.org
X-Gm-Message-State: AOJu0Yx2wDL2mN7vqgi5CESycO6yNNqnrqhUtPnFVfsuLiVdh1LApKzw
 XIo+BjlhznQrc33h/NEdSK1LKZgJ7ZzGov5V8WAAVZIbZN+mO+zr18VrE4Yakbg7aP2vGxJQ4OT
 pDvFHvVQSwi1u6ExLdols2GCleGFbkhkAJarisfFIXG6yWqw1fpGnbKcb
X-Gm-Gg: AZuq6aLNFJX9SR6mbgaJW2RxzaAYQIBmrWQjnHCGLkN+rHGVOLKJ2sXQillw+pGWQ4e
 SwdJ62bCaaodBiHKAkohTmL+gzGOnx/YxTpc2O+wTCvskPXKo27VC4qdCBf9YjbB4vwJAKnVRdB
 Z3HbNlEX6PIFwZH7ee+gELf7E0X5/J+B4FRS5OZnytkt0EJoqHuiPp8s7if+z/ItXabbnbH9VGc
 nQAYuGsblnTJEdf0rXxMJaRuczjs4JlgyvbZU+hbiMxJDpk5+koticgHJs7Gq/NaaVuGkU/mD7a
 Fw7U3ce5YfvZqRKUx8VIZNq92BPx1oEtkMcpz5QqBcBUVUmC+F+EeByXk0mkYAA1A7HFPg2bG+b
 SUmZaqGkc3Hnn7bN9Z/tygXY8fP5xloe2vlyuOcvnyxDVmg==
X-Received: by 2002:a05:600c:19c7:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-483201db067mr194470245e9.1.1770731036744; 
 Tue, 10 Feb 2026 05:43:56 -0800 (PST)
X-Received: by 2002:a05:600c:19c7:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-483201db067mr194469805e9.1.1770731036210; 
 Tue, 10 Feb 2026 05:43:56 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4832041f1a3sm145872225e9.7.2026.02.10.05.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:43:55 -0800 (PST)
Date: Tue, 10 Feb 2026 08:43:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
Subject: Re: [PATCH v3 0/9] : pnv/phb4: Update PHB4 to the latest PHB5 spec
Message-ID: <20260210084319-mutt-send-email-mst@kernel.org>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 10, 2026 at 07:40:50AM -0600, Saif Abrar wrote:
> Hello,
> 
> Addressing the review comments for the series v2:
> https://lists.gnu.org/archive/html/qemu-devel/2025-12/msg03768.html

pls include a detailed changelog.
No one wants to plough through all of it on each revision.

> This series updates the existing PHB4 model to the latest spec:
> "Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".
> 
> Updates include the following:
> - implemented sticky reset logic
> - implemented read-only, write-only, W1C and WxC logic
> - return all 1's on read to unimplemented registers
> - update PCIE registers for link status, speed and width
> - implement IODA PCT debug table without any functionality
> - update LSI Source-ID register based on small/big PHB number of interrupts
> 
> Also, a new testbench for PHB4 model is added that does XSCOM read/writes
> to various registers of interest and verifies the values.
> 
> Regards.
> 
> Saif Abrar (9):
>   qtest/phb4: Add testbench for PHB4
>   pnv/phb4: Add reset logic to PHB4
>   pnv/phb4: Implement sticky reset logic in PHB4
>   pnv/phb4: Implement read-only and write-only bits of registers
>   pnv/phb4: Implement write-clear and return 1's on unimplemented reg read
>   pnv/phb4: Set link-active status in HPSTAT and LMR registers
>   pnv/phb4: Set link speed and width in the DLP training control register
>   pnv/phb4: Implement IODA PCT table
>   pnv/phb4: Mask off LSI Source-ID based on number of interrupts
> 
>  hw/pci-host/pnv_phb.c               |   1 +
>  hw/pci-host/pnv_phb4.c              | 583 +++++++++++++++++++++++++---
>  include/hw/pci-host/pnv_phb4.h      |  16 +-
>  include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
>  tests/qtest/meson.build             |   1 +
>  tests/qtest/pnv-phb4-test.c         | 228 +++++++++++
>  6 files changed, 837 insertions(+), 58 deletions(-)
>  create mode 100644 tests/qtest/pnv-phb4-test.c
> 
> -- 
> 2.47.3


