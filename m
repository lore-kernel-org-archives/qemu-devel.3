Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12EAC83F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 14:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjg9Y-0006cR-10; Thu, 29 Aug 2024 10:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjg9V-0006bp-Vz
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjg9T-0008IZ-Ot
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724941770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTH8txxOZx8HLmIbM4WXwP6licKpCNz8esqd3/DqgOs=;
 b=czWH8DA16LE2U1rEgCQcgnUv8+THWAvzncklpSUKVNAknd+uPpiHXXWbaSBNMujE2tL8XM
 3KSZAwigzj0Ga/Wjin82y1jXfoa2GMSh4uVqNJUghalx18D4JdCaDe1EMQ+Y2JTRxaqFlq
 B9bSPxRXXpxn4c41fyu4eepf9/Z89a8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-sKRqAdYUOOCV2CPiw4cohw-1; Thu, 29 Aug 2024 10:29:27 -0400
X-MC-Unique: sKRqAdYUOOCV2CPiw4cohw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3df0ae89453so545044b6e.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 07:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724941767; x=1725546567;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTH8txxOZx8HLmIbM4WXwP6licKpCNz8esqd3/DqgOs=;
 b=WR1Hq3eHSnPZYv2/k0Z8p+XyS7W+ac4+PAGKMgWI7I3u2xL5AerhP/WQDVmI6EU/IR
 fOZ1WRFwPn2CVf6Aucnvk1HlPNmdzzuLcQs8U5XZzhYm5J7ZrLdyYVSk+mgnQWdyqiq2
 K6zNlRoHo6IhqFXelArw6Tm87qo899yULFcE7WLeqjQlWcEmnf9EJIyMfEUTX+AxwyYm
 Db3OrZE/VEZVHamulr/Z+xfkBENhg01e2jUVaB9xT4jxLUpqolcLcBCRHs2Pmz2ioDWZ
 mwLAE+dEmG/qemIXU+cDmSrqQe8HtH259mjLfGnXoaijSyuzaWirRicmgFy8rQE0CFws
 hLDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy2g/o9uyFuBhvn3Yy7yfW+LEv9nCJKNyEqIelYUTPlG6YEmxwNK8fzV4Go8xli3pDG+33ohWtyyfB@nongnu.org
X-Gm-Message-State: AOJu0YwnG2+XdaFOr7uohc/QBEHNKBsMfdOPb2SbDPeNAJTpgte48h2S
 4iD0IRkJqvVhtehDwgCRaRzfOuP54MFpRP0CFHP2USVFIZDoW8IqlVMewXEVSryYq9M5ea4dMhM
 CSKfV3yHl7L7AqZk2bh41gSRgpuDK5eE1lshNocBatL3v56eo5lhB
X-Received: by 2002:a05:6808:1692:b0:3de:13bf:3092 with SMTP id
 5614622812f47-3df05d8557fmr2851996b6e.24.1724941767051; 
 Thu, 29 Aug 2024 07:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqzQF5lM+M047jcpNOVhwCz5vImwcc/WUU0Ghehm+2Z5gYiW+2iGQMFjE0aivONkPAATSl+w==
X-Received: by 2002:a05:6808:1692:b0:3de:13bf:3092 with SMTP id
 5614622812f47-3df05d8557fmr2851970b6e.24.1724941766401; 
 Thu, 29 Aug 2024 07:29:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682cd3dd6sm5202351cf.46.2024.08.29.07.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:29:25 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:29:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, jasowang@redhat.com, mcoqueli@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/2] vhost-user: add a request-reply lock
Message-ID: <ZtCFxLfFKvojRD2u@x1n>
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240828100914.105728-3-ppandit@redhat.com>
 <20240829033717-mutt-send-email-mst@kernel.org>
 <CAE8KmOzC__Z6wgSv9sGcAPrbbZBOQg7tD=6An-=XZVouPCA2Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOzC__Z6wgSv9sGcAPrbbZBOQg7tD=6An-=XZVouPCA2Bg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> 
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

I think Michael was suggesting taking bql in vhost_user_postcopy_end(), not
in postcopy code directly.  I'm recently looking at how to make precopy
load even take less bql and even make it a separate thread. Above is
definitely going backwards, per we discussed already internally.

I cherish postcopy doesn't need to take bql on its own in most paths, and
we shouldn't add unnecessary bql requirement even if vhost-user isn't used.

Personally I still prefer we look into why a separate mutex won't work and
why that timed out; that could be part of whoever is going to investigate
the whole issue (including the hang later on). Otherwise I'm ok from
migration pov that we take bql in the vhost-user hook, but not in savevm.c.

Thanks,

-- 
Peter Xu


