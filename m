Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4C6106FD7E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 05:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0v3Y-0006zJ-Of; Fri, 13 Mar 2026 01:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0v3W-0006yx-N5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1w0v3T-0007jl-RP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 01:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773379641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WCp3Be2pEGu9Egvrou3Pk16gJGtVfmuY10fF2H/wHc=;
 b=fkVyw95POxbi8eq/b3pXtxeUy2mUweC/MSx28b+mHh9ELUX+c8VDzbKUvRioL9ijV+56HV
 Kug2YV7EjqP5zarGV+tKV6Tz2aTALFR1avw4sl6TXZiBD/c/K/EXcvJHpFesprT7dsA5Xx
 tLuRLgiY5TdeBvBjd/GOjIHzWtvRI+E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-_Jjg-2iiOX2QIbR9G6eMcA-1; Fri, 13 Mar 2026 01:27:19 -0400
X-MC-Unique: _Jjg-2iiOX2QIbR9G6eMcA-1
X-Mimecast-MFC-AGG-ID: _Jjg-2iiOX2QIbR9G6eMcA_1773379638
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so13579225e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 22:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773379638; cv=none;
 d=google.com; s=arc-20240605;
 b=gMF1ifX1VEhINUl/m/+CC3A1Gkfxomy30v71CatczlpaWo2zGwh0TJBI6yCpmuFl5u
 iXeLZuOwXRpdpungmYQnKrWPil/Kc7NAZCMlvtmgqlKSMq9v1NAGiz+bV+dNtAZtpsd7
 ojqWjj2w+++e2SsYJENy3h9ToZzqyhInxtIoWIac9XBXbxnheSgkXvD5zu/AyfYunJEQ
 9S9VByV1uslKzvjNPU1iMP41qyRbeWPY8fscBVFCZoAwzbS80l4+lwhsMUjtf5secHph
 zTfO3oRdLwxYRJGbFqNtlCSUV8gRsz6P4D4PKxiVz/zKHthOdby/VLVZkqzor/ER/iOw
 ltig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1WCp3Be2pEGu9Egvrou3Pk16gJGtVfmuY10fF2H/wHc=;
 fh=feRbpjM7fdovWhLApMTvB035xA8yy+KA9gWxM/J5FH8=;
 b=HV9jxYvHaAJKmmDyL1ajcaBW1TakcN4d89yqGKu/rpiTtXVoH+B0KbNggV1YUpEdCg
 8kKY21umi70EjbIUTrIt5MCJ3zqxULguCYWetE+a3iDkFZx0gtux5McLcpaj/6fecJ5f
 u+5Ydq0zS0tikX6f85QBxtfcGFoe27Ul4oQjVSdocc1ANOJY9U/uotrfYGlkbbac23/5
 tzT/0h4G11sD0hQmC/kBpcv8YAdg1w8stynlFlsR3wWKvyXZIHr//224dv1nmPn+nDbD
 qP/ni+zH5phMztLhbD4ak54ysICDlOQespNBy6eZ5K0S1yLlxfUw7q1o2GrDlXXXu0EV
 zESQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773379638; x=1773984438; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1WCp3Be2pEGu9Egvrou3Pk16gJGtVfmuY10fF2H/wHc=;
 b=E/5MBmwgD1psWWt1qkpg+Gxqbxrq04NIzsd44NbwKpVBgNaAXzB/8HDBqizjQ5Qr0b
 Lc8VDBOFQyx/qkQlXagSgXHHxH8nnGJNhjm6D+DOCnMYZlVkLhUoeLhEgYRqRknu0i4h
 7uicF2TuThPfrqV3aWGpmNlXbfBjFiFgE+oc+V80J4kruYFwqEQbmZAibUSeoNy4D10F
 toIHKPj+F1rIf2GFdSMeViJkXag8ElsVdyQWzaCB25DlRNS5N0PMEB2UxvAI/JmP1nZx
 MIsC8UpKYEaAXMK2jjuVLF11l5W5R3K89OVgIsnEOlJXKoNnWABRpoVE8I9gRC8tGe8g
 K06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773379638; x=1773984438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WCp3Be2pEGu9Egvrou3Pk16gJGtVfmuY10fF2H/wHc=;
 b=irFzoJniVVlaJN7q2K0j121R7EsiFD33VxTDLYoDKkXvZtWeWHloC4FuXRYH9EDAd0
 ggj6Ulk7eynBp0IUNlHxeNPBSJcI7kPNg9/BpZarqA1Wb9zA749rqVGCstw6MOczPQ5y
 zfrLduE4LcsIs69eioDqRxxLqURQ8ZA0NrbPUvvYzclBDvtQYuphRn6qx71JwFupmUEI
 loudqAZktotg9wUE93Qee7BuocVu73sizfWi91m3gWHI1hrfvZNlpk/2bWpQzSvkEPfy
 6YnKZ1Lo4imYbDc4zvsyf1Y+EsqJHDMDgtVxNL1I9AWaWt0Bb5SyMb3ODY5P1mEoP9Rf
 +WMg==
X-Gm-Message-State: AOJu0YwmRQXQJZagvfZnC7wvJGdxn520QyQFwd4D1kl8Mg+lNguXGf2l
 2iO1sD1VoorXL8SGPpiKB5Sxh1msP3H+uIT3QTS+BDO1jDKVzRlioAA3J6rU2h9lWw7XLMS1XdR
 BbP6E6JIU7rzbsJKIRTbhgKWJtgyauC/4T/+4nU7vTbXntwxrrsYCkv+YZg8ftOI7N6dhP48fvn
 KULpUIyS83N8PqxhZP8csH4kw7fKMXIx4=
X-Gm-Gg: ATEYQzz3NeANMC7EkHY9KlmjMxj03eQfquGWgoXnlHDVeICwDXtjF7LHanZGLSNB2xY
 uDoMJ7J81UJVCdXJCXkknWHSXVcnirw0Genh09+NdpK1jDf2wrOm44HF8das4H7SQlgdHEQqH2w
 rsv3KqZJ3a/rgCYr6/WxpOtnXdmb+NoRfUcVT1nWtXWtdyca6NKBFOF+oMyt0QkJiUwoDfqJ0s6
 XKqkjkf2D91He9oSMOkZTM7NxjVA19gTJLZlh9Sc8BpbgeSxp8clH4O8pGXrvcYKNg1
X-Received: by 2002:a05:600c:628c:b0:485:3aa1:a7f1 with SMTP id
 5b1f17b1804b1-485566c6a59mr26834255e9.7.1773379638310; 
 Thu, 12 Mar 2026 22:27:18 -0700 (PDT)
X-Received: by 2002:a05:600c:628c:b0:485:3aa1:a7f1 with SMTP id
 5b1f17b1804b1-485566c6a59mr26833945e9.7.1773379637764; Thu, 12 Mar 2026
 22:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260312204619.1969-1-farosas@suse.de>
In-Reply-To: <20260312204619.1969-1-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 13 Mar 2026 10:57:01 +0530
X-Gm-Features: AaiRm53TTKMVGRcN0CKb-5e8lNlOJcmz2V1cGuT7Y2vj83xfV30GuRhAfVEY_tI
Message-ID: <CAE8KmOz3Zp+2mx5MGovzxPqSYx+RQmjKQbT0F0i7rk_wPoceKg@mail.gmail.com>
Subject: Re: [PATCH v3] migration/options: Fix leaks in StrOrNull qdev
 accessors
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Mar 2026 at 02:18, Fabiano Rosas <farosas@suse.de> wrote:
> Fix a couple of possible leaks detected by Coverity. Both are
> currently harmless. This code is only used for the very specific
> purpose of maintaining compatibility of a few migration options which
> can be set via QEMU command line (-global migration.tls-*). The
> command line interface is not supported and only used during
> development and testing.
>
> 1) The setter function set_StrOrNull() is invoked whenever the -global
> migration.tls-* command line options are set. The way it could leak is
> that the temporary "StrOrNull *str_or_null" object is allocated before
> calling the visitor, which could fail and cause an early return of the
> function, leaving *ptr unset and str_or_null leaking.
>
> 2) The getter function get_StrOrNull() is unreachable code. It's only
> there to provide a complete implementation of the property. Still, the
> way it could leak is that the temporary "StrOrNull *str_or_null" might
> be allocated and is simply never returned to the caller nor freed.
>
> Fix the possible leaks:
>
> 1) at set_StrOrNull(): change the allocation of str_or_null to happen
> only after the visit call has returned successfully.
>
> 2) at get_StrOrNull(): assert that the object is non-NULL, there is no
> need for a temporary object.
>
> The reason it should be non-NULL is that the property is initialized
> by the default setter of the qdev property. The initialization is
> unlikely to fail because the call to the setter is setup by qdev,
> which has boilerplate ensuring the to-be-set object is allocated and
> of the correct type. Moreover, passing NULL via command line to
> -global migration.tls-* is not possible.
>
> A programming error could result in an invalid call to the setter,
> which would leave the object NULL and cause a crash in the getter, but
> that's not a worthwhile scenario to protect against given the low
> probability of this code being even reached.
>
> While here, update the comment about why there's no QNULL in this
> StrOrNull property to be more clear.
>
> Fixes: CID 1643919
> Fixes: CID 1643920
> Cc: Markus Armbruster <armbru@redhat.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> v3:
> more detailed commit message
> stopped removing the prop variable, cleaner diff
> updated the QNULL comment
> ---
>  migration/options.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/migration/options.c b/migration/options.c
> index f33b297929..658c578191 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -220,14 +220,12 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>      StrOrNull **ptr = object_field_prop_ptr(obj, prop);
>      StrOrNull *str_or_null = *ptr;
>
> -    if (!str_or_null) {
> -        str_or_null = g_new0(StrOrNull, 1);
> -        str_or_null->type = QTYPE_QSTRING;
> -        str_or_null->u.s = g_strdup("");
> -    } else {
> -        /* the setter doesn't allow QNULL */
> -        assert(str_or_null->type != QTYPE_QNULL);
> -    }
> +    /*
> +     * The property should never be NULL because it's part of
> +     * s->parameters and a default value is always set by qdev. It
> +     * should also never be QNULL as the setter doesn't allow it.
> +     */
> +    assert(str_or_null && str_or_null->type != QTYPE_QNULL);
>      visit_type_str(v, name, &str_or_null->u.s, errp);
>  }
>
> @@ -236,16 +234,25 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>  {
>      const Property *prop = opaque;
>      StrOrNull **ptr = object_field_prop_ptr(obj, prop);
> -    StrOrNull *str_or_null = g_new0(StrOrNull, 1);
> +    StrOrNull *str_or_null;
> +    char *str;
> +
> +    if (!visit_type_str(v, name, &str, errp)) {
> +        return;
> +    }
>
>      /*
> -     * Only str to keep compatibility, QNULL was never used via
> -     * command line.
> +     * This property only applies to the command line usage of
> +     * migration's TLS options (-global migration.tls-*) where the
> +     * NULL value cannot be provided as input (only strings are
> +     * allowed). Therefore, this StrOrNull implementation never
> +     * produces a QNULL value to avoid ever returning values outside
> +     * the range of what was previously handled by consumers of the
> +     * TLS options.
>       */
> +    str_or_null = g_new0(StrOrNull, 1);
>      str_or_null->type = QTYPE_QSTRING;
> -    if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
> -        return;
> -    }
> +    str_or_null->u.s = str;
>
>      qapi_free_StrOrNull(*ptr);
>      *ptr = str_or_null;
> --

* Change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


