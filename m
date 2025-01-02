Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3635DE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 22:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTTzb-0000It-Pb; Thu, 02 Jan 2025 17:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTzX-0008Vo-3X
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:48:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTTzU-0004g7-4g
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 17:48:34 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 586501F794;
 Thu,  2 Jan 2025 22:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735858110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CAXAhHI4fUwdMhvQ+lDXaNjMK76VrQyDt+p0AH/xYpI=;
 b=MQUFsfWQkL0q5OkK6ExRfHThieIsSAb+bDWU4BwXWnqNnfsqaui040lC+eh6ZzIzmM1eAv
 7U7C/CEBtb/tjT5LAUipnow+5DQY00z8CBAwA7sWaDtW53uAoM2pmE4PZ2fUxr6FdblzSH
 VE30FP01ZMGh4/SvgdhKuqUmF1k8uuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735858110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CAXAhHI4fUwdMhvQ+lDXaNjMK76VrQyDt+p0AH/xYpI=;
 b=DOen1EyJsF3d1U7Hp5bwSOe8wnid0tBdtkNn3fJJjP+shjcIlpu7mgnpWbIjbsq1OG/PJp
 pifIgS6hm0lQTHCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735858110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CAXAhHI4fUwdMhvQ+lDXaNjMK76VrQyDt+p0AH/xYpI=;
 b=MQUFsfWQkL0q5OkK6ExRfHThieIsSAb+bDWU4BwXWnqNnfsqaui040lC+eh6ZzIzmM1eAv
 7U7C/CEBtb/tjT5LAUipnow+5DQY00z8CBAwA7sWaDtW53uAoM2pmE4PZ2fUxr6FdblzSH
 VE30FP01ZMGh4/SvgdhKuqUmF1k8uuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735858110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CAXAhHI4fUwdMhvQ+lDXaNjMK76VrQyDt+p0AH/xYpI=;
 b=DOen1EyJsF3d1U7Hp5bwSOe8wnid0tBdtkNn3fJJjP+shjcIlpu7mgnpWbIjbsq1OG/PJp
 pifIgS6hm0lQTHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C518B13418;
 Thu,  2 Jan 2025 22:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zUgQIr0Xd2eQAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 Jan 2025 22:48:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] migration: Add more error handling to analyze-migration.py
In-Reply-To: <Z3cNJZ0inEMRSitV@x1n>
References: <20250102185831.4324-1-farosas@suse.de> <Z3cNJZ0inEMRSitV@x1n>
Date: Thu, 02 Jan 2025 19:48:27 -0300
Message-ID: <87pll496is.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Thu, Jan 02, 2025 at 03:58:31PM -0300, Fabiano Rosas wrote:
>> The analyze-migration script was seen failing in s390x in misterious
>> ways. It seems we're reaching the subsection constructor without any
>
> It might be a good idea to add some debug lines indeed. Though are you sure
> it's from parsing a subsection?

Ah, indeed it's not always a subsection. So I need to go back to the
code and do more auditing, we might have a wrong struct macro somewhere.

>
> https://lore.kernel.org/all/20241219123213.GA692742@fedora/
>
> ====8<====
> stderr:
> Traceback (most recent call last):
>   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 688, in <module>
>     dump.read(dump_memory = args.memory)
>   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 625, in read
>     section.read()
>   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 461, in read
>     field['data'] = reader(field, self.file)
>   File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 434, in __init__
>     for field in self.desc['struct']['fields']:
> KeyError: 'fields'
> ====8<====
>
> It reads to me that it's not in "if 'subsections' in self.desc['struct']"
> loop yet, instead it looks like a real STRUCT field in one of the device
> sections?  If that's true, then...
>
>> fields, which would indicate an empty .subsection entry in the vmstate
>> definition. We don't have any of those, at least not without the
>> unmigratable flag set, so this should never happen.
>> 
>> Add some debug statements so that we can see what's going on the next
>> time the issue happens.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  scripts/analyze-migration.py | 33 +++++++++++++++++++++++++++------
>>  1 file changed, 27 insertions(+), 6 deletions(-)
>> 
>> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
>> index 8a254a5b6a..1dd98f1d5a 100755
>> --- a/scripts/analyze-migration.py
>> +++ b/scripts/analyze-migration.py
>> @@ -429,6 +429,10 @@ def __init__(self, desc, file):
>>          super(VMSDFieldStruct, self).__init__(desc, file)
>>          self.data = collections.OrderedDict()
>>  
>> +        if 'fields' not in self.desc['struct']:
>> +            raise Exception("No fields in subsection key=%s name=%s" %
>> +                            (self.section_key, self.vmsd_name))
>
> ... this self.section_key / self.vmsd_name may not exist..

Right, so there's no information we can get at this point I think. But
raising will still trigger the dump later on.

>
> In all cases, IMHO this would be better the debug lines work with both pure
> structs and sections.

Yeah, I need to change that to something generic.

>
>> +
>>          # When we see compressed array elements, unfold them here
>>          new_fields = []
>>          for field in self.desc['struct']['fields']:
>> @@ -477,6 +481,11 @@ def read(self):
>>                      raise Exception("Subsection %s not found at offset %x" % ( subsection['vmsd_name'], self.file.tell()))
>>                  name = self.file.readstr()
>>                  version_id = self.file.read32()
>> +
>> +                if not subsection:
>> +                    raise Exception("Empty description for subsection %s" %
>> +                                    name)
>
> This is checking subsection==None??  I doubt whether this will hit..

Well, there could be a None in the list of subsections somehow, no?

>
>> +
>>                  self.data[name] = VMSDSection(self.file, version_id, subsection, (name, 0))
>>                  self.data[name].read()
>>  
>> @@ -575,9 +584,8 @@ def __init__(self, filename):
>>          self.filename = filename
>>          self.vmsd_desc = None
>>  
>> -    def read(self, desc_only = False, dump_memory = False, write_memory = False):
>> -        # Read in the whole file
>> -        file = MigrationFile(self.filename)
>> +    def _read(self, file, vmsd_json, desc_only = False, dump_memory = False,
>> +              write_memory = False):
>>  
>>          # File magic
>>          data = file.read32()
>> @@ -589,7 +597,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
>>          if data != self.QEMU_VM_FILE_VERSION:
>>              raise Exception("Invalid version number %d" % data)
>>  
>> -        self.load_vmsd_json(file)
>> +        self.load_vmsd_json(file, vmsd_json)
>>  
>>          # Read sections
>>          self.sections = collections.OrderedDict()
>> @@ -632,12 +640,25 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
>>                      raise Exception("Mismatched section footer: %x vs %x" % (read_section_id, section_id))
>>              else:
>>                  raise Exception("Unknown section type: %d" % section_type)
>> -        file.close()
>>  
>> -    def load_vmsd_json(self, file):
>> +    def read(self, desc_only = False, dump_memory = False,
>> +             write_memory = False):
>> +        file = MigrationFile(self.filename)
>>          vmsd_json = file.read_migration_debug_json()
>> +
>> +        try:
>> +            self._read(file, vmsd_json, desc_only, dump_memory, write_memory)
>> +        except:
>> +            raise Exception("Full JSON dump:\n%s", vmsd_json)
>
> Better dump the Exception line itself too? IIUC that needs things like:
>
>   except Exception as e:
>       raise Exception(XXX, e, vmsd_json)

It already shows both exceptions in the form:

Traceback (most recent call last):
  <backtrace>
Exception: <msg>

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  <backtrace>
Exception: ('Full JSON dump:\n%s', '{"configuration": {"vmsd_name" ...

>
> More below..
>
>> +        finally:
>> +            file.close()
>> +
>> +    def load_vmsd_json(self, file, vmsd_json):
>>          self.vmsd_desc = json.loads(vmsd_json, object_pairs_hook=collections.OrderedDict)
>>          for device in self.vmsd_desc['devices']:
>> +            if 'fields' not in device:
>> +                raise Exception("vmstate for device %s has no fields" %
>> +                                device['name'])
>
> This looks a valid check, though I still doubt whether this would hit at
> all for this specific error (which looks like a top level STRUCT of a
> section, that is missing "fields").

Ok, but it's a (VMSDSection, device) tuple below. That "device" might
end up in the constructor of the FieldStruct:

MigrationDump.load_vmsd_json:
  ...
  value = ( VMSDSection, device )
  self.section_classes[key] = value
  ...

MigrationDump.read:
  ...
  classdesc = self.section_classes[section_key]
  section = classdesc[0](file, version_id, classdesc[1], section_key)


class VMSDSection(VMSDFieldStruct):
    def __init__(self, file, version_id, device, section_key):
        ...
        # A section really is nothing but a FieldStruct :)
        super(VMSDSection, self).__init__({ 'struct' : desc }, file)

>>              key = (device['name'], device['instance_id'])
>>              value = ( VMSDSection, device )
>>              self.section_classes[key] = value
>> -- 
>> 2.35.3
>> 
>
> For the capture part, would it be easier if we trap at the very top level
> once and for all, then try to dump the vmsd_desc as long as existed?  Like
> this:
>
> ====8<====
> @@ -685,9 +686,15 @@ def default(self, o):
>      f.close()
>  elif args.dump == "state":
>      dump = MigrationDump(args.file)
> -    dump.read(dump_memory = args.memory)
> -    dict = dump.getDict()
> -    print(jsonenc.encode(dict))
> +    try:
> +        dump.read(dump_memory = args.memory)

This is not the only dump.read() call in the file. Ideally we'd wrap
them all. But then there's a slight clash with the parameter validation
part (args.dump == ...) because it raises if no valid option is used.

I'll try to improve this a bit. I was just trying to get this thing to
spit something useful so we can unblock the migration PR.

> +        dict = dump.getDict()
> +        print(jsonenc.encode(dict))
> +    except Exception as e:
> +        # If loading vmstate stream failed, try the best to dump vmsd desc
> +        raise Exception(
> +            f"Caught exception when reading dump: {e}\n"
> +            f"Trying to dump vmsd_desc: {jsonenc.encode(dump.vmsd_desc)}")

I wanted to avoid doing any processing after the error because there's
the chance there's Python issue during decoding. But I can maybe store
the string instead at load_vmsd_json.

>  elif args.dump == "desc":
>      dump = MigrationDump(args.file)
>      dump.read(desc_only = True)
> ====8<====
>
> So no matter what caused error, fallback to try dump vmsd_desc as long as
> available.
>
> Thanks,

