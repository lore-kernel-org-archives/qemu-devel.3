Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FB0C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdO3m-0005fh-6l; Fri, 23 Feb 2024 00:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdO3a-0005W4-Jz
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:25:11 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdO3G-0005s7-Va
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 00:25:10 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a3e7ce7dac9so50881966b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 21:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708665889; x=1709270689; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdFHXhmvDb25vHI+WXPFJhobvLWIcTUdohNv3qG2z8Y=;
 b=b+DX0fxVevnC13As7fvCwyVVwgX6lB9j+pwqSeVh0pLFtldwH+VbDZE8qPPdSa/G5P
 3AlzjuTkvOsx140IkSrVSTcAtuHXPW6M0pcoa1ay+O1mmeqGtglIk/IicLuUwIYnP56Q
 lae4WLej1yLN4Egv1oKwRv56lG8UTy9a5inZROayTs1QOo+xzWdLo8uIgaButqVAsyto
 u16LyKjMz/VAyI411oUh7BTpePcCS5ZUWEbypq3JcMktOU6GoFQnmZFAQDRZ4LjZPcNz
 vq/KBstrOKfw1iKMyory0ZINfYB3EjEeJJA2jb1aR8yJDEdDQPziLhFNK/27ia+OusAI
 hJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708665889; x=1709270689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdFHXhmvDb25vHI+WXPFJhobvLWIcTUdohNv3qG2z8Y=;
 b=IZoFuvUK2fj4f74G8QBa/rXIrjYowAzaDlJQFx8DPb5F/5je01TedOtToWZQLDxqiC
 L4s3ZO8vGfuhZOIndNCQZimt9A6Re443GByuYa9+ksGRHksC5bzLUbrVsyX8CMLHsFI1
 xYkds3/2/sL3n4f0fgryKevH7HNtHTFsHwTKI7gcyQjFUPDnWpuSz3LOrYC06VGSO9kh
 6Yy1SqlUjzLk2PZtkVAXZWk1ipFOvzu4n1FESTkLsovtzMT908Oj/LcjXQtez2dT4dYQ
 fq2RzVe1X7sjJkbzd2RovNluFEFhiq24zb7ZyLPa/1btKNLl5cgtwBtASAI3lzTrE4zf
 ssgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyk8AR9alfFMiMHR6wP8v3dG7U9Fe6xSl0Jv5FHyJnBWIVBqqb6IhrcIFzIoGMq3c9SvscLdD/LtQFnDj1EeDmJ8wv7PE=
X-Gm-Message-State: AOJu0Yy/rMxjgCfKb7IFn+7WMbDZY7uaWnFa7NNA71hxQ143rEFB4lpo
 xWwtxrJh3LMKm3/yEszvM2MsmWLJBKsDjCn3imXeRfClLqUxVQ94ONz0pYMHDFh9kPpZfqc3X+5
 EbRUbNs5vvIsxkhb3YQ+OkIky+UV19/HEyZWwiw==
X-Google-Smtp-Source: AGHT+IF6aeJqhWpKCP/xxHaVhSxZekhpuF4fw2922dALovk72lcOeNH1wLLKyI0TNWH5V9x/puXp4OaCKavGsxXT33U=
X-Received: by 2002:a17:906:1c09:b0:a3e:8808:fc1d with SMTP id
 k9-20020a1709061c0900b00a3e8808fc1dmr469647ejg.64.1708665889232; Thu, 22 Feb
 2024 21:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com>
 <CAEr7rXg5kZsUnDd8tcLu7Y4NmLrhWmu5bjh8KtAYnYubbHqbJA@mail.gmail.com>
In-Reply-To: <CAEr7rXg5kZsUnDd8tcLu7Y4NmLrhWmu5bjh8KtAYnYubbHqbJA@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 21:24:38 -0800
Message-ID: <CAAYibXir5+e3xeP1rwN49tp+fpQzH_GmSTKAag8xPwwMf0TUsg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 4/7] migration/multifd: Enable zero page
 checking from multifd threads.
To: Elena Ufimtseva <ufimtseva@gmail.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 21, 2024 at 8:11=E2=80=AFAM Elena Ufimtseva <ufimtseva@gmail.co=
m> wrote:
>
>
>
> On Fri, Feb 16, 2024 at 2:42=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.co=
m> wrote:
>>
>> This change adds a dedicated handler for MigrationOps::ram_save_target_p=
age in
>> multifd live migration. Now zero page checking can be done in the multif=
d threads
>> and this becomes the default configuration. We still provide backward co=
mpatibility
>> where zero page checking is done from the migration main thread.
>>
>> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> ---
>>  migration/multifd.c |  1 +
>>  migration/options.c |  2 +-
>>  migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++-----------
>>  3 files changed, 42 insertions(+), 14 deletions(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index fbb40ea10b..ef5dad1019 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -13,6 +13,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/rcu.h"
>> +#include "qemu/cutils.h"
>>  #include "exec/target_page.h"
>>  #include "sysemu/sysemu.h"
>>  #include "exec/ramblock.h"
>> diff --git a/migration/options.c b/migration/options.c
>> index 3c603391b0..3c79b6ccd4 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -181,7 +181,7 @@ Property migration_properties[] =3D {
>>                        MIG_MODE_NORMAL),
>>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationSta=
te,
>>                         parameters.zero_page_detection,
>> -                       ZERO_PAGE_DETECTION_LEGACY),
>> +                       ZERO_PAGE_DETECTION_MULTIFD),
>>
>>      /* Migration capabilities */
>>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 5ece9f042e..b088c5a98c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSearc=
hStatus *pss,
>>      QEMUFile *file =3D pss->pss_channel;
>>      int len =3D 0;
>>
>> -    if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_LEGACY) =
{
>> -        return 0;
>> -    }
>> -
>>      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>>          return 0;
>>      }
>> @@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSearch=
Status *pss)
>>
>>  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
>>  {
>> +    assert(migrate_multifd());
>
> We only call ram_save_multifd_page() if:
>  if (migrate_multifd()) {
>         migration_ops->ram_save_target_page =3D ram_save_target_page_mult=
ifd;
> So this assert is not needed.

The point of an assert is to ensure the current function is called
with the correct assumptions. In the future, if someone moves this
function to a different place, we can catch the potential issues.

>
>> +    assert(!migrate_compress());
>>
>> +    assert(!migration_in_postcopy());
>
> These two are redundant and done before we call in here.
>
>> +
>>      if (!multifd_queue_page(block, offset)) {
>>          return -1;
>>      }
>> @@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, PageS=
earchStatus *pss,
>>   */
>>  static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *=
pss)
>>  {
>> -    RAMBlock *block =3D pss->block;
>>      ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>>      int res;
>>
>> @@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMState =
*rs, PageSearchStatus *pss)
>>          return 1;
>>      }
>>
>> +    return ram_save_page(rs, pss);
>> +}
>> +
>> +/**
>> + * ram_save_target_page_multifd: save one target page
>> + *
>> + * Returns the number of pages written
>> + *
>> + * @rs: current RAM state
>> + * @pss: data about the page we want to send
>> + */
>> +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus =
*pss)
>> +{
>> +    RAMBlock *block =3D pss->block;
>> +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>> +
>> +    /* Multifd is not compatible with old compression. */
>> +    assert(!migrate_compress());
>
> Do we need to check this for every page?
>
>>
>> +    /* Multifd is not compabible with postcopy. */
>> +    assert(!migration_in_postcopy());
>> +
>>      /*
>> -     * Do not use multifd in postcopy as one whole host page should be
>> -     * placed.  Meanwhile postcopy requires atomic update of pages, so =
even
>> -     * if host page size =3D=3D guest page size the dest guest during r=
un may
>> -     * still see partially copied pages which is data corruption.
>> +     * Backward compatibility support. While using multifd live
>> +     * migration, we still need to handle zero page checking on the
>> +     * migration main thread.
>>       */
>> -    if (migrate_multifd() && !migration_in_postcopy()) {
>> -        return ram_save_multifd_page(block, offset);
>> +    if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_LEGACY=
) {
>> +        if (save_zero_page(rs, pss, offset)) {
>> +            return 1;
>> +        }
>>      }
>>
>> -    return ram_save_page(rs, pss);
>> +    return ram_save_multifd_page(block, offset);
>>  }
>>
>>  /* Should be called before sending a host page */
>> @@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *opaq=
ue)
>>      }
>>
>>      migration_ops =3D g_malloc0(sizeof(MigrationOps));
>> -    migration_ops->ram_save_target_page =3D ram_save_target_page_legacy=
;
>> +
>> +    if (migrate_multifd()) {
>> +        migration_ops->ram_save_target_page =3D ram_save_target_page_mu=
ltifd;
>> +    } else {
>> +        migration_ops->ram_save_target_page =3D ram_save_target_page_le=
gacy;
>> +    }
>>
>>      bql_unlock();
>>      ret =3D multifd_send_sync_main();
>> --
>> 2.30.2
>>
>>
>
>
> --
> Elena

