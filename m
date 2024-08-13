Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB44C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 19:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdwnK-0006aB-BM; Tue, 13 Aug 2024 15:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdwnI-0006Yo-Eg
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 15:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdwnF-0002la-VG
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 15:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723575768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMRA68p/vmRGdNYlG3Xw4Elr0Q/GFG/009gC0WkXZ7E=;
 b=HuYLzPER7+OmRNKJKQTFzm/rX4giRULXmP5AiZsQUte0ZSo0ntVuyiReL+DBFB8GD45sCr
 2JEkLq8TFBmO96fXsA8f1zode8XahMTYY619ceRTDN+S8isI/YIz4EZtCghnG/sqXzJER0
 98dVZ+BKp1HXV1uAWR76OsbPHX2l1MQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-VyquKcW5Ooac6Qu0M2YWjA-1; Tue, 13 Aug 2024 15:02:47 -0400
X-MC-Unique: VyquKcW5Ooac6Qu0M2YWjA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ba92dd246fso12019966d6.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 12:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723575767; x=1724180567;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QMRA68p/vmRGdNYlG3Xw4Elr0Q/GFG/009gC0WkXZ7E=;
 b=B/u3PK9Ig3W/gUUhDMpleVFHb9GIUOGT0lfT/CJZ1ZNgOTi0tr0Q2nH3Nw0jyl1QPL
 5Cx5gVcsbiWXCNMDMBoGoFPFA17hcsr1A+5eAMSayYMCGtOG0WNlrDplQzodgOHjxrDj
 8UqsMM96NlX+UVoGYBWMfkdRumvvn/gQ/N3fIr9LVtRjX3cFM+a4sw4yg7R69C6NJdkB
 7cmfvceN2VOfNoGrHD0IkxAE+ousqhETik70VEFe2donUymcoY9W2inFu724YDWQdY5B
 zzBSACIraFhXLAAIylTymaLsaH1xneBOjNbHUENk2DBnIrWJz8+LY3r70yPpqI3WYnmn
 BFKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3/DwKZmDcB1Shzu47oD3PXxO+SrJBtrJKMoH+NLqb/pq4c9vY0gy2ovmVj6+QA2np4UKgiEaXoHYj@nongnu.org
X-Gm-Message-State: AOJu0YxUsUggSNpBu2jpgP91yXo+HFNXm+I4Yo0lCi93VmKe4KrbLJa2
 fq/m3TNSHHKPMKcAOdweGgYMpkB+K20IKDlaEUPanl5ix/HaxagQel3WYuh/hZNn7izvmWahR0P
 RuxoJ2GltTAotXa140Grfz27AEAsH3vvDDhL+O5gyvAH1BRXM31kD
X-Received: by 2002:a05:6214:c48:b0:6b7:7832:2217 with SMTP id
 6a1803df08f44-6bf5d17ca44mr3109886d6.3.1723575766627; 
 Tue, 13 Aug 2024 12:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBwn4ldLRutRi0KidqLOrqct5ZofbObTRKDk0fpabAvoux0RXAIwUsXRMU3e69QWIFI7oxfQ==
X-Received: by 2002:a05:6214:c48:b0:6b7:7832:2217 with SMTP id
 6a1803df08f44-6bf5d17ca44mr3109716d6.3.1723575766268; 
 Tue, 13 Aug 2024 12:02:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bd82ca19efsm36499616d6.73.2024.08.13.12.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 12:02:45 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:02:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
Message-ID: <Zrut0yNhCoXfRcGa@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
 <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
 <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com>
 <Zrt9M00rDk3EUdNM@x1n>
 <7f7af1e5-f1b4-40bb-b114-45932d38b0db@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f7af1e5-f1b4-40bb-b114-45932d38b0db@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 13, 2024 at 01:34:42PM -0400, Steven Sistare wrote:
> > > > Non memory-backend-objects (ramblocks not described on the qemu command line) will always
> > > > be allocated using memfd_create (on Linux only).  The alloc-anon option is deleted.
> > > > The logic in ram_block_add becomes:
> > > > 
> > > >       if (!new_block->host) {
> > > >           if (xen_enabled()) {
> > > >               ...
> > > >           } else if (!object_dynamic_cast(new_block->mr->parent_obj.parent,
> > > >                                           TYPE_MEMORY_BACKEND)) {
> > > >               qemu_memfd_create()
> > > >           } else {
> > > >               qemu_anon_ram_alloc()
> > > >           }
> > > > 
> > > > Is that acceptable to everyone?  Igor, Peter, Daniel?
> > 
> > Sorry for a late reply.
> > 
> > I think this may not work as David pointed out? Where AFAIU it will switch
> > many old anon use cases to use memfd, aka, shmem, and it might be
> > problematic when share=off: we have double memory consumption issue with
> > shmem with private mapping.
> > 
> > I assume that includes things like "-m", "memory-backend-ram", and maybe
> > more.  IIUC memory consumption of the VM will double with them.
> 
> The new proposal only affects anon allocations that are not described on
> the command line, and their memfd will be shared.  There is no
> command line option which would set share=off for these blocks.
> 
> "-m" and "memory-backend-ram" are not affected.
> They will not work with CPR.

Hmm yeah memory-backend-ram should be TYPE_MEMORY_BACKEND for sure.. and I
just noticed "-m" looks like the same.

Though this change still gives me the feeling that we don't yet know who's
the target of this change at all, and what purpose it services.

I'll see how others see this.  For me, at least in this case I think it'll
be nice the "else if" will not be used unless cpr is enabled in the first
place.  But that's still a bit hacky to me.

Thanks,

-- 
Peter Xu


