Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803AFCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGdac-0000eK-67; Tue, 13 Oct 2026 10:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1xGdaZ-0000cm-2W; Tue, 13 Oct 2026 10:34:47 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1xGdaW-0004AY-6j; Tue, 13 Oct 2026 10:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=iggU6xo52j7UG5f89Bng/0Pyh6G/SqJ/YSGM/n8n/nc=; b=ILI3HUbMwaiTNmXt
 4MVkZAkzrVh7f42Z7Oedb0nzJydEHlwYOZpVXGkvzLq03Wd5VeEUcxaBINq211n78SwzoLjqfxWbm
 4rIEQy/8XkGxTObDppvF+O40NInOuiKoEpljXwPwjU3yuMBr5Cq1QdkPq9gvQLPA4cW0QvP9EIrjl
 V5W2ZhKdlP2oQySUS2NJEquEyGx9neFfH00aDhsmsVkmLd+Mk4z5M7ecApZ88PCTKJ6ZFSbHiWjeW
 QfSLwjwNtkuzpGLLxspPQIvTxK+0nneYo1FDNfwXrGITejs/z57T2qV4sd5yXSFOLNwl3QCaxmqcs
 QfQruF+0+a9iaedscQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1xGdaK-00000003l3Q-2nef;
 Tue, 13 Oct 2026 14:34:32 +0000
Date: Tue, 13 Oct 2026 14:34:32 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH v2 04/10] gdbstub: add gdb_register_internal_coprocessor()
Message-ID: <as5BeHc6uCyYynwz@gallifrey>
References: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
 <20261013-query-reg-v2-4-6f95a2e139a9@redhat.com>
 <87ik36gfe6.fsf@draig.linaro.org>
 <CAJ+F1CK938-GciwPJj_KjtvKZ04fvKhi8UcSHHORmoboVURzeQ@mail.gmail.com>
 <CAFEAcA-sKfp-1u_UaPbv=SCbDNYrdc69NZdVPT8RTTXgwXYSZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-sKfp-1u_UaPbv=SCbDNYrdc69NZdVPT8RTTXgwXYSZQ@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.111+deb13-amd64 (x86_64)
X-Uptime: 14:32:12 up 13 days, 23:53,  2 users,  load average: 0.00, 0.02, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Tue, 13 Oct 2026 at 14:01, Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi
> >
> > On Tue, Oct 13, 2026 at 12:51 PM Alex Bennée <alex.bennee@linaro.org> wrote:
> > >
> > > Marc-André Lureau <marcandre.lureau@redhat.com> writes:
> > >
> > > > Add support for registering coprocessor features that are only visible
> > > > to QEMU's internal APIs (HMP monitor $register expressions, plugins) but
> > > > hidden from GDB's target description XML.
> > > >
> > > > When a feature is registered as internal:
> > > > - It is excluded from the target.xml sent to GDB
> > > > - Its XML is not served via qXfer:features:read
> > > > - 'p'/'P' packets for internal register numbers return E14
> > > >
> > > > This is useful for exposing system registers to the HMP monitor without
> > > > affecting GDB's register namespace. Exposing aliases or synthetic
> > > > registers through GDB's target description can cause problems: name
> > > > collisions with GDB's pseudo-registers, independent register caching,
> > > > and missing DWARF unwind rules.
> > >
> > > Hmm are they *that* useful for HMP then?
> > >
> > > The front-ends do limit what they export to gdb (see for example
> > > ARM_CP_NO_GDB) generally because reading them causes side-effects. Those
> > > restrictions are also a reason to limit them from the HMP interface.
> >
> > I am not a user, but I can imagine they are useful for developers.
> >
> > I would like to be able to implement "info registers" purely based on
> > QMP for ex.
> 
> Yes, getting rid of the current hacks that "info registers" does will
> be a very nice cleanup.
> 
> I think that the reason we get this internal-only interface is
> that gdb itself sets up pseudo-registers for various things that
> are nice for a human to have but are not directly exposed that
> way in the XML. So for HMP we can either:
>  (a) not expose that human-facing convenience at all
>  (b) reimplement the equivalent of the pseudo-registers and
>      aliases, to the extent that we care to do so, in a way
>      that they don't appear in the XML we expose to gdb
> 
> Personally I'm sceptical of the utility of the "info registers"
> interface -- if you want to see what the guest CPU is doing then
> you're going to have a much better time connecting gdb to the debug
> stub rather than using the extremely rudimentary monitor commands --
> but "preserve the existing functionality" is a much easier path
> towards getting this cleaned up than trying to get agreement that
> we can drop some aspects of it, so I support doing that.

It's useful for getting hints on hung VMs;  getting a gdb into a container
on some cluster of hosts and someone letting you poke with it is
often pretty hard.
Getting an admin to run one command when they find a hung VM is more doable.
(Similarly in cases where they wont send you a full vm dump)

Dave

> thanks
> -- PMM
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

