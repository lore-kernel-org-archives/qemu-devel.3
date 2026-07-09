Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD20C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whhDS-0002U1-H8; Thu, 09 Jul 2026 01:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whhDQ-0002Tr-Q3
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:22:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whhDN-00089d-Vn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783574544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3n9ikShtEzWEbFkrvqUTgn8Xp4iwYRJupc/DFE55Ehk=;
 b=gSsMMNNPWe8dmKix31QSvSrY2b6EcmdbTv+4C4OqxJxHiGAM0Q8fI4ljwAz6kbt2yNkTe6
 zjF7t6qKrJvEWgzLTLx4oVDpcr10Xs9WZA/bXsgZRwG/I6SE1OReqf3Y1a1n506VJyzdO4
 gyiKfU6h2oVUGY8fJsY1uTJzsNtz8Vc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-eEsW_Bb-Pxy2LGHjJV55ng-1; Thu, 09 Jul 2026 01:22:22 -0400
X-MC-Unique: eEsW_Bb-Pxy2LGHjJV55ng-1
X-Mimecast-MFC-AGG-ID: eEsW_Bb-Pxy2LGHjJV55ng_1783574541
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bdf90adaso10335785e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783574541; x=1784179341; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3n9ikShtEzWEbFkrvqUTgn8Xp4iwYRJupc/DFE55Ehk=;
 b=l+Q1N3sduYciCVspM+aldLY6+JIPdRUBHtP6R8RWsxm7SIe02UigbCUxtwwlf0ryUh
 m8lElW5dfckTUHBgpOgNEWeRFecSDhtWOtqF1/l1dJ01oy3PUPGN9OLJi8bxUlFeL804
 1HZcxbioEKOK8BwZwdLfcWspHnGQNx/OO89O317FURhwXNzV5vQ5SdjIG91ER+O2rXvP
 tbkIOb8B0J65Bq1HYJ5C1u2483zJRDzltc5yeY/eITL21/n3C8HLbWb5Z5T0Sz1B9irD
 4eXC5bNTIqojqj7CCpXc6bsCpA6XBxdzW7n45Vd68fFJgQg4KvUWyvREw4i7uOn6EN3q
 K7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783574541; x=1784179341;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3n9ikShtEzWEbFkrvqUTgn8Xp4iwYRJupc/DFE55Ehk=;
 b=UrEQHnARFlH946i2ds111CsJxRjBb7KUnVBWv3dccPvESGNuqwXrp/bEi+BpAhpB81
 8sdtQoVOwk+eGgSQjyhLcgJ6V4xIgRdOzI6WzErdyV6BeFTvHv0LPkESJugxx+utuTJI
 B3F2swa0EveqP2YT4VpZwT8pNgLRfkyuCV/tsS+eoX8KpRjhGRENTkw1LIpltelZVHD3
 +BHzKpXoE7dJ/8xXM1yd1Hmp/xz9KjwwRYDcIj7qdPQm4aGN75Hpi/wKFLaS1nNzBLgu
 yTr1TFO+hSs4cI8C+VF8r3dFXVELzMD9DgTvuJaIOVIg3xaWlpVe9KWkq1nBo6LihChV
 HN6g==
X-Gm-Message-State: AOJu0YzJ51Hlgm7ehUvrqLWLB4Yj8GR36VjT2qw9BQvp2kuLeW0dmgkG
 SSdvuZf+v71WukVqqXMAR398kgF3C0cQYEeXqnbm7OBcaArjTSGUmyqTBsmmQe20E1KqMHD7tkg
 /4loaKNwPQATsXSNa7Bfe4/UT1kqiTIqrffb+NF5AuYYd7WVe1EaEtLFT
X-Gm-Gg: AfdE7cmSQzPsAaPGTAjRTU/balYtJHujja4ZrM9Ojs7X1RNj/KcbeDOrW94tWmaG72A
 nOGrzjbIzfADAxbCg6mKUaPYUOotYEfcRdFfZYFbiQJLOX0I0tv2kSeOetyVbJYytsWp9q/kYt8
 c/xRWNlsSJNwA0XMK1P5lJLVB/h440+fKU3fNEf+TD8KTjXj7jkjKNjZUljipmEfLYOXrqiopKl
 Oh63QDMFMqioJnxm4xcOfHh2rp6ndQziwSvwNz6QR6VcvIFyxoC9x7oTwjIZKFPpeotEZyktdCL
 0PUx6SvKCDratv3ShzqwbcgKIa/qIDfCIus+6mu82MmqWY3RpFxyyLb9ukPOGXOZKI8aWsrMH9L
 3/MZpnnpBpjVNlWR1XJClf7MlfI/jPOqd
X-Received: by 2002:a05:600c:6297:b0:493:ee2b:c8c7 with SMTP id
 5b1f17b1804b1-493ee2bcb92mr1019555e9.4.1783574541167; 
 Wed, 08 Jul 2026 22:22:21 -0700 (PDT)
X-Received: by 2002:a05:600c:6297:b0:493:ee2b:c8c7 with SMTP id
 5b1f17b1804b1-493ee2bcb92mr1019305e9.4.1783574540617; 
 Wed, 08 Jul 2026 22:22:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ff432sm30759635e9.4.2026.07.08.22.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 22:22:20 -0700 (PDT)
Date: Thu, 9 Jul 2026 01:22:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [PULL 4/4] docs: outline some guidelines for security
 classification
Message-ID: <20260709012044-mutt-send-email-mst@kernel.org>
References: <20260707175027.3029620-1-berrange@redhat.com>
 <20260707175027.3029620-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707175027.3029620-5-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 07, 2026 at 06:50:27PM +0100, Daniel P. Berrangé wrote:
> Beyond the overall virt/non-virt use case classification, there are
> a number of scenarios which we have decided will not be treated as
> security issues. Start to document some of these to give consistency
> in our treatment of incoming disclosures.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/system/security.rst | 63 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index 53992048e6..52bbf0cc7a 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -75,6 +75,69 @@ Bugs affecting the non-virtualization use case are not considered security
>  bugs at this time.  Users with non-virtualization use cases must not rely on
>  QEMU to provide guest isolation or any security guarantees.
>  
> +Security boundary scope
> +'''''''''''''''''''''''
> +
> +Even where a flaw affects the virtualization use case described above,
> +not all scenarios will be considered in scope. The following guidelines
> +are used to evaluate whether to apply the full security process, or treat
> +an issue as a normal bug.
> +
> +* **assert** / **abort**. If triggering the code path requires kernel
> +  privileges (or root account access) in the guest, asserts/aborts in
> +  QEMU are a self inflicted denial of service. These will **not** be
> +  treated as security flaws, at most hardening bugs. If triggering the
> +  code path can be done by an unprivileged guest OS account, this
> +  **may** justify handling as a security bug.
> +
> +* **vhost-user/vfio-user backends**. The backend processes have
> +  shared memory regions co-mapped with the QEMU process. The intent
> +  of the process separation is operational resilience & flexibility
> +  and allowing for independent software suppliers. There is not
> +  considered to be security boundary between QEMU and the vhost-user
> +  & vfio-user backends. Thus flaws in the backends which can cause
> +  crashes / undesirable behaviour in QEMU will **not** be treated as
> +  security flaws, but should be fixed as hardening bugs.
> +
> +* **memory allocation bounds**. There are many ways in which a QEMU
> +  process can legitimately consume an amount of memory that is
> +  significantly larger than the assigned guest RAM. QEMU's worst
> +  case memory usage should be considered effectively unbounded. As
> +  such the QEMU deployment on the host should account for the
> +  possibility of large memory peaks and apply countermeasures to
> +  provide continuity of host operations. It is typical for the Linux
> +  OOM killer to reap the process triggering host memory overcommit
> +  in the case of exccessive usage, offering a degree of protection.
> +  As such, bugs which can lead to excessive/unbounded memory allocations
> +  will usually not be classified as security flaws, but should be
> +  fixed as hardening bugs.


however, this is treated as denial of service, see **assert** /
**abort** above: if the excessive/unbounded memory allocations can be
triggered by an unpriveledged guest application, this can be considered
a security flaw.

> +* **degraded guest behaviour**. There are a set of bugs which can
> +  lead guest hardware devices to misbehave. For example, a flawed
> +  virtual IOMMU operation may not offer the guest device isolation
> +  that would otherwise be expected. If a guest triggered exploit
> +  requires kernel privileges (or root account access), and leads
> +  to sub-optimal behaviour of the virtual device this is considered
> +  a self inflicted service degradation. These will **not** be
> +  treated as security flaws, at most hardening bugs. If triggering
> +  the code path can be done by an unprivileged guest OS account,
> +  this may justify handling as a security bug.
> +
> +* **nested virtualization**. The scope for nested virtualization
> +  is to prevent a level 2 guest from breaking out into a level
> +  1 guest. As noted above, a number of scenarios exclude security
> +  handling for flaws only exploitable by the guest kernel / root
> +  account with affect the guest's own service/availability. In the
> +  context of nested virtualization with PCI device assignment, it
> +  may may be possible for a level 2 guest kernel to trigger flaws
> +  that affect the level 0 QEMU process. While these bugs should be
> +  fixed, they will not be triaged as security flaws at this time.
> +
> +* **low severity impact**. As a catch all rule, issues which
> +  are judged to have a "low" severity impact on the system will
> +  usually not justify handling as security bugs, nor assignment
> +  of CVEs. They will be fixed as routine bugs when time allows.
> +
>  Architecture
>  ------------
>  
> -- 
> 2.55.0


