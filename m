Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A116C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPTO-0001Ro-AM; Fri, 07 Feb 2025 09:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPTL-0001RA-QV
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:36:47 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPTJ-00044i-KF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:36:47 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2C801F449;
 Fri,  7 Feb 2025 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzBbJkVPPbn1TLJrFeU/MiHcaGb2mOvCv56h8CeRyPM=;
 b=G38Fr856uiyISqjVxWt5VSlFpLgDJaMHpuxZnV/ZMIZbkV6PBgTnlP0aOc5hUrtK7Pn9H6
 YMsgU3C/c2ScmZ3m9RTUoyjES3MjsspKMm0G1vt70+XtPQt2ko2AfV+ITO0p5U1AmUhuvN
 QFCY7PGU6Yr+7+B4l61bZ1+e/RR/rFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzBbJkVPPbn1TLJrFeU/MiHcaGb2mOvCv56h8CeRyPM=;
 b=nFCIgxXFFYBYrX1fAJEC3KaD15yNYIpnIWLeAGbCAazuA1qtVL6tjL9iEkO3rnViA/mFor
 xFZFfMvGHXURs0BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzBbJkVPPbn1TLJrFeU/MiHcaGb2mOvCv56h8CeRyPM=;
 b=G8vEMCArZyH/RlLSRiVroaE/XJxwbqptR4EJ+cZpMBPNTYKyUh43TmnGxMbaA6DQwYvfFz
 0kyzZktR3gO8dTW7OXvyT31b9j4TRg1NrMbVvokeir7jLPQBFaDjJec9IeIzGM5VfPGg3J
 K7x/tFmJeaUvwDNwAtztohEFuvzJkT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzBbJkVPPbn1TLJrFeU/MiHcaGb2mOvCv56h8CeRyPM=;
 b=TY66C67Gy/hoNJkMgi6F3OObL4lBooNh+B92HFv9MczWS0sapaMXWRHGHjLkP1AuOEiyjr
 dmaonnBNjiOLvBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42A5F139CB;
 Fri,  7 Feb 2025 14:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pgd6AHsapmfQPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 14:36:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 17/33] migration/multifd: Make MultiFDSendData a struct
In-Reply-To: <e7a227c97319d036dd1b06d1ea93af77ce92563d.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <e7a227c97319d036dd1b06d1ea93af77ce92563d.1738171076.git.maciej.szmigiero@oracle.com>
Date: Fri, 07 Feb 2025 11:36:40 -0300
Message-ID: <877c61n7nr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 oracle.com:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: Peter Xu <peterx@redhat.com>
>
> The newly introduced device state buffer can be used for either storing
> VFIO's read() raw data, but already also possible to store generic device
> states.  After noticing that device states may not easily provide a max
> buffer size (also the fact that RAM MultiFDPages_t after all also want to
> have flexibility on managing offset[] array), it may not be a good idea to
> stick with union on MultiFDSendData.. as it won't play well with such
> flexibility.
>
> Switch MultiFDSendData to a struct.
>
> It won't consume a lot more space in reality, after all the real buffers
> were already dynamically allocated, so it's so far only about the two
> structs (pages, device_state) that will be duplicated, but they're small.
>
> With this, we can remove the pretty hard to understand alloc size logic.
> Because now we can allocate offset[] together with the SendData, and
> properly free it when the SendData is freed.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [MSS: Make sure to clear possible device state payload before freeing
> MultiFDSendData, remove placeholders for other patches not included]
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  migration/multifd-device-state.c |  5 -----
>  migration/multifd-nocomp.c       | 13 ++++++-------
>  migration/multifd.c              | 25 +++++++------------------
>  migration/multifd.h              | 15 +++++++++------
>  4 files changed, 22 insertions(+), 36 deletions(-)
>
> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> index 2207bea9bf8a..d1674b432ff2 100644
> --- a/migration/multifd-device-state.c
> +++ b/migration/multifd-device-state.c
> @@ -16,11 +16,6 @@ static QemuMutex queue_job_mutex;
>  
>  static MultiFDSendData *device_state_send;
>  
> -size_t multifd_device_state_payload_size(void)
> -{
> -    return sizeof(MultiFDDeviceState_t);
> -}
> -
>  void multifd_device_state_send_setup(void)
>  {
>      qemu_mutex_init(&queue_job_mutex);
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index c00804652383..ffe75256c9fb 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -25,15 +25,14 @@
>  
>  static MultiFDSendData *multifd_ram_send;
>  
> -size_t multifd_ram_payload_size(void)
> +void multifd_ram_payload_alloc(MultiFDPages_t *pages)
>  {
> -    uint32_t n = multifd_ram_page_count();
> +    pages->offset = g_new0(ram_addr_t, multifd_ram_page_count());
> +}
>  
> -    /*
> -     * We keep an array of page offsets at the end of MultiFDPages_t,
> -     * add space for it in the allocation.
> -     */
> -    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
> +void multifd_ram_payload_free(MultiFDPages_t *pages)
> +{
> +    g_clear_pointer(&pages->offset, g_free);
>  }
>  
>  void multifd_ram_save_setup(void)
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 61b061a33d35..0b61b8192231 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -105,26 +105,12 @@ struct {
>  
>  MultiFDSendData *multifd_send_data_alloc(void)
>  {
> -    size_t max_payload_size, size_minus_payload;
> +    MultiFDSendData *new = g_new0(MultiFDSendData, 1);
>  
> -    /*
> -     * MultiFDPages_t has a flexible array at the end, account for it
> -     * when allocating MultiFDSendData. Use max() in case other types
> -     * added to the union in the future are larger than
> -     * (MultiFDPages_t + flex array).
> -     */
> -    max_payload_size = MAX(multifd_ram_payload_size(),
> -                           multifd_device_state_payload_size());
> -    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
> -
> -    /*
> -     * Account for any holes the compiler might insert. We can't pack
> -     * the structure because that misaligns the members and triggers
> -     * Waddress-of-packed-member.
> -     */
> -    size_minus_payload = sizeof(MultiFDSendData) - sizeof(MultiFDPayload);
> +    multifd_ram_payload_alloc(&new->u.ram);
> +    /* Device state allocates its payload on-demand */
>  
> -    return g_malloc0(size_minus_payload + max_payload_size);
> +    return new;
>  }
>  
>  void multifd_send_data_clear(MultiFDSendData *data)
> @@ -151,8 +137,11 @@ void multifd_send_data_free(MultiFDSendData *data)
>          return;
>      }
>  
> +    /* This also free's device state payload */
>      multifd_send_data_clear(data);
>  
> +    multifd_ram_payload_free(&data->u.ram);
> +

Shouldn't this be added to the switch statement at
multifd_send_data_clear() instead?

>      g_free(data);
>  }
>  
> diff --git a/migration/multifd.h b/migration/multifd.h
> index ddc617db9acb..f7811cc0d0cb 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -115,9 +115,13 @@ typedef struct {
>      uint32_t num;
>      /* number of normal pages */
>      uint32_t normal_num;
> +    /*
> +     * Pointer to the ramblock.  NOTE: it's caller's responsibility to make
> +     * sure the pointer is always valid!
> +     */
>      RAMBlock *block;
> -    /* offset of each page */
> -    ram_addr_t offset[];
> +    /* offset array of each page, managed by multifd */
> +    ram_addr_t *offset;
>  } MultiFDPages_t;
>  
>  struct MultiFDRecvData {
> @@ -140,7 +144,7 @@ typedef enum {
>      MULTIFD_PAYLOAD_DEVICE_STATE,
>  } MultiFDPayloadType;
>  
> -typedef union MultiFDPayload {
> +typedef struct MultiFDPayload {
>      MultiFDPages_t ram;
>      MultiFDDeviceState_t device_state;
>  } MultiFDPayload;
> @@ -392,12 +396,11 @@ void multifd_ram_save_cleanup(void);
>  int multifd_ram_flush_and_sync(QEMUFile *f);
>  bool multifd_ram_sync_per_round(void);
>  bool multifd_ram_sync_per_section(void);
> -size_t multifd_ram_payload_size(void);
> +void multifd_ram_payload_alloc(MultiFDPages_t *pages);
> +void multifd_ram_payload_free(MultiFDPages_t *pages);
>  void multifd_ram_fill_packet(MultiFDSendParams *p);
>  int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
>  
> -size_t multifd_device_state_payload_size(void);
> -
>  void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state);
>  
>  void multifd_device_state_send_setup(void);

