Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D665BCCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 14:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH12T-0008Ly-EB; Thu, 06 Nov 2025 09:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vH12N-0008K1-CI
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:32:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vH12J-0005kV-M6
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 09:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762439545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iH/u78Yn1gdXcehix/fpXUcBGOTBioZ+JnzyJrUEyWM=;
 b=X7JHQNaVu/7N8/ZsPYIB+2WL/8TG4hKR567xwekx5LHlVAXTraa6UurI54uGSqeNJysYSZ
 hR+Dser84zY6/bpH6BPdjQ905+dbxaOGknq8Du4y2vLUm1Vomq/wJrFmr2jAdw1vrB5q9Z
 Jt0EURiXMk+Ptp7ARx1vG8Dbli63OLc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-tcYzcB7uOy2g8-t58wy9ww-1; Thu, 06 Nov 2025 09:32:24 -0500
X-MC-Unique: tcYzcB7uOy2g8-t58wy9ww-1
X-Mimecast-MFC-AGG-ID: tcYzcB7uOy2g8-t58wy9ww_1762439542
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429f0907e13so343401f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 06:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762439542; x=1763044342; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iH/u78Yn1gdXcehix/fpXUcBGOTBioZ+JnzyJrUEyWM=;
 b=PGeqn5RrxUqJ31izGI+TfP55f3+VNowNKhNoyl78ZiAgX3A/s2d81PZCFj/EpvIhAl
 +vVBLwtz0i5a8DdRgoaw676nia9wBblP5O4/GllPHZCRXJ0KjLIpyl49V+4YTuaFDhoS
 OK+fdI5jOoqb6VW7lTrwgYdtvgJIjppFjaXZKxHRribbUXee8kdMRQ6NGs7BPkIfEQkP
 n4yN22kVIq4sBgdY8d0f3UpO4Gsgeac2ACRqS0bHvpC/JIfB668vUS4/s7/ddUU1B1zh
 BMSFDZkEU5xQZnri1epbCvuSQzYaUK0JHSfpibYm9mKcWJ/kDEYsTOG2LJM/VRIN6iIL
 XFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762439542; x=1763044342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iH/u78Yn1gdXcehix/fpXUcBGOTBioZ+JnzyJrUEyWM=;
 b=EuJbKwDP0RDQaUgFuOQuo9KmgZbctVTyAo6Gyis3BfenfiyR7CzxuXbYYRhtBwc+/R
 0NuVwBc9On4O12ADDd1N1nWADP2rKDQFCTFEFzQiVb0/KEIQ8iD/fNDi7gzVVe6KP8SW
 EoEAAlIjr6wQZVYjrEJ95zlVsHMx0s23iL23h4hDSdMUhtbNCphO+hw4hVV/K+Nj95ko
 xnBEnUDQfCabEJvZx8q+yHdos5NSrBmdZ4q/GyqYR3gRYYJrpw31GDM3ERcgpecsdKKF
 w9LWmQ0v9W6AEJO1+AEdgWOlMLr31fwODVYrIGHiT8CUnVKwcEEqmrrb77VUU2c4RpHM
 tbYw==
X-Gm-Message-State: AOJu0Ywre/H5iW9/2Lo8K6AitH15B9YdTD4+DP52XtgjfLHJ858/gK6B
 6AqA9u2SEXJBhm0NwJVajk7ul106ER6gjt5GOsPgIUlSNbh8EJZpQzwpbR8fsiTsCRPpTsLr9zZ
 g5o5ANNJgnBOTZLpX137aJIUjxt6QceaO6n5PG0k+IdbvkX0kJUCVB5eR
X-Gm-Gg: ASbGncsXD3+S1XS246OLzLMvAbSzllNE++SKf1VO9zLQPsMGcbeAGF3UMpGtcbSDzFm
 peq2pkNVF0TApjTOR1eT9vlKnwWG/bqzEvWhG5j4+GzESAvISHImCXz5A0iHNd/gBVlCOQ4D4yC
 UJAvNgdzOcftHC9soqxTkspOxgSLhiZCCGmAs/WTka/Xfuqbiy35Jvr35KqgADf21F9/pSI09z6
 zQ6iwy4ffHqIt4Zxp+l4bBBYmCj0a4qfZLKwEiJphelDBqfs32Rw4nrhQ0hFdsyKjjZ6of//iiR
 OETEjrnakXf98SaSxMDIW+1rv0zz06v0xoqZl6DEWIiQ3EU37sROfTYsd6HMohevk01o5Fo1GWo
 isQ==
X-Received: by 2002:a05:6000:641:b0:427:603:715 with SMTP id
 ffacd0b85a97d-429e32e468bmr5345712f8f.18.1762439542106; 
 Thu, 06 Nov 2025 06:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6ZbjgDx/LRerXtliRAW1ebDp/cemckfkUjYUktLCitYiqURjwOymIox8RQiiq3G80CDy0MQ==
X-Received: by 2002:a05:6000:641:b0:427:603:715 with SMTP id
 ffacd0b85a97d-429e32e468bmr5345683f8f.18.1762439541664; 
 Thu, 06 Nov 2025 06:32:21 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb477203sm5542734f8f.29.2025.11.06.06.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 06:32:20 -0800 (PST)
Date: Thu, 6 Nov 2025 15:32:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Robert Hoo <robert.hoo.linux@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: vsock support for communication between guests
Message-ID: <pkglizwznrfj6fm7tdyew4tzmomgtp2cetxwfj2fx7ge4vtwhv@kdlj2jdxqheo>
References: <1943ea16-c3cb-4442-be72-5719026ee13a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1943ea16-c3cb-4442-be72-5719026ee13a@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

On Fri, Oct 10, 2025 at 09:00:21PM +0800, Robert Hoo wrote:
>Hi,
>
>Does vsock support communication between guests?
>From man page, and my experiment, seems it doesn't.
>But why not?
>

It depends, vhost-user vsock device, supports it.
See 
https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#sibling-vm-communication

The vhost-vsock in-kernel device doesn't support it.

The main problem is that vsock is designed for host<->guest 
communication, so implementing a guest<->guest communication is 
possible, but requires more configuration (e.g. some kind of firewall, 
etc.) and also an extension to the address (see the required
`.svm_flags = VMADDR_FLAG_TO_HOST` in the link).

The easy way to do that with vhost-vsock, is to use socat in the host to 
concatenate 2 VMs (some examples here: 
https://stefano-garzarella.github.io/posts/2021-01-22-socat-vsock/)

Cheers,
Stefano


