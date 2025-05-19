Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3894EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 09:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGwaP-0008Ar-9I; Mon, 19 May 2025 05:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGwaM-00088s-15
 for qemu-devel@nongnu.org; Mon, 19 May 2025 05:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGwaH-00057I-TJ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 05:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747646095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2C4KdJi1QF3Niatz+kL4tJmLMrQDtvaT3SUuilt7ds=;
 b=a4++8kFCDMe0X5UtPNQsOH3cTIved2Jooo5l07Xq0r485QkIf4zkR0iKTiQhLquX+M41nZ
 hsvZHpQczFpssWpHdxncm8aeXG5dsXT+Qc6sHI0jO/v7IeclTRby+TtwZ4CQ6obCltX4iO
 ebaChDWh3NI9K8jw8bN7atFS66SMBjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-rYjiZHHGPaGRTfMeyEU9_A-1; Mon,
 19 May 2025 05:14:50 -0400
X-MC-Unique: rYjiZHHGPaGRTfMeyEU9_A-1
X-Mimecast-MFC-AGG-ID: rYjiZHHGPaGRTfMeyEU9_A_1747646089
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2912B1800373; Mon, 19 May 2025 09:14:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B28EC1956096; Mon, 19 May 2025 09:14:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4815921E66C3; Mon, 19 May 2025 11:14:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  berrange@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 12/12] qapi: make all generated files common
In-Reply-To: <20250515172732.3992504-13-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 May 2025 10:27:32 -0700")
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-13-pierrick.bouvier@linaro.org>
Date: Mon, 19 May 2025 11:14:46 +0200
Message-ID: <8734d1hshl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 7582c2b5bcf..6cc3afce721 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -140,6 +140,6 @@ foreach output : qapi_nonmodule_outputs
>    if output.endswith('.trace-events')
>      qapi_trace_events +=3D qapi_files[i]
>    endif
> -  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
> +  system_ss.add(if_true: qapi_files[i])
>    i =3D i + 1
>  endforeach

I think this can be simplified further:

diff --git a/qapi/meson.build b/qapi/meson.build
index 6cc3afce72..3b035aea33 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -85,8 +85,7 @@ qapi_nonmodule_outputs =3D [
   'qapi-emit-events.c', 'qapi-emit-events.h',
 ]
=20
-# First build all sources
-qapi_util_outputs =3D [
+qapi_outputs =3D qapi_nonmodule_outputs + [
   'qapi-builtin-types.c', 'qapi-builtin-visit.c',
   'qapi-builtin-types.h', 'qapi-builtin-visit.h',
 ]
@@ -109,20 +108,17 @@ foreach module : qapi_all_modules
       'qapi-commands-@0@.trace-events'.format(module),
     ]
   endif
-  qapi_util_outputs +=3D qapi_module_outputs
+  qapi_outputs +=3D qapi_module_outputs
 endforeach
=20
 qapi_files =3D custom_target('shared QAPI source files',
-  output: qapi_util_outputs + qapi_nonmodule_outputs,
+  output: qapi_outputs,
   input: [ files('qapi-schema.json') ],
   command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
   depend_files: [ qapi_inputs, qapi_gen_depends ])
=20
-# Now go through all the outputs and add them to the right sourceset.
-# These loops must be synchronized with the output of the above custom tar=
get.
-
 i =3D 0
-foreach output : qapi_util_outputs
+foreach output : qapi_outputs
   if output.endswith('.h')
     genh +=3D qapi_files[i]
   endif
@@ -132,14 +128,3 @@ foreach output : qapi_util_outputs
   util_ss.add(qapi_files[i])
   i =3D i + 1
 endforeach
-
-foreach output : qapi_nonmodule_outputs
-  if output.endswith('.h')
-    genh +=3D qapi_files[i]
-  endif
-  if output.endswith('.trace-events')
-    qapi_trace_events +=3D qapi_files[i]
-  endif
-  system_ss.add(if_true: qapi_files[i])
-  i =3D i + 1
-endforeach


