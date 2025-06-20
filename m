Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968D9C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbXH-0001wU-M4; Fri, 20 Jun 2025 09:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbX2-0001k5-Cu
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbWz-0005T9-1Q
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750425103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJe2HBRJ/IQUNIxBb2aBkefCTkrhJFGgYNypf7axFYo=;
 b=Q8gvDpFzmP7JdOb70lUfyt/dHOz92iF4MD7Cdmf/GWpyB5HqdhJhISzMjjqyPkTF3Le06y
 bkTs+4AnAQcv3KvMm9d+T1/MIsOacFrKn14iwa0zeEJ+sIhHCvNaGMY0X6eaDzPvgCYvdW
 eFP7YXwSap5eYlpBjviIdoNnEVCIwsU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-kglGW9JkPFSxJ8DVfyKgEg-1; Fri, 20 Jun 2025 09:11:42 -0400
X-MC-Unique: kglGW9JkPFSxJ8DVfyKgEg-1
X-Mimecast-MFC-AGG-ID: kglGW9JkPFSxJ8DVfyKgEg_1750425100
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso11123445e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750425100; x=1751029900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJe2HBRJ/IQUNIxBb2aBkefCTkrhJFGgYNypf7axFYo=;
 b=H+EIXvufYMhfZCNpjwBeOLBn92yN9YFuHgZBJELtbmDfGCTxPi01Kbq4qiWlSiSsIw
 IoxnTOkheLa4ijWin0FiYUep6+ux+1H9crhpJrx2bwcylxDM+6K7QRGOjaPmLlOa/pRQ
 U55ykhdKyYzK2yqeOydOicVXsayPurR/qhX9lS4rnLkX5nnga5xLLuWAJ7NbwYxcwoWW
 VPWk5aqoPWfIrAAc+HWDiwnQJw2G9XGintTrNdN0ps8QCSq3Y7SIXeZsiN6h1nUmZWhq
 6J8wVEL+YXic5Kp+grfHHLx4BvPI8O4kKneaaQRKROUGnbb1SAJPwccUu5Kjm2nzWTsA
 R/IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXUmWEH2dmL67KmvZpOVEnwXM8tqkQt6YPYHEFSYeRhbCPx4k95xCPisUuTZ223HEBKgTfOrAIk9wX@nongnu.org
X-Gm-Message-State: AOJu0Yyy3iQLOvNpcRK7lvaPc58h3T+QDmV7JsjuyA4UluRCD1J53d9O
 wofaU2f6VBDaxRuNH3DSIYXi8p9NMOaxd4ON8NmwXfOTMI4rO3U1qfH+XYbxzvu+7U5Ru36lFJl
 3FXmtN74rPPt9j1Qn73IAjdfFbfPdDwwdJQ+hEKj2yypoS1o6VX7eJJ+n
X-Gm-Gg: ASbGncvd4JGCQ4nt5JLkHFTugh+rXLSdo94K3qJCIr4oHub6YdWekzKlJQwbNivLO4x
 XlOdSFfiSIvJu1oGv2qeUbCFHWIlA7KmSEJQkUW3ooQeHyZCOjZr7IeTbf//5dDz7BvXoti0yT8
 9o683Mwj6PKZyRrLpj1ySJOn2U4NizyIsPBIVzkrAKVSrQgOjGWXEM07BAEJVPcG55YCc6yvnaw
 IpxdO/0sPm4yukdhXV2iQPqVBpNzZRAQW6HAHZQeTlcV63suvhUkgaw4x8vxJjLK/gkWlJsgHHD
 fSRQQjWeHncK
X-Received: by 2002:a05:600c:a111:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-45365c0678dmr21001275e9.4.1750425099818; 
 Fri, 20 Jun 2025 06:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNQM7Np2enqemYVMkCPCqzu3is3q23TkWsiA7wGt1GJsCxdkTMcBdYZtjV1Fdwrk5+e8wFmQ==
X-Received: by 2002:a05:600c:a111:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-45365c0678dmr21001015e9.4.1750425099451; 
 Fri, 20 Jun 2025 06:11:39 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453647070cesm24972035e9.33.2025.06.20.06.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 06:11:39 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:11:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 27/29] tests/qtest/bios-tables-test: Prepare for
 addition of acpi pci hp tests
Message-ID: <20250620151138.01364280@fedora>
In-Reply-To: <20250620113138.00007531@huawei.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-28-eric.auger@redhat.com>
 <20250620113138.00007531@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 20 Jun 2025 11:31:38 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 16 Jun 2025 11:46:56 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > From: Gustavo Romero <gustavo.romero@linaro.org>
> > 
> > Soon we will introduce a new test related to ACPI PCI hotplug that
> > will use a new reference blob:
> > 
> > tests/data/acpi/aarch64/virt/DSDT.acpipcihp
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>  
> 
> Unusual sign off chain.  Eric is signing off as handling Gustavo's patch?
> I'd expect Eric's sign off to be second.  Looks good in the next patch fo
> instance.  With that fixed.
>  
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > ---
> >  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
> >  tests/data/acpi/aarch64/virt/DSDT.acpipcihp | 0
> >  2 files changed, 1 insertion(+)
> >  create mode 100644 tests/data/acpi/aarch64/virt/DSDT.acpipcihp
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index dfb8523c8b..dc3ab24d05 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,2 @@
> >  /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
> > diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
> > new file mode 100644
> > index 0000000000..e69de29bb2  
> 


