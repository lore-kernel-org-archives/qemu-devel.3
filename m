Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F5EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 06:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ2rb-00069t-Tj; Wed, 31 Jul 2024 02:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ2rV-00068u-CE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 02:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZ2rQ-0005bQ-AC
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 02:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722407454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFqmm5B5rAwk5dtYSiYPSjKNDVSS+d62iKdjRKaAh00=;
 b=C1jiCzXd3HBPrBhtaCoxGu8n9kVPQOjxb8AMXDO+GoWy3l56G6L5ahkdLy6Q8fK+ru+qcC
 p5A57z0rT9eX99CEDqSqXU7glnD4+RaVeZ4DlFfvvFnIuhOnivy+5HbU3mUSg6tJMb3m6u
 8EKTPWdq4d4uZBt8HSMCi5gRIKJcAV8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-dV63mwN3N2CIzUbGrHsDMw-1; Wed,
 31 Jul 2024 02:30:51 -0400
X-MC-Unique: dV63mwN3N2CIzUbGrHsDMw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 218551955D45; Wed, 31 Jul 2024 06:30:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA30A19560AE; Wed, 31 Jul 2024 06:30:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8DAFF21E6690; Wed, 31 Jul 2024 08:30:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 richard.henderson@linaro.org,  berrange@redhat.com,  eduardo@habkost.net,
 Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v2 2/2] qom/object, accel-system: add support to Accel
 globals
In-Reply-To: <20240703204149.1957136-3-dbarboza@ventanamicro.com> (Daniel
 Henrique Barboza's message of "Wed, 3 Jul 2024 17:41:49 -0300")
References: <20240703204149.1957136-1-dbarboza@ventanamicro.com>
 <20240703204149.1957136-3-dbarboza@ventanamicro.com>
Date: Wed, 31 Jul 2024 08:30:46 +0200
Message-ID: <87bk2ekr8p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

I apologize for the delay.

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> We're not honouring KVM options that are provided by any -accel option
> aside from the first. In this example:
>
> qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
>     -accel kvm,riscv-aia=hwaccel
>
> 'riscv-aia' will be set to 'emul', ignoring the last occurrence of the
> option that set 'riscv-aia' to 'hwaccel'.

The way you phrase this, it sounds like a bug.  But as far as I know,
-accel is meant to have fallback semantics: we use the first one that
works.

Perhaps:

  -accel has fallback semantics, i.e. we try accelerators in order until
  we find one that works.  Any remainder is ignored.

  Because of that, you can't override properties like this:

      qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
          -accel kvm,riscv-aia=hwaccel

  When KVM is available, 'riscv-aia' will be set to 'emul', and the
  second -accel is ignored.  When KVM is not available, neither option
  works, and the command fails.

Why would you want to override accelerator properties?

Aside: not diagnosing obvious errors in fallback options we don't use is
not nice.  Not this patch's problem.

> A failed attempt to solve this issue by setting 'merge_lists' can be
> found in [1].

I guess this failed because it destroyed the fallback semantics.
Correct?

>               A different approach was suggested in [2]: enable global
> properties for accelerators. This allows an user to override any accel
> setting by using '-global' and we won't need to change how '-accel' opts
> are handled.
>
> This is done by calling object_prop_set_globals() in
> accel_init_machine(). As done in device_post_init(), user's global
> props take precedence over compat props so object_prop_set_globals() is
> called after object_set_accelerator_compat_props().
>
> object_prop_check_globals() is then changed to recognize TYPE_ACCEL
> globals as valid.

Would it make sense to enable -global for user-creatable objects
(-object), too?

> Re-using the fore-mentioned example we'll be able to set
> riscv-aia=hwaccel by doing the following:
>
> qemu-system-riscv64 -accel kvm,riscv-aia=emul (...) \
>     -global kvm-accel.riscv-aia=hwaccel

I'm confused.

-accel kvm,riscv-aia=emul creates accelerator kvm (which is an instance
of class "kvm-accel") and sets its property "riscv-aia" to "emul".

-global kvm-accel,riscv-aia=hwaccel changes the (global) default value
of class "kvm-accel" property "riscv-aia".

Are you *sure* your example sets "riscv-aia" to "hwaccel"?

> [1] https://lore.kernel.org/qemu-devel/20240701133038.1489043-1-dbarboza@ventanamicro.com/
> [2] https://lore.kernel.org/qemu-devel/CABgObfbVJkCdpHV2uA7LGTbYEaoaizrbeG0vNo_T1ua5b=jq7Q@mail.gmail.com/
>
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


