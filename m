Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B62E9B365
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1Sd-0000vZ-JL; Mon, 02 Mar 2026 06:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vx1Sb-0000uy-Mx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vx1SZ-0002lf-Cc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772450949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ef+w0QuWcEy6SB4bZPDAMQnkNdWx3fazme4/mQN/hYA=;
 b=cBKvSFLjQuY+0fuQzk3TWyGHcDA4nFs+iED3oNYNWS3ksw+6uLDwqah24u+7cWlvqAdWSH
 I5Nmbbyda/dZRwDWgeGlooPooS50D7rVuNV0PaX4eAG1MerP4wjb2UCpM82jSqh6KG3osP
 SWmxjsD+sb5wdvyLRapazjLwN2VewOY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-hdiS-pomMI-_T2gcZ1Ifuw-1; Mon, 02 Mar 2026 06:29:08 -0500
X-MC-Unique: hdiS-pomMI-_T2gcZ1Ifuw-1
X-Mimecast-MFC-AGG-ID: hdiS-pomMI-_T2gcZ1Ifuw_1772450947
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so43714015e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 03:29:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772450947; cv=none;
 d=google.com; s=arc-20240605;
 b=POPrSd/fSN1ybZWEiwPImD4mEiKtqJJCEhUaevsHl0Rub6Wd6wSlyqDc9zSOjfEeoH
 3k/SQkV3vicSmT+1RrJ3Y9aWseafVXjFqPRsqFjPDP/OSJBrPk7mSeJYUT/0D5M3R+ts
 A9O1E0nd+eJk43tyk7vnptBKdo+53NvcPf610P8wNXcFTBxk0jrowFnSpfTrpm38cRht
 SU/RWsxSqs+/+K1TQ6rcetfrqfycpbKjbn5TIjwrzQ22/JdgXn41fhXy8dglVEmYj4kK
 EnnC/Aa9mEP2cZ269rRFPD/VlYUij322shfyh1g6lkKh3BOElrkag2AirzEPqSQs55gx
 Xa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ef+w0QuWcEy6SB4bZPDAMQnkNdWx3fazme4/mQN/hYA=;
 fh=uAFGmZptPmX0dD/bXyHyHkfLYptx/M8rPXvxv1Kk7Ms=;
 b=GkLOLAzFa/9fsrP6Xt283HYEM0PKks/ioe6HpJSt5ZcwIPSCp7MldyF+3fTas/4E/0
 RZIeo8Utr3gDh3Xc9Mdz9xvFG2i+RT0EFZmdB1h9lHTZyQqD1WezpP7//1xUoYb9S8vN
 uDBusDlKjOdoPxWuhPZKfZOGKW7wzaPOhoCGDDZb1hrkesYCbGALvVCFVfqSSmdWrTDJ
 e+GLKWKL4b3zaHVs4D7dNOtmHEJjwwbNPl4QkO6DU7AWkNhrdbQka25BAk+umxIhNAWr
 vQGpdqT5a2IcxJ6Mj2KvKmAvHX1U3Q/nxgqH+kU/U94BwUdSJapIM6E4Pb4egwD98uiG
 p9eA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772450947; x=1773055747; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ef+w0QuWcEy6SB4bZPDAMQnkNdWx3fazme4/mQN/hYA=;
 b=BkNS2nTkpEXOQGYZ7F+LAPvwqhjDQIv7pXX09RifcrYvM3ZXq82S+yZuOlDcDn5XNe
 LHdgkD1gFMqcHXSD16XZ4MHigpbZuMS/dK2aQrwgUqQM/U10NodAjb7y6ApUAGNeeKnl
 K+N/pTXyJP5O3iL+S4gSTy/dRcXVUKILRfKwh5PZ4BoPWZM3JG+edgij6hXLzCQBxjfw
 5wS3j0tbAP0F++F8CgLgCBuEQoRiLhIOL53tFyJCgQGMAkgtdVKTc1rYle04w86ii9e3
 oFzM/SUQBlHVcOdC/I4jz9U419xVSGKwzW9tfpW1xBYCOkIV6zAnGEVtCONHJ4U6iJTb
 bQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772450947; x=1773055747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ef+w0QuWcEy6SB4bZPDAMQnkNdWx3fazme4/mQN/hYA=;
 b=VKnvtX3PdbJhsQNFCD4GXPgacy60ujPOuA2ZdEmt7Ykvwa127BBMydcv+Qr8xEH7Oe
 8IvX8Ud/l6dtCFJq0HD65tsRUeoFEWQqI8IMc5HmnDlJQ806Qqndc7GL4sYnmXjcA7tc
 73AGtD8hhn6uuCSkMI+TjYkw3xN6B34KLEFRFh61ezgs86CiCCCGzjkZFd8m72aGeJHO
 wg3eE5ZnvzGQvNyeUWlP3OUw8nnBPoD1xiWHhDUX4RURiz58QeA/EfE2LzKC/uzFOXxx
 Ben/Bh2TzUBqNEvi1RmrG18LOI44J/wHqfo2GI8dxP1pHvPRBsihAUOuJYOYZ4fHbCBr
 hgxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdVxCXyVv1uKdW1qDLBLwwDxesozuT/MZZmg172/tNf8Jb9fB8Kmt2JitM+Q4SKqpA/TDeibqVfiyv@nongnu.org
X-Gm-Message-State: AOJu0Yyx2vDu5+Lli6sVJSagaS36C5kNTjepP4hSnuVnc9+17t05ia43
 HXKm0S3YBP0PLwNTbzEa8uMB2LNf1fifzpZyikqdZCPxQYf1IA+DkUgdkOrbtcd4Z7A1TwAQra6
 88jU1DyoerxP5Bcg7XLfrcdmcYONFHDYN2oj4KLF5co/OZdjXC/wQ+zsXVVGI7UjZo7lxXmyuXF
 FGKUv/+dBdK0eDTpBltejTg7UvGpJvwC0=
X-Gm-Gg: ATEYQzyTuPZtcUomhyc/kSNs8ceMo33oWTqAgL0SaZlEfMoAS7vSQ2sOa5M0uPqCz+Q
 sq0ntg/3IduFmwzp2HH3AJcb5ptH18ZkkQ5Gk/dABihxob7sFOY839Z1/tODjoXKByeP1+FV/K0
 wuB/rStZ1ew5FxXo5kii6gUYPh0wft6D+NWNmn9peMDgrTXn3cXIERTauKnYLJE5Yjvcmrwi6Xh
 nBpUZsfCdkq51Cm0XHaxE7QOpub634b8vk0R1E0vaR1IVkRAsps7fs8FEkdHc9xa3OQ
X-Received: by 2002:a05:600c:6994:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-483c9c0b88amr202692695e9.22.1772450947263; 
 Mon, 02 Mar 2026 03:29:07 -0800 (PST)
X-Received: by 2002:a05:600c:6994:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-483c9c0b88amr202692305e9.22.1772450946775; Mon, 02 Mar 2026
 03:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
 <aZ8xlrL2xQtoN9MI@x1.local> <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
 <aaBFxY6PUsNrAYft@x1.local> <83E69A6D-EDC8-4380-8C4E-6F77D1E2F078@redhat.com>
In-Reply-To: <83E69A6D-EDC8-4380-8C4E-6F77D1E2F078@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 2 Mar 2026 16:58:50 +0530
X-Gm-Features: AaiRm51Z2wbW4oia-dQkCcF8M-BauJ95nAIC5bCfCiUdbMKZW52KQUCCsV9gtUY
Message-ID: <CAE8KmOzmk195FKCK-J6qVnj=wcDp5HC6+xhbNhturYo-Ls0egw@mail.gmail.com>
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
To: Ani Sinha <anisinha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <ani@anisinha.ca>, 
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello all,

On Thu, 26 Feb 2026 at 21:46, Ani Sinha <anisinha@redhat.com> wrote:
> >>> On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
> >>>> Currently the code that adds a migration blocker does not check if the same
> >>>> blocker already exists. Return an EEXIST error code if there is an attempt to
> >>>> add the same migration blocker again. This way the same migration blocker will
> >>>> not get added twice.
> >>>
> >>> Could you help explain why it will inject two identical errors in the first
> >>> place, and why the caller cannot make sure it won't be injected twice?
> >>
> >> Likely due to a bug in the code. For example if the init function that
> >> adds the blocker is called again and the caller does not handle the
> >> second init call properly.  This came up as a part of the coco reset work
> >> where migration blockers are added in init methods. They need not be
> >> added again when init methods are again called during the reset
> >> process. The caller can handle it of course but adding a check further
> >> down the call stack makes things more robust.
> >
> > IMHO if we want to make it more robust, we shouldn't return an error
> > because the caller may not always check for errors.
> >
> > Would assertion suites more here?  Because migration blockers are not
> > something the user can manipulate, so it's a solid bug to fix when
> > triggered.
>
> If Prasad agrees, I will send something.

* The majority of the places I see constructs like:
===
        if (migrate_add_blocker(&g->migration_blocker, errp) < 0) {
OR
        ret = migrate_add_blocker(&hv_no_nonarch_cs_mig_blocker, &local_err);
        if (ret < 0) {
            error_report_err(local_err);
===

* So setting **errp and returning a negative value is consistent with
that. Aborting (assert(3)) for trying to add a duplicate blocker
object seems like a harsh punishment, considering that'll happen at
run time and the user won't be able to do much then.

Thank you.
---
  - Prasad


