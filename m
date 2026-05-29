Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1732CD6E57
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1Ir-0003C9-6I; Fri, 29 May 2026 13:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wT1Io-0003Bu-3F
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wT1Im-0001of-8A
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780076839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7GduYPlkAuLRJ44tuwhwCsEGcK7AakqOh+aTWldKGU=;
 b=YQ63QRllZQkbZ1VAN7YoP4zfWXhq3rKqJV9nQbGnNJ9bvBDxVHkT+tCt6aI2NiWRG06j7E
 3T+fOX+lpIiKNK3ohc07ir6v1Zf94H6TNp8oLgyN6ti96BFCQdUnZuIAvMfZ+iTd2pTIKC
 VIeJlJm6ihS9LStLQWnRKcQIP3CHNow=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-8e5crlIDOFGj_AWkE8j5LA-1; Fri, 29 May 2026 13:47:16 -0400
X-MC-Unique: 8e5crlIDOFGj_AWkE8j5LA-1
X-Mimecast-MFC-AGG-ID: 8e5crlIDOFGj_AWkE8j5LA_1780076836
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4909c0f0ba2so7481595e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780076835; x=1780681635; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/7GduYPlkAuLRJ44tuwhwCsEGcK7AakqOh+aTWldKGU=;
 b=ioRK+/w6VhPmSkvtuaWrH1kLRNXqESSAcAR+jSUpbRz5uXdTcg1BSYqwZjIHvEN2pq
 ew+tTKTChYWK3MaSQ17ZljAZyVPSuPd6Mqv+nfYQcg/ssmfY0iUr9wgVNcyeS63qDhzy
 k293y0xEjqTXvqDxfdqNjDnnb6nyPmjC5pULXipq7F7mv712vgNBrAJo1zx2Or63RCK7
 k+iO9V/ZyioxbqDDpwIkpwP5GZwY3fzTB8c/XMSk3BLTXXHoHVXV3IXkiwhNitJmDYyW
 XanL0dyykTTo97nioVwFiAeUHVjuzQUiPFv8U0qgKuOEPEPK4G9NtYGtQy9wbCi28wPk
 5GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780076835; x=1780681635;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/7GduYPlkAuLRJ44tuwhwCsEGcK7AakqOh+aTWldKGU=;
 b=KnThCZe1GyLfmmqOT3J8HQzMQhBwtEn9xYHlY+W640cDCOY4Gp/1N9vds3WW4FT+Vh
 wpgajCvbcLfW48vzWjaKxVs34/AeSNlXc/vHW+CLGWe4m9Zrtc/u2j6yX5uooxe3eyLT
 cogKW+GaBHWPd/i94e/CY38jCBuTbWhb6MhVkgXPdY6AMT7TFc5NmrnI/nAzOjm6WS1l
 6j4HQLfV9xKDv1/KkhrrrkVVPyeK6kOyXg90zG3tZiIQgQzmc3F3MgqUunM8psHfAFJQ
 j7Oj2//cyeB8hhUZMZ1wxvY74wACucZ2OUI9Fi4EP3u0n1pctHoi6X0iPIWNRDaqd9/h
 TAmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XpUx44AMr+OQ+tZz5nl65lspWsd8l/N2YNSh4VDWANeA8OFM3dQiqhji3qyRiAHNxwzf+9xnx9EPo@nongnu.org
X-Gm-Message-State: AOJu0Yxy6VuBmJhGQqqDRAEzmFX6qYbfGgE8XEahFbU265Z6MVThpcjN
 7hnMtry/kaGwGTTs5Sp6Jn3UFoZgEY4rDRagY1k3zELnYLAOOxcLOiGOMYkjTFVP9CsP0Wde1E+
 xApPivRqc+EVmDmMf6Cz8aV2+QM2fRnA4LHdGm7ea7ihEv9ofvE/EduHxmHxeZIqu
X-Gm-Gg: Acq92OEMqT9Uqz27b7xcDZGLR/sLVeBrHzJ6zcDCww/dtqux0HJBrjo65I6ZoPu1UMs
 uU/tt/NDQDf6hmgVRSy37B5gmsK5t/eAY8k1you7o28XjOS32jAi0G+qG+lVGMnWbHH1win1wZb
 oLbiCJFEHbv24VPDtiryTw1r9Um8HLVpj6ow4zbP1C1fIeYwvXHH3gkGf8duhcLL0aWywVlDcNy
 Wb5TEdvhn2Y4OxLr+USAZAtNnC1E1gSXE880jIFsfJpQoZFaNX9seKNhvFNBLyQRD12FmE9X8pX
 PZ6DcXY+AYLxXu4M+RAJAgfKBiJThmfleONIl+d6EA/JD+4ZwJaRIEfAlgb8QLV8W5dnPy/mvAQ
 pfMM1wB9g0XwSJo4YR0D/4rAosYkh1oGA872zyAQd25HY3ZVhOnFfSw==
X-Received: by 2002:a05:600d:8648:20b0:490:9d5c:a3e0 with SMTP id
 5b1f17b1804b1-490a29215ebmr8437325e9.9.1780076835501; 
 Fri, 29 May 2026 10:47:15 -0700 (PDT)
X-Received: by 2002:a05:600d:8648:20b0:490:9d5c:a3e0 with SMTP id
 5b1f17b1804b1-490a29215ebmr8436965e9.9.1780076834946; 
 Fri, 29 May 2026 10:47:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cab0e79sm110378875e9.13.2026.05.29.10.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:47:14 -0700 (PDT)
Date: Fri, 29 May 2026 13:47:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260529124753-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <CAFEAcA_EWR_MjH1arCdi2y0saZ-Hc7zRAK97YTeEcesVRb9Rtg@mail.gmail.com>
 <20260529114114-mutt-send-email-mst@kernel.org>
 <CABgObfZ5OUOih=pSrmpCKaAWqWnKgNZ2yZvRUoctYr=tEunoXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZ5OUOih=pSrmpCKaAWqWnKgNZ2yZvRUoctYr=tEunoXA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 29, 2026 at 06:17:29PM +0200, Paolo Bonzini wrote:
> 
> 
> Il ven 29 mag 2026, 17:46 Michael S. Tsirkin <mst@redhat.com> ha scritto:
> 
>     > If as a project we want to limit the
>     > blast-radius if we find we have to rip out a hypothetical tainted
>     > contribution, shouldn't that mean that we hold that as a project-wide
>     > line, rather than leaving it up to the opinion of the individual
>     > maintainer ?
> 
>     I guess, the maintainer can judge that the code is unique and qemu
>     specific enough, and follows from what it is doing automatically enough,
>     that the chances it is accidentally copying something are nil?
> 
> 
> One thing that I had in mind was using AI to adjust QEMU code as the kernel
> side goes through review and APIs change. The changes at that point may be not
> entirely mechanical and, more importantly for traceability, it probably will
> not make sense to separate them from the original code; but the code still has
> fundamentally a shape and design that was provided by the human.
> 
> Another, which is Rust-specific, is procedural macro code, which is often
> boring, or very much tied to the shape of the generated code and human-written
> traits, or both. See https://github.com/qemu/qemu/blob/master/rust/qemu-macros/
> src/migration_state.rs for an example, contrasting the block starting with
> "self.conversion = match" with the rest.
> 
> I don't think it makes sense to have a wholesale permission for procedural
> macros because that is not *always* true, or true for a whole file. But say a
> contributor wrote the overall specification/documentation first, and mostly
> one-shotted a skeleton with a prompt like "based on the documentation, generate
> basic attribute parsing code for the MigrationState derive macro, together with
> a code generator that provides empty methods for an implementation of the trait
> ::migration::MigrationState from rust/hw/migration/". Then I would absolutely
> not reject it. This is also the intention of the suggestion around prompts—to
> favor quick generation of boilerplate code over full "agentic" (blargh)
> implementation.


Agreed.

> 
>     > > +**Documentation and code comments**
>     > > +  While AI can help draft text, it still requires significant human
>     > > +  oversight.  Pay attention to the organization and flow of the
>     generated
>     > > +  text, and strictly fact-check all technical details as LLMs are
>     prone
>     > > +  to being confidently wrong.
>     >
>     > I think the application to documentation and comments is the part
>     > I'm least enthusiastic about here.
> 
>     But I am very enthusiastic about less agrammatical english in both.
>     AI is super helpful for non native speakers.
> 
> 
> I am also not enthusiastic for documentation; the review I gave for Philippe's
> unedited experiment was rather scathing. The main challenge for documentation
> is the structure of the work, which is really complicated to establish because
> the LLM doesn't have a clue about the underlying design.
> 
> But there can be interesting uses nevertheless, such as integrating knowledge
> from functional tests into documentation, that are worth exploring. Also for
> Rust I am really trying to have *all* functions commented (and tested through
> so tests) and AI can produce good results more often than not, especially when
> the model has access to a human-written file-level blurb.
> 
> 
>     > For changes to code, we have at
>     > least some guardrails on the AI output, in the fact that it has to
>     > compile and to pass tests. For changes to documentation, the
>     > only guardrails are human eyeballs.
>     >
>     > Also both comments and documentation ideally are a record of
>     > what we intended the behaviour to be. If an LLM is effectively
>     > autogenerating something documentation-shaped from the code we
>     > lose that.
> 
> 
> I agree with both of these observations, for what it's worth.
> 
> Paolo
> 
> 
>     >
>     > -- PMM
> 
> 


