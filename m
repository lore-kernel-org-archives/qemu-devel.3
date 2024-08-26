Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B79C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 17:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sidHi-0003Rr-Op; Mon, 26 Aug 2024 13:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sidHg-0003RA-Vt
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 13:13:41 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sidHf-0007gM-7Y
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 13:13:40 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C567621ACA;
 Mon, 26 Aug 2024 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724692416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9Xzva9trV5ADcbokSTNpEBjrcJASimEdT5iG6KJRB4=;
 b=vLcxBJNCQICUYpCoaaEvEeA72A5CjZKaKUp9N0Lcd5Ax9Cr8VjS2dqNCMkoNnopxWpe020
 9HQ+U1UlVaJwURIrtbT5DsG1RyFJPZpK8HnmV4i7pram7zyMHQvrzMNvfSAVb5OtmOXPug
 NEEb5Lb3qjOUaCUIDsvoNkVKmeQpN6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724692416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9Xzva9trV5ADcbokSTNpEBjrcJASimEdT5iG6KJRB4=;
 b=JT6heDviGLgS/sYwA4gf0hsml7xKbstxe0KH8jEnDwU9nWqqz58BdMtDvG3uRfj3pW9ChM
 eEQ5q1YCfx0DPmBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CBM80M86;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LJzIIqG6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724692415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9Xzva9trV5ADcbokSTNpEBjrcJASimEdT5iG6KJRB4=;
 b=CBM80M86yVmkpANAUgYMtwULaAY0iT9bXoUxgU66tvQGd2bSQz3l/kE5L4J6KEQXIZt2zr
 EfvcZrgA364Wrw74mmwwUs98qalAWg0NDO2uBPELyB5JbyY6KbPiyNnuw71bUHQJJeywz/
 eshbzdHOmoSLB+wXQ7hV0PCwSNTIOII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724692415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9Xzva9trV5ADcbokSTNpEBjrcJASimEdT5iG6KJRB4=;
 b=LJzIIqG6vTsa7bJtFsp+4ILUH/MewXf627pw5Tv8pV582CHIeGLOKB4Hd2nAkENutjIVOl
 yAcjUOriASf67+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F2C913724;
 Mon, 26 Aug 2024 17:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0yC3Bb+3zGacDQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Aug 2024 17:13:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 10/16] migration/multifd: Isolate ram pages packet data
In-Reply-To: <1c096ef1-5a61-44a2-a4ad-b3eb8e5e5b94@linaro.org>
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-11-farosas@suse.de>
 <1c096ef1-5a61-44a2-a4ad-b3eb8e5e5b94@linaro.org>
Date: Mon, 26 Aug 2024 14:13:32 -0300
Message-ID: <878qwjxl4z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C567621ACA
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 23/8/24 19:39, Fabiano Rosas wrote:
>> While we cannot yet disentangle the multifd packet from page data, we
>> can make the code a bit cleaner by setting the page-related fields in
>> a separate function.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   migration/multifd.c    | 99 +++++++++++++++++++++++++-----------------
>>   migration/trace-events |  5 ++-
>>   2 files changed, 63 insertions(+), 41 deletions(-)
>
>
>> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **err=
p)
>> +static int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>   {
>>       MultiFDPacket_t *packet =3D p->packet;
>>       uint32_t page_count =3D multifd_ram_page_count();
>>       uint32_t page_size =3D multifd_ram_page_size();
>>       int i;
>>=20=20=20
>> -    packet->magic =3D be32_to_cpu(packet->magic);
>> -    if (packet->magic !=3D MULTIFD_MAGIC) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "magic %x and expected magic %x",
>> -                   packet->magic, MULTIFD_MAGIC);
>> -        return -1;
>> -    }
>> -
>> -    packet->version =3D be32_to_cpu(packet->version);
>> -    if (packet->version !=3D MULTIFD_VERSION) {
>> -        error_setg(errp, "multifd: received packet "
>> -                   "version %u and expected version %u",
>> -                   packet->version, MULTIFD_VERSION);
>> -        return -1;
>> -    }
>> -
>> -    p->flags =3D be32_to_cpu(packet->flags);
>> -
>>       packet->pages_alloc =3D be32_to_cpu(packet->pages_alloc);
>>       /*
>>        * If we received a packet that is 100 times bigger than expected
>> @@ -511,13 +507,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
>>           return -1;
>>       }
>>=20=20=20
>> -    p->next_packet_size =3D be32_to_cpu(packet->next_packet_size);
>> -    p->packet_num =3D be64_to_cpu(packet->packet_num);
>> -    p->packets_recved++;
>> -
>> -    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
>> -                       p->flags, p->next_packet_size);
>> -
>>       if (p->normal_num =3D=3D 0 && p->zero_num =3D=3D 0) {
>>           return 0;
>>       }
>> @@ -559,6 +548,40 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
>>       return 0;
>>   }
>>=20=20=20
>> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **err=
p)
>> +{
>> +    MultiFDPacket_t *packet =3D p->packet;
>> +    int ret =3D 0;
>> +
>> +    packet->magic =3D be32_to_cpu(packet->magic);
>> +    if (packet->magic !=3D MULTIFD_MAGIC) {
>> +        error_setg(errp, "multifd: received packet "
>> +                   "magic %x and expected magic %x",
>> +                   packet->magic, MULTIFD_MAGIC);
>> +        return -1;
>> +    }
>> +
>> +    packet->version =3D be32_to_cpu(packet->version);
>> +    if (packet->version !=3D MULTIFD_VERSION) {
>> +        error_setg(errp, "multifd: received packet "
>> +                   "version %u and expected version %u",
>> +                   packet->version, MULTIFD_VERSION);
>> +        return -1;
>> +    }
>> +
>> +    p->flags =3D be32_to_cpu(packet->flags);
>> +    p->next_packet_size =3D be32_to_cpu(packet->next_packet_size);
>> +    p->packet_num =3D be64_to_cpu(packet->packet_num);
>> +    p->packets_recved++;
>> +
>> +    ret =3D multifd_ram_unfill_packet(p, errp);
>
> Pre-existing but since you modify this code, maybe cleaner to
> "unfill" all packet fields, then check for sane magic/version
> and return error, to not let a packet half-swapped. Otherwise:

I don't even see the point of byte-swapping the packet
in-place. Probably better to have all the swaps into the variables in
the unfill function and leave the packet unchanged. I'll add another
patch to the series.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>> +
>> +    trace_multifd_recv_unfill(p->id, p->packet_num, p->flags,
>> +                              p->next_packet_size);
>> +
>> +    return ret;
>> +}

