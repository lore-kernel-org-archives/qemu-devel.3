Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C71C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 14:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWdKB-0002tR-IV; Wed, 24 Jul 2024 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWdK7-0002rp-E2
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 10:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWdK4-0004Wm-7H
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 10:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721832630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVJlYM0dAOiQL4SSBRggroK5dF7Qw47Kb5QaAZOFNJM=;
 b=UOy79R/16MvSObwgjuGUcHrt69Wx7/JjmGbJXcAwRSenoWGT9XBV80gSx7+kSAZ2R3Biyy
 44Dpr32flOmix6d0nPTQcv/O5pPqrorbPpxAJnuyfpsFf2SF1JoLnX8L9XHlxx8FJnHSHT
 psyZa0hRA47iswHLhDKhMB/EFqbVWFQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-atkXcDW5M9ijkkRDexlDtA-1; Wed,
 24 Jul 2024 10:50:26 -0400
X-MC-Unique: atkXcDW5M9ijkkRDexlDtA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C9691955D4A; Wed, 24 Jul 2024 14:50:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 797761955F40; Wed, 24 Jul 2024 14:50:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1186321E6757; Wed, 24 Jul 2024 16:50:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Yichen Wang <yichen.wang@bytedance.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org,  Hao Xiang <hao.xiang@linux.dev>,  "Liu, Yuan1"
 <yuan1.liu@intel.com>,  Shivam Kumar <shivam.kumar1@nutanix.com>,  "Ho-Ren
 (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v5 08/13] migration/multifd: Add new migration option
 for multifd DSA offloading.
In-Reply-To: <87y1603n21.fsf@suse.de> (Fabiano Rosas's message of "Tue, 16 Jul
 2024 21:00:06 -0300")
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711215244.19237-9-yichen.wang@bytedance.com>
 <CAHObMVZ1rifLMe-6R_Lttu_aOWDPvqv29sa6p_gz_7HROn00Tg@mail.gmail.com>
 <87y1603n21.fsf@suse.de>
Date: Wed, 24 Jul 2024 16:50:21 +0200
Message-ID: <87ed7iyhci.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> Yichen Wang <yichen.wang@bytedance.com> writes:
>
>> On Thu, Jul 11, 2024 at 2:53=E2=80=AFPM Yichen Wang <yichen.wang@bytedan=
ce.com> wrote:
>>
>>> diff --git a/migration/options.c b/migration/options.c
>>> index 645f55003d..f839493016 100644
>>> --- a/migration/options.c
>>> +++ b/migration/options.c
>>> @@ -29,6 +29,7 @@
>>>  #include "ram.h"
>>>  #include "options.h"
>>>  #include "sysemu/kvm.h"
>>> +#include <cpuid.h>
>>>
>>>  /* Maximum migrate downtime set to 2000 seconds */
>>>  #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
>>> @@ -162,6 +163,10 @@ Property migration_properties[] =3D {
>>>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationSt=
ate,
>>>                         parameters.zero_page_detection,
>>>                         ZERO_PAGE_DETECTION_MULTIFD),
>>> +    /* DEFINE_PROP_ARRAY("dsa-accel-path", MigrationState, x, */
>>> +    /*                    parameters.dsa_accel_path, qdev_prop_string,=
 char *), */
>
> This is mostly correct, I think, you just need to create a field in
> MigrationState to keep the length (instead of x). However, I found out
> just now that this only works with QMP. Let me ask for other's
> opinions...
>
>>> +    /* DEFINE_PROP_STRING("dsa-accel-path", MigrationState, */
>>> +    /*                    parameters.dsa_accel_path), */
>>>
>>>      /* Migration capabilities */
>>>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>>
>> I changed the dsa-accel-path to be a ['str'], i.e. strList* in C.
>> However, I am having a hard time about how to define the proper
>> properties here. I don't know what MACRO to use and I can't find good
>> examples... Need some guidance about how to proceed. Basically I will
>> need this to pass something like '-global
>> migration.dsa-accel-path=3D"/dev/dsa/wq0.0"' in cmdline, or
>> "migrate_set_parameter dsa-accel-path" in QEMU CLI. Don't know how to
>> pass strList there.
>>
>> Thanks very much!
>
> @Daniel, @Markus, any idea here?
>
> If I'm reading this commit[1] right, it seems we decided to disallow
> passing of arrays without JSON, which affects -global on the
> command-line and HMP.
>
> 1- b06f8b500d (qdev: Rework array properties based on list visitor,
> 2023-11-09)
>
> QMP shell:
> (QEMU) migrate-set-parameters dsa-accel-path=3D['a','b']
> {"return": {}}
>
> HMP:
> (qemu) migrate_set_parameter dsa-accel-path "['a','b']"
> qemu-system-x86_64: ../qapi/string-input-visitor.c:343: parse_type_str:
> Assertion `siv->lm =3D=3D LM_NONE' failed.

HMP migrate_set_parameter doesn't support JSON.  It uses the string
input visitor to parse the value, which can only do lists of integers.

The string visitors have been thorns in my side since forever.

> Any recommendation? I believe all migration parameters so far can be set
> via those means, I don't think we can allow only this one to be
> QMP-only.
>
> Or am I just missing something?

I don't think the string input visitor can be compatibly extended to
arbitrary lists.

We could replace HMP migrate_set_parameter by migrate_set_parameters.
The new command parses its single argument into a struct
MigrateSetParameters with keyval_parse(),
qobject_input_visitor_new_keyval(), and
visit_type_MigrateSetParameters().


