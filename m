Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B81E77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 15:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTjB0-0004W1-3O; Fri, 03 Jan 2025 10:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tTjAj-0004U6-3n; Fri, 03 Jan 2025 10:01:09 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tTjAd-00024J-Tw; Fri, 03 Jan 2025 10:01:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 469DC21119;
 Fri,  3 Jan 2025 15:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735916461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLlZhWeS7KDhoYjnDMbRZ+Mf3l5cR/S5+Yv/CL+wim8=;
 b=kyX4khkSAEUDv+MhcNO3o3hZicUcdf4F4TS/XH+TW6SVZHQQOj7AbdO1cIa8aYGRaLR6kN
 bfh/rPMwvNEaLxE6ZNdeMvLIl5reDyxwadeBsGllqoXpYgRQ9Hkf9V2jxhAHdgkGyKOv4Y
 3ji5kv0rmYpmvUUzyPADgZwIq2fTUis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735916461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLlZhWeS7KDhoYjnDMbRZ+Mf3l5cR/S5+Yv/CL+wim8=;
 b=hEtpSnbWa7SgKPXJvhI3syEXXgpDfuvthoNW/0H/e4grTrYbaRWkVZM82MOTM6EB/P3qTL
 eXCFm0sXFUFLipBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kyX4khkS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hEtpSnbW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735916461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLlZhWeS7KDhoYjnDMbRZ+Mf3l5cR/S5+Yv/CL+wim8=;
 b=kyX4khkSAEUDv+MhcNO3o3hZicUcdf4F4TS/XH+TW6SVZHQQOj7AbdO1cIa8aYGRaLR6kN
 bfh/rPMwvNEaLxE6ZNdeMvLIl5reDyxwadeBsGllqoXpYgRQ9Hkf9V2jxhAHdgkGyKOv4Y
 3ji5kv0rmYpmvUUzyPADgZwIq2fTUis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735916461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLlZhWeS7KDhoYjnDMbRZ+Mf3l5cR/S5+Yv/CL+wim8=;
 b=hEtpSnbWa7SgKPXJvhI3syEXXgpDfuvthoNW/0H/e4grTrYbaRWkVZM82MOTM6EB/P3qTL
 eXCFm0sXFUFLipBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B788513418;
 Fri,  3 Jan 2025 15:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ok/SHqz7d2fGZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 Jan 2025 15:01:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 4/4] tests/qtest/boot-serial-test: Initialize PL011
 Control register
In-Reply-To: <20250102105822.43532-5-philmd@linaro.org>
References: <20250102105822.43532-1-philmd@linaro.org>
 <20250102105822.43532-5-philmd@linaro.org>
Date: Fri, 03 Jan 2025 12:00:57 -0300
Message-ID: <878qrs7xhy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 469DC21119
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, linaro.org:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> The tests using the PL011 UART of the virt and raspi machines
> weren't properly enabling the UART and its transmitter previous
> to sending characters. Follow the PL011 manual initialization
> recommendation by setting the proper bits of the control register.
>
> Update the ASM code prefixing:
>
>   *UART_CTRL =3D UART_ENABLE | TX_ENABLE;
>
> to:
>
>   while (true) {
>       *UART_DATA =3D 'T';
>   }
>
> Note, since commit 51b61dd4d56 ("hw/char/pl011: Warn when using
> disabled transmitter") incomplete PL011 initialization can be
> logged using the '-d guest_errors' command line option.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/qtest/boot-serial-test.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-tes=
t.c
> index bcfa504826c..6ea7e62e076 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -70,15 +70,20 @@ static const uint8_t kernel_plml605[] =3D {
>  };
>=20=20
>  static const uint8_t bios_raspi2[] =3D {
> -    0x08, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #=
8]   Get &UART0 */
> +    0x10, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #=
8]   Get &UART0 */

The comment needs updating, no?

> +    0x10, 0x20, 0x9f, 0xe5,                 /*        ldr     r2, [pc, #=
8]   Get &CR */
> +    0xb0, 0x23, 0xc3, 0xe1,                 /*        strh    r2, [r3, #=
48]  Set CR */
>      0x54, 0x20, 0xa0, 0xe3,                 /*        mov     r2, #'T' */
>      0x00, 0x20, 0xc3, 0xe5,                 /* loop:  strb    r2, [r3]  =
     *TXDAT =3D 'T' */
>      0xff, 0xff, 0xff, 0xea,                 /*        b       -4        =
     (loop) */
>      0x00, 0x10, 0x20, 0x3f,                 /* UART0: 0x3f201000 */
> +    0x01, 0x01, 0x00, 0x00,                 /* CR:    0x101 =3D UARTEN|T=
XE */
>  };
>=20=20
>  static const uint8_t kernel_aarch64[] =3D {
>      0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000=
000  Load UART0 */
> +    0x21, 0x20, 0x80, 0x52,                 /*        mov    w1, 0x101  =
     CR =3D UARTEN|TXE */
> +    0x41, 0x60, 0x00, 0x79,                 /*        strh   w1, [x2, #4=
8]   Set CR */
>      0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
>      0x41, 0x00, 0x00, 0x39,                 /* loop:  strb   w1, [x2]   =
     *TXDAT =3D 'T' */
>      0xff, 0xff, 0xff, 0x17,                 /*        b      -4         =
     (loop) */

