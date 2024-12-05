Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A55E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEdm-0008RB-BX; Thu, 05 Dec 2024 11:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJEdj-0008Qp-QI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:23:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJEdi-0008V9-G4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733415820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8RNeggw0oESsgKE26h6qM+URKamgvJQEqGAvzp2iCSQ=;
 b=ICFAHcHMNOTNas0/5mnpkS/32DT2LwZJE2/FW2lSx8DWaZ4majMLjlwMeFL2dJZnXPb0Tb
 s9KrZsv1y/jHdfWFaNo30f6gDzvUfEZqGPJ9DRVJ8J+t4e/f0foXd8WC/gzRzpXnnLe//H
 O7Wd0Gj/bRR2O6Yq/xe0ob1LI2XvKvo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-8mDIX7xoMW2SY_tMwkjGow-1; Thu, 05 Dec 2024 11:23:30 -0500
X-MC-Unique: 8mDIX7xoMW2SY_tMwkjGow-1
X-Mimecast-MFC-AGG-ID: 8mDIX7xoMW2SY_tMwkjGow
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7bdd00353so10094505ab.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 08:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733415808; x=1734020608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RNeggw0oESsgKE26h6qM+URKamgvJQEqGAvzp2iCSQ=;
 b=wcVKqOmei+6HthA+uCQaXO/7Sr1gvEL5nGFNU6kXE3hQIGene/ouG39FILzDQxGpX8
 yhDZqC1YWxvHZPgPw+c/P+9mu/ZECCC/7c74JWSD/J5YnR5EN9gm1YuBfdrEIYVHI2ev
 Wl3Lddto8jMZcA03vP99y8Huqd8oaUg5aEJW+m18AE3ZNsM8xrsTFs+VfHux3wxLkRdE
 wUPAg/WSzFVw7UnK10lJE4si3XjFKE1x3q5Rhseue9ljZ5tZDKPY2OIgxyZbk75ypo2H
 njswuk7x5d8XIPJbNxmBSgmBgSZi79dMMnorUGhCEQ/F2mr/VjG2ARXHrSblgW1M/L7t
 fYHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxb0BX1t/kpK6Jp5WrA4eAkQSLdZOTvA3mXeUS+ONCufKWQ6+T1PJ9CBp7tBWg/y/s33jwZFiD6Z7S@nongnu.org
X-Gm-Message-State: AOJu0Yz1y+ohJjyZk7Z2wPbqSkZLPoJG+VaadLRS09kvza1/Uhj24K3f
 DQQUSlzDTR4SmliYQs/m3TGaRcj9UJ26BwDYpN6m0Rf90C8C7fymMugn8myQrWl3MWRQI08CKhW
 U+8KNLreVOYLjBuag4mf9jUu2pwgCQ+xeK4vyNi7eOqZNm/vQ/zj6
X-Gm-Gg: ASbGnctGadGHZx7eEJlHgcDP22cNKo0+6lDmhnUfCvQ/RdEWKkpC7ACiBHWTS7yZzKS
 Tn5IxHJbDoy4VP1yD1nU/8UO0a1CIFghdO8V0ljaMTsOIIYtLNnWPmvR6Z0S9+BIrzMFyDb+IyI
 Nx5zqrtL8ISd1mBgC72lmf5o2c0iMv6Gt8y33wGcUhZuhhcN/1c+BiN+vBakoWbtgySo5DHNdep
 9SUKBNvDHvLW9J7AAGzXSCwqHPp9FUU4T7+PDMj6kd88on2aFC715GvDLwB7N0TBKgKtXlZ80/I
 FGKzNtDn+Ms=
X-Received: by 2002:a05:6e02:1a66:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3a7f9a35f8bmr117355905ab.1.1733415808635; 
 Thu, 05 Dec 2024 08:23:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv78HeXinft+gLMkx1uHyVL0awgeiBGT/LW+24za/QuQHofnfPmMEcHeR3/TB14M64zxvBqA==
X-Received: by 2002:a05:6e02:1a66:b0:3a7:6d14:cc29 with SMTP id
 e9e14a558f8ab-3a7f9a35f8bmr117355685ab.1.1733415808377; 
 Thu, 05 Dec 2024 08:23:28 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808dc639esm5139515ab.47.2024.12.05.08.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 08:23:27 -0800 (PST)
Date: Thu, 5 Dec 2024 11:23:25 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 12/24] migration/multifd: Add an explicit
 MultiFDSendData destructor
Message-ID: <Z1HTfeftOqKl294h@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <55c9769a2961d621f5843e04ce995e6c226b1432.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55c9769a2961d621f5843e04ce995e6c226b1432.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Sun, Nov 17, 2024 at 08:20:07PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This way if there are fields there that needs explicit disposal (like, for
> example, some attached buffers) they will be handled appropriately.
> 
> Add a related assert to multifd_set_payload_type() in order to make sure
> that this function is only used to fill a previously empty MultiFDSendData
> with some payload, not the other way around.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


