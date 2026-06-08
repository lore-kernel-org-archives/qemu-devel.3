Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D27ACD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWYK0-0005B3-2p; Mon, 08 Jun 2026 07:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWYJw-0005AV-FO
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWYJt-0006YZ-Fv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780918743;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7U8ggQahttMFndg7bBnoA6ZA81bWpOUflLpAgHxqM4=;
 b=eELdQCR6oP7Sqhw9BozbrMWcKPfr8xresoqkKPFECddgJk2ygk5FVL67wPKtuel2Y2UGGZ
 mAhm02aDHZZxLBBweHHO0Epo0ra2QFUk9C7pbFmxDpUw/NHSKeZCrMIv2HsSZLAXqQpKeW
 4b72oLbVMNBC6znIlEkCMZwd8bQ282A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-iwXai69yPte3MtlYnicYCw-1; Mon,
 08 Jun 2026 07:39:00 -0400
X-MC-Unique: iwXai69yPte3MtlYnicYCw-1
X-Mimecast-MFC-AGG-ID: iwXai69yPte3MtlYnicYCw_1780918739
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4992195609F; Mon,  8 Jun 2026 11:38:58 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.219])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51E24765; Mon,  8 Jun 2026 11:38:55 +0000 (UTC)
Date: Mon, 8 Jun 2026 12:38:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jugraham@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <aiapywnJY64G7nUK@redhat.com>
References: <20260608001821.850921-1-gshan@redhat.com>
 <aiaDgG26a6TUrKuM@redhat.com>
 <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07ca74b4-52a8-4187-a57c-7c3277e574d3@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jun 08, 2026 at 09:11:50PM +1000, Gavin Shan wrote:
> Hi Daniel,
> 
> On 6/8/26 6:55 PM, Daniel P. Berrangé wrote:
> > On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
> > > On the guest where a NVidia's GH100 card is passed from the host, the
> > > guest system hang can be observed on attempt to compile 'cuda-samples',
> > > as reported by Julia.
> > 
> > snip
> > 
> 
> Thanks for looking into this.

NB, I didn't really look into it beyond noticing the suggestion
that users set an "x-" property as a proposed solution to failing
to boot, which raised a red-flag to me from a usability POV.

I don't really know anything about the underlying technical problems
here, so can't offer specific guidance in that area.

> 
> > > By default, the max bounce buffer size is only 4096 bytes, even less
> > > than one page when the guest page is 64KB. This tries to fix the issue
> > > by inheriting the customized max bounce buffer size of the virtio bus's
> > > parent through property 'x-max-bounce-buffer-size' when the customized
> > > size is a larger one. With this applied, no guest system hang is seen
> > > with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
> > 
> > "x-max-bounce-buffer-size"  is an experimental / unsupported property.
> > 
> > We really shouldn't be expecting users to have to set this in a production
> > deployment in order to stop a guest from hanging.  Even if we dropped the
> > experimental marker from this property, users would still need to know to
> > provide this magic setting, so it would still be broken out of the box.
> > 
> > How can we  get a solution that "just works" out of the box, which is
> > fully supported, not relying on experimental properties ?
> > 
> 
> How do we know that "x-max-bounce-buffer-size" is an experimental or unsupported
> property? I guess the properties whose names start with "x-" are all treated as
> experimental and unsupported?

Yes, any QEMU property starting with 'x-' is experimental/unstable/
unsupported and can be changed/withdrawn at any time.  Libvirt will
not provide any way to configure 'x-' properties, as it requires a
supported/stable solution from QEMU.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


