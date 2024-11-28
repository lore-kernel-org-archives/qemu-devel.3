Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66A2D690FA
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0k-0003W7-JS; Thu, 28 Nov 2024 05:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGbzj-00027R-AI
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGbzb-0000Yj-QC
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732790604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bRYt+uVfaNdXrwS3S5rhlBrBT7cMIc4F+Ipel92Hz8=;
 b=aklIeKTpXQJbcNBuMWv5DG3VoBY8O3Yny2WCcBBn8Z7AMed1GqyTog0hyLVj7o6BQ5dbvs
 FU7dvp96aacVQgnxg1uln7lC3dLq7H//0Y7GXxchU4omDfEmUao+B8IuDFPi2YbWTwJ8ND
 4Vdg8gwsAsMv55lBzJnuMLlqLcn/AZE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-wvWIiiF3P-2FaLw7wBwKqQ-1; Thu, 28 Nov 2024 05:43:23 -0500
X-MC-Unique: wvWIiiF3P-2FaLw7wBwKqQ-1
X-Mimecast-MFC-AGG-ID: wvWIiiF3P-2FaLw7wBwKqQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4349cbf726cso5347145e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790600; x=1733395400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3bRYt+uVfaNdXrwS3S5rhlBrBT7cMIc4F+Ipel92Hz8=;
 b=UL3enGCAM3j5ST9OGhxhGDXvK5mGgVwccBLzgBfmJzsxAqIbeeCQQPbkCweBIl2n7m
 uZeZRI4G2dbYP6SbAedh9XJpzjuVyTYZjHxn6lS5QnFSirvIeBeUmSgqKQKNg86iCCh/
 0RsOzpXi4kd7sXmzZair68IjgaDo/J1l7SL4HjvnyY91Hwhj0MevYpYl3jTppH7Q+TFT
 ODZLbK7nsIfHOVXEqjWszKLW97xKXljI2tcUgNj9t5i/QSm1EWIXXZOT0tVW4ycBjtJV
 IhPg6Zh5t/w9xb8SYoBQ7a09gEYe1YiGPAjQvP9hdgKm348P3QIpqGXkgN3AvUIVblwQ
 ncvw==
X-Gm-Message-State: AOJu0Yz8VBF9QCYwQ1H9FSZLeWbt9fb+oTAudbLzS95eEkxHcVz3SJ5K
 k08Zdk/emW7c9leRKUfo+Qvr1+ojtMllqdeeZX2E2N8Yzpg81r6Trz68MOHzFVzEGLBRSILdE10
 1BDE6Oyd+EkopetsAmfw+1mjDvuAJuqleVQiwOZ3z1E22wnA/PHl1PaO6was77DkyUSQ07P7Li5
 R/ojnWy/mu8q3EK5zZytcNNXQ7uij+Ma4NAOQ=
X-Gm-Gg: ASbGncu1oJqVOv2HcDY5f5Se0/Wv9arhK+m35KsRI/2i6sNbZCwHPxau9cxyMxEp+B3
 HmaELNagdIscihHQJQxFkNxr++DgASMq+wg==
X-Received: by 2002:a05:600c:3b02:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-434a9dc4ff8mr60071025e9.9.1732790600702; 
 Thu, 28 Nov 2024 02:43:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpa0UIKGOvfW5ExOxnwG8M5tvlX4SGXIlduoeaiKFhsJTBylAED1ZxMILOpj/gEo7Htbb3k68Ifud5bcHUf7Q=
X-Received: by 2002:a05:600c:3b02:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-434a9dc4ff8mr60070905e9.9.1732790600385; Thu, 28 Nov 2024
 02:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com>
 <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
 <878qt4na1n.fsf@suse.de>
In-Reply-To: <878qt4na1n.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 28 Nov 2024 16:13:03 +0530
Message-ID: <CAE8KmOy2v_LS_1DvVU17Ah3xGqajBpGgrOx968CM+GXXC0PS_A@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

On Wed, 27 Nov 2024 at 17:49, Fabiano Rosas <farosas@suse.de> wrote:
> > On Wed, 27 Nov 2024 at 02:49, Fabiano Rosas <farosas@suse.de> wrote:
> >> This patch should be just the actual refactoring on top of master, with
> >> no mention to postcopy at all.
...
> It doesn't need to be a single patch submission, it could be a patch at
> the start of this series. It's just that it needs to logically do only
> one thing, which is to move the code around without adding new bits that
> don't exist in current master (a strict definition of refactoring). The
> multifd+postcopy changes come in a subsequent patch so it's clear that
> one patch was just shuffling code around while the rest is part of the
> feature enablement.

* Okay, will do.

Thank you.
---
  - Prasad


