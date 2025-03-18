Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF371C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuW9y-0000Ou-9o; Tue, 18 Mar 2025 08:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tuW9v-0000Mc-L3
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:35:03 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tuW9s-0005z0-Qx
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:35:02 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out1.suse.de (Postfix) with ESMTP id EDE3F21C6B;
 Tue, 18 Mar 2025 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742301298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gX5tV2h9AeeYUMvUvHUuJnAAol65fuiWYm/RGUYWE8=;
 b=vAPrZDdc1HkbCyYcJh4WYXoiNUUpavkfFl5cRh5yejiHMIGvFClWimhzgGm9UO8Hc8sUzo
 lNls6gCeXEpShSDW14ehOyu4InjQDHps58G7ZLIXjuFy/A/r/KbtyqoqQncoq8BfW5DvuA
 cgvhm9qdMgFZfs8kmJHJ5AR0GjBIF8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742301298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gX5tV2h9AeeYUMvUvHUuJnAAol65fuiWYm/RGUYWE8=;
 b=xmpD9D7sM8hFPuWQ+j2e82oRvVsD+DIcofMXTnYrHgxa3BuI/GBW4kMBysTY3kmKfqYbtY
 tV0xvhB5MLEF9EDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SzQejDmO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=egLyXCCi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742301297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gX5tV2h9AeeYUMvUvHUuJnAAol65fuiWYm/RGUYWE8=;
 b=SzQejDmOMj3lET8X5RY+W+YkU0OD+t1ZzcdDWR/h9pV6Yi41SkfJj1xGK8Fo6GO6OUv7tX
 a0/ro9moWJ3PibXn9CpVzMSkDjHp80kROCV2WaZ2f4QfVNvVxMJJu6b5yJcBvH5VnjcruM
 twK6zw38uSm3xkgPiML3Nf4AuHdrNes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742301297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gX5tV2h9AeeYUMvUvHUuJnAAol65fuiWYm/RGUYWE8=;
 b=egLyXCCiMiwjT8z6InQATTpaDlFSy/SBoTuLnVMa9XtCJDbK0ocimGHBIm7GRyMhMHGBJu
 K0I24yXdj0dOvABQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id CDE104A0561; Tue, 18 Mar 2025 13:34:57 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
In-Reply-To: <Z9lf7lniMWzoy6uS@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 18 Mar 2025 11:58:38 +0000")
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com>
Date: Tue, 18 Mar 2025 13:34:57 +0100
Message-ID: <mvmmsdih5zi.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.60 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.988]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmx.de];
 FREEMAIL_CC(0.00)[linaro.org,gmx.de,nongnu.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_ONE(0.00)[1]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: EDE3F21C6B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=schwab@suse.de;
 helo=smtp-out1.suse.de
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

On Mär 18 2025, Daniel P. Berrangé wrote:

> Whereever practical, it is preferrable to check a discrete feature
> or behaviour in a functional way, rather than matching on "is it QEMU"

Do you know a way to detect support for CLONE_VFORK that isn't too
expensive?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

