Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1D2D41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjY5-0000Rn-4R; Thu, 11 Dec 2025 11:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTjY2-0000PU-KC
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vTjXz-0002la-Rq
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765470583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fgRaE3Xf992Qlq61leuvg1J5w2Ls1v5f4ErSftPW58c=;
 b=VMfjf/OCU+VMlwMrE/A7AOm3poTwM5KkJFeWczeY4zjyeaXGNOHE6iUNutKE8dd8L47kme
 rtmw+shOaQDnCdgYRW+nK4YeX6+qb9FUCqSGwelU/S3UMWcIq7ImzZjB1FvJiHhtwL1LpO
 +uvX62TQKSOnBpHplfaejGXJPtZOfGA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-9-byB7VUMCu8JfjbJ0DBCQ-1; Thu, 11 Dec 2025 11:29:41 -0500
X-MC-Unique: 9-byB7VUMCu8JfjbJ0DBCQ-1
X-Mimecast-MFC-AGG-ID: 9-byB7VUMCu8JfjbJ0DBCQ_1765470580
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42e2d6d13d1so151540f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765470580; x=1766075380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fgRaE3Xf992Qlq61leuvg1J5w2Ls1v5f4ErSftPW58c=;
 b=QiustEaBCS2qhePpTCOWShOAR7yWUNw/k41vLRplLCEV2s2kuDt2Ve7se+Ims0z7s4
 7nclWAhrLxtXMSfNXfhs7lqPVc/nBHmZMsLmB9ToQUcrP3ElJ4BXWSbAmagNHbuQ1N7o
 v3xpSJf1hSnbst/LR1TyD/wtWb74vufrN9CDQxRKanwQFeHILSY298uCMU8Rbrq2/jpw
 6Ecj/x8Xg6xf6cUJYx4SHVDZsGGXMOP/gw55QUucdxWvNYZ6IheTuUPJSV3TvUBHcxfV
 IJozKxo7ujVVSLdteaWgabOlNnSZTLB9XfRXvh5R/8j+Rjk5C9Y3Nkh1AspQai4xhL2h
 QMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470580; x=1766075380;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgRaE3Xf992Qlq61leuvg1J5w2Ls1v5f4ErSftPW58c=;
 b=igaSiaqWN7TwuG8aEG/LspqR5K/boq9LfaH+FBAPj2PvB0iCsSAmlTPX6HLzH0IYWZ
 4tLFA/gFJ7MrPFq8ZGUYlevSZ3TJuFEJ3SS7LlJtdaqMj8V29ktAltAYE7w8oTYa8hiC
 BjtKY32UF6FlRl364O8XEBc8VU8Tukx9b2/+/W7nvOJf7tEEQXJtH9xtziVxElRwcvNU
 Oxzw9MivgO4+XgIbLj8OCI57QNDlVzyhazvBxKQFAMXrV3iHWjlJGQDdPhtnzd/GQ0NC
 dWEqJpk7kvjXRFk5Ctg3TNBOWurgmQGA33AEQ5QgHZ/UTkdly4jIqoIRhlojrUFaKwrE
 Fryg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgVBb762VozP+DAk0JxniXzVCEb92yYj+Y5gzE1NKCb8ABHPLqQGIxuPE89EZ1UQ9ggTfXynYcH/zQ@nongnu.org
X-Gm-Message-State: AOJu0Yxe9MYHX03CPRPqYCNahCJbpkyOriktiRAIPcNL4XRrm4mwYGTO
 O7zaiSbxWwR3qXjnQk+WYINEXmS25v9KwJvy3DzCiUenR1yYg52ZotkJl03l9aOes5pmQeb3oIw
 LaaIhX+6N4g24v3HrScFILweLJFiidNbtUZxeu9n6/vIzrQILk7NuNflr
X-Gm-Gg: AY/fxX4C/1O99ER00/yA/q0IXa9ZhoISJjeH6RFaOQJUULqdG1f1vErLiCNkl5QnQqb
 p4+rsUrZIiaFAQpv2+3GisBlVu0guNSv5eqDu+2B9hESfNU2ffrrXSf68tZ2W6bhJXjWcUj4wKh
 iEcgO0iYtQ28xp19t3ZhgqRWurfLiFOeTgkF9KKZ+h1OhSL6uGesYMC+tsaU0QPx9/L1BSYQ2Ys
 zBxY2BNTj8a+hPBeAteNj4aeKEm2UTO1Uuhv8WGimOvzC9TxCezoiIkGWtKHYgUFtIDbrVsGR3+
 ixZMbvZkZzMmmyqJRhc3dIP6Bb+w02xMxnmv/Go9TcTSHi/0V1lTZMUSAeRpMvZ91AlsJYQkSMi
 Z4MLyZ5P0VK21137x0v+19ZzFveVXgaAdv2IgGOCzB2OpauwI
X-Received: by 2002:a05:6000:2905:b0:426:d5ac:8660 with SMTP id
 ffacd0b85a97d-42fa3b1ef5bmr6858226f8f.58.1765470580100; 
 Thu, 11 Dec 2025 08:29:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQajvy+M0BsjCRN5gTdZ7eWkEvdV0JyfpqwPq517U3BViauilVCY4TKSWfATyClOjOXcHigg==
X-Received: by 2002:a05:6000:2905:b0:426:d5ac:8660 with SMTP id
 ffacd0b85a97d-42fa3b1ef5bmr6858197f8f.58.1765470579540; 
 Thu, 11 Dec 2025 08:29:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b259sm6444144f8f.41.2025.12.11.08.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 08:29:39 -0800 (PST)
Message-ID: <ab8ac8e1-b371-410d-88da-21e93a5985b0@redhat.com>
Date: Thu, 11 Dec 2025 17:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251209162857.857593-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/9/25 17:28, Peter Xu wrote:
> [This is an RFC series, as being marked out.  It is trying to collect
>   opinions.  It's not for merging yet]
> 
> Background
> ==========
> 
> It all starts with machine compat properties..
> 
> Machine compat properties are the major weapon we use currently in QEMU to
> define a proper guest ABI, so that whenever we migration a VM instance from
> whatever QEMU version1 to another QEMU version2, as long as the machine
> type is the same, logically the ABI is guaranteed, and migration should
> succeed.  If it didn't, it's a bug.

On the PPC pseries machines, we had to introduce a capability concept
and infrastructure on top of the machine versions to handle cases where
the features advertised to the guest (also visible to the OS) could
differ from one host to another and generate migration errors. See :

   hw/ppc/spapr_caps.c

These capabilities can be tweaked on the command line to adjust source
and target host support. It's mostly related to CPU and MM features.
Initially these difference were related to CPU bugs IIRC and different
FW levels on the host.

Is your proposal doing something similar ? Is my understanding correct ?

Thanks,

C.

> 
> These compat properties are only attached to qdev for now.  It almost
> worked.
> 
> Said that, it's also not true - we already have non-qdev users of such, by
> explicitly code it up to apply the compat fields.  Please refer to the
> first patch commit message for details (meanwhile latter patches will
> convert them into a generic model).
> 
> Obviously, we have demands to leverage machine compat properties even
> outside of qdev.  It can be a network backend, it can be an object (for
> example, memory backends), it can be a migration object, and more.
> 
> This series tries to introduce a common root class OBJECT_COMPAT for it.  I
> didn't abuse OBJECT because I know there're too many OBJECTs that do not
> need compat properties at all.  With this design, we can also opt-in piece
> by piece on the new root class, only when needed.
> 
> Class OBJECT_COMPAT
> ===================
> 
> This is almost OBJECT class, except that it'll also apply machine compat
> properties from anywhere.  One can refer to patch 1.
> 
> Note that currently I didn't further identify the three possible source of
> object_compat_props[3] (accel, machine compat property, legacy globals).  I
> don't think it's a huge issue so far because non-qdev objects will not
> collapse with names in accel / legacy globals, due to the fact that object
> names cannot dup acorss QEMU binary.  So I kept the changeset as minimum as
> possible.  Feel free to shoot if there's concerns I overlooked.
> 
> This part is done in patch 1-6.  This is the part I felt slightly more
> confident with.  Meanwhile, these will be the dependency if we want to
> e.g. allow TAP network backends to take compat properties like a virtio-net
> frontend (but likely we'll need to QOMify TAP first).  That's something for
> the future even if applicable.
> 
> Export Property from QDEV
> =========================
> 
> I also have patch 7-10 below for one step further beyond OBJECT_COMPAT.
> Feel free to take it even as a seperate small series to review.
> 
> So far the first part will be the focus, but I still want to collect
> opinions here on this second part.  This is about exporting Property for
> non-qdev uses.  Currently, migration is the only user.
> 
> In short, Property is something qdev uses internally to ultimately
> represents ObjectClass's properties hash table.  It's pretty handy to
> e.g. avoid definining accessors for object properties, setting default
> values, etc.  Then they'll be converted to Object properties at some point.
> 
> Migration object currently defines all the global fields in Property and
> can use "-global migration.XXX" to allow global overrides, with almost one
> line for each property, which is efficient.
> 
> This 2nd step will allow migration object to inherit from OBJECT_COMPAT too
> with almost only a few lines of changes, and keep the functionality as-is.
> 
> Two other options we have:
> 
>    (1) Keep migration object to be a qdev, it's still fine, even if it
>        sounds hackish.. if we want to keep "-global" working as before
> 
>    (2) Inherit OBJECT_COMPAT without supporting "-global" anymore.
> 
> Any comments welcomed, especially on the first half (1-6), thanks.
> 
> Peter Xu (10):
>    qom: Introduce object-compat
>    qdev: Inherit from TYPE_OBJECT_COMPAT
>    hostmem: Inherit from TYPE_OBJECT_COMPAT
>    accel: Inherit from TYPE_OBJECT_COMPAT
>    confidential guest support: Inherit from TYPE_OBJECT_COMPAT
>    qom: Unexport object_apply_compat_props()
>    qdev: Pave way for exporting Property to be used in non-qdev
>    qdev: Introduce helper object_apply_globals()
>    qdev: Refactor and rename of qdev_class_add_property()
>    migration: Inherit from TYPE_OBJECT_COMPAT
> 
>   include/hw/qdev-properties.h          | 11 ++++++++
>   include/qom/object.h                  |  2 +-
>   migration/migration.h                 |  2 +-
>   accel/accel-common.c                  |  2 +-
>   backends/confidential-guest-support.c |  2 +-
>   backends/hostmem.c                    |  8 +-----
>   hw/core/qdev-properties.c             | 37 +++++++++++++++++++++------
>   hw/core/qdev.c                        |  6 ++---
>   migration/migration.c                 | 31 +++++++++++-----------
>   qom/object.c                          | 16 +++++++++++-
>   system/vl.c                           |  1 -
>   target/i386/sev.c                     |  1 -
>   12 files changed, 79 insertions(+), 40 deletions(-)
> 


