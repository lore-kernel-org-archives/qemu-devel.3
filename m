Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15148C83010
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 09:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjbLw-0002Ox-09; Thu, 29 Aug 2024 05:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjbLu-0002Nh-4m
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sjbLs-0004NB-5o
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 05:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724923318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlDaLxL3spAJXJV83CSuYRZr8pDkR3tZ7RP54APTJVU=;
 b=ipiGCHNG5FcHNupZdVPJCGpw2QN41PWoVN7H3EVfoKgx+atmY8Te312pIdfQwwbY6eFyr/
 SWntDs+FGa4kvaaaJqiO4PoKNG3M97YkvfwcRfrk3u/h9/TyooNBgtcchyq6JaGptQ+7PB
 coTeqnr5N9aOUMbMKVRtdUtN2Lg9TWk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-S7Mh5a8tMPWo763qmEEL7Q-1; Thu, 29 Aug 2024 05:21:55 -0400
X-MC-Unique: S7Mh5a8tMPWo763qmEEL7Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5334c7d759dso410646e87.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 02:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724923314; x=1725528114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlDaLxL3spAJXJV83CSuYRZr8pDkR3tZ7RP54APTJVU=;
 b=NaWE3LxJvK0CYJRlQ1GnMBLeaBgq/HkMqk8nKPRLzna49WjMwNQUbBqP8AHow9LfRS
 +RMvoP00trQF/BSrVtq0PfsjEFaMbg/77+0EkYJYD5yUqsUQ8KF92u/uB6hUcqYttquH
 Nd1QfqnE6z7n0UtJ/agv1Z1OAxo+EPqRXlbdWFdwFg0trUXYoJpHUCRRchDBVLu6nWhm
 FyUqCe4/d4/JZX2iZvYrfFaY+HtNLDJR3yrPTKQVPstqgs5O4/7Gyk4n5bClR/ElJKU+
 Kesa4laMpXR0C2LHYfSa97YV5PzYGrY+ae4M+gV+IkI3xO5NsOFweFWUDUUP6S0g8tFR
 ip1A==
X-Gm-Message-State: AOJu0YwPfsB8p6iiE5iqIicT8SeHb5qMmekOlQdne8H0ihsP2VymvFBv
 OZPze/54tj/lUYqCwAXAn7eGsSTCDTgVo9zQC/sW/ab7xzGAcN1stdFuu8/3+fxHMnyGTCBA2gp
 fyKEca9/BHsaBv1wfYAJZRDUCOMkkbsu7UwZ0pHRKQQg4fdprN++Y
X-Received: by 2002:a05:6512:238e:b0:52c:812b:6e72 with SMTP id
 2adb3069b0e04-5353e546392mr1371276e87.1.1724923314325; 
 Thu, 29 Aug 2024 02:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyWvzGwwhVbAJBwsJf2IC1QgMj0oWS5zpD/Z1rRHTqJYjq8bs/5ibXlNin9aAozu0K7cxxjg==
X-Received: by 2002:a05:6512:238e:b0:52c:812b:6e72 with SMTP id
 2adb3069b0e04-5353e546392mr1371224e87.1.1724923313289; 
 Thu, 29 Aug 2024 02:21:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:a269:8195:851e:f4b1:ff5d])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a898900f26asm54001866b.58.2024.08.29.02.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 02:21:52 -0700 (PDT)
Date: Thu, 29 Aug 2024 05:21:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com,
 mcoqueli@redhat.com, peterx@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/2] vhost-user: add a request-reply lock
Message-ID: <20240829052033-mutt-send-email-mst@kernel.org>
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240828100914.105728-3-ppandit@redhat.com>
 <20240829033717-mutt-send-email-mst@kernel.org>
 <CAE8KmOzC__Z6wgSv9sGcAPrbbZBOQg7tD=6An-=XZVouPCA2Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOzC__Z6wgSv9sGcAPrbbZBOQg7tD=6An-=XZVouPCA2Bg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 29, 2024 at 02:45:45PM +0530, Prasad Pandit wrote:
> Hello Michael,
> 
> On Thu, 29 Aug 2024 at 13:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Weird.  Seems to indicate some kind of deadlock?
> 
> * Such a deadlock should occur across all environments I guess, not
> sure why it happens selectively. It is strange.

Some kind of race?

> > So maybe vhost_user_postcopy_end should take the BQL?
> ===
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e7c1215671..31acda3818 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2050,7 +2050,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
>           */
>          qemu_event_wait(&mis->main_thread_load_event);
>      }
> +    bql_lock();
>      postcopy_ram_incoming_cleanup(mis);
> +    bql_unlock();
> 
>      if (load_res < 0) {
>          /*
> ===
> 
> * Actually a BQL patch above was tested and it worked fine. But not
> sure if it is an acceptable solution. Another contention was taking
> BQL could make things more complicated, so a local vhost-user specific
> lock should be better.
> 
> ...wdyt?
> ---
>   - Prasad

Keep it simple, is my advice. Not causing regressions is good.

-- 
MST


