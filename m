Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FDDF589D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFu18-0002RO-Jp; Thu, 23 Apr 2026 09:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFu17-0002R0-Dn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFu13-0006eJ-GO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776950566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DfCH5Z07qyMyxYDVBvwks0o4DrO8Yc41upKqB1tbsvE=;
 b=KF4htlZgivpxvi75U4ZtTC8AYJUV5kwrEPCvGE43EwXVSyP0vRrD/71uhzTHnDrQHelcPK
 6oJq4lziUzOJATngsG8dwPET0zVO4UZiWwdpCJ/IXGga3Sf/cRPjGWhjORBt3efbUcj3Rr
 BIwKmXhx5dQR5bqKfFDHTyoQAP0betc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-iPhRjTb_PluwC9k7uH9NMQ-1; Thu, 23 Apr 2026 09:22:45 -0400
X-MC-Unique: iPhRjTb_PluwC9k7uH9NMQ-1
X-Mimecast-MFC-AGG-ID: iPhRjTb_PluwC9k7uH9NMQ_1776950564
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8abd6e281c0so182805786d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776950564; x=1777555364; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DfCH5Z07qyMyxYDVBvwks0o4DrO8Yc41upKqB1tbsvE=;
 b=A5pvbgV7id3oqtQiAovdYkd4q46YsDNE6hW98Ax+YxSJuMarr2nAhRD5Tuqv0H+o/6
 5bfHVq0swZOLLm01ixW9H+h7u81MVJ4z5Lvu2UR51O68j7qBtohLMQ6VHNjR6r2Cy+k8
 vLxl2e/wzZjl/zYVMoB+2QBXj8I4krckzZoCyboOFKvtIhc4B+QgVhhZOd6gyFDnfDg3
 Yljpn9X802XkGzGjBnbDZI12QMVuzhG1o7Et4O4VHslsQaqsAWPzPQGEJ4SJ++BlQ2+b
 ZomqiRHnysCh3TL75Npvkqcjzknq5I1fPu32+FIHWrdEOjzA+VHFA/g5SFpy5C5tanG6
 ox/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776950564; x=1777555364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfCH5Z07qyMyxYDVBvwks0o4DrO8Yc41upKqB1tbsvE=;
 b=jApUH6cHMeylSD6u7KtTNkqVQ45pdTXJTGCt3itEqA2tL57PQk45NnNL/kVNvcIZ9I
 AudcozsWW16VaXMffJLJSB+LE+zd0siuGUqpR8mXDe/skQ46g9mGAG4la5TKJdsRNIlW
 x87LiqgO1Zt0rcJc7sKqfAXIykMUYOWbJOWnGzIQYCb2QTLDAnKVkr2yE84yqSEHeM7E
 LUf7VqSwxyiK/XVVg6JqnwanE+c8oCOB2yyvfewMP76+x6zULWpZEBXMwrn0D7JuDgwz
 s1tmU1RHzBRIhw/WLXN//YWaoNy4vPFCOzSzv03x8Tl6Fqa/uN/9cnnELScYl6Ze3Ota
 MQlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Kh7u64Im3L0DH6mMFTmX4JDZKs83pRkOvmEo4OMFylgQdnc04KQZGV6jbyqxLAcPmux0d12TqA2JW@nongnu.org
X-Gm-Message-State: AOJu0Yxv0KPcPJaw5vZ2oexdy3VwJjYO2ziXq/oqIGmWj/OoV24x4PQ9
 QZ7LkD5sTMZr0ZUFmwlNrSKfjOVtyYsbbwtws1NXzsJJehzevqa2W8lUTURhCwbHVIIzdYaZZpE
 PMzFA1/Fzpg1mX8zDHwAKysvHCrycZSkFTnLpJnQh0+By5fir/uzGcwMI
X-Gm-Gg: AeBDiesjaP1TWZ4UtPUczki8v04hld7eVqqXivlmuBfWYYkz46YtH7k+3eyYiXKE37f
 OC1xUaphgNJvBKz8cLA0DER8zTfanZVvnDX1hiOI6dusPr2BQRRAhzsnWVWxfy8RI4AJTYgP3Yi
 XWXiCYyISmTnTASeoRQkwXZMYhqH7jremRkcJvqvzwrH9ZGqDJvacZDPoN2bZRPgIAOCESivtON
 Hy1LX4r36XC4TYkg7gEe8FN5Zjblx43QOlt7CpTP4rOTEhGuMpKhLxSi9pIhRPeW7pMlhNeJZm3
 Y3WbTvHk8QhKBmgUj0e6ZCUFrteVyupjepIlsx6RvLtUfhpx+HrsCa/ESaOhpG8uzeD0RauzgAj
 5MxhUX+BtAOKQqyG8JMfmY3kaz/ALli3nJpj22N7qR2899DsDrWEmFrjBfQ==
X-Received: by 2002:a05:6214:27ee:b0:8ac:b1ad:3a29 with SMTP id
 6a1803df08f44-8b02816b33emr423689486d6.35.1776950564454; 
 Thu, 23 Apr 2026 06:22:44 -0700 (PDT)
X-Received: by 2002:a05:6214:27ee:b0:8ac:b1ad:3a29 with SMTP id
 6a1803df08f44-8b02816b33emr423688896d6.35.1776950563884; 
 Thu, 23 Apr 2026 06:22:43 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac7834esm153455646d6.18.2026.04.23.06.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:22:43 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:22:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Claudio Fontana <cfontana@suse.de>, Trieu Huynh <vikingtc4@gmail.com>,
 qemu-devel@nongnu.org, Jim Fehlig <jfehlig@suse.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
Message-ID: <aeodIPAxxCK-D3Qk@x1.local>
References: <20260405152612.93027-1-viking4@gmail.com> <878qb05gq7.fsf@suse.de>
 <ada038hgmY9hNqPK@x1.local>
 <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
 <ad1a9GaGQFHS4UHx@x1.local> <87ldeeehpm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldeeehpm.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 22, 2026 at 07:46:45PM -0300, Fabiano Rosas wrote:
> I came to the thread to suggest this, but I see you already mentioned
> it. I'm not sure what you mean by "forward", but I was actually thinking
> "migrate". Do we have precedent for migrating a QAPI object? Do we want
> to have it? =) Put that MigrationInfo at the end of the stream and we'd
> have a nice symmetric interface for query-migrate in both src and dst.

Do we need to "migrate" it, say, using VMSD data structures?

We could, but I'm not yet sure if it's a good idea, especially if we should
make that as part of ABI.  It may add some unnecessary burden to us.

> 
> (we have plans to deal with QEMU_VM_VMDESCRIPTION at some point anyway,
> we could maybe rework that end section into something useful)

That might still be a bit early phase to contain all the stats info. For
example, the real downtime needs to be calculated until src receiving the
ACK, that should be after dest receive QEMU_VM_VMDESCRIPTION, IIRC.  So if
we want to at least forward the downtime info, that might be too early.

In all cases, I still think we should evaluate libvirt solution before any
other explorations.. because so far we still don't know why it can't be
done, and it's the simplest afaiu.

-- 
Peter Xu


