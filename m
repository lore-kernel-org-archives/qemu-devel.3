Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202F4CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0e1y-000412-Ls; Mon, 22 Sep 2025 06:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1v0e1u-00040d-6c
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1v0e1r-0005uS-C8
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758537857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnbu1l1VkjVnu8/6pKhzxkvdYigzo+AQskHIDc04FnE=;
 b=KXCnFim120Hn1L8zmR1/fR+Yook+zg1F7LTOWeiJgTsjP/7mUcugFyJyBTL2PnLPI2D/0D
 Cf0zZMLvn/0YevDl0xDjvbCAAdticue4BXrXrcpFZv2m1b7rqa8Klvb+oJuORHcWqkf7Xn
 KopPKv5YArvvddGKkNzFwKxOn8Nx3ZY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-zTYX_yUbNmm7LqcfHm1Npw-1; Mon,
 22 Sep 2025 06:44:13 -0400
X-MC-Unique: zTYX_yUbNmm7LqcfHm1Npw-1
X-Mimecast-MFC-AGG-ID: zTYX_yUbNmm7LqcfHm1Npw_1758537852
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85C3819560A5; Mon, 22 Sep 2025 10:44:12 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CEE53000198; Mon, 22 Sep 2025 10:44:10 +0000 (UTC)
Date: Mon, 22 Sep 2025 12:44:09 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
Message-ID: <aNEoecDkcHV7y3IH@orkuz.int.mamuti.net>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <aK7wDn03e8RtKmk3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK7wDn03e8RtKmk3@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 27, 2025 at 12:46:22 +0100, Daniel P. Berrangé wrote:
> On Wed, Aug 27, 2025 at 12:10:00PM +0100, Mark Cave-Ayland wrote:
> > On 26/08/2025 08:25, Xiaoyao Li wrote:
> > 
> > > On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
> > > > The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
> > > > possible to specify any CPU via -cpu on the command line, it makes no
> > > > sense to allow modern 64-bit CPUs to be used.
> > > > 
> > > > Restrict the isapc machine to the available 32-bit CPUs, taking care to
> > > > handle the case where if a user inadvertently uses -cpu max then the
> > > > "best"
> > > > 32-bit CPU is used (in this case the pentium3).
> > > > 
> > > > Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > > > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > ---
> > > >   hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
> > > >   1 file changed, 26 insertions(+)
> > > > 
> > > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > > index c03324281b..5720b6b556 100644
> > > > --- a/hw/i386/pc_piix.c
> > > > +++ b/hw/i386/pc_piix.c
> > > > @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj,
> > > > int value, Error **errp)
> > > >   #ifdef CONFIG_ISAPC
> > > >   static void pc_init_isa(MachineState *machine)
> > > >   {
> > > > +    /*
> > > > +     * There is a small chance that someone unintentionally passes
> > > > "- cpu max"
> > > > +     * for the isapc machine, which will provide a much more modern
> > > > 32-bit
> > > > +     * CPU than would be expected for an ISA-era PC. If the "max"
> > > > cpu type has
> > > > +     * been specified, choose the "best" 32-bit cpu possible which
> > > > we consider
> > > > +     * be the pentium3 (deliberately choosing an Intel CPU given
> > > > that the
> > > > +     * default 486 CPU for the isapc machine is also an Intel CPU).
> > > > +     */
> > > > +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
> > > > +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
> > > > +        warn_report("-cpu max is invalid for isapc machine, using
> > > > pentium3");
> > > > +    }
> > > 
> > > Do we need to handle the case of "-cpu host"?
> > 
> > I don't believe so. I wasn't originally planning to support "-cpu max" for
> > isapc, however Daniel mentioned that it could possibly be generated from
> > libvirt so it makes sense to add the above check to warn in this case and
> > then continue.
> 
> Libvirt will support sending any valid -cpu flag, including both
> 'max' (any config) and 'host' (if KVM).
> 
> If 'isapc' still expects to support KVM, then it would be odd to
> reject 'host', but KVM presumably has no built-in way to limit to
> 32-bit without QEMU manually masking many features ?
> 
> I'm a little worried about implications of libvirt sending '-cpu max'
> and QEMU secretly turning that into '-cpu pentium3', as opposed to
> having '-cpu max' expand to equiv to 'pentium3', which might cauase
> confusion when libvirt queries the expanded CPU ? Copying Jiri for
> an opinion from libvirt side, as I might be worrying about nothing.

When doing CPU expansion or checking a virtual CPU created when starting
a domain, we only care about features and ignore CPU model name. The CPU
expansion returns "base" CPU model name anyway. So we should not really
notice -cpu max was silently changed into something else by QEMU.

Jirka


