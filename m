Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD19C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 18:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhDb-0001qd-HA; Mon, 09 Jun 2025 14:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uOhDX-0001qE-4Z
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:27:31 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uOhDV-0003vd-8C
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 14:27:30 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so769383066b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749493646; x=1750098446; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGrwTS0B43FIImIC09i/Xm+524QL3xw7ybR/hvWOpfM=;
 b=ZRgQ+scMzWtI32cJb5C5Xkw6v42whgeO/zsXNKYmNyxUpQjwH+rgpdEATPkFFiKiBS
 b8VCFafBCRD1td59nU+1s4qN7IerU7lEHQlWCAo2y3ZBEonpgkrZKSAHT32JikIwWF3u
 /xCJfCTdiC+sG93Up5qAjMev6/KK/748G9RMZWS3zW67rMuRyC7mwI9PGO906kQbhlSi
 HiwqSi6dawqvOykS8LBKCJxZxyYaS6cCIMmaM09TLKmR03YgSzIz3FHQX77I9Y3m9u1G
 GzU9dO6zLQYSdtcP/BHoOo2M+4F6fgDNlEnfiPBroiVjWEKXIFQL0BjsDTX4Qs8RmFaN
 hCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749493646; x=1750098446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGrwTS0B43FIImIC09i/Xm+524QL3xw7ybR/hvWOpfM=;
 b=xI8iMlqSneTNQhG5Z9DuEDwn0YazEqvy9zaRlduUkuDA1djXuaqFmTQ5Bo82BXx6KJ
 IvZS7qZVgzw+cGZ6DaKQVEa43wUVX3tBoh/81LOlQMtznOSj5OZJY3+TIbcpgOSo6XOs
 hvMXHChOv2dPySsSRc08GUpoYG79DgfjQThh+qOdI8AL2vyHt6quOWHsnXC90L45rERh
 N8gds6VUt4PhIltbsRmS23ggHmOO/Y8ug5WwPf27GBKhlpGQ5xG6xKrCZxy4vS+k/BiW
 1dG9CqYqcaDT9lN3hP5r66wQTxHwgHupLXQtQqC9b3Ke+zPlCjlCj35u5EPV2CTaL5nT
 0qIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAdYAw7dYxldVC3lCQbRUaaVIlxKO/dYctYZYgJTbR9RxWU1SoTR5oT1F/u8SrzzyNOcVsWcTUkSwI@nongnu.org
X-Gm-Message-State: AOJu0YzRIqvY4soBKY1FQth7+jDiTPChOKUSuF+NAHoCmv+5GP8q+MMW
 iVLNd6jQUoXm9lOEGu7zg5Tc5thMYy0cqo2Ot0RPmVFGRS0c1Rxu45S1c5GXAEDxDBDyhp50Qir
 A4espjN4UFI/Gw79vFd1ErFqZGIEKDVE=
X-Gm-Gg: ASbGncvhJwKD019tHv6BW6aeXVRCaI6U+zGi1UVHU6XXyV+pTmnWWOhI1jaVJHY/JmM
 nZYlEIjoI3aWRwvUHjLJxs3nkKoNiJrTDOiwhn82ynU7kv8kves0esNITgxWWJ/1UXRjj/sha9d
 SMgc07hjqF0Zt4cJSBL/D9W8bcbLqvckj14aydbfMZTQ==
X-Google-Smtp-Source: AGHT+IEmpTpW0v0GnAC9Wjj7uhn/9XUPsQpvMp14CHGk0Mc3wy+RF0dqRB2NF+Um1IkDpxIcvGLY/ebQQzKdFBwJL1A=
X-Received: by 2002:a17:907:3f1e:b0:ad8:9909:20ac with SMTP id
 a640c23a62f3a-ade1aa0f3e7mr1263610066b.50.1749493646184; Mon, 09 Jun 2025
 11:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-3-tanishdesai37@gmail.com>
 <20250602222434.GB320269@fedora>
 <7f4eefa2-9e00-4ba2-898f-c480c2123904@redhat.com>
 <CAJSP0QX=e3GkB5L0rpAf8YfkJDKOZYJcx553tut+7Hp2NK3XYg@mail.gmail.com>
 <03c067fc-2a47-4fc5-9204-1ac6ded4301b@redhat.com>
In-Reply-To: <03c067fc-2a47-4fc5-9204-1ac6ded4301b@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 9 Jun 2025 14:27:13 -0400
X-Gm-Features: AX0GCFtWTRfLqkemyTIGS3d5ZlpiWkBhPciH84opK1G81sj6Wh_C8erIIvyAsvw
Message-ID: <CAJSP0QULzQsJEN7q-QiG+Tj0ngstKcu_=0fyTytx11uMUDXmrw@mail.gmail.com>
Subject: Re: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>, qemu-devel@nongnu.org, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 5, 2025 at 2:49=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 6/5/25 20:37, Stefan Hajnoczi wrote:
> > On Thu, Jun 5, 2025 at 9:57=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >>> It's easier to understand the code generator and the generated code w=
hen
> >>> each trace event is implemented as a single function in the header fi=
le.
> >>> Splitting the trace event up adds complexity. I don't think this is a
> >>> step in the right direction.
> >>
> >> I am not sure I agree on that; something like
> >>
> >> static inline void trace_smmu_config_cache_inv(uint32_t sid)
> >> {
> >>       if (trace_event_get_state(TRACE_SMMU_CONFIG_CACHE_INV)) {
> >>           _simple__trace_smmu_config_cache_inv(sid);
> >>           _log__trace_smmu_config_cache_inv(sid);
> >>       }
> >>       QEMU_SMMU_CONFIG_CACHE_INV(sid);
> >>       tracepoint(qemu, smmu_config_cache_inv(sid));
> >> }
> >>
> >> and one function per backend seems the most readable way to format the
> >> code in the headers.  I understand that most of the time you'll have
> >> only one backend enabled, but still the above seems pretty good and
> >> clarifies the difference between efficient backends like dtrace and US=
T
> >> and the others.
> >>
> >> This series doesn't go all the way to something like the above, but it
> >> does go in that direction.
> >
> > It's nice to share a single trace_event_get_state() conditional
> > between all backends that use it. There is no need to move the
> > generated code from .h into a .c file to achieve this though.
>
> Ok, I see what you mean.  Personally I like that the backend code is
> completely out of sight and you only have a single line of code per
> backend; but it's a matter of taste I guess.
>
> > In the absence of performance data this patch series seems like
> > premature optimization and code churn to me.
> >
> >> Now, in all honesty the main reason to do this was to allow reusing th=
e
> >> C code generator when it's Rust code that is using tracepoints; but I =
do
> >> believe that these changes make sense on their own, and I didn't want =
to
> >> make these a blocker for Rust enablement as well (Tanish has already
> >> looked into generating Rust code for the simple backend, for example).
> >
> > How is this patch series related to Rust tracing? If generated code
> > needs to be restructured so Rust can call it, then that's a strong
> > justification.
> Well, moving code to the .c file would make it possible to call it in
> Rust without duplicating code generation for the various backends (other
> than the "if" and function calls, of course, but those are easy).
> However, this is only handy and not absolutely necessary for the Rust
> tracing project.
>
> If you disagree with this change we can certainly live without them---I
> asked Tanish to start with this as an exercise to get familiar with
> tracetool, and he's learnt a bunch of things around git anyway so it's
> all good.

A maintainer's life is easy when patches have a clear motivation. With
this patch series I'm not convinced there is a clear motivation, and
that makes me hesitate about applying them.

If it's okay with you, Tanish and Paolo, please hold on to the patches
and let's see how they fit into the larger goal of Rust tracing
support. If they help with that then I would be happy to merge them
together with Rust tracing patches.

>
> We'll also try to take a look at the code that is generated in the
> function that invokes the tracepoint, to see if it's improved.
>
> Paolo
>

