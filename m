Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62104C5472C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 20:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sigcV-0001eS-Ne; Mon, 26 Aug 2024 16:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sigcR-0001dk-5r
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:47:19 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sigcO-0001rx-OI
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:47:18 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a868b739cd9so575195666b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724705233; x=1725310033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EmNUbWN3L7bNAjIpWx76uXYrmDJBWu5r+10QBHC/Dxo=;
 b=IYc66RIUbhqT1K3NqOwuaeeXfPlPPUoLcOkT+yBBtYmgNE6M/jDqS8Duchy6VTD/xf
 MAsxwCS3sqjfcX7fG6lzUbw94vhHr+p0QpscV/O6gP6jqYvpkpU0Z9N+hL2HMLtnQehc
 qBvkUty1egKmktmoAk4C8W5tnbBBb2Sg+fbvROLUti4ZzO+iUL3Wdd1TL7zA2gzU6r/a
 1a+gRJVNU9uI5WX9BCc6oweVxk17P9GdII0I6aj2TLEo3JG6KbXr2ChlMmQIn4KCEPrh
 qB9ncHvw/FtBlFRu7rO0KinvDo7Vag4wjc6FNgmXR112FpBicpi+h4IU5YNkSCD+Jvqn
 Cb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724705233; x=1725310033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EmNUbWN3L7bNAjIpWx76uXYrmDJBWu5r+10QBHC/Dxo=;
 b=gbZWRqxCbUU7Mcn2ZlMPWxP7b6eak3wmZGv1Go6oM4YvkXwOC/maqkbUec8BnfeGbV
 TJYt2MkIVPUlHBGm22ZgYHmztJtEmYFYuJ4VYjp/bWzS1rzK/bPx/vxAzoiKP8KCD3MJ
 9Hq06fU0MWu75I+FTtSnhA8iEtN/pdTq20/MYEVU8tWGjz14cVpFMz9tRns+2j2N2368
 YDC2vC9Ek1J2eqQz7jcHsi3oJnJK0s5WwTv5pMBUaHihsY7WGbSyZLE1XdGxKpDgHJkn
 WWmEsVVH4QONa1rkgosLIG3R8bssb3bZdt4C+ZqhPGym84G3JfX2QMSEeyEQxCyReVM+
 MU+g==
X-Gm-Message-State: AOJu0YxIaHetHYmSKVKPjvfTheW0py+12fH2uSjXb25dRwXJnVQONhbp
 erJXcCLdITDvvR9vh/IPLq/Y1txLWCLtzrD8kMIkR1lIh6OnTAvJ+iKYQZhV2v4=
X-Google-Smtp-Source: AGHT+IHMG72KEAHzwWr8MrL24exoQRM/F3UdYQpEnb/oaG/xMDtidxsTT1w2Orx9oF1wZZZa7fRaWw==
X-Received: by 2002:a17:907:2cc6:b0:a86:7021:1368 with SMTP id
 a640c23a62f3a-a86e39dc9b2mr51400666b.21.1724705232762; 
 Mon, 26 Aug 2024 13:47:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb471d7bsm172231a12.59.2024.08.26.13.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 13:47:12 -0700 (PDT)
Message-ID: <ee8d01b4-50e3-42c6-aa86-233021ea3423@linaro.org>
Date: Mon, 26 Aug 2024 22:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/18] migration/multifd: Stop changing the packet on
 recv side
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20240826195322.16532-1-farosas@suse.de>
 <20240826195322.16532-19-farosas@suse.de> <ZszhkJ6Ydqr6JY98@x1n>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZszhkJ6Ydqr6JY98@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 26/8/24 22:12, Peter Xu wrote:
> On Mon, Aug 26, 2024 at 04:53:22PM -0300, Fabiano Rosas wrote:
>> As observed by Philippe, the multifd_ram_unfill_packet() function
>> currently leaves the MultiFDPacket structure with mixed
>> endianness. This is harmless, but ultimately not very clean. Aside
>> from that, the packet is also written to on the recv side to ensure
>> the ramblock name is null-terminated.
>>
>> Stop touching the received packet and do the necessary work using
>> stack variables instead.
>>
>> While here tweak the error strings and fix the space before
>> semicolons. Also remove the "100 times bigger" comment because it's
>> just one possible explanation for a size mismatch and it doesn't even
>> match the code.
>>
>> CC: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   migration/multifd-nocomp.c | 38 ++++++++++++++++----------------------
>>   migration/multifd.c        | 18 ++++++++----------
>>   2 files changed, 24 insertions(+), 32 deletions(-)
>>
>> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
>> index f294d1b0b2..0cbf1b88e1 100644
>> --- a/migration/multifd-nocomp.c
>> +++ b/migration/multifd-nocomp.c
>> @@ -220,33 +220,29 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>       MultiFDPacket_t *packet = p->packet;
>>       uint32_t page_count = multifd_ram_page_count();
>>       uint32_t page_size = multifd_ram_page_size();
>> +    uint32_t pages_per_packet = be32_to_cpu(packet->pages_alloc);
>> +    const char *ramblock_name;
>>       int i;
>>   
>> -    packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
>> -    /*
>> -     * If we received a packet that is 100 times bigger than expected
>> -     * just stop migration.  It is a magic number.
>> -     */
>> -    if (packet->pages_alloc > page_count) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "with size %u and expected a size of %u",
>> -                   packet->pages_alloc, page_count) ;
>> +    if (pages_per_packet > page_count) {
>> +        error_setg(errp, "multifd: received packet with %u pages, expected %u",
>> +                   pages_per_packet, page_count);
>>           return -1;
>>       }
>>   
>>       p->normal_num = be32_to_cpu(packet->normal_pages);
>> -    if (p->normal_num > packet->pages_alloc) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "with %u normal pages and expected maximum pages are %u",
>> -                   p->normal_num, packet->pages_alloc) ;
>> +    if (p->normal_num > pages_per_packet) {
>> +        error_setg(errp, "multifd: received packet with %u non-zero pages, "
>> +                   "which exceeds maximum expected pages %u",
>> +                   p->normal_num, pages_per_packet);
>>           return -1;
>>       }
>>   
>>       p->zero_num = be32_to_cpu(packet->zero_pages);
>> -    if (p->zero_num > packet->pages_alloc - p->normal_num) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "with %u zero pages and expected maximum zero pages are %u",
>> -                   p->zero_num, packet->pages_alloc - p->normal_num) ;
>> +    if (p->zero_num > pages_per_packet - p->normal_num) {
>> +        error_setg(errp,
>> +                   "multifd: received packet with %u zero pages, expected maximum %u",
>> +                   p->zero_num, pages_per_packet - p->normal_num);
>>           return -1;
>>       }
>>   
>> @@ -254,12 +250,10 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>           return 0;
>>       }
>>   
>> -    /* make sure that ramblock is 0 terminated */
>> -    packet->ramblock[255] = 0;
>> -    p->block = qemu_ram_block_by_name(packet->ramblock);
>> +    ramblock_name = g_strndup(packet->ramblock, 255);
> 
> This one is leaked?
> 
> IMHO the "temp var for endianess" is better justified than this specific
> one, where I think always null-terminating the packet->ramblock[] doesn't
> sound too bad - it makes sure all future ref to packet->ramblock is safe.

OTOH we can make MultiFDPacket_t const to be sure we don't alter it:

-- >8 --
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 0cbf1b88e1..a759470c9c 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -217,11 +217,11 @@ void multifd_ram_fill_packet(MultiFDSendParams *p)

  int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
  {
-    MultiFDPacket_t *packet = p->packet;
+    const MultiFDPacket_t *packet = p->packet;
      uint32_t page_count = multifd_ram_page_count();
      uint32_t page_size = multifd_ram_page_size();
      uint32_t pages_per_packet = be32_to_cpu(packet->pages_alloc);
-    const char *ramblock_name;
+    g_autofree const char *ramblock_name = NULL;
      int i;

      if (pages_per_packet > page_count) {
diff --git a/migration/multifd.c b/migration/multifd.c
index 256ecdea56..2a8cd9174c 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -230,7 +230,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)

  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
  {
-    MultiFDPacket_t *packet = p->packet;
+    const MultiFDPacket_t *packet = p->packet;
      uint32_t magic = be32_to_cpu(packet->magic);
      uint32_t version = be32_to_cpu(packet->version);
      int ret = 0;
---

> 
>> +    p->block = qemu_ram_block_by_name(ramblock_name);
>>       if (!p->block) {
>> -        error_setg(errp, "multifd: unknown ram block %s",
>> -                   packet->ramblock);
>> +        error_setg(errp, "multifd: unknown ram block %s", ramblock_name);
>>           return -1;
>>       }
>>   
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index b89715fdc2..256ecdea56 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -231,21 +231,19 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>>   static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>   {
>>       MultiFDPacket_t *packet = p->packet;
>> +    uint32_t magic = be32_to_cpu(packet->magic);
>> +    uint32_t version = be32_to_cpu(packet->version);
>>       int ret = 0;
>>   
>> -    packet->magic = be32_to_cpu(packet->magic);
>> -    if (packet->magic != MULTIFD_MAGIC) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "magic %x and expected magic %x",
>> -                   packet->magic, MULTIFD_MAGIC);
>> +    if (magic != MULTIFD_MAGIC) {
>> +        error_setg(errp, "multifd: received packet magic %x, expected %x",
>> +                   magic, MULTIFD_MAGIC);
>>           return -1;
>>       }
>>   
>> -    packet->version = be32_to_cpu(packet->version);
>> -    if (packet->version != MULTIFD_VERSION) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "version %u and expected version %u",
>> -                   packet->version, MULTIFD_VERSION);
>> +    if (version != MULTIFD_VERSION) {
>> +        error_setg(errp, "multifd: received packet version %u, expected %u",
>> +                   version, MULTIFD_VERSION);
>>           return -1;
>>       }
>>   
>> -- 
>> 2.35.3
>>
> 


