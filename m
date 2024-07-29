Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E376C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPVW-0006ox-Su; Mon, 29 Jul 2024 08:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYPVU-0006i9-Vl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYPVT-0000rH-6D
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722256178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSCGIkagRajMJUNnkRhQR1V1o2DHbmlR8SKkQy4X4pM=;
 b=P/qZhkRT37fp3ftw5j7v7IsAZ7himcUU2NwwE0fAkZR3O2W63Z9S1ta0mSxrVz+fJTtm8i
 ej1rn+ndJo816wI9S/2O+8JJ5v/xi93GDyLpvPDDiudelucNKb+aOpGLjzyLFZwXOBO9ki
 J+QWTO2LQ/4hjEZYSsa9zEWEXEjELw0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-OVdntNpxM1ezX2RWmiVqvQ-1; Mon, 29 Jul 2024 08:29:36 -0400
X-MC-Unique: OVdntNpxM1ezX2RWmiVqvQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3687e6d7a3aso1248430f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722256175; x=1722860975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSCGIkagRajMJUNnkRhQR1V1o2DHbmlR8SKkQy4X4pM=;
 b=qKn9bQjvZirsZjAxO6Q1pqJcXGCD/d3tqT84BO1M6vWYiAgPHDiIyGne2hodRx84wx
 DY+iuiVSJSCchCH+xuJmRWTcXFpfY1vHN2WMmxhuL76uOSt+IBEBPVNzga88y6IA6dHo
 Ihmu5mpbS66hwCesKdg6dI1YfvWCRMrzs9u2zb8Pdi602jJ3bVNkhviiTCa80imwOc3O
 SCqqKplGzrXx3vhyoDVUYV74SGxlPS9tykY9uFVfk1vvqapsKOgPv2+LUFCglF+i24i3
 HcLcC4/EyZN0SduqxedJuThyOxuanOoO+LpBXZbVf7RE59g+mb6QQ3g352f55Za7edYA
 c1jg==
X-Gm-Message-State: AOJu0Yy6rrSjeesSzZ29SyMDnpSHWs0GOx9llC/kiHcFE3rJN3tnqMrh
 MJRhGZijwf2SgelJ6fGBW8WA77fCvx1VxZ1+iCyhV2Fmw+BhcUuswjdZ7IqMQ8sMMbJKCQSWJ3E
 RlRvv0sStF+sa7OsWvXtdXvrrhxOaJe4+cHwjP/wi6WOcrJRXhFil
X-Received: by 2002:a5d:698b:0:b0:367:9088:fecd with SMTP id
 ffacd0b85a97d-36b5cee2e4emr5251006f8f.7.1722256175283; 
 Mon, 29 Jul 2024 05:29:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeoXJnACuhaOBERrsZqdRmBWKpabnGs5regVIs3AuxVrMGHjcFAaV/fk5WMdAOvhe8d01GBw==
X-Received: by 2002:a5d:698b:0:b0:367:9088:fecd with SMTP id
 ffacd0b85a97d-36b5cee2e4emr5250992f8f.7.1722256174814; 
 Mon, 29 Jul 2024 05:29:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93594b6sm220493395e9.5.2024.07.29.05.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 05:29:34 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:29:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, David Hildenbrand <david@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Markus
 Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
Message-ID: <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
In-Reply-To: <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, 20 Jul 2024 16:28:25 -0400
Steven Sistare <steven.sistare@oracle.com> wrote:

> On 7/16/2024 5:19 AM, Igor Mammedov wrote:
> > On Sun, 30 Jun 2024 12:40:24 -0700
> > Steve Sistare <steven.sistare@oracle.com> wrote:
> >   
> >> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
> >> on the value of the anon-alloc machine property.  This affects
> >> memory-backend-ram objects, guest RAM created with the global -m option
> >> but without an associated memory-backend object and without the -mem-path
> >> option  
> > nowadays, all machines were converted to use memory backend for VM RAM.
> > so -m option implicitly creates memory-backend object,
> > which will be either MEMORY_BACKEND_FILE if -mem-path present
> > or MEMORY_BACKEND_RAM otherwise.  
> 
> Yes.  I dropped an an important adjective, "implicit".
> 
>    "guest RAM created with the global -m option but without an explicit associated
>    memory-backend object and without the -mem-path option"
> 
> >> To access the same memory in the old and new QEMU processes, the memory
> >> must be mapped shared.  Therefore, the implementation always sets  
> >   
> >> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
> >> user must explicitly specify the share option.  In lieu of defining a new  
> > so statement at the top that memory-backend-ram is affected is not
> > really valid?  
> 
> memory-backend-ram is affected by alloc-anon.  But in addition, the user must
> explicitly add the "share" option.  I don't implicitly set share in this case,
> because I would be overriding the user's specification of the memory object's property,
> which would be private if omitted.

instead of touching implicit RAM (-m), it would be better to error out
and ask user to provide properly configured memory-backend explicitly.

> 
> >> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
> >> as the condition for calling memfd_create.  
> > 
> > In general I do dislike adding yet another option that will affect
> > guest RAM allocation (memory-backends  should be sufficient).
> > 
> > However I do see that you need memfd for device memory (vram, roms, ...).
> > Can we just use memfd/shared unconditionally for those and
> > avoid introducing a new confusing option?  
> 
> The Linux kernel has different tunables for backing memfd's with huge pages, so we
> could hurt performance if we unconditionally change to memfd.  The user should have
> a choice for any segment that is large enough for huge pages to improve performance,
> which potentially is any memory-backend-object.  The non memory-backend objects are
> small, and it would be OK to use memfd unconditionally for them.
> 
> - Steve
> 


