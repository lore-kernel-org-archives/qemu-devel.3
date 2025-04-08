Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB75C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 05:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u21To-0002pV-Jd; Tue, 08 Apr 2025 01:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u21TW-0002mk-Ko
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 01:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u21TR-0004ZS-TI
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 01:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744089970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hVdRnIze/EWTJ57HwuEcu59PSYXpeukf1t+BMjsWVHY=;
 b=blirtyxQ89B3HGyaA39lhw0ZAjLm+CxXqLsLWRQJJNG93nG53CQg+aOwJb4fwPCs8sepVr
 m6dt5W869NcKOZMZK6xC/0Fn7298jY66pVYNIkOAhexKJm4tRmA1KYG4ti1xGQkrhLLhBj
 0GlHfWr0cdMNvTqHrDJUhiDk+FRxFd4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Auel8h7WPYet58l2Da4glg-1; Tue, 08 Apr 2025 01:26:09 -0400
X-MC-Unique: Auel8h7WPYet58l2Da4glg-1
X-Mimecast-MFC-AGG-ID: Auel8h7WPYet58l2Da4glg_1744089968
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39c30f26e31so3590814f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 22:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744089968; x=1744694768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVdRnIze/EWTJ57HwuEcu59PSYXpeukf1t+BMjsWVHY=;
 b=YTQMS8hizKJZi9tkyQi2HXE7emYegnPunQFFE+SpWq5AnYEQ218MOw+3Whnj9ZBtIr
 VTM+qagxOZqbeSOuFvxEdPkGSKCybD1SPYLEN9PwOYhO9YUCmB5x/2QjQoDaP26kbCcv
 psUeRsYVseu4oDKUvqiVTGVxIi25Hjuvjxt9jwQjQ5tuFNZE5SNSKHqs+tQgnlDCv0dw
 dtv4ckyrNn13w/nEQ7Glm1cq8lmnZKxGiIRwiQxTlgbOmNm3gkqHoVJUcu7AoUkNBmRZ
 JKLUai1AXasZagWT9D22OQTX7SOuAVXEneYdOBLk1uTsnOSPqysYRatmQc2a6THy9xym
 a61w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5sLLNHl0N4SIYfTsit5n/mRJm9oo7+o/cxougdUtXeT+14xO+PjaUc7K7NBEkQDh/2jWz4sXWAqIQ@nongnu.org
X-Gm-Message-State: AOJu0YzVfwIYPxt8v9L2DkAYviClljB582zMPR36kJVGFJETFouTBdUO
 xi3PMuDaUaPBRk5UVBq/o8PB71vYq9BM4gpnrS7uupqpw426l5t85hon+EIJq/OLoWBba3UkMk0
 n0cEPVT2hFvlY/bLGPq5Ca5/yq+vEHPnSYU5oiTdfeNO+u7mTIJ9xzitRm1Ofi2OgcOtGTXM9kl
 Hq7ogxQMtUL7Pe2cjD9vbL6VwciQs=
X-Gm-Gg: ASbGnctysl1gjc06TpHRNL3w2wXZGVdA1u8a7VCM+3TSC0gppjy/cUL1Ffovf/ZlgzB
 YWgEXCPsvVLelB2BMB6cAd1DIJjp299k7gSr6VwTC4IJ/Fj+RLJc6fwrqafnZkz7dYMXaXlY4uj
 g=
X-Received: by 2002:a05:6000:381:b0:39c:1257:cc27 with SMTP id
 ffacd0b85a97d-39cbbcb3b96mr12644858f8f.58.1744089967906; 
 Mon, 07 Apr 2025 22:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYN1UmeyfV7MJrAzDEcNZz9xZNVNvFNBjYVT7A74lpp9RCv1WQPrv8qyUY9SwRaES2qMpaJguSi7eZvmC13tU=
X-Received: by 2002:a05:6000:381:b0:39c:1257:cc27 with SMTP id
 ffacd0b85a97d-39cbbcb3b96mr12644840f8f.58.1744089967484; Mon, 07 Apr 2025
 22:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <CAE8KmOzbtMwwTF662e_xo77EQ-nK-QOcqYDfmirkX-m8faAcxQ@mail.gmail.com>
 <5ed-67efa080-44f-38bc9540@144005994>
 <CAE8KmOzz2cyHimBXcs79wOOzg2KyKwmSNSXbkJomhGdhwWfKBg@mail.gmail.com>
 <5ef-67efcb00-537-1a6bb1a0@222476586>
 <CAE8KmOyBjkFhc-pa-m897S2h+G=vRgkDf69595K9NvogT_oKRw@mail.gmail.com>
 <4c8ae-67f39480-20b-1b3425c0@158944275>
In-Reply-To: <4c8ae-67f39480-20b-1b3425c0@158944275>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 8 Apr 2025 10:55:50 +0530
X-Gm-Features: ATxdqUFccMIchITZ-isqb7DziiJB_nZh_8tAXQ5zCp6WoBtdUKNYJ0H-hSVe3Xw
Message-ID: <CAE8KmOyL_HJ6p2AZPedYbiDpeNH2LKj+wodF-nX3OgcH8Aq4jA@mail.gmail.com>
Subject: Re: [PATCH] migration: add FEATURE_SEEKABLE to QIOChannelBlock
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 7 Apr 2025 at 14:31, Marco Cavenati <Marco.Cavenati@eurecom.fr> wrote:
> As you said the capability is used internally. Its goal is to signal to
> other QEMU code that the QIOChannel is seekable.
> 'qio_channel_pwritev' and 'qio_channel_preadv' can be used only if
> the QIOChannel has the 'QIO_CHANNEL_FEATURE_SEEKABLE'
> capability.
>
> The mapped-ram migration checks if the channel has this capability
> because it uses the aforementioned functions. Without the capability
> and the functions implemented in this patch, the mapped-ram migration
> won't work with QIOChannelBlock.
>
> You can have a look at the patch where those functions were
> introduced here [0].

*  _channel_preadv/_writev functions are generic. They are independent
of whether the underlying channel is file or socket or memory or
something else. They are called if and when they are defined and they
in turn call channel specific preadv/pwritev functions.

        if (!klass->io_pwritev) {
            error_setg(errp, "Channel does not support pwritev");
            return -1;
        }

* io: add and implement QIO_CHANNEL_FEATURE_SEEKABLE for channel file
    -> https://gitlab.com/qemu-project/qemu/-/commit/401e311ff72e0a62c834bfe466de68a82cfd90cb

   This commit sets the *_FEATURE_SEEKABLE flag for the file channel
when the lseek(2) call succeeds.

* ie. 'file' OR 'fd' channel is seekable when lseek(2) call works.
Similarly Block channel would be seekable when ->io_seek() method is
defined and it works. And ->io_seek() method is also called if and
when it is defined

    qio_channel_io_seek
        if (!klass->io_seek) {
            error_setg(errp, "Channel does not support random
access");
            return -1;
        }

  Setting  '*_FEATURE_SEEKABLE' for the block channel does not ensure
that ->io_seek() is defined and works. It seems redundant that way.

Maybe I'm missing something here, not sure. Thank you.
---
  - Prasad


