Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F0EE6FE23
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 16:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY5gC-0003Pz-9B; Tue, 23 Dec 2025 11:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5gA-0003Pj-Bg
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:56:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5g7-0005El-AU
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766508964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9hVy6EvXYS0bM65nRWn5rMZHRNKPD0wA4xBLq/uJ4o=;
 b=IgUc1BYD6Z6NDfpIS8A1MCBl3Sjjgm2kZ70YYGb3P2iC4dPrC4/P427If/B1UI1PAi4dbP
 uIUkX1PRQ+LrUCm2M154kksIe89CGRgicUHnDaWH+RczEYxff09cc0xVljd7cb4xZZgj6b
 sYFpey/fGW+LsqhrhthiC8pDlt2kC7o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-upSqqR78ODSK6GqgVQ1eDQ-1; Tue, 23 Dec 2025 11:56:02 -0500
X-MC-Unique: upSqqR78ODSK6GqgVQ1eDQ-1
X-Mimecast-MFC-AGG-ID: upSqqR78ODSK6GqgVQ1eDQ_1766508962
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b9fa6f808cso1464601785a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766508962; x=1767113762; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E9hVy6EvXYS0bM65nRWn5rMZHRNKPD0wA4xBLq/uJ4o=;
 b=SXX2QHEfaMBOGbghdaiGxSNdJh1MGhmMW+U6tUIBXtVs4/rs7Gr/08i4EB7sy3+8/8
 beS7HcYJyFdpd/F4gC9YoXqxa2tpZoJYBb0kLhUlBiW02JrSf6/QPqpWjAtooMqK1vLK
 Z83yZ9H9B/249YFB17oiGlyTOy82Pmo7hALo6DqZ/7ezEngIFMBqfbelxL8yvWifI9CQ
 wTYNCKdmO1zhFjedalPGAThdcn4VioBiG75nJKmUVSVezlS5QBNGh8gDd8SW1s1nGRy3
 01VDr0vLUDHLk9E+Li0NYHznycDWiDyHLfTU4Xzhu2Bjval01hvYShseDeD3Dsq5Bf33
 glzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766508962; x=1767113762;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9hVy6EvXYS0bM65nRWn5rMZHRNKPD0wA4xBLq/uJ4o=;
 b=mlYLVFwG4RT5qG30UIhaiq7nejw4uxVlT6NtGT9kgQJhW2OCuEueID09go9TUNqZPF
 4/sRLSWLVfHxerpz/CTXQUtiTRC46CQ4D5zdZo3kfxSydUp1BQoM1/zEsWGPAf9ng/2s
 TGRAGoiALV5czoSc/+H3ZJ2RSkP4G4rbo98AQTS6n4UXt3Kk+5or08DQcDnXMD6jjyGo
 LIOuAXP5CsmT7D71EbqLgvBdExzwFWZ3yfXvlTKIB/d3bKb4UmQJANffACHffGV1Pssz
 H1xqBrNsUL7CDP0a/e2hgkNW3BwzqFVbhsDzUQXqeaZRXAs864OZiHVQtS0NfSm831z1
 6VoA==
X-Gm-Message-State: AOJu0YyTqTYMOmKQmddPHgKEl2HgNkWYFLfHzVDkvUYy0KWXRz17kgHE
 X5jDpiH0Nwc4CNIn2VUKX5zNOm4Whfhz9JYpZGqi6WfMqUXiM0f+EB+utadsD3L9iSU3udlbzVa
 sLAomL3JdgISEF+t0LqC080lu3L1fCzcYz0VYDR0Gl7V8dD5e95MLx+TN
X-Gm-Gg: AY/fxX6nF3pu8+ZPH1ypKqXUwvV/qPkHQOFA242ejEBGigN619jd1d2zjBgnrEssyUz
 51420J0hLChsAz8ULH4ForiUzMJxWKLfC8CMF4tOeaodctj8ncUsExvrMI3ReZGd6QzDca1k7dl
 wZvKwKMND/znkS9IWeIVjTa3MSvfFlEhfeJYb6fCv9812yW7JhmY5dOnzAmf/FGQaqmpv9faQ6+
 NFPDhRwpeqOuXZCKexx1qDATGT5zDZ9nyKC9Jpnpk6XUgKPqbKt+s3Jlze4hnub4U2AbsnS/TEk
 UVZhjHMI2eo4DDt9IROUgpA+CU4IUEOwyQY08k5NMLM1wLmUNrShT22/xNiRtA6SefEcTcPLE2P
 wcro=
X-Received: by 2002:a05:620a:c4c:b0:8b2:7608:1ee0 with SMTP id
 af79cd13be357-8c08fd33630mr2276055985a.71.1766508962332; 
 Tue, 23 Dec 2025 08:56:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmzhTYL/oCU8Djt5fXlb/DeZ8FRMBgWh67VhT8JkBBB2D53S+ZHeqprC8Jv6d0/2+1pNT3OA==
X-Received: by 2002:a05:620a:c4c:b0:8b2:7608:1ee0 with SMTP id
 af79cd13be357-8c08fd33630mr2276053585a.71.1766508961896; 
 Tue, 23 Dec 2025 08:56:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d997aed21sm128176276d6.30.2025.12.23.08.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 08:56:01 -0800 (PST)
Date: Tue, 23 Dec 2025 11:56:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v3 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Message-ID: <aUrJoJbRJuOjwyKa@x1.local>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-2-peterx@redhat.com>
 <76d1fec9-0bb4-43f3-a50a-c66f065fcb59@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76d1fec9-0bb4-43f3-a50a-c66f065fcb59@intel.com>
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

On Tue, Dec 16, 2025 at 08:41:50PM +0800, Xiaoyao Li wrote:
> Hi Peter,
> 
> On 12/16/2025 4:51 AM, Peter Xu wrote:
> > diff --git a/system/physmem.c b/system/physmem.c
> > index c9869e4049..3555d2f6f7 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -2211,6 +2211,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> >                          object_get_typename(OBJECT(current_machine->cgs)));
> >               goto out_free;
> >           }
> > +
> > +        if (!kvm_private_memory_attribute_supported()) {
> > +            error_setg(errp, "cannot set up private guest memory for %s: "
> > +                       " KVM does not support private memory attribute",
> 
> There is one redundant blank space at the beginning since the previous line
> leaves one at the end.
> 
> Please help fix it. Thanks!

Sure!

-- 
Peter Xu


