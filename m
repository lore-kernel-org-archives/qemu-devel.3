Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4247FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seyy5-0002J4-SS; Fri, 16 Aug 2024 11:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seyy4-0002IY-CM
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seyy2-0001b5-Jv
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723822455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9RtqEswVmPxQ+vIIwqYss5Erzk/MhyDzg6O3ZT/S40=;
 b=It8MRCr68bwTdAXrKfBTxgMMwnX3HFgEqwu/cZiMJ3CcbcLHBiICL2DbkUe2gL/OJl2eEm
 TW11sLHza6KMvwzcbumtbkdHo6HQ0NF2XKS94S5g2nKkl4NBPpszvZ/BQeIOn3wC++jCyH
 UGtGm7lr3GsxTyDUoNSwkb3xK6HB+KU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-YZP2IC-RP9-hkY8_M0gyug-1; Fri, 16 Aug 2024 11:34:14 -0400
X-MC-Unique: YZP2IC-RP9-hkY8_M0gyug-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5d5bb101d53so318883eaf.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 08:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723822453; x=1724427253;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B9RtqEswVmPxQ+vIIwqYss5Erzk/MhyDzg6O3ZT/S40=;
 b=qt21NgCRL4qNt9PS/5hBd07tmfj02lCLIxeQEFI1rICnC0TyFYscSbI0pmEr9KfHnb
 WAQvcZBjVfaUXzE7kr1hWVtjTUt7Apf066++a1j9wlaunXm44/ZWVC7Fl+DrDsJUP3eI
 oNMPb6Piv7xWqLcEtBBo+mFcHKLywV6C5ME0T5Eak6owspv8nRCCZxp9z2bRYHf/4lmr
 +agKoOmwf1oxQsdpwxTmO234pofyCPQG0ZMngjEqTfVaTXY39ALc6uTX6jFh3RDQsNi1
 zovVJDax2t0Bah4mKnORSbad6VqmboNBAKqCEdnxqba/+AgBtRY+lUSpvAjHiMncyu1z
 vMsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4nx6EhwHQ8rWxjAKm0ohivaTjMC334vbFl9Kkwf42x0tuN6WuZ656MtQ0LzW+chQlCx4TLW/5ow5Q@nongnu.org
X-Gm-Message-State: AOJu0YwbOG1o6SvYQ02PFmCXCtpoZqDGdi5SA2OiP08rbt7YweZyHe6L
 8S2WmZoaaE/bbDtQC4+AyaQFRL8fOsPoJAoYVOyPQkSCed/wBt5L3MOb9QUjpfh+CUtHs6XfDbG
 k2hwQ4ugO8sIsS+xJjcJWX+aU6huw8K+qCDV18SOiWaRc8NoQsLusT0K3KZ0m
X-Received: by 2002:a4a:de16:0:b0:5d8:5a15:146b with SMTP id
 006d021491bc7-5da97d404d8mr2305287eaf.0.1723822453115; 
 Fri, 16 Aug 2024 08:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZvso1gtwMuoYctZvI9hzfBib7AGHir6ww53Ue+ruIjP1yqSr7E44jW1OXZM39DGnvVrlUYw==
X-Received: by 2002:a4a:de16:0:b0:5d8:5a15:146b with SMTP id
 006d021491bc7-5da97d404d8mr2305276eaf.0.1723822452703; 
 Fri, 16 Aug 2024 08:34:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fdd9c68sm18637636d6.3.2024.08.16.08.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:34:12 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:34:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zr9xcmUfkYAWnXH-@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n> <ZrCi8DWCKFiBHQAQ@redhat.com>
 <5776f6b4-c55f-4e56-aac5-bee7e441ad15@oracle.com>
 <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
 <Zr9q4muKZmYCf9mv@x1n> <Zr9tYsmy8j2t8fq0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr9tYsmy8j2t8fq0@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 16, 2024 at 04:16:50PM +0100, Daniel P. Berrangé wrote:
> On Fri, Aug 16, 2024 at 11:06:10AM -0400, Peter Xu wrote:
> > On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
> > > On 8/13/2024 3:46 PM, Peter Xu wrote:
> > > > On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
> > > > > > The flipside, however, is that localhost migration via 2 separate QEMU
> > > > > > processes has issues where both QEMUs want to be opening the very same
> > > > > > file, and only 1 of them can ever have them open.
> > > > 
> > > > I thought we used to have similar issue with block devices, but I assume
> > > > it's solved for years (and whoever owns it will take proper file lock,
> > > > IIRC, and QEMU migration should properly serialize the time window on who's
> > > > going to take the file lock).
> > > > 
> > > > Maybe this is about something else?
> > > 
> > > I don't have an example where this fails.
> > > 
> > > I can cause "Failed to get "write" lock" errors if two qemu instances open
> > > the same block device, but the error is suppressed if you add the -incoming
> > > argument, due to this code:
> > > 
> > >   blk_attach_dev()
> > >     if (runstate_check(RUN_STATE_INMIGRATE))
> > >       blk->disable_perm = true;
> > 
> > Yep, this one is pretty much expected.
> > 
> > > 
> > > > > Indeed, and "files" includes unix domain sockets.
> > > 
> > > More on this -- the second qemu to bind a unix domain socket for listening
> > > wins, and the first qemu loses it (because second qemu unlinks and recreates
> > > the socket path before binding on the assumption that it is stale).
> > > 
> > > One must use a different name for the socket for second qemu, and clients
> > > that wish to connect must be aware of the new port.
> > > 
> > > > > Network ports also conflict.
> > > > > cpr-exec avoids such problems, and is one of the advantages of the method that
> > > > > I forgot to promote.
> > > > 
> > > > I was thinking that's fine, as the host ports should be the backend of the
> > > > VM ports only anyway so they don't need to be identical on both sides?
> > > > 
> > > > IOW, my understanding is it's the guest IP/ports/... which should still be
> > > > stable across migrations, where the host ports can be different as long as
> > > > the host ports can forward guest port messages correctly?
> > > 
> > > Yes, one must use a different host port number for the second qemu, and clients
> > > that wish to connect must be aware of the new port.
> > > 
> > > That is my point -- cpr-transfer requires fiddling with such things.
> > > cpr-exec does not.
> > 
> > Right, and my understanding is all these facilities are already there, so
> > no new code should be needed on reconnect issues if to support cpr-transfer
> > in Libvirt or similar management layers that supports migrations.
> 
> Note Libvirt explicitly blocks localhost migration today because
> solving all these clashing resource problems is a huge can of worms
> and it can't be made invisible to the user of libvirt in any practical
> way.

Ahhh, OK.  I'm pretty surprised by this, as I thought at least kubevirt
supported local migration somehow on top of libvirt.

Does it mean that cpr-transfer is a no-go in this case at least for Libvirt
to consume it (as cpr-* is only for local host migrations so far)?  Even if
all the rest issues we're discussing with cpr-exec, is that the only way to
go for Libvirt, then?

-- 
Peter Xu


