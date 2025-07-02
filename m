Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F92FC7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWu8y-0002QL-0f; Wed, 02 Jul 2025 05:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uWu8w-0002Pv-Ci
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uWu8q-0007PE-Lz
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751449952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVGCQRvjpcJ0EUym+BMRZADm7767a04CNXZRyCrLG1U=;
 b=VlpsWzRHR4fSrtKWnz9ByoFIv7cB+4n40agsKQC36XXSPAjtFo40F4P6lNQdvizfrZCqtD
 A7gj1F4aaUecZc9MCS1wf5cTcpwV45x+bNC70azC7B30+kv9pkEQyRnEEnre59lz4hurLE
 0gXda+A0YQ2wIz1+tAN/rNPLzhsai3g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-RbkRDh0mNbq2Ar3s8Uauag-1; Wed,
 02 Jul 2025 05:52:28 -0400
X-MC-Unique: RbkRDh0mNbq2Ar3s8Uauag-1
X-Mimecast-MFC-AGG-ID: RbkRDh0mNbq2Ar3s8Uauag_1751449947
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 753E7180120F; Wed,  2 Jul 2025 09:52:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.226.82])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0615A180045C; Wed,  2 Jul 2025 09:52:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9B1D4180039F; Wed, 02 Jul 2025 11:52:22 +0200 (CEST)
Date: Wed, 2 Jul 2025 11:52:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Eric Auger <eauger@redhat.com>, qemu-arm@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 2/2] hw/i386: Add the ramfb romfile compatibility
Message-ID: <etie67k64lfoaaqhuym5ayse6ejbwmdqrbm6n3ja5raqqsuupm@j5tev5gtzsqx>
References: <20250702085616.2172722-1-shahuang@redhat.com>
 <20250702085616.2172722-3-shahuang@redhat.com>
 <dec256c0-d0a5-49d7-b5ce-a025eaf27f8c@redhat.com>
 <36d469be-d9fd-48c9-8106-2db885e6fe39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d469be-d9fd-48c9-8106-2db885e6fe39@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 02, 2025 at 05:28:01PM +0800, Shaoqin Huang wrote:
> Hi Eric,
> 
> On 7/2/25 5:08 PM, Eric Auger wrote:
> > 
> > 
> > On 7/2/25 10:56 AM, Shaoqin Huang wrote:
> > > Set the "use-legacy-x86-rom" property to false by default, and only set
> > > it to true on x86 since only x86 will need it.
> > > 
> > > At the same time, set the "use-legacy-x86-rom" property to true on those
> > > historical versioned machine types in order to avoid the memory layout
> > > being changed.
> > > 
> > > Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> > > ---
> > >   hw/core/machine.c             |  2 ++
> > >   hw/display/ramfb-standalone.c |  2 +-
> > >   hw/i386/pc_piix.c             | 10 ++++++++++
> > >   hw/i386/pc_q35.c              |  3 +++
> > If I understood correctly, Gerd said we needed to set the prop to "true"
> > on microvm too? I don't see that change.
> 
> Yes, I try to do that. But I didn't see there are any machine type in the
> microvm like q35. I'm confuse about it, How should I do that?

Just add them to microvm_properties[]

take care,
  Gerd


