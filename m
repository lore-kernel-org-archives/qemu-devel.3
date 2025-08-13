Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BDAC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 22:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umJrt-00083b-0w; Wed, 13 Aug 2025 18:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umJrq-00082v-RS
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 18:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umJrm-0000ST-Ea
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 18:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755123757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wWL5STgfJcrf7n/cHXETW2fZIlgDUKV3GHAdSMeHedY=;
 b=RWezcAhQM9YMwcKiSQvUygejuU9yuZop/pDbzXA2968AtRd3vRSITNtVbDUL1e0AhoHfY7
 IGiraO/hxTKORd2hddfUB5BjeaZYmfNnj0MWCl2oXqSQ50Uu2v9w2uyBqahaE04NqrO/Zz
 Xa0UPT8aI3EMsZ/3kGOBeHredE7VxXs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-CzTQ4qcuNoSJdK46sovYBA-1; Wed, 13 Aug 2025 18:22:36 -0400
X-MC-Unique: CzTQ4qcuNoSJdK46sovYBA-1
X-Mimecast-MFC-AGG-ID: CzTQ4qcuNoSJdK46sovYBA_1755123756
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70a94f3bbdbso8357196d6.2
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 15:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755123756; x=1755728556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWL5STgfJcrf7n/cHXETW2fZIlgDUKV3GHAdSMeHedY=;
 b=rdYNbe86fVGxXPtTIkVFD2wkblqo5jmZd8BNIwSOP5ctHqqXmCLD1zDwXnjwdyh37J
 9Vv5g09N+Z8NZ6dcgZxI2DtrubrF9RjXBuZ8Hd0DllMSs5054VKkRGXYhfLl43KV8D15
 so/AsIP/3w5bo7QkhjakFRF3SJolXM/Qeog+1oNZ1svdUHYKZ9QCqJoqQdI9tHadFIVg
 DbM6H2Jjn+9tmq8NohktLH+exqPrlxA3Xr6tnxfvrlYM/OA9fhGjQ60RMcZsRaqfksPX
 59f87faqXWHcBLsbk1rgqe+MRvLAQzVIgRtMgEIM8KJB0MvlOj4tki2ihodvLZat/bHR
 0XbA==
X-Gm-Message-State: AOJu0Yzmg5nFL8O6+wFQ5jCs0JA5DFX+iotmD0RDPWRoUQFxUDy4SqK9
 +f1JoACZQsZyPh+cHSEUNt4mGI+VGMZuxLXCvU8+TDuSe4KDh4RJvDRBYCUnOVNDucH/hILspWN
 LqEoD0n/N7MpGDa0St1dSeeJ+DCenJouMlCFb+BFL0v26i2AUsUZoN3JO
X-Gm-Gg: ASbGncseyfb9JELmf3dtMIxUb/iy8bPXMVvS1W2HqDg4R1N4cf/yDwfVc8KLrttZvrd
 KuZc6OJKkkopOX9MlvyUJaB0tI4fg/MbKfwJhHXXno0dyRrJ5XdfNu20+uT6IGWtgfNEWHlea5M
 F+iHcoc64eutxqkyjn7tUJZdRbNkRrSNQxrQkN91E9w6ndZH5ZIIyRPlhXQdmPj5/Fxq7UI4F+I
 HFlislizLvOhBBYDsn0ighwnzOn/bWAIaxS8yZ1gT6Ipcf81qPCbykv2lzIgNNS1PJCJI+LDZn3
 ObESYp+edNQZ+nsOexVXTSsQ7Pynjsvp
X-Received: by 2002:a05:6214:3002:b0:709:82dc:b1b2 with SMTP id
 6a1803df08f44-70af5f8bab8mr15854696d6.48.1755123755852; 
 Wed, 13 Aug 2025 15:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAUrHVRA3KQvmm6+TAB6Ql/pXZaeec3C5yuk8bi0S+dWiXhCrs39JYM19CANagtSDi/nDkMA==
X-Received: by 2002:a05:6214:3002:b0:709:82dc:b1b2 with SMTP id
 6a1803df08f44-70af5f8bab8mr15854446d6.48.1755123755454; 
 Wed, 13 Aug 2025 15:22:35 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ae6cdcd7fsm4417366d6.30.2025.08.13.15.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 15:22:34 -0700 (PDT)
Date: Wed, 13 Aug 2025 18:22:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 21/24] tests/qtest/migration: Take reference when
 passing %p to qtest_qmp
Message-ID: <aJ0QHowWNp90OnzO@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-22-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630195913.28033-22-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 30, 2025 at 04:59:10PM -0300, Fabiano Rosas wrote:
> The documentation of qobject_from_jsonv() states that it takes
> ownership of any %p arguments passed in.
> 
> Next patches will add config-passing to the tests, so take an extra
> reference in the migrate_qmp* functions to ensure the config is not
> freed from under us.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/migration-qmp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index fb59741b2c..d82ac8c750 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -97,7 +97,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
>      }
>  
>      err = qtest_qmp_assert_failure_ref(
> -        who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> +        who, "{ 'execute': 'migrate', 'arguments': %p}",
> +        qdict_clone_shallow(args));
>  
>      g_assert(qdict_haskey(err, "desc"));
>  
> @@ -136,7 +137,8 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>      }
>  
>      qtest_qmp_assert_success(who,
> -                             "{ 'execute': 'migrate', 'arguments': %p}", args);
> +                             "{ 'execute': 'migrate', 'arguments': %p}",
> +                             qdict_clone_shallow(args));
>  }
>  
>  void migrate_set_capability(QTestState *who, const char *capability,
> @@ -174,7 +176,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
>      migrate_set_capability(to, "events", true);
>  
>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
> -                    args);
> +                    qdict_clone_shallow(args));

Isn't it intentional to pass over the ownership in the three places here?
I don't see otherwise where args got freed.

OTOH, I saw there're yet another three similar usages of %p in framework.c:

x1:migration [migration-params-caps-no-config]$ git grep -A1 %p framework.c
framework.c:        migrate_qmp_fail(from, args->connect_uri, NULL, "{ 'config': %p }",
framework.c-                         args->start.config);
--
framework.c:    migrate_qmp(from, to, args->connect_uri, NULL, "{ 'config': %p }",
framework.c-                args->start.config);
--
framework.c:    migrate_incoming_qmp(to, args->connect_uri, NULL, "{ 'config': %p }",
framework.c-                         args->start.config);

They seem to be suspecious instead, as they seem to have lost ownership of
args->start.config, so args->start.config can start to point to garbage?

>  
>      if (!qdict_haskey(rsp, "return")) {
>          g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
> -- 
> 2.35.3
> 

-- 
Peter Xu


