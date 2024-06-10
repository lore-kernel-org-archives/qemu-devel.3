Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBA2C27C5F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGaxQ-0005yu-Jp; Mon, 10 Jun 2024 05:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGaxP-0005yl-6x
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGaxN-0008VY-JZ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 05:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718010288;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mKuuchVZsjLeG9DtMQTKrCEpEL90mBaYcfrj/ftlYM0=;
 b=HZMrTLXJKaB3Hs5GW/0+UEvsSipOd97LBUAx6jOOju9KwnR5HjLhveO+v6fdijet7xRrCg
 UpYwmTD8htd9emmfWZAUtC1QQA5lae/2YyxjMeFEWFNTfBAvECaYcWm4pYPexr40NGGuUq
 /HNnesn8vdcOSRM408nDYtY736hE3fM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-aIM_YCDRO4mIFdOFuQZfSQ-1; Mon,
 10 Jun 2024 05:04:46 -0400
X-MC-Unique: aIM_YCDRO4mIFdOFuQZfSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A46D53806708;
 Mon, 10 Jun 2024 09:04:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 909832166B33;
 Mon, 10 Jun 2024 09:04:44 +0000 (UTC)
Date: Mon, 10 Jun 2024 10:04:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] tests/qtest/x86: check for availability of older
 cpu models before running tests
Message-ID: <ZmbBqouWxvIS8hDZ@redhat.com>
References: <20240606044419.8806-1-anisinha@redhat.com>
 <20240606044419.8806-4-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606044419.8806-4-anisinha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 06, 2024 at 10:14:19AM +0530, Ani Sinha wrote:
> It is better to check if some older cpu models like 486, athlon, pentium,
> penryn, phenom, core2duo etc are available before running their corresponding
> tests. Some downstream distributions may no longer support these older cpu
> models.
> 
> Signature of add_feature_test() has been modified to return void as
> FeatureTestArgs* was not used by the caller.
> 
> One minor correction. Replaced 'phenom' with '486' in the test
> 'x86/cpuid/auto-level/phenom/arat' matching the cpu used.
> 
> CC: thuth@redhat.com
> CC: imammedo@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/test-x86-cpuid-compat.c | 170 ++++++++++++++++++----------
>  1 file changed, 108 insertions(+), 62 deletions(-)
> 
> changelog:
> v2: reworked as per suggestion from danpb.
> v3: reworked as_feature_test() same way as add_cpuid_test()
> 

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


