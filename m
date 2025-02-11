Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E705FC0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thu24-0003BP-3A; Tue, 11 Feb 2025 12:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu22-0003B3-N2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thu20-0006PJ-Qk
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739294801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NzuY0AHeMwyR44Oi55ps+jZ1lrBZ+FSzgdsy4mJBeng=;
 b=BKjreUI1FXRuqyOAVVMzubRJZJwcDcrlBlWwbs5KudlFUZCCOKfJjdC6lNlX3RvKIvOE54
 F1+0I8NRtnjFo/r9HeNkPNnNHTb4+5Sxzj3IqGoWnbYk7aGBxn9rgsrJ44nqWviIGA/1oL
 Im+jIXvcMmj9IChfJlwjAhHcKpH2SM4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-vSvSE3rLN1yP7bfu7M9ACw-1; Tue, 11 Feb 2025 12:26:39 -0500
X-MC-Unique: vSvSE3rLN1yP7bfu7M9ACw-1
X-Mimecast-MFC-AGG-ID: vSvSE3rLN1yP7bfu7M9ACw
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3f3bea95b3fso1416882b6e.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 09:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739294799; x=1739899599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzuY0AHeMwyR44Oi55ps+jZ1lrBZ+FSzgdsy4mJBeng=;
 b=CuyEGJLHiw8k65gfeIxiNRcjSSQWFy/wJ+Yay/Ek394KY1bAuQ0pKTxoZmNbemIWJS
 kL4SyJOFVuHhFLOPWEdLA1NQfZk5TdpIXQeuJXbwZWooUGyPt4aLTsNdTEVAuaulM8RG
 Ep9UBAdHNhOMbmBHG9cwl/9cKPg8lNVz7ZTlKC+6brwbiQY6ravf+OoprkMeWhae8xPj
 JsEWcL62cDLhNYFeKUxIsFc0li96uxOGb5hT4oLw3XWRnzuGOp6pgPIr7rlwqouh0+gZ
 Zun+3mlF0QIZKN3MeWJwOPrXpBiBbkV6LqPO+EzBlRpWESypn4xHyCIZNSYLTRnLGMQT
 IX+A==
X-Gm-Message-State: AOJu0Yxs1cDRbRmLy9/+Pe3BMgdUq6z2NDhrSDw2y+uNKVP7kDNA7Kpb
 yOuRdPkRxTpUH+MRcZIRZo6JI5jFE63MVOWyVWVu3HcIjvBuZDGhNeXKZJJiw9MwO6KF5zsMXmI
 FDBLqpY9BmGxQzrv2uIrfHGBpD2JCastfkFAEDDWkjXc+3fXoje1X
X-Gm-Gg: ASbGncslx8Vfffx99dl9kNkC9KZCpsykbO0T4+4NRuDfroFJfiieq6/JkKJ5CHWhtyZ
 FOvt5NJAUPhXmzQ7ORKvTDev0oSNTElIEcuvOCkuMWGTaSKKR4ThLlXhsqhN7v+sOVu82Ol1sax
 5mhM/TDtwTGp8ETX2N9OoiIB59dlzUcVKrA4i1IGrrHwKefZuDymCoKi/lSr4wnYUei6c8lQ7wP
 /W0lONtFQVo0xTgLb0xS78Eift+QSMV+PE0zGyTP46S6UfMNOZP9hKNd1A=
X-Received: by 2002:a05:6808:3384:b0:3e6:3878:3b9c with SMTP id
 5614622812f47-3f3cd56f9bbmr311909b6e.8.1739294798841; 
 Tue, 11 Feb 2025 09:26:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAMx/tRgeTQMPhYg2q5xwTFOB/aXDRz7I2ePb0lIWH5jBvsKzQ60CSBEnAahmIOUyGO2dhuA==
X-Received: by 2002:a05:6808:3384:b0:3e6:3878:3b9c with SMTP id
 5614622812f47-3f3cd56f9bbmr311892b6e.8.1739294798549; 
 Tue, 11 Feb 2025 09:26:38 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f389ed47fbsm3272531b6e.18.2025.02.11.09.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:26:37 -0800 (PST)
Date: Tue, 11 Feb 2025 12:26:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/9] migration: Set migration error outside of
 migrate_cancel
Message-ID: <Z6uISvSUH8tL_81z@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211150136.6781-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

On Tue, Feb 11, 2025 at 12:01:28PM -0300, Fabiano Rosas wrote:
> There's no point passing the error into migration cancel only for it
> to call migrate_set_error().
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


