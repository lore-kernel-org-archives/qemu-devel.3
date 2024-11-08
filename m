Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6827FD5C0E4
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9QVK-0007At-4K; Fri, 08 Nov 2024 10:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9QUy-00078e-3V
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9QUu-0007XT-Vf
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731078122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EFGuP/ApkhB2V+QODh2msYRwCrjyHxKkitvi4g11ygk=;
 b=BU9NyWpQ0lr8RJtws3s++1B4YUGStgykjUcDYHgCub0UXaK+6WxNskQ3rPWLG274lBBzx5
 FZYHtpB94bObCxDpNP+dCAf+/0QCvnkty688gFJjIACeTrKGOinifr/GxU66CnCnumuwbi
 MZu/Pv0v//CQCVw+TYb5AMosFki/GgQ=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-bV2pnIKHOsKy69hy44Gbwg-1; Fri, 08 Nov 2024 10:01:58 -0500
X-MC-Unique: bV2pnIKHOsKy69hy44Gbwg-1
X-Mimecast-MFC-AGG-ID: bV2pnIKHOsKy69hy44Gbwg
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-288485b2358so2317464fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731078117; x=1731682917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EFGuP/ApkhB2V+QODh2msYRwCrjyHxKkitvi4g11ygk=;
 b=FhCZqCZbfXgTDaLxXV/fsMN8QVzY/MUOOMfoe2kYfVNOzFv0q2OdAw5vwAzMR96Nkh
 qRA5ennmnQlzbmJwngP+fHQeJHwMfPRXbqnYv+0Q6UDDh4TWFWRA/SredAm5Q2JgDV6O
 h7z0DUmQxQi6HuZYEpRviZc+StpJiRhfsRHyPj2du/M5f5iE9GvQRLhUYooe9OPINgHX
 puyDKbtElIZp1DVO+sO3JjBBx9Ue3xRPDG7Z1v++y4TK3y8vmTLC8eFlhb2OK3pq2Y+a
 PQKS+C8BA/DFAwTg/PLglhiuhJJ73H83IKxFuaoOdi+ie9PQHXtegyFz0qAi9uDO/D13
 k/kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9N4UzSCY4gzfkdfmXLURqJ6MATZ7FkKuLC80HO+9VyQCgKizmt06OnwJcPwkS6voA2STCjvIE2ktv@nongnu.org
X-Gm-Message-State: AOJu0Yx3jjT5mqyd5f5wQXxKTi4O86ofyt1RuoTapuSFhDVjN3R/1iTv
 SWSjedBrSYbB/vLu1t23hOXoredbXMEBsxUlmUvBi4IVV76uKfOIqJhD6hkok0DUX1hymrKrPhG
 Z0mXwvdCSzXSm+cj5FcTL1IXSsN5IWEs2hZLNxg0tGfcc9IhZYakc
X-Received: by 2002:a05:6870:b4a6:b0:25e:1711:90e3 with SMTP id
 586e51a60fabf-29560033c96mr3381964fac.2.1731078117200; 
 Fri, 08 Nov 2024 07:01:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECUgy3BOBwJjwJvo0gROXjSAMO6BXu4XkiLDpVMm5M5M/WxDWJHy5ATKLKx2OCVyOpuYqShg==
X-Received: by 2002:a05:6870:b4a6:b0:25e:1711:90e3 with SMTP id
 586e51a60fabf-29560033c96mr3381910fac.2.1731078116656; 
 Fri, 08 Nov 2024 07:01:56 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a10921812sm756039a34.66.2024.11.08.07.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:01:56 -0800 (PST)
Date: Fri, 8 Nov 2024 10:01:52 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <Zy4n4Dsqd82kmlcf@x1n>
References: <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
 <Zy4VkScMEpYayGtM@x1n>
 <4bfb997b-6abd-4349-9cf5-292fead25d0b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bfb997b-6abd-4349-9cf5-292fead25d0b@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Nov 08, 2024 at 03:18:07PM +0100, David Hildenbrand wrote:
> > 
> > Could anyone remind me why we can't simply set PRIVATE|SHARED all over the
> > place?
> > > IMHO RAM_AUX is too hard for any new callers to know how to set. It's
> much
> > easier when we already have SHARED, adding PRIVATE could be mostly natural,
> > then we can already avoid AUX due to checking !SHARED & !PRIVATE.
> 
> How is it clearer if you have to know whether you have to set RAM_PRIVATE or
> not for some RAM? Because you *wouldn't* set it "all over the place".

I think I answered that in previous reply, but exactly after the line where
it got cut-off.. :)

https://lore.kernel.org/qemu-devel/Zy4VkScMEpYayGtM@x1n/

        Basically, SHARED|PRIVATE then must come from an user request (QMP
        or cmdline), otherwise the caller should always set none of them,
        implying aux.

But I confess that's not accurate.. some caller is based on type of objects
etc. to decide mem must be SHARED.  A better version could be:

        RAM_SHARED|RAM_PRIVATE describes the share-able attribute of the
        RAM block.

        It can never be set together.  When one is set, the memory
        attribute must suffice the request.  When none is set, QEMU will
        decide how to request the memory.

        The flag should only be set if the caller has explicit requirement
        on such memory property.  For example, it can come from either a
        request from user (share=on/off), or the memory must be shared /
        private due to its own attribute (shm objects, like ivshmem, shm
        backend, or remotely shared mem, etc.).

        Otherwise, callers should leave both flags unset.

Maybe we should document this directly into the flag definitions, so what
flags to set would be clearer than before, and just to say it's not the
caller's own willingness to set SHARED | PRIVATE randomly (so as to make
cpr available as much as possible).

Thanks,

-- 
Peter Xu


