Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D135C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 12:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU2re-0005Be-Qz; Tue, 24 Jun 2025 08:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uU2rZ-0005AH-Tv
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:34:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uU2rS-0003WG-IB
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:34:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2334B1F461;
 Tue, 24 Jun 2025 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750768486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvaNRYybsVmwTuOe3MXf8d4p/JLoTkpN47V1Nypr098=;
 b=PCnq6gnQuQfB3roKqTHOUab7M8QnvwjVyamLoK67QJYQkBPptBetprd8PXk0P6Qlz6KCuH
 6nXxB3FHSne+Pn6OQImZfL0EBGH0q6fzaklxtZFKZfFS63S0XssEyOmq/ijytnNkEZhEPD
 FiLDZ4E/yOeYT7gxA8FOU9FW53WDmME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750768486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvaNRYybsVmwTuOe3MXf8d4p/JLoTkpN47V1Nypr098=;
 b=DIga+BREqBkrfFqnbaJo9fOi947UC9nUGoMQmBASt5w3+0HbMOipI1VBiwiMNj6bnnyZ1O
 eAvjeQTmfYKMtxCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750768486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvaNRYybsVmwTuOe3MXf8d4p/JLoTkpN47V1Nypr098=;
 b=PCnq6gnQuQfB3roKqTHOUab7M8QnvwjVyamLoK67QJYQkBPptBetprd8PXk0P6Qlz6KCuH
 6nXxB3FHSne+Pn6OQImZfL0EBGH0q6fzaklxtZFKZfFS63S0XssEyOmq/ijytnNkEZhEPD
 FiLDZ4E/yOeYT7gxA8FOU9FW53WDmME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750768486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvaNRYybsVmwTuOe3MXf8d4p/JLoTkpN47V1Nypr098=;
 b=DIga+BREqBkrfFqnbaJo9fOi947UC9nUGoMQmBASt5w3+0HbMOipI1VBiwiMNj6bnnyZ1O
 eAvjeQTmfYKMtxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9463813A24;
 Tue, 24 Jun 2025 12:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cIk0FGWbWmipWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 24 Jun 2025 12:34:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Richard
 Henderson <richard.henderson@linaro.org>, David Hildenbrand
 <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH] s390x: Fix leak in machine_set_loadparm
In-Reply-To: <e4e7a238-6438-481d-ae6c-8263730bc239@redhat.com>
References: <20250509174938.25935-1-farosas@suse.de>
 <7a850346-8ae5-4dd2-b4ce-7ffb1cfeabd1@linaro.org>
 <1cd816d0-5808-4caf-b38b-9e4ba10680b6@linaro.org> <87sel9et69.fsf@suse.de>
 <e4e7a238-6438-481d-ae6c-8263730bc239@redhat.com>
Date: Tue, 24 Jun 2025 09:34:42 -0300
Message-ID: <87ikklqpwd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 linaro.org:email]
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

Thomas Huth <thuth@redhat.com> writes:

> On 12/05/2025 17.37, Fabiano Rosas wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> On 12/5/25 16:07, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 9/5/25 19:49, Fabiano Rosas wrote:
>>>>> ASAN spotted a leaking string in machine_set_loadparm():
>>>
>>> What about ccw_device_set_loadparm() in hw/s390x/ccw-device.c?
>>>
>>=20
>> Yep, that one as well. I'll send a patch. Thanks
>
> Did you ever send it?
>

Sorry, no. Got sidetracked as usual. I'll mark this email so I don't forget.

>   Thomas

