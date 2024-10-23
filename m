Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE77BCFA452
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 17:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3f0m-0005cl-Nv; Wed, 23 Oct 2024 13:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3f0h-0005cL-0J
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3f0f-0005qV-6R
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729703936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1waTrkBJ2lPFI50WxL9zhuaYboCtM2YLewk9NIuYQeI=;
 b=D5fyAER4+ciFX4Rqtx0Uo7aeZHURgO1auHrVJeFHwKmpGtDus4VZraBipNIDXR4/AoOmEP
 D9Gs23CHk2ARhkex59hFJJ3XUXeN1mkGse9nGBMVu2w9jOuMesBztWN3ZLxICuvM7krtIc
 rhFhejQ0TSUKtXh2hn+5TcGS31dNzkA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-J1iHNnQtNRCvX-iDYubNLQ-1; Wed, 23 Oct 2024 13:18:52 -0400
X-MC-Unique: J1iHNnQtNRCvX-iDYubNLQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so3535441f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 10:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729703931; x=1730308731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1waTrkBJ2lPFI50WxL9zhuaYboCtM2YLewk9NIuYQeI=;
 b=i8ky4qaHERdqzWEUc0/BMOY7NbAcuLVajIm/BoJ6z3SStwzmE0uTiaWF1Sb/VYPGGM
 2M4SVYjrAAploW7U8+qXU4KCusIVhyRehtHqrsf7TLY1enWex0BbZy7rD7fZCdcdh4wr
 2lyT0O7TywgqiniGJBHyvhtEjJRLFqznglab7vdZh8wF/P0hJVxux7tvbSlvBqFIhEK+
 fy2wrgUDEiElKNjLl88+GvbaIns15jHNeJjrYUPGevddEX7wjBg6TN2SrNnNbVeXh/fC
 ENrkS4V/KPrQ9XVdvsXcrAl5SbxXNraSck9TCehPDW0o7jEEQmRp2HE5cgjBYf73U2X9
 g2Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdEaJbM5nOO1yFdqKM5PV8FcWjILdiePB/jV6eLXNzIunXniUFJVjCcfuOOrTWWys7SyfBqVaUuFo9@nongnu.org
X-Gm-Message-State: AOJu0YwF8ZDbK78hCe49Lh0pHl7iVgygg3is9dvaSV99D8mNpoTNFwcN
 g91AqOJ2b0dLTi+CZaqGLOTxREVBk5s5EEyLLLYRzbrgh9weckj8hax+9E7CkYtMlwC+tGgaZlL
 fvKxkbA9Xw9XZmlC777AwDlTTrkifNfPUL2B+oStwSRs98I0e8ylFHpIdmSLB8zIu1JZmuiVAKF
 GMyVqLyBuYhUi28+GG5jr5zHUHwVU=
X-Received: by 2002:adf:cc8a:0:b0:37d:43e5:a013 with SMTP id
 ffacd0b85a97d-37efcef0f1amr2174285f8f.8.1729703931049; 
 Wed, 23 Oct 2024 10:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLGaICAHUAixxMCLozi02v5rbaCsXpz6jXhHSTqam8XQuE4kZEQqAaZsCXA7FGWP5uiItjHSXb1tm4tdpGjYI=
X-Received: by 2002:adf:cc8a:0:b0:37d:43e5:a013 with SMTP id
 ffacd0b85a97d-37efcef0f1amr2174266f8f.8.1729703930685; Wed, 23 Oct 2024
 10:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <c4ce511b-bdc2-466f-85e6-2495c0bd2f08@redhat.com>
In-Reply-To: <c4ce511b-bdc2-466f-85e6-2495c0bd2f08@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Oct 2024 19:18:38 +0200
Message-ID: <CABgObfYTS6b-_GH1iRbbTOJMNU-XY-xWbtWWqNQ3V1L-LzZJtg@mail.gmail.com>
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Wed, Oct 23, 2024 at 6:00=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> This makes it impossible to refer to a backend in a machine option from
> the command line.  While this is not done for now, it is not a
> limitation I'd like to introduce.

I stand corrected; it's exactly what's happening with canbus.

Paolo


