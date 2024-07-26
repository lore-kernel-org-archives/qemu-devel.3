Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D9CC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 14:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXLpY-0000Ng-Fu; Fri, 26 Jul 2024 10:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1sXLpW-0000Me-G4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 10:21:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1sXLpU-00014c-4T
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 10:21:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6415C1F82D;
 Fri, 26 Jul 2024 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1722003712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=tBFz1qLHbz1jFtlHAKKcACG6nNYrHa1NApu5Ev1+JUo=;
 b=pj+bclFt9Y+u2wPi/GtBMZcOX1wRT7lBHT1CZ4vEIQ5J26ELlxGS571sy/qFfrKqoSA9iA
 f1w2onWkhFCyiMY3pDvfe2dda+ExJChndsC5cQPW7eofWYVoJG/u7RTOkgunlSBmofiau4
 Eo9d5VeDnFVagFyUihcjRz/P+7S/6SU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1722003712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=tBFz1qLHbz1jFtlHAKKcACG6nNYrHa1NApu5Ev1+JUo=;
 b=pj+bclFt9Y+u2wPi/GtBMZcOX1wRT7lBHT1CZ4vEIQ5J26ELlxGS571sy/qFfrKqoSA9iA
 f1w2onWkhFCyiMY3pDvfe2dda+ExJChndsC5cQPW7eofWYVoJG/u7RTOkgunlSBmofiau4
 Eo9d5VeDnFVagFyUihcjRz/P+7S/6SU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F13A9138A7;
 Fri, 26 Jul 2024 14:21:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gDphOP+wo2YzHgAAD6G6ig
 (envelope-from <dfaggioli@suse.com>); Fri, 26 Jul 2024 14:21:51 +0000
Message-ID: <68f8b8b1ca1bf58b059f52afbd1c9c51108a074a.camel@suse.com>
Subject: SRSO mitigation in microcode not passed through to VMs
From: Dario Faggioli <dfaggioli@suse.com>
To: qemu-devel@nongnu.org
Cc: jpoimboe@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Fabian Vogt
 <fvogt@suse.de>, Nikolay Borisov <nik.borisov@suse.com>,
 fabiano.rosas@suse.com
Date: Fri, 26 Jul 2024 16:21:49 +0200
Autocrypt: addr=dfaggioli@suse.com; prefer-encrypt=mutual;
 keydata=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
 fkAJ0OEQQ==
Organization: SUSE Software Solutions Italy S.r.l.
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-lTo5ODzHdegmxhSD5PF+"
User-Agent: Evolution 3.52.3 (by Flathub.org) 
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.20 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SIGNED_PGP(-2.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.20)[multipart/signed,text/plain];
 HAS_ORG_HEADER(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+,1:+,2:~]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.com:s=susede1]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=dfaggioli@suse.com;
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


--=-lTo5ODzHdegmxhSD5PF+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

So, even if SRSO is fully mitigated on the host, we still see as not
completely patched inside of the VMs running on Zen 3 and 4 hosts
(e.g., AMD EPYC 7713)

We can see an example of that here:
https://bugzilla.suse.com/show_bug.cgi?id=3D1228079

This specific bug is about SLE15SP5, where we have old versions of QEMU
and kernel (and the kernel was missing a backport), but we see it also
on openSUSE Tumbleweed, where we have kernel 6.9.9 and QEMU 9.0.2, e.g:


  ### Host
  virt136:~ # uname -a
  Linux virt136 6.9.9-1-default #1 SMP PREEMPT_DYNAMIC Thu Jul 11 11:31:54 =
UTC 2024 (8c0f797) x86_64 x86_64 x86_64 GNU/Linux

  virt136:~ # qemu-system-x86_64 --version
  QEMU emulator version 9.0.2 (openSUSE Tumbleweed)

  virt136:~ # cat /proc/cpuinfo | grep -e "vendor\|family\|model\|stepping\=
|microcode" | tail -5
  cpu family	: 25
  model		: 1
  model name	: AMD EPYC 7713 64-Core Processor
  stepping	: 1
  microcode	: 0xa0011d5

  virt136:~ # lscpu | grep rstack
  Vulnerability Spec rstack overflow:   Mitigation; Safe RET

  ### Guest
  virt136:~ # virsh console opensusetumbleweed
  Connected to domain 'opensusetumbleweed'
  Escape character is ^] (Ctrl + ])

  localhost:~ # uname -a
  Linux localhost.localdomain 6.9.9-1-default #1 SMP PREEMPT_DYNAMIC Thu Ju=
l 11 11:31:54 UTC 2024 (8c0f797) x86_64 x86_64 x86_64 GNU/Linux

  localhost:~ # lscpu | grep rstack
  Vulnerability Spec rstack overflow:   Vulnerable: Safe RET, no microcode


Fabian and Nikolay (Cc-ed) can provide more details, if necessary.
AFAIUI this is due to how/when the proper bit in CPUID is set, on this
specific CPU model.

In fact (and I'm quoting Nikolay): "the problem with the IBPB_BRTYPE
flag is that on CPUs which require the microcode fix, the flag is not
shown by CPUID despite it actually being available. Ini this case the
kernel checks whether the feature is valid by doing a specific wrmsr
and, if it is, it sets the flag internally in the kernel and in KVM's
cpuid representation".

Yet, we don't see this in the VM, because QEMU seems to be masking it
(as visible, e.g., here:
https://bugzilla.suse.com/show_bug.cgi?id=3D1228079#c2)

In one of the thread on LKML where this mitigation was discussed, we
found mentions (from Josh, Cc-ed) to a QEMU patch being necessary, and
also being ready and about to be submitted, e.g.:

https://lore.kernel.org/lkml/20230821170520.dcovzudamnoqp7jc@treble/

But I'm not able to find such patch, neither in the mailing list not as
a commit... Is it just me not seeing it? In case it's really missing,
what's the best course of action? Do we need that patch? Is it (in the
form in which it appears in that email) still correct?

Thanks and Regards,
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)

--=-lTo5ODzHdegmxhSD5PF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAmajsP4ACgkQFkJ4iaW4
c+6hgBAAwKFWIB0360joqfldNy7wQFMoPPP0yKgzoLc2TWDJTNiU7aaCev3nhAqm
6YG6ivhbmwkAMhxzPQimqeoVN86BFUmcksR5RTDL10jxysvelxZhGvnrYXC2AHTa
NVWI4auq36liarUKnCI4nACMLfc1pA8YO0ByYKMvpy3ODPdY6SO6VIonIEQ19HGJ
cTSwVIo6SHMTjFDsXDpmdXSw5TPp2bBkAMnymx5aZzX8ShBcmg695CJUvxxx7cuM
fHTTesUYkhtKD5k8qGfUEtYNfDDCV3T4aoRwahUai3OOAw2tQ6ohy2reF8tLnuGx
IysymksL53NzTnKFEoZjNRwydRJOeJNVh4ghDeMVeM0RijupTdqyYfH1fCNkqhJ1
ab/1KFBmpKemhJIAdpV4It0jgtW31NtwXL5uOfmU/RXcrklqr7dHfIqYlugQF9HL
kDagHTZNMXYViA97UkUBnxxD6RS9gucQdFSb5Cqor3D0Q/+WErc4qvZiaRoLCLQb
w4XzvDdYG3HZKQm642eYJt/Y/9tHXNuzvAdCLr5YBdH2+hn3vgjyq/3q2vwTcsCk
o+Z4QRrmMrR7Xms7AeoyYzIG1ZWfgmLULv7L8jts4m9KURNCqwuNTpaR9cmg+UWs
PAbeoOeijKlpiWZ1pZPKORUJAyhnDoVo0WvdqqY5ehnufo/std0=
=7V05
-----END PGP SIGNATURE-----

--=-lTo5ODzHdegmxhSD5PF+--

