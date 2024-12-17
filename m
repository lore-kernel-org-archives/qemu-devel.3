Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C03E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 12:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNWtv-0005BJ-Vw; Tue, 17 Dec 2024 07:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tNWtp-0005Ar-ER
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:42:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tNWtl-0003OE-GF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734439307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9vsTGjpT995nBSScRodX+d95bnmCNkwLraykxKT7HPk=;
 b=WeLuSaPGOGKTZH6GxgLdl8i+F75hVcCuz0fj//KVrrxlIP7fe988cQF97JWdPZSt0Ln7gP
 FBQNhJOkTe5JWMtU7+/vM5jBG7kAqaJD8g2I8rtwRLPAhMdTpWH7O18Yir0NnP0ogoRHPP
 8x/tSXtV+fQDVNE7tq2Jo88VGuJuhJQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-wEv52gM6MAKCA2mpeFoOaQ-1; Tue, 17 Dec 2024 07:41:45 -0500
X-MC-Unique: wEv52gM6MAKCA2mpeFoOaQ-1
X-Mimecast-MFC-AGG-ID: wEv52gM6MAKCA2mpeFoOaQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e1339790so3093969f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 04:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734439304; x=1735044104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vsTGjpT995nBSScRodX+d95bnmCNkwLraykxKT7HPk=;
 b=Npy7N+lb4OqE+bqCt6xsiPzL8X4fFDVdxzWz/lxvQm9p/ukP610VmngLtS7Lb9pW81
 VvJAMHT2vHN5hTf6TZnmnElu8Oto40fEhd6NNET0UlD/Om2o6ErPRB63iXjbjIOfMn7p
 BkFDyFYcoeYt6ZDxG7eM3O+hrzCCmYN9Jy4JjCEYY8oLfokAii8YxgQ7ku6OSWN6rs8R
 usz9LoIJrjY467uHcTDTFXnsfVE5MiCtS55zHynQyyqakdpVruCxLb7J9JEQMIfaNEeY
 sOWUbDG/hq6xjUvi0YU1WnLJ3mEtqi+PuPq88G3LksLFA530fI/AUXFuZ/334bd24TeQ
 PFTQ==
X-Gm-Message-State: AOJu0Yy6jGLbRt8QIldKCumplUBQudDhDI640Dy/4Bb7735KIbOhm4kb
 ShchnjONx27z/S3I8QXofKDVWq/QLeqiiVFGCLXaLPaCLeFlLJvtikLNxY4UOKHn80z41K3nH/H
 77kfrnLwTzIcRIov2GWMqqSQT4DVkfKX+ZHFJ58/9uFC0S9WmgFvS
X-Gm-Gg: ASbGncsP8k/t1oc+UhLy8AIbkOqRkjT4rkWuJdX8ql1fR6LY5ov3lpdB/6WPuyDoc/8
 ICW5YqNAxqCN8yphf17F8laAcqEqpGwwQWN75jJyB14bq3CYTWkEHipptKN8u7pwlmdG8TlkXzd
 ct3oDKIdqA3quwjvIe1y6LZMV7jNnkFOgnuo5FM5r76fhGxuHzGB6Gggh9Hrfr3YXZwBfgBHezr
 +xwU6CthvkRfwjher7xdLXmRW5Qz5H8sAxvZ+3ZxpsY56JFA5g=
X-Received: by 2002:a05:6000:471b:b0:386:3835:9fff with SMTP id
 ffacd0b85a97d-3888e0c06c7mr15616917f8f.59.1734439304570; 
 Tue, 17 Dec 2024 04:41:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2x162+dU56dRRqFXnpTJkePC0pcIHkhRm9zsYVGWOqow2UoeQ9s/8QIrtggPa4n9USGM+ew==
X-Received: by 2002:a05:6000:471b:b0:386:3835:9fff with SMTP id
 ffacd0b85a97d-3888e0c06c7mr15616894f8f.59.1734439304270; 
 Tue, 17 Dec 2024 04:41:44 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ed:dd96:e5cc:8b38:146f:2e38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c804a297sm10974189f8f.67.2024.12.17.04.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 04:41:43 -0800 (PST)
Date: Tue, 17 Dec 2024 07:41:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 0/2] Convert the intel_iommu avocado test
Message-ID: <20241217074128-mutt-send-email-mst@kernel.org>
References: <20241217121550.141072-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217121550.141072-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Tue, Dec 17, 2024 at 01:15:48PM +0100, Thomas Huth wrote:
> The first patch introduces a helper function for retrieving the
> hostfwd ports from QEMU.
> We then use this helper function to run a HTTP server in the guest
> in the second patch to exercise the network of the guest.

Good stuff

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v3:
> - Use the new hostfwd helper function instead of trying to probe
>   for an unused port on the host
> - Use a constant for the guest port 8080
> 
> Thomas Huth (2):
>   tests/functional: Add a helper function for retrieving the hostfwd
>     port
>   tests/functional: Convert the intel_iommu avocado test
> 
>  MAINTAINERS                                   |   1 +
>  tests/functional/meson.build                  |   2 +
>  tests/functional/qemu_test/utils.py           |   7 +
>  tests/functional/test_info_usernet.py         |   8 +-
>  .../test_intel_iommu.py}                      | 191 +++++++++++-------
>  5 files changed, 135 insertions(+), 74 deletions(-)
>  rename tests/{avocado/intel_iommu.py => functional/test_intel_iommu.py} (26%)
>  mode change 100644 => 100755
> 
> -- 
> 2.47.1


