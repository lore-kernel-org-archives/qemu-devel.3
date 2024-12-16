Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55821E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNE2K-0004j9-W7; Mon, 16 Dec 2024 11:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNE2K-0004ii-9i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:33:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNE2H-0001VZ-T9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734366812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B1+6KC++alXOU/47+GrsHZX0GfIao5HC3bjlQJdMKfg=;
 b=daek5JVUHJhL82z07WcRGBd3ijlQjc6C/jNoRhpv+13k7T4gc9HB8hVPG7N2f+SNi96zBa
 ZxiRAYBIRRuZkq65CYI4KZar0rESSx+fhaS9gNd93c9fFhnW4QE18g2sYBgRg/WJDmOcI5
 1Isl0WugFlnbJ65aBLQ2/5bU7RJywuc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-7NMr0T2UPw-1ZkeKj9-azw-1; Mon, 16 Dec 2024 11:33:28 -0500
X-MC-Unique: 7NMr0T2UPw-1ZkeKj9-azw-1
X-Mimecast-MFC-AGG-ID: 7NMr0T2UPw-1ZkeKj9-azw
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-844db0decffso390788039f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 08:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734366807; x=1734971607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1+6KC++alXOU/47+GrsHZX0GfIao5HC3bjlQJdMKfg=;
 b=QeERIOqWxOhhj5/2OMuO97Zi/go5c9qeeVQ3/B2Cq9Gtj4owDCsfC9aGgOhgg1GLVa
 T0D5upYO9CSMBRbF7oCcwCt2xxOcF3fJ/5Ips+cuKe9oPdUkY2aMLOU6E9xyzt6qloRA
 za4WjJh8mV4aBJQ8FCWn1yR0Moyt7stpk7mo9IlSzm06Qm+qgD1PKVu5ypoA4EZn/bNO
 XQ+IR6grJonEIppLqSPoDXcdSG0ANQL5+WVEe0hCV7lVrGXBetNYMxIbacWC/JCnSR6F
 R/lGoXKZ3EFOkbQRmWIIlfei4zQwr3FjXTWN4shDxZvMh1yjqjRczPAekyqFsMLZ93VI
 loeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl10RasXQIkH89KGITVvSyQFiMx03759nkhzGXLjGvPPmzYIhv4CHkrevMb1q2V6KqHqeeAVP5pOtg@nongnu.org
X-Gm-Message-State: AOJu0Yx1kHqjVWdWSvJ74VbyyePa1MNGmcYJLZ4lpdifFMndOPmZLHXo
 lwjILu6bUpNdxHmP7VBHhB2Gw9VfrAHYCBSTnN+pn+D2teooOrj3yh/TlneldOMs3Tl+nJREMZ3
 7OEBy00QMzXc7X8kWjUreS3YxpEWaRn//BkJIoJmxE9g7tAbWt6hS
X-Gm-Gg: ASbGncvRCxvGnWZ7ajlrijZ1n1TQxV0mx/SZ9hndYdGFxwhXMyUl/WHKUdqhjaIEaDF
 VKp+a7n7oAQacK0Cc4SAYNcC6Nbk0+w/QJ7ee+HxKL3dkw19kwUKgteoBUx/F+DkDdUd2fYsX4a
 kTl4OWkcF3PRH8lZgbp92MdSzKnMg1NXLAWeTKuhV1vtgF9lHNguGYPuQEsbNPdgJHlrqKyhqr5
 XHQ/w+58x0N5hydxTCeWQ0PcjOdf2iVzbI3U+y4q8F7Z8vjR5Iq3CRxfuBZOzRjKU8QmcqGSskc
 uHJacQp3Umz7x9eU5Q==
X-Received: by 2002:a05:6602:2c88:b0:83a:ae9d:9300 with SMTP id
 ca18e2360f4ac-844e982ba67mr887638439f.3.1734366807546; 
 Mon, 16 Dec 2024 08:33:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrflbGl5jAioQ5LmKgBp0A8laTn8ugaFd2hj6L11Bm7lxvIYJuqGatd1rD2WMvBR9r8u1yXw==
X-Received: by 2002:a05:6602:2c88:b0:83a:ae9d:9300 with SMTP id
 ca18e2360f4ac-844e982ba67mr887637339f.3.1734366807264; 
 Mon, 16 Dec 2024 08:33:27 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844f628d2a9sm132895739f.22.2024.12.16.08.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 08:33:26 -0800 (PST)
Date: Mon, 16 Dec 2024 11:33:25 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
Message-ID: <Z2BWVSI7lu1JRMfI@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
 <198ca4a4-01fd-42b4-9e1a-d2860277be9e@nvidia.com>
 <ceff9e17-b23e-472b-9f29-bf4c3c895c55@maciej.szmigiero.name>
 <Z1DbH5fwBaxtgrvH@x1n>
 <7e6373ca-b344-409f-a9ad-bce72779c10f@maciej.szmigiero.name>
 <Z1sVcJRamoUFshwk@x1n>
 <2c1d2c4c-d09f-4603-8bf6-c11a4faca0eb@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c1d2c4c-d09f-4603-8bf6-c11a4faca0eb@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

On Thu, Dec 12, 2024 at 11:53:42PM +0100, Maciej S. Szmigiero wrote:
> migrate_set_error() wouldn't be called until qemu_loadvm_state() exits
> into process_incoming_migration_co().
> 
> Also this does not account other qemu_loadvm_state() callers like
> qmp_xen_load_devices_state() or load_snapshot().
> 
> While these other callers might not use load threads currently, it feels
> wrong to wait for these threads in qemu_loadvm_state() but set their
> termination/abort flag as a side effect of completely different function
> (migrate_set_error()).
> 
> Having a dedicated abort flag also makes the semantics easy to infer
> from code since once can simply grep for this flag name (load_threads_abort)
> to see where it is being written.
> 
> Its name is also pretty descriptive making it easy to immediately tell
> what it does.

That's fine. As long as we can at least report an Error** and remember that
it's OK to me.

Thanks,

-- 
Peter Xu


