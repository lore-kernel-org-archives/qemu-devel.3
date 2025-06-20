Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088FEC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSaq8-00070Y-QN; Fri, 20 Jun 2025 08:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSaq5-0006zn-8w
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSaq2-00089K-0G
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750422439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsVVfo4kZ4kiu9BrFrTNt7r/DIf0qYw+e+sl2xJBqzw=;
 b=CLvc6pkYFPdXwTlieqfjzWyyeO43LgjpXg63xS0YOivd3NsM2C/LyawWM8ZFFtHaAdcxyj
 oJP94CSdmLc/1QafbEFWm0SRRcJ6qQhiN7pHvbkJHP+b3JVjYkj6gD/h3dTrZr9iqMOqiT
 XlfGMxkbB8sBkQJrF0zC5V6S48zr6Zg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-5Wx_EJ84OxiOlCZ3QyMFtw-1; Fri, 20 Jun 2025 08:27:18 -0400
X-MC-Unique: 5Wx_EJ84OxiOlCZ3QyMFtw-1
X-Mimecast-MFC-AGG-ID: 5Wx_EJ84OxiOlCZ3QyMFtw_1750422437
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso1003628f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750422437; x=1751027237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HsVVfo4kZ4kiu9BrFrTNt7r/DIf0qYw+e+sl2xJBqzw=;
 b=fGYP/ScKYKxfcE50T9L+gJTR8Z0PMssLGInqL5gHRINqcQYwVXgAZBFSGTRUdCdLb8
 J6PA+6xKif7vx3dOg3ojA/Xenn3IhF5LTTPDJ3o11RjbvqkGNNk3B2cJzQbzuDLCLDVE
 jIXxKskoGtrNB2JoHtPHCd1vr3kTi2QqHlOtEpJchX6kcJTnlJKQoW+S3K+aCvmthzI/
 PsmELxKerqjq9W45wqRPr4I08Ej449IFBbO0jNxF14oPvAkY43zxqDo/iv/+hOp74CGw
 Un4PlE1SwsPHiGL3hllXTBp4u1bAa3tQuoa0hpBK/iDDVSDv+z7ApTdxDaiksyratyGc
 Rqtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnfNj3mlEokJfmNZxOT74MIVj5VsbPQvWshzC4ClWngHhcUXWIS9JJOy1CWmEq/7i1VS29CBPnr8bn@nongnu.org
X-Gm-Message-State: AOJu0YxRQzbmsnS4PokPfWauDBmwH/F2xqoJ57+qDUTwP+JVabZ+BkTm
 qKbq2oecxV609JmhjO+7iM1wtF9uK5J9ub/GWbR38pUTD7Mxj2PeFmDvbAJ8qAZx59NDXfW5ZBs
 WKsIDOXCq5keGtW8rdkDWhFNodtKLBrLxa9nAcjm42JwWe7BJafuxjLlG
X-Gm-Gg: ASbGnctph0/ss/Ko3Dxx4W+Pd6oH/u7kYrmztSln97AM8l1WeRlYhitYskn5YTEx69u
 OBfPbEzgI743A4VC1Lg3J2q/5az30FN0B25773Xww8CeW6tkcDwtPS8NxLGDxshvoOehPBfPGHx
 3hIUDpRLazOerO7yrbXyMQm1J4LJ8GDjmRLp0wN1QYtMFBeM2p/IRzQmasK5+OR5/whcBC1xTte
 VUpXTq+/Z0BV36MzmrCLHc7f2bd5U5SS5WNmKADoxtn98ITYcIXXmfivq5tkGGBXtE4ZqMMCzxk
 0dBiizqLjp11
X-Received: by 2002:a05:6000:1448:b0:3a4:dd8e:e16d with SMTP id
 ffacd0b85a97d-3a6d12a3bc0mr2195373f8f.15.1750422437377; 
 Fri, 20 Jun 2025 05:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKclbNbWnH11noHkQH2DPFA1XKhZt1PzxkZLUUe/LQc778wIW/qJqI6q3BJAx9oJBM16JlNg==
X-Received: by 2002:a05:6000:1448:b0:3a4:dd8e:e16d with SMTP id
 ffacd0b85a97d-3a6d12a3bc0mr2195342f8f.15.1750422436779; 
 Fri, 20 Jun 2025 05:27:16 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e741b43sm59446925e9.0.2025.06.20.05.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:27:16 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:27:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 16/29] hw/i386/acpi-build: Move aml_pci_edsm to a
 generic place
Message-ID: <20250620142714.4c4b1d8a@fedora>
In-Reply-To: <20250620101936.00005f96@huawei.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-17-eric.auger@redhat.com>
 <20250620101936.00005f96@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 20 Jun 2025 10:19:36 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 16 Jun 2025 11:46:45 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > Move aml_pci_edsm to pci-bridge.c since we want to reuse that for
> > ARM and acpi-index support.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>  
> 
> A request for a bit of documentation inline.  aml_pci_edsm() sounds
> like we should be able to grep the spec for edsm and find it but
> that's just internal method naming in qemu.

agree, aml_ prefix is typically reserved for ACPI spec items. 

perhaps rename it to follow build_ prefix scheme?

> 
> 
> More interesting is I don't think this will ever be called as
> the kernel has no idea how to call it and unlike on x86 the
> blobs don't show wrapping the call in a _DSM() (see aml_pci_static_endpoint_dsm())
> 
> Did EDSM usage get dropped as this set evolved leaving this behind?
> 
> 
> 
> >
> > ---
> > 
> > v2 -> v3:
> > - move to pci-bridge.c instead of pcihp.c (Igor)
> > ---
> >  include/hw/acpi/pci.h |  1 +
> >  hw/acpi/pci-bridge.c  | 54 +++++++++++++++++++++++++++++++++++++++++++
> >  hw/i386/acpi-build.c  | 53 ------------------------------------------
> >  3 files changed, 55 insertions(+), 53 deletions(-)
> > 
> > diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> > index 69bae95eac..05e72815c8 100644
> > --- a/include/hw/acpi/pci.h
> > +++ b/include/hw/acpi/pci.h
> > @@ -42,5 +42,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
> >  void build_srat_generic_affinity_structures(GArray *table_data);
> >  
> >  Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
> > +Aml *aml_pci_edsm(void);
> >  
> >  #endif
> > diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
> > index 7baa7034a1..be68a98c34 100644
> > --- a/hw/acpi/pci-bridge.c
> > +++ b/hw/acpi/pci-bridge.c
> > @@ -35,3 +35,57 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
> >          }
> >      }
> >  }
> > +
> > +Aml *aml_pci_edsm(void)  
> 
> Can we have some comments, or a more descriptive name than
> the resulting method name?  There is stuff in the function obviously
> that associates it with the naming DSM but given this is moving to
> generic code maybe it needs a brief intro comment?
> 
> 
> > +{
> > +    Aml *method, *ifctx;
> > +    Aml *zero = aml_int(0);
> > +    Aml *func = aml_arg(2);
> > +    Aml *ret = aml_local(0);
> > +    Aml *aidx = aml_local(1);
> > +    Aml *params = aml_arg(4);
> > +
> > +    method = aml_method("EDSM", 5, AML_SERIALIZED);
> > +
> > +    /* get supported functions */
> > +    ifctx = aml_if(aml_equal(func, zero));
> > +    {
> > +        /* 1: have supported functions */
> > +        /* 7: support for function 7 */
> > +        const uint8_t caps = 1 | BIT(7);
> > +        build_append_pci_dsm_func0_common(ifctx, ret);
> > +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
> > +        aml_append(ifctx, aml_return(ret));
> > +    }
> > +    aml_append(method, ifctx);
> > +
> > +    /* handle specific functions requests */
> > +    /*
> > +     * PCI Firmware Specification 3.1
> > +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> > +     *        Operating Systems
> > +     */
> > +    ifctx = aml_if(aml_equal(func, aml_int(7)));
> > +    {
> > +       Aml *pkg = aml_package(2);
> > +       aml_append(pkg, zero);
> > +       /* optional, if not impl. should return null string */
> > +       aml_append(pkg, aml_string("%s", ""));
> > +       aml_append(ifctx, aml_store(pkg, ret));
> > +
> > +       /*
> > +        * IASL is fine when initializing Package with computational data,
> > +        * however it makes guest unhappy /it fails to process such AML/.
> > +        * So use runtime assignment to set acpi-index after initializer
> > +        * to make OSPM happy.
> > +        */
> > +       aml_append(ifctx,
> > +           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
> > +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
> > +       aml_append(ifctx, aml_return(ret));
> > +    }
> > +    aml_append(method, ifctx);
> > +
> > +    return method;
> > +}
> > +
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index fe8bc62c03..6cf623392e 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -338,59 +338,6 @@ build_facs(GArray *table_data)
> >      g_array_append_vals(table_data, reserved, 40); /* Reserved */
> >  }
> >  
> > -static Aml *aml_pci_edsm(void)
> > -{
> > -    Aml *method, *ifctx;
> > -    Aml *zero = aml_int(0);
> > -    Aml *func = aml_arg(2);
> > -    Aml *ret = aml_local(0);
> > -    Aml *aidx = aml_local(1);
> > -    Aml *params = aml_arg(4);
> > -
> > -    method = aml_method("EDSM", 5, AML_SERIALIZED);
> > -
> > -    /* get supported functions */
> > -    ifctx = aml_if(aml_equal(func, zero));
> > -    {
> > -        /* 1: have supported functions */
> > -        /* 7: support for function 7 */
> > -        const uint8_t caps = 1 | BIT(7);
> > -        build_append_pci_dsm_func0_common(ifctx, ret);
> > -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
> > -        aml_append(ifctx, aml_return(ret));
> > -    }
> > -    aml_append(method, ifctx);
> > -
> > -    /* handle specific functions requests */
> > -    /*
> > -     * PCI Firmware Specification 3.1
> > -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
> > -     *        Operating Systems
> > -     */
> > -    ifctx = aml_if(aml_equal(func, aml_int(7)));
> > -    {
> > -       Aml *pkg = aml_package(2);
> > -       aml_append(pkg, zero);
> > -       /* optional, if not impl. should return null string */
> > -       aml_append(pkg, aml_string("%s", ""));
> > -       aml_append(ifctx, aml_store(pkg, ret));
> > -
> > -       /*
> > -        * IASL is fine when initializing Package with computational data,
> > -        * however it makes guest unhappy /it fails to process such AML/.
> > -        * So use runtime assignment to set acpi-index after initializer
> > -        * to make OSPM happy.
> > -        */
> > -       aml_append(ifctx,
> > -           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
> > -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
> > -       aml_append(ifctx, aml_return(ret));
> > -    }
> > -    aml_append(method, ifctx);
> > -
> > -    return method;
> > -}
> > -
> >  /*
> >   * build_prt - Define interrupt routing rules
> >   *  
> 


