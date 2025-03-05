Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992ABC282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprVe-00008H-R6; Wed, 05 Mar 2025 11:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tprVd-00007z-SV
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tprVc-00017n-BY
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741191730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6wBwkAtifNAodq85dur72m5NAtGlaa79Y3PIM3WJOKY=;
 b=R/uTul3U1LelA1H5MeWtYbKRy4XSxo1FuKLKxq9pk9/RQFtcyFTAgC1sitOx9DmB/m6svS
 a9d3VtQgyJTN24vpi9OrriWlKyDWdRCFPJUIv7ZbeU2MbZjKHsvDV5lt9su4+2iHXsxXuT
 usOpMU3uF35UDkdf3cjctXHhj48KSM8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-0HBQByROM3OMlgmFxwK4Yg-1; Wed, 05 Mar 2025 11:22:07 -0500
X-MC-Unique: 0HBQByROM3OMlgmFxwK4Yg-1
X-Mimecast-MFC-AGG-ID: 0HBQByROM3OMlgmFxwK4Yg_1741191727
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4750717a643so32342911cf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741191727; x=1741796527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wBwkAtifNAodq85dur72m5NAtGlaa79Y3PIM3WJOKY=;
 b=dPEuGbZf6JDLgcFVgDoChJrUa9dulewnAiTKYlqJZl7sTXh9NzPus9MDaWkyyfUbhB
 HsRxH1m1Up8ESXjP5ckfvCqdkjHu1/7ecr8xQHRKz+T/uD18usvQlLSBmR0nHSbXKxR0
 j/IwmzAknJD0+4/+lFbyYVVy3Fq+nSGGYx5nTLotwhkJxXLFBntYWd/dPe/+lvNYlR2Q
 /R33HzBdoCu0VfEhwfwRyJeNMrwYtNdbOi+Z4VACeHqJSWmV19iB0ruZTVC0lveTHkmK
 srNzYW8vFgIWs74lreCdq4SIzw5Vek4Euh8AdKgkc1T2rHZ/6WgYMLs/ghWHqW4PNMG7
 hZZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkl7cnIkyVwCbj2XLFxfXroYi7NAHWaJEBEKP11X9dGhmR6IH/Wu0NmD9/nnDK3fM80mxIX1Erj2JN@nongnu.org
X-Gm-Message-State: AOJu0YyhnAEqQQre4xvxhrT0I+d6gHvBijWYvSc/JJvIcq9kR21WJPur
 HsuzavBt8SsS2nb6oqhWkXqiDAAbXDeMYtI1Pw95x4XuerKPLujd6qOVhfNuJcgSWwTp9/7x3Ao
 nk8oRDmBlBD/hr2O1bjtVTaT5BTx0TEivaNlafxXHudeTZ2FG0mZG
X-Gm-Gg: ASbGncvjWjGogTgHwKrswjkHpuAk7+MfMXAf3PGMBk0YEbaatEKGi+afXBAawhez13y
 tr/7u2ZYohtXJy74ClJFxBTB8eTPamKXfjr+C9TzJyJxztJ4XwFVCVKTjHGgx/mjzWQUmlI7bK/
 rkbYG3mdVlBdcAHjS1YPY4BZdCdJLxsKh+aPg0E0CZHnC/3Pw3CNs8nGwSWmUxQ7fNZBWL05Zxf
 wzuH17h+kD+rPoK2fPEr9wRNqgpcYJgl8zq9bRUsilX7sbz1agcBg6PMTHDSi7QZ/FTnlSWb26T
 Rpd2uMk=
X-Received: by 2002:ac8:5fc3:0:b0:472:58b:463d with SMTP id
 d75a77b69052e-4750b23e2b5mr50797531cf.5.1741191727253; 
 Wed, 05 Mar 2025 08:22:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHVl6YEGSeBhZ/aVAs1boI2U1xjgFSbaRnFonB5St0c0f0Ks+VFNgHjfDFyAnzAvAMDPPo3Q==
X-Received: by 2002:ac8:5fc3:0:b0:472:58b:463d with SMTP id
 d75a77b69052e-4750b23e2b5mr50797161cf.5.1741191726936; 
 Wed, 05 Mar 2025 08:22:06 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-474ede93859sm40508941cf.50.2025.03.05.08.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 08:22:06 -0800 (PST)
Date: Wed, 5 Mar 2025 11:22:04 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 25/36] vfio/migration: Setup and cleanup multifd
 transfer in these general methods
Message-ID: <Z8h6LGGrw82RgA_Y@x1.local>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <b1f864a65fafd4fdab1f89230df52e46ae41f2ac.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1f864a65fafd4fdab1f89230df52e46ae41f2ac.1741124640.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 04, 2025 at 11:03:52PM +0100, Maciej S. Szmigiero wrote:
> @@ -509,6 +513,9 @@ static void vfio_save_cleanup(void *opaque)
>      Error *local_err = NULL;
>      int ret;
>  
> +    /* Currently a NOP, done for symmetry with load_cleanup() */
> +    vfio_multifd_cleanup(vbasedev);

So I just notice this when looking at the cleanup path.  It can be super
confusing to cleanup the load threads in save()..  IIUC we should drop it.

> +
>      /*
>       * Changing device state from STOP_COPY to STOP can take time. Do it here,
>       * after migration has completed, so it won't increase downtime.

-- 
Peter Xu


