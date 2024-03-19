Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31041CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbQO-00089s-0i; Tue, 19 Mar 2024 11:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmbQL-00089Q-UC
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmbQF-0002WH-UX
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710862238;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=37GFYLI5MyQqq4540bATPhxNX5uMFiPaTnTj87Z/d5c=;
 b=OzVwdv9wXsB/xaimThbEWOA5z2lAnashbzljBREXj64VCcdi4WpAkmHhH+ZIunu/2Lq29E
 lLRwoDn7cHaSO+aOLymgpDTXymG1vNg6vuRCdGDyvemWfqWmDCkrhR511uQQXIquzsr8DQ
 cskXegArJKlfJl+zbYKmruz4tkT+juI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-kU30rjpWMg214CtLgs35JA-1; Tue, 19 Mar 2024 11:30:35 -0400
X-MC-Unique: kU30rjpWMg214CtLgs35JA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 583D2101CC6F;
 Tue, 19 Mar 2024 15:30:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE9B740C6DAD;
 Tue, 19 Mar 2024 15:30:32 +0000 (UTC)
Date: Tue, 19 Mar 2024 15:30:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eauger@redhat.com>, Shaoqin Huang <shahuang@redhat.com>,
 qemu-arm@nongnu.org, Sebastian Ott <sebott@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Message-ID: <ZfmvgXa9Xs2QA-U3@redhat.com>
References: <20240221063431.76992-1-shahuang@redhat.com>
 <CAFEAcA-dAghULy_LibG8XLq4yUT3wZLUKvjrRzWZ+4ZSKfYEmQ@mail.gmail.com>
 <c50ece12-0c20-4f37-a193-3d819937272b@redhat.com>
 <CAFEAcA-Yv05R7miBBRj4N1dkFUREHmTAi7ih8hffA3LXCmJkvQ@mail.gmail.com>
 <0f8380d9-bdca-47b2-93d9-ee8f6382e7f1@redhat.com>
 <CAFEAcA_dQGfBDiFCm7PUmvDrQtp1UK9HqkkV0-5x8fb-svYDYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_dQGfBDiFCm7PUmvDrQtp1UK9HqkkV0-5x8fb-svYDYA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 19, 2024 at 03:00:40PM +0000, Peter Maydell wrote:
> On Tue, 19 Mar 2024 at 14:57, Eric Auger <eauger@redhat.com> wrote:
> >
> > Hi Peter,
> >
> > On 2/29/24 12:00, Peter Maydell wrote:
> > >
> > > It doesn't appear because the list of properties that we advertise
> > > via query-cpu-model-expansion is set in the cpu_model_advertised_features[]
> > > array in target/arm/arm-qmp-cmds.c, and this patch doesn't add
> > > 'kvm-pmu-filter' to it. But you have a good point about all the
> > > others being bool properties: I don't know enough about that
> > > mechanism to know if simply adding this to the list is right.
> > >
> > > This does raise a more general question: do we need to advertise
> > > the existence of this property to libvirt via QMP? Eric, Sebastian:
> > > do you know ?
> > sorry I missed this question. yes I think it is sensible to expose that
> > option to libvirt. There is no good default value to be set at qemu
> > level so to me it really depends on the upper stack to choose the
> > correct value (depending on the sensitiveness of the data that justified
> > the kernel uapi).
> 
> In that case we should definitely have a mechanism for libvirt
> to be able to say "does this QEMU (and this CPU) implement
> this property?". Unfortunately my QMP/libvirt expertise is
> too low to be able to suggest what that mechanism should be...

Libvirt uses 'qom-list' on '/machine/unattached/device[0]' to
identify CPU properties.

If 'kvm-pmu-filter' appears with that, then detection will be
fine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


