Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68A91125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N6D-0004nL-RZ; Wed, 11 Mar 2026 13:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0N6A-0004mx-Li
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0N68-0003I0-3a
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773249109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yo+57izCfFIdJQFkqwgAJQWOEhxx8YDd09UBuMJA/74=;
 b=TnLKRXuFjYyvOco1GXxbAad736w2WL1LTxuBnQaG2lixUix9R6sgLwuNEW1LQwFz/PE03n
 0eSgWJx0KOBy68HJ4JNweqaQjEmjY404cUKlU7eREknUBDh+6NCQp9enWRSfJBEKDiH7D1
 nf9dhfK2933V9hGghpHNIyq0i7lGngU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-i4RaX2loO4Cb1Sw8we3zsg-1; Wed, 11 Mar 2026 13:11:47 -0400
X-MC-Unique: i4RaX2loO4Cb1Sw8we3zsg-1
X-Mimecast-MFC-AGG-ID: i4RaX2loO4Cb1Sw8we3zsg_1773249106
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so583545e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773249106; cv=none;
 d=google.com; s=arc-20240605;
 b=A6K386y098rUDRoHSlwEeVW+YqQ1cCribBuSjfBf9BusJLZ+ZjGSAyDYPI7G2FseYA
 7O9fd6jrHQqaQzwK1uBiWxdOYvmOz1F45BT+V8m7wwMgbjAKguU1eaEVO+nWl0mw2t9M
 tp5XkG+WYUUIddx9UYfVb+OZzrDv1U9MR3Fxnlxr5ZPu1YWPTvEjoii0IQjqcCMmuC3T
 br1jyxx+XUO7usNk6wJNllhQUF1bNZ+FcRkLemuZ9zbJgmy7muLf8coMcgDG04UjMMS3
 Q+QvdfP6eh96lXKgNG1/Jfhgn6sXxviWFhuMMmzEBg6OyTy21CkXOvxpZ+mYfH6Oioyv
 UEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yo+57izCfFIdJQFkqwgAJQWOEhxx8YDd09UBuMJA/74=;
 fh=Tev9uNpKQwEmFpHd7GA6oNqQAGtssuGqEYguVa48Pa4=;
 b=BmxHjVRkP92ecjYRkdyUTZ2rm+BBDZUUp5hUsWU31OLnPoTMjYfQkO2hPmF63NAvA9
 mZCFCFj+bmY1ZbAa/6Z0J4e+spqNwiwEll0dhMSFzL2CV7foMxkFem/CPt/2mIg9kJut
 MxpbPIOrrsYrxDIaIV+lz3EN7MDPyJFVFJOlG2bJFeBtFeceIfBpyQMj2y5qyQ7r9EzP
 srkCe0E6q5wBt6nQ/ZrOdmaQQW593D6R7eCeVzFX9lSAF+ramNhvyQnZmxK8xL+JMs2w
 ACtyAO7cqHXhZY1BoH9RksFpx8jr00g9E5q4/207y8qdAOdhRNZA+vI2dxdmuiljUyur
 18EA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773249106; x=1773853906; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yo+57izCfFIdJQFkqwgAJQWOEhxx8YDd09UBuMJA/74=;
 b=XNRcIu+TpzKdnUVhLnZIcc5bJD8T0FJQmen1kRpLxF5fDSYs9dZY/lPV/wcKzKTrK3
 EU8o4KU6JvRfucKkP1PSuJDVYbdXJGnaHzRrdxry4tVd8AdA6cUbriqjQWaI/nfXAauR
 ss8mFGy/+WqSy/BBT0AqE7ExVTbWmpwS2g2rSXTtc6yHvN8Bwm1Add2R4YfC5NRLlGx4
 LVZwf4To/XztyMs46IUyMpcZYzFa3AyTwtJ9B+4DrBKqvBH3U+ufctaFd3IWVty3ZXlh
 Xx+eD7nL5DKxe5xcFx4cpE9gOkMJ50dhpOy0K5dE2DXEWvbSEw5qQKQTHDTmrfVCfjeW
 R4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773249106; x=1773853906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yo+57izCfFIdJQFkqwgAJQWOEhxx8YDd09UBuMJA/74=;
 b=QklQwqujSjXj8cCIbo28BuFQIM5oIQUtAEZJhLIAewV88RQOu9j97JPHdInZdLBetc
 JS9TiltuDmpoINwRNH44004SXc3Jubzjswb9cKwPMULXvGsE6AlXog96ChtbeliMEJ6h
 GYWDpMK5SgWwjR982JNXfY59nUoFvT7isgQ6WfoIYAu6xRJ14c4Mue1tJwNpp92viEZe
 2FSblqm7qABRO90ewTp7haGLNqvSoIdrfkDYZc5672AyhXVWZYA1nSE9/B3Pt4Aw+eZ5
 w2Av9VPsL8UzEbTaRVu+0beVmb4iviDlxdDsos7iqHhzrs7AfSaggdzhQUaZ4F4ecBde
 ZRbA==
X-Gm-Message-State: AOJu0YzJyebyCrseIeizxmx75BMSAz5YsiQH7I4aiujiWamI0t9VsLrF
 caPAWB95cI6DJ9dtfWtWdPkZMz/euKipPavQLwTKTZMRqcKgmZ3LqKICfzgpHIiGZ5ONCJqeEmC
 jvqKhoSkZ3T/TzJgcBfH7UdzMrQE0YXOlEDRGN4luJA/N2RrcCEhCbRe9hco7MU/H9ltJvNIMvG
 D5vwsNR4xSxGEhpv3iK6eUUbG4ROkKEa0=
X-Gm-Gg: ATEYQzxBIzZ5PupOS6AmQA3Ml8c2qouH7yovh7LKoH2pubJhY+5FhoiVVpyjnYrc0vG
 l0SikBr6PY3/ctTpwo1N2hZfYirgIz8dPo22GrIHRzA+2Cuk/GftDYmYdOLJ1sX7vP4bWbVfPO5
 GGstttVlu9JZAKnX0pASg87N5tzmR0yEXxi7/IQzey7Z+GK7B11YgxnlCqzg5TSc5ZGlJRuLjLi
 p+Yc/cNL8mHr16XZVpW/e6iCKSymcH5I6VkqI9ER1jDuSM9hbI0J0hb61nqsgBTeUoGP0CWcaKB
 szSKuKM=
X-Received: by 2002:a05:600c:3e0b:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-4854b0bb5c0mr59667275e9.13.1773249105678; 
 Wed, 11 Mar 2026 10:11:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0b:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-4854b0bb5c0mr59666935e9.13.1773249105241; Wed, 11 Mar 2026
 10:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260311162045.563301-1-pbonzini@redhat.com>
 <abGdQciQmo2pWFj_@leonardi-redhat>
In-Reply-To: <abGdQciQmo2pWFj_@leonardi-redhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 18:11:33 +0100
X-Gm-Features: AaiRm53mHlzWDXzYex471o_Z1jn7OJ1r3gyk_pAunYB2o213fK5o1023bvXuImQ
Message-ID: <CABgObfazN8bdAweUyG3qqPiu51eZ9+2Rwxgazhn-WSCfA_bq8A@mail.gmail.com>
Subject: Re: [PATCH] typedefs: move QIgvm out of typedefs.h
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

> oops :) Thanks Paolo!
>
> I wonder if we should move IgvmCfg as well?

Yes, why not. target/i386/igvm.c does not include system/igvm-cfg.h so
one has to make some choices unlike for this patch. It's probably
easiest to just merge igvm-cfg.h and igvm.h into a single file.

Paolo

> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>


