Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8222CC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8tz-0003so-CT; Wed, 03 Jul 2024 18:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ty-0003rn-6P
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8tw-0001ek-4d
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwYyD/KUkbkxSb1TRAT8zXkqiqU7/n4SuhkILToxS/w=;
 b=JqmNwpu9lmSm2pxZfa3INsOFJNzWs0HlPjff3KWxEQbqMhrejJ2Zb5RIbBKcXP5YsmqXaB
 /oWdJk0qqmLwENKm4nnkuVZz3n29rO9tfUx8ow+Mu92PdcYreQHAbgfDKiR1zOl6VpdieG
 7LmM/CsgxiX+vmMKhjo3EN2fZoCxG3A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-nRTa7nZHN3iSO1A-25YxiQ-1; Wed, 03 Jul 2024 18:56:34 -0400
X-MC-Unique: nRTa7nZHN3iSO1A-25YxiQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e982ad660so1184605e87.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047392; x=1720652192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwYyD/KUkbkxSb1TRAT8zXkqiqU7/n4SuhkILToxS/w=;
 b=pojSUNe3Moh04VCfzgnrvIHtdg1NnRch9wAZLlS+rrY0juJXmRSTJnjWY0sNuF/jhW
 8hIPkwGMw1+K/g7t1Zpq1ANaEow8INkDj54eKsvcqm2lZotQXUUskB7feE8AxaN3kFSO
 ezJrNBqkGZBmagBbIcwxLnWEpE8eXkERCrZQyrszT3xFwIsfQ0tyI66qwlUqbYsebYAh
 2ChRWDSAkMxQPsEifpwYcY2sNUDSXdNT5we+NkJ2YTW0FkIiU8ZgH4EdGwd8RNkf21bK
 rFTGMyw+bkJgpMGlFidvomshaSq1JqBeiJFJf+HED/0m2nCTaclcBsENxBoUudOT9Mdc
 Tdxw==
X-Gm-Message-State: AOJu0YxRojsUya2KNX1sZxim9sLn6Z34AIcAZ/siwVzWCkPoUQTXNuzS
 4b0GqhTgzcT2TDUJBNnnEWgHbELgJsVfeTeLIY7vmmUss4IjQFDhUwMX2SoIe1Uk8TJFd61ZNzt
 9AmCd47QVk0q7VKySbXC9JDhd1EiZq1kQS6zkm4F8fFLl1oJnQtviKSobuV1+RGxZ/nSeZh39SN
 IqoOok9pBvcd9HuBlp4hOss4eQVbtaGg==
X-Received: by 2002:a05:6512:3c9c:b0:52c:8979:9627 with SMTP id
 2adb3069b0e04-52e826467f8mr10887558e87.3.1720047392028; 
 Wed, 03 Jul 2024 15:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYR6GPRB9iG/xpmU5wXORmOCudYip0iPHL3usAsVW7BYYmW9ewnODZ6s4AXh7fMfEFw78TMw==
X-Received: by 2002:a05:6512:3c9c:b0:52c:8979:9627 with SMTP id
 2adb3069b0e04-52e826467f8mr10887532e87.3.1720047391149; 
 Wed, 03 Jul 2024 15:56:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58b43df9efdsm2933694a12.57.2024.07.03.15.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:56:30 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:56:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL v3 68/85] tests/data/acpi/virt: Move ARM64 ACPI tables under
 aarch64/${machine} path
Message-ID: <7434f904673c36b78871a3b18ab1f5c09c640131.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-ID: <20240703225626.5w386n0Y5i1fILtGERupIEk7Mn_0zy1k7B-q0BsKbk0@z>

From: Sunil V L <sunilvl@ventanamicro.com>

Same machine name can be used by different architectures. Hence, create
aarch64 folder and move all aarch64 related AML files for virt machine
inside.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-11-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/{ => aarch64}/virt/APIC             | Bin
 .../data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/APIC.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/DBG2             | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT             | Bin
 .../data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.pxb         | Bin
 tests/data/acpi/{ => aarch64}/virt/DSDT.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/FACP             | Bin
 tests/data/acpi/{ => aarch64}/virt/GTDT             | Bin
 .../data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/IORT             | Bin
 tests/data/acpi/{ => aarch64}/virt/MCFG             | Bin
 tests/data/acpi/{ => aarch64}/virt/NFIT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT             | Bin
 .../data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/PPTT.topology    | Bin
 tests/data/acpi/{ => aarch64}/virt/SLIT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/SPCR             | Bin
 .../data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt  | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/SRAT.numamem     | Bin
 tests/data/acpi/{ => aarch64}/virt/SSDT.memhp       | Bin
 tests/data/acpi/{ => aarch64}/virt/VIOT             | Bin
 25 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/data/acpi/{ => aarch64}/virt/APIC (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/APIC.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DBG2 (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.pxb (100%)
 rename tests/data/acpi/{ => aarch64}/virt/DSDT.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/FACP (100%)
 rename tests/data/acpi/{ => aarch64}/virt/GTDT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/HMAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/IORT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/MCFG (100%)
 rename tests/data/acpi/{ => aarch64}/virt/NFIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/PPTT.topology (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SLIT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SPCR (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.acpihmatvirt (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SRAT.numamem (100%)
 rename tests/data/acpi/{ => aarch64}/virt/SSDT.memhp (100%)
 rename tests/data/acpi/{ => aarch64}/virt/VIOT (100%)

diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/aarch64/virt/APIC
similarity index 100%
rename from tests/data/acpi/virt/APIC
rename to tests/data/acpi/aarch64/virt/APIC
diff --git a/tests/data/acpi/virt/APIC.acpihmatvirt b/tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/APIC.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/APIC.acpihmatvirt
diff --git a/tests/data/acpi/virt/APIC.topology b/tests/data/acpi/aarch64/virt/APIC.topology
similarity index 100%
rename from tests/data/acpi/virt/APIC.topology
rename to tests/data/acpi/aarch64/virt/APIC.topology
diff --git a/tests/data/acpi/virt/DBG2 b/tests/data/acpi/aarch64/virt/DBG2
similarity index 100%
rename from tests/data/acpi/virt/DBG2
rename to tests/data/acpi/aarch64/virt/DBG2
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
similarity index 100%
rename from tests/data/acpi/virt/DSDT
rename to tests/data/acpi/aarch64/virt/DSDT
diff --git a/tests/data/acpi/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/DSDT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
similarity index 100%
rename from tests/data/acpi/virt/DSDT.memhp
rename to tests/data/acpi/aarch64/virt/DSDT.memhp
diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
similarity index 100%
rename from tests/data/acpi/virt/DSDT.pxb
rename to tests/data/acpi/aarch64/virt/DSDT.pxb
diff --git a/tests/data/acpi/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
similarity index 100%
rename from tests/data/acpi/virt/DSDT.topology
rename to tests/data/acpi/aarch64/virt/DSDT.topology
diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/aarch64/virt/FACP
similarity index 100%
rename from tests/data/acpi/virt/FACP
rename to tests/data/acpi/aarch64/virt/FACP
diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/aarch64/virt/GTDT
similarity index 100%
rename from tests/data/acpi/virt/GTDT
rename to tests/data/acpi/aarch64/virt/GTDT
diff --git a/tests/data/acpi/virt/HMAT.acpihmatvirt b/tests/data/acpi/aarch64/virt/HMAT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/HMAT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/HMAT.acpihmatvirt
diff --git a/tests/data/acpi/virt/IORT b/tests/data/acpi/aarch64/virt/IORT
similarity index 100%
rename from tests/data/acpi/virt/IORT
rename to tests/data/acpi/aarch64/virt/IORT
diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/aarch64/virt/MCFG
similarity index 100%
rename from tests/data/acpi/virt/MCFG
rename to tests/data/acpi/aarch64/virt/MCFG
diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/aarch64/virt/NFIT.memhp
similarity index 100%
rename from tests/data/acpi/virt/NFIT.memhp
rename to tests/data/acpi/aarch64/virt/NFIT.memhp
diff --git a/tests/data/acpi/virt/PPTT b/tests/data/acpi/aarch64/virt/PPTT
similarity index 100%
rename from tests/data/acpi/virt/PPTT
rename to tests/data/acpi/aarch64/virt/PPTT
diff --git a/tests/data/acpi/virt/PPTT.acpihmatvirt b/tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/PPTT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt
diff --git a/tests/data/acpi/virt/PPTT.topology b/tests/data/acpi/aarch64/virt/PPTT.topology
similarity index 100%
rename from tests/data/acpi/virt/PPTT.topology
rename to tests/data/acpi/aarch64/virt/PPTT.topology
diff --git a/tests/data/acpi/virt/SLIT.memhp b/tests/data/acpi/aarch64/virt/SLIT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SLIT.memhp
rename to tests/data/acpi/aarch64/virt/SLIT.memhp
diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/aarch64/virt/SPCR
similarity index 100%
rename from tests/data/acpi/virt/SPCR
rename to tests/data/acpi/aarch64/virt/SPCR
diff --git a/tests/data/acpi/virt/SRAT.acpihmatvirt b/tests/data/acpi/aarch64/virt/SRAT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/SRAT.acpihmatvirt
rename to tests/data/acpi/aarch64/virt/SRAT.acpihmatvirt
diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/aarch64/virt/SRAT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SRAT.memhp
rename to tests/data/acpi/aarch64/virt/SRAT.memhp
diff --git a/tests/data/acpi/virt/SRAT.numamem b/tests/data/acpi/aarch64/virt/SRAT.numamem
similarity index 100%
rename from tests/data/acpi/virt/SRAT.numamem
rename to tests/data/acpi/aarch64/virt/SRAT.numamem
diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/aarch64/virt/SSDT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SSDT.memhp
rename to tests/data/acpi/aarch64/virt/SSDT.memhp
diff --git a/tests/data/acpi/virt/VIOT b/tests/data/acpi/aarch64/virt/VIOT
similarity index 100%
rename from tests/data/acpi/virt/VIOT
rename to tests/data/acpi/aarch64/virt/VIOT
-- 
MST


