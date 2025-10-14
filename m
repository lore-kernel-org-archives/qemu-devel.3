Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17926CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ezY-0003lx-S2; Tue, 14 Oct 2025 09:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8ezV-0003l2-22
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8ezR-0007Qq-Vf
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760448173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZeAe0W2caL9CflAGkea4mBkhMtjIgXKl2UU112ofOw=;
 b=AHnU6Yyn6regajuihR2KI2P1co24JOPHSqygQlEdMIQTAwREOM6DVHHF+nXLdLJ9/P+aG+
 6i7yjsrMOZos7f5qnzjgbTo2NBQYyxYlBi7PGQYtz3cZH79KtK2EOCOv45BS/5wuzd4Oba
 bM6eQE8vvGsflVG9XDxBKVcOwllk0C4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-EeCLxSfyOrWfltLtTa2Zng-1; Tue,
 14 Oct 2025 09:22:49 -0400
X-MC-Unique: EeCLxSfyOrWfltLtTa2Zng-1
X-Mimecast-MFC-AGG-ID: EeCLxSfyOrWfltLtTa2Zng_1760448167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 949E81954102; Tue, 14 Oct 2025 13:22:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.198])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51BC71801AD9; Tue, 14 Oct 2025 13:22:40 +0000 (UTC)
Date: Tue, 14 Oct 2025 14:22:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Message-ID: <aO5OndKoyP4Tk8Rw@redhat.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
 <20251013070945-mutt-send-email-mst@kernel.org>
 <aOzm2ukHfkPF-zhT@redhat.com>
 <CAFEAcA9p51aPGhHgUPishEJ9TE60dm83ofKr5Wa-qM_1SqJ67w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9p51aPGhHgUPishEJ9TE60dm83ofKr5Wa-qM_1SqJ67w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 14, 2025 at 01:20:07PM +0100, Peter Maydell wrote:
> On Mon, 13 Oct 2025 at 12:47, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > With a very minimal wording tweak our current defined policy could
> > avoid being a blocker for enabling KVM in imx8mp-evk. In
> >
> >   https://www.qemu.org/docs/master/system/security.html
> >
> > where it describes the "virtualization use case", we could simply
> > tweak it to always require a versioned machine type
> >
> > Change
> >
> >   "These use cases rely on hardware virtualization extensions
> >    to execute guest code safely on the physical CPU at close-
> >    to-native speed."
> >
> > To say
> >
> >   "These use cases apply to versioned machine types when used
> >    in combination with hardware virtualization extensions
> >    to execute guest code safely on the physical CPU at close-
> >    to-native speed"
> 
> With the suggested changes listed elsewhere in this
> thread, my current manually curated list of machines is:
> 
> aarch64
>   ``virt``
> i386, x86_64
>   ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
> s390x
>   ``s390-ccw-virtio``
> loongarch64:
>   ``virt``
> ppc64:
>   ``pseries``
> riscv32, riscv64:
>   ``virt``
> 
> If we say "versioned machine type", that puts these machines
> outside the "supported" boundary:
> 
> i386, x86_64
>   ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``
> loongarch64:
>   ``virt``
> riscv32, riscv64:
>   ``virt``
> 
> I can certainly see the argument for loongarch64
> and maybe even riscv[*] still being "not supported for
> production security-boundary stuff", but do we really
> want to say that the Xen machine types and microvm
> aren't suitable for VM use ?

No, that would be wrong. How about this alternative

  @@ -21,7 +21,9 @@ Virtualization Use Case
   The virtualization use case covers cloud and virtual private server (VPS)
   hosting, as well as traditional data center and desktop virtualization.  These
   use cases rely on hardware virtualization extensions to execute guest code
  -safely on the physical CPU at close-to-native speed.
  +safely on the physical CPU at close-to-native speed.  This use case is limited
  +to the use of versioned machine types, or machine types designed exclusively
  +for virtualization.
 
 The following entities are untrusted, meaning that they may be buggy or
 malicious:

that wording would bring xen* and microvm into the scope, and so match
your manually curated list.


> [*] Could somebody from riscv or loongarch maintainers
> say whether they think these machines should be on the
> "security supported" list or not yet ?

As 'virt' machines even if they're not quite there today, they are heading
in that direction. So it would make sense to consider them in scope for
the virtualization use case security handling. Even with this classification
we still have the flexibility to make bugs public immediately with no embargo
if we consider the real world impact to be low, so the burden is not large.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


