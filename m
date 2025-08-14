Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F471CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 19:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umdoH-00032y-Rv; Thu, 14 Aug 2025 15:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umdoF-00032I-F8
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 15:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umdoC-0003ap-Je
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 15:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755200417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aFACkOcF2p/DSpurtoj+eFrLFIp6qRkt+3Kvgz65B48=;
 b=AKQJuCw1P3Fe4KDNZp5vrFy1R0+2sFjowXII0Fz6lH7aH7QhogGBBnVbMGthBeZYabqukK
 24QqSV2+YREUBriPvYTbeRkmwI5u+2PAirdXX8cJUmnq7hAENUBAVnANz+Lx61OuVQSplt
 Gr/7RuMqMtuWxp04QvoOf1ZcIEMd3Pk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-wxpy2zAmPfmiDYI1r5pw4g-1; Thu, 14 Aug 2025 15:40:15 -0400
X-MC-Unique: wxpy2zAmPfmiDYI1r5pw4g-1
X-Mimecast-MFC-AGG-ID: wxpy2zAmPfmiDYI1r5pw4g_1755200415
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70a928135f0so27546306d6.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 12:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755200415; x=1755805215;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFACkOcF2p/DSpurtoj+eFrLFIp6qRkt+3Kvgz65B48=;
 b=TERNSFI9IgN3bP9770632tHoeDqHZ+6niUIb+pvtxaCLqsE4b5PRjNjR2ZYuX+vD4E
 zSKaceit/NyplV4uB4AGQmulesrISnaN/dswFyZVGegN411EwzVY6CXVzrQMuzcuKAYL
 HIMzEXvKnHzS9NShggq9shY/v/9YVMHKWTwToXb8EbgIZYewPvHz0HPR+FiKT6cKUgNb
 8gtAMqPGFvAPkVS1JJ/2fkvDtAUPe63BAsSsoi2tuPAd6yKETD3q62D8S5jhgLmQvfzq
 LKuFWoTG0wX45C87rtAjqYlYFZnrRgNcT37u96EBmVZLsV+0Dl3OCN8JGD4z6zGVXnXr
 2Hsg==
X-Gm-Message-State: AOJu0YxNQZklzLn9T3s+x/r7KyOOv0gahFO6TZGf13FnyRYuhmbXQVDN
 N6I+QurZnDDCwpzUAmtQ70HgtK26n+Q7SHbiKINGr5s7T2zb7H80yA9tLEMEpzBcJcTEQSmRTSU
 oE+l9YhS7isq2MTAH1LyxKqdY4CVexSk1d2QMDcO8ps8Yu8BXx97469In
X-Gm-Gg: ASbGncu9JTBwpmU2mYwbN1HQcI2vJseUbvUTRS5NZhkWa62Wd+9+c4QgXxnw/hJlmZP
 M3jdMkhc4QOS5byxQeRcyDN2LKzGRlmKvK/Mg/ArFX9Pa6Wf3eBfMohadbsAQDBUM6eBarWKd3b
 1M8V3bW+azT6CKGW8KfZMsyWV/7f9UY0bDuy9djMj1yFqjJE57dTBc9ooLk+aVgSawV1Nlw7Coz
 AEojnWWupY+jiA1dmGmbtBKvOzISxL8Ah8GVoNmCVblzSiNpboZK9cLSTFgywDI2fj9sCo/Gia5
 HOCNbn8wSIpptTRkRd2+UKftAnxL4Ifl
X-Received: by 2002:ad4:5967:0:b0:707:5974:388d with SMTP id
 6a1803df08f44-70ba471e24amr1751946d6.8.1755200414580; 
 Thu, 14 Aug 2025 12:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEldpG0Md01FIVHPVLMB1rqwZ3fmYnwaT+tslhbNRtasWhrcwuN6h04MyDMLVRQ6jy/NfOBw==
X-Received: by 2002:ad4:5967:0:b0:707:5974:388d with SMTP id
 6a1803df08f44-70ba471e24amr1750406d6.8.1755200414004; 
 Thu, 14 Aug 2025 12:40:14 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70af5b82985sm16961896d6.65.2025.08.14.12.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 12:40:13 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:40:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v2 14/24] migration: Use visitors in
 migrate_params_test_apply
Message-ID: <aJ47kLZWhma1aOzw@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-15-farosas@suse.de>
 <aJzv8hm87PVIOSLj@x1.local> <871ppe0wja.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871ppe0wja.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 14, 2025 at 12:10:01PM -0300, Fabiano Rosas wrote:
> > IIUC this is essential the trick we used to play before QAPI_CLONE, before
> > commit a15fcc3cf69e.
> >
> > https://lore.kernel.org/all/1465490926-28625-15-git-send-email-eblake@redhat.com/
> >
> > Yes, looks similar..
> >
> > QAPI_CLONE_MEMBERS() will copy everything, which we do not want here. We
> > only want to copy where has_* is set.  So it's indeed a sligntly different
> > request versus the current clone API.
> >
> > IIUC that can be implemented using a similar qapi clone visitor, however
> > instead of g_memdup() on the structs/lists first (or in the case of
> > QAPI_CLONE_MEMBERS, we did *dst=*src), we lazy copy all the fields.
> >
> > I wished this is a generic API we could use.  I think it means we'll
> > maintain this ourselves.  Maybe it's OK.
> >
> 
> I'm not sure how easy it is to provide a generic API for this. I don't
> think there's much space for this code to change anyway, so is fine to
> keep it in migration. I'll try to implement a
> QAPI_CLONE_PRESENT_MEMBERS, let's see.

The new visitor will slightly improve readability on what this code is
doing. But yeah, feel free to choose whatever you see fit when repost (and
if the code will be kept as-is, please consider adding some comments to
help future readers).

Thanks,

-- 
Peter Xu


