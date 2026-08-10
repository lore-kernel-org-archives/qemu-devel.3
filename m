Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE00C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSFm-0004kE-4k; Mon, 10 Aug 2026 11:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtSFk-0004k2-17
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtSFi-0007tq-Ic
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786376965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vD645EtleOUzDowepCXxZgoK2vO387+nDjXctvWuVAE=;
 b=IVABnIWsxo5goHERll31qntcFvNX9jgqi6jVYfWD60KNWG1IrdNhWUla1UGV8P+MNCw3gW
 9u3ZqBnZORPy3aVCqcpt6ppA+kis9SYH6UHPl06YrodGYeJvFMGCtLdaYJSBk+K26ZnkRK
 YUZSEiQEAtyyWXfcNn4ZUQanvL4dC+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-Qph1QQymNT-Ys08voHvoRQ-1; Mon, 10 Aug 2026 11:49:21 -0400
X-MC-Unique: Qph1QQymNT-Ys08voHvoRQ-1
X-Mimecast-MFC-AGG-ID: Qph1QQymNT-Ys08voHvoRQ_1786376960
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47fe23b5acdso1944806f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786376960; x=1786981760; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vD645EtleOUzDowepCXxZgoK2vO387+nDjXctvWuVAE=;
 b=UyZlaDKM9BvsCgMHWg2kEGbLASOnERWEU7qSFd+/7W/Ty5g+PeOdhVbRfFbB/a+Ze6
 0X4SkHHKpgv6AZDP3wq8N58oI+QlPkSWtvIG/QbnFka5LRc/WemBUpMq0gKIVrzPNBC6
 O/QOMeC9XDzhFwL6mSBVx6ga8V1vyc5mLSOztX3SCLh4bYb76gZwyJykZ1uxyHolRqyZ
 Y8mpFy7QipjsKnSM8Vu9pOBbPyFjvM3pvGSqmbDk7QA+i829nlZu10hfGat0gnQXpAz2
 HatEKmuqAIMR+cehxQz6TShd6xBsbS8HEUNLXLctDTz733Fx4a4Zd2vI5D2xd4N7JXmQ
 irig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786376960; x=1786981760;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vD645EtleOUzDowepCXxZgoK2vO387+nDjXctvWuVAE=;
 b=XoZYxl4FfQeVcMiCH7JYDIVDAZdttFfNGExplHvQ9A+YZPA+PUVVZkDHfI61prQhNa
 IbK7DsO2tBfS7lD27J6vroKLahPGjZlw/RJv35Xy9V7ttoROuZADJu7uDMH5jfpLAmSN
 XZLzRHI1zMjP03qfbI6FfaUUiklHnWKgTeg+rELGsDuozUb2oWZCvrOBSh1eVNI6YkqA
 n1PG4+A1i/No5DyCDSZ0iWvcmIYOQOjAkbxLZn/1yjsV8JD6vp9BbY140XOuwoqZ7fRy
 33ha5Vut0FHC+KP15S6rExW0WLiCQo/uPZGhs/HBxW5NWNkcHu7qjkTeLAT1NkfthRUd
 kirQ==
X-Gm-Message-State: AOJu0YzyKRbVZfhIRZT9/cVj0FHeDfqTZbsxs4ykWxElo4zeF16T1tg+
 l/lw/3Z/Yn70PcfaGeWtdfiOIGVd/xHgqsyN28Vhd2h5raFhxEONhSU09ZU4mpee7z9DT+Ami79
 uJpaTR+/qBWBkgFO9XWXo6RZiprUpEPCW50TD4vyseQmaw394lCo7W9AE
X-Gm-Gg: AR+sD11NEOAc1VQ4E7Edo8GrPhzzNFBWlPL2QjUt2FZQdZ80D5niJutNGqovB5a6RY2
 DFMBHsQU+bsrRk4HrrVnM+j0tEVRZv9N3/nUxmkSSqSrOA0ub7e+G56+BSwQzdxxxWek9uxmIP7
 IjITBDge1Huz/dA5LEBtvj7bYq25I7/A7xMl145f/5zbsxawMnBMUufs/0xBw45UuyI2Ty0shjS
 kqYSMSXQ5cwrdJaxQd+OeX4/VJirY/U3BAqWzthMPum2eWeivktv3qaQN0zlxt9jPfTbmjimUJ2
 HLUC38LzWneb1VUmVq4WgVkwUQBEYh2WXKDPmoBxatPYqXMZYc8rC1DW
X-Received: by 2002:a5d:5888:0:b0:47f:aebd:841d with SMTP id
 ffacd0b85a97d-47ffd91848dmr49870773f8f.15.1786376960341; 
 Mon, 10 Aug 2026 08:49:20 -0700 (PDT)
X-Received: by 2002:a5d:5888:0:b0:47f:aebd:841d with SMTP id
 ffacd0b85a97d-47ffd91848dmr49870701f8f.15.1786376959993; 
 Mon, 10 Aug 2026 08:49:19 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002206effsm32603199f8f.32.2026.08.10.08.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:49:19 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:49:17 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 09/11] migration: update capability conflict test for
 postcopy-ram+mapped-ram
Message-ID: <anny7SztZXyLtfZq@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-10-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-10-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> Remove the test test_validate_caps_pair, which asserted postcopy-ram
> and mapped-ram capabilities cannot be active together. The new fast
> snapshot load feature is exactly this pair of capabilities active
> together, with the following patches in this series, this combination
> will now supported and be functional.
> 
> Remove the capability check that rejected mapped-ram and postcopy-ram
> being set simultaneously, as this combination now corresponds to fast
> snapshot load.
> 
> Add a capability check against setting multifd when configured for fast
> snapshot load as it is not supported yet. Also add capability check
> against setting postcopy-preempt as it is incompatible.
> 
> Add infrastructure to check postcopy_notifier_list being empty in
> capaility checking to block vhost-user with fast snapshot load as it is
> not supported.
> 
> A smoke test exercising this feature has been added further in this
> series.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  include/qemu/notify.h              |  2 ++
>  migration/options.c                | 20 ++++++++++--
>  migration/postcopy-ram.c           |  5 +++
>  migration/postcopy-ram.h           |  1 +
>  tests/qtest/migration/misc-tests.c | 52 ------------------------------
>  util/notify.c                      |  5 +++
>  6 files changed, 31 insertions(+), 54 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


