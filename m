Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132CCC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whhgG-0002TT-Tu; Thu, 09 Jul 2026 01:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whhgD-0002TK-DH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whhg8-00029b-UB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783576327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmZzQdZWsgpJ6GxnyzeEPn6AOQ7U4yMp/pczXd1HTpk=;
 b=dcV2YHq2dGOrtoNaTbyiBOjvkAyQ9ELG/QnGaKE/4qVvkcBrMVcbqiP9hJTBSeBWiEHzxq
 Ox37xD3QCtvdcUV12VL8pEZnJKOI5Oelz0GQC1nl+GYUQ/zZ73Odn39tFvGdFbEhZCN7gQ
 QOfZawcyLS1frneZFf/AX3FXr7Rjpao=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-afZIPhiwNKW5iIpvd1HjwQ-1; Thu, 09 Jul 2026 01:52:05 -0400
X-MC-Unique: afZIPhiwNKW5iIpvd1HjwQ-1
X-Mimecast-MFC-AGG-ID: afZIPhiwNKW5iIpvd1HjwQ_1783576325
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493d742c668so12180445e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783576325; x=1784181125; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmZzQdZWsgpJ6GxnyzeEPn6AOQ7U4yMp/pczXd1HTpk=;
 b=GCKqcks0QgA37rhRF++kt1VA9XqAvrtp1HGUZrlOWttuuqcTnwo74vsTOSPRuLmomg
 CX1KvRcUP3WjXZjf6+tRayPT2RpLxh27Ybuk04oCyhib1c0lpGaipQT8ldavUVbpXNVU
 Z4fnFDE/O3puqX+W+VLJFn1HwzwE2DDO/f/XiGw6cy37qMghLl+luZZvzzGjpToD4TDM
 5dHWUl96OYSrdhF7TmhNVKbGUYO7RBXnd4653gNc7MgqjictS7pl3CJpNqFbFtJFrN4+
 GY0gwucmCOV7WsjDtTVzuDusWB3FQZ5wixo+dS2bnW/v6JFU3+Bko43XwUPAAXY1LwsG
 wP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783576325; x=1784181125;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KmZzQdZWsgpJ6GxnyzeEPn6AOQ7U4yMp/pczXd1HTpk=;
 b=KhGLKCiz5HpeiQ272SQvpgAGzWemlYb6QGZKDpKDl8cXgaYksk1OMIX9VpXzNAPE3q
 HcNP6NJJ6nFIHVeFCD8PwQjQ0AJ8hDDuIGxluNbOitGeO0qACjx/t7RM1VWMKdL1rhUi
 IlJlABPcVYe9ud+L1imFUd7+oN9bYCBAAHW6GTY6fMrj8iiFEAKXQJnCQ+ljdN52EC78
 403Dz8SBVgeBIjKv18HuZnYrJDW8jKE01h3hmCU8jgjATd8MYUeMER3AKfPmnkdiDZsx
 6qqX8Krgscelz1tXICgY0yqK/C4oJYJGvfv+R1TzJdG+810teyxDJWUWuWtpiIJdZbu8
 66ew==
X-Gm-Message-State: AOJu0YyLsjbKn/Bqcy+NPYDRDsYrS1QzQR3o1lIZGz/dOOdLrwAENV7q
 rvcHg6YjyEuq7vRfivicxrxW3hhiot8TG1beIgDiyWNEDzLx1bPFTqOaQyWzCY/qFELUTIjEE4t
 MnqC8mZQ9OQ9vaPJKscetrQ2lYNpFmRPJha8rsIDzDOnoo1E/+hPvnKuljIizY4pE
X-Gm-Gg: AfdE7cmtedpDCz7n1BZ6/bb9lEY5IzuCYrlxGMB4mdwBrFNmbqn2XjljeVXarvZdm8c
 uwaXJl9nJKMgZLFGR+h0gvcvscjrK2aEb6evW0Wu6R3NILwJ9QDr1MYpUx4LIj6hJFhdheKtJ70
 oIMKHovmGDHfcKS9l9eTgGUs+WKDCsn+uz3cSncaoBTGr2qWjc1s/kuVoDqls1bQHAL3KCbZTxe
 /Gj3J7WnBflq7Bn1iYycI6y8Hj6ZRLfb+CPAuJqOcPG+fljKZWu9q5y15R1IMDnwKivHeyktRlY
 m671Cn60UzB0/4Q9ymNbZxKq9vG7FfWA6W+EmSRcuAn8Sni5fRMHf4HYOuMIyzIIHhRzIyLYjhB
 MlvUo0DGq0uzuvE5jf2v82y9N+5TztBpJ
X-Received: by 2002:a05:600c:4e93:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-493e67f7c3emr49585855e9.0.1783576324638; 
 Wed, 08 Jul 2026 22:52:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4e93:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-493e67f7c3emr49585405e9.0.1783576324006; 
 Wed, 08 Jul 2026 22:52:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3b85sm58465005e9.2.2026.07.08.22.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 22:52:03 -0700 (PDT)
Date: Thu, 9 Jul 2026 01:52:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 4/4] docs: outline some guidelines for security
 classification
Message-ID: <20260709014834-mutt-send-email-mst@kernel.org>
References: <20260707175027.3029620-1-berrange@redhat.com>
 <20260707175027.3029620-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707175027.3029620-5-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It seems to work kinda unreliably here on my laptop. Likes killing firefox
for some reason. Using libvirt ... what am I doing wrong?

> +  As such, bugs which can lead to excessive/unbounded memory allocations
> +  will usually not be classified as security flaws, but should be
> +  fixed as hardening bugs.



