Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C8C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB92v-00078z-Vz; Mon, 28 Sep 2026 06:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB92u-00078Z-2o
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB92r-0006G9-VY
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790593037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDar4Z7zDZs3Gf1LVC2IUvdH1Oto7aASa+E88d+qPwo=;
 b=EmGS0Lhr4DyRJcQgODRkuWbx5yuYqz2Z7YW4u2vPssaR6/4WETyIqerqzRhSdGEBKMwVYd
 0DBKt8k2bT9o9AwjdpWmfsBWtNzgtLIeV85biyaTXPxRfy5cvqQmv57u5Cjd6TBzhoumoq
 MUXa9ea62QlM6Nu1n0gPe5G5imaJ65o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-dBhQGp6tMvW_GPR04Ctp6w-1; Mon,
 28 Sep 2026 06:57:11 -0400
X-MC-Unique: dBhQGp6tMvW_GPR04Ctp6w-1
X-Mimecast-MFC-AGG-ID: dBhQGp6tMvW_GPR04Ctp6w_1790593030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0FED195394F; Mon, 28 Sep 2026 10:57:09 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76C7C1956087; Mon, 28 Sep 2026 10:57:06 +0000 (UTC)
Date: Mon, 28 Sep 2026 11:57:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
Message-ID: <arpH_2anGV-JU12e@redhat.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 28, 2026 at 06:51:41PM +0800, Yonggang Luo wrote:
> On Mon, Sep 28, 2026 at 6:39 PM Philippe Mathieu-Daudé <
> philmd@oss.qualcomm.com> wrote:
> >
> > On 28/9/26 12:13, Daniel P. BerrangÃ© wrote:
> > > On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> > >> query-targets lists each linked target, including none, with its
> > >> arch, endianness, and the machines that target accepts.
> > >>
> > >> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > >> ---
> > >>   hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> > >>   qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
> > >>   2 files changed, 65 insertions(+)
> > >
> > >
> > >> diff --git a/qapi/machine.json b/qapi/machine.json
> > >> index 6aaa2af709a..d8cdea6203e 100644
> > >> --- a/qapi/machine.json
> > >> +++ b/qapi/machine.json
> > >> @@ -307,6 +307,41 @@
> > >>   ##
> > >>   { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> > >>
> > >> +##
> > >> +# @TargetMachines:
> > >> +#
> > >> +# One registered system target and the machines that can run on it.
> > >> +#
> > >> +# @arch: the target architecture
> > >> +#
> > >> +# @endianness: the target endianness
> > >> +#
> > >> +# @machines: machine type names, not aliases
> > >> +#
> > >> +# Since: 11.2
> > >> +##
> > >> +{ 'struct': 'TargetMachines',
> > >> +  'data': { 'arch': 'SysEmuTarget',
> > >> +            'endianness': 'EndianMode',
> > >> +            'machines': ['str'] } }
> > >
> > > We already have  'QemuTargetInfo' struct which is used
> > > with 'query-target', that should also be used with the
> > > new 'query-targets' command.
> > >
> > > We need to add the 'endianness' field to QemuTargetInfo.
> >
> > Why do we want to expose endianness, and what endianness to
> > expose? Endianness is a runtime bit state of CPUs. Sometime
> > this bit is hardwired but that is an implementation detail.
> 
> For some targets it's, but for some targets it's not. for example
> 
> mips-softmmu.mak
> mipsel-softmmu.mak
> mips64el-softmmu.mak
> mips64-softmmu.mak
> 
> 
> mips64el-softmmu.mak
> mips64-softmmu.mak
> only differ the endianless

"EndianMode" is a tri-state including 'unspecified' as a value,
so we can cope with both scenarios - the targets where endianness
is runtime switchable in the CPU can use 'unspecified' as the
EndianMode. That behaviour should be documented in the QAPI
docs for QemuTargetInfo

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


