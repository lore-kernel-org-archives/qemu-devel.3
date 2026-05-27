Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FFFCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHHz-0005Cs-Sm; Wed, 27 May 2026 12:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHHs-00056f-6b
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHHq-0002Wq-4g
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779899955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=veKq+p2RsAkK1BMEPxGaeBuNcImSxA6ryTM+zmsRdwo=;
 b=JfNctilsTkUxdS8DkJjP542ueAa19X7dyBIiQYF8wcnDxG7KGrhxne+8VgHI9GLeonGyjm
 m4HlDXKWpZgcI2pn4fwU0iRIgzR6RhUPEbyPRKNuKw9ZBQFaWm7r809TfaCXrhFFUoQdHf
 IZCuRSRWnJWw67bg2dtldZNkAcw56h8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-o4SFnUvXNrueV9xWVsJrog-1; Wed, 27 May 2026 12:39:12 -0400
X-MC-Unique: o4SFnUvXNrueV9xWVsJrog-1
X-Mimecast-MFC-AGG-ID: o4SFnUvXNrueV9xWVsJrog_1779899951
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49043386b3fso52918165e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779899951; x=1780504751; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=veKq+p2RsAkK1BMEPxGaeBuNcImSxA6ryTM+zmsRdwo=;
 b=Byv3ZgX/hfru7JFFNOh+0nZ22sCjpUxTqWiyn5RmvI94Yf+YBPWK3gax7lvp8Hssjr
 /N5BXgPWc/OkWP7VcXWj7PsOdUBdo8CxwiGZkpOBv/fd/UDpok5l7tPnZpMXTr2eJBtc
 xi/ZDxFEoFiiCjYKZQ8aW4QaIPbWd1lg8z3KWNkP0b+ZRI50Y6cC7Mk+YZilBrVz7Gkj
 i6LcmJ4OAfTBc8ouYedBCpLpfaKZgLi9e7y44l/xSsVNgGUJ6ow9U4kI4Y72+qCeaKie
 zFw8kq3YKz/hlmESrWwUW5oMes95pJ+O67DWjz5stwvxIVCkOR+3PF50+OSNbWIohQcS
 R7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779899951; x=1780504751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veKq+p2RsAkK1BMEPxGaeBuNcImSxA6ryTM+zmsRdwo=;
 b=GsE2M8yAOh/MS7ZNp3kn+gkVMaW3orGi/kFUWI6Iph2nrSOpfortCP3ox5WkFr7JLY
 FSGO97KC1RLyc0zu1P3ri5GvfKTZNQ4Ebd8HKvyQEE1TQLuxp8R74pVxCHSZW/w8ie0F
 +C07CBhS5/G2tvG5MYou9BgfFV1fDc1zQsPFaxrFjP5Yku6kP4ktV4Yz/r5MVdLci/I1
 /BqNlJImFjOKH3WToUmL5Nqpao1U570xe0/Gxr3TFZ019LYjWkQ7fc+q+sqtcfMONI8k
 V6AVD4hEHvwvApEFi6krjAUKSdyRxOYTeUnmJ5gqBtUKfeDiSeEYQAYyyGwD9MIF2B6k
 n1Tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lp7KreNoh4Bo9CnvwpVKgvix1/OWs/F+1hnafSf6Lv4h3BZckYFJONR/hAYoJhPuwSY0c3fZ6KD/f@nongnu.org
X-Gm-Message-State: AOJu0YwdNoiqLR5rwyWLWlmQobJSF2Jy4YNoV1dAIAQpv2ZiRGX7RL6l
 JlUJvbUil0FGul+bhnRQ7dC5kvmmCUazLIsHq+bZS7yINHeVAWBmrUlToQy53z4M9BqrrSN/co3
 8SRFfIo043oQfLLRnkrGh9eWZCG+QjD0wKrNPAfZtNdZYp4jHODHuVQ9U
X-Gm-Gg: Acq92OGwcyFUOfnH6DKAvA5MLtx9zYaVN6OnfxxN4fipX5zEvrixiC3Nbm3aEUOLfKG
 i3zjZ/YnbgvDXaQEjtRAOAk+j0fJDGmtYPKsMHl+dhWO7IYM/7kZ6CnFb5v2ttw+Rmxm404TNyg
 aICrk1hH1jE+rmmjQ1JCEr6IO/eLJipy3lxSEvXNxBQ+iKTjhw/y4/WByOxVpYnPiScV77ZZxCf
 OkOyt5dNuF/DlxDGSp1JDsEjpHfxWOpMhROw91ZO0dtEud9KYQ5tgrzGZtlYH5P8D1ZyMu7a2Am
 yx44RAKXjG1YPz7n2X62WC3w3X1d5qpxCKBaOgLnK6YMemhpARpGekYoQ1JtboJtBWRGYbuWHyl
 XgPPLZIR059MOmPVm2RfgBhk=
X-Received: by 2002:a05:600d:4453:20b0:490:2238:4021 with SMTP id
 5b1f17b1804b1-49042494fe3mr286742055e9.8.1779899951107; 
 Wed, 27 May 2026 09:39:11 -0700 (PDT)
X-Received: by 2002:a05:600d:4453:20b0:490:2238:4021 with SMTP id
 5b1f17b1804b1-49042494fe3mr286741585e9.8.1779899950607; 
 Wed, 27 May 2026 09:39:10 -0700 (PDT)
Received: from redhat.com ([31.187.78.155]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb548dfasm6750785f8f.4.2026.05.27.09.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:39:09 -0700 (PDT)
Date: Wed, 27 May 2026 12:39:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260527123503-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 27, 2026 at 12:01:10PM +0200, Paolo Bonzini wrote:
> Commit messages for AI-assisted changes
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> When AI/LLM tools produce or substantively shape your patch, add an
> ``AI-used-for:`` trailer.  The text of the trailer could be one or more of
> ``code``, ``tests``, ``docs``, ``research``, possibly followed by an
> explanation in parentheses::
> 
>     AI-used-for: tests, docs
>     AI-used-for: code
>     AI-used-for: code (refactoring)
>     AI-used-for: code (prototype)
>     AI-used-for: research
> 
> The trailer is intended as a clarification of your DCO obligations as well
> as to guide reviewers.  It is not intended for minimal presence such as
> autocomplete or asking for a pre-review of the patch, and it does not remove
> your responsibility to understand the changes that you are submitting.
> 
> Include the prompt in the commit message if it helps a reviewer judge the
> result:
> 
> * yes: "move field ``foo`` from ``struct aa`` to ``struct bb``.  If a
> function already has a local variable or parameter of type ``struct bb``,
> use it instead of accessing ``aa.bb``."
> 
> * yes: "add an implementation of the trait for ``Mutex<T: MyTrait>``,
> forwarding the member functions to ``T`` while taking the lock around the
> calls".
> 
> * no: "write user-facing documentation for the new tool"
> 
> * no: "write testcases for the new functions"

I don't understand what these yes/no examples are trying to show.
AI tools aren't really yet up to the task of generating a reasonable
qemu patchset from a single prompt. As a reviewer, I am not really
interested what kind of magic "think extra ultra hard" invocation was
used to coax the output from the model.

I actually would like to know which model was used, since I expect that
with time I'll learn to trust output from specific models more just
like I trust output from specific contributors more.

-- 
MST


