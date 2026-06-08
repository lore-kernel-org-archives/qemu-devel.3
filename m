Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F26CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfns-0007U5-21; Mon, 08 Jun 2026 15:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wWfnk-0007Ti-L4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:38:25 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wWfng-0005PR-M5
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780947496; x=1781552296; i=deller@gmx.de;
 bh=DpB2Eb7tCpT7Ui+M6of6GyKm3J8UPwPWrejd1R9B6Y0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rKf7o3VBRiynzuUWY978oMqemsL7Fr9XfQ+Kq5lpnAAbyiM8qLZ4yKgVWS9ijAGN
 s5rmjH8JGC6h5gwi0Amq0qZwYQtzsECiJXdvx97THo9THhSZaAbqHLKBDBh1pLBqJ
 mgyx4R9oY1FHAjvo8sJqN/ljodRWyh5N+iaP87LLV3Z2oVn7FjAKiowPqdrnIHZMK
 Plrs+df9iU/HKQeVeDLEktzniAEdMiParjLzcLhxCD8ws4dUKbfUFkfxzswtSl0un
 AKu/5L9vKWSp5WfsXD5wQKATIEeg1xMCjAKABtwFwX9nmTRqQVkABz3GVYNVbu8wk
 gPObtPn4qIUb/rZ1Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1x45Tb03Ql-00nZf4; Mon, 08
 Jun 2026 21:38:16 +0200
Message-ID: <1db334a7-b50a-4de0-b87c-67b4eb34bc8a@gmx.de>
Date: Mon, 8 Jun 2026 21:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] linux-user/xtensa: restore FP rounding mode on
 sigreturn
To: Max Filippov <jcmvbkbc@gmail.com>, Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20260607140356.10702-1-deller@kernel.org>
 <20260607140356.10702-10-deller@kernel.org>
 <CAMo8BfKSegeBHdKaxiXp3RQ+XX-BO9sztt-MucX_cWR=frnxfA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAMo8BfKSegeBHdKaxiXp3RQ+XX-BO9sztt-MucX_cWR=frnxfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nI23zCHKgI4yE8Y7N74/sdfqZKm2IWWWeeCSUQsIIg+XC3KVdtF
 5wUU0O479wSpHvc8sSXJH34NLKi4+D4uvllOssS3kB8GGFCUvTUxXqKjQ0qaVvXiTTv6q+U
 uXb+QDhXjgwZTcfRZVBbi1w7VvbvD03MzqvjJ5XIoZXgtDMz/TFXto6WC2J4mlizAzQvqvs
 Ku9UMeliotz5QL4ej4fzw==
UI-OutboundReport: notjunk:1;M01:P0:xXG+u673xBE=;6g9Jkp+qOdXBOeLWAKbeKNQQhqX
 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
 plSCcA==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/7/26 22:06, Max Filippov wrote:
> On Sun, Jun 7, 2026 at 7:04=E2=80=AFAM Helge Deller <deller@kernel.org> =
wrote:
>>
>> From: Matt Turner <mattst88@gmail.com>
>>
>> The Xtensa FCR rounding-mode (RM) bits are not held only in
>> env->uregs[FCR]: they are also reflected into env->fp_status via
>> set_float_rounding_mode().  Similarly, FSR exception flags are mirrored
>> into env->fp_status.  Every write to FCR/FSR goes through
>> helper_wur_fpu{2k,}_fcr / helper_wur_fpu_fsr which keep the two in sync=
.
>>
>> restore_sigcontext() previously wrote nothing back for xtregs, leaving
>> env->fp_status with whatever rounding mode and exception flags the
>> signal handler last installed.  Any FP instruction in the interrupted
>> code could then operate with the wrong mode.
>>
>> Add a minimal target_xtensa_xtregs sub-frame carrying FCR and FSR.
>=20
> The structure of the xtregs area is defined by the target xtensa core an=
d
> this definition doesn't match what a typical core with FPU would produce=
.
>=20
> Also this area saves not only FCR and FSR, but all of the FPU registers,
> which are caller-saved. Not saving them means that any operation
> that touches FPU registers in the signal handler context will clobber
> them for the code that was interrupted by the signal.

I see this patch and the next one ("target/xtensa: add cpu_set_fcr/fsr
helpers to sync fp_status") need some more cleanups.
I'll drop them for now from this series.
They can go in later after fixing by another pull series or through a xten=
sa tree...

Helge

