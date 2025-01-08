Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7FBE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVZeg-0006xh-Tm; Wed, 08 Jan 2025 12:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVZeR-0006xJ-DD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:15:27 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVZeO-00030w-MH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:15:26 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D153721157;
 Wed,  8 Jan 2025 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736356522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9D1ohLEqsOnEcXu+RaSs8F4BXBT7K8aLAajVQD3028=;
 b=gyrzEIqcgt8tJvhi4mrD24SxzSc8b66JaeKc1+wg5F642DdsZMy8si9J9OaDeEWZqYGznV
 RJi5xJe5ZK5VA+bl8O5Qxe/4Q0Z1kw90idWKf8hadABDlKshm2h1InEMGG+aQvD3zbPv86
 4CwAf4vARXn2V4c3oZUnjZqCX7HYJD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736356522;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9D1ohLEqsOnEcXu+RaSs8F4BXBT7K8aLAajVQD3028=;
 b=X+JutC5+b6Pybo/jvwl6bXDaxdkAa90qD1QnbMSeumJT9gsNOfHDR/qEVWJsKBX/ShkHNP
 1ua6gonJ/Zw0DGAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736356522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9D1ohLEqsOnEcXu+RaSs8F4BXBT7K8aLAajVQD3028=;
 b=gyrzEIqcgt8tJvhi4mrD24SxzSc8b66JaeKc1+wg5F642DdsZMy8si9J9OaDeEWZqYGznV
 RJi5xJe5ZK5VA+bl8O5Qxe/4Q0Z1kw90idWKf8hadABDlKshm2h1InEMGG+aQvD3zbPv86
 4CwAf4vARXn2V4c3oZUnjZqCX7HYJD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736356522;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b9D1ohLEqsOnEcXu+RaSs8F4BXBT7K8aLAajVQD3028=;
 b=X+JutC5+b6Pybo/jvwl6bXDaxdkAa90qD1QnbMSeumJT9gsNOfHDR/qEVWJsKBX/ShkHNP
 1ua6gonJ/Zw0DGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 596DF13A86;
 Wed,  8 Jan 2025 17:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0+P6B6qyfmcLAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 08 Jan 2025 17:15:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 6/7] migration: Fix arrays of pointers in JSON writer
In-Reply-To: <Z36kScJti9LrWVU7@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-7-farosas@suse.de> <Z3231YxnKrjtwX6h@x1n>
 <87cygx4dlt.fsf@suse.de> <Z36kScJti9LrWVU7@x1n>
Date: Wed, 08 Jan 2025 14:15:19 -0300
Message-ID: <875xmp447s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

> On Wed, Jan 08, 2025 at 10:52:30AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Jan 07, 2025 at 04:50:24PM -0300, Fabiano Rosas wrote:
>> >> Currently, if an array of pointers contains a NULL pointer, that
>> >> pointer will be encoded as '0' in the stream. Since the JSON writer
>> >> doesn't define a "pointer" type, that '0' will now be an uint64, which
>> >> is different from the original type being pointed to, e.g. struct.
>> >> 
>> >> That mixed-type array shouldn't be compressed, otherwise data is lost
>> >> as the code currently makes the whole array have the type of the first
>> >> element.
>> >> 
>> >> While we could disable the array compression when a NULL pointer is
>> >> found, the JSON part of the stream still makes part of downtime, so we
>> >> should avoid writing unecessary bytes to it.
>> >> 
>> >> Keep the array compression in place, but break the array into several
>> >> type-contiguous pieces if NULL and non-NULL pointers are mixed.
>> >
>> > Could I request for a sample JSON dump for an example array in the commit
>> > log?  This whole solution looks working but is tricky.  A sample could help
>> > people understand (e.g. showing the same "name" being dumped multiple
>> > times..).
>> 
>> {"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
>>  "version": 1, "fields": [
>>    ...,
>>    {"name": "css", "array_len": 254, "type": "uint8", "size": 1},
>>    {"name": "css", "type": "struct", "struct": {
>>     "vmsd_name": "s390_css_img", "version": 1, "fields": [{"name":
>>     "chpids", "array_len": 256, "type": "struct", "struct": {"vmsd_name":
>>     "s390_chp_info", "version": 1, "fields": [{"name": "in_use", "type":
>>     "uint8", "size": 1}, {"name": "type", "type": "uint8", "size": 1},
>>     {"name": "is_virtual", "type": "uint8", "size": 1}]}, "size": 3}]},
>>     "size": 768},
>>    {"name": "css", "type": "uint8", "size": 1},
>>    ...
>> ]}
>
> Yes something like this would work, thanks.  We could even omit most of the
> struct details but only show the important ones:
>
>   {"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
>    "version": 1, "fields": [
>      ...,
>      {"name": "css", "array_len": 254, "type": "uint8", "size": 1},
>      {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
>      {"name": "css", "type": "uint8", "size": 1},
>      ...
>   ]}
>
>> 
>> >
>> > Side note: I tried to dump a very basic VM's JSON out to disk, it scares me
>> > on the size:
>> >
>> > $ ls -lhS JSON.out 
>> > -rw-r--r--. 1 peterx peterx 106K Jan  7 17:18 JSON.out
>> >
>> > That's a simplest VM with all default stuff, mostly nothing complex.. I may
>> > really need to measure how the JSON debug strings affect migration function
>> > or perf at some point..
>> >
>> 
>> Agreed.
>> 
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >>  migration/vmstate.c          | 33 ++++++++++++++++++++++++++++++++-
>> >>  scripts/analyze-migration.py |  9 ++++++++-
>> >>  2 files changed, 40 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> >> index 52704c822c..a79ccf3875 100644
>> >> --- a/migration/vmstate.c
>> >> +++ b/migration/vmstate.c
>> >> @@ -425,15 +425,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>> >>              int size = vmstate_size(opaque, field);
>> >>              uint64_t old_offset, written_bytes;
>> >>              JSONWriter *vmdesc_loop = vmdesc;
>> >> +            bool is_prev_null = false;
>> >>  
>> >>              trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
>> >>              if (field->flags & VMS_POINTER) {
>> >>                  first_elem = *(void **)first_elem;
>> >>                  assert(first_elem || !n_elems || !size);
>> >>              }
>> >> +
>> >>              for (i = 0; i < n_elems; i++) {
>> >>                  void *curr_elem = first_elem + size * i;
>> >>                  const VMStateField *inner_field;
>> >> +                bool is_null;
>> >> +                int max_elems = n_elems - i;
>> >>  
>> >>                  old_offset = qemu_file_transferred(f);
>> >>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>> >> @@ -448,12 +452,39 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>> >>                       * not follow.
>> >>                       */
>> >>                      inner_field = vmsd_create_fake_nullptr_field(field);
>> >> +                    is_null = true;
>> >>                  } else {
>> >>                      inner_field = field;
>> >> +                    is_null = false;
>> >> +                }
>> >> +
>> >> +                /*
>> >> +                 * Due to the fake nullptr handling above, if there's mixed
>> >> +                 * null/non-null data, it doesn't make sense to emit a
>> >> +                 * compressed array representation spanning the entire array
>> >> +                 * because the field types will be different (e.g. struct
>> >> +                 * vs. uint64_t). Search ahead for the next null/non-null
>> >> +                 * element and start a new compressed array if found.
>> >> +                 */
>> >> +                if (field->flags & VMS_ARRAY_OF_POINTER &&
>> >> +                    is_null != is_prev_null) {
>> >> +
>> >> +                    is_prev_null = is_null;
>> >> +                    vmdesc_loop = vmdesc;
>> >> +
>> >> +                    for (int j = i + 1; j < n_elems; j++) {
>> >> +                        void *elem = *(void **)(first_elem + size * j);
>> >> +                        bool elem_is_null = !elem && size;
>> >> +
>> >> +                        if (is_null != elem_is_null) {
>> >> +                            max_elems = j - i;
>> >> +                            break;
>> >> +                        }
>> >> +                    }
>> >>                  }
>> >>  
>> >>                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
>> >> -                                      i, n_elems);
>> >> +                                      i, max_elems);
>> >>  
>> >>                  if (inner_field->flags & VMS_STRUCT) {
>> >>                      ret = vmstate_save_state(f, inner_field->vmsd,
>> >> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
>> >> index 4836920ddc..9138e91a11 100755
>> >> --- a/scripts/analyze-migration.py
>> >> +++ b/scripts/analyze-migration.py
>> >> @@ -497,7 +497,14 @@ def read(self):
>> >>                      raise Exception("internal index of data field unmatched (%d/%d)" % (len(a), int(field['index'])))
>> >>                  a.append(field['data'])
>> 
>> There's actually a bug here, the code above does:
>> 
>>   if len(a) != int(field['index']):
>>       raise Exception()
>> 
>> Which only works with this patch because the compressed array happens to
>> come first.
>
> I think it will work no matter how it's ordered after your patch?  IOW I'd
> hope it'll keep working if the 1st is a nullptr:
>
>      {"name": "css", "type": "uint8", "size": 1},
>      {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
>      {"name": "css", "array_len": 254, "type": "uint8", "size": 1},
>
> Because IIUC the python script will parse each of the lines above into a
> VMSD field.

Yes, but all fields go into self.data of the VMSDFieldStruct, so
self.data["css"] will increase beyond the size of the array.

>> 
>> >>              else:
>> >> -                self.data[field['name']] = field['data']
>> >> +                # There could be multiple entries for the same field
>> >> +                # name, e.g. when a compressed array was broken in
>> >> +                # more than one piece.
>> >> +                if (field['name'] in self.data and
>> >> +                    type(self.data[field['name']]) == list):
>> >> +                    self.data[field['name']].append(field['data'])
>> >> +                else:
>> >> +                    self.data[field['name']] = field['data']
>> >
>> > Do we realy need these script changes?  I thought VMSDFieldStruct always
>> > breaks array_len field into "index" based anyway?
>> >
>> >         new_fields = []
>> >         for field in self.desc['struct']['fields']:
>> >             if not 'array_len' in field:
>> >                 new_fields.append(field)
>> >                 continue
>> >             array_len = field.pop('array_len')
>> >             field['index'] = 0
>> >             new_fields.append(field)
>> >             for i in range(1, array_len):
>> >                 c = field.copy()
>> >                 c['index'] = i
>> >                 new_fields.append(c)
>> >
>> >         self.desc['struct']['fields'] = new_fields
>> 
>> This code is about decompressing the array, it doesn't handle multiple
>> entries with the same name. See the JSON I posted up there.
>> 
>> This makes the single:
>> 
>>   {"name": "css", "array_len": 254, "type": "uint8", "size": 1},
>> 
>> become multiple:
>> 
>>   {"name": "css", "index": 0, "type": "uint8", "size": 1},
>>   {"name": "css", "index": 1, "type": "uint8", "size": 1},
>>   ...
>>   {"name": "css", "index": 253, "type": "uint8", "size": 1},
>
> Correct.
>
> I think that means for each of the break-down entries there'll be an
> "index" if it's an array.  What you changed above is the case where "index"
> is not available, which is processing the non-array entry.  Why does that
> need change?

It needs to append to, not overwrite the previous self.data[name]

> What happens if you run this without the python part you
> changed in this patch?

The last nullptr overwrites everything else:

    "s390_css (14)": {
        "pending_crws": "00",
        "sei_pending": false,
        "do_crw_mchk": true,
        "crws_lost": false,
        "max_cssid": "0x00",
        "max_ssid": "0x00",
        "chnmon_active": false,
        "chnmon_area": "0x0000000000000000",
-->     "css": "nullptr",
        "default_cssid": "0xfe"
    },

