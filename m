Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8013CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 09:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut0ar-0005iK-AT; Mon, 01 Sep 2025 05:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ut0X2-0002sA-V6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ut0Wu-0007Ap-Ge
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756717720;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HgpYc71PQfl4nfQlGnVqXiwDo61Jcd9jk0uU5SIwJ/A=;
 b=D9GazeDF752fiJP2v/c5UPIkVasLcPd/x5h+505m7BPzJauf6pCyqVGDsVjvN3lQizJdpm
 uWEBc7U9VEP7j+WICHIhj2AxJHBvdfEa4rxjPin+3boVL6IhXClctxqXTQNth9Stc6svZU
 Db7zNXP9NMAnOhwjMryA2bf09urTlrY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-TGSxVHrPMzmei2BBgVqs-A-1; Mon,
 01 Sep 2025 05:08:39 -0400
X-MC-Unique: TGSxVHrPMzmei2BBgVqs-A-1
X-Mimecast-MFC-AGG-ID: TGSxVHrPMzmei2BBgVqs-A_1756717718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E1AF18002A8; Mon,  1 Sep 2025 09:08:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EF111955E89; Mon,  1 Sep 2025 09:08:34 +0000 (UTC)
Date: Mon, 1 Sep 2025 10:08:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 pbonzini@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH] smbios: cap DIMM size to 2Tb as workaround for broken
 Windows
Message-ID: <aLVijyqK4pPocGH8@redhat.com>
References: <20250901084915.2607632-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901084915.2607632-1-imammedo@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 01, 2025 at 10:49:15AM +0200, Igor Mammedov wrote:
> With current limit set to match max spec size (2PTb),
> Windows fails to parse type 17 records when DIMM size reaches 4Tb+.
> Failure happens in GetPhysicallyInstalledSystemMemory() function,
> and fails "Check SMBIOS System Memory Tables" SVVP test.
> Though not fatal, it might cause issues for userspace apps,
> something like [1].
> 
> Lets cap default DIMM size to 2Tb for now, until MS fixes it.
> 
> 1) https://issues.redhat.com/browse/RHEL-81999?focusedId=27731200&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-27731200

Why link to a comment that refers to a link to Adobe photoshop
and doesn't mention KVM ???

Also should have:

Fixes: 62f182c97b31445012d37181005a83ff8453edaa

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS: It's obvious 32 int overflow math somewhere in Windows,
>     MS admitted that it's Windows bug and in a process of fixing it.
>     However it's unclear if W10 and earlier would get the fix.
>     So however I dislike changing defaults, we heed to work around
>     the issue (it looks like QEMU regression while not being it).
>     Hopefully 2Tb/DIMM split will last longer until VM memory size
>     will become large enough to cause to many type 17 records issue
>     again.
> PS2:
>     Alternatively, instead of messing with defaults, I can create
>     a dedicated knob to ask for desired DIMM size cap explicitly
>     on CLI. That will let users to enable workaround when they
>     hit this corner case. Downside is that knob has to be propagated
>     up all mgmt stack, which might be not desirable.


How many type 17 records can we get before hitting the the
Linux limits which was the motiviation for the previous
fix 62f182c97b31445012d37181005a83ff8453edaa ?

ie, with this 2 TB dimm size, what is our effective maximum
RAM size ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


