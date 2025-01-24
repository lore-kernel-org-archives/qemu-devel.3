Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BB6C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMnR-0003VJ-Kb; Fri, 24 Jan 2025 11:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tbMmm-0003Kb-BI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tbMmk-0000ze-Hn
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737737037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IDKUVYKOGSDfpP03QEl3KwwK9q8MuQxs4/UuoRKH5lI=;
 b=FsXtsscp6c0/EvI0BHRLc3mdfhVa5VryoQFhxJiavge5yFHotByeMa9UyEwbwQVJpflLHk
 WmCZC4RMEA5tZF6tUAWkqxuKukGv5FVya0JHApdVpEvv4lt5Kr/xMU/E6MyIIqq0HdO58F
 24eZ7IODRyxiZVj+Ad2uBm3rfhg0yRA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-JXF_cFceO8WVcUVRuJ0f_g-1; Fri, 24 Jan 2025 11:43:54 -0500
X-MC-Unique: JXF_cFceO8WVcUVRuJ0f_g-1
X-Mimecast-MFC-AGG-ID: JXF_cFceO8WVcUVRuJ0f_g
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-71e13d7e9f2so1583567a34.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737737033; x=1738341833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDKUVYKOGSDfpP03QEl3KwwK9q8MuQxs4/UuoRKH5lI=;
 b=PcdTD6HV4kTO9dkC9KxcP7nU/C944nmEgemiJTh1SagutTE0+yVzthOoGOXrSE274c
 eAelxbB7EiB3GJYxa/LAvrR+8gXrXJwDeUydUDSFG54hU4qhJK2yvQcTfb9koeoXTzCH
 nSnAY5Xr8y5DrGlH/XUDwG0YpS28U/kFSxkyXzgG2JRwd8GpmaDQ4QhEubUVNOJixNmx
 lp3P4F8J2ZKLKO4acsePZxGjrPy3yRhQQLK4mQ8+953OROKXZF1rXBsZHQMTUA8jRhdK
 cCEDyFyTq7VODj7MgJ8FOjRGRg4vylDP9ytwTOgK+cUEm5nrsd6Nxh2iKTjn0Dg+2O0e
 1OXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7pCP/TdEOSaBf2KQNFDWdMGLevGhtZEoBNCGPCaXjY9/PlinVrGPsz/fq7Api1OoImpnETQaYtnLf@nongnu.org
X-Gm-Message-State: AOJu0YzieGNglQTT6yImJtLCM3ZjqG2ueRidIW5m+4DIjrrAkIzpSygb
 96vmOuiIvJ9KPk9nDqK24qGRJuoBRKep6zjbyb4rroUG/BULvYGQbR80cxJ4qosFNXGFUq47PBa
 1l5PHcQCBHQFsJamc8abTpsX9QJmpXssXdodGKVIpceyvXxroDwAu
X-Gm-Gg: ASbGncs34lqI38sFvDBtr1EQPpK5qOKcnxiRrUBoS/hkqf34imDT23AwgRBUFLTM126
 Xv8yDae30K2/u+wd8+dgDVktf0MVfAVZEcIW+7gg9f8GxSU1hh74ymiI12G+Ug4yakdEb813C91
 MxdEkdkMc/m5RxTTthce8pzDNXuaY78xW1g9PpBG1AFnSn3ATgrVLLB4V8JrcXhjeSMVa+B9U/N
 vC+5vAMjfodXnCECOiiNP6+1u/fjzUZMui56zQTC+bEGeHaFJELljLS+M5sNm3AazVi2U1Fd+Sc
 4eooJZlTu+GctSx7n65cXQ2UP2USnjg=
X-Received: by 2002:a05:6214:d63:b0:6dd:be26:50ba with SMTP id
 6a1803df08f44-6e1b21d4775mr472168246d6.21.1737735158714; 
 Fri, 24 Jan 2025 08:12:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkedu4M4bSFyiRgJDvmyb6kS6QCNU3PVd61/eGKd58HzLgZACf+QknYf4i4z86MzQZZnxlEg==
X-Received: by 2002:a05:6214:d63:b0:6dd:be26:50ba with SMTP id
 6a1803df08f44-6e1b21d4775mr472167866d6.21.1737735158385; 
 Fri, 24 Jan 2025 08:12:38 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c236csm9808906d6.104.2025.01.24.08.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:12:37 -0800 (PST)
Date: Fri, 24 Jan 2025 11:12:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z5O784_wnrBMrV6X@x1n>
References: <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com>
 <Z46W7Ltk-CWjmCEj@x1n>
 <8e144c26-b1f4-4156-b959-93dc19ab2984@intel.com>
 <Z4_MvGSq2B4zptGB@x1n>
 <c5148428-9ebe-4659-953c-6c9d0eea1051@intel.com>
 <9d4df308-2dfd-4fa0-a19b-ccbbce13a2fc@intel.com>
 <b11f240d-ff8c-4c83-9b33-5e556cde0bce@amd.com>
 <d54f6f53-3d11-477e-8849-cc3d28a201db@intel.com>
 <2115c769-144c-4254-94b0-6b38b7afc6fc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2115c769-144c-4254-94b0-6b38b7afc6fc@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 24, 2025 at 04:56:50PM +1100, Alexey Kardashevskiy wrote:
> > Now, I assume Peter's real question is, if we can copy the vBIOS to a
> > private region and no need to create a specific guest_memfd-backed
> > memory region for it?

Yes.

> 
> I guess we can copy it but we have pc.bios and pc.rom in own memory regions
> for some reason even for legacy non-secure VMs, for ages, so it has little
> or nothing to do with whether vBIOS is in private or shared memory. Thanks,

My previous question is whether they are required to be converted to be
guest-memfd backed memory regions, irrelevant of whether they're separate
or not.

I think I found some answers in the commit logs here (it isn't hiding too
deep; I could have tried when asking):

===8<===
commit fc7a69e177e4ba26d11fcf47b853f85115b35a11
Author: Michael Roth <michael.roth@amd.com>
Date:   Thu May 30 06:16:40 2024 -0500

    hw/i386: Add support for loading BIOS using guest_memfd
    
    When guest_memfd is enabled, the BIOS is generally part of the initial
    encrypted guest image and will be accessed as private guest memory. Add
    the necessary changes to set up the associated RAM region with a
    guest_memfd backend to allow for this.
    
    Current support centers around using -bios to load the BIOS data.
    Support for loading the BIOS via pflash requires additional enablement
    since those interfaces rely on the use of ROM memory regions which make
    use of the KVM_MEM_READONLY memslot flag, which is not supported for
    guest_memfd-backed memslots.

commit 413a67450750e0459efeffc3db3ba9759c3e381c
Author: Michael Roth <michael.roth@amd.com>
Date:   Thu May 30 06:16:39 2024 -0500

    hw/i386/sev: Use guest_memfd for legacy ROMs
    
    Current SNP guest kernels will attempt to access these regions with
    with C-bit set, so guest_memfd is needed to handle that. Otherwise,
    kvm_convert_memory() will fail when the guest kernel tries to access it
    and QEMU attempts to call KVM_SET_MEMORY_ATTRIBUTES to set these ranges
    to private.
    
    Whether guests should actually try to access ROM regions in this way (or
    need to deal with legacy ROM regions at all), is a separate issue to be
    addressed on kernel side, but current SNP guest kernels will exhibit
    this behavior and so this handling is needed to allow QEMU to continue
    running existing SNP guest kernels.
===8<===

So IIUC the CoCo VMs will assume they're somehow convertable memories or
they'll stop working I assume, at least on some existing hardwares.

Thanks,

-- 
Peter Xu


