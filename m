Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB2ACF3970
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 21:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srOXz-0001Of-Bs; Thu, 19 Sep 2024 17:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srOXy-0001JQ-4T
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 17:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srOXw-0000n3-KG
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 17:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726780719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/h0B+FgVmF4hl7MJvr7oKOHu6ekeIjZIwhOLzrLLULU=;
 b=FA6WodINa5dQ7ZOdw7W7yrxqdxEC6dF6CrwWGDw4Il4B0Rb6xUvEo1uxlbx7at1w/rW9vQ
 IPOq64Y2sji/MP12MgCqYT1s/syjM/M5pZTLNQAybCIyoFZ7U8qoDm6QFjm9XGsiuDR7BA
 Xe5GweNjL80XrKmm3OsX6t/EehyzbZs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-5NNnwJC6OGW2Y-fveLkIOQ-1; Thu, 19 Sep 2024 17:18:38 -0400
X-MC-Unique: 5NNnwJC6OGW2Y-fveLkIOQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c366dfd540so22110296d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 14:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726780718; x=1727385518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/h0B+FgVmF4hl7MJvr7oKOHu6ekeIjZIwhOLzrLLULU=;
 b=V3hCdtWcktvRocvAsabAOY3ofEJYhL6nLuRj5qJIYaP8dbqUJ/vFrE6KASPkQ9Yk1Z
 08hI4Y6+TomwvmfeqyGlYTFP8VkZu9VQE0zkgiJd8XoBuNckrgpqp3d3HeE2KZcnYOBn
 sGGNHklKNiG6hpf9hFwSGB01hH+8phWXU2fe01V59OUpJ3BevUpK0tbHv9iRG2hAurhd
 6gk5BtgsidSgS65H0CxKe8c0km6dlI1VuPSroMJPHPJDx8dvO8vhdBykO72zAag0Zdbo
 1McD+v8sn/d4/7oVvFrHnQW3BnNiW4L2qZfF9LSFno1d2LXoRwoqgI6akDgdMm//IY4V
 PN5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHJ9H2LZbG+HubeduNRedqSX5Eq+Jwg2eIZd6nCzfJYd7ZwtYwOj9dlrC1CeQ+YYJT8FvJabiINMu/@nongnu.org
X-Gm-Message-State: AOJu0Yzzivnr0RhWBX/82K+x8AF3DXweiiEvxlYdhaCswyS88CXX2EUW
 qIr+YN0JBnHOIIaDZVBDOv1WKUYd/JU5UZgNnN/7MQfUVfQk5ilHMZnvUqZ6DoEAzPLQLP9+Mri
 D5XEwi7HqDFp3cLww4bFs3fBsf7ekyU+DUm5RO8qN8jlNJImLmI8H
X-Received: by 2002:a05:6214:449f:b0:6c5:ab2b:3a9c with SMTP id
 6a1803df08f44-6c7bc65b698mr10175786d6.4.1726780717864; 
 Thu, 19 Sep 2024 14:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAbhycUm7WJTH+d4MIb2iVS+p1q2Ga+w1BSsr5IG+y2cNXP7NiK7ILVvmn5p2XT2mnybZI0w==
X-Received: by 2002:a05:6214:449f:b0:6c5:ab2b:3a9c with SMTP id
 6a1803df08f44-6c7bc65b698mr10175506d6.4.1726780717547; 
 Thu, 19 Sep 2024 14:18:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e44bffesm10963556d6.3.2024.09.19.14.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 14:18:36 -0700 (PDT)
Date: Thu, 19 Sep 2024 17:18:33 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
Message-ID: <ZuyVKeNW0uIIJJNI@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <ZuBumSH-nZDzpCcQ@x1n>
 <e9037c2b-3994-405b-baf1-de8a862880e0@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9037c2b-3994-405b-baf1-de8a862880e0@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 19, 2024 at 09:49:57PM +0200, Maciej S. Szmigiero wrote:
> On 10.09.2024 18:06, Peter Xu wrote:
> > On Tue, Aug 27, 2024 at 07:54:31PM +0200, Maciej S. Szmigiero wrote:
> > > +bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
> > > +                                char *data, size_t len)
> > > +{
> > > +    /* Device state submissions can come from multiple threads */
> > > +    QEMU_LOCK_GUARD(&queue_job_mutex);
> > 
> > Ah, just notice there's the mutex.
> > 
> > So please consider the reply in the other thread, IIUC we can make it for
> > multifd_send() to be a generic mutex to simplify the other patch too, then
> > drop here.
> > 
> > I assume the ram code should be fine taking one more mutex even without
> > vfio, if it only takes once for each ~128 pages to enqueue, and only take
> > in the main thread, then each update should be also in the hot path
> > (e.g. no cache bouncing).
> > 
> 
> Will check whether it is possible to use a common mutex here for both RAM
> and device state submission without drop in performance.

Thanks.

-- 
Peter Xu


