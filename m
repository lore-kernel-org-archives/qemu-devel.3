Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8024E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 16:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJEVY-0003C1-1e; Thu, 05 Dec 2024 11:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJEVU-0003Al-97
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:15:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJEVS-0004Ph-08
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 11:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733415308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWjS+8WlmLRyynLUFD471rE5CcYj4AOU52EO30KFnR4=;
 b=RfXIxyHUZHdu7BqV0C5JP194YfVt3g7vAG7WzGL43Y1EZUwFGQKhmN9W7j7Va/yOq4AC6A
 /dnJs2ypNhXD3s9XI58SecykjQgmh9XZA/OL/RTfGx2gNAWuTCfyTcAxOS+22y9GeAUMGn
 l61ZMyjeTVt6Nj53fbAzOYUQvxZ5lXg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-uvEfO3TTNl25xqYpnvcPIg-1; Thu, 05 Dec 2024 11:15:07 -0500
X-MC-Unique: uvEfO3TTNl25xqYpnvcPIg-1
X-Mimecast-MFC-AGG-ID: uvEfO3TTNl25xqYpnvcPIg
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-843671e13c0so188937239f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 08:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733415306; x=1734020106;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oWjS+8WlmLRyynLUFD471rE5CcYj4AOU52EO30KFnR4=;
 b=uc6GookkyNtoRWCVRQ9fvSMdyo7XQQY1RcI6GVRuHwlodxGk9xnIOttBG3q6ZMBP6d
 vNCVIXwRpzQPumgIzC3CquHRQjCeMKvB+qWO1cQmbeYFKDsSJo+wqcf9joRPfuSsrmu7
 GT//eRdnqLccN9b8UFKZWjbSSPuLlnNhGq9dK3UOvFq3SSnlrEAn39w0R7pbTnCibTaz
 moKdHWpMXD9vJsmz23BjaHxW+78JpmWZqux83p0xJWFHS1FFjM4kS5cN7ZmTvahEy80f
 dNJE7Y5XtP3RCy2ILGB9WkTXbeMvxOGd3BIc1kFDPhk8vBoV9+WUBXpQLrAtikGvnKmP
 9jBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtLLQQ0MahvMc/BTeaXfy9bQ6rqkPZ3eXEwk1OwkMH52d17iOxM5WIpMpw/BdqcdmrQRoQwK0JCnNM@nongnu.org
X-Gm-Message-State: AOJu0YwGfyc4qME7QcTAPwW9Df3lXGFtT9sO6G8xeEOvf84gYMsCMAYx
 RCQcOAr2qJqyKwTHZPNp2C3Oj69vHcjI7L3mGrOBflKAcZ931RjBCNzzaqFgMlx3jbW1Zhf55CH
 C6K2bK651W3zM7DZwabXQMBccmTEn0cV2nfUa+J1tt+3vfbCN3OcT
X-Gm-Gg: ASbGnculA6My13MP5haylQREwFvr6qA9/8kEVFtFNxEEnZy2fR9psHmI+NCMSe3VPv1
 uo91758Ks/bfiErkwOR3l7JxbjJW7BSZ4JGbDvustEKk4rpOf6muOJ24ItvsTMCvTmZfa9nwrJo
 sTtJa/kU4zVkT/eEb8hyk2L4wYTmddnvMJ6aGujQEpyUit5/DG+S8QfsWa9i7nmQtCXjO8XxbpD
 YrH8jIrK00csSeIAp6R03zpwixhyQgPR0FLAtMk8A1XRnWyTQkvdRl9nn2dhGo1GiB/nerBzBRa
 SvxAjb9dY2w=
X-Received: by 2002:a92:ca45:0:b0:3a7:c072:c69a with SMTP id
 e9e14a558f8ab-3a7f9a25dcfmr156858315ab.3.1733415306535; 
 Thu, 05 Dec 2024 08:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBTwC5Cw4pZgDoltGfA4CgpNnHpAcciOhUbhnvS9SHXgcXVIjZhOC8GLq6bA/uI3TVe2MsmQ==
X-Received: by 2002:a92:ca45:0:b0:3a7:c072:c69a with SMTP id
 e9e14a558f8ab-3a7f9a25dcfmr156857785ab.3.1733415306259; 
 Thu, 05 Dec 2024 08:15:06 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861da9a4sm351077173.92.2024.12.05.08.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 08:15:05 -0800 (PST)
Date: Thu, 5 Dec 2024 11:15:03 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
Message-ID: <Z1HRh6e91dM8nrGY@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <9a229308-2c80-4ee2-8c49-5fec2207ad74@redhat.com>
 <489d1769-3807-4007-888c-608c1e9407fb@maciej.szmigiero.name>
 <Z1DcVH6j7pzboucr@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1DcVH6j7pzboucr@x1n>
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

On Wed, Dec 04, 2024 at 05:48:52PM -0500, Peter Xu wrote:
> > > > @@ -71,6 +72,10 @@
> > > >   const unsigned int postcopy_ram_discard_version;
> > > > +static ThreadPool *load_threads;
> > > > +static int load_threads_ret;
> > > > +static bool load_threads_abort;

One thing I forgot to mention in the previous reply..

We should avoid adding random global vars.  I hope we can still move these
into MigrationIncomingState.

-- 
Peter Xu


