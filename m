Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B1ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27dM-0003V7-Hu; Fri, 26 Sep 2025 08:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v27dF-0003UN-5S
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:33:01 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v27d9-0003dD-64
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:32:58 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71d60157747so21609607b3.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758889967; x=1759494767; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lp3GeJ+YLtVVqIxcZjFigOF119X+ufuw7YFLf23UwCk=;
 b=k9DstLcyhxYkQ3p4zybi70UOpZXu6h//B6rF7BU1m/3HDJAfmDRYPX+wHe5+uc1ilV
 EZ58YogAc9jOd3H3J6CLGHE2paJBosu2LplxDt7EQzy9ki40K8fBl34b78ojOL4ak1nv
 IUxeINfLKeFbh7Qd4ZYpjsuCpaBEvtFaiG2o/iTpZih3vVp3Tqr7eXFT23VbBzVb1itV
 cDOTsY9SGedgxGivC7ni9V72Ao9aSxGHW36TnixfesAe6B96BfZ7rcrc2ExhV4PpqOGe
 EkSZMRdg3C0hAH/Da/8+Ig5+sTKXhkOUVmxN+gPgCcpnKIFMVKIF/0/3XMTkwgt7LBbe
 DB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758889967; x=1759494767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lp3GeJ+YLtVVqIxcZjFigOF119X+ufuw7YFLf23UwCk=;
 b=ZXjlRGSaWv3MvJa2S/fuQVLHDFnXhTCl2jnb7VoeH7nPexfmab7za/SXrOny1e5/QH
 b5OTr2PZ6E7eJowTBBb/6WEDCWQXDpsDEB7NqJVhlZh3WO/KI9IyWhCCmQ0m2MgPcRor
 1Lin1inCL58wHO0q93leZWOlhsx13l+ZTQqre/2hoyKfpm+FjmHnP9RlblVpdhjPxN7r
 +E6JXwba6uNgT3RZsmRG+2FRJtGoONX41GlRedye0+9PULLi6LB6VrpimrOslBbx8m2p
 QVARmHSxk3YKgM49bU9zCWzZdaMdZS7kc0v+A/z3bneO6hcwbEEiYH/q/qWbj+h3zqUM
 9TMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/DNmy3kms3X799d4Do5qMNvwRC2wOuA1OG3vozsDCwGd1YDn2ZQfk1EHSgOzCfF8CaIxX/t2TNwPT@nongnu.org
X-Gm-Message-State: AOJu0YwM/r+8MBCUr18ipah/NUjTLAI2r0FplkRE6FXnSeL8Xh29pfGX
 crKhH9IVkWtSBvHKBzfj9DFm2eo+e0HuG+lyy3fflJaXOpVBREE+P3UMib05q/5W3zp75UGE7uZ
 AdzJamOnPmi+Ir47boTIlzbo0ykBx9XGeEkrutT3ENw==
X-Gm-Gg: ASbGncvI5dFsZdu0bH1EuZwafNbQtjOnSZVQgx3D4aOuVsdiadf87HrpB3DQej6HcIp
 FXKpjveQ/RSLi/BpXfe3Q9XQDx+Xaj3MXT+Qax9q2vCIGybDmrcXjB9s42il4C2EXcqZJfAXVcG
 c23kZglo3agA+rq9S7ofu22iefQUBRsABshMJHHBYpb0uPYO46+E18VOp38mkrC3JV197ANn0y8
 LilK4o+DCOkv6GdBa8PEyJ3lFOhMw==
X-Google-Smtp-Source: AGHT+IHI1/rGHt9tNX89UUrRv1M3aYiXMZqWbrEDkbTuwstWTB1T6hjaiFA/Vz1MVdsrnLNPuVgbdlZybk4IpP7x6W0=
X-Received: by 2002:a05:690e:2449:b0:633:c0f9:705c with SMTP id
 956f58d0204a3-6361a7b9867mr5794222d50.24.1758889966788; Fri, 26 Sep 2025
 05:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-3-mark.caveayland@nutanix.com>
 <CAFEAcA_w1QkHACeb9y6GGUOPunu1YHYVQQwat4zdFWODG3u2Nw@mail.gmail.com>
 <9343fab3-f1e8-4a07-ae15-cc905d4bc42c@nutanix.com>
In-Reply-To: <9343fab3-f1e8-4a07-ae15-cc905d4bc42c@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 13:32:34 +0100
X-Gm-Features: AS18NWDb0fgFxfuwOdlNikXaqhDvt2LhKoI-0I4XfGdNFVaQDclJuybb5oq3l6I
Message-ID: <CAFEAcA_miYHARDKmczwDH-TCS3JvbNp6Y3bEJKV8-0wkJf2bUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs/about/deprecated.rst: document new
 restrictions for isapc CPU models
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: imammedo@redhat.com, philmd@linaro.org, berrange@redhat.com, 
 jdenemar@redhat.com, armbru@redhat.com, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 26 Sept 2025 at 13:28, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 26/09/2025 13:05, Peter Maydell wrote:
>
> > On Thu, 25 Sept 2025 at 17:07, Mark Cave-Ayland
> > <mark.caveayland@nutanix.com> wrote:
> >>
> >> Add a new paragraph in the "Backwards compatibility" section documenting that
> >> the isapc machine is now restricted to 32-bit x86 CPUs, and -cpu host and
> >> -cpu max are no longer supported.
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >> ---
> >>   docs/about/deprecated.rst | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> >> index aa300bbd50..4c7000650d 100644
> >> --- a/docs/about/deprecated.rst
> >> +++ b/docs/about/deprecated.rst
> >> @@ -514,6 +514,19 @@ available firmwares that are using the current (wrong) name.  The
> >>   property is kept as is in 9.1, together with "riscv,delegation", to
> >>   give more time for firmware developers to change their code.
> >>
> >> +x86 "isapc" board restricted to 32-bit x86 CPUs (since 10.2)
> >> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> >> +
> >> +The "isapc" board represents a historical x86 ISA PC and is intended for
> >> +older 32-bit x86 CPU models, defaulting to a 486 CPU model.  Previously it
> >> +was possible (but non-sensical) to specify a more modern x86 CPU, including
> >> +``-cpu host`` or ``-cpu max`` even if the features were incompatible with many
> >> +of the intended guest OSs.
> >> +
> >> +Now the "isapc" board contains an explicit list of supported 32-bit x86 CPU
> >> +models. If the user requests an unsupported CPU model then an error message is
> >> +returned indicating the available CPU models.
> >
> > This should go in "removed.rst", I think. "deprecated.rst" is for
> > things that still work today (perhaps with a warning) but will stop
> > working in a future QEMU release, not for things that we have already
> > caused to stop working. (And we should only go directly to
> > 'removed' for features that we are sure nobody's using, but
> > I assume we've already had that discussion for the code change.)
>
> It's an interesting one because rather than removing something, we're
> adding a validation check to prevent the user from doing something that
> is nonsensical, i.e. using a modern CPU on a board/OSs that would never
> happen in real life. Given that just about everyone other than hobbyists
> is using the pc/q35 machines on x86, the target audience for isapc is
> comparatively small.
>
> There was some concern that libvirt could generate -cpu host/-cpu max
> for isapc on the command line which is why I added the original
> workaround, but then Igor intervened as maintainer and requested this to
> be removed and enforced via valid_cpu_types instead.
>
> Where do you think would be a suitable place in removed.rst? Maybe the
> "System emulator machines" section?

That would be fine. In general I think deprecated.rst and
removed.rst are supposed to have the same structure of sections,
so that when we take something from "deprecated, might warn"
to "stops working entirely" we move that paragraph from wherever
it was in deprecated.rst to the equivalent section in
removed.rst.

-- PMM

