Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2318C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqjq-0002J7-DG; Thu, 10 Jul 2025 08:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uZqjm-0002GY-Bp
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uZqjg-0006Gc-Rg
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752151844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPAVdSMVWfhytqhwyWvzzUnPODToZnYv25EJjchVkrk=;
 b=YyDmGFIX7pG5SpqzU+29/vwQkI6JjY3Mw5F70ITloYzrnO0SzCKValpLS6bzraT1BqCm88
 6qhFgu6O434jM6eRFvZwo7m6J2B/wp8Gmwly+aK7YhmfsGWv++JhEzFiZ8KN3n7Z+dT8pC
 9JdOxxBFy+lyl/FN2qS/e3qjvi/plYs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-x-3vPi4iNFaHmV28M8cJcg-1; Thu, 10 Jul 2025 08:50:43 -0400
X-MC-Unique: x-3vPi4iNFaHmV28M8cJcg-1
X-Mimecast-MFC-AGG-ID: x-3vPi4iNFaHmV28M8cJcg_1752151842
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45311704d1fso6284575e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752151842; x=1752756642;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iPAVdSMVWfhytqhwyWvzzUnPODToZnYv25EJjchVkrk=;
 b=Q0lMvx6ZFse912T6kfhVOBNDBH1ysaw5XXgFB0xIbZCnC3plYL+T6IDgPGCeGHYMXk
 65qE5j36v4uXZ0lLrbGK+abhQv8H2X7q8LKoQnQXt4sc3DubNEXccVHJBGVxpGPKv7uU
 rljYzmCSRu7IHNiGJlKNEyK7mjZ5/Qhpv69PRnP4Qa/KUH07f94RNz4+UpEk1CHSNifE
 hW7moY6wE6fuazDxZMls7u/P46p3uDXGEsLlDKkB3P9zwELup2gjZ0i3kkzUjyPiHgW8
 SGQEUisqkjclsluOQErlvxCbBx53taJoD39L0MV7VvlMe8jp8Gdy89ZKtqPGBeMfeIBS
 DScA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKexey6g9HzjrvzVUNlJwutwo33KDxZhCcc3bFFUhX+fhzbe9qdfiZgjWCxrbPSxuveoGFJcOeN8Au@nongnu.org
X-Gm-Message-State: AOJu0YzywOR+j9rcvdpV8MtmKaOVZGNeGg2yKO2zfpGFKc8+zLK4o3kB
 w4WPEOd24Lfejd5i/37E5/CBU+fDRs0ADv2pyOwZ6IltPcv/lWNiGGqoget3EZAUHh5XttjZvgF
 pnUZxZhtQ1G8GPs1q8UiaLfC4ggSLwaM442+MuxhSXoUg6e60ud6P7Ytx
X-Gm-Gg: ASbGncuVABpPqhISdaUpjWEK/XMu2Ca14hgLOpjMSVCwyv/ZboWrb/r/9l1TifWO8p0
 wre+1Zy8MWbPFZJRMWPrOXaNjSJnmBA2AB/XqKO5oZdGQ28xm3kihVDo/RfPu05cJ41qNhSORcZ
 zoS1/yLmFhgaPXj6XS4wXIAB3NK4cFhTiUtXIU4I0KHZLXFcPR+plarKvT0qTi5bBTOU2oaZjp4
 qKJV0E8FD4BrtQ7y28AugyMg14fEbJPmKlvbNmoK2qV2XIRhvMv8KfWD0grda4c6Nuvnh6Etdr2
 bYjx/Dw5JHM=
X-Received: by 2002:a05:600c:5489:b0:450:d07e:ee14 with SMTP id
 5b1f17b1804b1-454dd2e22eamr31579145e9.17.1752151842257; 
 Thu, 10 Jul 2025 05:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQUm+nSlcdSTM71ERxEOGYQPw+A1Esda0RdwN42zIQcLwtfOvwaPORxQvahGpOTVVlQz6WqQ==
X-Received: by 2002:a05:600c:5489:b0:450:d07e:ee14 with SMTP id
 5b1f17b1804b1-454dd2e22eamr31578855e9.17.1752151841847; 
 Thu, 10 Jul 2025 05:50:41 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d4cbsm1828131f8f.50.2025.07.10.05.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 05:50:41 -0700 (PDT)
Date: Thu, 10 Jul 2025 14:50:39 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL 19/23] util/qemu-sockets: Refactor success and failure
 paths in inet_listen_saddr()
Message-ID: <mqf4udflugih2bj5bn6cvo2jqqsr6icnmcfekpcvpxvyxnar3l@r26ont3wrtpy>
References: <20250522102923.309452-1-berrange@redhat.com>
 <20250522102923.309452-20-berrange@redhat.com>
 <CAFEAcA9jxiazMKEyoPQQdqRBKydgkbKQobtLPyszSHT1M-LHGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9jxiazMKEyoPQQdqRBKydgkbKQobtLPyszSHT1M-LHGA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-07-10 13:17, Peter Maydell wrote:
> On Thu, 22 May 2025 at 11:33, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > From: Juraj Marcin <jmarcin@redhat.com>
> >
> > To get a listening socket, we need to first create a socket, try binding
> > it to a certain port, and lastly starting listening to it. Each of these
> > operations can fail due to various reasons, one of them being that the
> > requested address/port is already in use. In such case, the function
> > tries the same process with a new port number.
> >
> > This patch refactors the port number loop, so the success path is no
> > longer buried inside the 'if' statements in the middle of the loop. Now,
> > the success path is not nested and ends at the end of the iteration
> > after successful socket creation, binding, and listening. In case any of
> > the operations fails, it either continues to the next iteration (and the
> > next port) or jumps out of the loop to handle the error and exits the
> > function.
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  util/qemu-sockets.c | 51 ++++++++++++++++++++++++---------------------
> >  1 file changed, 27 insertions(+), 24 deletions(-)
> >
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 4a878e0527..329fdbfd97 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> 
> 
> Hi; Coverity complains about this code (CID 1610306):
> 
> > @@ -303,11 +303,20 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
> >          port_min = inet_getport(e);
> >          port_max = saddr->has_to ? saddr->to + port_offset : port_min;
> >          for (p = port_min; p <= port_max; p++) {
> > +            if (slisten >= 0) {
> > +                /*
> > +                 * We have a socket we tried with the previous port. It cannot
> > +                 * be rebound, we need to close it and create a new one.
> > +                 */
> > +                close(slisten);
> > +                slisten = -1;
> 
> Here we set slisten to -1 ...
> 
> > +            }
> >              inet_setport(e, p);
> 
> ...but then two lines later we unconditionally set slisten to
> something else, so the -1 assignment is overwritten without being
> used.
> 
> >              slisten = create_fast_reuse_socket(e);
> 
> What was the intention here ?

Hi Peter!

The intention was to not leave an invalid socket number in the variable
after it's closed, similarly how it was done before refactoring:
https://gitlab.com/qemu-project/qemu/-/blob/b8b5278aca78be4a1c2e7cbb11c6be176f63706d/util/qemu-sockets.c#L346

I haven't noticed it's technically not needed anymore; unless there is
something added in-between in the future. I can send a patch that
removes it if necessary.

Best regards

Juraj Marcin

> 
> thanks
> -- PMM
> 


