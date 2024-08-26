Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C306C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 20:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sigBW-0002Wi-8K; Mon, 26 Aug 2024 16:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sigBV-0002WC-Aa
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:19:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sigBS-0005bX-AS
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:19:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 51D0C1F8B5;
 Mon, 26 Aug 2024 20:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724703564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7feimIoJGv2rvhbgHuqob40zVArZNC1v7FYkNCbrfc=;
 b=sk6zyRcZi++v+keXHW8NAjlAthAgxUUfZgv6dsM/MOMzmkPqqm4MuqK7jrd5facDu7YixT
 glwRRvsizzfQr+xXqUonuLMiGZ4PABfMrIw8bvVcPa5UnJv4iLv3ptmIcCL/akdyDeL55G
 NtTBdz5lhr9HIohuNlm2L8CdDB6HQOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724703564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7feimIoJGv2rvhbgHuqob40zVArZNC1v7FYkNCbrfc=;
 b=/mBZVIfWWymAeopIckz15mdNRnCYDcByhkDlnRe9OvC09hnqT5I7rPucuzuyi6k0xGdFsS
 ZptiAIB0fQbAH+BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sk6zyRcZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/mBZVIfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724703564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7feimIoJGv2rvhbgHuqob40zVArZNC1v7FYkNCbrfc=;
 b=sk6zyRcZi++v+keXHW8NAjlAthAgxUUfZgv6dsM/MOMzmkPqqm4MuqK7jrd5facDu7YixT
 glwRRvsizzfQr+xXqUonuLMiGZ4PABfMrIw8bvVcPa5UnJv4iLv3ptmIcCL/akdyDeL55G
 NtTBdz5lhr9HIohuNlm2L8CdDB6HQOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724703564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7feimIoJGv2rvhbgHuqob40zVArZNC1v7FYkNCbrfc=;
 b=/mBZVIfWWymAeopIckz15mdNRnCYDcByhkDlnRe9OvC09hnqT5I7rPucuzuyi6k0xGdFsS
 ZptiAIB0fQbAH+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D23EF13724;
 Mon, 26 Aug 2024 20:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CoruJUvjzGYwRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Aug 2024 20:19:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v5 18/18] migration/multifd: Stop changing the packet on
 recv side
In-Reply-To: <ZszhkJ6Ydqr6JY98@x1n>
References: <20240826195322.16532-1-farosas@suse.de>
 <20240826195322.16532-19-farosas@suse.de> <ZszhkJ6Ydqr6JY98@x1n>
Date: Mon, 26 Aug 2024 17:19:21 -0300
Message-ID: <8734mrxcja.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 51D0C1F8B5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:dkim, suse.de:mid,
 suse.de:email, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Aug 26, 2024 at 04:53:22PM -0300, Fabiano Rosas wrote:
>> As observed by Philippe, the multifd_ram_unfill_packet() function
>> currently leaves the MultiFDPacket structure with mixed
>> endianness. This is harmless, but ultimately not very clean. Aside
>> from that, the packet is also written to on the recv side to ensure
>> the ramblock name is null-terminated.
>>=20
>> Stop touching the received packet and do the necessary work using
>> stack variables instead.
>>=20
>> While here tweak the error strings and fix the space before
>> semicolons. Also remove the "100 times bigger" comment because it's
>> just one possible explanation for a size mismatch and it doesn't even
>> match the code.
>>=20
>> CC: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/multifd-nocomp.c | 38 ++++++++++++++++----------------------
>>  migration/multifd.c        | 18 ++++++++----------
>>  2 files changed, 24 insertions(+), 32 deletions(-)
>>=20
>> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
>> index f294d1b0b2..0cbf1b88e1 100644
>> --- a/migration/multifd-nocomp.c
>> +++ b/migration/multifd-nocomp.c
>> @@ -220,33 +220,29 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p=
, Error **errp)
>>      MultiFDPacket_t *packet =3D p->packet;
>>      uint32_t page_count =3D multifd_ram_page_count();
>>      uint32_t page_size =3D multifd_ram_page_size();
>> +    uint32_t pages_per_packet =3D be32_to_cpu(packet->pages_alloc);
>> +    const char *ramblock_name;
>>      int i;
>>=20=20
>> -    packet->pages_alloc =3D be32_to_cpu(packet->pages_alloc);
>> -    /*
>> -     * If we received a packet that is 100 times bigger than expected
>> -     * just stop migration.  It is a magic number.
>> -     */
>> -    if (packet->pages_alloc > page_count) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "with size %u and expected a size of %u",
>> -                   packet->pages_alloc, page_count) ;
>> +    if (pages_per_packet > page_count) {
>> +        error_setg(errp, "multifd: received packet with %u pages, expec=
ted %u",
>> +                   pages_per_packet, page_count);
>>          return -1;
>>      }
>>=20=20
>>      p->normal_num =3D be32_to_cpu(packet->normal_pages);
>> -    if (p->normal_num > packet->pages_alloc) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "with %u normal pages and expected maximum pages are=
 %u",
>> -                   p->normal_num, packet->pages_alloc) ;
>> +    if (p->normal_num > pages_per_packet) {
>> +        error_setg(errp, "multifd: received packet with %u non-zero pag=
es, "
>> +                   "which exceeds maximum expected pages %u",
>> +                   p->normal_num, pages_per_packet);
>>          return -1;
>>      }
>>=20=20
>>      p->zero_num =3D be32_to_cpu(packet->zero_pages);
>> -    if (p->zero_num > packet->pages_alloc - p->normal_num) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "with %u zero pages and expected maximum zero pages =
are %u",
>> -                   p->zero_num, packet->pages_alloc - p->normal_num) ;
>> +    if (p->zero_num > pages_per_packet - p->normal_num) {
>> +        error_setg(errp,
>> +                   "multifd: received packet with %u zero pages, expect=
ed maximum %u",
>> +                   p->zero_num, pages_per_packet - p->normal_num);
>>          return -1;
>>      }
>>=20=20
>> @@ -254,12 +250,10 @@ int multifd_ram_unfill_packet(MultiFDRecvParams *p=
, Error **errp)
>>          return 0;
>>      }
>>=20=20
>> -    /* make sure that ramblock is 0 terminated */
>> -    packet->ramblock[255] =3D 0;
>> -    p->block =3D qemu_ram_block_by_name(packet->ramblock);
>> +    ramblock_name =3D g_strndup(packet->ramblock, 255);
>
> This one is leaked?
>
> IMHO the "temp var for endianess" is better justified than this specific
> one, where I think always null-terminating the packet->ramblock[] doesn't
> sound too bad - it makes sure all future ref to packet->ramblock is safe.

Ok, I can drop this part.

>
>> +    p->block =3D qemu_ram_block_by_name(ramblock_name);
>>      if (!p->block) {
>> -        error_setg(errp, "multifd: unknown ram block %s",
>> -                   packet->ramblock);
>> +        error_setg(errp, "multifd: unknown ram block %s", ramblock_name=
);
>>          return -1;
>>      }
>>=20=20
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index b89715fdc2..256ecdea56 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -231,21 +231,19 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **err=
p)
>>  {
>>      MultiFDPacket_t *packet =3D p->packet;
>> +    uint32_t magic =3D be32_to_cpu(packet->magic);
>> +    uint32_t version =3D be32_to_cpu(packet->version);
>>      int ret =3D 0;
>>=20=20
>> -    packet->magic =3D be32_to_cpu(packet->magic);
>> -    if (packet->magic !=3D MULTIFD_MAGIC) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "magic %x and expected magic %x",
>> -                   packet->magic, MULTIFD_MAGIC);
>> +    if (magic !=3D MULTIFD_MAGIC) {
>> +        error_setg(errp, "multifd: received packet magic %x, expected %=
x",
>> +                   magic, MULTIFD_MAGIC);
>>          return -1;
>>      }
>>=20=20
>> -    packet->version =3D be32_to_cpu(packet->version);
>> -    if (packet->version !=3D MULTIFD_VERSION) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "version %u and expected version %u",
>> -                   packet->version, MULTIFD_VERSION);
>> +    if (version !=3D MULTIFD_VERSION) {
>> +        error_setg(errp, "multifd: received packet version %u, expected=
 %u",
>> +                   version, MULTIFD_VERSION);
>>          return -1;
>>      }
>>=20=20
>> --=20
>> 2.35.3
>>=20

