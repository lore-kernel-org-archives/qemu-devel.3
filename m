Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10028109C04A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5SOJ-0001Bs-Ka; Wed, 25 Mar 2026 13:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5SOI-0001Bh-88
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:51:38 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w5SOG-0000pL-FT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:51:38 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB8DC4D231;
 Wed, 25 Mar 2026 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774461093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gqo1O8e36tUbKSa6c/92/NJbXAkfX+28wwKvvBLDeA=;
 b=aHoa4SWEdnIxcerN4R4kYuVTUiGbaGq1OLmJwXwpbJbx7xoTGoKNVDlt/hL18eqCQVSWAR
 PMewpCpSH2oFtymENU8HRfQ0krPwTuwkBFOXAVDRyV+zPaIzztyFxyI2MJpuBC0T+q4eMF
 om11QKUHOXnN8yfOK5f9lAaxs6dDtxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774461093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gqo1O8e36tUbKSa6c/92/NJbXAkfX+28wwKvvBLDeA=;
 b=VDjMzKNNKhgntsE9Mfc+oeU60s1DfA8JXkIeyIRDxWe1Z6SaHbm9qofMYUf7LB85jOtr8D
 Q/5SjLkRR05GKGDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774461093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gqo1O8e36tUbKSa6c/92/NJbXAkfX+28wwKvvBLDeA=;
 b=aHoa4SWEdnIxcerN4R4kYuVTUiGbaGq1OLmJwXwpbJbx7xoTGoKNVDlt/hL18eqCQVSWAR
 PMewpCpSH2oFtymENU8HRfQ0krPwTuwkBFOXAVDRyV+zPaIzztyFxyI2MJpuBC0T+q4eMF
 om11QKUHOXnN8yfOK5f9lAaxs6dDtxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774461093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7gqo1O8e36tUbKSa6c/92/NJbXAkfX+28wwKvvBLDeA=;
 b=VDjMzKNNKhgntsE9Mfc+oeU60s1DfA8JXkIeyIRDxWe1Z6SaHbm9qofMYUf7LB85jOtr8D
 Q/5SjLkRR05GKGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67EF344512;
 Wed, 25 Mar 2026 17:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HzA9DqUgxGnIGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 25 Mar 2026 17:51:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 02/17] vmstate: Remove vmstate_use_marker_field
In-Reply-To: <acQPOrC5YA89kr1P@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-3-farosas@suse.de> <acQPOrC5YA89kr1P@x1.local>
Date: Wed, 25 Mar 2026 14:51:31 -0300
Message-ID: <87se9nkdb0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Mar 24, 2026 at 04:43:17PM -0300, Fabiano Rosas wrote:
>> Bring back is_null, but set use_marker_field based on it. This makes
>> it clear that the compression logic is only because of the null
>> marker. When the marker is not null, it doesn't make sense to
>> compress.
>
> Yeah I see where this came from, I agree the is_null case is at least
> harder to follow now when without that variable being around.
>
> I'll squash this into my commit for now, maybe I'll still try to keep the
> comments somewhere.
>
> Then I'll also hope we can remove the whole JSON blob very soon.  Do you
> plan to look into the "vmsd walker rewrite analyze-migration script" plan a
> bit?  Let me know if you want me to try; it'll not happen immediately, but
> after seeing this I'm more eager to try removing those..
>

I don't think I'll have time to work on it properly. Actually, I have
the feeling this is something that will take some effort. We may need to
make little steps of progress towards it. If you have the opportunity to
work on something, go ahead.

The first step might be to stop emitting the JSON where
appropriate.

> When those are ready, we should be able to remove is_null again.
>

I'm also considering whether we really need the compression logic at
all. If we remove the blob from the stream and make it a separate
command then we could simply just output the entire array of zeroes and
let external tools deal with it. I bet jq has a way to display that data
nicely.

>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/vmstate.c | 36 ++++++++++--------------------------
>>  1 file changed, 10 insertions(+), 26 deletions(-)
>> 
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index 7d7d9c7e18..7edfa3d990 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -240,22 +240,6 @@ static bool vmstate_post_load(const VMStateDescription *vmsd,
>>      return true;
>>  }
>>  
>> -
>> -/*
>> - * If we will use a ptr marker in the stream for a field?  Two use cases:
>> - *
>> - * (1) When used with VMS_ARRAY_OF_POINTER_ALLOW_NULL, it must always be
>> - *     present to imply the population status of the pointer.
>> - *
>> - * (2) When used with normal VMSD array fields, only emit a null ptr marker
>> - *     if the pointer is NULL.
>> - */
>> -static inline bool
>> -vmstate_use_marker_field(void *ptr, int size, bool dynamic_array)
>> -{
>> -    return (!ptr && size) || dynamic_array;
>> -}
>> -
>>  bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>>                         void *opaque, int version_id, Error **errp)
>>  {
>> @@ -318,8 +302,8 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>>                      curr_elem = *(void **)curr_elem_p;
>>                  }
>>  
>> -                use_marker_field = vmstate_use_marker_field(curr_elem, size,
>> -                                                            use_dynamic_array);
>> +                use_marker_field = use_dynamic_array || (!curr_elem && size);
>> +
>>                  if (use_marker_field) {
>>                      /* Read the marker instead of VMSD first */
>>                      if (!vmstate_ptr_marker_load(f, &load_field, errp)) {
>> @@ -634,7 +618,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>>              int i, n_elems = vmstate_n_elems(opaque, field);
>>              int size = vmstate_size(opaque, field);
>>              JSONWriter *vmdesc_loop = vmdesc;
>> -            bool use_marker_field_prev = false;
>> +            bool is_null_prev = false;
>>              /*
>>               * When this is enabled, it means we will always push a ptr
>>               * marker first for each element saying if it's populated.
>> @@ -651,7 +635,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>>              for (i = 0; i < n_elems; i++) {
>>                  void *curr_elem = first_elem + size * i;
>>                  const VMStateField *inner_field;
>> -                bool use_marker_field;
>> +                bool use_marker_field, is_null;
>>                  int max_elems = n_elems - i;
>>  
>>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>> @@ -659,8 +643,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>>                      curr_elem = *(void **)curr_elem;
>>                  }
>>  
>> -                use_marker_field = vmstate_use_marker_field(curr_elem, size,
>> -                                                            use_dynamic_array);
>> +                is_null = (!curr_elem && size);
>> +                use_marker_field = use_dynamic_array || is_null;
>>  
>>                  if (use_marker_field) {
>>                      inner_field = vmsd_create_ptr_marker_field(field);
>> @@ -681,16 +665,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>>                   */
>>                  if (vmdesc && vmsd_can_compress(field) &&
>>                      (field->flags & VMS_ARRAY_OF_POINTER) &&
>> -                    use_marker_field != use_marker_field_prev) {
>> +                    is_null != is_null_prev) {
>>  
>> -                    use_marker_field_prev = use_marker_field;
>> +                    is_null_prev = is_null;
>>                      vmdesc_loop = vmdesc;
>>  
>>                      for (int j = i + 1; j < n_elems; j++) {
>>                          void *elem = *(void **)(first_elem + size * j);
>> -                        bool elem_use_marker_field = !elem && size;
>> +                        bool elem_is_null = !elem && size;
>>  
>> -                        if (use_marker_field != elem_use_marker_field) {
>> +                        if (is_null != elem_is_null) {
>>                              max_elems = j - i;
>>                              break;
>>                          }
>> -- 
>> 2.51.0
>> 

