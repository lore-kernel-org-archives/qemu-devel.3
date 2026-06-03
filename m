Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D373ECD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUnwl-0001RA-5k; Wed, 03 Jun 2026 11:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUnwj-0001P3-Mv
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wUnwh-0001Ks-GJ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780502153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=En83FSP12+T4wVjlIj9J6aqoQBCNBaC1yETUkdIdu0w=;
 b=NM2NjuJ5LsPQkVox5ekDng/qrZc25vejZZFykzh9vjBeFEcRhslWaKuFkRa1paI66hHNOP
 j1vXzZ7jB2vYOauP6wxkJDrbCrsodG4jKqSmI4i+6/Bsr4EcNBzo58D9hOlIzX03/d2zoj
 FWqKYRmETGyrJO0r6W15ZsjdWnXyiP0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93--CYTmt2KPhC9mxrWpi3Mmw-1; Wed, 03 Jun 2026 11:55:52 -0400
X-MC-Unique: -CYTmt2KPhC9mxrWpi3Mmw-1
X-Mimecast-MFC-AGG-ID: -CYTmt2KPhC9mxrWpi3Mmw_1780502151
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bb6c41341so7077570a91.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780502151; x=1781106951; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=En83FSP12+T4wVjlIj9J6aqoQBCNBaC1yETUkdIdu0w=;
 b=mDoJaySZN1IcdEtUT8VdNVLX8Mb+zGzvVNea6SNGjb1B5uKad8T8MSjFGtjl8lYffx
 Lr/e9jKFVU8gzMbg/Y/i58ILJvkdjdrWUpZ86P/Y8C0QYYD9MX8dhpgVzyfK3fR8qRkD
 Dyuly1fBCKdlccTCdxXICSRobtpvIheq9RujaE+sjuegr+rgD32WJ1XokZXqpOAsv0PF
 RRsNN7qf6oy3IGgnJor8I+WKoBoDAucaIDTAz0KTtoR7ItpJG3PwmK3uzU+Xtx0cnJGp
 s8VdoVohl0AM/DtHc8fC6Nf59yTdxZSFwGVgWsrnuCRC6iptudQWkebAQ2csaT+R4l+t
 MlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502151; x=1781106951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=En83FSP12+T4wVjlIj9J6aqoQBCNBaC1yETUkdIdu0w=;
 b=DG7GyYxWrMoUkRGQna19bNbQDGYRq3iLIJknEnk+47Lx5ERFhOYUMPtzB4YhbF07LC
 NQ3/TcGREdXgASWYmqCQmMhv/yToehQvOG5kt+P3lPVbHrZX91JIYaKxxUzKKDBmMGxg
 zudj7kixJu4vCrBRtk+eQDFbsEM0qcdZUqaIzhYmduyP3W7F/o63jlmNxX7CgibAWesb
 KgNtFJN8y7keYNNVISa67UEpJnH0olm6GC/26OkUX4byQ7HO+xY1MzvPB9vB5oDvddHs
 /8DUxnT+yyTmQmLixfcGAbQhjYThOWo26cFSKUj/PUZfnWqnmHbwjL6VgmVd10pGKKg2
 f7Ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+D6EAgZRA6aPdRFRku16lf9lwyqF19Mx0yR3vE3kSQ4sjpnI5q6mjkZayO80suEy+mjGuge/Y+EQFd@nongnu.org
X-Gm-Message-State: AOJu0YwMQAEsNZkztX2Vlj1wdybTnydt/r2A2kHsGWkElliE8eAu3Mps
 IyU5zPZ5eS670/g02LEaByHAYhhNzPkX0QbY3QdqyoSM8QyZ5+eDtLnwPGMwC+pSgYcdNJ9RgmU
 VWl3eaiaDr1NbU866sIrZPUkZmJ+R7V6tdtyWbC+4ShbJcGC4mrV23Zyx
X-Gm-Gg: Acq92OFEdQYcCt706En0VM9cxM3CHlEbacTAn8DUHMofKc5VM5lJURwB6/SPdXYDcWY
 zHs1eZiKNdtJvI4r4fd/zFr+tODRH4xdj2vVQJoOWwz5xtPqr2QhMRwVcB6prfAItL782gUUHZp
 WoIVU+97W5EQ891qaq9HWL7uSzNGxfVW3N5asBEqTTEH+bSgKcBec4A2zNXj/681fY5g3s530XS
 n8Y6LSX4FgdMvtjlzrkhRPFhqAkF/MZLvAZ0r6UQq9z32mNHlFRorbRyxVQdm7vRYzCsIdAHxVS
 OKMzgfdn4Sapy1t+neWed9jr/7pxKnITgKPLi3dU6fhJjSRiN+nH8kjOIXLgfq9835s5t3V4ACl
 Vu2JYmH5AbaqDu9e1abzBYmiSfw==
X-Received: by 2002:a17:90b:4ac7:b0:36d:df4f:ab2 with SMTP id
 98e67ed59e1d1-36e30a298b5mr3971966a91.13.1780502151079; 
 Wed, 03 Jun 2026 08:55:51 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac7:b0:36d:df4f:ab2 with SMTP id
 98e67ed59e1d1-36e30a298b5mr3971937a91.13.1780502150536; 
 Wed, 03 Jun 2026 08:55:50 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f714e26afsm45854a91.17.2026.06.03.08.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:55:50 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:55:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with
 -incoming config:*
Message-ID: <aiBOg66Txxwv6w3I@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com>
 <87pl2ftc12.fsf@suse.de> <ahmrcVkOWW5iwozk@x1.local>
 <87cxyetbc4.fsf@suse.de> <ah36ZhBP2TweYhg0@x1.local>
 <87zf1d6p24.fsf@suse.de>
 <12cf9760-831a-410c-b8dd-a9bc6befbae3@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12cf9760-831a-410c-b8dd-a9bc6befbae3@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Wed, Jun 03, 2026 at 04:36:37PM +0100, Mark Cave-Ayland wrote:
> Is the longer-term goal here to allow machine-versioned usage of all
> migration parameters supplied via -incoming via -global?

Nop.

Machine compat properties sticks with machines, they'll be applied properly
to migration objects at some point (needs to happen after machine object is
initialized).  It'll keep working, no plan to change that.

This series is only about exposing a new API to setup migration parameters
so that modules (like TAP as backends) can query at very early stage of
QEMU boot.

Thanks,

-- 
Peter Xu


