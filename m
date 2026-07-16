Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F30AC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMlu-0004JU-75; Thu, 16 Jul 2026 10:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wkMlt-0004JM-0N
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:09:05 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wkMlq-0002Ky-SZ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:09:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CAEA3DF5;
 Thu, 16 Jul 2026 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784210941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doARhWkB/+hg9g2G/MWFsYTDZ2MMihTXLifaR94YNME=;
 b=poAZMjI5W5WUizZ3HKc59+9rAZKVYVwg3wMdPunLH74y/6Htoy3iPXpyaeUShJ4pB2UX/I
 hYz6xvbMrHFNCfMJn5RxqWzcr5IF9/70JolUGmxd5pWbZ9LuhQ76Y5CIabFZZB1dQNeIeE
 uJAQTRp10p72D1Zc1N56KcMc3cNKLc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784210941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doARhWkB/+hg9g2G/MWFsYTDZ2MMihTXLifaR94YNME=;
 b=JXbmB9y54FZg5Y9GuEYR88RLHXglvWaiAQN1pq2CSjgerqwpBt7Eft9rvfSU//qWJ8b2sx
 y4BZFGsuxHDibRDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784210940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doARhWkB/+hg9g2G/MWFsYTDZ2MMihTXLifaR94YNME=;
 b=s0XJopi4zE2pll4ePOysIlYvMh3D5bwrkKFYdZowXSqMFK5ccj5pJ5rm+coSXU8b0CmsYg
 7guAWgV2sWmMgOxMZfRb93GuUqDYTQo+7XKE71gw9u4yYM/A7dpPE+re8p1rEBgRoNzYc3
 MdEnce7OYd29p3WnG3YfK4XSQ//d/Yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784210940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=doARhWkB/+hg9g2G/MWFsYTDZ2MMihTXLifaR94YNME=;
 b=z9eoW/uhIZ8Fnto8hqZC9ed2PXgoTmuh3lHk3IR+f4NGOJwaqI4DfzyHNW5mXIASCWJGfH
 Z0jFgMVDtZw+FaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A41E779AD;
 Thu, 16 Jul 2026 14:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1uHeGvvlWGrNLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 16 Jul 2026 14:08:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
In-Reply-To: <ak0q0vOeFVJsDBcL@redhat.com>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com>
Date: Thu, 16 Jul 2026 11:08:49 -0300
Message-ID: <87jyqv3u32.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, qemu.org:url,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Jul 07, 2026 at 04:43:43PM +0400, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>=20
>> On Tue, Jul 7, 2026 at 2:59=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
>> >
>> > Beyond the overall virt/non-virt use case classification, there are
>> > a number of scenarios which we have decided will not be treated as
>> > security issues. Start to document some of these to give consistency
>> > in our treatemnt of incoming disclosures.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >
>> > Mauro / Michael: please suggest any other rules which we have applied
>> > historically on qemu-security disclosures that we should capture here.
>> >
>> > The vfio-user/vhost-user addition is a new one based on discussions
>> > in some GitLab issues today/yesterday
>> >
>> >  docs/system/security.rst | 63 ++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 63 insertions(+)
>> >
>> > diff --git a/docs/system/security.rst b/docs/system/security.rst
>> > index 53992048e6..fbbca50f95 100644
>> > --- a/docs/system/security.rst
>> > +++ b/docs/system/security.rst
>> > @@ -75,6 +75,69 @@ Bugs affecting the non-virtualization use case are =
not considered security
>> >  bugs at this time.  Users with non-virtualization use cases must not =
rely on
>> >  QEMU to provide guest isolation or any security guarantees.
>> >
>> > +Security boundary scope
>> > +'''''''''''''''''''''''
>> > +
>> > +Even where a flaw affects the virtualization use case described above,
>> > +not all scenarios will be considered in scope. The following guidelin=
es
>> > +are used to evaluate whether to apply the full security process, or t=
reat
>> > +an issue as a normal bug.
>> > +
>> > +* **assert** / **abort**. If triggering the code path requires kernel
>> > +  privileges (or root account access) in the guest, asserts/aborts in
>> > +  QEMU are a self inflicted denial of service. These will **not** be
>> > +  treated as security flaws, at most hardening bugs. If triggering the
>> > +  code path can be done by an unprivileged guest OS account, this
>> > +  **may** justify handling as a security bug.
>> > +
>> > +* **vhost-user/vfio-user backends**. The backend processes have
>> > +  shared memory regions co-mapped with the QEMU process. The intent
>> > +  of the process separation is operational resilience & flexibility
>> > +  and allowing for independent software suppliers. There is not
>> > +  considered to be security boundary between QEMU and the vhost-user
>> > +  & vfio-user backends. Thus flaws in the backends which can cause
>> > +  crashes / undesirable behaviour in QEMU will **not** be treated as
>> > +  security flaws, but should be fixed as hardening bugs.
>> > +
>> > +* **memory allocation bounds**. There are many ways in which a QEMU
>> > +  process can legitimately consume an amount of memory that is
>> > +  significantly larger than the assigned guest RAM. QEMU's worst
>> > +  case memory usage should be considered effectively unbounded. As
>> > +  such the QEMU deployment on the host should account for the
>> > +  possibility of large memory peaks and apply countermeasures to
>> > +  provide continuity of host operations. It is typical for the Linux
>> > +  OOM killer to reap the process triggering host memory overcommit
>> > +  in the case of exccessive usage, offering a degree of protection.
>> > +  As such, bugs which can lead to excessive/unbounded memory allocati=
ons
>> > +  will usually not be classified as security flaws, but should be
>> > +  fixed as hardening bugs.
>> > +
>> > +* **degraded guest behaviour**. There are a set of bugs which can
>> > +  lead guest hardware devices to misbehave. For example, a flawed
>> > +  virtual IOMMU operation may not offer the guest device isolation
>> > +  that would otherwise be expected. If a guest triggered exploit
>> > +  requires kernel privileges (or root account access), and leads
>> > +  to sub-optimal behaviour of the virtual device this is considered
>> > +  a self inflicted service degradation. These will **not** be
>> > +  treated as security flaws, at most hardening bugs. If triggernig
>> > +  the code path can be done by an unprivileged guest OS account,
>> > +  this may justify handling as a security bug.
>> > +
>> > +* **nested virtualization**. The scope for nested virtualization
>> > +  is to prevent a level 2 guest from breaking out into a level
>> > +  1 guest. As noted above, a number of scenarios exclude security
>> > +  handling for flaws only exploitable by the guest kernel / root
>> > +  account with affect the guest's own service/availability. In the
>> > +  context of nested virtualization with PCI device assignment, it
>> > +  may may be possible for a level 2 guest kernel to trigger flaws
>> > +  that affect the level 0 QEMU process. While these bugs should be
>> > +  fixed, they will not be triaged as security flaws at this time.
>> > +
>> > +* **low severity impact**. As a catch all rule, issues which
>> > +  are judged to have a "low" severity impact on the system will
>> > +  usually not justify handling as security bugs, nor assignment
>> > +  of CVEs. They will be fixed as routine bugs when time allows.
>>=20
>> Should we have a section about management-plane protocols? (migration,
>> QMP, monitor), since they already require trusted network access?
>
> There is a section later about QMP/monitor
>
>   https://www.qemu.org/docs/master/system/security.html#sensitive-configu=
rations
>
> For migration we do need to think of something to explain our approach
> more clearly, and indeed document our expectations for configuration
> for migration (trusted LAN vs TLS + certs).
>

+CC peterx

Hi, I put together a draft so we can discuss, let me know what you
think.

Assumptions:

A) The migration stream is assumed to be secured by TLS on a per-host
basis.

B) For migration streams stored to file, including snapshots, it is
assumed that the storage file is authentic, i.e. the files are owned by
the party performing the live migration and have not been tampered with.

C) The network ports used for migration are expected to be available
only during migration. No long-standing listening destination QEMU
process.

D) The network used for migration is expected to be adequately isolated.

E) The migration source QEMU process is assumed to be secure. Compromise
of the source QEMU process is nonetheless possible but exploiting the
migration process is expected to grant no further privileges.

For security consideration, the following are considered:

OUT OF SCOPE:

1) Abort of destination QEMU process while migration is still in course.
Rationale: the source virtual machine is not affected.

2) Migration failure.
Rationale: eventual failed migrations are part of normal operation.

3) Memory over-allocation issues in the destination QEMU process.
Rationale: the destination host's operating system is expected to
constrain resource usage. Process termination due to OOM falls under
point 1 above.

IN SCOPE:

1) Privilege escalation from the guest operating system into the
destination QEMU process or host.

2) Tampering or exfiltration of migration stream data by a third party
at a lower privilege level than either QEMU processes involved in the
migration.

3) Termination of the source QEMU process by source virtual machine
guest userspace, including by forcing host OS resource constraints to
be reached.

4) Other tampering or exfiltration of data from the source QEMU process
if reached from migration code or migration stream manipulation.

5) Causing source QEMU process to enter a state from which migration is
not possible permanently.

The overall effect of this policy is that only legitimately produced
migration data is considered for security implications, whether that
data is malicious or buggy.

