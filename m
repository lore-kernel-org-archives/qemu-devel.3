Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08890C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 05:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPx5b-00023c-Ka; Fri, 13 Jun 2025 01:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPx5X-00021v-NU; Fri, 13 Jun 2025 01:36:28 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPx5T-0004D9-VU; Fri, 13 Jun 2025 01:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749792985; x=1781328985;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=F58yUyairb8+CMgREp6Coq/wzpd2FVi+30joS8mftl8=;
 b=XK1xwbiAEWd6nZlA4nsrD0iEJQ9kIuqseuVQRlZGiMGTGaiopMNcyG5e
 RSvY1enkCLfYpN5mIXDHaiYguwA3oCuuJvZvcerQ7v2bBFWqq0Whmx9Wt
 CURVFBJhV/T2IgaVf6tU0pibd0eqHws+XEdn+EcIvfnJRPXRKnDwfZ4Yy
 jwqsbDrhmIFeXs3MvGjFvbluwwHF7CJB5avApjmQbNTK/k78QIF/BpVKN
 LMLKiznoO2H+NssWvFw7G4QS6lUBU7CK9gcMHgpdTID6JWE2Hc9MtbgrW
 W0Pbu7snQPOg5SWUFYpdeFs5L2KGqGXbrx9YfOf68dj5Th4zJLy0prjOh w==;
X-CSE-ConnectionGUID: h8qKNIvBQjGFCjDB7FE1dA==
X-CSE-MsgGUID: 3tf8Cp0CQFu/AIor0Qz5kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52133994"
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; d="scan'208";a="52133994"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 22:36:21 -0700
X-CSE-ConnectionGUID: 2GSdNUF/SquKEbRE23F0og==
X-CSE-MsgGUID: lXSyYJiMSwyjsIgYxkytjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,232,1744095600"; d="scan'208";a="147639452"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 12 Jun 2025 22:36:19 -0700
Date: Fri, 13 Jun 2025 13:57:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 qemu-rust@nongnu.org, armbru@redhat.com, mkletzan@redhat.com
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
Message-ID: <aEu90HVJsySBHJKz@intel.com>
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <aEk6vdosWZgyQGXD@intel.com>
 <CABgObfaK8h3GE4GWbPrn22JshYcCFdXsxWHWuAPVC4pRb7GZ0A@mail.gmail.com>
 <CABgObfa+w3pcYhFnO6ETxSfoNiNU=+_8WcW6dE8dkUrbt6darw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfa+w3pcYhFnO6ETxSfoNiNU=+_8WcW6dE8dkUrbt6darw@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 12, 2025 at 12:24:44PM +0200, Paolo Bonzini wrote:
> Date: Thu, 12 Jun 2025 12:24:44 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
> 
> On Wed, Jun 11, 2025 at 10:57 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Yes. If using serde the implementation of the traits is very small,
> > and basically the same for all types. If not using serde, it would
> > need some (or most) of the infrastructure in Marc-André's original
> > series.
> 
> Looking more at it, the Rust->QObject and QObject->Rust parts *can* be
> done with serde (following the model of serde_json's Value
> (de)serializer) but the Rust<->C part has a problem.
> 
> To recap, Rust->C is the serialization and corresponds to output
> visitors. C->Rust is the deserialization and corresponds to input
> visitors.
> 
> For serialization, serde has a push model where the generated code
> looks like this:
> 
>       let mut state =
>           Serializer::serialize_struct(serializer, "S", 2);
>       SerializeStruct::serialize_field(&mut state, "a", &self.a)?;
>       SerializeStruct::serialize_field(&mut state, "b", &self.b)?;
>       SerializeStruct::end(state)
> 
> whereas QAPI has a pull model where visit_type_* drives the process
> and requests the fields one by one.
> 
> For deserialization, serde has a pull model where the generated code
> asks for the field names one by one:
> 
>     fn visit_map<__A>(self, mut __map: __A)
>         while let Some(key) =
>             MapAccess::next_key::<__Field>(&mut __map)? {
>                 match __key { ... }
>         }
>     }
> 
> whereas QAPI has a push model where visit_type_* again drives the
> process and sends fields one by one.
> 
> For commands this is not a problem because the real underlying
> transformation is QObject->QObject and the intermediate steps (to and
> from QObject) can use serde.
> 
> However, QOM property getters/setters (especially, but not
> exclusively, for properties with compound types) remain a problem
> since these use callbacks with a Visitor* argument. I see three
> possibilities:
> 
> 1) everything is done through an intermediate QObject step (e.g. for a
> setter: Visitor->QObject with an input visitor, and QObject->Rust with
> serde deserialization).
>     + easy, Rust only sees serde
>     + QMP commands use a single conversion step
>     - inefficient

This sounds like a natural approach.

> 2) everything is done through an intermediate C step (e.g. for a
> setter: Visitor->C with a visit_type_* function, and C->Rust with
> generated code that does not need to use serde).

I understand this step indicates to use bindgen to generate visit_type_*
bindings...

> There is still a
> double conversion step, but it's more efficient than option 1
>     + one framework (visitor)
>     - double conversion for the QMP commands
>     - lots of generated code

...if so, then yes, there would be too much generated and "unsafe"
codes, and further abstraction may be needed to ensure safety, similar
to the lots of work currently done in the qemu-api.

> 3) generating a Rust visit_type_* implementation as well, either in
> qapi-gen (3a) or through a procedural macro (3b).> This should not be
> hard to write but it would remove a lot of the advantages from using
> serde.
>     + efficient
>     + preserves single conversion for QMP commands
>     - two frameworks

The difference between the two frameworks is that one is for C and the
other is for Rust, which increases the maintenance burden.

> I am leaning towards option 1, i.e. keep using serde but only cover
> conversions to and from QObject.

Based on my understanding of the three options above, I also think that
option 1 is the more appropriate approach.

> The reason is that one future usecase
> for Rust in QEMU is the UEFI variable store; that one also has some
> Rust<->JSON conversions and could be served by either QObject or
> serde_json. Either way, it'd be nice for the UEFI variable store to
> remain within the Rust serde ecosystem and allow sharing code between
> QEMU and Coconut SVSM. But I'm not so sure...

Thanks,
Zhao


