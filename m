Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA997C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 22:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBjCn-0003jc-TZ; Mon, 27 May 2024 18:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sBjCm-0003jB-Hl
 for qemu-devel@nongnu.org; Mon, 27 May 2024 18:52:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sBjCk-0001lu-Js
 for qemu-devel@nongnu.org; Mon, 27 May 2024 18:52:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A17F1FFC3;
 Mon, 27 May 2024 22:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716850352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/qbMfx3PYFNdZvSICr1x7eDWGcYOgjDAe9zAdmpyY4=;
 b=pGAfuisn3NPk9Eym1VQHMNu7W0VWA/LPl880J7H7Ym/qJEe5X3k03dV/k8s/WMsO0JFzjJ
 pFXVyiXdqWXRAu7QlbNI0d39GI5Rf5ZUK0Uy73oybkDPI2mFy1CLWa/LQiEVuyE3j9RmhI
 jme3rAEgK6ZvfetRIOw8EanmRsB9KQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716850352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/qbMfx3PYFNdZvSICr1x7eDWGcYOgjDAe9zAdmpyY4=;
 b=VFTOYBGrqkt2eNziaI+0ItzjXsawRGUoL3RCBS4QXmlvFjgtPIcYen/l1W3S93pcZafS0/
 pmq41+2muP6mPKCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716850351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/qbMfx3PYFNdZvSICr1x7eDWGcYOgjDAe9zAdmpyY4=;
 b=jLiwbciH3FFN0yLowbneGfZm11duxcnjsMWxuqjgvlDjG5e+yoLDR875Jii2qP3XhiapsA
 OzaPjnwp9KU3+z+j/+ZOucTS0QjatmlIopC0NrK1AaXCeqeyEEVbh8RWNMMi6gVNTT6hE8
 0+cNjT0Vx0l9eprwQgLREg5XZL+gUvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716850351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3/qbMfx3PYFNdZvSICr1x7eDWGcYOgjDAe9zAdmpyY4=;
 b=HyIJincywn2bfHvGoWC/PyF8v7/FG6sDL3k8jqAq6bt7h9CEMJ+7i0QJvKRerWKStCK9VR
 fNomVEd3y/CRwOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E604B13A6B;
 Mon, 27 May 2024 22:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id prH5Kq4OVWb9UQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 May 2024 22:52:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>, Het Gala
 <het.gala@nutanix.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/4] tests/qtest/migration: Add a test that runs
 vmstate-static-checker
In-Reply-To: <ZlT11c-9IDwVfm52@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-3-farosas@suse.de> <ZlT11c-9IDwVfm52@x1n>
Date: Mon, 27 May 2024 19:52:28 -0300
Message-ID: <87zfsag95f.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
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

> On Thu, May 23, 2024 at 05:19:20PM -0300, Fabiano Rosas wrote:
>> We have the vmstate-static-checker script that takes the output of:
>> '$QEMU -M $machine -dump-vmstate' for two different QEMU versions and
>> compares them to check for compatibility breakages. This is just too
>> simple and useful for us to pass on it. Add a test that runs the
>> script.
>> 
>> Since this needs to use two different QEMU versions, the test is
>> skipped if only one QEMU is provided. The infrastructure for passing
>> more than one binary is already in place:
>> 
>> $ PYTHON=$(which python3.11) \
>>  QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-x86_64 \
>>  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>>  ./tests/qtest/migration-test -p /x86_64/migration/vmstate-checker-script
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> some code duplication for now, just so we can reason about this
>> without too much noise
>> ---
>>  tests/qtest/migration-test.c | 82 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index e8d3555f56..2253e0fc5b 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -63,6 +63,7 @@ static QTestMigrationState dst_state;
>>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>>  
>>  #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
>> +#define VMSTATE_CHECKER_SCRIPT "scripts/vmstate-static-checker.py"
>>  
>>  #define QEMU_VM_FILE_MAGIC 0x5145564d
>>  #define FILE_TEST_FILENAME "migfile"
>> @@ -1611,6 +1612,85 @@ static void test_analyze_script(void)
>>      test_migrate_end(from, to, false);
>>      cleanup("migfile");
>>  }
>> +
>> +static void test_vmstate_checker_script(void)
>> +{
>> +    g_autofree gchar *cmd_src = NULL;
>> +    g_autofree gchar *cmd_dst = NULL;
>> +    g_autofree gchar *vmstate_src = NULL;
>> +    g_autofree gchar *vmstate_dst = NULL;
>> +    const char *machine_alias, *machine_opts = "";
>> +    g_autofree char *machine = NULL;
>> +    const char *arch = qtest_get_arch();
>> +    int pid, wstatus;
>> +    const char *python = g_getenv("PYTHON");
>> +
>> +    if (!getenv(QEMU_ENV_SRC) && !getenv(QEMU_ENV_DST)) {
>> +        g_test_skip("Test needs two different QEMU versions");
>> +        return;
>> +    }
>> +
>> +    if (!python) {
>> +        g_test_skip("PYTHON variable not set");
>> +        return;
>> +    }
>> +
>> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>> +        if (g_str_equal(arch, "i386")) {
>> +            machine_alias = "pc";
>> +        } else {
>> +            machine_alias = "q35";
>> +        }
>> +    } else if (g_str_equal(arch, "s390x")) {
>> +        machine_alias = "s390-ccw-virtio";
>> +    } else if (strcmp(arch, "ppc64") == 0) {
>> +        machine_alias = "pseries";
>> +    } else if (strcmp(arch, "aarch64") == 0) {
>> +        machine_alias = "virt";
>> +    } else {
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    if (!qtest_has_machine(machine_alias)) {
>> +        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
>> +        g_test_skip(msg);
>> +        return;
>> +    }
>> +
>> +    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
>> +                                      QEMU_ENV_DST);
>> +
>> +    vmstate_src = g_strdup_printf("%s/vmstate-src", tmpfs);
>> +    vmstate_dst = g_strdup_printf("%s/vmstate-dst", tmpfs);
>> +
>> +    cmd_dst = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
>> +                              machine, machine_opts, vmstate_dst);
>> +    cmd_src = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
>> +                              machine, machine_opts, vmstate_src);
>> +
>> +    qtest_init_with_env_no_handshake(QEMU_ENV_SRC, cmd_src);
>> +    qtest_init_with_env_no_handshake(QEMU_ENV_DST, cmd_dst);
>> +
>> +    pid = fork();
>> +    if (!pid) {
>> +        close(1);
>> +        open("/dev/null", O_WRONLY);
>> +        execl(python, python, VMSTATE_CHECKER_SCRIPT,
>> +              "-s", vmstate_src,
>> +              "-d", vmstate_dst,
>> +              NULL);
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    g_assert(waitpid(pid, &wstatus, 0) == pid);
>> +    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
>> +        g_test_message("Failed to run vmstate-static-checker.py");
>> +        g_test_fail();
>> +    }
>> +
>> +    cleanup("vmstate-src");
>> +    cleanup("vmstate-dst");
>> +}
>
> Did I ask before on whether this can be written without C?

If you did I forgot about it, sorry.

> I think this and also the analyze-script are more suitable to be written in
> other ways, e.g., bash or python, no?
>

I would prefer not to fragment the test framework. There's a bunch of
infra already present in migration-test/libqtest that we would end up
having to rewrite in the other languages.

>>  #endif
>>  
>>  static void test_precopy_common(MigrateCommon *args)
>> @@ -3495,6 +3575,8 @@ int main(int argc, char **argv)
>>  #ifndef _WIN32
>>      if (!g_str_equal(arch, "s390x")) {
>>          migration_test_add("/migration/analyze-script", test_analyze_script);
>> +        migration_test_add("/migration/vmstate-checker-script",
>> +                           test_vmstate_checker_script);
>>      }
>>  #endif
>>      migration_test_add("/migration/precopy/unix/plain",
>> -- 
>> 2.35.3
>> 

