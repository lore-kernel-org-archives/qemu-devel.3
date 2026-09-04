Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F3CC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Qu2-0001GJ-Ei; Fri, 04 Sep 2026 06:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2Qu1-0001G2-8b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2Qtz-0000AH-B2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 06:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788516726;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmNmnbnTv7wSzEKsL+gGAR/l60yeaczum5xxREckn3I=;
 b=NadEv4YIW4ApEhYQejWsYRDyhr43pOTPGRUOwBaiLNKI/pkfHImZxuqXjYtkMRy794eCDy
 DEG5jOdTi1JNSna5On2WVDtT7MyQghmmCdNO9riVCUtjIGewNPyfFjlANYvu/2ao0T86jx
 i96f4DVdEzKYXi9Y9RMSh9zn+l8eL1g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-Dp2J1arXMuytTF8QFj2fuQ-1; Fri,
 04 Sep 2026 06:12:00 -0400
X-MC-Unique: Dp2J1arXMuytTF8QFj2fuQ-1
X-Mimecast-MFC-AGG-ID: Dp2J1arXMuytTF8QFj2fuQ_1788516719
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71D57190F9E4; Fri,  4 Sep 2026 10:11:59 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B2FF427; Fri,  4 Sep 2026 10:11:57 +0000 (UTC)
Date: Fri, 4 Sep 2026 11:11:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
Message-ID: <apqZancGjQF7ld97@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <apqVhJrtMDECUb7I@redhat.com>
 <CAE2XoE-qNgNXi5fKzjt5qM4pk8hs+x90h4Bv_8OsJczYHW1_Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE-qNgNXi5fKzjt5qM4pk8hs+x90h4Bv_8OsJczYHW1_Rw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Sep 04, 2026 at 06:04:24PM +0800, Yonggang Luo wrote:
> On Fri, Sep 4, 2026 at 5:55 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> >
> > On Fri, Sep 04, 2026 at 10:13:04AM +0100, Peter Maydell wrote:
> > > On Fri, 4 Sept 2026 at 09:58, Yonggang Luo <luoyonggang@gmail.com>
> wrote:
> > > > On Fri, Sep 4, 2026 at 4:19 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> > > > > I'm still not clear on why we need to filter the devices at all for
> > > > > a new "qemu-system" binary ?
> > > > >
> > > > > Looking at the device delta listed in your other mail, a large
> number
> > > > > of those are PCI based. The microblaze machine types don't expose a
> > > > > PCI controller, so those PCI devices are redundant / won't be used
> > > > > with microblaze machines, which is why existing
> qemu-system-microblaze
> > > > > doesn't link to those devices.
> > > > >
> > > > > The same is true of many of the arm machines too though. Only a
> subset
> > > > > of arm machines have PCI, but the qemu-system-arm binary still
> includes
> > > > > and lists all these PCI devices. Users simply can't create a PCI
> device
> > > > > for the arm machines that lack a PCI controller, or they'll receive
> an
> > > > > error.
> > > > >
> > > > > Why doesn't this approach extend into the future qemu-system binary
> ?
> > > > > List everything, and if the user tries to add a device that's not
> > > > > compatible with a machine, then it will simply result in an error.
> > > >
> > > > Device filtering would be complicated, I guess, as there is so much
> CONFIG_* for devices. Another approach is to just place devices under an
> meson "enable_modules "  (in *.so/*.dll/*.dylib), so it won't be
> listed(memory consumption will also be reduced when it's not needed).
> > > >
> > > > But machine listings still need the filtering, considering virt is
> present for many different arches(riscv/arm/i686). so machine listing is
> still a thing.
> > >
> > > I was wondering if maybe one way to approach that is some
> > > "disambiguation" syntax on the machine name; so one could write
> > > "-machine aarch64:virt" vs "-machine riscv64:virt" (or whatever) to
> > > disambiguate when just "-machine virt" would be ambiguous; but if
> > > there's only one machine of that name then just "-machine foo" would
> > > work.
> >
> > Currently the QOM type name is directly derived from the machine
> > type name, just with a "-machine" suffix attached. So if the
> > machine name is not unique, then neither is the QOM type name.
> >
> > At the very least we need the QOM type name to be unique. We
> > could de-couple the two to make this work though, which does
> > not seem too hard.
> 
> I have did that, for example:
>  hw/riscv/virt.c         | 3 ++-
>  include/hw/riscv/virt.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index dd396410178..5e57f9443c2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1739,6 +1739,7 @@ static void virt_machine_class_init(ObjectClass *oc,
> const void *data)
>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
> 
>      mc->desc = "RISC-V VirtIO board";
> +    machine_class_set_name(mc, "virt");
>      mc->init = virt_machine_init;
>      mc->max_cpus = VIRT_CPUS_MAX;
>      mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> @@ -1802,7 +1803,7 @@ static void virt_machine_class_init(ObjectClass *oc,
> const void *data)
>  }
> 
>  static const TypeInfo virt_machine_typeinfo = {
> -    .name       = MACHINE_TYPE_NAME("virt"),
> +    .name       = TYPE_RISCV_VIRT_MACHINE,
>      .parent     = TYPE_MACHINE,
>      .class_init = virt_machine_class_init,
>      .instance_init = virt_machine_instance_init,
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 7c862b0da25..9f96dd98c6a 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -30,7 +30,7 @@
>  #define VIRT_SOCKETS_MAX_BITS          2
>  #define VIRT_SOCKETS_MAX               (1 << VIRT_SOCKETS_MAX_BITS)
> 
> -#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
> +#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("riscv-virt")
>  typedef struct RISCVVirtState RISCVVirtState;
>  DECLARE_INSTANCE_CHECKER(RISCVVirtState, RISCV_VIRT_MACHINE,
>                           TYPE_RISCV_VIRT_MACHINE)
> 
> 
> Maybe we have a better way for it?
> 
> For device conflict, that needs to be detected after the qemu-system is
> present.

Our existing qom-test should already be validate that in fact, if we
run them against the qemu-system binary, aas it'll start
'qemu-system -machine none' and list all QOM types & properties,
at least for the targets & associated devices that we have converted
to work with 'qemu-system'. Best coverage would require all targets
to be converted but we don't have to get there straightaway.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


