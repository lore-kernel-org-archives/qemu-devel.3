Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2460D2CDFB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3HIZ-0004Lj-H1; Tue, 22 Oct 2024 11:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HIV-0004LU-FY
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HIS-0000dH-Ta
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729612786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPDvf4+CfIkk8D/qaXxb4BdrqY2Rc8Lqp2W80tVKAOw=;
 b=fmCs1pgDCMn4+n2vj2MgWO5ZK5EsycoBaFZvRHVgHSw7hKKU8MnUdkrlOAO6G1BYXuXQb7
 2Y3zkN/5TxHjN7vf9ZQ5DHG7G8qQbhyOxOaaGyoPNbu5AVDnsak/8nGqmxgj2yEzIP93ZD
 l55SfEEQmNrC0g6wS8advuNHHUrd3vg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ZVbUMPHhOly_AZrmADnzsQ-1; Tue, 22 Oct 2024 11:59:45 -0400
X-MC-Unique: ZVbUMPHhOly_AZrmADnzsQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6cbe4a123fdso88348606d6.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729612784; x=1730217584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPDvf4+CfIkk8D/qaXxb4BdrqY2Rc8Lqp2W80tVKAOw=;
 b=QAhHboQ2azxmsGxxO3QnhlDaUj2/NZr/7wEdr4EZiE2RWhJiLp96WxxYINrKfmyX4e
 1jqdk5dP2hKOd7qIZygNDrP2oLZzp/Jlk1MFn76ZUnIH98K/dFiy1LOzBBXsaAsPr1xk
 WgCXNBF0r7Ut7EdEn9ek2ir60UMPit+yb8/N0vKX3DOxQlomxE0jGws2nE0MlqHRwWB+
 z9Eg42DHd6nepgNlqjMLLwJLy5TmDxA7awCBdr51xUkwTVqYaMkY1rjab0gqLlMUPWmi
 DoF7yc1GXTRTyUAp9UHk9+Aaqt18woOZfaTiFLwgrAfEX+ezJFgkf0nhAO4KVfJOQucR
 T1/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOhQdnPcoY4ZNS7CxAdtLCubhDifc66MJFTdX96EoMhfqoXP9MTvHixyWhoVzzSw1LCd7g3xfTVXh4@nongnu.org
X-Gm-Message-State: AOJu0YyFabIOzXHfBq23vMWI0WA1PVxdC6bZrGrKwE/DDHVe+rUIF5yy
 DpPfEqb/3bS+VrOVqfpNApr06J+Jl/7Dv5dAV08zscME+kPEEqA/2ugFuA9VOR4Fyae2i2dTfbC
 J02EWebmjTLwj6pw6eBs415x8h++6T5MtrV/T3mgaBuOqatjPGH3/
X-Received: by 2002:a05:6214:3bc5:b0:6cb:c5f7:719 with SMTP id
 6a1803df08f44-6ce23e1d554mr39626976d6.27.1729612784728; 
 Tue, 22 Oct 2024 08:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkm8iKInFI9c+SusnQIovxIVPhn46eDwZlGP5xBmAn5wk2FmxZsjbe0TCZr3q9RoVHUV3ofg==
X-Received: by 2002:a05:6214:3bc5:b0:6cb:c5f7:719 with SMTP id
 6a1803df08f44-6ce23e1d554mr39626716d6.27.1729612784449; 
 Tue, 22 Oct 2024 08:59:44 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009fea30sm30260006d6.135.2024.10.22.08.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 08:59:44 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:59:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration/dirtyrate: Silence warning about strcpy()
 on OpenBSD
Message-ID: <ZxfL7lrntriKoVOX@x1n>
References: <20241022063402.184213-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022063402.184213-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Tue, Oct 22, 2024 at 08:34:02AM +0200, Thomas Huth wrote:
> The linker on OpenBSD complains:
> 
>  ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):
>  warning: strcpy() is almost always misused, please use strlcpy()
> 
> It's currently not a real problem in this case since both arrays
> have the same size (256 bytes). But just in case somebody changes
> the size of the source array in the future, let's better play safe
> and use g_strlcpy() here instead, with an additional check that the
> string has been copied as a whole.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Check the return value of g_strlcpy to avoid truncation of the string

queued, thanks.

-- 
Peter Xu


