Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FD8D3B98A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 18:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT2rO-0001uJ-Ky; Tue, 09 Dec 2025 13:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT2rM-0001tT-Oa
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:54:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vT2rL-0003jQ-Cj
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 13:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765306490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kpa/SKphh2ndJXa5JSV3jKWPU8MWIIWPDCsXTOa/Gfw=;
 b=VDopraxYyl+5Y/elwJvNlvsS2sqJdq+R0k2uPHGOCNalAhaGErZCuH1sU7ryXF4SbZvtbm
 0JMuyljqs06itf7RRLUuKZ/p9Nx6eS6U096VMTbpue8Eg1m3xQ0ETgyIyFTUuFIAheumYy
 EordVVhtTOEOaCMcKk0b1rdT3oow94Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-cQQ3cBNNO72jWhCiIuSSbw-1; Tue, 09 Dec 2025 13:54:48 -0500
X-MC-Unique: cQQ3cBNNO72jWhCiIuSSbw-1
X-Mimecast-MFC-AGG-ID: cQQ3cBNNO72jWhCiIuSSbw_1765306488
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b24a25cff5so1395532685a.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 10:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765306488; x=1765911288; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kpa/SKphh2ndJXa5JSV3jKWPU8MWIIWPDCsXTOa/Gfw=;
 b=q9IDxIV+VbfKOK4r/zuSYAfXMxve0hHVTgGKsW59SoSn3oNgIpCmfFVebXn45xbN9Q
 Qh3V+TlJYKFCnwy4evDskrSc4bL5yMQKEDOVPx650f59uk9/FkpWfaEgMf/FHh2/AY/G
 PQjfqChtmjn+S7edTO3r/Y3xCvA+pAi+JToobrB/JfrtSbFpKaUe3UX/GgCbfIMCJVys
 ao+QYhykwLDav1kX7M2bLQ40hcBx5XR3K6GbV1NSQxrNZkRprxBp1Wu0NALtK8Ds7E8J
 5nANhU9cM9NKC8M5ThzK/CINEa9ell5JQx22R63cP9m28TBaJ7VNzjCkHkiJgil7pbnp
 CyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765306488; x=1765911288;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kpa/SKphh2ndJXa5JSV3jKWPU8MWIIWPDCsXTOa/Gfw=;
 b=JYWCujhjEYi65EQg9OeF5eMlPlM0opfe+579lZbzfxVKx/TGCr6RE37BLgbtOkmGr+
 TW76Kl1p922pZ/BSj6fynV57sQL4jhyW+wA2hWkLheYd0Ydk5sy9rfX6tbaDbn2+/zib
 s7FuMF8Gxdoml3vxDnGBXUWdKwnvbn4GLNqwf72CjIuwRFHsL6AmaOUHPBVd2s7Th3DK
 9h2vbcUoXJEAO8c0rFhKZkHyhY5Ob+eE9p+vQpaFg2FD/P323jfZoD7pzza0dkFghexy
 B+Poo+7A52K+1oLDM4VGbu/a+EBsR3yDEPfJhDfRf3wK/7uLzCZw5o9Ucx/lu+puzyWP
 VWVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH9MlP9Ua/XG1ptIwfxp2r+xyAzLl2qzUL9rskAkMqX+NXB51b1+Jp1t0JIqN3OgIwT0+iHW5z4kIh@nongnu.org
X-Gm-Message-State: AOJu0YxTh2y+amAD4tlzF3E+xT7Qi5n/swfA75tBLn4UkgM7OOdvL0Tk
 DK0p4tyLCOQYisOrtabTUvS6X/5wtFr6uqZwQX0cLtIWseDVJSC7cvJrpEMeZRZruQX6ZgQckWU
 TTIW8LCprMHBBUSOC5reP5ldHa4YdzCeK/Ax9+cBYD3mqu52x1sO8KBKK
X-Gm-Gg: ASbGncvYWnW7zfJ73pKu6k5hMCOYxma2Ne4Fj0jjH4nnADuYrwg6i3iteL671zYtYz+
 1G54Bf4coP3wf/sPPWdO7rMtHzP4TRwkRj8SYbDQ7XvstjEAdf0dFWCjNmClGVIar4wOqMtng8v
 hU5CGqfK8huRQuWH9KI+djSoNDlKcNexoyAlWx+dU73fZSQSJI8rG4xqPgC+cvh9ZAq4nB4+lXh
 4+svtpczqooThW1JdOyCm/0xV4MVNUI10s1B9plW/jZKBh3LCal8xMLWFWJn+gB5p0ccHMwdzzr
 v8L9X+4KK/oUE2i7f9or41e6VicBoVwgJAod/QduTvjFTZA4kEVvQzIYknXE+x2kTh9S4qs5A2o
 ZMDc=
X-Received: by 2002:a05:620a:404f:b0:8b2:f26e:3220 with SMTP id
 af79cd13be357-8ba38a76499mr8042585a.8.1765306488170; 
 Tue, 09 Dec 2025 10:54:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGoWXQKA+EY0mXVd7mDqef+wzi7zU58j+VU1ytb0p5p2tdlAoq3JQW+erw/oXRUr8FZItUXQ==
X-Received: by 2002:a05:620a:404f:b0:8b2:f26e:3220 with SMTP id
 af79cd13be357-8ba38a76499mr8039285a.8.1765306487786; 
 Tue, 09 Dec 2025 10:54:47 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b627a79b75sm1346025985a.25.2025.12.09.10.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 10:54:47 -0800 (PST)
Date: Tue, 9 Dec 2025 13:54:46 -0500
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mark.kanda@oracle.com" <mark.kanda@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Hudson, Nick" <nhudson@akamai.com>
Subject: Re: [PATCH] migration: cpr socket permissions fix
Message-ID: <aThwdthSF30NygY4@x1.local>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local>
 <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
 <aTL2j7PB4--w68ir@x1.local>
 <85437E51-DEC6-4B79-8E5E-93B5D64D4CB2@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85437E51-DEC6-4B79-8E5E-93B5D64D4CB2@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 08, 2025 at 07:32:41PM +0000, Chaney, Ben wrote:
> 
> ﻿On 12/5/25, 10:13 AM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com>> wrote:
> 
> 
> > Maybe you can stick with -incoming defer, then it'll be after step [3],
> > which will inherit the modified uid, and mgmt doesn't need to bother
> > monitoring.
> 
> I tried this approach, but It doesn't look like it is possible to create the
> cprsocket later with -incoming defer.

You'll still need to chmod for the cpr socket.  "defer" will still help the
main channel to be created with the uid provided.

-- 
Peter Xu


