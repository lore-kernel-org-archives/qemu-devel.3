Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF710D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvtR-0004ZC-P7; Tue, 26 Nov 2024 08:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFvtR-0004Yw-2q
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tFvtO-0002IH-Vc
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732628773;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZJTlDIDAnLLiWxccqjWOmK1Gni8JZ4CGXNJVthvIHfw=;
 b=TaS+gZrJDNjo4dsBKE/kkcbFSRyEIJ3NqdHgTt+/pEuPpDFgnRSVbgIP9fyW/heJC6dyV9
 ELzWyHJIrW8H2GJfd4Dqym3IAbR38XPLyNYRbJR/eYaN6zlangp6WkjiEIB71qWqK0AbaE
 VoXr2LEYsmujnmHDx3Egj+CuSpI94ww=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-Cq5oK5N1NiSUkG1mG0Chsg-1; Tue,
 26 Nov 2024 08:46:06 -0500
X-MC-Unique: Cq5oK5N1NiSUkG1mG0Chsg-1
X-Mimecast-MFC-AGG-ID: Cq5oK5N1NiSUkG1mG0Chsg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54BA319560B4; Tue, 26 Nov 2024 13:46:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8E9B1944CC9; Tue, 26 Nov 2024 13:45:58 +0000 (UTC)
Date: Tue, 26 Nov 2024 13:45:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
Message-ID: <Z0XREyMovNyB4s6t@redhat.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
 <02b90518-2996-4231-bee9-43ce313669b0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02b90518-2996-4231-bee9-43ce313669b0@linux.ibm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 25, 2024 at 05:23:44PM -0500, Stefan Berger wrote:
> 
> 
> On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
> > Create an event log, in the format defined by Trusted Computing Group
> > for TPM2. It contains information about the VMM, the Realm parameters,
> > any data loaded into guest memory before boot and the initial vCPU
> > state.
> > 
> > The guest can access this log from RAM and send it to a verifier, to
> > help the verifier independently compute the Realm Initial Measurement,
> > and check that the data we load into guest RAM is known-good images.
> > Without this log, the verifier has to guess where everything is loaded>
> and in what order.
> 
> Typically these logs are backed by extensions of TPM PCRs and when you send
> a log to a verifier you send a TPM quote along with it for the verifer to
> replay the log and check the TPM quote. Also, early code in the firmware is
> typically serving as a root of trust that starts the chain of measurements
> of code and data, first measuring itself and then other parts of the
> firmware before it jumps into the other parts. Now here you seem to just
> have a log and no PCR extensions and therefore no quote over PCRs can be
> used. Then what prevents anyone from faking this log and presenting a
> completely fake log to the verifier?

In addition, a measurement log is just one of the interesting features
that a TPM provides to OS. The other TPM features are still relevant
and useful to confidential VMs.

As a high level goal I think we should be aiming to make it possible for
users to move their existing VM workloads from non-confidentail to
confidential environments, simply as a choice at deployment time. To make
this as practical as possible, confidential VMs  need to be aiming to
match non-confidential VM features where ever it is practical to do so.
Users & vendors should not need to build & carry around 2 sets of disk
images - one setup for confidential and one setup for non-confidential.
Following existing standards will reduce the work both for OS developers,
app developers and users alike, to adopt the CVM world.

IOW, this is a long winded way of saying that we should be looking to
provide a complete *standards compliant*, trusted TPM implementation to
confidential VMs, not providing a cherry-picked selection of a few
TPM-like features.

On the x86 side of things, the route to providing a trusted TPM is via
SVSM, both for SNP and TDX. Microsoft's recently open sources openhcl
similarly provides a st

I don't know so much about RME. Is providing a trusted TPM a job for
the RMM ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


