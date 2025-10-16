Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF5FCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 19:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Tok-00088b-5a; Thu, 16 Oct 2025 15:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9Toh-00088N-HX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9Tod-0002iV-CJ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 15:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760643548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUUptjB/bwyxCzaKffHN7hLPJG8Wzwkw7Q3nBf8U5pA=;
 b=BUAUpvPbW+CTaOb3Q8YGrhIFBjmwSLYQcsDYakPnUcEBkivnDC7eocFkgOefbs07c+TrBq
 Gf7FGt/SzKqx01UBv7kIxEqA2KHkFuV78djKOVt8jD9s14wwhptmHP1hkjAuLJOHpy8wq1
 ZEXRew5bxDRKQ+6on+XLbQ68a1YDihQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-AAK7QoWjNYqymp_ubi7iTw-1; Thu, 16 Oct 2025 15:39:06 -0400
X-MC-Unique: AAK7QoWjNYqymp_ubi7iTw-1
X-Mimecast-MFC-AGG-ID: AAK7QoWjNYqymp_ubi7iTw_1760643546
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-87c1558a74aso48529976d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 12:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760643546; x=1761248346;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUUptjB/bwyxCzaKffHN7hLPJG8Wzwkw7Q3nBf8U5pA=;
 b=is4tM33Qi5RNtoaCGsIr8zpXyLyNBIZgp0yvnbJS8JSQr0tPcdlpSP2YZ4FIo0jChT
 zrIJlvmNcHuHOm8/rRkEq+n8dJf+i2XnfneGa4Q5uTidZI2ekkVmTriaMqDTSJ0AzhuH
 ROexWZCdoTjuCE15d9AjKAytoqgk8THVzOTqmmbctkZMAVZo/32dWvY2dOBY+3SZeXj2
 nWGIn90KQsmyQVH1HQeDNfQPXpmFwM1yZYuH1i59MUXFkRAdYo1O75jEVXG+0YnvMFpk
 7w0Ev9yoPzy4tMuFkJDSyUQHCLJYz6j2ujT8acvG99BGJ0n4rEvnTYDIoc8Is0c6L2/T
 GOmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsnypTLWZKBxtR5woZcTBO/f1ClgHhXfSjagM54ZKhvgCIph8JHpu++WLspFPP1rWp0wlGvI9I5jZq@nongnu.org
X-Gm-Message-State: AOJu0YztG1fiWsFE6+NyAAi2AvkrfxG732Nrrwq91r+Q9wG4UjqGSOMN
 nM7PdC1CHSzAZPDX7hNmF/PZjsgocY/PFcgYXcnWod95CyiH7FlgKzIqQWBg05hfhFWgajIZz7L
 E1Fqp7LUL5ZhWwF/pLJr5P7/6NiHkqcf2iMekk29baI6mqLDORza4IPGK
X-Gm-Gg: ASbGncse+zNAWyQLXAOoOkJ6Fv/kdUHutKIWeoQ1K6qm+NDEtURRcCTWJI7RR13iPQf
 OA+bN9LR8O2sKhsox38+saINqj7aFI7eb6fLAWSby4cDZJPrFrw5icl70dGw7dVVfiMceT6S0PW
 fG+G75upSGDsnfCeU+bNVkNpw/xeKb6NW1LxcU40eIgPkYkEIuwbobOSlBi6v2yy0/ncQnZ2KkI
 TkzLqRCbLj/7DAwnjNqbjd7RDkhnjd1ka4BcdcaaQ1lqLUTKOZpObgwX7fB0xWcIEhZEGFFqAKG
 1zOhSa94KRaRJemCmRYAjEG8gRp7ikwdGO3O528ZXu8V06kqq9HownaeNIVBPLGhCMA=
X-Received: by 2002:a05:6214:f02:b0:873:af59:fafa with SMTP id
 6a1803df08f44-87c206465b5mr22965716d6.45.1760643546121; 
 Thu, 16 Oct 2025 12:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7F+dyxCyoKY0Caf+1P/FhnTUzyVYcKIbL7RPtHrQxv2K45BzBLCOlQ8KqOdgJMn2ml8g6Ag==
X-Received: by 2002:a05:6214:f02:b0:873:af59:fafa with SMTP id
 6a1803df08f44-87c206465b5mr22965416d6.45.1760643545714; 
 Thu, 16 Oct 2025 12:39:05 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87c0128d879sm45945806d6.35.2025.10.16.12.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 12:39:05 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:39:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, jasowang@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPFJ16QZ7m_7h_kM@x1.local>
References: <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFFSVJ8iCn8zaSV@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPFFSVJ8iCn8zaSV@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 08:19:37PM +0100, Daniel P. Berrangé wrote:
> On Thu, Oct 16, 2025 at 07:51:42PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Oct 16, 2025 at 02:40:58PM -0400, Peter Xu wrote:
> > > On Thu, Oct 16, 2025 at 12:23:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > On 16.10.25 11:32, Daniel P. Berrangé wrote:
> > > > > On Thu, Oct 16, 2025 at 12:02:45AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > 1. Remote migration: we can't reuse backends (files, sockets, host devices), as
> > > > > > we are moving to another host. So, we don't enable "backend-transfer". We don't
> > > > > > transfer the backend, we have to initialize new backend on another host.
> > > > > > 
> > > > > > 2. Local migration to update QEMU, with minimal freeze-time and minimal
> > > > > > extra actions: use "backend-transfer", exactly to keep the backends
> > > > > > (vhost-user-server, TAP device in kernel, in-kernel vfio device state, etc)
> > > > > > as is.
> > > > > > 
> > > > > > 3. Local migration, but we want to reconfigure some backend, or switch
> > > > > > to another backend. We disable "backend-transfer" for one device.
> > > > > 
> > > > > This implies that you're changing 'backend-transfer' against the
> > > > > device at time of each migration.
> > > > > 
> > > > > This takes us back to the situation we've had historically where the
> > > > > behaviour of migration depends on global properties the mgmt app has
> > > > > set prior to the 'migrate' command being run. We've just tried to get
> > > > > away from that model by passing everything as parameters to the
> > > > > migrate command, so I'm loathe to see us invent a new way to have
> > > > > global state properties changing migration behaviour.
> > > > > 
> > > > > This 'backend-transfer' device property is not really a device property,
> > > > > it is an indirect parameter to the 'migrate' command.
> > > 
> > > I was not seeing it like that.
> > > 
> > > I was treating per-device parameter to be a flag showing whether the device
> > > is capable of passing over FDs, which is more like a device attribute.
> 
> Whether a backend is technically capable of transfer shouldn't require a
> user specified property - there should be an internal API to query whether
> the current backend configuration is transferrable or not, based on the
> code implementation. Allowing a mgmt app to specify this can only lead
> to mistakes, because they don't know the internal constraints of the
> implementation.
> 
> The mgmt app should only be concerned with whether they want to transfer
> a backend or not which is a time-of-use decision rather than launch time
> decision.

IMHO the per-device property, when available, should always mean it fully
support the feature, when it is turned ON.

I also think above statement matches exactly how I see it..  I never
expected mgmt to toggle the per-device properties, as I just left similar
statements in another reply.

That's also why I think the global backend-transfer should be the only
thing exposed to mgmt.  So even if the device properties would exist, they
should only be used in compat properties for the upstream QEMUs.

They're still needed, and be helpful when other devices introduce some
similar concepts to support fd passover, then on some machine types when
the global feature enabled, QEMU will automatically do fd-pass for some
devices and some not, based on the machine type.

Thanks,

-- 
Peter Xu


