Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAECD7879B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAv0-0004IQ-U5; Thu, 21 Nov 2024 12:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAuz-0004Hw-At
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAux-00059q-Ra
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732209873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzx2mz45zHpdJuxjxVAUqjOq6ZgxGiNg26POvjO+oao=;
 b=d9DFGbYPD/qyqXuociBEhwis832nAzcAm48Dg+qnRVHWKVQx2AOdOLNSXwlhHkUGG7+3nx
 qTUMWufb2W3jifokNpO8uPCHHwzvOfmBQAZowQQEH2hc35Q51dWxazusJQCDv15x2QxCSA
 OE9WORaFQC27cAjwz9bzoDnp41NvN2Y=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-3-ptB4tjNtiaLF14P61s4w-1; Thu, 21 Nov 2024 12:24:32 -0500
X-MC-Unique: 3-ptB4tjNtiaLF14P61s4w-1
X-Mimecast-MFC-AGG-ID: 3-ptB4tjNtiaLF14P61s4w
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a78e952858so12505565ab.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:24:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732209871; x=1732814671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzx2mz45zHpdJuxjxVAUqjOq6ZgxGiNg26POvjO+oao=;
 b=figk8kOWeJK7bX9TLUgzUw7qWLe6TTOIdxYfj3XSFWwQaxG/ecwqYC9kFZmVPsnO+J
 ZhOT2sl4hh6/KE+JufAvEuPz/cG42C/0hzP11GWg3bwZOrHBJo4MbXBikZaoiul+dnvD
 WNI8Bsj177i5c1zqll4VaXzp89FDwdMW297i4Uvp6xBGp2GjwxkdhgjINsLLY8ps5UE9
 gjfTsleZMRsMc+8KNDEbHo2uY7XFxDHYAuIDlgPnnQhDpoKZUsVNKvUa7lO6orMSiwkz
 myy6Z7o4u/LOcVNdg8egeGtcp9gzw6aYrcvH1XNH0+DbWeuNgeUAPNg2GygCQQ+zquLT
 X7Ow==
X-Gm-Message-State: AOJu0YzKgax+35DI4cYd1T1jaLVx2lxCU+0XHziyMKQaOFEzBHLl24td
 2T/po/DSeZl69GTDsk2XHv5DNTYr/eWdvnn8lMklVG/9RM6eyElKEGjC1R6BLBOVYe0kTv4rd7r
 UgswcEYbOu1V/OGVuRj6is/q/nyg8Dfzd+eWg6zM5RWmyoOGkeE/WSfhEdQ4Z
X-Gm-Gg: ASbGncssHM6LxqKUovW+Yykl9CH/SwQcQiJ+ULSsSKpMHZo9pf+K0tUoE+CSP5infg9
 d5SttpUrRDGWpg/2gAFgmoVBHvyDfht/H4fxFYG8tkY4atmBVcuQYD6cVyuArJOf6NCzBXQQQZH
 lL9i/2XASSsBq57sE7wASl02qE+wVSC0Vhs2YnoGIZHHbM9mxrH8NqlJJmqW9jkDMn4HHAtyLEI
 EHqTCz+VIIeBgIoCWIPjWt8lyN1jR7wvbRxuj7Pmi5hNg+AIxApDaeDfv13zRwlzxMS6cm6Qlqw
 Ygi4k+lBQFw=
X-Received: by 2002:a92:c543:0:b0:3a7:9347:5465 with SMTP id
 e9e14a558f8ab-3a793475533mr32440275ab.3.1732209871618; 
 Thu, 21 Nov 2024 09:24:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcsfLiemwjZwiZ6ExpbynWKnEveikqzpx4PlNMDxFdpkTEY53Masr4Ac1d9rLXuJ9wbP1yoA==
X-Received: by 2002:a92:c543:0:b0:3a7:9347:5465 with SMTP id
 e9e14a558f8ab-3a793475533mr32439755ab.3.1732209871143; 
 Thu, 21 Nov 2024 09:24:31 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe34d35sm56217173.60.2024.11.21.09.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:24:30 -0800 (PST)
Date: Thu, 21 Nov 2024 12:24:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
Message-ID: <Zz9szJnWPLO8iUOj@x1n>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com>
 <87h680iuhg.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h680iuhg.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

On Thu, Nov 21, 2024 at 02:31:23PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Always explicitly create QEMU system containers upfront.
> >
> > Root containers will be created when trying to fetch the root object the
> > 1st time.
> 
> Which ones are affected?

I updated the commit message to this:

    qom: Create system containers explicitly
    
    Always explicitly create QEMU system containers upfront.
    
    Root containers will be created when trying to fetch the root object the
    1st time.  They are:
    
      /objects
      /chardevs
      /backend
    
    Machine sub-containers will be created only until machine is being
    initialized.  They are:
    
      /machine/unattached
      /machine/peripheral
      /machine/peripheral-anon

Note that I also added "backend" per request from Dan, as of now.

> 
> Not a fan of creating stuff on first use, unless there may not be any
> use.  But no worse than before.

True.. since that can be a separate question to answer, I avoided going too
far to dig into which binaries may use containers, which may not.

Thanks,

-- 
Peter Xu


