Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983B7C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwjZg-0004iX-7D; Tue, 16 Apr 2024 10:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwjZc-0004i9-6z
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwjZa-0005Xp-Cx
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713276848;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vTfY+ty4nwNxKXecpSglhqjGE9Md6CDnFq+SzqH+5kI=;
 b=Pfjw2qmUU1xfojjHIQ3x4rtQzSnGJan7JAo34m92EgRRxEIQpbPvs0N9GHVuXj1a4P+FY6
 VPPL5ixJmqANyyeX0CBzlsEj8tXd0QErDSl8wMUfnG5xJXHfCMKHRsHsqL505sk/DdkPKk
 A88Gi9xVzU9xeo5H52PysjzjQxXu2Eo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-s04pzW6WNl-tCxf1xk85AA-1; Tue,
 16 Apr 2024 10:14:04 -0400
X-MC-Unique: s04pzW6WNl-tCxf1xk85AA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51D41382C46B;
 Tue, 16 Apr 2024 14:14:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F0CC40C6CB2;
 Tue, 16 Apr 2024 14:14:00 +0000 (UTC)
Date: Tue, 16 Apr 2024 15:13:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v2 01/10] meson: Add optional dependency on IGVM library
Message-ID: <Zh6HkspE45lh8Dvu@redhat.com>
References: <cover.1712141833.git.roy.hopkins@suse.com>
 <0da76c3956bf776a9bbb0e18a1813b8dc5e20bf8.1712141833.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0da76c3956bf776a9bbb0e18a1813b8dc5e20bf8.1712141833.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 03, 2024 at 12:11:32PM +0100, Roy Hopkins wrote:
> The IGVM library allows Independent Guest Virtual Machine files to be
> parsed and processed. IGVM files are used to configure guest memory
> layout, initial processor state and other configuration pertaining to
> secure virtual machines.

Looking at the generated header file for the IGVM library, I see
some quite bad namespace pollution. eg igvm_defs.h has:

typedef uint64_t u64_le;
typedef uint32_t u32_le;

#define UINT32_FLAGS_VALUE(x) *((uint32_t*)&(x))

#define MAKE_INVALID_IMPL(x, y) x##y
#define MAKE_INVALID(x, y) MAKE_INVALID_IMPL(x, y)
#define INVALID MAKE_INVALID(INVALID_, __COUNTER__)

enum IgvmPageDataType {
  NORMAL = 0,
  SECRETS = 1,
  CPUID_DATA = 2,
  CPUID_XF = 3,
};

enum IgvmPlatformType {
  NATIVE = 0,
  VSM_ISOLATION = 1,
  SEV_SNP = 2,
  TDX = 3,
};



enum IgvmVariableHeaderType {
  INVALID = 0,
  ...
}

There are soo many more examples in igvm_defs.h that I won't
list them all here.


These are all way too generic as names to be exposing in library
header file. We may be lucky right now that these definitions
don't clash with anything else defined in the compilation namespace
of the consuming application, but that's a bad bet to make long
term.

IMHO this really needs fixing before there's any use of this igvm
library, since fixing it will be a backwards-incompatible change.

Essentially everything in the header needs to have an 'IGVM/Igvm/igvm'
prefix on it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


