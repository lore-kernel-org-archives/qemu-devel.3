Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FC0CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 22:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slyC5-0006JJ-Ud; Wed, 04 Sep 2024 18:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyC4-0006IZ-3l
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyC2-0002TJ-N4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725487777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YfYsZKapOR9mOdcFkFk3RY6Nhue7QbEBjv1hXHfqcqg=;
 b=UQuNr4VYZMHEYnixpA3Zq7HjNVKOc7dK27Q8SYutNov/YEE2iZa5kuVByPgPUXdHEg5RLl
 jSuLGw13m9lBBUfYlPbT4+WQovOqkJZTRsojNtzrnJDjdAYxOtAQ9FGzIw+tGOFkDxHSjP
 j1XvWNnLH22GE8/nJ5Zd60aUvTVO9Ao=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-4i_zjmt0OYqaE9dgjRNRag-1; Wed, 04 Sep 2024 18:09:35 -0400
X-MC-Unique: 4i_zjmt0OYqaE9dgjRNRag-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6c5135456cbso1124786d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 15:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725487775; x=1726092575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfYsZKapOR9mOdcFkFk3RY6Nhue7QbEBjv1hXHfqcqg=;
 b=s6XVeXITVz93jlbJK8B5bJixgdCQEuH3dMAC0FiNPXp5SUIX3kcXI9mT269Dbj/HCX
 7oV6tf7qq2dqosbfYu1wY6JOv7KHiK8oLy8Esqx0VN978d77p3GnH77yqgV3q1pjWEsb
 DsWpyUoF3mGdwy1GPnoSTGLDyFqj2p7u0hn6QPK2RmK2xEudR+1Yi14B4BKmu7qHDPM1
 +/7clphOuXw2m7ipy5rHd1GVWeyAocFfmyg79h3qTqsKdLCZY4tNxm2doM8+RRA2hG7U
 606rq1zEpDhh5wWLa0yaGsoNnOOnbu6OJ7x4O/XdQMhK08xuorSXLtoV4AoTYJm1TGc7
 hrnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAZky1Qm1RhoJnlbjAitno29//+B/8EQgs5hp4ub5tU8vlKQBrKLnl1hVRURCAd59SNY8gUUL2JZBK@nongnu.org
X-Gm-Message-State: AOJu0YxznH4roQZTPx7HbCRkiesDEIPiNzaoKRwiqLQmVJ07BxQzdVRj
 zWOkWZ13dtnveGXdCt9ZAlJgC4pZmc0+8O7uZCxtyv2VgdNyvl0hN0nh5Ra5vA3E1T8u/BZx4j6
 EVYmxIq6gr3sI6bumqXMRIuielTLtUTAMs7XMnLamhmIV9F92cmX0
X-Received: by 2002:ad4:5247:0:b0:6c4:99ae:a2d7 with SMTP id
 6a1803df08f44-6c499aea404mr87083976d6.37.1725487774947; 
 Wed, 04 Sep 2024 15:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp/1Pi5QJefwVkpDnJLi4mgj+7UGCEiHV6+PeXlgXbYq0EcPQvWEFRMpZ0xJZOiJiVXjEYHQ==
X-Received: by 2002:ad4:5247:0:b0:6c4:99ae:a2d7 with SMTP id
 6a1803df08f44-6c499aea404mr87083796d6.37.1725487774591; 
 Wed, 04 Sep 2024 15:09:34 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5201dedf9sm2445576d6.20.2024.09.04.15.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:09:34 -0700 (PDT)
Date: Wed, 4 Sep 2024 18:09:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <ZtjanN9-SP5XCAJZ@x1n>
References: <Zpk2bfjS1Wu2QbcO@x1n>
 <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n>
 <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
 <Zr9u1YV4m9Uzvj7Z@x1n> <Zr9yGoXBpHIzrDak@redhat.com>
 <Zr93bOr1zrSZadf5@x1n>
 <dfc000d3-3728-4d1a-9558-943438abf2e6@oracle.com>
 <6ee0a0b6-06e9-468d-b1a9-9dea834b641c@oracle.com>
 <b318619a-fed3-42e5-8172-e8418e1bd860@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b318619a-fed3-42e5-8172-e8418e1bd860@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Wed, Sep 04, 2024 at 05:14:37PM -0400, Steven Sistare wrote:
> Hi Peter, before I post V2 of this series, I would like to reach agreement on this
> interface. I cannot tell if you have gone quiet on this thread because you agree,
> disagree, or are on vacation!

Hey Steve,

I'm not on vacation. :) But indeed I had some other stuff to look at
recently, so can be slower (than my usual slow..).

I think I finished reading this one, but I'll double check tomorrow and let
you know if there's something.

-- 
Peter Xu


