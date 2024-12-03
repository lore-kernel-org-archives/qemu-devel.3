Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21AEE74AC6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 17:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIWsp-0003Tx-LC; Tue, 03 Dec 2024 12:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIWsn-0003Tf-24
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:40:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIWsi-0004DY-Sh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733247612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlzMFlCMjVs0k53de37fr+TddL7nNhW/tfpVbRKTUbA=;
 b=e6zOkNykfLEAzW9Veu8jbDIf5HlMqPlGTtTkJwGUiPfIKgtNUxNRtyx3YAr+GDABZ1QGag
 F86lmqq4P5aRIwCpgFtmHWo8NdCbsoQxrxx3r2T9WCEGUbWiq9N84eF6B36bpJoTNKq7h9
 mOVzfCRribVAncamY2KgIBroePSZ6Vc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-rA8hG7BfOtGA0EtTCldCHA-1; Tue, 03 Dec 2024 12:40:10 -0500
X-MC-Unique: rA8hG7BfOtGA0EtTCldCHA-1
X-Mimecast-MFC-AGG-ID: rA8hG7BfOtGA0EtTCldCHA
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-843e4d7c601so493095039f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 09:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733247610; x=1733852410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlzMFlCMjVs0k53de37fr+TddL7nNhW/tfpVbRKTUbA=;
 b=RuPLc/uw2QTQ0sXHxOg3plytGh19MGEBcCERGubDsc9uY4dpcZegzK9YeRGKAxE+em
 ms2FLqnvCcwQWJvjLKrl8lcN7hZ1xYV4Env5clJcw+PJvuV2F6Dwf0rKs1mC8UnbXivW
 l8PoqSlEIuVovMRPUnW5RXEakQAtibV9f7XTl74iRIMwRWW6Gx5M7FXZ9VX27jPuN1X0
 VpvS9YcCHtYYU6mc++cqJCuGElh43DNwBX0k9Wc/O9bOgBwq5uAH66QsArMSZGH4Z8Fo
 O0Ncwf+pAcsH3WaqNTdB0UtWBw6qThR2IAjjENsIWQ7ZD63eYml01EJmbQ9sQldLgVdj
 peuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkNDwdHFt9dWwv2Gc6yqiRoHMe+In8rzik7sHTPWsdoxrn08d7v/T57NzSV+fwFZ/OclJZxTtegWJl@nongnu.org
X-Gm-Message-State: AOJu0Yz4+hh6BD/NzK1dVA4zK+qVD7GPAdkHaVwgbwbQni1s0ZIhoHrS
 9qdOhlAC6QONCiN2yBs9aOG+PvKwMNcjTIqfsPqFakkaNbPDcunSFv2zGU7T3u+91WMOotYFYxb
 OGVjll0obX1kXWefZU7Tlro1qSWxZkPH4VTm3fP7j+5iJePfhOj3m
X-Gm-Gg: ASbGncv7etRYiJwJkmLwOTA5HVo9BxlNbMgXZ2tZzjA2fENlgIUiiWKeMQbzBMchYea
 nAk2euzCOS/X8qjGgmHHavugru1sdFTqbM3ZwwrRZkTubpoRce7Bxg4iw4++JxP5KfktYGs3Icy
 qW8qSi4isBX3daepueICj0/Rj3xV2eP7cc78O6lO80Qhj8H0bVe3HRyH5Dxe4vcZhFIPAlcWCIw
 MTpUKGeRxyVb1pmcu61VvM+O77afHMcPT6IMaFFVXhzqkiDbhBFUtzIAhvHNacSxq+Mvmam3u4B
 l5BpKl1Dd3M=
X-Received: by 2002:a05:6602:3405:b0:841:a1c0:c058 with SMTP id
 ca18e2360f4ac-8445b577d49mr488323239f.9.1733247609835; 
 Tue, 03 Dec 2024 09:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIrwGU/viAEngg91wVuvN0ih9G8T0zL7VQ3E5hRKY5ZwWYv80ZquCRxJmCWuEhFUDax3vouQ==
X-Received: by 2002:a05:6602:3405:b0:841:a1c0:c058 with SMTP id
 ca18e2360f4ac-8445b577d49mr488321139f.9.1733247609520; 
 Tue, 03 Dec 2024 09:40:09 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230e6165bsm2671597173.109.2024.12.03.09.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 09:40:08 -0800 (PST)
Date: Tue, 3 Dec 2024 12:40:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
Message-ID: <Z09CdpY4C5Eq6OxI@x1n>
References: <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
 <87v7w6jkc9.fsf@suse.de> <87plmejgtb.fsf@suse.de>
 <CAK9dgmbHL+O34+E3ykDdAunap+Ruubm7ysisrMags6TN25BiNQ@mail.gmail.com>
 <Z04PTe4kCVWEQbPL@x1n> <Z06866qR0z9n2BgP@redhat.com>
 <875xo1j6ub.fsf@suse.de> <Z075-ZPW9dzzCKJn@redhat.com>
 <8734j4kiuq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734j4kiuq.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Tue, Dec 03, 2024 at 10:15:57AM -0300, Fabiano Rosas wrote:
> We shouldn't be adding warnings to the build like that. When building
> static binaries, I'd assume the person at least knows there's a -static
> in there somewhere. If you're just building the system binaries and
> warnings start to show up, that's not good. Since this is just a side
> script that's very infrequently used, I don't think it justifies the
> extra warning.

Yeah this could be a valid point.

The main issue is I believe 99.999999% of people building qemu will not use
stress.c and the initrd at all.  It means we could start burning some tiny
little more cpus all over the worlds for nothing.. the added warning is a
bad extra side effect of that.

So I wonder if it would make more sense to only build stress.c manually
like before, until some of the stress test would be put into either 'make
check' or CI flows.  Then we decide whether to fix the warning or not.

-- 
Peter Xu


