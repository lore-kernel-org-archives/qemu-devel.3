Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77605C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdN1B-0001Tw-VI; Thu, 22 Feb 2024 23:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdN17-0001TY-Tv
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:18:33 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rdN14-0006G2-Tn
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 23:18:33 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-564e4df00f3so411017a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 20:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708661904; x=1709266704; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaHbJ1rxncSRzCSI0nO3XpJqJHNyJuklks3j6VhVtRo=;
 b=YDtkBboCSdBpPjYcFWzM5T63fR4tEViy1yRPBquD6x41tzrIWDe+8yboYmOI0qS0Hn
 Cp5daosZ4mSVao1sx6R/FqZTVJDs2RHRsOW5eQjU6ynvK9LeGT7KyDgRzks4nESYsvOF
 nvt1MipE70lHD9jSrHOOz08hwFxl75OINMYLy9Fd+XiCr+6hgzFFpx7hJ7JMWdxmAICV
 cMLuCKETstqc26FB10zjl0x34Wj1BJnaaRxR+UU+YXvkITcmBOuL7xnVs7T6eNVUXuqm
 liyY3hayqzV8GyFjLmtAggnbuwiC0VxfzzvcoSpLsDNtfuJqBeKcgPMatplFZqyUEu7j
 KLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708661904; x=1709266704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EaHbJ1rxncSRzCSI0nO3XpJqJHNyJuklks3j6VhVtRo=;
 b=Tn13624QPwEJWXyAqihW7+VwCAPz9hmVXl13TbrZb7BGXTz4POY47fgoeHNG6tx4hQ
 sQ8K1DXf5CcKspRp9qtP2cR4mMUwPQWpR+nUp/BR3cwIWEh8NdUF+JwVslauHuUMlJP7
 9QvJXGuD+lI9AYoOWCmlD17Nxafjy7Iq5V5R0RWleiMsTvmY1sJYkP7yd4NOhfnXfGZf
 NkdHcB3/4QtH+zeM5YLYLMUA9BsjDnNDcLGWNiSwuhTddkiIB5M5kki+2KIdIfdM/igD
 r4Ybm2DLo9MIbnL55Ds/eG0pn8sglCbVbeW29/BYGR8JUlLkhYcFyBWoU3Yo99KSAWZ8
 bs7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZNyB8hwirTEA2pgb5SfoC1Aot/W+36phjClMs6QPqx0KDDvtiq5SomLyHArY2n58C/IIHvDw+BXaPqC2W17BOYbjbX8I=
X-Gm-Message-State: AOJu0YwGqJehZU+Ge/MQP9+2Mmdc9flRRJgPlv2Kl7mtJbyhSNuOFu7c
 /SYsfQBRwtoB9Ibhxsf5Y7UZjoSeLWAKaxqXU4joEyke2o+7kVqJ5FZoHUzG+900YF2e7UYax9K
 wlJ4DBN8k8bnI5G0kr/+tAiCxDZI0xOREXdPURw==
X-Google-Smtp-Source: AGHT+IET4UXPUnNMX/asY0/RV8hYGwdDafqJpaYYDvKP/pQ6fIDFFLiunN/C1x0swQYfDvdtjRaDV0jnLdGpdMqvhV8=
X-Received: by 2002:a17:906:6dc1:b0:a3e:a0cd:5c4b with SMTP id
 j1-20020a1709066dc100b00a3ea0cd5c4bmr345371ejt.55.1708661904139; Thu, 22 Feb
 2024 20:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-3-hao.xiang@bytedance.com>
 <CAEr7rXjCqe0j8HgVz_Jg3mUasipdz3RXvrkf7p1KZMCMLdCzxw@mail.gmail.com>
In-Reply-To: <CAEr7rXjCqe0j8HgVz_Jg3mUasipdz3RXvrkf7p1KZMCMLdCzxw@mail.gmail.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 22 Feb 2024 20:18:13 -0800
Message-ID: <CAAYibXgvRsSyZHCMaZM+bk=O-zR18qoS7zCiiWsFSMZv2UTepw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/7] migration/multifd: Support for zero
 pages transmission in multifd format.
To: Elena Ufimtseva <ufimtseva@gmail.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x530.google.com
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

On Wed, Feb 21, 2024 at 7:37=E2=80=AFAM Elena Ufimtseva <ufimtseva@gmail.co=
m> wrote:
>
>
>
> On Fri, Feb 16, 2024 at 2:41=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.co=
m> wrote:
>>
>> This change adds zero page counters and updates multifd send/receive
>> tracing format to track the newly added counters.
>>
>> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> ---
>>  migration/multifd.c    | 43 ++++++++++++++++++++++++++++++++++--------
>>  migration/multifd.h    | 21 ++++++++++++++++++++-
>>  migration/ram.c        |  1 -
>>  migration/trace-events |  8 ++++----
>>  4 files changed, 59 insertions(+), 14 deletions(-)
>>
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index adfe8c9a0a..a33dba40d9 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -236,6 +236,8 @@ static void multifd_pages_reset(MultiFDPages_t *page=
s)
>>       * overwritten later when reused.
>>       */
>>      pages->num =3D 0;
>> +    pages->normal_num =3D 0;
>> +    pages->zero_num =3D 0;
>>      pages->block =3D NULL;
>>  }
>>
>>
>> @@ -309,6 +311,8 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n=
)
>>
>>      pages->allocated =3D n;
>>      pages->offset =3D g_new0(ram_addr_t, n);
>> +    pages->normal =3D g_new0(ram_addr_t, n);
>> +    pages->zero =3D g_new0(ram_addr_t, n);
>>
>>
>>      return pages;
>>  }
>> @@ -319,6 +323,10 @@ static void multifd_pages_clear(MultiFDPages_t *pag=
es)
>>      pages->allocated =3D 0;
>>      g_free(pages->offset);
>>      pages->offset =3D NULL;
>> +    g_free(pages->normal);
>> +    pages->normal =3D NULL;
>> +    g_free(pages->zero);
>> +    pages->zero =3D NULL;
>>      g_free(pages);
>>  }
>>
>> @@ -332,6 +340,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>>      packet->flags =3D cpu_to_be32(p->flags);
>>      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
>>      packet->normal_pages =3D cpu_to_be32(pages->num);
>> +    packet->zero_pages =3D cpu_to_be32(pages->zero_num);
>>      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
>>
>>      packet_num =3D qatomic_fetch_inc(&multifd_send_state->packet_num);
>> @@ -350,9 +359,10 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>>
>>      p->packets_sent++;
>>      p->total_normal_pages +=3D pages->num;
>> +    p->total_zero_pages +=3D pages->zero_num;
>>
>> -    trace_multifd_send(p->id, packet_num, pages->num, p->flags,
>> -                       p->next_packet_size);
>> +    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_num,
>> +                       p->flags, p->next_packet_size);
>>  }
>>
>>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **err=
p)
>> @@ -393,20 +403,29 @@ static int multifd_recv_unfill_packet(MultiFDRecvP=
arams *p, Error **errp)
>>      p->normal_num =3D be32_to_cpu(packet->normal_pages);
>>      if (p->normal_num > packet->pages_alloc) {
>>          error_setg(errp, "multifd: received packet "
>> -                   "with %u pages and expected maximum pages are %u",
>> +                   "with %u normal pages and expected maximum pages are=
 %u",
>>                     p->normal_num, packet->pages_alloc) ;
>>          return -1;
>>      }
>>
>> +    p->zero_num =3D be32_to_cpu(packet->zero_pages);
>> +    if (p->zero_num > packet->pages_alloc - p->normal_num) {
>> +        error_setg(errp, "multifd: received packet "
>> +                   "with %u zero pages and expected maximum zero pages =
are %u",
>> +                   p->zero_num, packet->pages_alloc - p->normal_num) ;
>> +        return -1;
>> +    }
>
>
> You could probably combine this check with normal_num against pages_alloc=
.
>>
>> +
>>      p->next_packet_size =3D be32_to_cpu(packet->next_packet_size);
>>      p->packet_num =3D be64_to_cpu(packet->packet_num);
>>      p->packets_recved++;
>>      p->total_normal_pages +=3D p->normal_num;
>> +    p->total_zero_pages +=3D p->zero_num;
>>
>> -    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->flags,
>> -                       p->next_packet_size);
>> +    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num=
,
>> +                       p->flags, p->next_packet_size);
>>
>> -    if (p->normal_num =3D=3D 0) {
>> +    if (p->normal_num =3D=3D 0 && p->zero_num =3D=3D 0) {
>>          return 0;
>>      }
>>
>> @@ -823,6 +842,8 @@ static void *multifd_send_thread(void *opaque)
>>
>>              stat64_add(&mig_stats.multifd_bytes,
>>                         p->next_packet_size + p->packet_len);
>> +            stat64_add(&mig_stats.normal_pages, pages->num);
>
>
> That seems wrong. pages->num is the number of pages total in the packet.
> But next patch changes it, so I suggest or change it here and not in 3/7.

In this patch, multifd zero pages are not enabled yet. So pages->num
are the number of normal pages not pages total in the packet. The zero
pages were send in a different format in save_zero_page. Later on,
when multifd zero page is enabled, pages->normal_num counts the number
of normal pages and hence the accounting is changed.

>
>> +            stat64_add(&mig_stats.zero_pages, pages->zero_num);
>>
>>              multifd_pages_reset(p->pages);
>>              p->next_packet_size =3D 0;
>> @@ -866,7 +887,8 @@ out:
>>
>>      rcu_unregister_thread();
>>      migration_threads_remove(thread);
>> -    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_norm=
al_pages);
>> +    trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_norm=
al_pages,
>> +                                  p->total_zero_pages);
>>
>>      return NULL;
>>  }
>> @@ -1132,6 +1154,8 @@ static void multifd_recv_cleanup_channel(MultiFDRe=
cvParams *p)
>>      p->iov =3D NULL;
>>      g_free(p->normal);
>>      p->normal =3D NULL;
>> +    g_free(p->zero);
>> +    p->zero =3D NULL;
>>      multifd_recv_state->ops->recv_cleanup(p);
>>  }
>>
>> @@ -1251,7 +1275,9 @@ static void *multifd_recv_thread(void *opaque)
>>      }
>>
>>      rcu_unregister_thread();
>> -    trace_multifd_recv_thread_end(p->id, p->packets_recved, p->total_no=
rmal_pages);
>> +    trace_multifd_recv_thread_end(p->id, p->packets_recved,
>> +                                  p->total_normal_pages,
>> +                                  p->total_zero_pages);
>>
>>      return NULL;
>>  }
>> @@ -1290,6 +1316,7 @@ int multifd_recv_setup(Error **errp)
>>          p->name =3D g_strdup_printf("multifdrecv_%d", i);
>>          p->iov =3D g_new0(struct iovec, page_count);
>>          p->normal =3D g_new0(ram_addr_t, page_count);
>> +        p->zero =3D g_new0(ram_addr_t, page_count);
>>          p->page_count =3D page_count;
>>          p->page_size =3D qemu_target_page_size();
>>      }
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index 8a1cad0996..9822ff298a 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -48,7 +48,10 @@ typedef struct {
>>      /* size of the next packet that contains pages */
>>      uint32_t next_packet_size;
>>      uint64_t packet_num;
>> -    uint64_t unused[4];    /* Reserved for future use */
>> +    /* zero pages */
>> +    uint32_t zero_pages;
>> +    uint32_t unused32[1];    /* Reserved for future use */
>> +    uint64_t unused64[3];    /* Reserved for future use */
>>      char ramblock[256];
>>      uint64_t offset[];
>>  } __attribute__((packed)) MultiFDPacket_t;
>> @@ -56,10 +59,18 @@ typedef struct {
>>  typedef struct {
>>      /* number of used pages */
>>      uint32_t num;
>> +    /* number of normal pages */
>> +    uint32_t normal_num;
>> +    /* number of zero pages */
>> +    uint32_t zero_num;
>>      /* number of allocated pages */
>>      uint32_t allocated;
>>      /* offset of each page */
>>      ram_addr_t *offset;
>> +    /* offset of normal page */
>> +    ram_addr_t *normal;
>> +    /* offset of zero page */
>> +    ram_addr_t *zero;
>>      RAMBlock *block;
>>  } MultiFDPages_t;
>>
>> @@ -124,6 +135,8 @@ typedef struct {
>>      uint64_t packets_sent;
>>      /* non zero pages sent through this channel */
>>      uint64_t total_normal_pages;
>> +    /* zero pages sent through this channel */
>> +    uint64_t total_zero_pages;
>
>
> Can we initialize these to zero when threads are being set up?
> Also, I have a strong desire to rename these.. later.

When MultiFDSendParams are allocated in multifd_send_setup, g_new0
will initialize them to zero.

>
>>
>>      /* buffers to send */
>>      struct iovec *iov;
>>      /* number of iovs used */
>> @@ -178,12 +191,18 @@ typedef struct {
>>      uint8_t *host;
>>      /* non zero pages recv through this channel */
>>      uint64_t total_normal_pages;
>> +    /* zero pages recv through this channel */
>> +    uint64_t total_zero_pages;
>>      /* buffers to recv */
>>      struct iovec *iov;
>>      /* Pages that are not zero */
>>      ram_addr_t *normal;
>>      /* num of non zero pages */
>>      uint32_t normal_num;
>> +    /* Pages that are zero */
>> +    ram_addr_t *zero;
>> +    /* num of zero pages */
>> +    uint32_t zero_num;
>>      /* used for de-compression methods */
>>      void *data;
>>  } MultiFDRecvParams;
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 556725c30f..5ece9f042e 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1259,7 +1259,6 @@ static int ram_save_multifd_page(RAMBlock *block, =
ram_addr_t offset)
>>      if (!multifd_queue_page(block, offset)) {
>>          return -1;
>>      }
>> -    stat64_add(&mig_stats.normal_pages, 1);
>>
>>      return 1;
>>  }
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 298ad2b0dd..9f1d7ae71a 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -128,21 +128,21 @@ postcopy_preempt_reset_channel(void) ""
>>  # multifd.c
>>  multifd_new_send_channel_async(uint8_t id) "channel %u"
>>  multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=3D=
%u err=3D%p"
>> -multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t f=
lags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " pages %=
u flags 0x%x next packet size %u"
>> +multifd_recv(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t=
 zero, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %"=
 PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
>>  multifd_recv_new_channel(uint8_t id) "channel %u"
>>  multifd_recv_sync_main(long packet_num) "packet num %ld"
>>  multifd_recv_sync_main_signal(uint8_t id) "channel %u"
>>  multifd_recv_sync_main_wait(uint8_t id) "channel %u"
>>  multifd_recv_terminate_threads(bool error) "error %d"
>> -multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "=
channel %u packets %" PRIu64 " pages %" PRIu64
>> +multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t normal_p=
ages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %" =
PRIu64 " zero pages %" PRIu64
>>  multifd_recv_thread_start(uint8_t id) "%u"
>> -multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t=
 flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " norma=
l pages %u flags 0x%x next packet size %u"
>> +multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages, ui=
nt32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel %u p=
acket_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next packet =
size %u"
>>  multifd_send_error(uint8_t id) "channel %u"
>>  multifd_send_sync_main(long packet_num) "packet num %ld"
>>  multifd_send_sync_main_signal(uint8_t id) "channel %u"
>>  multifd_send_sync_main_wait(uint8_t id) "channel %u"
>>  multifd_send_terminate_threads(void) ""
>> -multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_p=
ages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
>> +multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_p=
ages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal pages %" =
 PRIu64 " zero pages %"  PRIu64
>>  multifd_send_thread_start(uint8_t id) "%u"
>>  multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char =
*hostname) "ioc=3D%p tioc=3D%p hostname=3D%s"
>>  multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=
=3D%p err=3D%s"
>> --
>> 2.30.2
>>
>>
>
>
> --
> Elena

