Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0EEC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 16:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjL5H-0000AT-4u; Wed, 28 Aug 2024 11:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL5E-00005Z-D0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL5D-0000nE-2s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724860781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=71DoOIDQNm+n77E4DnXTxeBJyi7vY+QlZn2l4I8ekqY=;
 b=HMdekNz8+d5Q6NPlJn09s8mMrcvg1iRY3WV6pJUxZWBIDcVM8LiUfvmDUTdDVn+9dM8Z+e
 80ue4Y9mFNFVUo64bOnnafiZRquTfhsjWVmqqsrTuaHXej1bi6E7FaAJ0qRS4U2Lc8zOKy
 HXDG8QdCEN3717F/lugD8GzsKjUWiI8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-woOSx252OrG_5i0nM8N_jA-1; Wed, 28 Aug 2024 11:59:40 -0400
X-MC-Unique: woOSx252OrG_5i0nM8N_jA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7094641d4c7so747284a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860779; x=1725465579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71DoOIDQNm+n77E4DnXTxeBJyi7vY+QlZn2l4I8ekqY=;
 b=wsnGnggqsvX5Q5hZyn8uDHtfRn3QQ3hJVZGEyM32gfS+hNjxNnYNw3Awk5FcPrhqS6
 2UT8cw3Pgg6L+scc83aO2x//64CUnsrTSRiOk+/buoZzvziiVM0cmaoj0YzD89Gt3OGM
 J1Wb7AZA5thI6FrJ1nuDjIVv1Sr08dSUN97NEFmv7jTj6F0P6TkDrGilN2S2LOQsXkF5
 ogqJ0zTtMMQLstM0+EbnWfCzIsTzsClrjrhh8JQdIJKgGmbts5GFqQuVrNLoDwnjOqfw
 NmLUgxgXY7O4SQ6n2K3Ep5OU8BIE+dkM8YP7NbkSRBNI5R+IqOdTTuNuIowz9M+o4GN2
 QO9w==
X-Gm-Message-State: AOJu0YzbA6miXuEe+yD9U3fcb02ghw48OQEi6eXlO0+AIybpIf1PyyJQ
 YXHtb6NfkyQisb96m/WGXTvIaBdbO5DI4zmnvbIA0K35oJtVcKZqYqOLcc9HqXz9KEyStpc5B5U
 WrBrMbHI7fxNzu/MoOjGryKtzKJJVo+or6TnLpKkv1CMIOU5jkQbY
X-Received: by 2002:a05:6830:4123:b0:703:6b11:33a4 with SMTP id
 46e09a7af769-70f5320eeacmr1044424a34.9.1724860779625; 
 Wed, 28 Aug 2024 08:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi5e82Wcl9pp6j4IcKroIqjy+F3SgS+F8JRGKV+AwLcLl+vKHXk4n+d5G7dtYm4ygor2RF3Q==
X-Received: by 2002:a05:6830:4123:b0:703:6b11:33a4 with SMTP id
 46e09a7af769-70f5320eeacmr1044419a34.9.1724860779223; 
 Wed, 28 Aug 2024 08:59:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70e03ab03dbsm2936453a34.31.2024.08.28.08.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 08:59:38 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:59:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 2/4] migration/multifd: Fix p->iov leak in
 multifd-uadk.c
Message-ID: <Zs9JaeQ2AZo1BCao@x1n>
References: <20240828145650.15879-1-farosas@suse.de>
 <20240828145650.15879-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828145650.15879-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 11:56:48AM -0300, Fabiano Rosas wrote:
> The send_cleanup() hook should free the p->iov that was allocated at
> send_setup(). This was missed because the UADK code is conditional on
> the presence of the accelerator, so it's not tested by default.
> 
> Fixes: 819dd20636 ("migration/multifd: Add UADK initialization")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Thanks.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


