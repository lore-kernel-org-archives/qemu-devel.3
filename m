Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E38D5C0C8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 14:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Q2l-00073z-7k; Fri, 08 Nov 2024 09:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9Q2j-00073X-Tn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:32:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t9Q2h-000343-8V
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 09:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731076373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTCYdwkfaOg2zJAuYW8/8HJeR5sdHrMyVZN7kXtfhy8=;
 b=GWLD7SJHJLxcmE9P/DM7wZeFiyVA5aUTnomz3fekVDMEZqnkJU19O/VkvuNGucyaXzee9u
 7iKb6qSGF39C9RB6Q2hLASkCtxuVZ0i7iy47F1t43XQZdZjNW0QKksX0IlmvraKCWw/Lej
 P3b5rKSjQK+w3r8yClpMquU5H8qKaFA=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Kaq2VvPTPfKpDJavIheWZg-1; Fri, 08 Nov 2024 09:32:50 -0500
X-MC-Unique: Kaq2VvPTPfKpDJavIheWZg-1
X-Mimecast-MFC-AGG-ID: Kaq2VvPTPfKpDJavIheWZg
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-28879673bb1so1921430fac.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 06:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731076370; x=1731681170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTCYdwkfaOg2zJAuYW8/8HJeR5sdHrMyVZN7kXtfhy8=;
 b=IMz6WRMNmk1NNCgpnwKl20A3JVKoSCTzHsJruiVIXjKm5gPgmigGbA6VFoU/Kue+Xk
 TViYJ8TBgomqCECVrpHxOWSjKOP1f3VDzvQC6oIvG+VG7SsAvkCgX+M0yaKTxVELTmt7
 AaAVip+qJZLrwAfKfBqMPKPdEjA1nnmJlMjfdXYNv1LmMs5cpvk7W4Sq5xsMHBddAehF
 dKge7JTg/TKtyXPx3dz2mwoON36vF7dRRluD+vpkrlhVq1VcQ34YsBMRdbOoThtxYYIR
 0qV6Nkc6oNwychk6NaDdSszxTG8UlQwjessYV/op7qDFYaR/e3SnoP+jcOdphHf878BQ
 bEQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY7nSJEtNuP01KCtvCtKl9GuTRb/u+Ax7S8wh/9P1BGoCMXupwOgF7dorkKOomQuZviOo4CdN2/D+g@nongnu.org
X-Gm-Message-State: AOJu0YxatsUD9S9VA20FNmmfqQ8Sgl/5MUH5GeR7/+ju/jpbi13gVSA8
 OzcsxAM351FJINFQXQoV9HcZQMWHZtFmjE4CNqtLuWH0A2u7Ja6Pw1tPFJFCV3P/Z9msV6a2J1E
 iOpgZdBVWRAaiuAazVK2EOOnsO31Pgyysi4CJCW8+fPc2YDSWRt8e
X-Received: by 2002:a05:6871:5c7:b0:288:9adc:3670 with SMTP id
 586e51a60fabf-2956026ec80mr3512348fac.29.1731076369974; 
 Fri, 08 Nov 2024 06:32:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXdvW5v1QmPoWuXNVm1pDLsYSq98I2971uzSxFhqJNsW0f4FSeu1INpziG0BR2pjZPMZz8jg==
X-Received: by 2002:a05:6871:5c7:b0:288:9adc:3670 with SMTP id
 586e51a60fabf-2956026ec80mr3512321fac.29.1731076369678; 
 Fri, 08 Nov 2024 06:32:49 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29546ed9093sm990707fac.39.2024.11.08.06.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 06:32:48 -0800 (PST)
Date: Fri, 8 Nov 2024 09:32:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <Zy4hDcKMDcak8j_9@x1n>
References: <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
 <Zy4VkScMEpYayGtM@x1n>
 <514e4919-45c1-48da-83fb-518fdc12161f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <514e4919-45c1-48da-83fb-518fdc12161f@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Nov 08, 2024 at 09:14:02AM -0500, Steven Sistare wrote:
> > Could anyone remind me why we can't simply set PRIVATE|SHARED all over the
> > place?
> > 
> > IMHO RAM_AUX is too hard for any new callers to know how to set.  It's much
> > easier when we already have SHARED, adding PRIVATE could be mostly natural,
> > then we can already avoid AUX due to checking !SHARED & !PRIVATE.
> > 
> > Basically, SHARED|PRIVATE then must come from an user request (QMP or
> > cmdline), otherwise the caller should always set none of them, implying
> > aux.
> > 
> > It still looks the best to me.
> 
> Our emails crossed. We could set PRIVATE|SHARED all over the place.  Nothing
> wrong with that solution. I have no preference, other than finishing.

The current AUX is exactly what I was picturing when I was replying v2, so
the four paths you listed here:

https://lore.kernel.org/qemu-devel/44b15731-0ee8-4e24-b4f5-0614bca594cb@oracle.com/

        Agreed, RAM_AUX is a clear solution.  I would set it in these
        functions:

                qemu_ram_alloc_resizeable
                memory_region_init_ram_nomigrate
                memory_region_init_rom_nomigrate
                memory_region_init_rom_device_nomigrate


That is what I listed previously:

https://lore.kernel.org/qemu-devel/Zv7C7MeVP2X8bEJU@x1n/

        I think that means below paths [1-4] are only relevant:

        qemu_ram_alloc
                memory_region_init_rom_device_nomigrate [1]
                memory_region_init_ram_flags_nomigrate
                        memory_region_init_ram_nomigrate    [2]
                        memory_region_init_rom_nomigrate    [3]
        qemu_ram_alloc_resizeable                   [4]

Except that if we don't want to risk using VM_SHARED unconditionally on
linux for aux, then we need to have a new flag, aka RAM_AUX or similar.

So I believe the list is at least correct.

I changed my mind because I noticed it will be non-trivial to know whether
one should set RAM_AUX when a new user needs to create some new ramblocks.

In that case, we need to define RAM_AUX properly.  One sane way to define
it is: "if the user didn't specify share or private property, please use
AUX", but then it'll overlap with RAM_SHARED / RAM_PRIVATE already, hence
redundant.

Yes, let's wait and see David's comment.

Thanks,

-- 
Peter Xu


