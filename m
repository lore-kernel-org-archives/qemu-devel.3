Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981BBC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sgS-0001qn-SX; Tue, 08 Sep 2026 06:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3sgR-0001qe-VM
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x3sgG-0005VL-Hl
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UyohnQ1SfDwRPxyGNNjmcrgZGQgLel04OYjSJiVc6mg=;
 b=IEl9uneR3LgFnAgExVxHhYsZEUr3wBAZ8dujFkeUF0vRDWwXpLncfBEaqzhrhkLTt2pb6L
 XZGrJgsmHsh8apVeuqjE7L2OlLQ59C5sssbWfX8pwq3mmnHr6r2ZihDTl4b4DP8Fl2c54P
 U74YjujFV7PGsvkw1R4jHXhALqXmWxc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-UBEQ31lENQGr8pPAoe0jaA-1; Tue, 08 Sep 2026 06:03:53 -0400
X-MC-Unique: UBEQ31lENQGr8pPAoe0jaA-1
X-Mimecast-MFC-AGG-ID: UBEQ31lENQGr8pPAoe0jaA_1788861832
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49991beee7aso41547385e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788861832; cv=none;
 d=google.com; s=arc-20260327;
 b=Z6kHRr+xOgQMuC9swwRZ7j+xOahckzR0yvJp20cA35rOqje4q9WaCEVGf7Y48T7IyP
 KSylSkbG541bcIptCpemIcCB4K8OhZycssZf3OFyuJyAW6/2s7xGuNkyajuKIQCTjTRu
 0jC0ksYc906NcqGkNPg7DH0QIS5Wh7Yd06UxYXcKcHn2XfSv/bJOV7XbT3wELDaWEnBE
 gPIuvFsICYCG1ym9il8ryi4r/ohjuYc+0PFZnDVJpic3bV04eHmiUSUsXQVqDsMegUIp
 Pta2qX2+UMpf7i/E38ci37mgqnFbeTqQvK5zmZf9t5oFGHNTnoOPcSRVfKaZzjsS3LHH
 zDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UyohnQ1SfDwRPxyGNNjmcrgZGQgLel04OYjSJiVc6mg=;
 fh=xMxd3Q4Aixnq8oW08ruj9ywbyKbPaQ+kZwFVPswqSmc=;
 b=h62uhv8PsHaBT8QumdBZ2z7d+SedrwP+ATUZ3nxW3aW2PqiBl2NGv7JHIiigi5gGzf
 2HzxJeQmWVJCce6DS+Qg+VTP/nycIlOiJ19Hda9EuxxSZ7FYUH+EWJcSPgaSNZR3tnxW
 cLTpViatcsLKOgDDZk8wPuRCiOLindzqPSoPUfDg94OwteiRPRk8TyyOX+IbDuF+6ZRg
 nqrVmMPECErB80h5swFpXXjbnMXeCdNSGmataycFgdu/1b/+xH86mxxTvVwPsLlK0bfj
 4MktuJFjMELVxXWjl6yXkvZCYT3VDeXmCrAQarEoR9NwKQvYloP2cGnnaUSZAOqNX1Mb
 E9QA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788861832; x=1789466632; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UyohnQ1SfDwRPxyGNNjmcrgZGQgLel04OYjSJiVc6mg=;
 b=SmeSFkmbyfwj4srukM6iQ2+EhKBJvZ8VLhd1575uumFXTQO4HTDuOCkUSAfacwb92Z
 o2NoY9jS5wHWh0nAiUjxXo2aUDvc1JSkmtmw6Rn/JWMuyCUUtn0Dq8b+WFz35WpxTD27
 iihUYWe94u1cFYNka7UrPVqA0Db2zt0Z1ikHezwWWDrMz9ors+tNqe+XLmLoop7u6Daz
 tJhQTyxaQ2eEeABFwVUQ/MQexdXJHohwwL4si0+Fzzjeddmp+n+JU0bWdaaJXpmlMDcu
 DNMFw06//JhH5/g0gUB8lIZ9P+zeZE2VDuYFX7WY91ukoE9HKK4pwSXOiwBVrU6s09RY
 xcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788861832; x=1789466632;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UyohnQ1SfDwRPxyGNNjmcrgZGQgLel04OYjSJiVc6mg=;
 b=seLxk/D1cLvPUYwCvvWB39byGQbsu4wHQw6xfbtzJ2rkl0inlfgdgzxgV7lWkZLFJG
 Fqf4PRAJggQIQYSDuSJTQ89gfiqwXR59RlgmgwcWnnKx/v44GqIm2BWyuFOdCYoKHN3W
 bhU0juTBjO4A2h4Xb064A088S7wEl05ZTIDkS6e2EEL1rFLeiJww1Y+JHHYxVfYsOJHn
 xoT1H/5aoK3ByHSFLFQnXJKRhb8n1fxVKpLoSrhyfRxxU8HK1LmZxz2p4ITyS3jVrhvk
 W/rOYdGuMIUai8Uyb4jjD6aJL83VxE8AvSIsVMz6rWe6SWTG50GSszDNsk3VvOuc8s8p
 Ggeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAMoJlZzb4vTtt7P1t4DzFh4HVROzeJ+g4X+wtuH42ME1o8uf9O0yBTOAbHOpxPdmI5azLNHvB8ZSh@nongnu.org
X-Gm-Message-State: AFuF++lFKz48GwaXXiS9BUfGoRTtwlM5EUQI3VNffPf5YTl3rSD7wxYU
 FxbwwlhfUn7sab9ZVYN7ETRcQLA5NXoODtWb5cJ5km5yeAg4t5CnFkP/xA/2Utd0QIKgW2HRm+p
 QypglvLUOaZEjdSQZlCHYwGLg33LBIRAa3WPeA5bXIX2L3DGOSGkZ1JUK98NcyBZ68ikWeip2i5
 if5qMTUpf5LfKr/sq0eZ4YGQ7hON9vAR8=
X-Gm-Gg: AYBFou02k0khhMBwUUnB9ReDBro/xtiRQXI+2hWrHunPVtfPdSmzXnU/SXo2Y2rbv7j
 W5sP6tzVwT33OFefJVYeGlqW7rS6KgprfGkrp/n5Bk6+n5pZupXMNZEv/5oZ8O8Z8bodAU+lJaU
 rej0sYRDw6WZyG6AeYClDplN6uHTm+nE2vdCNRrQ9tvw8I1cqD2xkuprb6aorfNAtO7QpOt2ASZ
 LvzPA8+HJzAT+cz3Y+/Q/CM2Dbqm4ROnnSmWhdIkVHc7xr5bRMv9DRQvGN8mA==
X-Received: by 2002:a05:6000:400f:b0:485:9cb1:7186 with SMTP id
 ffacd0b85a97d-4859cb172acmr19670306f8f.1.1788861832139; 
 Tue, 08 Sep 2026 03:03:52 -0700 (PDT)
X-Received: by 2002:a05:6000:400f:b0:485:9cb1:7186 with SMTP id
 ffacd0b85a97d-4859cb172acmr19670237f8f.1.1788861831764; Tue, 08 Sep 2026
 03:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
 <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
 <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
 <7766d96b-4065-4917-9d7d-094bd6d1f29c@oss.qualcomm.com>
 <5aba99f7-5310-4cd3-a38c-3e9b922c8b05@redhat.com>
 <CAFEAcA9tz=Br3dRe3mN1fPkjm4y36eRSWUMs=bU8zDbKczCCsg@mail.gmail.com>
 <CABgObfZQb8FwDubg=pZk6nRSrUgdMxoDpRwG3Kd=GwpQeccLhg@mail.gmail.com>
 <CAFEAcA9mvz4U1v49-Pt20+Zw4LUsaVrOW3LuL0xhT-xHEuM_sA@mail.gmail.com>
In-Reply-To: <CAFEAcA9mvz4U1v49-Pt20+Zw4LUsaVrOW3LuL0xhT-xHEuM_sA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 8 Sep 2026 12:03:38 +0200
X-Gm-Features: AcwNN1XZAVazIgsi5kbjvtr5qaw5dCgCzudj7AmKsehhRDYop5TVhmxZnqFeJKc
Message-ID: <CABgObfYTAUoo1=8es_w9yBjfZtpNBJngUZViGWUkweeuiE7PZg@mail.gmail.com>
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 8, 2026 at 11:54=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
> On Tue, 8 Sept 2026 at 10:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On Tue, Sep 8, 2026 at 10:40=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > > I bet also that most targets don't expect it. Picking one at
> > > random, the sparc has_work function calls e.g. cpu_interrupts_enabled=
()
> > > which does not look like a function that is expecting to be called
> > > without the BQL.
> >
> > Why? It only accesses fields for the local CPU. The problem is
> > interprocedural communication, and only if it does not use
> > cpu_interrupt().
>
> Mmm, I guess this is OK: actual TCG code execution also accesses
> local CPU fields with the BQL not held, and if we're definitely
> always on the local vcpu thread when we call has_work then
> this is more or less the same thing. Doing anything more complicated
> than "we hold a lock" for thread-safety makes me nervous, is all :-)

Rightly so, but locks aren't always easy either. They can introduce
more problems or more widespread changes and "we're always on the
thread" in the end is mutual exclusion just like locks, only spatial
instead of temporal.

It's the ultimate thread-safety solution and, as you noticed, it's the
core of MTTCG's BQL-less execution.

And abstractions such as cpu_interrupt are needed even if they use
locks internally.

The problem is that C doesn't provide any tool to tell you that your
accesses are not local, or that your accesses are not holding the
lock, neither at compile time nor at run time (the BqlRefCell in the
Rust bindings are an example of run time checks).

Paolo


Paolo


