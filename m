Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D096C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 10:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKaIL-0004FU-7F; Thu, 29 May 2025 06:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKaIJ-0004FH-Ij
 for qemu-devel@nongnu.org; Thu, 29 May 2025 06:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKaII-0007pS-7C
 for qemu-devel@nongnu.org; Thu, 29 May 2025 06:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748513724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJevQnYE6fAv/YbNyTMJxSk7HmlWFw9RIyKt+XNnB3A=;
 b=K6QDyUOvzDAZ0I/+G01krn36vvs+ByICFe/nyLH5MgxDnPkNdT/i7jM14lXBeo8lHpMrm1
 WZe84Q0BCL/eeFrxQ0aysXLQV1ZRKKfTZR8icYxRUNrt8fET5a9/niClfW9oMRSEGJS6Kz
 OTcMcs6H2Ceh81628KO8czglT1BSi5I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-HAEYJoT-NKWcn6lTmywCYw-1; Thu, 29 May 2025 06:15:23 -0400
X-MC-Unique: HAEYJoT-NKWcn6lTmywCYw-1
X-Mimecast-MFC-AGG-ID: HAEYJoT-NKWcn6lTmywCYw_1748513722
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a34f19c977so409006f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 03:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748513721; x=1749118521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJevQnYE6fAv/YbNyTMJxSk7HmlWFw9RIyKt+XNnB3A=;
 b=RgSlsoAnPXYFJvN6YUIPYvxELc2JyTko6iQzkGf5ghqCiQbK1gfSnZTQicBysNdTZQ
 5/hubEX179AbEOGDodE2Cd+Awn35oQyWLvlGMz7EOX2bg2Zi8xaDzTQDmgjNwNRxA1hQ
 dCCnUO9CAbO4U9hLGfLnNtRof1Z2OdKkz12lYVBodkK836xA73odwRk9Cg/8eHUaaj2J
 a8wQdqIsvJq+FJX3CqswWkw4eZIWyWZFXFCftXeeNjd/koa44rnEgqQrETgqUCPrthfk
 QsZjYLLcE4MKeZsDcQveLhEGtDAQAi9G2MzpSwTR/jwhXbqeL86tPlRvmv6qatIe1xf8
 AnCw==
X-Gm-Message-State: AOJu0YwRZpuSLqfMRU9eKiZZBYrp5yedmJ3Uuboh7kStEUCHvMDBgTKr
 mnMmyk/FeRegZgabhq22+mHshyX/PdXNdfnxfi1mPC0vS0knA7T+oT5aMU7By6C8ACIyzKGorT6
 P+7+9MSFbePi7+zyzW/6UjFXugll39G6s+DNVj0r7Dq19fzc4pM717AZWJkOcwqQH
X-Gm-Gg: ASbGncuHarwd2QKLzIXHWjvoy/eQgAohOV+E4iA4Ftd05ifskdhNoeVh48fHRY+9GS/
 s6rqYCl+6QzNBE0lnaoTwLFXEWbWCFi4AQvlwVzM5q+qruuh9nbkJUyDAYZwXM+Zt8ftGjvJdZA
 gK0CbJyDxVy56OKCh7nlWKMDNGCng6S23R8QN1AEG1qLuqg3135eq1eJ5hO5gxrvD1PZZyfu6oy
 9e48ACZupc0BIotGQ3Sg/VYBcfVZS1s3VxXKUvqwOH2MP8MuHi0xmpgL7bHdY60LLt2EzT7+8J7
 h6J+IQ==
X-Received: by 2002:a05:6000:40df:b0:3a4:d038:cb9b with SMTP id
 ffacd0b85a97d-3a4eed955d7mr2432006f8f.7.1748513721351; 
 Thu, 29 May 2025 03:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJh9z+BvfoZCm3YYDeh2gWJ3fRBeNLWClTeLpqWdMPFNRd2BRgZ0AfhbRRiTIXMcr6p+fNWw==
X-Received: by 2002:a05:6000:40df:b0:3a4:d038:cb9b with SMTP id
 ffacd0b85a97d-3a4eed955d7mr2431979f8f.7.1748513720973; 
 Thu, 29 May 2025 03:15:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c8f5sm1520651f8f.27.2025.05.29.03.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 03:15:20 -0700 (PDT)
Date: Thu, 29 May 2025 06:15:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com
Subject: Re: [PATCH] virtio: check for validity of indirect descriptors
Message-ID: <20250529061459-mutt-send-email-mst@kernel.org>
References: <20250515063237.808293-1-yuri.benditovich@daynix.com>
 <CAOEp5OegzUevfFit=qHzhjzSq9FPWq45kYjEgriFB0W111aAtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOEp5OegzUevfFit=qHzhjzSq9FPWq45kYjEgriFB0W111aAtw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 29, 2025 at 11:12:17AM +0300, Yuri Benditovich wrote:
> ping

thanks, it's tagged, will be in the next pull.


