Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A71FC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6uTF-0007X0-6I; Wed, 16 Sep 2026 14:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6uTB-0007Wd-8v
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6uT9-00014k-0B
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789583693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ympUeyP8j1uprO9LQ5N1t4b3impkrKz1jkXOMizHbw=;
 b=d+GDlOVmGN9CHIIZXyJjx5it9tSX5XBq4f9tkxo2oPl/llBnoRlzyF+58QEu/7igoOeh7S
 CY5ZFdNG3RjwKOzL4A+SPfroArZRNVmKKKrqQ/8BTaCxQpWftTUbiaHz0NhG5TP30DPsM7
 RpgVIExEi61FWEEo4DycI2X8pJLI6x4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-u1zaor3eOqmUmFS-WiObWg-1; Wed, 16 Sep 2026 14:34:51 -0400
X-MC-Unique: u1zaor3eOqmUmFS-WiObWg-1
X-Mimecast-MFC-AGG-ID: u1zaor3eOqmUmFS-WiObWg_1789583691
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5328dae1305so2129051cf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789583691; x=1790188491; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3ympUeyP8j1uprO9LQ5N1t4b3impkrKz1jkXOMizHbw=;
 b=jnQtOjAV4Q21+dxvREIrI5kLkxqN1PxZfk62J7ugL2Pi8+COtRl5w7n6TsXTKA7AHp
 1VAyBkGmaeDiePBcdz9ljsHpv1A54R4vqBti9vJM4kl8mdijPAHArCXiCUMnCN1Pwd8Y
 IkP49TP0NFUM58cwFhi0UHD2tEl2EAE/HRZowp4LB2w/OBYq/VfgNLLwfg9MzdF+2jPL
 5RBtOwnuB4wmhXdl0uzA2WQTtGAE3FQHCcdcLw7PTM5bBRxNUynkFyElU6jOnacgoAaU
 uc/CmZyflzII3s6RN+YWWzHPN5D9oALLYy7oHdRjQG3kBbsIimZsFMZgA5uiE6a/tgDD
 XrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789583691; x=1790188491;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ympUeyP8j1uprO9LQ5N1t4b3impkrKz1jkXOMizHbw=;
 b=KeZFPnzwtScZGIOYEM2S5N8mfY5AYiCs/4Dhmq8Pe50LTgOy7GaH03muRjbklgg+Fr
 2Nt8MUEqigEnJZxI7ztxXVk9bKsqNFkRdj6AZLbeFLW6Vkrp5yeHXDQ0qbBj7A7kv5z9
 1/2Zk8yg+acKUKcz9GIFfvuC2Kf0/IpYqxCXFElYByyucz6Cv94bFrZBLQWv2qaGsZqe
 hg+Z1OEqYoIXOYQ5EMz8nRa2fXE9Pj88FUAH/x+bZEU+yTghMc6YcLWpCPkhXaRAtlQp
 TXdNOwz6YJt1iPIAcvhSu8McMVqvp7htr5DEkxM/cEVAfkaSxf5mPEvkAU/x8yTMtu+g
 5lQg==
X-Gm-Message-State: AFuF++nEwW9zk8c4YnC09MAp8IN8OrSnG834X/VDP5NuqUchDba0VW/Z
 w8y3wC5ej040iJez5HdfgsiERpb2pgb1eSEJMIQxMRvRgTnZQ7SfqfxHi6Fp3nROJfguzOOT4FD
 qAd1q0qxLq/fo9B2YMo1eWbTXgjvM+a7FXIuUMtoB6bSwlhFLosjCnIC8
X-Gm-Gg: AYBFou065Jm2LsKau1gDrPpl3tvdK2/sVjKm+Hqo4TvjnLcx8ALlVc2FSUElM/8nZcP
 K2oW0yw51joyIhpN2bUKwgTX/CfZa8vgvI4p2/M7NgU3ONUR6z5L3jeU8fgEaUThaCwPKBVImgi
 8DgIceTcUYtpW7d57wPnT3EVSPPuyfLwyrOKOt6JFhRLEp0rw1u33m8lPFz62b+R1Cg4gjxFPy5
 6K2by0s5V+dtyDW+emz8OZi/v8iaIB9Xeb0G5OB5QURhUayLw31Jn4AotgqptA9ldmaBO4XQbs7
 mYRX9xDoIk7hv8ym8Xupme3dD7SmOpjn14vCyzvqFH3PlY1Yq2oAXeOc1o8M5O0cEHWXPlUJWTX
 QhB/Q1Wn+OcPgFUgIQzXIRXqFvTGyn90uM0W5rSNnbJee28jHY79Yj6Cvf8o=
X-Received: by 2002:a05:622a:5c07:b0:531:4a1:fecf with SMTP id
 d75a77b69052e-5327f205baemr58542041cf.5.1789583691189; 
 Wed, 16 Sep 2026 11:34:51 -0700 (PDT)
X-Received: by 2002:a05:622a:5c07:b0:531:4a1:fecf with SMTP id
 d75a77b69052e-5327f205baemr58541441cf.5.1789583690652; 
 Wed, 16 Sep 2026 11:34:50 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5326204ad36sm28740861cf.18.2026.09.16.11.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 11:34:49 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:34:39 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
Message-ID: <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916132428.1628553-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916132428.1628553-1-den@openvz.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 16, 2026 at 03:24:28PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> The cpr state is a process wide registry of the resources that have to
> survive an exec. Entries are added and dropped from realize and teardown
> paths all over the tree, and a caller has no way to tell which thread the
> next caller will run in.
> 
> The state carries no serialization of its own. It is safe today only
> because its callers happen to hold the BQL, and that is a property of
> where those callers live rather than anything the interface promises or
> checks. A caller that is correct within its own subsystem can therefore
> break this one from a distance: two that overlap corrupt the registry,
> and the next lookup walks an entry that has already been freed.
> 
> Give the state a lock of its own instead of relying on that. Entries
> move when a device is realized, when a resource is handed over, and when
> a migration starts, so none of this is on a hot path and an uncontended
> mutex costs nothing.
> 
> Take the lock in every accessor and across the save and load walks.
> Holding it over the walk callbacks is safe because none of them comes
> back through this interface. State that is not reached through these
> accessors, such as the VFIO device list that hw/vfio manipulates
> directly, stays outside it.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Cc: Ben Chaney <bchaney@akamai.com>
> Cc: Steve Sistare <steven.sistare@oracle.com>

Is there a real problem anywhere?

My gut feeling is we shouldn't be randomly adding fds into cpr unless we're
creating a new device or so, which should normally need bql already.

To ask in another way, shall we simply assert bql_locked()?

Thanks,

-- 
Peter Xu


