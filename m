Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99714C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdTN-0004kn-2F; Mon, 10 Mar 2025 09:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trdT2-0004fk-Mw
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trdT0-0001X9-4g
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741614409;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmpFkju+1pru3ICxY37dk/oO0z9jafjpp4slU7xenJA=;
 b=UvN+H/yVTo4FYvji2RHRWz9DXQAa9q/MGlVyMm5WmHb0xhtvoz5Qu4k9KR3l6Mde0u8xbJ
 BveRyGCq+2cpJ3aCXVISCKSXcQs+3sKDfPxZDS9W+LMDpHs1+GKtuSYNfQG3JRUcFADL1R
 hde2/W5M39XowfpfAtTVulLemyofuGY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-M3Vp4FyNPKGTOuJItaH-uw-1; Mon,
 10 Mar 2025 09:46:45 -0400
X-MC-Unique: M3Vp4FyNPKGTOuJItaH-uw-1
X-Mimecast-MFC-AGG-ID: M3Vp4FyNPKGTOuJItaH-uw_1741614401
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 089DB19560B2; Mon, 10 Mar 2025 13:46:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF4E01956048; Mon, 10 Mar 2025 13:46:34 +0000 (UTC)
Date: Mon, 10 Mar 2025 13:46:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH v2 3/3] qapi/machine: Make @dump-skeys command generic
Message-ID: <Z87tNx36KNd5dCe9@redhat.com>
References: <20250310133118.3881-1-philmd@linaro.org>
 <20250310133118.3881-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310133118.3881-4-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 10, 2025 at 02:31:18PM +0100, Philippe Mathieu-Daudé wrote:
> Reduce misc-target.json by one target specific command.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  qapi/machine.json          | 18 ++++++++++++++++++
>  qapi/misc-target.json      | 19 -------------------
>  hw/core/machine-qmp-cmds.c | 13 +++++++++++++
>  hw/s390x/s390-skeys.c      |  6 +-----
>  4 files changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09e..53680bf0998 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1898,3 +1898,21 @@
>  { 'command': 'x-query-interrupt-controllers',
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ]}
> +
> +##
> +# @dump-skeys:
> +#
> +# Dump guest's storage keys
> +#
> +# @filename: the path to the file to dump to
> +#
> +# Since: 2.5
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "dump-skeys",
> +#          "arguments": { "filename": "/tmp/skeys" } }
> +#     <- { "return": {} }
> +##

Currently the 'if: TARGET_S390X' ends up in the documentation
so users can see it is s390x-onl:

 https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-2890

Given there's no more conditional, the docs will loose this target
info, which could be considered a regression. We could tweak the
docs text to call this out:

 ##
 # @dump-skeys:
 #
 # Dump the storage keys for an s390x guest
 #




With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


