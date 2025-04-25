Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD5BC369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 07:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Das-000277-Qi; Fri, 25 Apr 2025 03:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u8Daq-00026l-3O
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u8Dan-0003Ex-M0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 03:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745566524;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=47yQX/tP944mV9CxlUSvSayRI6vi8x11887Tve8Kcrs=;
 b=a5vbHa7mhWUCMplfi0syZOnIpDqzoxdk+Hgt9D7zqhVVtBYmHP1nTOyUZxA7kBxIF0OGGr
 irjag04XtBOS2QS5bxAasN0c8w2hhmPrTLaIA/BPDNDuU96743jpFH3jLkNtU7N5MfHt8Z
 o78/9heBufUAn/DpGSxJk9dAGpydiJg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-5ek3zUPsPIusrVMzVqU27Q-1; Fri,
 25 Apr 2025 03:35:20 -0400
X-MC-Unique: 5ek3zUPsPIusrVMzVqU27Q-1
X-Mimecast-MFC-AGG-ID: 5ek3zUPsPIusrVMzVqU27Q_1745566518
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 831881955DCF; Fri, 25 Apr 2025 07:35:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A79F30001A2; Fri, 25 Apr 2025 07:35:14 +0000 (UTC)
Date: Fri, 25 Apr 2025 08:35:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 stefanha@redhat.com, Michael Roth <michael.roth@amd.com>,
 pbonzini@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Message-ID: <aAs6Q2GiBUbUCc2I@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Apr 24, 2025 at 11:33:47AM -0700, Pierrick Bouvier wrote:
> Feedback
> ========
> 
> The goal of this series is to be spark a conversation around following topics:
> 
> - Would you be open to such an approach? (expose all code, and restrict commands
>   registered at runtime only for specific targets)

QMP defines a public API between QEMU and external mgmt apps, and personally I
like the idea that the API exposed is identical across all binaries and thus
the API becomes independent of the impl choice of combined vs separate binaries,.

> - Are there unexpected consequences for libvirt or other consumers to expose
>   more definitions than what we have now?

QEMU used the selective hiding of commands in the QMP schema as a mechanism
to allow mgmt apps to probe for supported features. We need to check usage
of each QMP API feature that's behind a TARGET_* condition and identify
which libvirt uses as a feature probe, then come up with a strategy for how
best to handle each case in libvirt in future. We might need some additional
runtime mechanism to probe for certain things, but we won't know until we
look at things in more detail.

> - Would you recommend another approach instead? I experimented with having per
>   target generated files, but we still need to expose quite a lot in headers, so
>   my opinion is that it's much more complicated for zero benefit. As well, the
>   code size impact is more than negligible, so the simpler, the better.

IMHO it is unfortunate that the API we currently expose has a dependency on
a specific impl choice that mgmt apps are expected to rely on for feature
probing. An ideal API design is not so closely coupled to impl choice
(separate vs combined binaries), and would expose enough functionality
such that mgmt apps continue to work regardless of the impl choices.

We thought the conditionals were a good thing when we first designed QMP
this way. We ended up using two distinct classes of conditionals, one
reflecting build time features and one reflecting which target binary is
used. I don't think we fully contemplated the implications that the latter
set of conditionals would have on our ability to change our impl approach
in future. I think the proposal here is taking us in a good direction
given what we now know.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


