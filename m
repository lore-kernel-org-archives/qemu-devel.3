Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB917E6C609
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 05:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tILeM-0000vT-MG; Tue, 03 Dec 2024 00:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tILeA-0000qP-6Q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 00:40:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tILe8-0001F6-KY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 00:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733204427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FNqoGgCARsKysr/5lm5xSMJoqfRZ+Pb9heP9IAcjfSA=;
 b=GVw9gQgZZOgUqAp4EpCfXptMvUfjSsBfeFfDvMHy6xb0CqCUhdPobjqwm34WD6LdZoJigr
 kAfrjrrhrdj+ckHM0bfx1qcs4LZXpso59u9bskmAYCLR0UV7ISBdaypdlG2Ho08AViNixz
 ACQtLtAaPLiA2X4dBAMStLaRTauwv6E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-G1gpjrXcNNe86gYynYTrXQ-1; Tue, 03 Dec 2024 00:40:22 -0500
X-MC-Unique: G1gpjrXcNNe86gYynYTrXQ-1
X-Mimecast-MFC-AGG-ID: G1gpjrXcNNe86gYynYTrXQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a0bf9914so37216995e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 21:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733204421; x=1733809221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FNqoGgCARsKysr/5lm5xSMJoqfRZ+Pb9heP9IAcjfSA=;
 b=oVFM377+LHJnLADHApBCR0Sap4WGMt/YTdBS2kb2rY58x0P0bUnMocdBc2xBm1lVkY
 4ky0SoDaixPyX9XvL3lecC/40qAQESeG9CFkZRr8gh+K4q0jJ0iyFaQqBdPa6OvQnHfG
 5QdXer8IHpYnTlf7sOVCJu/+9oHj6mZGmR3Yu8aEwS3OYXf/GSXNes3ptZX6pMD/s/+v
 LNEhvToqkGNk+m5V56PTghu+h4PdzmzSTVWE/i0mUP3fMaY03QsAkZfMGtqikcvgiM0P
 Wn8O/GYdalpD96VRhwjblPVATziGDxHMSJH44y8uSJ9x/ActKVzrRwNVV7HeGfygpLcs
 N9qw==
X-Gm-Message-State: AOJu0YxX9jERgPblr6vFsI09wic8kow2iaDx+cKdWiUc1jop2aHqLFgJ
 91Z1+QuBBrR4GwxDmOVRTZIXkuW9E85PM/X808WB1Um01hI8EkjXgyfBdmRpjWs6UZHyJmUhi8z
 61A7PakDzVauOvDf0mUqakkTDNWFFfAjo0MZ6shd63uap/afzXNimFoeqfsgYQLaX0FVT2T4EIO
 cWxnSZipC7sevcwGlhHtCRYc5s0H8=
X-Gm-Gg: ASbGnctLX13g2KsvRvIcQfJbwuFWlcoTmUkBZ8y6/Y2YDyBqYI0if5Pnphjl+8xleo3
 p/DdEyCj/5kwoXrpqzXLr7+YDwFWjjmQERA==
X-Received: by 2002:a05:600c:3ba5:b0:434:a83c:6a39 with SMTP id
 5b1f17b1804b1-434d09b147fmr10118315e9.3.1733204421226; 
 Mon, 02 Dec 2024 21:40:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfRYeY47m+uLSAibu0hj+zrqhusc4sIebgdyfZ1mODPTDJ3U6s4BMQ3yaKBwDGG6Ev02NmjmwNNaIOmxAt5Bs=
X-Received: by 2002:a05:600c:3ba5:b0:434:a83c:6a39 with SMTP id
 5b1f17b1804b1-434d09b147fmr10118205e9.3.1733204420974; Mon, 02 Dec 2024
 21:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com>
 <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
 <875xo8n4ue.fsf@suse.de>
 <CAE8KmOzfaxzxTCMoF6miOG5fYFaikmz7sm9UeuAe6u1Optz8fg@mail.gmail.com>
 <87y113jy18.fsf@suse.de>
 <CAE8KmOygGSr=DuWdeVppgxq9UN2XG0fmMEV+nO=Q=QXQb4m8oA@mail.gmail.com>
 <87a5dejhre.fsf@suse.de>
In-Reply-To: <87a5dejhre.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 3 Dec 2024 11:10:04 +0530
Message-ID: <CAE8KmOzvCvZfh=6pxFSvfyk4pbCn3JQpivLkybWo+NTs5czfiw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Fabiano,

On Mon, 2 Dec 2024 at 19:42, Fabiano Rosas <farosas@suse.de> wrote:
> >   ...multifd_send/_recv_sync_main();    <= do the 'flush' and
> > 'sync' mean the same thing here?
>
> No, that patch is indeed inconsistent in the terminology, good point.
> Well, flush and sync are not reserved terms, we can use them however we
> see fit. As long as it's consistent, of course.
>

* It'll help to define what 'flush' does and what 'sync' does in the
Multifd context and how they differ from each other. Maybe here or
code comments or both places or somewhere. Knowing their intended
meaning will help while reading code, reviewing patches and also avoid
confusion.

Thank you.
---
  - Prasad


