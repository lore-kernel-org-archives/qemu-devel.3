Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82986ECE587
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 19:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snk02-0004fU-Tg; Mon, 09 Sep 2024 15:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snk01-0004da-N6
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snk00-0000dN-7R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725909870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0MdcRAqODEdPxWW/w2xHbPro635/fT1kSZJ+MHSYSI=;
 b=VpwYNhrZYw5G0aKN+O08Jwy55SlV8Ec8g8ptMdsZl1qASSwQJFD2WFC/aT8+F1W/3Js7ZE
 P9M7hxiq4qhAEkDsuQgWsDmWIGNZJY7HqKyQcGMQwO0YKiCS2gPlKgvIh4KPTKCAb+tm/M
 dMYcOX9uASh5bfsmA7Oim++sjhKOgIU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-Fcd95OHkNLWV0YRpaiLeUg-1; Mon, 09 Sep 2024 15:24:29 -0400
X-MC-Unique: Fcd95OHkNLWV0YRpaiLeUg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3e04c43fe89so797347b6e.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 12:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725909869; x=1726514669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0MdcRAqODEdPxWW/w2xHbPro635/fT1kSZJ+MHSYSI=;
 b=Q3LfAoTAUYpUzE2O8FJgeGW2COohSgfrOYA11v6gHXW6tMlSkcJVh7khzpqXchDfq+
 4Iv4gUwSft4/WZu/XQDyUKvlktWfk9EOw3UdcfEb8L3PnJcaQkta1FnXjP5cNxma60OL
 QohOhKy7dct0ub0OtNMSnSCC4c9YUWjMf3HrIoq+yYj3L9hGtSojF0xAOTJKTlnOlwfq
 pAz6WJPh9nvXM9u2ixdZptFe/4z2TVM5GhkUj/2sphQc9KLQRxmBykLdbqfbRH6eJqVQ
 tPWj+JVXWrcEZYHtcxEWH6Q2F5vWM9Z0s7ERjNlkDZucj4Rl7jNqMeL2Xse32uD2jB0H
 dAVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLA/gWLLLAlDmH702PWxApcXkDDkZdvf9bXnsrPhOOo+kBiYS2JbuRe6H78h6KljwqjS1JGliUDBax@nongnu.org
X-Gm-Message-State: AOJu0Yx1YQ37suJvsO3XU6ICTFk/5a4q6l9ufD9WdiEVyWclOpUb0BYm
 mcrGf9CdRJAnsFFtXyy7zSHd1NVPsHtP9Av/7Q5/4zLn/qJnb+QgDHIWixXXpoDGtgEqsr0s/ZN
 tjW8olVl0UfBwBPXn+mSgsmx3iMdfo/XAdflGMmylHiS1+7WG2lZ+
X-Received: by 2002:a05:6808:2f0c:b0:3e0:434f:f7af with SMTP id
 5614622812f47-3e0434ffa86mr4256805b6e.13.1725909869098; 
 Mon, 09 Sep 2024 12:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGokL2VWCAyO4MxwMPXleGLH6pJtVnKTLvgznSL3skS70O4ZvLj8rnUPni6Fh9x3tm1XhP2Qg==
X-Received: by 2002:a05:6808:2f0c:b0:3e0:434f:f7af with SMTP id
 5614622812f47-3e0434ffa86mr4256757b6e.13.1725909868515; 
 Mon, 09 Sep 2024 12:24:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e98a1dsm22924211cf.40.2024.09.09.12.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 12:24:27 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:24:24 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool
 support
Message-ID: <Zt9LaDlrjeEmJrQk@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
 <CAJSP0QU+dhh_e2LJRoGCxtCEh6C2-GBoZoFZL2W-SMSQPzUtYg@mail.gmail.com>
 <d6e7dbd4-634f-4f62-8516-7bbf404b7adf@maciej.szmigiero.name>
 <CAJSP0QXURSS4cHj0i6xy27HMbtF2D4ckL4fwDk5rHA3vFFtHUg@mail.gmail.com>
 <Zt8mPlBLO9FUHgxG@x1n>
 <24d8e48e-2967-44b7-b294-a398f61dfbd8@maciej.szmigiero.name>
 <Zt9InYR-0aswwbyT@x1n>
 <3730a037-539a-4af7-9486-65d02f16ad9a@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3730a037-539a-4af7-9486-65d02f16ad9a@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 09, 2024 at 09:16:32PM +0200, Maciej S. Szmigiero wrote:
> So, if I understand your design correctly, you want to basically wrap
> the Glib's GThreadPool into some QEMU GenericThreadPool and then use the
> later in multifd code, right?

Yes.  I didn't have an explicit picture yet in mind, but what you said
makes sense to me.

-- 
Peter Xu


