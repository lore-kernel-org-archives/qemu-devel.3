Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80363CE8D4A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJw64-0003lF-Su; Fri, 14 Nov 2025 10:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJw2l-0001om-By
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJw2j-0005fn-MX
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763135335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ks19+HOMfuiyHVjAWMmzRq2PuXHn9MIBnVt0hTO/8jQ=;
 b=XicNAMQE+zoTdjWi/lRtxmu12ipnbnRBeIKMl28n/yVAJJyCLKGk9axsztjcE1fnQ0gyhw
 6sBIGnFqFNvwBC+IyOPO0tJnMV+jQbfCK0G3mah1mH+WGLWND9dZMtpDSRXR3uzAWXjpRi
 bp2eu/midsCZIDpG19MeQcbEb6KPDMM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-zOb7CUaTPb-O8zARxZgsCg-1; Fri, 14 Nov 2025 10:48:54 -0500
X-MC-Unique: zOb7CUaTPb-O8zARxZgsCg-1
X-Mimecast-MFC-AGG-ID: zOb7CUaTPb-O8zARxZgsCg_1763135334
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8805054afa1so55149886d6.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763135334; x=1763740134; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ks19+HOMfuiyHVjAWMmzRq2PuXHn9MIBnVt0hTO/8jQ=;
 b=ZpE9IeO293yRP0vFgSYLzAn+WbVd+7iDZdEiMH49Ba9hBfDsVdmOe2ryJ3E4f8E1f2
 z8OdcpbpnOhyBo9/S2gX8poKXnsi1OjU+uyXrmg1NrxsuRdNTLDUc9cvaamjNaxP6UYB
 xeVINXPQi/xywXRK5G+N11zRyhGW11me6oS8ewmBbZE1rCEFfEwL4Yv67cQLydATuoxj
 gmTCHXAutGLj7YhC78Oc5Uc/bIeE+BOIGwL3bSOqn7bt1OFeh+OdY09YgeNjk+UMgqTs
 jvYLvMObfRbi0TEaMrGyci65ADlCLKxJG4Hc5Dnh10ufETGEHm8eLl7pbEhMmECYn6tu
 /lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763135334; x=1763740134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ks19+HOMfuiyHVjAWMmzRq2PuXHn9MIBnVt0hTO/8jQ=;
 b=nvILOrEPw1LoGoQw9VLzPogHuO625RtDxCCqNynBj7zpkbocRd4IZQBZGnu3UoIUyB
 JN/jAE1NxKQFt/c9IIxB9i8gD9Mfdcecx6Jf48PeadyD0xo2L8UmQuNrSc911qWCKgn/
 eHBXc9o910QO15fyNtI8jlgi6Uv+oJKLjfLeBM7GXX2/2bvljgcGUpEsG0jqbk6nPwIP
 1nJnTU3oDTB1IOD/zXgBuHR+ChsjNtNcm7PtGgRumCsJbiTfbGgUbwsLZBbdsgyC+4Wu
 KBiPyWA4OonX6iioiVyuRDx4uVtS5j/fkgAAhGWf3zbaF1cKNMINMOuOMAS3nJKfvVyB
 1hhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5r+eSgkEb0FTv+vd0VzmeOC59gM0d2oanSvzhmApEYjKh8bypaOkIIZ4Gk8m0oNiYzrB2j3n4LwAk@nongnu.org
X-Gm-Message-State: AOJu0YyT/2gnLBoYaliJ6t1queqDaeeTc+ls2B5ZBSRUtUgc83SyqNJj
 IhXuM7RHlLY/XA05b8Fqk8M/UqVLM3AxcBqQXTLqAAWW6HXOM3bDFcQV7J68XCCzlwYa4Ti7Z4K
 muuODqe8Y30MARxy2bmsfGhePc0/+Q4nFXXHf2fpIIgv2Z98xx1f0q8ex
X-Gm-Gg: ASbGncuUxKCOHvPi7Ii4dCSXA8f54gKhVER2elqAykEDVWrxQlx0p6ijb5JMBPBb7gd
 Ta5MnCz5bAejZgq060IwEimh1pRPVtrqrmiC5ZK0ZKZTxB75x1ZA9U0gfS27/ISVwncN4mS10Y/
 qef3IW7uNDx5XiiOMeQh0lNJVGBHzTMqQzfSewYNmhUshv/wSzPm6MDMco3C+Lcouc3YFs4Css1
 3I1QwEGUd/fZLPQIs8ZN5l6J1K5coRJMJVO6fRNQTfaCxNscrTWDmDyAZsb/bd3s4P/+TW8MaNm
 uCXKf9dpRGi2NP/NE3lbg5EAb2isJwTAodAp3wRpUgj3Y/ez/haoGeqB+/923cHJaZmKPl0cUVZ
 Y1Q==
X-Received: by 2002:a05:6214:2a47:b0:880:527f:9493 with SMTP id
 6a1803df08f44-882925ba930mr41295566d6.12.1763135333695; 
 Fri, 14 Nov 2025 07:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIOgDm+0WJKNevCwFO50nyWz9eriojbmtwj9zR780qfiEnG6QrRsdTfz2uWO8YHrTlm9HnuA==
X-Received: by 2002:a05:6214:2a47:b0:880:527f:9493 with SMTP id
 6a1803df08f44-882925ba930mr41295186d6.12.1763135333158; 
 Fri, 14 Nov 2025 07:48:53 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88286532f4esm33469916d6.37.2025.11.14.07.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:48:52 -0800 (PST)
Date: Fri, 14 Nov 2025 10:48:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: farosas@suse.de, steven.sistare@oracle.com, alex@shazbot.org,
 clg@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: set correct list pointer when removing notifier
Message-ID: <aRdPYVnrrWeRFf9D@x1.local>
References: <20251113213545.513453-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113213545.513453-1-mjrosato@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 13, 2025 at 04:35:45PM -0500, Matthew Rosato wrote:
> In migration_remove_notifier(), g_slist_remove() will search for and
> potentially remove an entry from the specified list.  The return value
> should be used to update the potentially-changed head pointer of the
> list that was just searched (migration_state_notifiers[mode]) instead
> of the migration blockers list.
> 
> Fixes: dc79c7d5e1 ("migration: multi-mode notifier")
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c2daab6bdd..9e787749b2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1693,7 +1693,7 @@ void migration_remove_notifier(NotifierWithReturn *notify)
>  {
>      if (notify->notify) {
>          for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> -            migration_blockers[mode] =
> +            migration_state_notifiers[mode] =
>                  g_slist_remove(migration_state_notifiers[mode], notify);
>          }
>          notify->notify = NULL;
> -- 
> 2.51.1
> 

queued, thanks.

-- 
Peter Xu


