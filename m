Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F815C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SBx-0001la-Hf; Thu, 17 Apr 2025 12:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u5SBu-0001l9-78
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u5SBs-0000F9-IU
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744907654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tp56kV1/qotqe0H8utwfEN1zE3FRKbIKazuRSjOxo1I=;
 b=LBPR6P8Ip4tZwUtSEEolnlcxFdFYeQ9z3tqidLKamKPlFvBuPeBHq36Dh+pZW9JkBfoYtB
 UfeH5i0YLTilKkkIYqfUpuc1XMr58GGOxxD0R+tJJopTevhg9rQTJ5T3+DoEP5G0hyHHYP
 oEsf42LvTgj7tvZ1g4wrBjR08VEIfCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447--ehYXT7TOb6o9DEa6f4jDw-1; Thu, 17 Apr 2025 12:34:10 -0400
X-MC-Unique: -ehYXT7TOb6o9DEa6f4jDw-1
X-Mimecast-MFC-AGG-ID: -ehYXT7TOb6o9DEa6f4jDw_1744907649
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso1002452f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744907648; x=1745512448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tp56kV1/qotqe0H8utwfEN1zE3FRKbIKazuRSjOxo1I=;
 b=gbmeLRFdTqAhP/OLLxVL7sbRSco6BI2XdFZQ8/YXJ4ae1nG0u9PjRr3l6pxZMlxJWb
 tnefvkZ4YSbniZB0pBKs6qA5/vW/DVl9yesYxrsdp8E2FC5BBx3Bbmcwlm+mFZ7g77S/
 6ZYz6dIv+j58nrAvoGl08ru4+OjvxjBRDuxeg/6IcFxEhraLRo3emWuwB3475fXetW/F
 aoq7t6oxCCtDHGBfvL1JtqL90QPPPrrgo5O40NiKDM1mQGaoWRPVwZ600sn30CAsABdO
 4LzCIOk+JzkhmReXZCu5WIJ12ApdGIchC2gEGcRaIR6dwzo5134xt2T4K1m1i6FyNp6q
 31eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm4duwD0FBvORO1ZmybBJIF0znpLG7Q1zdFOVVfD+XHXh7HjwIsiSGxqIrKjSBdGqWTvwI1wlyCriz@nongnu.org
X-Gm-Message-State: AOJu0YwPDQY2W3+B+sRDOmGUXWbNS8YIXItlSt+JUjJoHqPDmsxVRdaB
 zewf2XU//dUhBSMf4ii9ETj2gMKj+D3V7ddujPF9Gg92hFoxYpWWrhbQUsNSlr/2FGa9H8jTm41
 OqyoKGJH/KcljXlSG7LQVvqDdJxOeDe0xf1LMT6vNWfz5350fuhZ/Az/9Jvfl
X-Gm-Gg: ASbGncvd2rVaz+GWZOzpB2J1rVRAVDJhDQePNtO+pMys0sqNdDFOjSX6Fl5oT+mv0tR
 N9ebgJd4u/JyVYZm5mPw+RsQnGoCaFk5Z9J1gataHryJCEJbXirrXz8/eKaygZiXIOM64DMHxxJ
 TYg+/qxUjZIcfJG4EXd8fvIAy3XHS9TGREuOArkEW3T7vEVUra+ckkwM82GmC+R+FxO81txrpzL
 8fw6sJaxU+Bn4/GnrtmgMLcyJ+Fc//CYLDnLzPAAd26uUn8gW5Jl44ObBxLjMcCc8q9w+I3XB9V
 qt/u7Q==
X-Received: by 2002:a5d:64c2:0:b0:38d:e0a9:7e5e with SMTP id
 ffacd0b85a97d-39ef89b5dabmr544611f8f.6.1744907648398; 
 Thu, 17 Apr 2025 09:34:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs42FQaJSvr8aBRAKPHbBUlpnB98Gq7WNZ/zZi9NxjQ45jd1qwh3pHwfh6IrXZqiesqogTeg==
X-Received: by 2002:a5d:64c2:0:b0:38d:e0a9:7e5e with SMTP id
 ffacd0b85a97d-39ef89b5dabmr544589f8f.6.1744907648028; 
 Thu, 17 Apr 2025 09:34:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa493255sm58922f8f.69.2025.04.17.09.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 09:34:07 -0700 (PDT)
Date: Thu, 17 Apr 2025 12:34:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 Wei.Huang2@amd.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH 03/18] amd_iommu: Add support for IOMMU notifier
Message-ID: <20250417123305-mutt-send-email-mst@kernel.org>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-4-alejandro.j.jimenez@oracle.com>
 <d4c11455-f28f-4052-9042-5d2c2ed9329d@amd.com>
 <f14bf894-0c95-4bcf-8a7c-25dfa7ebe76d@oracle.com>
 <ce1ae384-ab88-4de5-af14-9479394b9182@amd.com>
 <8245dc10-4dff-4a89-b4e4-dad5025544fa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8245dc10-4dff-4a89-b4e4-dad5025544fa@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Apr 17, 2025 at 12:21:57PM -0400, Alejandro Jimenez wrote:
> > guest boots with iommu.passthrough=0
> 
> is already broken today if you are using the AMD vIOMMU with VFIO devices.
> We cannot stop guests from doing invalid things if they choose to do so.

Yea no need for an "unbreak things" flag - just unbreak them.

-- 
MST


