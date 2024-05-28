Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A57C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1Hn-0000FV-BW; Tue, 28 May 2024 14:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sC1Hl-0000FF-M7
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:10:57 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sC1Hj-0000iu-79
 for qemu-devel@nongnu.org; Tue, 28 May 2024 14:10:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 835AD22A9B;
 Tue, 28 May 2024 18:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716919851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtZt/kFeGg70tEtQYWAlmSpv2e1TKFj0TNXulv1iZNo=;
 b=oYCe5UtEQaM63jC0iFCJ7t0pP7Fjm5AGn248gnenwy2p/qcSwY1RLwCYBAhcOtCDoNTGuL
 9FbLg6SXzEtVKNcjP0agM+P4zdA/BJkMssip19nwWUHSEZ11pJ5djze5LTpkbDEyDcXnND
 CpN32MWgo/HhNcmhP9z8QsdQiFl5gP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716919851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtZt/kFeGg70tEtQYWAlmSpv2e1TKFj0TNXulv1iZNo=;
 b=7YlXOJ3FNq/VlvXUdSQjdXBPT391ImghH/6XDsNa7jlbcfhAs2FujACX3/u2GjcbJW+5sF
 lPaP3edkWLst1PAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716919851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtZt/kFeGg70tEtQYWAlmSpv2e1TKFj0TNXulv1iZNo=;
 b=oYCe5UtEQaM63jC0iFCJ7t0pP7Fjm5AGn248gnenwy2p/qcSwY1RLwCYBAhcOtCDoNTGuL
 9FbLg6SXzEtVKNcjP0agM+P4zdA/BJkMssip19nwWUHSEZ11pJ5djze5LTpkbDEyDcXnND
 CpN32MWgo/HhNcmhP9z8QsdQiFl5gP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716919851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtZt/kFeGg70tEtQYWAlmSpv2e1TKFj0TNXulv1iZNo=;
 b=7YlXOJ3FNq/VlvXUdSQjdXBPT391ImghH/6XDsNa7jlbcfhAs2FujACX3/u2GjcbJW+5sF
 lPaP3edkWLst1PAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 069E113A5D;
 Tue, 28 May 2024 18:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4EovLyoeVmY/GwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 May 2024 18:10:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>, Het Gala
 <het.gala@nutanix.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH 4/4] ci: Add the new migration device tests
In-Reply-To: <ZlX8sNDh2gIFa2Kp@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-5-farosas@suse.de> <ZlT4f368xO8fXsUY@x1n>
 <87ttiig62j.fsf@suse.de> <ZlX8sNDh2gIFa2Kp@x1n>
Date: Tue, 28 May 2024 15:10:48 -0300
Message-ID: <87mso9g63b.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Mon, May 27, 2024 at 08:59:00PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, May 23, 2024 at 05:19:22PM -0300, Fabiano Rosas wrote:
>> >> We have two new migration tests that check cross version
>> >> compatibility. One uses the vmstate-static-checker.py script to
>> >> compare the vmstate structures from two different QEMU versions. The
>> >> other runs a simple migration with a few devices present in the VM, to
>> >> catch obvious breakages.
>> >> 
>> >> Add both tests to the migration-compat-common job.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >>  .gitlab-ci.d/buildtest.yml | 43 +++++++++++++++++++++++++++++++-------
>> >>  1 file changed, 36 insertions(+), 7 deletions(-)
>> >> 
>> >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> >> index 91c57efded..bc7ac35983 100644
>> >> --- a/.gitlab-ci.d/buildtest.yml
>> >> +++ b/.gitlab-ci.d/buildtest.yml
>> >> @@ -202,18 +202,47 @@ build-previous-qemu:
>> >>    needs:
>> >>      - job: build-previous-qemu
>> >>      - job: build-system-opensuse
>> >> -  # The old QEMU could have bugs unrelated to migration that are
>> >> -  # already fixed in the current development branch, so this test
>> >> -  # might fail.
>> >> +  # This test is allowed to fail because:
>> >> +  #
>> >> +  # - The old QEMU could have bugs unrelated to migration that are
>> >> +  #   already fixed in the current development branch.
>> >
>> > Did you ever hit a real failure with this?  I'm wondering whether we can
>> > remove this allow_failure thing.
>> >
>> 
>> I haven't. But when it fails we'll go through an entire release cycle
>> with this thing showing red for every person that runs the CI. Remember,
>> this is a CI failure to which there's no fix aside from waiting for the
>> release to happen. Even if we're quick to react and disable the job, I
>> feel it might create some confusion already.
>
> My imagination was if needed we'll get complains and we add that until
> then for that broken release only, and remove in the next release again.
>
>> 
>> >> +  #
>> >> +  # - The vmstate-static-checker script trips on renames and other
>> >> +  #   backward-compatible changes to the vmstate structs.
>> >
>> > I think I keep my preference per last time we talked on this. :)
>> 
>> Sorry, I'm not trying to force this in any way, I just wrote these to
>> use in the pull-request and thought I'd put it out there. At the very
>> least we can have your concerns documented. =)
>
> Yep that's fine.  I think we should keep such discussion on the list,
> especially we have different opinions, while none of us got convinced yet
> so far. :)
>
>> 
>> > I still think it's too early to involve a test that can report false
>> > negative.
>> 
>> (1)
>> Well, we haven't seen any false negatives, we've seen fields being
>> renamed. If that happens, then we'll ask the person to update the
>> script. Is that not acceptable to you? Or are you thinking about other
>> sorts of issues?
>
> Then question is how to update the script. So far it's treated as failure
> on rename, even if it's benign. Right now we have this:
>
>             print("Section \"" + sec + "\",", end=' ')
>             print("Description \"" + desc + "\":", end=' ')
>             print("expected field \"" + s_item["field"] + "\",", end=' ')
>             print("got \"" + d_item["field"] + "\"; skipping rest")
>             bump_taint()
>             break
>
> Do you want to introduce a list of renamed vmsd fields in this script and
> maintain that?  IMHO it's an overkill and unnecessary burden to other
> developers.
>

That's not _my_ idea, we already have that (see below). There's not much
reason to rename fields like that, the vmstate is obviously something
that should be kept stable, so having to do a rename in a script is way
better than having to figure out the fix for the compatibility break.

def check_fields_match(name, s_field, d_field):
    if s_field == d_field:
        return True

    # Some fields changed names between qemu versions.  This list
    # is used to allow such changes in each section / description.
    changed_names = {
        'apic': ['timer', 'timer_expiry'],
        'e1000': ['dev', 'parent_obj'],
        'ehci': ['dev', 'pcidev'],
        'I440FX': ['dev', 'parent_obj'],
        'ich9_ahci': ['card', 'parent_obj'],
        'ich9-ahci': ['ahci', 'ich9_ahci'],
        'ioh3420': ['PCIDevice', 'PCIEDevice'],
        'ioh-3240-express-root-port': ['port.br.dev',
                                       'parent_obj.parent_obj.parent_obj',
                                       'port.br.dev.exp.aer_log',
                                'parent_obj.parent_obj.parent_obj.exp.aer_log'],
        'cirrus_vga': ['hw_cursor_x', 'vga.hw_cursor_x',
                       'hw_cursor_y', 'vga.hw_cursor_y'],
        'lsiscsi': ['dev', 'parent_obj'],
        'mch': ['d', 'parent_obj'],
        'pci_bridge': ['bridge.dev', 'parent_obj', 'bridge.dev.shpc', 'shpc'],
        'pcnet': ['pci_dev', 'parent_obj'],
        'PIIX3': ['pci_irq_levels', 'pci_irq_levels_vmstate'],
        'piix4_pm': ['dev', 'parent_obj', 'pci0_status',
                     'acpi_pci_hotplug.acpi_pcihp_pci_status[0x0]',
                     'pm1a.sts', 'ar.pm1.evt.sts', 'pm1a.en', 'ar.pm1.evt.en',
                     'pm1_cnt.cnt', 'ar.pm1.cnt.cnt',
                     'tmr.timer', 'ar.tmr.timer',
                     'tmr.overflow_time', 'ar.tmr.overflow_time',
                     'gpe', 'ar.gpe'],
        'rtl8139': ['dev', 'parent_obj'],
        'qxl': ['num_surfaces', 'ssd.num_surfaces'],
        'usb-ccid': ['abProtocolDataStructure', 'abProtocolDataStructure.data'],
        'usb-host': ['dev', 'parent_obj'],
        'usb-mouse': ['usb-ptr-queue', 'HIDPointerEventQueue'],
        'usb-tablet': ['usb-ptr-queue', 'HIDPointerEventQueue'],
        'vmware_vga': ['card', 'parent_obj'],
        'vmware_vga_internal': ['depth', 'new_depth'],
        'xhci': ['pci_dev', 'parent_obj'],
        'x3130-upstream': ['PCIDevice', 'PCIEDevice'],
        'xio3130-express-downstream-port': ['port.br.dev',
                                            'parent_obj.parent_obj.parent_obj',
                                            'port.br.dev.exp.aer_log',
                                'parent_obj.parent_obj.parent_obj.exp.aer_log'],
        'xio3130-downstream': ['PCIDevice', 'PCIEDevice'],
        'xio3130-express-upstream-port': ['br.dev', 'parent_obj.parent_obj',
                                          'br.dev.exp.aer_log',
                                          'parent_obj.parent_obj.exp.aer_log'],
        'spapr_pci': ['dma_liobn[0]', 'mig_liobn',
                      'mem_win_addr', 'mig_mem_win_addr',
                      'mem_win_size', 'mig_mem_win_size',
                      'io_win_addr', 'mig_io_win_addr',
                      'io_win_size', 'mig_io_win_size'],
    }

    if not name in changed_names:
        return False

    if s_field in changed_names[name] and d_field in changed_names[name]:
        return True

    return False


>> 
>> > I'd still keep running this before soft-freeze like I used to
>> > do, throw issues to others and urge them to fix before release.
>> 
>> Having hidden procedures that maintainers run before a release is bad
>> IMHO, it just delays the catching of bugs and frustrates
>> contributors. Imagine working on a series, everything goes well with
>> reviews, CI passes, patch gets queued and merged and a month later you
>> get a ping about something you should have done to avoid breaking
>> migration. Right during freeze.
>
> I understand your point, however I don't yet see a way CI could cover
> everything.  CI won't cover performance test, and I still ran multifd tests
> at least smoke it too before soft-freeze.
>
> If there's something done wrong, we notify the sooner the better.  Now it
> looks to me the best trade-off is like that - we notify at soft-freeze once
> per release considering that's pretty rare too, e.g. 9.0 has no such outlier.

We should notify before merging any code. If there is a tool that can
catch the bug, there's no point in wasting everyone's time carrying that
patch forward. That's the purpose of a CI setup. These tests are very
light in terms of resources.

Now, you're making the point that these issues are rare, which they may
very well be, I haven't ran this long enough to know. I also don't know
how to measure that, I believe our CI already has a large amount of
tests that never catch anything, so I'm not sure how much we should take
it in consideration when adding tests to the CI.

About the possibly false results, we'll have to hold merging this for a
few releases and gather more data, see how much of a bother it is to
keep updating these fields. I expect to have more bugs caught by the
script than any renames happening.

>
> Again I'm happy if we have a solution to not report false negatives; that's
> the only concern I have.
>> 
>> > Per my
>> > previous experience that doesn't consume me a lot of time, and it's not
>> > common to see issues either.
>> >
>> > So I want people to really pay attention when someone sees a migration CI
>> > test failed, rather than we help people form the habit in "oh migration CI
>> > failed again?  I think that's fine, it allows failing anyway".
>> 
>> That's a good point. I don't think it applies here though. See my point
>> in (1).
>
> Yes, if you have an answer to (1) I'm ok too.  Maybe I misunderstood your
> plan there.
>
> Thanks,
>
>> 
>> > So far I still don't see as much benefit to adding this if we need to pay
>> > for the other false negative issue.  I'll fully support it if e.g. we can
>> > fix the tool to avoid reporting false negatives, but that may take effort
>> > that I didn't check.
>> >
>> 

