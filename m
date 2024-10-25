Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9CFD10399
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MX9-0003Jn-Mp; Fri, 25 Oct 2024 11:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4MX7-0003JV-LF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4MX5-0002zU-MY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729871241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vdRa0lNDzbbAsouR2soEg0+zUvmQMiqrb985I59ljhY=;
 b=K0cor0kygTCoYrGxJNAT7gyav3GE7boFLsB7yXDPsLEOhCO2eGpIYgOZTxl0Npa/pCMj8b
 lTAqsuV6NTRpHNKhw6qlYQ402HFtFIV2dMnyR+8ZCb1ZIx13PDRpqhj2Q1tKpX73aZ+9Yr
 gqcTyrDzGQ8Y8JvO5QHuFoWWhMiIBRw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-4BDOhT2nNvmlJGDEySzyzA-1; Fri, 25 Oct 2024 11:47:19 -0400
X-MC-Unique: 4BDOhT2nNvmlJGDEySzyzA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cbe6ad0154so26563636d6.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729871239; x=1730476039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdRa0lNDzbbAsouR2soEg0+zUvmQMiqrb985I59ljhY=;
 b=n7Jf2LMynKS/M5JVLYGncPS3h0nAd2nwNoy7nIYa1R7pgOI/Xa1U8Xdnq3SG+XYfr2
 k/YtobkrGcwYDNZP+B6tpxLUHqPW/ml2Hx1vlGINm2nyTgsCsiKxygdgXXXqrh/tOP33
 N9/jZY3bmhJ5v/wjNybm17S6+3T62nfSr97Wm+Eledrxnh2kSc4o4lpmnkkg5/fVG63E
 W9iEJSK1Oz/M8COi+/xNiG/RkkMrz2Bzjx5Nx2cdZgYG4Y2Gw5FOVhrTyGw1+b5tBevc
 Sja6y6hXOKGFVipQrsEuxw6ITD/Y0bctuK/6f5c69MS2v4C7WDA2zIYAuI+G+RUa9kqy
 nrPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR49GBeEyuRWtLGhyurM/aP8SxOBFsKBrMipDmpfzS2ts2txGKYg3FWBPkvWEN1GIzLe0LcfBYjAgB@nongnu.org
X-Gm-Message-State: AOJu0Yw4NjfT4RWvHIMM2z9MEnVisRXkd13VIjnzojr1tAyqCjiOMvya
 Iso1yVHx/7hQ/63HKbVcl3hfPb5GUGdyFbZywMuf2xMzxKbcdlt/cDyE6iODMJiLg7/FLBBHkOD
 S0S+xdKQMc3OmLZCs9AHSzl+6mcEdSFGg0i/0Aw3sKFgR/6dCUU6N
X-Received: by 2002:a05:6214:4687:b0:6cb:eb51:a26a with SMTP id
 6a1803df08f44-6ce342ec6b5mr170070356d6.47.1729871239163; 
 Fri, 25 Oct 2024 08:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBMqwGVuFGAgwJQhvcyEjjz0k36ehHB/ztx7Or21J+cx8XxlSW4WRwX83y93yhPHPHvKxugw==
X-Received: by 2002:a05:6214:4687:b0:6cb:eb51:a26a with SMTP id
 6a1803df08f44-6ce342ec6b5mr170069966d6.47.1729871238760; 
 Fri, 25 Oct 2024 08:47:18 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1799fd524sm6738626d6.94.2024.10.25.08.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 08:47:18 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:47:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: Re: cpr-transfer with caveats
Message-ID: <Zxu9g_pZo1KdBl3S@x1n>
References: <87b1beba-4e03-45c7-b6ce-2772dcb117d1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87b1beba-4e03-45c7-b6ce-2772dcb117d1@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 25, 2024 at 11:01:27AM -0400, Steven Sistare wrote:
> Hi Peter, are you OK if we proceed with cpr-transfer as is, without the
> precreate phase?  Here are the problems that motivated it:
> 
> * migration test wants to enable migration events on the dest.
>   fix: enable on dest qemu using -global.  only for the test.

If it's to be documented that cpr-transfer allows no migration parameter /
cap setup, then the test case should follow, IMHO, rather than enabling
anything from cmdline.

I hope that's trivial if we can have MigrateCommon.disable_events, for
example, then only cpr selects it.

> 
> * migration test needs to fetch the dynamically assigned migration
>     listen port number
>   Fix: require unix domain socket for cpr-transfer, or a fixed port
>   number. Document it.

Fixed port is probably not a good idea.. requires unix sockets looks fine.

But then again the whole point previously having -cpr-uri together with
-incoming (IIRC, from your previous email) is to have that flexibility to
use non-unix too.  Now I am not sure whether it is still needed to be
separate just that you'll still need to rely on SIGHUP just because
precreate is gone.

> 
> * migration test hangs connecting to the qtest socket.
>   fix: in the qtest code, defer connection.

Not sure how much change here, hopefully still manageable.

From use case POV shouldn't be a huge issue, if we don't use -qtest in
production anyway.

> 
> Document that one cannot set migration caps or params on the dest
> for cpr-transfer.

This also needs to be reviewed by Dan, on impact of Libvirt initiating the
dest QEMU instance with QMP all dead before a "migrate" on src.  I'm not
sure whether Libvirt will also do early setup like what our qtest does to
enable events and so on, assuming QMP available since the start.

> 
> Document that for -incoming defer, mgmt must send the migrate command
> to the src first (so dest reads cpr state and progresses to start the
> monitor), then send the hotplug monitor commands to the dest.
> 
> Daniel, are you OK with that last bit?
> 
> - Steve
> 

-- 
Peter Xu


