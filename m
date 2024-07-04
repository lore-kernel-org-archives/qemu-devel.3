Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277DBC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 16:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPPZt-0007gq-ET; Thu, 04 Jul 2024 12:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPPZr-0007g3-IZ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:44:59 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPPZp-0001LB-Mk
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:44:59 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a77c7d3e8bcso7062166b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720111495; x=1720716295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7e+9jaG3i6h3581y6bfnNWzVuXNbsmJ9Fdj9t0MGtE0=;
 b=sF/6EUBGVRKsIfqhsKqg+FQhIPYmeoacCrcP+e/OhWOYyDtACtvEZ/uRiufSnZDXFC
 0utdoXhM8fejbvC8GKoFo+BODgJB1vXXkuo55vRGk/wWnpVaetKg5Jmx9ZGhu5rI+vp5
 W63xfs6tm8t3WlaId6hQipCgx2Nt6qxgjY8ZahxPZe5+qo28FaDLZzlQhaBR/y0GwwLF
 uNurc7pbBb5WLnvWmkYpabEFtH6pJq8usRNG5LfsGD8C6/wSBXbTR7DBLY39Fmax8ABR
 OnEQ6MYCsi5WaTSWB9MtUEZVtCILF7e15r+HVVvcIFwsgocG3R0Q7BjhBeYUxeQH9BGc
 pQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720111495; x=1720716295;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7e+9jaG3i6h3581y6bfnNWzVuXNbsmJ9Fdj9t0MGtE0=;
 b=PNgiJE1jU26fPKDeg+Zm2B9YrGnToxXmVsjqlSzAPkDOUi1bMm1dfsgzgKF8MLMEV2
 NxzMNCdY86g6YpjJIJTpN7NdOfQG3UZMfktZcIhlwjF9MVBDYwjkV40RtYiUEtlmahev
 IwcCcVS+v/3/mh6C5wVVUASESV/qBI4i7xbL7djaJNWL7yQ5FosA1Gp/F1cUT2bvAfth
 dyF73RA5nD4U9tSKeYXIDYs+552IuwHTyKQQWMrYn871oGV3KG4B6CpdmiKIkAbzj1Xt
 7tfOdtklz7tQ0+66Buba1RsAkOM+SlxX2oNKWF3Kdz3lt8iYOiUXHW4qVwEEjUvf/fvC
 HlzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUjETrlgMI9vMnly1gaJHxvxiG5G2E0yfNbnB9d9rokzohWVmA5UFVg2kkfs2ZsrZc+RzMULL7vWYFCU2hRLscTlbzTbc=
X-Gm-Message-State: AOJu0Yy9UUHp4smnKqavfFvRGWosga3nKBz0NgbU53ZI/pjGp6fEPwxh
 3cZbwRKd+TQVvum2D5BL8KCj9Jkmh88W3rKuTzziwNnYnsB2Z4ZB6/G0APENdhM=
X-Google-Smtp-Source: AGHT+IGTp3ymlZkKAcuX3mwvsyprJa2baN85p7ojMJg+tCz5V1oNIF9d7xmATIYbzE9cGXc8GE/tow==
X-Received: by 2002:a17:907:9620:b0:a72:4281:bc72 with SMTP id
 a640c23a62f3a-a77ba72781fmr186692266b.63.1720111494577; 
 Thu, 04 Jul 2024 09:44:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c3edb9f0sm23954366b.121.2024.07.04.09.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 09:44:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB6495F839;
 Thu,  4 Jul 2024 17:44:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  qemu-devel@nongnu.org,
 sstabellini@kernel.org,  paul@xen.org,  edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 2/2] xen: mapcache: Fix unmapping of first entries in
 buckets
In-Reply-To: <ZoawbAnukIBkYWCw@l14> (Anthony PERARD's message of "Thu, 04 Jul
 2024 14:23:41 +0000")
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-3-edgar.iglesias@gmail.com>
 <ZoawbAnukIBkYWCw@l14>
Date: Thu, 04 Jul 2024 17:44:52 +0100
Message-ID: <87wmm1m7i3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Anthony PERARD <anthony.perard@vates.tech> writes:

> On Tue, Jul 02, 2024 at 12:44:21AM +0200, Edgar E. Iglesias wrote:
>> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>>=20
>> This fixes the clobbering of the entry->next pointer when
>> unmapping the first entry in a bucket of a mapcache.
>>=20
>> Fixes: 123acd816d ("xen: mapcache: Unmap first entries in buckets")
>> Reported-by: Anthony PERARD <anthony.perard@vates.tech>
>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>> ---
>>  hw/xen/xen-mapcache.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
>> index 5f23b0adbe..18ba7b1d8f 100644
>> --- a/hw/xen/xen-mapcache.c
>> +++ b/hw/xen/xen-mapcache.c
>> @@ -597,7 +597,17 @@ static void xen_invalidate_map_cache_entry_unlocked=
(MapCache *mc,
>>          pentry->next =3D entry->next;
>>          g_free(entry);
>>      } else {
>> -        memset(entry, 0, sizeof *entry);
>> +        /*
>> +         * Invalidate mapping but keep entry->next pointing to the rest
>> +         * of the list.
>> +         *
>> +         * Note that lock is already zero here, otherwise we don't unma=
p.
>> +         */
>> +        entry->paddr_index =3D 0;
>> +        entry->vaddr_base =3D NULL;
>> +        entry->valid_mapping =3D NULL;
>> +        entry->flags =3D 0;
>> +        entry->size =3D 0;
>
> This kind of feels like mc->entry should be an array of pointer rather
> than an array of MapCacheEntry but that seems to work well enough and
> not the first time entries are been cleared like that.

The use of a hand rolled list is a bit of a concern considering QEMU and
Glib both provide various abstractions used around the rest of the code
base. The original patch that introduces the mapcache doesn't tell me
much about access patterns for the cache, just that it is trying to
solve memory exhaustion issues with lots of dynamic small mappings.

Maybe a simpler structure is desirable?

We also have an interval tree implementation ("qemu/interval-tree.h") if
what we really want is a sorted tree of memory that can be iterated
locklessly.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

