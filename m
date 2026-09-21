Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C017C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8fLx-0002cp-Lv; Mon, 21 Sep 2026 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8fLm-0002ah-03
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:50:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8fLf-0002ju-JJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790002226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8STZDtJX9UCZzAYVpoBReVORpfEdG9dzLI8F6Gx1Bw=;
 b=VNYxAAkMrn5iopVCoowtCHHWe6eeNffl721JLdH1V0uvk/FRU5d8nfEse3H75zdCoSjvHF
 JYysZ1MieVFkqF+Kf8Vm8zhMdwpMwLIc22F+CeTB5zAGgPYSjl2YQpX1dy4vPz7K+SpmhE
 mUOCA63MXHMHrMV7SRuFt0LTPzV+0zs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-DsBjqwFFNC2tFZ9WNb59sQ-1; Mon,
 21 Sep 2026 10:50:21 -0400
X-MC-Unique: DsBjqwFFNC2tFZ9WNb59sQ-1
X-Mimecast-MFC-AGG-ID: DsBjqwFFNC2tFZ9WNb59sQ_1790002218
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C8C91828B19; Mon, 21 Sep 2026 14:50:17 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F2EE180057F; Mon, 21 Sep 2026 14:50:11 +0000 (UTC)
Date: Mon, 21 Sep 2026 15:50:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <17746591750@163.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 1/8] machine: allow -M name to differ from QOM type
Message-ID: <arFEIHf5YtRHP10c@redhat.com>
References: <20260918000640.1001-1-luoyonggang@gmail.com>
 <20260918000640.1001-2-luoyonggang@gmail.com>
 <arE85G8MqlxMQQ7B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arE85G8MqlxMQQ7B@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 21, 2026 at 03:19:16PM +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 18, 2026 at 08:06:32AM +0800, Yonggang Luo wrote:
> > - Add machine_class_set_name() so boards can keep a stable -M name
> >   when the QOM type is uniquified. machine_class_base_init still
> >   defaults the name to the QOM type without -machine.
> > - Document that MachineClass::name is the -M name, not the QOM type.
> > - Sort -M help by MachineClass::name so order matches the printed names
> >   when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
> > 
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  hw/core/machine.c        |  6 ++++++
> >  include/hw/core/boards.h | 12 +++++++++++-
> >  system/vl.c              |  8 +++-----
> >  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

When I apply this series and test libvirt, libvirt crashes because
it sees a machine name "virt-11.1" and then to introspect it, it
calls

  qom-list-properties type=virt-11.1-machine

this doesn't work as the actual type name is

  qom-list-properties type=arm-virt-11.1-machine

The problem we put ourselves in here is that 'query-machines' only
returns the machine name, and not the typename, so mgmt apps have
to infer that    typename==$machinename + "-machine".

Libvirt shouldn't crash of course and the fix for the crash it
"easy", but when fixing it, then libvirt simply won't be able to
introspect the machine, as it doesn't name the naming convention to
get the typename out.


I think we probably need to extend 'query-machines' so that it
includes a @typename field, so mgmt apps don't have to make the
bad assumptions about naming conventions for types.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


