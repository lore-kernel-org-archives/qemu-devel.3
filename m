Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDAD2D0E3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfd4Z-0007Fb-QO; Tue, 13 Jan 2026 07:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vfd4D-00078J-HG
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vfd4B-0007Ap-6O
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768305605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQu7qskk39rh8RLT+iwEMz7/L2wtsyjUnWY0S/woLdE=;
 b=RaEvD+Lch1IlBNs1fRj+J3q+mfKLoVYG7IaZNUMybkWp+HR2VoceHk5MML7NHxxL6Ix8CO
 SgPwFzpnlVD9KtXvtSvNTzwLPdUAMHupcvLKZ5Ehd2LNPrbY45DNAlO1L7mwRjANT5ziuE
 mvvfrlrJHIiBJW/btHjai2YCE+kKqeg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-QEmr27MkMe2C4X2_v5msKA-1; Tue, 13 Jan 2026 07:00:04 -0500
X-MC-Unique: QEmr27MkMe2C4X2_v5msKA-1
X-Mimecast-MFC-AGG-ID: QEmr27MkMe2C4X2_v5msKA_1768305603
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so49851025e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768305603; x=1768910403; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GQu7qskk39rh8RLT+iwEMz7/L2wtsyjUnWY0S/woLdE=;
 b=tMMW2vK7t+jboQ4WXVt246c9xOLMxkv240afC7ioZAQFAx9EWAH2vQ6xZB0wqi31BS
 vmzoMPS/eA0GoMBXqRcxmAkHLdNK7AS7Krf0ShPFtRgDmAR5+Mc5M75G1CYQrtKI/xdi
 9XqYuG7Op8+AXg5ziuZMkt7XTnSuZkpJRbkTAN6qmU1mncFBjyl0yPkjTtoPv9IOgc0B
 l/bhH8FIC9jPZrQwt4eeFHbq9cA3cl6UO0qTa3fe2zuhAt9VA1tNPROm1jRE7Yzawc7L
 3zgGKt605LUlDJu2OW6u+6Vd+kQTy0xWq6JMJ8T4b5faun799ZkTg0DzdAi+Ue0/QB0h
 hm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768305603; x=1768910403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQu7qskk39rh8RLT+iwEMz7/L2wtsyjUnWY0S/woLdE=;
 b=sEtPEoPBImXG2qlfP069O/dZ1ozpogFCbeREaceYWzlTZXZBttp9yJhMKUuVRGXUlP
 tslYChgUOH9p9xELVfOZitpoL6ouxMx+vIvSbqQsKFBSBuuZKEmoJeeED09ImCxvIP6N
 ut27thI5VfV0+fFTiZVSPqDinAWb6kSQr2ec11UR1Ca8X42TsyNoYvdE3HTiYtZS9pPi
 iYQjsA6JPxbgz+a9+hbD4Onfq55R5HHZNlWWJKZMyGRC/DWzSfFO2Aav0N8RENnKPOTF
 /0dMKn2D1jGP/ZDjEQTct4bwZqJVUUs8/BPqz4C9psnBGUrmLJNrMSx9SnG5ikSJUEcl
 dbYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURACwTxYt3jiinvtCrlZwFoEFvUf60r46zQV3QsjcKIeEZ33BYFCZh454wghLok7T83US3941oV+8S@nongnu.org
X-Gm-Message-State: AOJu0Ywt6CdZ8cmX7wge0bhX1lIarSZURaxHuiFgqSnM5TUGaLH104Bi
 5EWedai3NDDkKICOacnID4B9F4qrNfnfBcTCRmDon7+gxaK/Ejntl+Auxu47zt+PbfLK5IIPL6L
 HmXPxpGWEFzQh5MKwi+3cWQT9kPj8+TgIGbhQsqDpFbbv8r2acYXaYXs80GeG3Q8x3cl3d2hS5w
 PCDCFSu7pelMsc2HCcMRwrINP2ZX13xe4=
X-Gm-Gg: AY/fxX6Ev50/ILrFLanrhtcTE4fBqPwQ/FkY+R5LrnvgkXhaxz20WRDRzNqUAQF5gQj
 C0+XQJVPt2mlT/yWzATr7INDe7ZErqfjRoTOzU5CXkDO/Rt2rdAnJMuAUY1gAOmlHFp5qqeTLwa
 eWZru5luFJ66ZAWF5N0FRY1oq7S8wEgei+dF07ELdmxlMeg/4tbs2oRkU+35bu+oZn3LQOBTQZm
 qNUzXWnXBGN94YtAdeAKQ/NomqHoSDPiWg2XwC7M6DGGEgrX1VXSxGo
X-Received: by 2002:a05:600c:8484:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-47d84b1a095mr222803375e9.14.1768305602715; 
 Tue, 13 Jan 2026 04:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeZLpT93tLvr734wc7TV9IYZKAAC0m3MkFwnNkOr3WxmTVilVTism3z6s/DGjyv/01m5+dd9V7qyQ42VTyoKg=
X-Received: by 2002:a05:600c:8484:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-47d84b1a095mr222803135e9.14.1768305602270; Tue, 13 Jan 2026
 04:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
 <87zf6q26q5.fsf@suse.de>
 <CAE8KmOzxDn7X7rohJGT5AeW3+5oJFgueVtaQCpUc2bmBvrgRXg@mail.gmail.com>
 <874ioxzhcm.fsf@suse.de>
 <CAE8KmOx0ikDueu-znY14RCmp6weX_G+CJMUrQOmOuv-OPwPR+Q@mail.gmail.com>
 <87y0m2zkc3.fsf@suse.de>
In-Reply-To: <87y0m2zkc3.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 13 Jan 2026 17:29:44 +0530
X-Gm-Features: AZwV_Qgt4RKhSEqvfkVTWXHgMy_gTx4WXB_G8DlfvPMvqaeJ2bFhQ3sWmavEOBE
Message-ID: <CAE8KmOw+g3gZYJfay=9gwkhtkviA_K9BapfmJBhD+BzTCcxLxg@mail.gmail.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 13 Jan 2026 at 01:15, Fabiano Rosas <farosas@suse.de> wrote:
> There are failures that happen _because_ we cancelled. As I've mentioned
> somewhere else before, the cancellation is not "informed" to all threads
> running migration code, there are some code paths that will simply fail
> as a result of migration_cancel(). We need to allow cancelling to work
> in a possibly stuck thread (such as a blocked recv in the return path),
> but this means we end up calling qemu_file_shutdown indiscriminately.
> In these cases, parts of the code would set FAILED, but that failure is
> a result of cancelling. We've determined that migrate-cancel should
> always lead to CANCELLED and a new migration should always be possible.

* I see.

> This is ok, call it an error and done.
>
> > OTOH, if we cancel while processing an error/failure, end user
> > may not see that error because we report - migration was cancelled.
> >
>
> This is interesting, I _think_ it wouldn't be possible to cancel while
> handling an error due to BQL locked, the migrate-cancel wouldn't be
> issued while migration_cleanup is ongoing. However, I don't think we ever
> tested this scenario in particular. Maybe you could try to catch
> something by modifying the /migration/cancel tests, if you're willing.

* I have made a note of looking at it at a later time.

> Aside from the QAPI states, there are some internal states we already
> track with separate flags, e.g.:
>
> rp_thread_created, start_postcopy, migration_thread_running,
> switchover_acked, postcopy_package_loaded, fault_thread_quit,
> preempt_thread_status, load_threads_abort.
>
> A bit array could maybe cover all of these and more.
>
> ---
>
> You could send a PoC patch with your idea fixing this FAILING bug? We'd
> need a trigger for migrate, set_caps, etc and the failed event.
>
> If that new patch doesn't get consensus then we merge this one and work
> on a new design as time permits.

* Considering the above wider coverage area, I think it is best to
first fix the issue at hand and then move to this new change. For now
I'll try to rebase my current patch on your v3: cleanup early
connection code series. Once that is through, I'll take the states
change patch. Hope that's okay.

Thank you.
---
  - Prasad


