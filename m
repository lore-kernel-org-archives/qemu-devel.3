Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EDDD17124
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 18:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2x0D-0007RC-Up; Mon, 21 Oct 2024 14:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t2vDa-0001ga-7h
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:25:18 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nenut@skiff.uberspace.de>)
 id 1t2vDX-0004Za-O7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:25:17 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id D10061803B7
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 18:25:05 +0200 (CEST)
Received: (qmail 10259 invoked by uid 990); 21 Oct 2024 16:25:05 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 21 Oct 2024 18:25:05 +0200
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 16:25:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <nenut@skiff.uberspace.de>
Message-ID: <871fdb20adbc4fc3a9709291e489ba1cd1ffda7d@skiff.uberspace.de>
TLS-Required: No
Subject: Re: [RFC PATCH v2 4/7] target/arm: call plugin trap callbacks
To: "Peter Maydell" <peter.maydell@linaro.org>, "Julian Ganz"
 <neither@nut.email>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
In-Reply-To: <CAFEAcA8iiYG2kw=tpMiLUsN+ZB-f6aN5eb-aAOhhc7nZyjA0+A@mail.gmail.com>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <be4c64f56a4a7f25a2769c0eccd2ed6e1d8cb9ee.1729355735.git.neither@nut.email>
 <CAFEAcA8iiYG2kw=tpMiLUsN+ZB-f6aN5eb-aAOhhc7nZyjA0+A@mail.gmail.com>
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1)
X-Rspamd-Score: -0.1
Received-SPF: pass client-ip=185.26.156.114;
 envelope-from=nenut@skiff.uberspace.de; helo=mailgate02.uberspace.is
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 21 Oct 2024 14:19:35 -0400
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

Thanks for the quick reply!

October 21, 2024 at 2:58 PM, Peter Maydell wrote:
> This omits M-profile Arm CPUs (whose interrupt/exception
> handling is rather more complicated, and lives in
> m_helper.c.)

Yes, I forgot about the M-profile. I'll include those changes wiith the
next patch-series.

> >  @@ -11819,6 +11838,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
> >  if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
> >  arm_handle_psci_call(cpu);
> >  qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
> >  + arm_do_plugin_vcpu_interrupt_cb(cs);
> >=20
>=20This isn't really an interrupt or exception -- it's
> more like the semihosting, where the guest does an HVC
> or SMC instruction and QEMU handles it by emulating it
> as if it were firmware. Maybe it would be better to
> name the "semihosting" plugin callbacks something more
> generic and include this kind of case in them ?

Oh, good to know. The only term for something like this (which also
includes semihosting) that comes to mind would be "host call". But that
may be confusing when talking about emulated vs simulated hypervisors?

Regards,
Julian

