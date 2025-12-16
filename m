Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A877ED637A5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 20:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVbgu-0004iK-Rh; Tue, 16 Dec 2025 15:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVbgs-0004hc-Pr
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 15:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVbgr-0000lI-EW
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 15:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765917036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=thSltGCw7IaZK35RxLV8zELxMzSGQxFqL6YKQfomkj4=;
 b=gCe5TNIit7dR4np44TUwhxmhYh6VQlIuAK8074dLvLJF4ocCYquxNAhwgZwC2XATgvFezL
 1mqBVGPD1F3xq72RDmwg0mUnCYvBL3akNQISnkfQo/l20B9B1AcRxJHZ+kEyBfkZGHUA/E
 4ogMqLSvMJOVPXUQz+J8A09sw3JQDJY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-hyiKwag_OMa2ykLxDnwebw-1; Tue, 16 Dec 2025 15:30:35 -0500
X-MC-Unique: hyiKwag_OMa2ykLxDnwebw-1
X-Mimecast-MFC-AGG-ID: hyiKwag_OMa2ykLxDnwebw_1765917035
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8804b991a54so188871246d6.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 12:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765917035; x=1766521835; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=thSltGCw7IaZK35RxLV8zELxMzSGQxFqL6YKQfomkj4=;
 b=smXZv5doyZtoGbVzlfWKUGJqQv1+sjYAKdIyvKeZv4sdV96GJ8ifG3JAYrMulAc/VT
 Gjow7UJn4kEJFz2XMv0RklO4ECw/BkGQqqfoD2jp6Ll+4WccayRPTvnVnfJrvSV+57C7
 awztZWDR58AznSj8KeSqikJDDmdo5wA5Yh5ckDXj/X5IcrehXA4EM6osFrWYz4BUavYI
 OBnV1ZWRtmQ22lq3esw5j4H0UXjDJVxMHNsCXvOfmk0DB68p1aT7GXV5zbFsJbVtD9D7
 VyZ1BWRvGKtLIhYH2zX0ZuGjVBBQp5OpX/qGkAxP8HLlfVUIUnoNFVD/BymNXScbdZc7
 QHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765917035; x=1766521835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thSltGCw7IaZK35RxLV8zELxMzSGQxFqL6YKQfomkj4=;
 b=fiQzlJZEKMPDNziypvmeddMDK9IY2XWYxf8Q5t/Y/RAiWadYHv05Z6phnnDNpQYCZl
 VTIjFqVKsvWfc0Z+NOKQKxD85SgbOA0FYEaz4IOTwyw4O2UObeNSgp00FbTJJhoBR4tH
 wvSwLkYUoXiSI+MBuJjRg81yLrskyiFxoYDETDdSpwBeDJCJs+pZIFZHRxGxgQohOEU5
 1RQ0rWpD8hRyRoHRjBCg/O0sionWtNuQjDtejvci8iQ4MO3TrNZJpTs1PrkANOz+1H7A
 N+vgogzcA/BoX1kYEWNxV3b0NUigAhnqgCAxWOCssxNjzv5Sjirz/sXAbTF1NrDjHb2f
 XU6Q==
X-Gm-Message-State: AOJu0YwFq02JHlaOaO9QjE+uGt5X6HMbzzTAJLw8UBZQRUATJdDZM3FL
 dYnCOnkIOXecKRwn8tBk28M1zexAvRD8wU9X8IbxyOo9x5B8R3LWY48NTePzUuNFjxp937RXawz
 OslfSw2JbPTnRCb0dGXPCyDNOJATcyeWc4oLjc7WGjK9BCExpLADtH24M
X-Gm-Gg: AY/fxX6Lyrahg4FC37ERdriKOvWZW837XJ+398nIgoxVRsa5Uk3Q0JSQpfop0+AlfZ/
 U5shDXdqTZKUOuw3me3wvno1FnIgE5tJe7R835QDEyE6Yeeeh47IC0H9LjSXpIkI0wa2or/iB+W
 4OjAZatYMtgWe7BPK9BLR/3jIe7oHJzyrU0Vwk/yYpghZjE1GdQYO5aGfnZl8R/ZIrRsGbnO/ol
 pmN99tJ7wvsDLkeI83IiAs4QpxK9ZSTXjfw2NHAOHxACLKLrb4K2BdC3T4LHcYWpvi7EHSuV94T
 Ue7AXiI9RGbwEIIWQyeDPyJPqgCgorpwKCjYKvrVEat9Po24RnKlS7hXS+aa1CL7kIMxH0ZMirc
 nAmc=
X-Received: by 2002:a05:6214:4411:b0:888:59d6:fc74 with SMTP id
 6a1803df08f44-8887e1558cbmr230448046d6.62.1765917034644; 
 Tue, 16 Dec 2025 12:30:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE0R/aMqIpLt9NLHZVmmLIzLKVjH+TimT82uRboBUVs5A3Hf7GHgmh9e4/8nhcQCbkmraM+A==
X-Received: by 2002:a05:6214:4411:b0:888:59d6:fc74 with SMTP id
 6a1803df08f44-8887e1558cbmr230447556d6.62.1765917034202; 
 Tue, 16 Dec 2025 12:30:34 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899dbab5d6sm78920216d6.25.2025.12.16.12.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 12:30:33 -0800 (PST)
Date: Tue, 16 Dec 2025 15:30:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3 16/51] qapi: Add QAPI_MERGE
Message-ID: <aUHBaLaH0m0u-BYe@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-17-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 07:00:02PM -0300, Fabiano Rosas wrote:
> The migration subsystem currently has code to merge two objects of the
> same type. It does so by checking which fields are present in a source
> object and overwriting the corresponding fields on the destination
> object. This leads to a lot of open-coded lines such as:
> 
>     if (src->has_foobar) {
>         dst->foobar = src->foobar;
>     }
> 
> This pattern could be replaced by a copy using visitors. Implement a
> macro that extracts elements from a source object using an output
> visitor and merges it with a destination object using an input
> visitor.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Let's see how QAPI maintainers think..  Looks good here:

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


