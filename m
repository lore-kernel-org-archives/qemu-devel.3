Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0197C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seyX4-0006ae-Fa; Fri, 16 Aug 2024 11:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seyWz-0006Yu-7t
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seyWu-0006NE-Tj
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723820774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E3KC6rF1jt182BaYrTc0ZcHki6d26eYQ0/S1Xo0Wfdk=;
 b=NnSXiZU4m1qPM982yNrxBAqCHuKkO3dTG2oxOB+CVz3PkoGZNXtm5TpWXbCNVw0mlp4HrA
 JSTEWn3Q++tP/fq83IGp3LYmj0AyMJnyYMgPGgdAfog5TOCbr0L7QPnT6yvG5S6CZ6FJqR
 TtZN62unTnkIvGOQk3f37c7n1rfIFTw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-MvUewqN5O6ubNlmLUQmqow-1; Fri, 16 Aug 2024 11:06:13 -0400
X-MC-Unique: MvUewqN5O6ubNlmLUQmqow-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6bf6f1ad75cso4441776d6.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 08:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723820773; x=1724425573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3KC6rF1jt182BaYrTc0ZcHki6d26eYQ0/S1Xo0Wfdk=;
 b=meNI/nQrB+M0eDICm9MSXOkvahko/T5xSoXCG1ohNgatA9TcjbVoIMKNt6WlPgvDje
 q57L3Z0zp1t50v5EAQaNcwCw9Gb2Nwm52YtsR2gciuPl7Jb6m89dT/RRUyCM51JtiF5d
 qPkPIbkuxfOe9DJC7dBNCvo5fiaO8ueYaTA92Zju3pTABO/QSF4s/dePK7JkcBT/LqnL
 rcDB9T95ZHxN9wSs47I/C8yjjAOefqNYMO8yD59PkOLaQzc8zYZqAiVKnDu+zrzxz+h/
 wmI63OkiNRrUHN1Vazw4sdk2IVZQHl33nwrfjfN+jIEAkVNr18KFn1k6uGNzuZ3Aty+h
 g3QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7raP059l4AKPnxB3l6Sfd5saubgGniNUcfkXMZp69i0iuhLawathsnhjLN75LgLAj+32Y2qcf3cq8@nongnu.org
X-Gm-Message-State: AOJu0Yx4RX9jrnIwa+cRyxou8RLU06QLBZZma6uTsMGFZjJYHpi87oEj
 OkZRU9sXrygsoLS3Sdp1fcWstg9Hy/l0Z81ZzJY4q+/WpvMna3fp4y/11I2ihxvDrl/7wbIfnf1
 qRz7gFP5iW1iqHLKCImK2UgYBaaxtZ7ZIQLt8o99VUTW8mVyazh9R
X-Received: by 2002:a05:622a:2c9:b0:44f:d7b5:a665 with SMTP id
 d75a77b69052e-4537419cc08mr19736501cf.1.1723820772791; 
 Fri, 16 Aug 2024 08:06:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+wycdqYUXMU2ZCYxW6FL4s6cbJpJmuiamKptDzS0VHI2F1iWFmUZvbq99xsPI9oHSlJ0QkQ==
X-Received: by 2002:a05:622a:2c9:b0:44f:d7b5:a665 with SMTP id
 d75a77b69052e-4537419cc08mr19736241cf.1.1723820772285; 
 Fri, 16 Aug 2024 08:06:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4536a072683sm16936571cf.85.2024.08.16.08.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:06:11 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:06:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zr9q4muKZmYCf9mv@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com>
 <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
> On 8/13/2024 3:46 PM, Peter Xu wrote:
> > On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
> > > > The flipside, however, is that localhost migration via 2 separate QEMU
> > > > processes has issues where both QEMUs want to be opening the very same
> > > > file, and only 1 of them can ever have them open.
> > 
> > I thought we used to have similar issue with block devices, but I assume
> > it's solved for years (and whoever owns it will take proper file lock,
> > IIRC, and QEMU migration should properly serialize the time window on who's
> > going to take the file lock).
> > 
> > Maybe this is about something else?
> 
> I don't have an example where this fails.
> 
> I can cause "Failed to get "write" lock" errors if two qemu instances open
> the same block device, but the error is suppressed if you add the -incoming
> argument, due to this code:
> 
>   blk_attach_dev()
>     if (runstate_check(RUN_STATE_INMIGRATE))
>       blk->disable_perm = true;

Yep, this one is pretty much expected.

> 
> > > Indeed, and "files" includes unix domain sockets.
> 
> More on this -- the second qemu to bind a unix domain socket for listening
> wins, and the first qemu loses it (because second qemu unlinks and recreates
> the socket path before binding on the assumption that it is stale).
> 
> One must use a different name for the socket for second qemu, and clients
> that wish to connect must be aware of the new port.
> 
> > > Network ports also conflict.
> > > cpr-exec avoids such problems, and is one of the advantages of the method that
> > > I forgot to promote.
> > 
> > I was thinking that's fine, as the host ports should be the backend of the
> > VM ports only anyway so they don't need to be identical on both sides?
> > 
> > IOW, my understanding is it's the guest IP/ports/... which should still be
> > stable across migrations, where the host ports can be different as long as
> > the host ports can forward guest port messages correctly?
> 
> Yes, one must use a different host port number for the second qemu, and clients
> that wish to connect must be aware of the new port.
> 
> That is my point -- cpr-transfer requires fiddling with such things.
> cpr-exec does not.

Right, and my understanding is all these facilities are already there, so
no new code should be needed on reconnect issues if to support cpr-transfer
in Libvirt or similar management layers that supports migrations.

I suppose that's also why I'm slightly confused on how cpr-exec can provide
benefit for mgmt layers yet so far with these open projects.  It might
affect Oracle's mgmt layers, but again I'm curious why Oracle does not
support these, because if that should support normal live migration, I
thought it should be needed to support changed ports on host etc..

-- 
Peter Xu


