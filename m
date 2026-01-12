Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249E4D2503B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 07:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfBv3-0004Qn-QW; Mon, 12 Jan 2026 02:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfBuh-0004Nq-6P
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:00:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfBud-0003ul-RK
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768201226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5lPuVsPyv1xwEPYso965xgr7n58gl0b6Ie4iaRnmdE=;
 b=PfOlJJ86ESi86Z2W4KRKN5uqfItyC8Xi42pvDSapNWoPkSd0q0lBGAtGMIDZg2M7pSXwos
 E7bB/Rb4xvK+Ekz0moG3berPAt9y5t96PzDvHSbxHItT4XuaDvEByMF1nILajxeQWqNlRQ
 sOsi7Ov3FubwxSAkOeWgq97+8O712yA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-Eh4OOc84NAWH6hua5Yl5Pw-1; Mon,
 12 Jan 2026 02:00:22 -0500
X-MC-Unique: Eh4OOc84NAWH6hua5Yl5Pw-1
X-Mimecast-MFC-AGG-ID: Eh4OOc84NAWH6hua5Yl5Pw_1768201219
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFC2619560A3; Mon, 12 Jan 2026 07:00:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94D3A1956048; Mon, 12 Jan 2026 07:00:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2255B21E6683; Mon, 12 Jan 2026 08:00:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,  Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Yoshinori Sato
 <yoshinori.sato@nifty.com>,  Max Filippov <jcmvbkbc@gmail.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] monitor/hmp: Reduce target-specific definitions
In-Reply-To: <aWOvk527PkZzLtSp@gallifrey> (David Alan Gilbert's message of
 "Sun, 11 Jan 2026 14:11:31 +0000")
References: <20260107182019.51769-1-philmd@linaro.org>
 <20260107182019.51769-3-philmd@linaro.org>
 <87jyxsczyk.fsf@pond.sub.org> <aWOvk527PkZzLtSp@gallifrey>
Date: Mon, 12 Jan 2026 08:00:14 +0100
Message-ID: <87a4yjiadd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>> > From "monitor/hmp-target.h", only the MonitorDef structure
>> > is target specific (by using the 'target_long' type). All
>> > the rest (even target_monitor_defs and target_get_monitor_def)
>> > can be exposed to target-agnostic units, allowing to build
>> > some of them in meson common source set.
>> >
>> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>=20
>> The only use of the ->get_value() callback I can see is in
>> get_monitor_def(), to implement HMP's $register feature.  I can't see
>> the callback being set.  Is it dead?
>
> I think I see that being used in ppc;
> target/ppc/ppc-qmp-cmds.c
>
> const MonitorDef monitor_defs[] =3D {
>     { "fpscr", offsetof(CPUPPCState, fpscr) },
>     /* Next instruction pointer */
>     { "nip|pc", offsetof(CPUPPCState, nip) },
>     { "lr", offsetof(CPUPPCState, lr) },
>     { "ctr", offsetof(CPUPPCState, ctr) },
>     { "decr", 0, &monitor_get_decr, },
>     { "ccr|cr", 0, &monitor_get_ccr, },
>     /* Machine state register */
>     { "xer", 0, &monitor_get_xer },
>     { "msr", offsetof(CPUPPCState, msr) },
>     { "tbu", 0, &monitor_get_tbu, },
> #if defined(TARGET_PPC64)
>     { "tb", 0, &monitor_get_tbl, },
> #else
>     { "tbl", 0, &monitor_get_tbl, },
> #endif
>     { NULL },
> };
>
> those monitor_get_* functions are that get_value() aren't they?

You're right.

target/sparc/monitor.c and target/i386/monitor.c have more.

I prefer .member =3D initial-value when member is optional.

Thanks!


