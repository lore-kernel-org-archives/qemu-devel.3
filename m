Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8961FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3d0O-0004RA-IB; Tue, 30 Sep 2025 12:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3d0E-0004QL-NU
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3d07-0001Ou-84
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759248885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ds5tdil/lTNH/2NK3Cg7a+fvCLOuvhJYbX2wfZ6xi5c=;
 b=UIsHs//DNo/u6XejlQQ7bYQccik9gdBWBg9aN+KWx1ccwP9nmWys5oAt8VRA5DGRTCARct
 k1gTpZOjqBfKk8HoE29AJHkI/H8lbjmyIlXGN7xS9SCMdhw/8yTyrB55TUL46VUzADHBqY
 pzbfvKuGzgtyvjDNNoBEn6a/3Czly1Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-vvjdya72Ntm0Kay29sygKg-1; Tue, 30 Sep 2025 12:14:41 -0400
X-MC-Unique: vvjdya72Ntm0Kay29sygKg-1
X-Mimecast-MFC-AGG-ID: vvjdya72Ntm0Kay29sygKg_1759248881
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4de4fb840abso974651cf.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 09:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759248881; x=1759853681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ds5tdil/lTNH/2NK3Cg7a+fvCLOuvhJYbX2wfZ6xi5c=;
 b=thZYbjZoXQmX031MJ1xPvdW6oRJCQAxtW+/DnqMggRgoUAgjuNQ45eeIT58PsRHV9m
 7BY1XvSCh4QEDc0vwzMk78Gkt+jjghgoy6zgVcAYJFPwMnLtOBeT055T5PylFEhuNYwJ
 pZrOeIIWHrPcFljDthc5UJpppZdcC0pQkt0NksI+WsCPUnzfFH2kP5TX5QVJC3qKgQIP
 eK8DD4Sl94mB8Gpq5OVrlCABTV2z5nttEvkEqgwbSijqolG9jk0U88IoxUTuZJ0+hQJd
 gMtcDIhUyJP5a83eHFQfy4UHpbpJx9UuSQqg5bOY5jupCkJJJ4OvqLpQ5d8qeyF60iWe
 H0Tg==
X-Gm-Message-State: AOJu0YzrweX3OpCzwALIXDmFjffZOztQrTZcCfwZ6ZPmKHf4es6Qvm0l
 R7vaepAaHGU7RLZtVSht8sgCtFugtEbjsybuN6vlJZMkyttCBjAUwwG57N+lxdFf+1NIa0ve34g
 xWExCt0H3snsyNMfDtdFYacq9ZStyIU/6w6kdacdtOVZzVlWm2VnZeZkP
X-Gm-Gg: ASbGncuEdu/3q77FnpsLrzK2Z7b7zpKwc2lKCne6LteimVYam2iY1UP9b8ftylDQX73
 09LJ1TabcY7reWUTnf2bjJLyvWY1D7VUxTpMpwO2JFGuoA4wg6/C9f673PBaWQAY8o0eg5+42r/
 IXOoK+3+hUrHBYDE91feWBNIiNO8BxG4fg2UZ9AYnNHLn0o5Rk1E0zN61oPpdEUJEkVw6CjPCoY
 uuBxvIAbLzPJs2IiIawAc+i8GWmo17pP34IYKg+sxk8UePEQMGxg1SBZrDiX4n3cZFw2Ri2TdE4
 uU8tnyQoS2LawfPjRm3fGNrI9XOUXSVX2NIKFA==
X-Received: by 2002:a05:622a:1a24:b0:4d5:eedd:688c with SMTP id
 d75a77b69052e-4e404c89546mr7393871cf.13.1759248880794; 
 Tue, 30 Sep 2025 09:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSxSyAK+eWeR66Bz3rQWAA9dAJuqf1jTxx0n/LLtHCanEGcEa66qODusnKAdeP2Ipuhoxz+A==
X-Received: by 2002:a05:622a:1a24:b0:4d5:eedd:688c with SMTP id
 d75a77b69052e-4e404c89546mr7393301cf.13.1759248880186; 
 Tue, 30 Sep 2025 09:14:40 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db11227c23sm100598521cf.40.2025.09.30.09.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:14:39 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:14:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Emilio G . Cota" <cota@braap.org>
Subject: Re: [PATCH 3/3] rcu: Avoid double rcu frees
Message-ID: <aNwB7pdWyVxlDMaV@x1.local>
References: <20250929190801.931989-1-peterx@redhat.com>
 <20250929190801.931989-4-peterx@redhat.com>
 <CAFEAcA-7OC3AfDyowK9pCW6yxo_LoTVv=B+AvT=1g+6W46DmrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-7OC3AfDyowK9pCW6yxo_LoTVv=B+AvT=1g+6W46DmrQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 30, 2025 at 10:19:54AM +0100, Peter Maydell wrote:
> On Mon, 29 Sept 2025 at 20:08, Peter Xu <peterx@redhat.com> wrote:
> >
> > Trap call_rcu1() to make sure it won't be invoked twice for one rcu head.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  util/rcu.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/util/rcu.c b/util/rcu.c
> > index b703c86f15..9272fe5796 100644
> > --- a/util/rcu.c
> > +++ b/util/rcu.c
> > @@ -307,6 +307,8 @@ static void *call_rcu_thread(void *opaque)
> >
> >  void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
> >  {
> > +    /* Avoid double rcu frees */
> 
> I would maybe have this say "Catch accidental attempts to
> use the same rcu node for two things at once", which
> isn't the same as a "double free" in the usual sense.

Agree.  I'll also adjust the subject when repost, thanks.

> 
> > +    assert(node->func == NULL);
> >      node->func = func;
> >      enqueue(node);
> >      qatomic_inc(&rcu_call_count);
> 
> thanks
> -- PMM
> 

-- 
Peter Xu


