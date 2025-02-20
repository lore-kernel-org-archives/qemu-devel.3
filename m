Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BBAC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 14:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl7sm-0004KJ-UV; Thu, 20 Feb 2025 09:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl7sk-0004Jv-VF
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl7si-0003KF-Oy
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740063026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wnBy07z+c2TjKU15/+53Qrd3p22s0t56j9/E6y6sqTU=;
 b=M6WZMTjz+Jgp2qLku6mUkZJPujMaJKzfLYMBEQQBglX5i6LUoI5IvouaerdtoVMGmrh8rY
 HvjrDKTeN8PsL12cVNrWvqJar6KN1v9cxzK/V+Oal93zoNKzwmREj90BDesprj5Oi7RN9y
 i0fuxDZtrqS43oUsiRJoTLvVl1IQFj0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-FwTOZeVPNZSW21NA35-Srw-1; Thu, 20 Feb 2025 09:50:25 -0500
X-MC-Unique: FwTOZeVPNZSW21NA35-Srw-1
X-Mimecast-MFC-AGG-ID: FwTOZeVPNZSW21NA35-Srw_1740063024
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5ded4b4ff88so927410a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 06:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740063024; x=1740667824;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wnBy07z+c2TjKU15/+53Qrd3p22s0t56j9/E6y6sqTU=;
 b=Z5UdBaO67V9yF7b4XUWpeJ0WE57v3EBsrYuzVwWUYNTSceECjdhUfmJ+uPJ9GnIu9U
 TTscmKsCLCt6stHJGT/Gf6jQo/1hVRRCrmb6A8tLZN5a4eyxpncZBAzrxDx7z9euatZ1
 a258vYqAScXVkotPzauQnWhCtp3ruym3vZvXndFmgHkUh9Wl38x4IEp4OvPZpRenFx2m
 KDZHbbWsGkZYg0sa+LIOOLmLHmiEu/v0gHFObxYBOcZ/TDrzfVdCMIPi6laII7LUnAlv
 gLqOCt5HETzrAIt1BwwbJ02Eb71ku0nol4uD1N4k1XKmIK6qYLa5hIaLkUB2zMMUzIJj
 5CJg==
X-Gm-Message-State: AOJu0Yz7wPg3ulDR50WxveCU1GU5z5iZ3GicFgg9lKtG3oiowZQWGtRg
 /azPj3S7e1LBBw3SX2ysXuDvO2ze9dlabImedEqwcyL5cTbTwaT/9Hn05LCYZyJ2t/r6EsCtCho
 H7OkvGju/waZGb+Tvw9n67WDDSQvnDRaFkuAZM8PlYokVYzud86Ef
X-Gm-Gg: ASbGncty2JGsOcbCNgun422H8/hTmEdB5AegN+QYkdZsoXGAHiw2WAArlvcvgZP1iXF
 0hZAtFXP2nQhA5ZHmbU+5Kh7IqbnEvVkDhFQlbuX0jG/5MlxKS5TqhrMuzmh0OcqxYOMYIiUk13
 Yfto2ukrEgLRstUnQ1OSE/Tg/op2/a5y1W5p4nTSdyHdh28Jn6Y34jMaTJgA479KVnI+1yIHcdS
 N4+CczNek7+s5TH5HHO+IOb0bSx7HdELPWIUuDkZ4A9q4jRTv+sqic1ZKowy6XywvhIDQ==
X-Received: by 2002:a05:6402:3553:b0:5dc:8ed9:6bc3 with SMTP id
 4fb4d7f45d1cf-5e089d2fbfcmr6853054a12.26.1740063024038; 
 Thu, 20 Feb 2025 06:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6K8rAiBJ8F43qf1F1/x9x1glzXt/kJZtLNJA1p72f6cDqXAKlpklGwsXgqe2GaZGXQNNvNw==
X-Received: by 2002:a05:6402:3553:b0:5dc:8ed9:6bc3 with SMTP id
 4fb4d7f45d1cf-5e089d2fbfcmr6853027a12.26.1740063023567; 
 Thu, 20 Feb 2025 06:50:23 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e03aa0b1f7sm8899753a12.2.2025.02.20.06.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 06:50:22 -0800 (PST)
Date: Thu, 20 Feb 2025 09:50:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hendrik Wuethrich <whendrik@google.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net,
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, zhao1.liu@intel.com, xiaoyao.li@intel.com,
 peternewman@google.com
Subject: Re: [PATCH v5 0/8] mulate Intel RDT features needed to mount ResCtrl
 in Linux
Message-ID: <20250220094956-mutt-send-email-mst@kernel.org>
References: <20241213172645.2751696-1-whendrik@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241213172645.2751696-1-whendrik@google.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Dec 13, 2024 at 05:26:37PM +0000, Hendrik Wuethrich wrote:
> From: Hendrik Wüthrich <whendrik@google.com>
> 
> The aim of this patch series is to emulate Intel RDT features in order
> to make testing of the linux Resctrl subsystem possible with Qemu.
> 
> A branch with the patches applied can be found at:
> https://github.com/Gray-Colors/Intel_RDT_patches_applied/tree/rdt_v5
> 
> The changes made introduce the following features:



There was just my minor comment, are you going to post v6?

> * Feature enumeration for Intel RDT allocation.
> * Feature enumeration for Intel RDT monitoring.
> * Intel RDT monitoring system interface.
> * Intel RDT allocation system interface.
> 
> By adding these features, a barebones implementation most of the RDT
> state and MSRs is introduced, which can be enabled through qemu
> command line flags.
> The features missing for a faithful recreation of RDT are CDP and
> non-linear MBA throttle, as well as the possibility to configure
> various values through the command line, as some properties can be
> different across different machines. For increased ease of use, the
> correct features should be automatically enabled on machines that
> support RDT functionality.
> The missing features mentioned above will be implemented in the
> following order:
> 
> * Expand feature set for RDT allocation to include CDP and non-linear
>  MBA throttle
> * Allow for command line configuration of some values, such as the L3
>  CBM length
> * Automatically enable RDT on machines that officially support it.
> 
> Will NOT be implemented
> * Tests to simulate interaction with the host by the guest
> 
> Command line examples assuming entire patch series is applied (This
> requires a kernel with Resctrl enabled):
> 
> To emulate Intel RDT features:
> 
> Currently, it is necessary to force the RDT options on in qemu, as it is
> not automatically enabled for any machines. An example would be the
> following:
> -cpu Skylake-Server,+l3-cmt,+rdt-m,+rdt-a,+mba,+l3-cat,+l2-cat
> and
> -device rdt
> 
> Just enabling RDT in qemu won't really help, though. The following
> option allows resctrl in the kernel:
> - Kernel options: rdt=mbmlocal,mbmtotal,cmt,mba,l2cat,l3cat
> 
> To use Resctrl in the Qemu, please refer to:
> https://docs.kernel.org/arch/x86/resctrl.html
> 
> V4 -> V5
> - rebase
> - fix feature bit names to all be in hex
> 
> ‪Hendrik Wüthrich (8):
>   i386: Add Intel RDT device and State to config.
>   i386: Add init and realize functionality for RDT device.
>   i386: Add RDT functionality
>   i386: Add RDT device interface through MSRs
>   i386: Add CPUID enumeration for RDT
>   i386: Add RDT feature flags.
>   i386/cpu: Adjust CPUID level for RDT features
>   i386/cpu: Adjust level for RDT on full_cpuid_auto_level
> 
>  hw/i386/Kconfig                      |   4 +
>  hw/i386/meson.build                  |   1 +
>  hw/i386/rdt.c                        | 286 +++++++++++++++++++++++++++
>  include/hw/i386/rdt.h                |  76 +++++++
>  target/i386/cpu.c                    | 114 ++++++++++-
>  target/i386/cpu.h                    |  24 +++
>  target/i386/tcg/sysemu/misc_helper.c |  81 ++++++++
>  7 files changed, 584 insertions(+), 2 deletions(-)
>  create mode 100644 hw/i386/rdt.c
>  create mode 100644 include/hw/i386/rdt.h
> 
> -- 
> 2.47.1.613.gc27f4b7a9f-goog


