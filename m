Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D63CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7yl-0004qk-Os; Thu, 04 Jun 2026 09:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV7yi-0004nC-NR
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wV7yh-0005hu-7j
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 09:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780579158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgOwZNI7KPN4QVhMDFgkQQQfAtQVW8qLdijH8wJDYvI=;
 b=W1MNCGHdXQE5AcjHSLNYSYtljWub65JJJcJ+FAirrKy9i6MOVd/d3hlK65RGRsEfowSfBm
 kOKSFh42Ovj3wemsOVbVvvbeFeeshj0+Jbxo3qgTvIikzwCMrmDcWVRoQ4FPXOkRn7sFqs
 QLuAQkqNNc19UzRk9Fc+nHBzctWBH4c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-7KueZTyQPVST42sN95LyPw-1; Thu, 04 Jun 2026 09:19:16 -0400
X-MC-Unique: 7KueZTyQPVST42sN95LyPw-1
X-Mimecast-MFC-AGG-ID: 7KueZTyQPVST42sN95LyPw_1780579156
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cce2b4c290so16384976d6.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780579156; x=1781183956; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bgOwZNI7KPN4QVhMDFgkQQQfAtQVW8qLdijH8wJDYvI=;
 b=WOsNFzG0r2bKe2orp9GaMEY5rB+pCsBVVEkp1iHQcL3YJMup5CVNhG5lcmDJJK0sCa
 z+vjgBmOviLiA5LQ0t3edbR8koEIOtKrZilG1i90GkuK+WDI+vQyUfbJCKtRH9cMaumV
 xtuhyJJLQQ9kcnVPjfAohl1TdGruq5fa/B7KumHMkn03pBm9EQxpv11GfrJjuvER7rZ/
 2EVcediQzzYdwCAnmK2knpxH6YMAfr0H56TKS96ywTr/EhQ6Mwrih9skfWiCL04CSRaD
 DQe41aCEfga77IaBCx+aSrXuJAHFRGzs1fnvyLie+Yg67njkdpLDH2s5ZeSeOjXJU3bT
 a/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780579156; x=1781183956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgOwZNI7KPN4QVhMDFgkQQQfAtQVW8qLdijH8wJDYvI=;
 b=l7XS12I5xCpvsmcDby+5kvi9WZ+4Q69JWKlg0v1E6V1keX9meFlBR0qmk+noXI8QDp
 72PlbLqFlXG6D7LjbNmdNv142kRWfyXJpgRn/Svzs6Ght5C46wkZCAkNxFT9C6456D4V
 dV7x/1AJF6z8vkdX+hFBh0DelhH5pxglfpKz8suD9N7ElSxcAMdffsL+ZIr8xixTsyOU
 wnX7bF+qlsJsJpsUTW8mYhe25VaYcQLqwiT/GLX2f4DBojKR4RDrsTu5h+e+1/5Ru8rW
 ocmxL9Wc8CSt/JAljmkhZdlXtN1MwRi8+GE9ITE0FEP2vgCCD0DZAOMROvNCAZW6fza4
 581g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/opphrtSvqOpDGty1YsNOhHrO8uF7pgqHjzhKGJ/0/58jj8OSfCpUAOm+7/UbEsquM7QmUREo7+9hg@nongnu.org
X-Gm-Message-State: AOJu0YwvIg5zkLmf4lYaCaFACAi2N3G44itLK4id1e3oha1tz5mIuul7
 C7f4mTvNwKPawiW0QyJNnWyVG40v+C0rFRnI9dsMYwgNkJUOmUmqqyM/GEbmgWwo22Ki5PhExiE
 m0iq8ls3b+o62kSDYwqDVSQIo0VZQlXIt8A6RApG+py9WUAGETMSpTLTt
X-Gm-Gg: Acq92OFzN2h4PZ/vqSW9KHu4CfcNwdR7SlyfObfTGnxTidbM+c83O3ct+/SKN99OwIU
 ca659WoassgXanncp8Pb1fKsXn9NOu13CMWauFGqlTDfgqZMYxqlQnQNU9S8+mW/X72yY1QA/Y9
 WrnsvK0p460yAi6rxHs1Qfj9VozYUQrWkU3aKb9v4fmcE3a8VovZGk14ndeKggjkhH2Kg7BjgCi
 USCzB5nUd43JBNea22WwNis3ldl5cGSUTw44AFWSc0tAJmqOHpuQFyKN13e82e8KLR/Sez2o/Dc
 HgvFvfslq0ivCkLEXSu5qH2WeeTfHEmPyGQRqbH31RM+8L1uo/V/e/c/Pmx33UMfBhZ1WNAmezn
 B2LbljzvvAaIG2ZYeO26nIKa6UA==
X-Received: by 2002:a05:6214:e48:b0:8ce:abea:4735 with SMTP id
 6a1803df08f44-8cecdd13b69mr112475866d6.39.1780579155788; 
 Thu, 04 Jun 2026 06:19:15 -0700 (PDT)
X-Received: by 2002:a05:6214:e48:b0:8ce:abea:4735 with SMTP id
 6a1803df08f44-8cecdd13b69mr112475386d6.39.1780579155184; 
 Thu, 04 Jun 2026 06:19:15 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd051d61sm51813546d6.29.2026.06.04.06.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:19:14 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:19:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiF7UY6LPbYy7Ha_@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <283f85de-92b0-4c62-94ed-631221b62c07@nutanix.com>
 <aiBPakzg8080IOfo@x1.local>
 <256f5918-0e33-4904-bdc9-8c0412fddd04@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <256f5918-0e33-4904-bdc9-8c0412fddd04@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 04, 2026 at 11:00:17AM +0100, Mark Cave-Ayland wrote:
> On 03/06/2026 16:59, Peter Xu wrote:
> 
> > > Is this part of the same problem in that the migration object needs to be
> > > created much earlier than it is currently? And could doing this
> > > potentially remove the need for a separate CPR channel?
> > 
> > The problem is the migration object can't yet be created too early, due to
> > the fact it needs to apply compat properties.  That's why this series used
> > another approach to have a temporary early MigrationParameters object to
> > keep things until migration object is initialized (during which the temp
> > object will be destroyed).
> 
> If the MigrationParameters are needed earlier, then presumably devices can
> only depend upon the value of migration capabilities, and not the value of
> migration compat props?
> 
> In that case could you not just build the migration compat props with
> .realized_set_allowed = true in a similar way to e.g. hw/nvram/xlnx-bbram.c?

Could you elaborate?

A few contexts to provide:

Migration object (even if now a TYPE_DEVICE) doesn't use realize(), and it
will be TYPE_OBJECT soon, which is at least the current plan.  Direct use
of anything qdev specific won't work.

The other thing is, migration parameters by default should be allowed to be
set anytime after QEMU starts but before migration starts.  I don't yet
understand the reference of realized_set_allowed use case, and how that
idea can apply to migration.

Thanks,

-- 
Peter Xu


