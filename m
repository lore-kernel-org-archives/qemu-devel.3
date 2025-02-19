Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCFBC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 13:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkk06-0007SK-F8; Wed, 19 Feb 2025 08:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkk05-0007S8-Df
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:20:29 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkk02-0000B5-SW
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 08:20:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 914D321217;
 Wed, 19 Feb 2025 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739971224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FBw8H/xOEvXRGAyEE20Y6q8qz2oiPNBMbpm/8lanKzI=;
 b=LVEfv2ubHSlqIqu1joTUKCqHTGZ4dwApaONOO3iS65kh248g5BKohwzOxQnP8AC7B7pVTJ
 QcS6Jj+IOn1Hrtx9NPw5i3g2xO6hdxXgQwljk+4HRGPgmFRih9fKHAJgkCM8YF4INLcMhN
 8dRElfxxno+JPHaSBvY5TpBoafgEqzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739971224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FBw8H/xOEvXRGAyEE20Y6q8qz2oiPNBMbpm/8lanKzI=;
 b=Ux8mxgCPl4d7DQRfP4Lbab1sR4pUz8+lAUrGxl5t3gI92LWF9xdDiv34MHO/8iYXAvxFBf
 nMEU2E/jaHOBDcDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739971224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FBw8H/xOEvXRGAyEE20Y6q8qz2oiPNBMbpm/8lanKzI=;
 b=LVEfv2ubHSlqIqu1joTUKCqHTGZ4dwApaONOO3iS65kh248g5BKohwzOxQnP8AC7B7pVTJ
 QcS6Jj+IOn1Hrtx9NPw5i3g2xO6hdxXgQwljk+4HRGPgmFRih9fKHAJgkCM8YF4INLcMhN
 8dRElfxxno+JPHaSBvY5TpBoafgEqzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739971224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FBw8H/xOEvXRGAyEE20Y6q8qz2oiPNBMbpm/8lanKzI=;
 b=Ux8mxgCPl4d7DQRfP4Lbab1sR4pUz8+lAUrGxl5t3gI92LWF9xdDiv34MHO/8iYXAvxFBf
 nMEU2E/jaHOBDcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0596413874;
 Wed, 19 Feb 2025 13:20:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tQgwLZfatWdoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Feb 2025 13:20:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>
Cc: Li Zhijian via <qemu-devel@nongnu.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
In-Reply-To: <Z7XS8JmtxivALM92@x1.local>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
 <20250218074345.638203-2-lizhijian@fujitsu.com> <87zfij7yob.fsf@suse.de>
 <Z7UMcIQ4QrcXqwK3@x1.local>
 <ea265434-7842-4556-9a99-98ce42b6c1f1@fujitsu.com>
 <Z7XS8JmtxivALM92@x1.local>
Date: Wed, 19 Feb 2025 10:20:21 -0300
Message-ID: <87tt8q8416.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]
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

> On Wed, Feb 19, 2025 at 05:33:26AM +0000, Zhijian Li (Fujitsu) wrote:
>> 
>> 
>> On 19/02/2025 06:40, Peter Xu wrote:
>> > On Tue, Feb 18, 2025 at 06:03:48PM -0300, Fabiano Rosas wrote:
>> >> Li Zhijian via <qemu-devel@nongnu.org> writes:
>> >>
>> >>> This qtest requirs there is RXE link in the host.
>> >>>
>> >>> Here is an example to show how to add this RXE link:
>> >>> $ ./new-rdma-link.sh
>> >>> 192.168.22.93
>> >>>
>> >>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> >>> ---
>> >>> The RDMA migration was broken again...due to lack of sufficient test/qtest.
>> >>>
>> >>> It's urgly to add and execute a script to establish an RDMA link in
>> >>> the C program. If anyone has a better suggestion, please let me know.
>> >>>
>> >>> $ cat ./new-rdma-link.sh
>> >>> get_ipv4_addr() {
>> >>>          ip -4 -o addr show dev "$1" |
>> >>>                  sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
>> >>> }
>> >>>
>> >>> has_soft_rdma() {
>> >>>          rdma link | grep -q " netdev $1[[:blank:]]*\$"
>> >>> }
>> >>>
>> >>> start_soft_rdma() {
>> >>>          local type
>> >>>
>> >>>          modprobe rdma_rxe || return $?
>> >>>          type=rxe
>> >>>          (
>> >>>                  cd /sys/class/net &&
>> >>>                          for i in *; do
>> >>>                                  [ -e "$i" ] || continue
>> >>>                                  [ "$i" = "lo" ] && continue
>> >>>                                  [ "$(<"$i/addr_len")" = 6 ] || continue
>> >>>                                  [ "$(<"$i/carrier")" = 1 ] || continue
>> >>>                                  has_soft_rdma "$i" && break
>> >>>                                  rdma link add "${i}_$type" type $type netdev "$i" && break
>> >>>                          done
>> >>>                  has_soft_rdma "$i" && echo $i
>> >>>          )
>> >>>
>> >>> }
>> >>>
>> >>> rxe_link=$(start_soft_rdma)
>> >>> [[ "$rxe_link" ]] && get_ipv4_addr $rxe_link
>> >>>
>> >>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> >>> ---
>> >>>   tests/qtest/migration/new-rdma-link.sh |  34 ++++++++
>> >>>   tests/qtest/migration/precopy-tests.c  | 103 +++++++++++++++++++++++++
>> >>>   2 files changed, 137 insertions(+)
>> >>>   create mode 100644 tests/qtest/migration/new-rdma-link.sh
>> >>>
>> >>> diff --git a/tests/qtest/migration/new-rdma-link.sh b/tests/qtest/migration/new-rdma-link.sh
>> >>> new file mode 100644
>> >>> index 00000000000..ca20594eaae
>> >>> --- /dev/null
>> >>> +++ b/tests/qtest/migration/new-rdma-link.sh
>> >>> @@ -0,0 +1,34 @@
>> >>> +#!/bin/bash
>> >>> +
>> >>> +# Copied from blktests
>> >>> +get_ipv4_addr() {
>> >>> +	ip -4 -o addr show dev "$1" |
>> >>> +		sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
>> >>> +}
>> >>> +
>> >>> +has_soft_rdma() {
>> >>> +	rdma link | grep -q " netdev $1[[:blank:]]*\$"
>> >>> +}
>> >>> +
>> >>> +start_soft_rdma() {
>> >>> +	local type
>> >>> +
>> >>> +	modprobe rdma_rxe || return $?
>> >>> +	type=rxe
>> >>> +	(
>> >>> +		cd /sys/class/net &&
>> >>> +			for i in *; do
>> >>> +				[ -e "$i" ] || continue
>> >>> +				[ "$i" = "lo" ] && continue
>> >>> +				[ "$(<"$i/addr_len")" = 6 ] || continue
>> >>> +				[ "$(<"$i/carrier")" = 1 ] || continue
>> >>> +				has_soft_rdma "$i" && break
>> >>> +				rdma link add "${i}_$type" type $type netdev "$i" && break
>> >>> +			done
>> >>> +		has_soft_rdma "$i" && echo $i
>> >>> +	)
>> >>> +
>> >>> +}
>> >>> +
>> >>> +rxe_link=$(start_soft_rdma)
>> >>> +[[ "$rxe_link" ]] && get_ipv4_addr $rxe_link
>> >>> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
>> >>> index 162fa695318..d2a1c9c9438 100644
>> >>> --- a/tests/qtest/migration/precopy-tests.c
>> >>> +++ b/tests/qtest/migration/precopy-tests.c
>> >>> @@ -98,6 +98,105 @@ static void test_precopy_unix_dirty_ring(void)
>> >>>       test_precopy_common(&args);
>> >>>   }
>> >>>   
>> >>> +static int new_rdma_link(char *buffer) {
>> >>> +    // Copied from blktests
>> >>> +    const char *script =
>> >>> +        "#!/bin/bash\n"
>> >>> +        "\n"
>> >>> +        "get_ipv4_addr() {\n"
>> >>> +        "    ip -4 -o addr show dev \"$1\" |\n"
>> >>> +        "    sed -n 's/.*[[:blank:]]inet[[:blank:]]*\\([^[:blank:]/]*\\).*/\\1/p'\n"
>> >>> +        "}\n"
>> >>> +        "\n"
>> >>> +        "has_soft_rdma() {\n"
>> >>> +        "    rdma link | grep -q \" netdev $1[[:blank:]]*\\$\"\n"
>> >>> +        "}\n"
>> >>> +        "\n"
>> >>> +        "start_soft_rdma() {\n"
>> >>> +        "    local type\n"
>> >>> +        "\n"
>> >>> +        "    modprobe rdma_rxe || return $?\n"
>> >>> +        "    type=rxe\n"
>> >>> +        "    (\n"
>> >>> +        "        cd /sys/class/net &&\n"
>> >>> +        "        for i in *; do\n"
>> >>> +        "            [ -e \"$i\" ] || continue\n"
>> >>> +        "            [ \"$i\" = \"lo\" ] && continue\n"
>> >>> +        "            [ \"$(<$i/addr_len)\" = 6 ] || continue\n"
>> >>> +        "            [ \"$(<$i/carrier)\" = 1 ] || continue\n"
>> >>> +        "            has_soft_rdma \"$i\" && break\n"
>> >>> +        "            rdma link add \"${i}_$type\" type $type netdev \"$i\" && break\n"
>> >>> +        "        done\n"
>> >>> +        "        has_soft_rdma \"$i\" && echo $i\n"
>> >>> +        "    )\n"
>> >>> +        "}\n"
>> >>> +        "\n"
>> >>> +        "rxe_link=$(start_soft_rdma)\n"
>> >>> +        "[[ \"$rxe_link\" ]] && get_ipv4_addr $rxe_link\n";
>> >>> +
>> >>> +    char script_filename[] = "/tmp/temp_scriptXXXXXX";
>> >>> +    int fd = mkstemp(script_filename);
>> >>> +    if (fd == -1) {
>> >>> +        perror("Failed to create temporary file");
>> >>> +        return 1;
>> >>> +    }
>> >>> +
>> >>> +    FILE *fp = fdopen(fd, "w");
>> >>> +    if (fp == NULL) {
>> >>> +        perror("Failed to open file stream");
>> >>> +        close(fd);
>> >>> +        return 1;
>> >>> +    }
>> >>> +    fprintf(fp, "%s", script);
>> >>> +    fclose(fp);
>> >>> +
>> >>> +    if (chmod(script_filename, 0700) == -1) {
>> >>> +        perror("Failed to set execute permission");
>> >>> +        return 1;
>> >>> +    }
>> >>> +
>> >>> +    FILE *pipe = popen(script_filename, "r");
>> >>> +    if (pipe == NULL) {
>> >>> +        perror("Failed to run script");
>> >>> +        return 1;
>> >>> +    }
>> >>> +
>> >>> +    int idx = 0;
>> >>> +    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
>> >>> +        idx += strlen(buffer);
>> >>> +    }
>> >>> +    if (buffer[idx - 1] == '\n')
>> >>> +        buffer[idx - 1] = 0;
>> >>> +
>> >>> +    int status = pclose(pipe);
>> >>> +    if (status == -1) {
>> >>> +        perror("Error reported by pclose()");
>> >>> +    } else if (!WIFEXITED(status)) {
>> >>> +        printf("Script did not terminate normally\n");
>> >>> +    }
>> >>> +
>> >>> +    remove(script_filename);
>> > 
>> > The script can be put separately instead if hard-coded here, right?
>> 
>> 
>> Sure, If so, I wonder whether the migration-test program is able to know where is this script?
>> 
>> 
>> > 
>> >>> +
>> >>> +    return 0;
>> >>> +}
>> >>> +
>> >>> +static void test_precopy_rdma_plain(void)
>> >>> +{
>> >>> +    char buffer[128] = {};
>> >>> +
>> >>> +    if (new_rdma_link(buffer))
>> >>> +        return;
>> >>> +
>> >>> +    g_autofree char *uri = g_strdup_printf("rdma:%s:7777", buffer);
>> >>> +
>> >>> +    MigrateCommon args = {
>> >>> +        .listen_uri = uri,
>> >>> +        .connect_uri = uri,
>> >>> +    };
>> >>> +
>> >>> +    test_precopy_common(&args);
>> >>> +}
>> >>> +
>> >>>   static void test_precopy_tcp_plain(void)
>> >>>   {
>> >>>       MigrateCommon args = {
>> >>> @@ -968,6 +1067,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
>> >>>                          test_multifd_tcp_uri_none);
>> >>>       migration_test_add("/migration/multifd/tcp/plain/cancel",
>> >>>                          test_multifd_tcp_cancel);
>> >>> +#ifdef CONFIG_RDMA
>> >>> +    migration_test_add("/migration/precopy/rdma/plain",
>> >>> +                       test_precopy_rdma_plain);
>> >>> +#endif
>> >>>   }
>> >>>   
>> >>>   void migration_test_add_precopy(MigrationTestEnv *env)
>> >>
>> >> Thanks, that's definitely better than nothing. I'll experiment with this
>> >> locally, see if I can at least run it before sending a pull request.
>> > 
>> > With your newly added --full, IIUC we can add whatever we want there.
>> > E.g. we can add --rdma and iff specified, migration-test adds the rdma test.
>> > 
>> > Or.. skip the test when the rdma link isn't available.
>> > 
>> > If we could separate the script into a file, it'll be better.  We could
>> > create scripts/migration dir and put all migration scripts over there,
>> 
>> We have any other existing script? I didn't find it in current QEMU tree.
>
> We have a few that I'm aware of:
>
>   - analyze-migration.py
>   - vmstate-static-checker.py
>   - userfaultfd-wrlat.py
>

If it cannot be reached from there for some reason, we could copy it to
build/tests/qtest/migration during the build. As a last resort I'm fine
with just having it directly at tests/qtest/migration like this patch
does.

>> 
>> 
>> > then
>> > in the test it tries to detect rdma link and fetch the ip only
>> 
>> It should work without root permission if we just *detect* and *fetch ip*.
>> 
>> Do you also mean we can split new-rdma-link.sh to 2 separate scripts
>> - add-rdma-link.sh # optionally, execute by user before the test (require root permission)
>> - detect-fetch-rdma.sh # execute from the migration-test
>
> Hmm indeed we still need a script to scan over all the ports..
>
> If having --rdma is a good idea, maybe we can further make it a parameter
> to --rdma?
>
>   $ migration-test --rdma $RDMA_IP
>
> Or:
>
>   $ migration-test --rdma-ip $RDMA_IP

I think --rdma only makes sense if it's going to do something
special. The optmimal scenario is that it always runs the test when it
can and sets up/tears down anything it needs.

If it needs root, I'd prefer the test informs about this and does the
work itself.

It would also be good to have the add + detect separate so we have more
flexibility, maybe we manage to enable this in CI even.

So:

./add.sh
migration-test
(runs detect.sh + runs rdma test)
(leaves stuff behind)

migration-test
(skips rdma test with message that it needs root)

sudo migration-test
(runs add.sh + detect.sh + runs rdma test)
(cleans itself up)

Does that make sense to you? I hope it's not too much work.

If you'd like to limit the usage of sudo for running the tests, then we
could indeed add the --rdma option and this would be even more
strict. The good thing of not having --rdma is that I could call add.sh
and then run the full make check afterwards, but that's not a huge deal.

> Then maybe migration-test can directly take that IP and run the tests,
> assuming the admin setup the rdma link.  Then we keep that one script.
>
> Or I assume it's still ok that the test requires root only for --rdma, then
> invoke the script directly in the test.  If so, we'd better also remove the
> rdma link after test finished, so no side effect of the test (modprobe is
> probably fine).
>
> We can wait and see how far Fabiano went with this, and also his opinion.

I haven't got the chance to try the script yet. I still need to figure
out what packages I need from the distro.

