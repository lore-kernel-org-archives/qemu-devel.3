Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446FAC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2Qe-0004uL-Cu; Thu, 08 May 2025 10:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD2Qa-0004rU-Gj
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD2QY-0004uo-50
 for qemu-devel@nongnu.org; Thu, 08 May 2025 10:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746715242;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4xpNQXdVJ65r07S4WqAkf2rl1SNCrsHH+0zBg/lpj04=;
 b=ZbI1JkwliB2g8ryb4WQLucVPJbiSE85WbWcm3TA/7Su+qKvoViqAsbqTBiOFcorGrrJtSI
 GXsmi59i+15KFnB0Qv0MX96oVYC3TMJapWcNr3EBzlZbXUeFxMFIAGWkbs9nkmstCJ8L6u
 MP/xTJIy0I1q5q42QWN7n47slJYD7/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-I4wBilnYMMOFRGEOVPXT5Q-1; Thu,
 08 May 2025 10:40:37 -0400
X-MC-Unique: I4wBilnYMMOFRGEOVPXT5Q-1
X-Mimecast-MFC-AGG-ID: I4wBilnYMMOFRGEOVPXT5Q_1746715236
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19ACE18001D5; Thu,  8 May 2025 14:40:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4D7F1955F24; Thu,  8 May 2025 14:40:31 +0000 (UTC)
Date: Thu, 8 May 2025 15:40:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 richard.henderson@linaro.org, pbonzini@redhat.com, jsnow@redhat.com,
 philmd@linaro.org, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
Message-ID: <aBzCXNTebh8B5sQ_@redhat.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507231442.879619-10-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Wed, May 07, 2025 at 04:14:39PM -0700, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/machine-target.json | 84 ++++++++++++++++++++++++----------------
>  qapi/misc-target.json    | 48 ++++++++++++-----------
>  scripts/qapi/expr.py     |  9 +++--
>  3 files changed, 81 insertions(+), 60 deletions(-)
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 541f93eeb78..6174b7291ca 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -96,7 +96,7 @@
>  ##
>  { 'struct': 'CpuModelBaselineInfo',
>    'data': { 'model': 'CpuModelInfo' },
> -  'if': 'TARGET_S390X' }
> +  'runtime_if': 'target_s390x()' }

The existing 'if' conditions are already slightly uncomfortable
for QAPI when considering alternate code generators, because the
definition of what  "CONFIG_xxx" or "TARGET_xxx" condition means,
is essentially known only to our build system. While we expose
the conditions in the docs, the meaning of those conditions is
totally opaque to anyone reading the docs. Essentially our QAPI
schema ceased to be self-documenting/self-describing when we
introduced the 'if' conditions :-(


In retrospect, IMHO, for 'if' conditions we probably should have
created some kind of built-in QAPI concept of feature flag constants
with well defined & documented meaning. 

eg hypothetically

  ##
  # @target-s390x
  #
  # Whether this is an s390x emulator target
  { 'constant': 'target-s390x' }

  ##
  # @accel-kvm
  #
  # Whether the KVM accelerator is built
  { 'constant': 'accel-kvm' }

Then our 'if' conditions would have only been permitted to
reference defined 'constant'.

  { 'struct': 'CpuModelCompareInfo',
    'data': { 'result': 'CpuModelCompareResult',
              'responsible-properties': ['str'] },
    'if': 'target-s390x' }

The build system would need generate an input document for the
QAPI visitor that defines whether each constant is set to true
or false, based on suitable CONFIG/TARGET conditions from meson.

With this QAPI schemas would have remained fully self-contained.

Anyway, this is a long way of saying that having 'runtime_if'
conditions directly referencing the names of internal C
functions makes me even more uncomfortable than I already am
with the 'if' conditions.

The meaning of the QAPI schema now varies based on both the build
system, and an arbitrary amount of C, and is thus (conceptually)
even more opaque, even if you could infer some meaning from the
'target_s390x()' function name you've used. I think this is a very
undesirable characteristic for what is our public API definition.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


