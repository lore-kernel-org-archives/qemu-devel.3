Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577A3C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 18:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7eUb-0000XY-QU; Wed, 23 Apr 2025 14:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1u7eUa-0000Wd-LX
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 14:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1u7eUY-0005wa-5l
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 14:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745431595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=myCDdcqniXC3srlIWAAe0gy7O8yWyWlg+CPTXt6oQUI=;
 b=IEjs1XQ+DkfeSQKqLTe/YMAm7LOzjgjlq32E4Sxypoq1ov5FwfhN9PF/tc+KAr0PYmpJ7j
 Ruj/Hr0pAODfe02UHJb/5B8VA7kg+YLj9XMg9qsGSZWNjpptOi4/V5sN0NQs0klKDPUB65
 HVwrPoeXw9LssrYclK+OAqvX5tcM4FQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-KIPUprxKNYCPDx-XfQZN0Q-1; Wed, 23 Apr 2025 14:06:33 -0400
X-MC-Unique: KIPUprxKNYCPDx-XfQZN0Q-1
X-Mimecast-MFC-AGG-ID: KIPUprxKNYCPDx-XfQZN0Q_1745431593
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4769a8d15afso1521221cf.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 11:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745431593; x=1746036393;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=myCDdcqniXC3srlIWAAe0gy7O8yWyWlg+CPTXt6oQUI=;
 b=iFMHG8Asizvgse7tPPGeB86cQKP2/i3z2KBoVFUpiA+UtnSqBMQ4UAVAd0RbdBP9nA
 Vyt/hrfd0WfUy+e0zV8ylmtQAVAhcLGIAh12d1I0ySEGL+xgmRNQf5bUh+ruUmATkgiZ
 u2hwwhzCmWaRa3WIKEfhH3eWnK5dYDJR02vwjymBCgnmAUsuoq2xhqAEDquRFTZ+hLbM
 9JILQbAVxku2DDo/vnkA0CKtKIkZ9QTZC/alOjS18uussjcw7oB0lX9J5M2ynWHC5bmi
 i8e1fRkAfPZRoNUSzxQG4xMEstwPFSobsLpiblLuvFKW9y5MWD4igLFK/tza7QfvjHpj
 K/AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOWZ+bmqoR8+r7JtJpE7uonOf+c1Wbh8hlyHPWvv2Qa/sfiahEky88MzfsIDb2reO2MCQZ+N82CFWS@nongnu.org
X-Gm-Message-State: AOJu0YyUDpXFzCGhZHx9zIpcp2aboPTDVnRkHD9NHhO9mY2NW4rRLvUV
 DIASEQG2Z/yYEzgSOA3hRBPgao+lmVq5l88+PnlftdXg1wcfBPLDDpDqhe4uqralMbeKj72SzOQ
 N0DIkDS8yEdrtlYFPxebEl5j2klxcXfPTdxAtiW9BU8xx2BaWuEaxC+9MXEaXL+2EEC3kl8UXjR
 1Ue7+Evl/00DHgkRWLdvsAy+5boKs=
X-Gm-Gg: ASbGncvwMcSlixiTKkXc+byF/twOpz4TNj/s53wJPhxUUtmfGmZKr47H6pw4BrlVz9g
 UYTLY3knsgcX+6D5R/8eoAay2sUh2rbtY81lV9HqPMVN1MYzAQWCI6JpoF5V1XCu2Xyll0Q==
X-Received: by 2002:ac8:7e89:0:b0:476:91a5:c832 with SMTP id
 d75a77b69052e-47e77ca9fbbmr2526291cf.32.1745431592852; 
 Wed, 23 Apr 2025 11:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYArIOfVgc3Ow8oA3HkIQHw262mp5pDAZw1DnyCRp2OIl7CK5M1FNAu14g7sb7KJA7bIDcC+caiD2UW+lY0Q4=
X-Received: by 2002:ac8:7e89:0:b0:476:91a5:c832 with SMTP id
 d75a77b69052e-47e77ca9fbbmr2525891cf.32.1745431592434; Wed, 23 Apr 2025
 11:06:32 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:06:31 -0400
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Apr 2025 14:06:31 -0400
From: Andrea Bolognani <abologna@redhat.com>
References: <20250417124839.1870494-1-dbarboza@ventanamicro.com>
 <20250417124839.1870494-8-dbarboza@ventanamicro.com>
 <20250423-7d7e348ed0ec6cadb1efe399@orel>
MIME-Version: 1.0
In-Reply-To: <20250423-7d7e348ed0ec6cadb1efe399@orel>
Date: Wed, 23 Apr 2025 14:06:31 -0400
X-Gm-Features: ATxdqUHC7WKWWSAaVnA1qrTj3VbEi455gE6LUEJ1xhAg_l3NTVRokwwmjiDaZUA
Message-ID: <CABJz62NKOzO=aE-fz9Ad2gxLnSNvU41xnfhOS0EKLim0SnYOtA@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/riscv/kvm: reset 'scounteren' with host val
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Apr 23, 2025 at 05:46:16PM +0200, Andrew Jones wrote:
> I would just drop this patch and make the default 'virt' cpu type 'max',
> then nobody will hit the issue.

FWIW virt-manager has recently started doing just that:

  https://github.com/virt-manager/virt-manager/pull/784

-- 
Andrea Bolognani / Red Hat / Virtualization


