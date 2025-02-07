Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5454C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgRcP-0000Fb-Kp; Fri, 07 Feb 2025 11:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgRcO-0000FK-Cq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:54:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgRcM-0004Qw-RK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738947254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJXeFnEzqoSV6B2sp8vrSeC5C1Yde3acfQJgATlGvqc=;
 b=ikCvQfFQgtW7BU4aac1NL6mBVs4f7fK3NaC2C0Ur+MVelRZM+2JrooK5o7Tx3iScjEBo/8
 x4B1QPcpY85SBC7OUC7ci1eHULYJeIaD9fROU6ze+RKx+FpYkjUc9Mm7CvXtEmPiizHm3j
 AMpAc4AhjYjGAqjd//WEhU1Xhnqu9xs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-5foGbhmGN8yzkQZBnmLN2w-1; Fri, 07 Feb 2025 11:54:12 -0500
X-MC-Unique: 5foGbhmGN8yzkQZBnmLN2w-1
X-Mimecast-MFC-AGG-ID: 5foGbhmGN8yzkQZBnmLN2w
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e44fa43bafso2875996d6.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738947252; x=1739552052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJXeFnEzqoSV6B2sp8vrSeC5C1Yde3acfQJgATlGvqc=;
 b=kEctRoB9ZEToZ06RuQSudSVpY6/B2njwp+O8lh6CdParYLYySRfdu19e3XQ5wJ6O3g
 Ka3MaorBLMCiizru8vpJ+0FJU725qA8z84puzM8cwMTX8Y1YXPFvuDeNjpGqb7f6ymc1
 ITCLNOTfZ5sZwh+ezhwwFeud5kj6cEdShwBj/ObenRj5e41CcmNO6XM9skQipA6JescM
 +twDYez0ZQ8yfX5mTiHdBLZ8QCSI+nE+54Pixo3paZbWu67iWISAuE9dIqGdT7SGxBJL
 RXHTAGjopTMdpoZSXlfNY5+kE5wu/Qhn+XSvUlVTCmoBSDCu6N8EwCZtQKxV+fmiWZmK
 MATA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfNqRbTep5WgcxNufsPQCaNur566d+jrL8OJo64Ksp1kA2VOHiyxpJjbXMlffOUR41k3kKHg4BUp0G@nongnu.org
X-Gm-Message-State: AOJu0YwgFVJdoA3fUnXVby8DkTufKejkpLnjUkAmhwn/IQlIhppjtwps
 4UbwGxD0SmeVRjo+WqivLB5ceLgUPI58JiKnraDNCV8AibJWPzgCuIWCXZmM+jmMoYBcAQfak8z
 +OHQdNccjCXSsrIJ78LKjH7oBuNwAkzF1LU6fggnEchL9T5SNNzNd
X-Gm-Gg: ASbGncu4x+1EuizNlz3iBAzWUkoVdMIi05s4svtYB1/tDMXILe8H1Ya3qw8jPZXY3Cr
 1LweE5rPONa0ZN3sfKmvNDl4qROuzWqXkUAznXHA5OJZaeMnYQDIM9IV7o40tEL1o0ClFaSyJfr
 Ju8gkM63U0dg5FgwmaZ+wwCtpzy9PY/+5mCQfYjBycGuFVw5h4dyeArYhQwuAPjHwraAcWMb4sW
 Dqn7VhqmciMTELil4TCCsKaykP4EzGJ8GbBrQ/nVJ3liUs7RjODJ8RQCM3kOqQ7RKU+TSwYAsLW
 ecsVCw0QNnJ5ttvWrJ4BsWD4xjbnZ4lkvo5mmSWp7XkS/ZNv
X-Received: by 2002:a05:6214:1d24:b0:6d8:9c92:6555 with SMTP id
 6a1803df08f44-6e4456fea73mr53485796d6.29.1738947252103; 
 Fri, 07 Feb 2025 08:54:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnZ/7Bz6/MPYjtfM/i8M0A9RiBvRsFqmnKYEH92iOgVoBBP5We41Nf1wNQ2ViWPvtISsfG2A==
X-Received: by 2002:a05:6214:1d24:b0:6d8:9c92:6555 with SMTP id
 6a1803df08f44-6e4456fea73mr53485486d6.29.1738947251796; 
 Fri, 07 Feb 2025 08:54:11 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e44eb52460sm2915526d6.8.2025.02.07.08.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 08:54:11 -0800 (PST)
Date: Fri, 7 Feb 2025 11:54:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com,
 imammedo@redhat.com, alex.williamson@redhat.com, clg@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
Message-ID: <Z6Y6sf064FBWT5G1@x1.local>
References: <20250206142307.921070-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206142307.921070-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
> This is a follow-up of Peter's attempt to fix the fact that
> vIOMMUs are likely to be reset before the device they protect:
> 
> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
> https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
> 
> This is especially observed with virtio devices when a qmp system_reset
> command is sent but also with VFIO devices.
> 
> This series puts the vIOMMU reset in the 3-phase exit callback.
> 
> This scheme was tested successful with virtio-devices and some
> VFIO devices. Nevertheless not all the topologies have been
> tested yet.

Eric,

It's great to know that we seem to be able to fix everything in such small
changeset!

I would like to double check two things with you here:

  - For VFIO's reset hook, looks like we have landed more changes so that
    vfio's reset function is now a TYPE_LEGACY_RESET, and it always do the
    reset during "hold" phase only (via legacy_reset_hold()).  That part
    will make sure vIOMMU (if switching to exit()-only reset) will order
    properly with VFIO.  Is my understanding correct here?

  - Is it possible if some PCIe devices that will provide its own
    phase.exit(), would it matter on the order of PCIe device's
    phase.exit() and vIOMMU's phase.exit() (if vIOMMUs switch to use
    exit()-only approach like this one)?

PS: it would be great to attach such information in either cover letter or
commit message.  But definitely not a request to repost the patchset, if
Michael would have Message-ID when merge that'll be far enough to help
anyone find this discussion again.

Thanks!

-- 
Peter Xu


