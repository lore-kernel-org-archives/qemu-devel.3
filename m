Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26234C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 13:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD2jy-0004XG-Gw; Fri, 31 May 2024 09:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <reinoud@gorilla.13thmonkey.org>)
 id 1sD2jw-0004W5-8y
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:56:16 -0400
Received: from 2a02-a46b-bd8f-1-b9b1-f16b-e3de-c82.fixed6.kpn.net
 ([2a02:a46b:bd8f:1:b9b1:f16b:e3de:c82] helo=gorilla.13thmonkey.org)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <reinoud@gorilla.13thmonkey.org>) id 1sD2jt-0000BA-1m
 for qemu-devel@nongnu.org; Fri, 31 May 2024 09:56:15 -0400
Received: by gorilla.13thmonkey.org (Postfix, from userid 103)
 id 2903D2FF0981; Fri, 31 May 2024 15:46:00 +0200 (CEST)
Date: Fri, 31 May 2024 15:46:00 +0200
From: Reinoud Zandijk <reinoud@gorilla.13thmonkey.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: Re: [PATCH 2/5] cpu: move Qemu[Thread|Cond] setup into common code
Message-ID: <ZlnUmG41Ahi_dSzX@gorilla.13thmonkey.org>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-3-alex.bennee@linaro.org>
 <2a20631b-ce2a-4079-87c6-f77c0ba589e3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a20631b-ce2a-4079-87c6-f77c0ba589e3@linaro.org>
Received-SPF: none client-ip=2a02:a46b:bd8f:1:b9b1:f16b:e3de:c82;
 envelope-from=reinoud@gorilla.13thmonkey.org; helo=gorilla.13thmonkey.org
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.26,
 RCVD_IN_PBL=3.335, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, May 30, 2024 at 03:29:41PM -0700, Pierrick Bouvier wrote:
> On 5/30/24 12:42, Alex Bennée wrote:
> > Aside from the round robin threads this is all common code. By
> > moving the halt_cond setup we also no longer need hacks to work around
> > the race between QOM object creation and thread creation.
> > 
> > It is a little ugly to free stuff up for the round robin thread but
> > better it deal with its own specialises than making the other
> > accelerators jump through hoops.
> > 
> > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
...
> > diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
> > index 6b2bfd9b9c..0ba31201e2 100644
> > --- a/target/i386/nvmm/nvmm-accel-ops.c
> > +++ b/target/i386/nvmm/nvmm-accel-ops.c
> > @@ -64,9 +64,6 @@ static void nvmm_start_vcpu_thread(CPUState *cpu)
> >   {
> >       char thread_name[VCPU_THREAD_NAME_SIZE];
> > -    cpu->thread = g_new0(QemuThread, 1);
> > -    cpu->halt_cond = g_new0(QemuCond, 1);
> > -    qemu_cond_init(cpu->halt_cond);
> >       snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
> >                cpu->cpu_index);
> >       qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,

I haven't tested it since I don't have a recent qemu build but I doubt it will
give issues as its main qemu stuff.

Reinoud


