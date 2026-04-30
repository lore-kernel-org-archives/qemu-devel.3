Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14B2CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILa7-00054F-Ma; Thu, 30 Apr 2026 03:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wILa6-00053r-1a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wILa4-000896-I4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777533182;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=c/tw+9Eqi6d9lbQRH7vlzkki2m4ZK89cLoQe2J20B7M=;
 b=TFzqG6e21hP9/9lGLcTNU6gf41ZUObf+3TKjiNDgj8R2bcUweljMn4Fz/LAG39kfATagnQ
 HLGTTI5rSqYObTHpl/v7J2xrLMhtt6b28J7e3HU97O6/t3NOxLyeaoz7fg6vddDqGM9qDa
 +FN5yVS4foQDazytzEX8I36Is4tY7UU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-EBvcFiVmNma3TTvPqtczpw-1; Thu,
 30 Apr 2026 03:12:59 -0400
X-MC-Unique: EBvcFiVmNma3TTvPqtczpw-1
X-Mimecast-MFC-AGG-ID: EBvcFiVmNma3TTvPqtczpw_1777533178
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D5821956056; Thu, 30 Apr 2026 07:12:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.62])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA56C1800446; Thu, 30 Apr 2026 07:12:52 +0000 (UTC)
Date: Thu, 30 Apr 2026 08:12:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 3/7] qom/object: register OBJECT and INTERFACE QOM
 types before main
Message-ID: <afMA8SCcF9XJ8VUe@redhat.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-4-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430035626.3511676-4-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 29, 2026 at 08:56:22PM -0700, Pierrick Bouvier wrote:
> Those types are special, as they are the base of all other QOM types. In
> next commit, we'll introduce an extra step in module initialization for
> target-info-* types.
> 
> However, those types depend on TYPE_OBJECT, which is only registered
> at MODULE_INIT_QOM step.
> 
> To avoid having to introduce another step, and modify all code calling
> module_call_init(MODULE_INIT_QOM), we simply register those base types
> directly in the static constructor, before anything else.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  qom/object.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/qom/object.c b/qom/object.c
> index f981e270440..a5d268d0722 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
>                                    NULL);
>  }
>  
> -static void register_types(void)
> +static void __attribute__((constructor)) register_types(void)
>  {
>      static const TypeInfo interface_info = {
>          .name = TYPE_INTERFACE,
> @@ -2857,5 +2857,3 @@ static void register_types(void)
>      type_interface = type_register_internal(&interface_info);
>      type_register_internal(&object_info);
>  }
> -
> -type_init(register_types)

IMHO this should have been done using the MODULE_INIT_QOM_EARLY
approach that I suggested on v1, rather than special casing both
the base classes and MODULE_INIT_TARGET_INFO

With regards,
Daniel


