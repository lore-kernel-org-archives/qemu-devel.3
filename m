Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1F4FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIUrG-0001F4-ME; Thu, 30 Apr 2026 13:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIUrE-0001Dk-KC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wIUrA-00082t-Vz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777568838;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neqj4Fgl2AnLiL3xT3MAZ7r0NKcfxOW0iMB97X1Jk+Y=;
 b=MKvG0q7icm8JAvlxNv8UNV0JhFtFGWMFabonx6HjUV1MRA07L5a7zUDqKrygru7UV83RG6
 SLGkTVDvlS56NUy3pdnGw9y7SEfiewqPlKhIyMfZro2rUaTnCXZACS8JcfgwDGhyHhHGZ7
 6yKc1K5dKBHfWCJlltUmEShsO4kV0Qk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-lCVHPJLUPU-Ira2B64bjjg-1; Thu,
 30 Apr 2026 13:07:14 -0400
X-MC-Unique: lCVHPJLUPU-Ira2B64bjjg-1
X-Mimecast-MFC-AGG-ID: lCVHPJLUPU-Ira2B64bjjg_1777568833
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DDEE19560B7; Thu, 30 Apr 2026 17:07:13 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.62])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74A2C300019F; Thu, 30 Apr 2026 17:07:09 +0000 (UTC)
Date: Thu, 30 Apr 2026 18:07:05 +0100
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
Message-ID: <afOMOcbpEnjzfyj6@redhat.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-4-pierrick.bouvier@oss.qualcomm.com>
 <afMA8SCcF9XJ8VUe@redhat.com>
 <d95d58da-764d-4967-ae93-2cb7418d8c5d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d95d58da-764d-4967-ae93-2cb7418d8c5d@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 30, 2026 at 09:03:52AM -0700, Pierrick Bouvier wrote:
> On 4/30/2026 12:12 AM, Daniel P. Berrangé wrote:
> > On Wed, Apr 29, 2026 at 08:56:22PM -0700, Pierrick Bouvier wrote:
> >> Those types are special, as they are the base of all other QOM types. In
> >> next commit, we'll introduce an extra step in module initialization for
> >> target-info-* types.
> >>
> >> However, those types depend on TYPE_OBJECT, which is only registered
> >> at MODULE_INIT_QOM step.
> >>
> >> To avoid having to introduce another step, and modify all code calling
> >> module_call_init(MODULE_INIT_QOM), we simply register those base types
> >> directly in the static constructor, before anything else.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  qom/object.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/qom/object.c b/qom/object.c
> >> index f981e270440..a5d268d0722 100644
> >> --- a/qom/object.c
> >> +++ b/qom/object.c
> >> @@ -2839,7 +2839,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
> >>                                    NULL);
> >>  }
> >>  
> >> -static void register_types(void)
> >> +static void __attribute__((constructor)) register_types(void)
> >>  {
> >>      static const TypeInfo interface_info = {
> >>          .name = TYPE_INTERFACE,
> >> @@ -2857,5 +2857,3 @@ static void register_types(void)
> >>      type_interface = type_register_internal(&interface_info);
> >>      type_register_internal(&object_info);
> >>  }
> >> -
> >> -type_init(register_types)
> > 
> > IMHO this should have been done using the MODULE_INIT_QOM_EARLY
> > approach that I suggested on v1, rather than special casing both
> > the base classes and MODULE_INIT_TARGET_INFO
> >
> 
> I'm ok to follow your approach if you really prefer it.
> However, can you specify what should be the semantic to put in comment
> for it? I have trouble finding to explain what is early vs non early,
> while it's clear for me what is TARGET_INFO vs REST_OF_QOM.

I don't think we need to set our strong rules. It is just an early
startup hook to be used by classes which are a dependency of other
initialization code.  Conceptually this is similar to what we did
in system/vl.c, where we have various stages for creating -object
args. What goes in each stage is simply determined by a functional
need at the point in time.

> As well, adding a INIT_QOM_EARLY implies we need to call it in all
> locations where we already call INIT_QOM for future-proofing, which
> seems very redundant. Should we had it or not?

Yep, that's true, but not the end of the world imho.

Ultimately an solution is a bit of a hack. Long term what we need
to do is follow glib's approach from GType and have "just in time"
initialization on first use which will make everything "just work"
without having to think about ordering. I didn't want to suggest
that now though, as it has potential to be a can of worms.


