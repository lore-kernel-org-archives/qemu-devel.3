Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950F3C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfN7s-000891-22; Tue, 04 Feb 2025 12:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfN7p-00088K-85
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:54:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfN7n-0003F8-3c
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738691653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzB0PxE/qeAUkS640SpKBR+gsIAMBhWTD3NGVRXPBPI=;
 b=JrIrimOg9BO8QT2hcwyW0OqZ/3PMjMtEoSfCBB/TJcbVeJg+p+/eNbj4WXeWfUF1AG0p2P
 4XZWewA6YNk3z+JtUVZHl8cKDVTkRRa19wI79mdeLEjm4aJfqbAjVzItu+83SMqbQH/oHW
 XqZ/E963BTJViZW+CVj7fvUivkHQowQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-vPfE9i8TOvu_mZd-uu6nFQ-1; Tue, 04 Feb 2025 12:54:10 -0500
X-MC-Unique: vPfE9i8TOvu_mZd-uu6nFQ-1
X-Mimecast-MFC-AGG-ID: vPfE9i8TOvu_mZd-uu6nFQ
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6e852eeabso963691285a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:54:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738691650; x=1739296450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzB0PxE/qeAUkS640SpKBR+gsIAMBhWTD3NGVRXPBPI=;
 b=kwXvoaQmyFv+9H9SNuBNX1zRYYrKZBZKjZG0zeYkk8aT/azvBHH4S9tAa5JV/Xy4ch
 MmFYS5dpyskeYspelyEzHerlOLuBFBTW+DTJh/uTsLMhcaPhQft/2stvZ/coEcw7tv6r
 i+jFiaSXxhAPIeNuV7pmSkt59tuhPOqvitbfrpv6hpFbM+tYkpMlOQJR/2scRsw/+37k
 CDo2I2sB+sFohAnuC5JVBa0jsMsx1H16NrALufL5gJdc9VEyngQc72h+hxBovk5QOsMg
 prMER1avR6BKSHq6dnHh0SQ2zAA5Vy/6vrzb6MZ3kNwCCNmY619DVa1Ej9pBzBPdGU2e
 SFNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPm9KhDUlVV84BSJdoTe+a3T9gM4CYq+MW1mXl1D9hdQGib0TAgVN9YFke0vAXTLq8OV7EvS7Uvgsp@nongnu.org
X-Gm-Message-State: AOJu0YyRf0JswoG06l1vv+mYVe37Iwj14DA/XesCDdVUNrG+uKFJxpHZ
 H0eBrK1hfNRzzaIQ3FF75Y4voHqsHy3TEv96Y0H5WW/wZnvt09EaMRiVpgEHmDFOqR+nlS8Q/hC
 puQ5P8hPlZX5zvBv+RG8PmRVkDHniQ6zpJTcGLc7QMfyK+wabzDvR
X-Gm-Gg: ASbGncusMfWVljtC0ymVGC+qpObVnudEUsJfjeVrPFS228+VeIlMltlLpmOfM0r1Lsv
 et9wa3RKgXxHLuPsfBOiOW3axBj9MmAtlHJSeS942FFK2JOC+yNngZR+XVg0LB/uDVzQ8L1XX+z
 ZeFg36eVuFkE1S7ugf6MlpOThpYx2+i7XhZoXCgSGZY/uu2p7glDP6ryLg9bmC9P1DwKOEwboon
 vQBeSPkcwwHOUuOFHNJE8dHTwGmmOvozdhAAcQljrxo7NASJi+o/+VTwdv2uoHwpXxNWZCXtXQ3
 rA7LLs3JJ3RP4zEFtCZgmFxhelVQcNBAEpdLvljVhxrS0xDa
X-Received: by 2002:a05:620a:284c:b0:7b6:d28b:42b4 with SMTP id
 af79cd13be357-7bffcce1d50mr3845297385a.19.1738691650337; 
 Tue, 04 Feb 2025 09:54:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSjiC9b9OBiAPpuVHshl4ZrtzJbo8lzAMdQZHET8sQoId5L3gF/z5lSyM0KKS5TzViYcBgGw==
X-Received: by 2002:a05:620a:284c:b0:7b6:d28b:42b4 with SMTP id
 af79cd13be357-7bffcce1d50mr3845293785a.19.1738691650037; 
 Tue, 04 Feb 2025 09:54:10 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90ce2esm658244285a.103.2025.02.04.09.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:54:09 -0800 (PST)
Date: Tue, 4 Feb 2025 12:54:07 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 19/33] migration: Add
 save_live_complete_precopy_thread handler
Message-ID: <Z6JUP2w9u_FQRP6u@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <7561a5d67e113e166c7d43246d52feec6ca06fb5.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7561a5d67e113e166c7d43246d52feec6ca06fb5.1738171076.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jan 30, 2025 at 11:08:40AM +0100, Maciej S. Szmigiero wrote:
> +static int multifd_device_state_save_thread(void *opaque)
> +{
> +    struct MultiFDDSSaveThreadData *data = opaque;
> +    int ret;
> +
> +    ret = data->hdlr(data->idstr, data->instance_id, &send_threads_abort,
> +                     data->handler_opaque);

I thought we discussed somewhere and the plan was we could use Error** here
to report errors.  Would that still make sense, or maybe I lost some
context?

Meanwhile, I still feel uneasy on having these globals (send_threads_abort,
send_threads_ret).  Can we make MultiFDDSSaveThreadData the only interface
between migration and the threads impl?  So I wonder if it can be:

  ret = data->hdlr(data);

With extended struct like this (I added thread_error and thread_quit):

struct MultiFDDSSaveThreadData {
    SaveLiveCompletePrecopyThreadHandler hdlr;
    char *idstr;
    uint32_t instance_id;
    void *handler_opaque;
    /*
     * Should be NULL when struct passed over to thread, the thread should
     * set this if the handler would return false.  It must be kept NULL if
     * the handler returned true / success.
     */
    Error *thread_error;
    /*
     * Migration core would set this when it wants to notify thread to
     * quit, for example, when error occured in other threads, or migration is
     * cancelled by the user.
     */
    bool thread_quit;
};

Then if any multifd_device_state_save_thread() failed, for example, it
should notify all threads to quit by setting thread_quit, instead of
relying on yet another global variable to show migration needs to quit.

Thanks,

> +    if (ret && !qatomic_read(&send_threads_ret)) {
> +        /*
> +         * Racy with the above read but that's okay - which thread error
> +         * return we report is purely arbitrary anyway.
> +         */
> +        qatomic_set(&send_threads_ret, ret);
> +    }
> +
> +    return 0;
> +}

-- 
Peter Xu


