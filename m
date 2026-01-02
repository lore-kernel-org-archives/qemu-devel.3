Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C386FA3744
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 13:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbeuX-0000PF-3L; Fri, 02 Jan 2026 08:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vbeuN-0000Mp-9R
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 08:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vbeuK-00052b-HN
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 08:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767359370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iI7JxmvH2opy8CsTkOzFCEj4ACQ+3y6bKbtlk/M2Q7c=;
 b=gq7j0h2aeGKfOKx15DUuf8VxXF4Xi+cqIY8m/KpiVn6Pw1qqTJp6MZNr2osVS7uWqLvh2v
 94hVZJkyBTbZs5L/tmMXzfsnfxnh69MAi6UlGzAHb9BW80vKmIyFFVye0tKr4LRgVwWxIQ
 zhCoI5nQZGbSfRTiivJG8WOCfSJCm9A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-_SK-QRLPM_GWSX6s2dDGpA-1; Fri, 02 Jan 2026 08:09:27 -0500
X-MC-Unique: _SK-QRLPM_GWSX6s2dDGpA-1
X-Mimecast-MFC-AGG-ID: _SK-QRLPM_GWSX6s2dDGpA_1767359366
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b79ff60ed8eso1522403766b.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767359366; x=1767964166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iI7JxmvH2opy8CsTkOzFCEj4ACQ+3y6bKbtlk/M2Q7c=;
 b=V8mtLalT+MNKDDYJtMsvEcbFX7RqIYskbG+I9NqLUWFlpPo+OvyGwtUdm4KTWgmQNO
 4ZjAEkSDtWYtCLYCb8d8Ph6j42qhikYpH+l2YndUB7n3P7AHoXNfGlE+i/CGMY+1Irex
 lZR6iB3v+GjLDJvkJ1OoXLKSJTNIdPEI57+virDMWVwXtYWPcUG3BiteW+WyUHPwaCLM
 hrbCvotfLpKkIAGKEgfUYPYOXdJB5/AsaUbdOl3mi4uwJkFLyxSVcsr17MillkAEClIF
 CIrVCIKQTWVVPRiGNudTRiw3GCk+ZvA3Hq8f8sJMqWTaYS0ZaLjCHwv0BQ7ZcpMaU8RO
 Zzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767359366; x=1767964166;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iI7JxmvH2opy8CsTkOzFCEj4ACQ+3y6bKbtlk/M2Q7c=;
 b=EyFawniwb5PmPKN3h6Qk5SG/O2gOn1NXUY03aoLwoAxy1Z+4QHHUlaEWRLYja5UT8M
 JG447stFnEp3H/bwIzOKNQCNSPyhOXz5HSVUZvOZQNIvcHPF/d8jIHXgjlaHaPh8WWr/
 Ty2K1wBXgBgZZRU8J4ZFD+G78HjpBjaOCKYaPHiPrjzowZ8a96Wq3SxdorHr59VHr+ri
 DXg1tO/fnmzchS4NSEZN819n4Lt4oO8ISUlZGsfo9TbSi8fRpyyECPE2V4BjAon4Bmiv
 tKG30RW2IwdXwClkV7I0LQrPgCyw8nUIXlaaSfcErEb6XlVU1W4K45O5TxAT3ck6i+Er
 dr7Q==
X-Gm-Message-State: AOJu0YyupJRNvCp7wuYljAuNz6+icbDQpNb/oQVS+Hn3nqZoYwWJ+VXx
 hQ+w/O/hK3dH5KETiAkZu3omTVPmLztIPo6Rs+ELzrj9FPX44TkJsScBar5bwtlCo8lFmfl33FT
 bazisiPrydEpr4DJLUQ4Qq+ad8rHnmAOl+1VDqTFJavWFXB6fuCsKp+T0
X-Gm-Gg: AY/fxX5283G8ncA13uRp6Nrp5JLEcnqSYFGmRKlXnPFzAESkn11v/6/42hitsThM8TW
 auH2UfNjmI56gIax3W/5zgvmkXCWVWOw7Yrap1LOwR1VJa+HL9ftvtmIEIS/nHY3zcQwns2JxAL
 AURCjtQvHMu9nK+caL7YdJgrHqEXz9Jas0CfXxEWnQN24VoFXVci0P/KASCvlsa6euzuN1N22QB
 tpbzekO6PKUxqlO/SBBmxp/coPuJIy7q1slkUSw5Tp+cZmRsvbFLUmLJAOuNPwuBwi3euzv1fd6
 AQaIpRKuU/tINcjO+Iu2lYTLipUrbAbWzWmttOny7Wtj0lra/VVRX9sXFiAE/R3gOmScpw1bhOu
 UNceKNqCbn/uGvhUG3VjmZg==
X-Received: by 2002:a17:907:944d:b0:b83:51e0:120 with SMTP id
 a640c23a62f3a-b8351e005e2mr1859485066b.65.1767359365856; 
 Fri, 02 Jan 2026 05:09:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVx2v2dwu0fIzSvqndlwMz4UEgI5xmWAJWQkyrEO26qgF9MWsaKkBLaC1Sq3yurRK0AjpEcQ==
X-Received: by 2002:a17:907:944d:b0:b83:51e0:120 with SMTP id
 a640c23a62f3a-b8351e005e2mr1859482466b.65.1767359365450; 
 Fri, 02 Jan 2026 05:09:25 -0800 (PST)
Received: from imammedo-mac ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de1421sm4632545266b.41.2026.01.02.05.09.24
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 02 Jan 2026 05:09:25 -0800 (PST)
Date: Fri, 2 Jan 2026 14:09:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@redhat.com>,
 <jonathan.cameron@huawei.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <20260102140922.456f599e@imammedo-mac>
In-Reply-To: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
Organization: imammedo@redhat.com
X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21;
 x86_64-apple-darwin14.0.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 9 Dec 2025 17:38:40 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Hi all,
> 
> This is v4 of the SPM (Specific Purpose Memory) patch. Thank you Jonathan
> for the detailed review.
> 
> Changes in v4 (addressing Jonathan's feedback):
> - Added architecture check: spm=on now reports error on non-x86 machines
> - Simplified return logic in e820_update_entry_type() (return true/false directly)
> - Changed 4GB boundary spanning from warn_report to error_report + exit
> - Updated QAPI documentation to be architecture-agnostic (removed E820 reference)
> - Removed unnecessary comments
> 
> Use case:
> This feature allows passing EFI_MEMORY_SP (Specific Purpose Memory) from
> host to guest VM, useful for memory reserved for specific PCI devices
> (e.g., GPU memory via VFIO-PCI). The SPM memory appears as soft reserved
> to the guest and is managed by device drivers rather than the OS memory
> allocator.
> 
> Example usage:
>   -object memory-backend-ram,size=8G,id=m0
>   -object memory-backend-file,size=8G,id=m1,mem-path=/dev/dax0.0
>   -numa node,nodeid=0,memdev=m0
>   -numa node,nodeid=1,memdev=m1,spm=on

I'm still not fond of 'spm' toggle on numa node itself (even though on AMD hadware sunch memory has 1:1 mapping)
without device model in between.

Can we try following instead:
  * add 'spm' property to DIMM device and disable hotplug on it in such case
  * make E820 enumerate spm/not hotpluggble marked DIMMs.

That will let us later to have mixed memory on the node if such need arises without
breaking QEMU CLI.

> Please review. Thanks!
> 
> Best regards,
> Jerry Huang
> 


