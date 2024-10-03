Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59563CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swNB6-0005v0-GI; Thu, 03 Oct 2024 10:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1swNAw-0005uN-CI
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1swNAu-0003RR-Fq
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727967087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFOC5ltxjnukHbOiTZnLdPhdjlEFGzr/Dkn5csRqcok=;
 b=FDtK/xN88MSfVgz0opIvRwHSeukVAdOnKoQUuLfITDSLunS1Nan4IHTkAS3ZMjqUVdSh5t
 o62CRvNYaG2UQ9qxWLOhhHnO3GcZaelHkUnGmM5teocnk19Nc+t6jERYt+FWxoBhWA5n8v
 zwaNrCFWTu1ZKYrk2J+Ua5t0ffV1G4o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-6R4OGSTCN5-lpsi05erGnQ-1; Thu, 03 Oct 2024 10:51:25 -0400
X-MC-Unique: 6R4OGSTCN5-lpsi05erGnQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42f310f0ed2so8818985e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727967084; x=1728571884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFOC5ltxjnukHbOiTZnLdPhdjlEFGzr/Dkn5csRqcok=;
 b=J8XJpC7u6fwS8v+7fj9y8heNZcJSRTSaoaaFLkefosy3i0oGEncUYACW2D5PP/kpkM
 bNhhWTqXyt5cDUyPFuIEhuidMWuk/ek36kOj1kNH71GiA/FUHXKmVoVGBQam1fxccOXs
 oNge2ng+lvNwFf/miWCHENtO7HozIN+AceKnl295fgidlQ28lXfNBE0HZkAj+TSwDZoT
 C+AXfZff0TcKC9B5F1whFARjiS0PKWI8kKg9RQR2pfYDFezzQ2bR8F+0gnJkFrfWrhBI
 v2eAfHAvZALp0Yo07QJmqURBMMURnLeBOOjyVBQeE0jy2saMmmIc8VIBGRDDzaitDfG6
 /v2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHV7Pzfb4LRhkfnJjSF2XWjJy8/slGKvmP0lv9CEFybJoxr4z5HTNAPs6SMASi9qPBC1eMPE/epWj3@nongnu.org
X-Gm-Message-State: AOJu0YwQM2Aozl9jra8r2s+dmov/QzXiL035S8eVuxcbhoFB+1/4j4/0
 yUi4megMMkg7Xk0tKgXhxuG3ydVv6OKxS5FlMprww2XoLPSIPov5BLn0lkGFNjCsp4/dx6r4XwP
 XnXf6fLWRQdVeu9MUgp3KD2ijzYNeru1koEmSTZ61bVzURax4iT8o
X-Received: by 2002:a05:600c:1c26:b0:42c:b77a:bd21 with SMTP id
 5b1f17b1804b1-42f777f00e0mr60514335e9.28.1727967083973; 
 Thu, 03 Oct 2024 07:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ6G3k/NxXaYRH9TBJ2crwndAkg4Z4yJNGSH7D8/wlS2L/LsF4ysezGdqf2xJL5nGToZ36Hg==
X-Received: by 2002:a05:600c:1c26:b0:42c:b77a:bd21 with SMTP id
 5b1f17b1804b1-42f777f00e0mr60514045e9.28.1727967083570; 
 Thu, 03 Oct 2024 07:51:23 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f802a0216sm17413925e9.33.2024.10.03.07.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:51:23 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:51:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 07/21] acpi/ghes: rework the logic to handle HEST
 source ID
Message-ID: <20241003165122.542dd026@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241001135759.474452d8@foz.lan>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <0dd7081717b23b4c1536bc86abfa926388cf2139.1726293808.git.mchehab+huawei@kernel.org>
 <20240917135934.38579213@imammedo.users.ipa.redhat.com>
 <20241001135759.474452d8@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 1 Oct 2024 13:57:59 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 17 Sep 2024 13:59:34 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Sat, 14 Sep 2024 08:13:28 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > The current logic is based on a lot of duct tape, with
> > > offsets calculated based on one define with the number of
> > > source IDs and an enum.
> > > 
> > > Rewrite the logic in a way that it would be more resilient
> > > of code changes, by moving the source ID count to an enum
> > > and make the offset calculus more explicit.
> > > 
> > > Such change was inspired on a patch from Jonathan Cameron
> > > splitting the logic to get the CPER address on a separate
> > > function, as this will be needed to support generic error
> > > injection.    
> > 
> > so this patch switches to using HEST to lookup error status block
> > by source id, though nothing in commit message mentions that.
> > Perhaps it's time to rewrite commit message to be more
> > specific/clear on what it's doing.  
> > 
> > now, I'd split this on several patches that should also take care of
> > wiring needed to preserve old lookup to keep migration with 9.1 machines
> > working:
[...]


> >  6. cleanup fwcfg based on x-has-hardware_errors_addr,
> >        i.e. for 'true':
> >           ask for write pointer to hardware_errors like it's done in current code
> >           and don't register hest_addr write pointer
> >        while for 'false'
> >           do opposite of above.  
> 
> This doesn't work. without the fw_cfg logic for both, QEMU/BIOS won't boot 
> and/or the hardware_errors won't work, causing ghes to do nothing.

we should look more into it,
only 1 of them hest_addr(9.2+) or hwerror_addr(9.1) is necessary
so if it breaks, it looks like a bug somewhere to me.

> 
[...]
> 
> 
> Thanks,
> Mauro
> 


