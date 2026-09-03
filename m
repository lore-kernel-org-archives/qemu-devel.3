Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77562C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2E04-0001BO-9p; Thu, 03 Sep 2026 16:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2E02-00019i-Dc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2E00-0006T2-W1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788467127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D40itdkmE2M4b/IG0YC9wKXX9KzGOyzIFjzEABbd3pQ=;
 b=hiq/YphJu87OozhtjEP3oCDhkPnNGjFfyzogqs6LlOG4bi1Z0h4rYPxnWV2xi1G27v3oti
 jI0O2BCXQPLcDWjWKogQiUr6+GnGa1WocFUABE1jKYYgKx4ZIjddTlYoPUL6SdoVZ2vgeq
 j9jAkkBYf/Xj+eUwRTH0wn7EEY+qrkk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-qKJH135lP8aQqMb_7kIBLA-1; Thu, 03 Sep 2026 16:25:26 -0400
X-MC-Unique: qKJH135lP8aQqMb_7kIBLA-1
X-Mimecast-MFC-AGG-ID: qKJH135lP8aQqMb_7kIBLA_1788467126
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52fb6c7b680so5271571cf.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788467126; x=1789071926; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D40itdkmE2M4b/IG0YC9wKXX9KzGOyzIFjzEABbd3pQ=;
 b=H60ByS7er7q621AcCVIOSgyjViH8oaanSpj/g8YBybgJh0cN28wHqvOQKToxitHgtS
 8hd72BCB2ZoRfzGXt90mebGPzE+zqTQOCB66oAbExnF8gqGQdGYJqH+qyKkkky5SXLaR
 HxbxBy7bYlVpCthLPvn0hWbuk+syk+ursoeA/ja/NEJ2lMHd7ozsJAjb1p8iNAuVh7W6
 BnqKzJWK0j0J8OMGBsFGF8aeXP+GNPbGjG5Zdt3lO6VWbR8QEbBp4VGtctRS/LVo7R9h
 USe1uzH7X6CdqCT9wKsVybDAUQz7biv1E33YxWCXV2Dk3mEBEct9cCJbABkO1JxKJDex
 fd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788467126; x=1789071926;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D40itdkmE2M4b/IG0YC9wKXX9KzGOyzIFjzEABbd3pQ=;
 b=oS772aJcHENengU3cWMXOWuPerw8TUqhA1+VRAcYz4ZBNrkRGq9TSbMOS7msPruVQN
 XFw4aOorqqdijMFfBYfRbJJIjpUNcZsylWuXPISkl/s5itQCjJYfTjyxzcYLyp34upFH
 3l+/EhFqaOMGo94eyNbSg4T8OyoNV+t40xGVOEsd/XwTODBLpc35n2qtbQaN4e9AgRjl
 99jpVu4/Up14ik49pU3JgZ0xCie8VIUwRVNdYVjhHiQEazY/lZxaKFOLWS8Nwy2XfzuM
 dcLtAgwGJ1ADA58KTp/Rfqz56N6RMjcy6ONfhUz0+gMO6L1OixvgvNkl5glVomddtLP/
 QAlw==
X-Gm-Message-State: AFuF++mHuIdU7/+pqCNQbp7s/6DPPXgqXzLNgyY+5Pd5pez7yxBUTYn+
 jQusV1Psfo20zT11PRjtG7BgM2ujRDFm1R8naFlteqAkctsZSbQkOhesBRRFDuQQl/nHuUnuKpV
 YOeq6MWu+Xx1lkpRQkBouq0Efo8yh7DAv/ufRyJi4tc48ZAe9VdDySVeF
X-Gm-Gg: AYBFou2/cIpOmKNjFnkAxHcc8UYM1ydh00UC86qqH9DvDThYxn4ceL/dpRVekeyt49O
 3/8I7AHC5mOWCPqg8d3uei/WdeN5eoxQPKWC56Y7wTNgkEkuRWqImLHwKtYlOMtAD0r/pfGXdOy
 CyAQxsC7LlXpLfNqaCcC5K5OmHkAfNAI7k8qQS32E1R5QzRTpmz59GRbhreKyEQfMMK4a4Is1lI
 V2Ol5UiJiMrgxQHcHPEd3UbddHF6YbKh4/6Pxm1tAY8xG5oXfoSu7eMxr8EU6IoVk9gPgfu3qr8
 6jj7AwJQL+hFaVo2sT+zoOs6pJ2AMw8hZ2kzx3oZfv7inxL2RBoPwrQC++6YHfhvVvhT
X-Received: by 2002:a05:622a:1f95:b0:530:42e5:f3a8 with SMTP id
 d75a77b69052e-53054a0e122mr18050441cf.43.1788467125901; 
 Thu, 03 Sep 2026 13:25:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1f95:b0:530:42e5:f3a8 with SMTP id
 d75a77b69052e-53054a0e122mr18049881cf.43.1788467125340; 
 Thu, 03 Sep 2026 13:25:25 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5305418950fsm4908981cf.20.2026.09.03.13.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 13:25:24 -0700 (PDT)
Date: Thu, 3 Sep 2026 16:25:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/18] migration: Change HMP 'info migrate_parameters'
 output
Message-ID: <apnXqkice-225qVe@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 02, 2026 at 07:15:40PM -0300, Fabiano Rosas wrote:
> The output of 'info migrate_parameters' includes units of measurement
> for a few parameters. This is convenient for a user. It also requires
> every parameter to be individually listed in the
> hmp_migrate_set_parameter() function, which in turn requires the
> MigrationParameter (singular) enum to exist. While the latter is not
> bothersome at all, the former is.
> 
> From a development and maintenance perspective, having a list of
> parameters explicitly written in several parts of the code brings
> several annoyances: conflicts during rebase, multiple extra hits when
> grepping, requires contributors to search for every location a change
> needs to be mirrored to, etc.
> 
> Remove the units from the output so we can write this code in a more
> convenient way. The HMP output is not part of any ABI.
> 
> Also remove quotes from around the TLS options strings as this is
> inconsistent with all the other strings.
> 
> Change block-bitmap-mapping format to a single line. This requires
> updating one of the iotests to match.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

HMP info commands are less of a worry.  I think this is ok, but I didn't
check the block layer details.  From migration side:

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


