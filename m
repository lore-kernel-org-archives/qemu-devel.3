Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81584C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufI7F-0002IU-RN; Fri, 25 Jul 2025 09:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ufI6a-000235-Kf
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ufI6W-0002AP-MF
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753448691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rXv7ljS6fBwMJjWVp/7G4PMXujANEoFQlwvqiTh1lFQ=;
 b=cavME9CR6Uw8D+NPN5H2UfY9ESGO9hwvC4vNGsXeGTup6uP0Vywfub7axYBhh7B+qUqhsU
 5E9TidJY3p2RVVBCINmL+FFI6t5ifLAoJAOCeP65WsD+BHCtchjpGRVoikbeWEzv0qiSGZ
 rKT39sldAOJK512f2uWGftaix3Ll0/M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-GKG8VoaUN8mIcTnUJ9rbLA-1; Fri, 25 Jul 2025 09:04:49 -0400
X-MC-Unique: GKG8VoaUN8mIcTnUJ9rbLA-1
X-Mimecast-MFC-AGG-ID: GKG8VoaUN8mIcTnUJ9rbLA_1753448688
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b7778eb1baso307161f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 06:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448688; x=1754053488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXv7ljS6fBwMJjWVp/7G4PMXujANEoFQlwvqiTh1lFQ=;
 b=X38rI8gsjCShKZ3Jm78LPoSvzC3SLUOdb3PCMqUCgGL8BpmFwfTa9xikZI5NoWydrO
 nwcfVodgHaNPXx5zAT1Y7/ZM7KJ42cccjraYzNpA+QRhfQ9DInw+cVyN0pPKxYqrt/eR
 KCARI5Hd87Sz1xVbRqu5cnz7/xONXMRkRHyAIGNqWznGu1mS4vppPu3KR2Vcq6EUOLII
 9T11O5IdAwczvty2t+dpHNON5IuGSztPULqtOeIgtHB2o+AK88PRJVgqt4OBFyh21y++
 jgAtI65KcFNpWZt79xDIaxl++Zz0Br9/1F3lmsw2qTtHhIs4AC7COFtPs36EuexhZ0bi
 KXmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3SaDfefE7bmO1u6LhLH3GYnb2BcA4o8iq8vpZ907uqPjZsBHo83l4Ui+MyM+QCTG5Ykm/m3BQwlC2@nongnu.org
X-Gm-Message-State: AOJu0YyGizD1y2NzUUisU/FqYevzMAAaypVEJVni88Jv4S7kccsvgTfl
 2koG/J1sskH4Pxt4AcseHXCKkc1/LU2D65HFGzCO0WAIPG6IXXVgwLiRryfvFcTyR6SVex2y/2z
 VsqvI5JM46KlsxBhXqjDDgZ1oZi8jVAQ7VDaR+vO180yFboKzdHd1xCWp
X-Gm-Gg: ASbGncv+B5eqz+Jz7sj5saJFOxAEs+eAJ70FyGX2BTYRBxUm7IvmNb7Chwr+jp8WPiq
 RADNAN73lTeIP91WMd+VDrYq2y+Y3hCLi7zT4HZwFiCykCjriaAK8S0obAJEE+KNM/4xqrqY3m8
 ljHiBGZs/PLk894YOYEyxUc5rZ2Cl/zjsmzNMF/3OpkVJn22eGRt6xL4/M3AktnEAMZ3OEiBlwG
 mElk1fIx+zzsOHQNI3OPZr1/82vesnyhMgDX5U0huvoM//HYRejFdA2FE0lSZ5KG9tm+DGIhniZ
 SbbDUjd+ctSzV8XBS/Zqv69KEUomfOx3mQ==
X-Received: by 2002:a05:6000:420f:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3b776728f92mr1751323f8f.14.1753448687715; 
 Fri, 25 Jul 2025 06:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPeRVwDpurmBCYcgZoQWkL9IEIku9ggOvmQUTcs47M5QXF83Z97lXXsk2OVDOIiGdLUB6m3Q==
X-Received: by 2002:a05:6000:420f:b0:3a4:ed10:c14 with SMTP id
 ffacd0b85a97d-3b776728f92mr1751277f8f.14.1753448687190; 
 Fri, 25 Jul 2025 06:04:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586f88cfe3sm36580025e9.0.2025.07.25.06.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 06:04:46 -0700 (PDT)
Date: Fri, 25 Jul 2025 09:04:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Corentin BAYET <corentin.bayet@reversetactics.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] pcie_sriov: Fix configuration and state synchronization
Message-ID: <20250725090436-mutt-send-email-mst@kernel.org>
References: <20250713-wmask-v1-1-4c744cdb32c0@rsg.ci.i.u-tokyo.ac.jp>
 <05448f8b-cbcc-45b9-8ab8-a989dec50291@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05448f8b-cbcc-45b9-8ab8-a989dec50291@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 25, 2025 at 02:27:59PM +0300, Michael Tokarev wrote:
> On 13.07.2025 12:27, Akihiko Odaki wrote:
> > Fix issues in PCIe SR-IOV configuration register handling that caused
> > inconsistent internal state due to improper write mask handling and
> > incorrect migration behavior.
> > 
> > Two main problems were identified:
> > 
> > 1. VF Enable bit write mask handling:
> >     pcie_sriov_config_write() incorrectly assumed that its val parameter
> >     was already masked, causing it to ignore the actual write mask.
> >     This led to the VF Enable bit being processed even when masked,
> >     resulting in incorrect VF registration/unregistration.
> > 
> > 2. Migration state inconsistency:
> >     pcie_sriov_pf_post_load() unconditionally called register_vfs()
> >     regardless of the VF Enable bit state, creating inconsistent
> >     internal state when VFs should not be enabled. Additionally,
> >     it failed to properly update the NumVFs write mask based on
> >     the current configuration.
> > 
> > Root cause analysis revealed that both functions relied on incorrect
> > special-case assumptions instead of properly reading and consuming
> > the actual configuration values. This change introduces a unified
> > consume_config() function that reads actual configuration values and
> > synchronize the internal state without special-case assumptions.
> > 
> > The solution only adds register read overhead in non-hot-path code
> > while ensuring correct SR-IOV state management across configuration
> > writes and migration scenarios.
> > 
> > Fixes: 5e7dd17e4348 ("pcie_sriov: Remove num_vfs from PCIESriovPF")
> > Fixes: f9efcd47110d ("pcie_sriov: Register VFs after migration")
> > Reported-by: Corentin BAYET <corentin.bayet@reversetactics.com>
> > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> This issue has been assigned two CVEs, CVE-2025-54566 and CVE-2025-54567.
> 
> Should we apply this fix for 10.1 and to stable-10.0 series too?
> 
> Thanks,
> 
> /mjt

sure


