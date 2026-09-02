Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097D5C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hiO-0001Tb-Dl; Wed, 02 Sep 2026 05:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1hiN-0001TT-Mk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x1hiM-0001ck-8w
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788343025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGNA7wu26rZKJishMAp63YtmxCqyPv8cuxhYHH2mSa8=;
 b=IhKfBRzg8G0Y4Y78ks/PipHXjoFs/+8E+We+tcI+E4vHbTyYplpF8iPoGr1g7ABksjJmlh
 ZIvzO4CQ4qOVYTYxmySQOO6b/oKxJija9k2jOKOaim/oC+dmLbxLqztezzS/KpV48/SnxQ
 D4d+WcFlLNBpAjS0slkCuzyAUjuUzMQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-RcxcYyb0N46Am4UaOpJ48A-1; Wed, 02 Sept 2026 05:57:01 -0400
X-MC-Unique: RcxcYyb0N46Am4UaOpJ48A-1
X-Mimecast-MFC-AGG-ID: RcxcYyb0N46Am4UaOpJ48A_1788343021
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48436a5fb42so572554f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 02:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788343020; cv=none;
 d=google.com; s=arc-20260327;
 b=KIPziKxTDhahoeYLF+SUc9Wu+SuIB+x5uCAHRtnGRnvOuX8zOK+29A8S05MTfdL+nA
 EYPHJYQmLm/px9n5vgxQvY3WCyMVuiNctBp1j+bFP1I+iwh8vHACvOlNrbgIboE0GQZh
 6++v8Qnoi4SC5jvOaSaDZk7Vq+/FY3d9cY038kw9nbrEqrxFFPHOx7bsDcGdmIPA/3rN
 5cfjQTwbOD/0aOnz7O3lQgI49KseIgdiYGFHTYLz9OEnYwreDM32cP0D78c/iABYpTuf
 6m2UKzhNSm6fWqj8oE09UTjxehXBYNsJg+WdwtXrsczUHdbl5lUTDOZRK/oLaIDubRW2
 5JsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OGNA7wu26rZKJishMAp63YtmxCqyPv8cuxhYHH2mSa8=;
 fh=WzKqTpRLcY5t18JP1fjIw0JF3e3rWsAPDy5LZkl7KeE=;
 b=LvlfZehnZ9PiDrmz9O3aD2UanhRLdksDY5cjpjwCFQ8QTPY4ulRR5lqLFv7PyZNi1U
 9gFVarVAUd1dszRwdPGl+YZUmofK+5+dehas59a6yIYYTWqemUXcNC0JUWtpK4aZM7QI
 qmY2qEfWiLtWLzMA3i9ssXzJJbxGZadI8AyLql7SS/RDlgSUYHqn9jSD7BAYj2DtDduP
 cA/PylYU1xjGAM8qMFMybIvcQkKvCe52rFyznpuv7FkSsEXDfq6QffhYz8bQZsRxjyBA
 brBEWEIJatIZZ014J4QtCCEpyRbv+/3HUpOaoTYBpWvmRh2wgr5Z5odjbUZ8ZTbWykkz
 7wWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788343020; x=1788947820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OGNA7wu26rZKJishMAp63YtmxCqyPv8cuxhYHH2mSa8=;
 b=oUcPu5TpHsoQpeV/C+aBcYjtJk0PGRPWrrBpRL58v/QOMoOUACM4s+f9CzZXsTGqN1
 RqfwPyMaQIsODEsiUeSBKfrrEGi6uhAa9rGPAkXeaNwgeZkWYMirDh3n+dIY0gt8dUq5
 IX6FAMqzOM+ooU4DAWPHMnDY9y4MDC/ZvwVQwqLImxTKx+3pg1HMogLvs3ZZBcYUJCpG
 xMN0TVYlF+gDbgie84aUm/ICPUUYb15GQY9aSDtgHs2X+o7yQF3vhajb7bsbPq+XhuNL
 9g6iJ8HNk7eWmonVKpQNTpVembfxiCjG4xyxTYKA3hBXeMfm4eded5JZg5OVJOyKecYv
 nOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788343020; x=1788947820;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OGNA7wu26rZKJishMAp63YtmxCqyPv8cuxhYHH2mSa8=;
 b=At6IBAZC4Ha2gGMnHJnI6iIzpKQskrfIw8NITIItr3gKr9O57fzXAzICbk2B8aPuRn
 /E2Jm9QIsKm5dv9ZYga7+52HhpgCeYjtCAOBeuYouLLsatpI5eZRD1Iv4MrxijgzxKSR
 q8o1+T0QFIgBQGVAC59ghWRRXLbRjLQlSZstWydV5c/50Nt0GxJM5U//m4o0qnjEcJIc
 WxHGPCNKmUZdjGX3suBfuEwAFukoB0USowE4AuOSH96mRztY5icT61ZlcDpwvz1TqXz3
 c/tZZOOO5pojazHC37f6ZhV5EM2uk074P/nx7CHegj8hK0FYtPwrvDSg/uzwFKObTiUp
 Bw7A==
X-Gm-Message-State: AFuF++mWLvxJK5ghjyqQJJMQ7RQ6I74iXCmOkckNTyIJDs/vEG0LOleP
 F682WNruZ0B0059BDInxzXv6KT1MlvYjmyqmwxKNLfow+wj68J9lQvo5CKJvp/rOcDXixaAmchG
 s986athu9G23/H24+sr/GAzI+yZb7l4rxunIVe09qkul2K9RM0C1ifR+7GOG7YS/oAqaesk2avi
 B2TtLeGy/prm29ur1rQpyVOn9AjqEtNog=
X-Gm-Gg: AYBFou3W1hr6DhxemOoowwc8Kekp97Q7IUzs2LpYFP6oxK3lX2tmSxe3FESG9Ymu6lO
 Qc6y+5F8rtKnvAZfEthT1FGiIMNJBB62/xoC2bwanTuROV9NbUeKQiBaGDOI645FfmXytafaJ8T
 9OvS7eyiCuKCrq/VK41XXtZDoaPDShXsm2TutTpinPxcd01CfYxsLIjQc9XtCrQBivBoJTi/O71
 p8VBKmTciDfy1zPJSbdghHGdPnWbprp27zOMXoODiYzcX9kPX2xmhQVlQOO
X-Received: by 2002:a5d:5850:0:b0:484:3d1b:7884 with SMTP id
 ffacd0b85a97d-48488f0f990mr5903592f8f.17.1788343020623; 
 Wed, 02 Sep 2026 02:57:00 -0700 (PDT)
X-Received: by 2002:a5d:5850:0:b0:484:3d1b:7884 with SMTP id
 ffacd0b85a97d-48488f0f990mr5903541f8f.17.1788343020290; Wed, 02 Sep 2026
 02:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-5-pbonzini@redhat.com>
 <20260902054543-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260902054543-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Sep 2026 11:56:46 +0200
X-Gm-Features: AcwNN1VFbCR5S8s8DhB1DTdI35wHDhBxd108W3Im-_0cMRV8o2d6XN-3OMgQawI
Message-ID: <CABgObfacwO0bx+wc2s=5aiaEbQghvt-gZc77D6eDigf88mS1zA@mail.gmail.com>
Subject: Re: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 2, 2026 at 11:46=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 01, 2026 at 06:14:22PM +0200, Paolo Bonzini wrote:
> > diff --git a/GEMINI.md b/GEMINI.md
> > new file mode 100644
> > index 00000000000..43c994c2d36
> > --- /dev/null
> > +++ b/GEMINI.md
> > @@ -0,0 +1 @@
> > +@AGENTS.md
>
> gemini seems to support agents.md - r u at the latest version?

I tested and it doesn't load it for me.

Paolo


