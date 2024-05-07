Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04C2C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 16:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4NS7-0005X9-J6; Tue, 07 May 2024 12:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4NS6-0005Wz-ME
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4NS5-0007UX-2N
 for qemu-devel@nongnu.org; Tue, 07 May 2024 12:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715098440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7QZHYm+Ei8/1iATuVALb+2BptqwX0TTbTEZ6LF7Zfg=;
 b=fDqgAYpmMb2WHmA9JtcPJjiG/FFFZJnRp2356iQ4Jketw1O04doEvMhlDYJid7ETkBNFyk
 EzsdLEG29Zd4wrlYVHSltSZe9X+MR5FgQbAHeTd+zmM367B4x/CN54QtYlQ07Hk5lrtkGQ
 QTSe8HpyYE0jXc7S7GJuePojwnp/WQw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-ITJZolJBPkmJNcQIdpVEOA-1; Tue, 07 May 2024 12:13:58 -0400
X-MC-Unique: ITJZolJBPkmJNcQIdpVEOA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a1326b6c56so9785036d6.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 09:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715098438; x=1715703238;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7QZHYm+Ei8/1iATuVALb+2BptqwX0TTbTEZ6LF7Zfg=;
 b=ZZSWqAwPi0tWyShCbWl4hzLJuV4NHe59VOiXiuMpREE0TQeoim15gD4onB4jgFE82d
 JrnUiJzFcG1IImY1YsRSim2eRxBm9k4akCPJ01WSgumoW5SJlp5d/j8jOWCr64IzhEgN
 DukKfYC4uVUKIyiQuSn5tu57GFkTiU5WFRZMbV+VWF0uC/9gVUdd/YxbdAZ5VRdnjIsd
 B8Yu0wYrKrix9g1BNQ0BpWpPO0tHJJW2kH8Q1qT5j+3BMQDJC0n1N/Tp3q2hPKfjVd5z
 LxrLda0SEj49OhRChGbfmvk3z2Kv78MWNoUfz7QsiZHg6sxiIrQmTLisY9fANpS1xTDY
 hcHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsFnFp/cFYU3XOOngATxOsd+Agan+W8fJBwLwFHU4/zhu3Wac5Dff9O4OHk3sLSTo3Lqqjv9z1yqE2RTzxafJOGQftC70=
X-Gm-Message-State: AOJu0YxazjlVSUtHO5re4bU5Pk6dTWK2bO8vgiPLHPFYywH5zwnFzxod
 kM5bubJ1bqcNu8vCrWQJ9tAOKJAGCaW3gBfV6m2eRgLYIy/8gRjAoxUXhH9SFmTdxmLlHFmtdBc
 8JOj/GyKtOiwh0nt9GQA7VOf+HV/D9dM3MoaSh/glS9bdeXsfUYxZ
X-Received: by 2002:a05:6214:19ee:b0:6a1:f0f:73a6 with SMTP id
 6a1803df08f44-6a1514c2f4dmr2996126d6.1.1715098437919; 
 Tue, 07 May 2024 09:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHaks3M/rgfZoI2aMmTavYCkIzUIrnxg2Xb9KKoshUAXrtYY7yDTnqTkYRi/epWlUYPElo1w==
X-Received: by 2002:a05:6214:19ee:b0:6a1:f0f:73a6 with SMTP id
 6a1803df08f44-6a1514c2f4dmr2995756d6.1.1715098437387; 
 Tue, 07 May 2024 09:13:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 t3-20020a0cea23000000b006a100fa5fb2sm4809681qvp.77.2024.05.07.09.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 09:13:57 -0700 (PDT)
Date: Tue, 7 May 2024 12:13:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <ZjpTQoKT9AIGwNGk@x1n>
References: <ZiKOTkgEIKo-wj5N@x1n>
 <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
 <Zig0IPofMCpJdGsn@x1n>
 <e88ecd55-14a2-4043-946b-9c2447fe9def@maciej.szmigiero.name>
 <Zig3vebacR4SfJLh@x1n>
 <1a0b3c24-fffd-4db3-a35e-e40ae2e0a074@maciej.szmigiero.name>
 <Zi-4FmjXv-gx7JH_@x1n>
 <fc0721e3-4932-40b8-a6eb-2584a475d8eb@maciej.szmigiero.name>
 <ZjkZyP9Ty0TpTCTx@x1n>
 <7e855ccb-d5af-490f-94ab-61141fa30ba8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e855ccb-d5af-490f-94ab-61141fa30ba8@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 07, 2024 at 11:41:05AM +0300, Avihai Horon wrote:
> Yes, I was working on parallel VFIO migration, but in a different approach
> (not over multifd) which I'm not sure is relevant to this series.
> I've been skimming over your discussions but haven't had the time to go over
> Maciej's series thoroughly.
> I will try to find time to do this next week and see if I can help.

IIUC your solution could also improve downtime, it's just that it bypasses
migration in general so from that POV a multifd-based solution is
preferred.

Fundamentally I think you share the goal more or less on allowing
concurrent vfio migrations, so it will be greatly helpful to have your
input / reviews, also making sure the ultimate solution will work for all
the use cases.

Thanks,

-- 
Peter Xu


