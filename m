Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB026C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 05:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNeb-0007Gh-G6; Thu, 22 Feb 2024 23:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNeY-0007GW-Vv
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:59:19 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdNeV-0007C4-Na
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:59:18 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3f5808b0dfso54043466b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708664352; x=1709269152; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eg6JU7y7gJ159lnRNcvAJsuRu4Zi8K6LXxwyq3HRd20=;
 b=NESZkTS/oin2zRa/K/BPH5w19hiqnhbNcCd5opKeKPw9bXzl4U6heFhM6DstlM5QVg
 1JBnCu1rTMTmFVMValTLNo+mUWk0z07juqcoLs6PjcHcgh09n+hND8zYMrtYcxSdC6PV
 ryZbs3krTL06Sgjamb3TPUNT62Co4S0rhUWlYVFQNkTy/qjx0xjJQNPHaLRcpp9pGnCo
 /CSYP0aht1aVOXnp/W6R6hmzXrrkRnXN45up7bO3DztmpjUOc4zIGQURHBhwHMTdBrLn
 xk23lSOK4ix+l4QabZgz/hMi17NYUJJduHoX8efwwg1ylqNj4H+81oP7QhH0RncRkTSf
 f/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708664352; x=1709269152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eg6JU7y7gJ159lnRNcvAJsuRu4Zi8K6LXxwyq3HRd20=;
 b=WpaqYMUpZ/cnS7gAGf6AIfzwBlCBCirwmIBgSwWKTtoj19yf39DvuIMWdq0Lvt87b6
 zF60WX2s0m8ZHMVuJpOkzteOs5xZKalu0PN+1nCB8rK98f0qP1kHjDaHgbrzKOwD9MY2
 ULEZ9k1l3FDsqT2HsPRGMzxTA/Hspn0PDb5A28aSMd9r1SKsYTcRglLJUvobiqh/mi9w
 jChHfn2SZ/5ZN0PxrlG145tFy9iPEt+oOiKaJbASPvdqW6gFYnoFmZ8LRpjrZOpAeW3c
 yi+QptZj5l/PyV29c5ctqdUqlnt335/dGWqye/z2ZxgnEmC8PdOAj07BWkaA+OVF7DG8
 erpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkX+ImFxvy2Er/LQVBK1IC/XjJHqqFViFqe6JTlSwKYjSAVY7AkMhAINXQOqR0SYDqzr2VnarhdjT6fMsGvFw0bhKWvvI=
X-Gm-Message-State: AOJu0Yx4AH+UZHYwCyt9CnufCQuD63zaieh9r2xpL79YyoB/vNQSBVrR
 T5VxSLj5kGDmKgNURJ/T6dqbnsEL85jxEkOX7OVpkpeMZDbCa78NqvUWXMpgzHf0fqcFu3R6qIh
 5wJZE0Q83/JRXYFO4TNow9u5toKnCVaXuN9b/dA==
X-Google-Smtp-Source: AGHT+IEHfEqL3f91ARwwB+Kg3vXOm0jGu2h26/ZP/aHjgx4O/rBCA6JAXzNxRt7ZTMNA9fGTvZ8EMd0GGTlV1BBrrv0=
X-Received: by 2002:a17:906:af95:b0:a3e:dac1:bd4b with SMTP id
 mj21-20020a170906af9500b00a3edac1bd4bmr438689ejb.27.1708664351681; Thu, 22
 Feb 2024 20:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-4-hao.xiang@bytedance.com>
 <CAEr7rXj93Ng2zA9aM=MXgu7Pke2YJHjYHeao08L4jT2isZ53ZQ@mail.gmail.com>
In-Reply-To: <CAEr7rXj93Ng2zA9aM=MXgu7Pke2YJHjYHeao08L4jT2isZ53ZQ@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 20:59:00 -0800
Message-ID: <CAAYibXig_1rPhNama21Rwpq1V7AYaK=iSgWAEft6o_Ycjs4jvA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/7] migration/multifd: Zero page
 transmission on the multifd thread.
To: Elena Ufimtseva <ufimtseva@gmail.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 21, 2024 at 8:00=E2=80=AFAM Elena Ufimtseva <ufimtseva@gmail.co=
m> wrote:
>
>
>
> On Fri, Feb 16, 2024 at 2:42=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.co=
m> wrote:
>>
>> 1. Implements the zero page detection and handling on the multifd
>> threads for non-compression, zlib and zstd compression backends.
>> 2. Added a new value 'multifd' in ZeroPageDetection enumeration.
>> 3. Add proper asserts to ensure pages->normal are used for normal pages
>> in all scenarios.
>>
>> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> ---
>>  migration/meson.build         |  1 +
>>  migration/multifd-zero-page.c | 59 +++++++++++++++++++++++++++++++++++
>>  migration/multifd-zlib.c      | 26 ++++++++++++---
>>  migration/multifd-zstd.c      | 25 ++++++++++++---
>>  migration/multifd.c           | 50 +++++++++++++++++++++++------
>>  migration/multifd.h           |  7 +++++
>>  qapi/migration.json           |  4 ++-
>>  7 files changed, 151 insertions(+), 21 deletions(-)
>>  create mode 100644 migration/multifd-zero-page.c
>>
>> diff --git a/migration/meson.build b/migration/meson.build
>> index 92b1cc4297..1eeb915ff6 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -22,6 +22,7 @@ system_ss.add(files(
>>    'migration.c',
>>    'multifd.c',
>>    'multifd-zlib.c',
>> +  'multifd-zero-page.c',
>>    'ram-compress.c',
>>    'options.c',
>>    'postcopy-ram.c',
>> diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page=
.c
>> new file mode 100644
>> index 0000000000..f0cd8e2c53
>> --- /dev/null
>> +++ b/migration/multifd-zero-page.c
>> @@ -0,0 +1,59 @@
>> +/*
>> + * Multifd zero page detection implementation.
>> + *
>> + * Copyright (c) 2024 Bytedance Inc
>> + *
>> + * Authors:
>> + *  Hao Xiang <hao.xiang@bytedance.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>> +#include "exec/ramblock.h"
>> +#include "migration.h"
>> +#include "multifd.h"
>> +#include "options.h"
>> +#include "ram.h"
>> +
>> +void multifd_zero_page_check_send(MultiFDSendParams *p)
>> +{
>> +    /*
>> +     * QEMU older than 9.0 don't understand zero page
>> +     * on multifd channel. This switch is required to
>> +     * maintain backward compatibility.
>> +     */
>> +    bool use_multifd_zero_page =3D
>> +        (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_MULTI=
FD);
>> +    MultiFDPages_t *pages =3D p->pages;
>> +    RAMBlock *rb =3D pages->block;
>> +
>> +    assert(pages->num !=3D 0);
>
>
> Not needed, the check is done right before calling send_prepare.
>
>>
>> +    assert(pages->normal_num =3D=3D 0);
>> +    assert(pages->zero_num =3D=3D 0);
>
>
> Why these asserts are needed?

The idea is that when multifd_zero_page_check_send is called, I want
to make sure zero page checking was not processed on this packet
before. It is perhaps redundant. It won't compile in free build.

>>
>> +
>>
>> +    for (int i =3D 0; i < pages->num; i++) {
>> +        uint64_t offset =3D pages->offset[i];
>> +        if (use_multifd_zero_page &&
>> +            buffer_is_zero(rb->host + offset, p->page_size)) {
>> +            pages->zero[pages->zero_num] =3D offset;
>> +            pages->zero_num++;
>> +            ram_release_page(rb->idstr, offset);
>> +        } else {
>> +            pages->normal[pages->normal_num] =3D offset;
>> +            pages->normal_num++;
>> +        }
>> +    }
>> +}
>> +
>> +void multifd_zero_page_check_recv(MultiFDRecvParams *p)
>> +{
>> +    for (int i =3D 0; i < p->zero_num; i++) {
>> +        void *page =3D p->host + p->zero[i];
>> +        if (!buffer_is_zero(page, p->page_size)) {
>> +            memset(page, 0, p->page_size);
>> +        }
>> +    }
>> +}
>> diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
>> index 012e3bdea1..cdfe0fa70e 100644
>> --- a/migration/multifd-zlib.c
>> +++ b/migration/multifd-zlib.c
>> @@ -123,13 +123,20 @@ static int zlib_send_prepare(MultiFDSendParams *p,=
 Error **errp)
>>      int ret;
>>      uint32_t i;
>>
>> +    multifd_zero_page_check_send(p);
>> +
>> +    if (!pages->normal_num) {
>> +        p->next_packet_size =3D 0;
>> +        goto out;
>> +    }
>> +
>>      multifd_send_prepare_header(p);
>>
>> -    for (i =3D 0; i < pages->num; i++) {
>> +    for (i =3D 0; i < pages->normal_num; i++) {
>>          uint32_t available =3D z->zbuff_len - out_size;
>>          int flush =3D Z_NO_FLUSH;
>>
>> -        if (i =3D=3D pages->num - 1) {
>> +        if (i =3D=3D pages->normal_num - 1) {
>>              flush =3D Z_SYNC_FLUSH;
>>          }
>>
>> @@ -138,7 +145,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, E=
rror **errp)
>>           * with compression. zlib does not guarantee that this is safe,
>>           * therefore copy the page before calling deflate().
>>           */
>> -        memcpy(z->buf, p->pages->block->host + pages->offset[i], p->pag=
e_size);
>> +        memcpy(z->buf, p->pages->block->host + pages->normal[i], p->pag=
e_size);
>>          zs->avail_in =3D p->page_size;
>>          zs->next_in =3D z->buf;
>>
>> @@ -172,10 +179,10 @@ static int zlib_send_prepare(MultiFDSendParams *p,=
 Error **errp)
>>      p->iov[p->iovs_num].iov_len =3D out_size;
>>      p->iovs_num++;
>>      p->next_packet_size =3D out_size;
>> -    p->flags |=3D MULTIFD_FLAG_ZLIB;
>>
>> +out:
>> +    p->flags |=3D MULTIFD_FLAG_ZLIB;
>>      multifd_send_fill_packet(p);
>> -
>
> Spurious?

We need to set the flag anyway otherwise the receiver side will complain.

>
>>      return 0;
>>  }
>>
>> @@ -261,6 +268,14 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Er=
ror **errp)
>>                     p->id, flags, MULTIFD_FLAG_ZLIB);
>>          return -1;
>>      }
>> +
>> +    multifd_zero_page_check_recv(p);
>> +
>> +    if (!p->normal_num) {
>> +        assert(in_size =3D=3D 0);
>> +        return 0;
>
>
> return here will have no effect. Also, why is assert needed here?

We return here so we don't end up calling qio_channel_read_all with
buflen =3D 0. The assert makes sure that normal_num/next_packet_size
states are consistent.

> This change also does not seem to fit the description of the patch, proba=
by separate patch will be better.

These changes are needed to ensure basic functionalities are working
after enabling the multifd zero page format.

>
>>
>> +    }
>> +
>>      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp)=
;
>>
>>      if (ret !=3D 0) {
>> @@ -310,6 +325,7 @@ static int zlib_recv_pages(MultiFDRecvParams *p, Err=
or **errp)
>>                     p->id, out_size, expected_size);
>>          return -1;
>>      }
>> +
>>      return 0;
>>  }
>>
>> diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
>> index dc8fe43e94..27a1eba075 100644
>> --- a/migration/multifd-zstd.c
>> +++ b/migration/multifd-zstd.c
>> @@ -118,19 +118,26 @@ static int zstd_send_prepare(MultiFDSendParams *p,=
 Error **errp)
>>      int ret;
>>      uint32_t i;
>>
>> +    multifd_zero_page_check_send(p);
>> +
>> +    if (!pages->normal_num) {
>> +        p->next_packet_size =3D 0;
>> +        goto out;
>> +    }
>> +
>>      multifd_send_prepare_header(p);
>>
>>      z->out.dst =3D z->zbuff;
>>      z->out.size =3D z->zbuff_len;
>>      z->out.pos =3D 0;
>>
>> -    for (i =3D 0; i < pages->num; i++) {
>> +    for (i =3D 0; i < pages->normal_num; i++) {
>>          ZSTD_EndDirective flush =3D ZSTD_e_continue;
>>
>> -        if (i =3D=3D pages->num - 1) {
>> +        if (i =3D=3D pages->normal_num - 1) {
>>              flush =3D ZSTD_e_flush;
>>          }
>> -        z->in.src =3D p->pages->block->host + pages->offset[i];
>> +        z->in.src =3D p->pages->block->host + pages->normal[i];
>>          z->in.size =3D p->page_size;
>>          z->in.pos =3D 0;
>>
>> @@ -161,10 +168,10 @@ static int zstd_send_prepare(MultiFDSendParams *p,=
 Error **errp)
>>      p->iov[p->iovs_num].iov_len =3D z->out.pos;
>>      p->iovs_num++;
>>      p->next_packet_size =3D z->out.pos;
>> -    p->flags |=3D MULTIFD_FLAG_ZSTD;
>>
>> +out:
>> +    p->flags |=3D MULTIFD_FLAG_ZSTD;
>>      multifd_send_fill_packet(p);
>> -
>
> Spurious removal.

Can you elaborate on this?

>
>>
>>      return 0;
>>  }
>>
>> @@ -257,6 +264,14 @@ static int zstd_recv_pages(MultiFDRecvParams *p, Er=
ror **errp)
>>                     p->id, flags, MULTIFD_FLAG_ZSTD);
>>          return -1;
>>      }
>> +
>> +    multifd_zero_page_check_recv(p);
>> +
>> +    if (!p->normal_num) {
>> +        assert(in_size =3D=3D 0);
>> +        return 0;
>> +    }
>> +
>
> Same question here about assert.
>
>>
>>      ret =3D qio_channel_read_all(p->c, (void *)z->zbuff, in_size, errp)=
;
>>
>>      if (ret !=3D 0) {
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index a33dba40d9..fbb40ea10b 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -11,6 +11,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "qemu/rcu.h"
>>  #include "exec/target_page.h"
>>  #include "sysemu/sysemu.h"
>> @@ -126,6 +127,8 @@ static int nocomp_send_prepare(MultiFDSendParams *p,=
 Error **errp)
>>      MultiFDPages_t *pages =3D p->pages;
>>      int ret;
>>
>> +    multifd_zero_page_check_send(p);
>> +
>>      if (!use_zero_copy_send) {
>>          /*
>>           * Only !zerocopy needs the header in IOV; zerocopy will
>> @@ -134,13 +137,13 @@ static int nocomp_send_prepare(MultiFDSendParams *=
p, Error **errp)
>>          multifd_send_prepare_header(p);
>>      }
>>
>> -    for (int i =3D 0; i < pages->num; i++) {
>> -        p->iov[p->iovs_num].iov_base =3D pages->block->host + pages->of=
fset[i];
>> +    for (int i =3D 0; i < pages->normal_num; i++) {
>> +        p->iov[p->iovs_num].iov_base =3D pages->block->host + pages->no=
rmal[i];
>>          p->iov[p->iovs_num].iov_len =3D p->page_size;
>>          p->iovs_num++;
>>      }
>>
>> -    p->next_packet_size =3D pages->num * p->page_size;
>> +    p->next_packet_size =3D pages->normal_num * p->page_size;
>>      p->flags |=3D MULTIFD_FLAG_NOCOMP;
>>
>>      multifd_send_fill_packet(p);
>> @@ -202,6 +205,13 @@ static int nocomp_recv_pages(MultiFDRecvParams *p, =
Error **errp)
>>                     p->id, flags, MULTIFD_FLAG_NOCOMP);
>>          return -1;
>>      }
>> +
>> +    multifd_zero_page_check_recv(p);
>> +
>> +    if (!p->normal_num) {
>> +        return 0;
>> +    }
>> +
>>      for (int i =3D 0; i < p->normal_num; i++) {
>>          p->iov[i].iov_base =3D p->host + p->normal[i];
>>          p->iov[i].iov_len =3D p->page_size;
>> @@ -339,7 +349,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>>
>>      packet->flags =3D cpu_to_be32(p->flags);
>>      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
>> -    packet->normal_pages =3D cpu_to_be32(pages->num);
>> +    packet->normal_pages =3D cpu_to_be32(pages->normal_num);
>>      packet->zero_pages =3D cpu_to_be32(pages->zero_num);
>>      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
>>
>> @@ -350,18 +360,25 @@ void multifd_send_fill_packet(MultiFDSendParams *p=
)
>>          strncpy(packet->ramblock, pages->block->idstr, 256);
>>      }
>>
>> -    for (i =3D 0; i < pages->num; i++) {
>> +    for (i =3D 0; i < pages->normal_num; i++) {
>>          /* there are architectures where ram_addr_t is 32 bit */
>> -        uint64_t temp =3D pages->offset[i];
>> +        uint64_t temp =3D pages->normal[i];
>>
>>          packet->offset[i] =3D cpu_to_be64(temp);
>>      }
>>
>> +    for (i =3D 0; i < pages->zero_num; i++) {
>> +        /* there are architectures where ram_addr_t is 32 bit */
>> +        uint64_t temp =3D pages->zero[i];
>> +
>> +        packet->offset[pages->normal_num + i] =3D cpu_to_be64(temp);
>> +    }
>> +
>>      p->packets_sent++;
>> -    p->total_normal_pages +=3D pages->num;
>> +    p->total_normal_pages +=3D pages->normal_num;
>>      p->total_zero_pages +=3D pages->zero_num;
>>
>> -    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_num,
>> +    trace_multifd_send(p->id, packet_num, pages->normal_num, pages->zer=
o_num,
>>                         p->flags, p->next_packet_size);
>>  }
>>
>> @@ -451,6 +468,18 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
>>          p->normal[i] =3D offset;
>>      }
>>
>> +    for (i =3D 0; i < p->zero_num; i++) {
>> +        uint64_t offset =3D be64_to_cpu(packet->offset[p->normal_num + =
i]);
>> +
>> +        if (offset > (p->block->used_length - p->page_size)) {
>> +            error_setg(errp, "multifd: offset too long %" PRIu64
>> +                       " (max " RAM_ADDR_FMT ")",
>> +                       offset, p->block->used_length);
>> +            return -1;
>> +        }
>> +        p->zero[i] =3D offset;
>> +    }
>> +
>>      return 0;
>>  }
>>
>> @@ -842,7 +871,7 @@ static void *multifd_send_thread(void *opaque)
>>
>>              stat64_add(&mig_stats.multifd_bytes,
>>                         p->next_packet_size + p->packet_len);
>> -            stat64_add(&mig_stats.normal_pages, pages->num);
>> +            stat64_add(&mig_stats.normal_pages, pages->normal_num);
>>              stat64_add(&mig_stats.zero_pages, pages->zero_num);
>>
>>              multifd_pages_reset(p->pages);
>> @@ -1256,7 +1285,8 @@ static void *multifd_recv_thread(void *opaque)
>>          p->flags &=3D ~MULTIFD_FLAG_SYNC;
>>          qemu_mutex_unlock(&p->mutex);
>>
>> -        if (p->normal_num) {
>> +        if (p->normal_num + p->zero_num) {
>> +            assert(!(flags & MULTIFD_FLAG_SYNC));
>
> This assertion seems to be not relevant to this patch. Could you post it =
separately and explain why it's needed here?

I thought this is nice to have because it ensures that sync packet and
data packet are mutually exclusive. I agree this is not needed for
things to work but does this deserve its own patch?

>
>>
>>              ret =3D multifd_recv_state->ops->recv_pages(p, &local_err);
>>              if (ret !=3D 0) {
>>                  break;
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index 9822ff298a..125f0bbe60 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -53,6 +53,11 @@ typedef struct {
>>      uint32_t unused32[1];    /* Reserved for future use */
>>      uint64_t unused64[3];    /* Reserved for future use */
>>      char ramblock[256];
>> +    /*
>> +     * This array contains the pointers to:
>> +     *  - normal pages (initial normal_pages entries)
>> +     *  - zero pages (following zero_pages entries)
>> +     */
>>      uint64_t offset[];
>>  } __attribute__((packed)) MultiFDPacket_t;
>>
>> @@ -224,6 +229,8 @@ typedef struct {
>>
>>  void multifd_register_ops(int method, MultiFDMethods *ops);
>>  void multifd_send_fill_packet(MultiFDSendParams *p);
>> +void multifd_zero_page_check_send(MultiFDSendParams *p);
>> +void multifd_zero_page_check_recv(MultiFDRecvParams *p);
>>
>>  static inline void multifd_send_prepare_header(MultiFDSendParams *p)
>>  {
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 99843a8e95..e2450b92d4 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -660,9 +660,11 @@
>>  #
>>  # @none: Do not perform zero page checking.
>>  #
>> +# @multifd: Perform zero page checking on the multifd sender thread. (s=
ince 9.0)
>> +#
>>  ##
>>  { 'enum': 'ZeroPageDetection',
>> -  'data': [ 'legacy', 'none' ] }
>> +  'data': [ 'legacy', 'none', 'multifd' ] }
>>
>>  ##
>>  # @BitmapMigrationBitmapAliasTransform:
>> --
>> 2.30.2
>>
>>
>
>
> --
> Elena

