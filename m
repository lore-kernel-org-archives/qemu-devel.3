Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386D2D729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 16:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH48P-0006Zs-Og; Fri, 29 Nov 2024 11:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tH48I-0006YK-CO
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 11:46:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tH486-0007yo-UK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 11:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732898758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q31rL84aVSmtZptqFfj7RihtHrRM45WcSTi0j/N2SwM=;
 b=E+oYDwsUlw7kNt/+0azkxYXrw44xkQbI6CW82rSqOf7kP55tVILU+8Sdu1atwjak4CSCmr
 eiMKtB9v59vaVhLGZyRGEFFe/Kx1beWIGLep9od5aEeYASeRksincPxFC7qgPvR/irDi25
 mPZfgVJBH/UlJfzbYdbVujjuSB5QcYA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-S_LonLN0PaGQ1UENgxMsIA-1; Fri, 29 Nov 2024 11:45:55 -0500
X-MC-Unique: S_LonLN0PaGQ1UENgxMsIA-1
X-Mimecast-MFC-AGG-ID: S_LonLN0PaGQ1UENgxMsIA
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a7e0d7b804so1811205ab.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 08:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732898755; x=1733503555;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q31rL84aVSmtZptqFfj7RihtHrRM45WcSTi0j/N2SwM=;
 b=ka3PPHbKLLgMbtiFT7gvkIhCGKGqj8W4oPh1BEfQkhH+4ZyVbD5Jx4h6U6Ap2NGy7/
 AG6JdqiEGDPALnE1xUDRIDqxiu06C8q372rpLetopDP8ijtY0L5aRZ3OLPWB2pGL1ACb
 14kkDF7gHVERiZUsXh50m5qyVvIPYNteyTtBYxv0eRPBzLBTlRVK55eGZnMitPKC6dh3
 hL02Vea0DMLxYCUxNo5aOucop4qZdD9PwpuPo+OZ5MtArUdLglRolHHn2N5smFps2Y4A
 vE12rvEDtgLAcOYauLzNqZrSaoQjhRViRdJBSpK3hxUn77sfrWr6Dx8WmAcik84em8DE
 ue2Q==
X-Gm-Message-State: AOJu0YynmfZ8v6BnMzsZjq13R82ea6d4l5MltTpQ1ipE06oUqZ8JWlJK
 bw+DNhIDQJ3r1GNevGulOEGgJxgHYoIEdfeHiP1xmaS+32Ca9QYNmJ8yvYbJoGUcmvAOuDysEd0
 f2ugxqpzyB/Bd5wnmWycYPztbhQ/Wbvbm/jT2aUreLClo1A13gp1Y
X-Gm-Gg: ASbGnctk1HWe3i3Dfj2/RPW2U05M0/Fv9YNAa38w+pmfatoODK7sS74jRSZvUSsn4RL
 iImdzT+wpgpZ56JwVbs6GP7n+ayiN37XktZZ1rFUaPGkb/wPaS7vn9xIWNfkPYV+QqWyJJU/AGf
 akaNcaZtujy+KJozb+gYSBxQi4rLR3XLgKz4QdQJreFcNrWVem4/oZ7fHOEV/sB6rZb4zoZ+9+/
 TFyRpmDdGd1tBHHcK8IJgoVo9eLuAXfKcbMqASiTX4nYq8zTjaVe5VC6hVe435075hvRKksfEFt
 pje7YqeMeZY=
X-Received: by 2002:a05:6e02:13ac:b0:3a7:1a65:2fbc with SMTP id
 e9e14a558f8ab-3a7c55f261dmr138562805ab.23.1732898755020; 
 Fri, 29 Nov 2024 08:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvCJ2sKsI+veQUd7euSLCVfHc7ggcclprOK5ISlOHw3s4oFtFL2f8oYlLjnstvv/5PE3zwhQ==
X-Received: by 2002:a05:6e02:13ac:b0:3a7:1a65:2fbc with SMTP id
 e9e14a558f8ab-3a7c55f261dmr138562555ab.23.1732898754700; 
 Fri, 29 Nov 2024 08:45:54 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7deff6fd8sm1865175ab.42.2024.11.29.08.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 08:45:53 -0800 (PST)
Date: Fri, 29 Nov 2024 11:45:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2 0/3] Allow to enable multifd and postcopy migration
 together
Message-ID: <Z0nvv23M6bCnJrZc@x1n>
References: <20241129122256.96778-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129122256.96778-1-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Nov 29, 2024 at 05:52:53PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Hello,
> 
> * Currently Multifd and Postcopy migration can not be used together.
>   QEMU shows "Postcopy is not yet compatible with multifd" message.
> 
>   When migrating guests with large (100's GB) RAM, Multifd threads
>   help to accelerate migration, but inability to use it with the
>   Postcopy mode delays guest start up on the destination side.
> 
> * This patch series allows to enable both Multifd and Postcopy
>   migration together. Precopy and Multifd threads work during
>   the initial guest (RAM) transfer. When migration moves to the
>   Postcopy phase, Multifd threads are restrained and the Postcopy
>   threads start to request pages from the source side.
> 
> * This series removes magic value (4-bytes) introduced in the
>   previous series for the Postcopy channel. And refactoring of
>   the 'ram_save_target_page' function is made independent of
>   the multifd & postcopy change.
> 
>   v1: https://lore.kernel.org/qemu-devel/20241126115748.118683-1-ppandit@redhat.com/T/#u
>   v0: https://lore.kernel.org/qemu-devel/20241029150908.1136894-1-ppandit@redhat.com/T/#u
> 
> 
> Thank you.
> ---
> Prasad Pandit (3):
>   migration/multifd: move macros to multifd header
>   migration: refactor ram_save_target_page functions
>   migration: enable multifd and postcopy together

Prasad,

I saw that there's still discussion in the previous version, while this
cover letter doesn't mention why it was ignored.  Especially, at least to
me, what Fabiano commented on simplifying the flush condition check makes
senes to me to be addressed.

Please cherish reviewer's feedback and time contributed, and let's finish
the disucssion first before rushing for a new version.  I'll try to join
the discussion later too there.

Meanwhile, before I read into any details, I found that all the tests I
requested are still missing.  Would you please consider adding them?

My previous comment regarding to test is here:

https://lore.kernel.org/qemu-devel/ZykJBq7ME5jgSzCA@x1n/

I listed exactly the minimum set of tests that I think we should have.

In general, any migration new feature must have both doc updates and test
coverage as long as applicable.

Multifd still has its doc missing, which is unfortunate.  We could have one
doc prior to this work, but it can also be done later.

OTOH on testing: this is not a new feature alone, but it's more dangerous
than a new feature due to what I mentioned before, that postcopy needs
atomicity on page movements, and multifd is completely against that from
design POV due to NIC drivers being able to modify guest pages directly.

It means multifd+postcopy bugs will be extremely hard to debug if we don't
put it right first.  So please be serious on the test coverage on this
work.

Thanks,

-- 
Peter Xu


