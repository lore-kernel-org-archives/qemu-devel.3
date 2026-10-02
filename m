Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6564ECA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgUk-0001H2-VN; Fri, 02 Oct 2026 12:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCgUh-0001Fp-Ff
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCgUf-0000C6-2T
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790959939;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtbWWHEp4TD27a35w2xmkt5MMvEdWzL5JZ78GVAcva8=;
 b=WePqC3ebBfgghaRWHauxVN4jbB2Z2rkD/BD9CkrsxHGaQAGOnyXOu33E8UpTLf80feTpuV
 GohxCdlAtIBv2skwGA5W4xICzWMv6plairn2qkWCqLQI2toGipIlrxgqd5raVAax2YUM1R
 E9/5AS1ho7kSOqpJmLOzjqR5+60InFg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-n9zEUQt_M3KPQ-9qn-dc8Q-1; Fri,
 02 Oct 2026 12:52:16 -0400
X-MC-Unique: n9zEUQt_M3KPQ-9qn-dc8Q-1
X-Mimecast-MFC-AGG-ID: n9zEUQt_M3KPQ-9qn-dc8Q_1790959933
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE273180214A; Fri,  2 Oct 2026 16:52:12 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6D0A180056E; Fri,  2 Oct 2026 16:52:07 +0000 (UTC)
Date: Fri, 2 Oct 2026 17:52:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
Message-ID: <ar_hNU0Y4BxXKHnv@redhat.com>
References: <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
 <ar6a_uDw9OeLng6c@redhat.com>
 <6bf4dad5-4fa2-4df1-b6b8-d594dbd3842c@oss.qualcomm.com>
 <ar6lw3jAcnVej6vK@redhat.com>
 <557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com>
 <CAE2XoE8MriyEEeRF3uDwWgnJWPHBieK_-pD1+k0tUjROWjDpWg@mail.gmail.com>
 <a9cba466-f442-4bbf-9154-3674b5f10882@oss.qualcomm.com>
 <ar_coT44h5-zJPVV@redhat.com>
 <CAE2XoE8Jg=WHDF1_pQ-K-Y6f_aE2N8y5_=aJSeC4A52HWFwEkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE8Jg=WHDF1_pQ-K-Y6f_aE2N8y5_=aJSeC4A52HWFwEkA@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 03, 2026 at 12:43:19AM +0800, Yonggang Luo wrote:
> On Sat, Oct 3, 2026 at 12:32 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > "is_available" is probably a bit overkill as a mechanism for
> > introspecting, when we just need to return a list of targets,
> > Since we have that already we might as well use it initially
> > though.
> 
> I have experimented with x86_64/i386 arm/aarch64 riscv32/riscv64 so
> that I can tell:
> using is_available will be a better option. As we can use inherent the
> is_available from
> parent, if we just use a bit set like QEMU_ARCH_ARM, then that means we need
> specify it for every single machine. And if any customization is
> needed, for example, depends
> on KVM config or other accel config or any condition not just
> QEMU_ARCH_*, then is_available
> still needed, so I would insist is_available with a TargetInfo*
> parameter, then all concern
> will be addressed.
> 
> 
> 
> >
> > > >> Does it matches what you would expect?
> > > >>
> > > >> Also, for compatibility with existing binaries, should we accept -M
> > > >> $arch-virt also? I feel like it does not hurt and would make thing
> > > >> simpler to switch between existing and new binary.
> > > >
> > > > Same reason -M $arch-virt, indeed like -M $arch:virt,  but $arch-virt
> > > > would be even harder.
> > > > Because "-" is a valid separator in machine names, ":" is not a valid
> > > > machine name.
> > > > So without init QOM, we can not reliably identify "$arch-virt" belongs
> > > > to which target.
> > > >
> > >
> > > From the conversation above, Daniel and I are not in favor to have any
> > > kind of parsing based on this string. So either we'll pick virt, or the
> > > real qom name, but not anything else.
> >
> > Yeah, I'm leaning more towards always exposing the $arch-virt names
> > in all binaries, and also exposing 'virt' in the traditional
> > binaries only.
> 
> I have a question, do we expose the "$arch-virt" as a machine "name"
> and expose "$arch-virt" as machine qom "typename";
> or expose "virt" as a machine "name" and expose "$arch-virt" as
> machine qom "typename".

The human facing machine "name" is the important one.

For the QOM typename, I don't really mind either way. If we can keep
the QOM typename and human "name" matching that's nice, but if they
differ, then it is not a big deal - your series has the patch to
expose the QOM typename in QAPI 'MachineInfo' which addresses the
only downside of them differing. So whatever approach works best when
implementing the ideas...

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


